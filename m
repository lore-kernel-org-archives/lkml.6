Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE8C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9591D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLOofSpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeLQNM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:12:57 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:35524 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeLQNM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:12:57 -0500
Received: by mail-yb1-f173.google.com with SMTP id z2-v6so5043390ybj.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOfplFds6EIUWOBhy40nhRvyfIR9Xhr39hZz8BRtwOQ=;
        b=ZLOofSpHfhN/niqagytI+agUhxA3+kyXhVg2F6NjasXE92Q8FfZGNUR/iv1LmBeIxe
         6RVGkVCyh7Nv5Ate6LbMf/5gzQzld1WgIwUE3wM2WNBH5F8r9/xO72hcF+Sx2MH6F3SD
         RG9ocFMbDRlzeP1K/TIfVTNHr7FtHkGlyljAaW7kU3Zu9zdg8x4Q3Q9Ssnb44a2YPaNp
         Cl6moyxkNVp+kfyjcngL7OAUh5uDXrHmbBhuq60nA/8ZxkzW6rrDYGQce/hUEfnXh9ET
         CD93aPLQbeMQ6FKl16aAhKG7+Uyw2GZ+RsmjVVBpgHMASnktB1oLazI9CI893SN+FAAf
         KNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOfplFds6EIUWOBhy40nhRvyfIR9Xhr39hZz8BRtwOQ=;
        b=A24DRrGi8IPrnIFVNpjRIfGWFD2P96tyQOxeadi9igYSxHvlmHLV/1GGb3wuzlXhR2
         DIcAt+rRJQpdG4+EZP2yptokntXLhSE+bN3a49XG4lB+7CEe0epwwYNvjFHDw8tJAf4J
         CaaJZT0vqguTCfgM89izhnRpJrx7hO3m78pqLs7IM6fUJw7+WD4Dxa/D/dQ3cBgcY4yh
         Vqq9FZXBzHE9FRuhNVxS9AzWWUh3Vha9ryfECrZs3L56DaBl9du2Hp8Qo1cF4sdVza+M
         aWnzsX8EUxbz7MNKq/IxX4FoGGxlXCXclepa7jcbnmaEQH3Qn17/O9WnVCjxkSQP2Wm/
         YuUw==
X-Gm-Message-State: AA+aEWbhk8Azy7tlGZMLDe9DqlX6G4GMYtobCwf0zpYcrPfveEB0VEGd
        J4Ep5g8LcXLBkEGHSjVYZrTgNaQAqiNYH8FHvic=
X-Google-Smtp-Source: AFSGD/UO5fPzqbmHd6F4Zkz98nqtXP0UqIwV4m1jZI8qqdatzJiQwbDFvdQEaWQvl7EF3/J+D0reyi5mEUu3JlHkjYk=
X-Received: by 2002:a25:e404:: with SMTP id b4mr13021985ybh.517.1545052376013;
 Mon, 17 Dec 2018 05:12:56 -0800 (PST)
MIME-Version: 1.0
References: <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net> <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net> <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com> <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5> <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com> <20181217113718.GB4900@worktop.programming.kicks-ass.net>
In-Reply-To: <20181217113718.GB4900@worktop.programming.kicks-ass.net>
From:   Yongji Xie <elohimes@gmail.com>
Date:   Mon, 17 Dec 2018 21:12:44 +0800
Message-ID: <CAONzpcbvyvXdUEL6Mc8_kN_Z_=jYiRCzDScSWH07+MOtbgxdKQ@mail.gmail.com>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
To:     peterz@infradead.org
Cc:     dave@stgolabs.net, mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@baidu.com>,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 19:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 10, 2018 at 11:12:52PM +0800, Yongji Xie wrote:
> > Hi Peter,
> >
> > Please let me know If there is any progress on this issue. Thank you!
>
> Right, sorry, my brain was filled with snot and didn't want to make
> sense of things.
>
> I've put some patches here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
>
> Could you have a look?

That looks good to me. Thank you!

Thanks,
Yongji
