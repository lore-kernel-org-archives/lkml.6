Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAEFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C020874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfDvSkd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbeL1SEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:04:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39696 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeL1SEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:04:36 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so27848056itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO6btzCMrspbbGuA4t1Dn1GB/cNGFTn7DeTiFHCdvBU=;
        b=dfDvSkd5V25EW3j/plGIf7nrV7UTYCBPpnkRpYNlaTUojd3kgEeaF17N5COXvb6tUs
         1rvtoomCjVSECjICQa1cs4/bUBCXrKqYVR2EP2GkmQ16USswGLfAYu3AW/ScjZY6F6o/
         ZTs4IeHx1ENzoqIEK96Jn6rRB/hBi4zXfMN8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO6btzCMrspbbGuA4t1Dn1GB/cNGFTn7DeTiFHCdvBU=;
        b=pdxWz07xXXAhL3+IrGVaVgSrvyV3gKY/h70Vm1q1KWorLHEBKPcfjFPRjE2j8fWJqu
         PxcJzuTUKtDjB5HvhLW7pyTXQjvsgdLf2RCJKj1p2OmjxGWBbrXQ/En67Nki8JN4iPDt
         TCH4CSw2Je1zvFGLAr94UbS2cHESdffvk8+BxMkLQNRifst9kmiJcvOoQIvk0r8OWD+5
         +gQ+uHDjMMeJWdvqGIT31FFb3pvhi0SbR/9/6mDVx0MRufqzyc3mRLMlHhbNftAlMJlO
         5VOIDpYgJAkj0ASL50Ln6mzDvi1hqfXoemueWY60755mqTI1UiEcS03/IppGNbk1Ry5k
         ytDw==
X-Gm-Message-State: AJcUukcDnvmRLf9YFfyuhZ5Lg2QHOS9skSvswL3OzprI2ZacnWqkzmrQ
        hRVfXCahJMD4FRl+1flNG11RlDFUk0LmYrF9N21dzQ==
X-Google-Smtp-Source: ALg8bN4nmFD3yOWX2Gx6+0H2pOA1stiOCAKUoO8Sar7bL5Z2H3knmJiF2jUbXZWqat3MB/xIKPQIPB8/EF+PkDr3cy8=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr18878734itf.14.1546020274084;
 Fri, 28 Dec 2018 10:04:34 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com> <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com> <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
 <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
 <20181228165451.GJ2509588@devbig004.ftw2.facebook.com> <CAKfTPtAMjfnNHu_JdDSi1BSMoXKgGkm2+G_QLsUBDAhq1wFvZQ@mail.gmail.com>
 <20181228174600.GK2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181228174600.GK2509588@devbig004.ftw2.facebook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Dec 2018 19:04:23 +0100
Message-ID: <CAKfTPtBV6tkf237ZAtWrHAYAiK+o3m_cd7ctX3EeLzt+onzUZQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 18:46, Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Dec 28, 2018 at 06:25:37PM +0100, Vincent Guittot wrote:
> > > done without extra space as long as each node has the parent pointer,
> > > which they do.  Is the dedicated list an optimization?
> >
> > It prevents to parse and walk all task group struct every time.
> > Instead, you just have to follow a linked list
>
> Hmmm... I'm having a bit of a hard time imagining doing an actual
> traversal being a meaningful optimization.  It may require more
> branches but that shouldn't be expensive at all, especially compared
> to walking all idle groups in the system each time which the code used
> to do. Anyways, this is tangential.
>
> Thanks for the explanation and happy new year!

Happy new year for you too

Thanks
Vincent

>
> --
> tejun
