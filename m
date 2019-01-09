Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0492C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D31520883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH5GHziz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfAIK5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:57:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39008 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfAIK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:57:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so6108166ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rp9agg0ydtjPWCMbWupsCarMyhx8m4ESfxME2ZSk+DA=;
        b=EH5GHziz3rk+pFTEtsg3oXegyBPWDM52F5GBfkRPztlq+Na8k7XQbEsxJJgbGbx/UH
         bFNwb3kvzeBMM7+WPcEXXkCrpx1InabW3WufWAFBTx1KeG/SvCl3yn/88ZF84tTh6dQ+
         96ebs8FZGJvW/vHD5ZRLsA0/o+k5DRX5d/kCweQKbGpIq9AnxnWPxCpno9SV7UthBSns
         dKLIea0xQH7B5FREngum/Tl5q1dQrVn3/QMki1upWD2yUETrdB8O2zZBdYqCu1SoxVgC
         EibB3VyvZrvlasNQI5YLTD0UgDEMPoFxnxlTJkE5R0z90QQq/CSSRbAAnf+1+uGJ3rYQ
         gXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rp9agg0ydtjPWCMbWupsCarMyhx8m4ESfxME2ZSk+DA=;
        b=Wfop9oWTV4YsVJuavaTJFnjwMVnrmCMRr31bLPhoU5KIpWegH4k1iMa1V3lYFpRX0y
         6RQ3J0wPOn1oCEMXxl0qbuanP6Dt1Oo4v5Ttbp4GKLir+Zk7xJIIDQczVZ2zkMIfkYW/
         nmBcpKXYk4ArkDgXz5zjgOMF73qbpDTxqulJSWCEhws5i+GTMW5WBXYC83XUimGqHE4k
         Mg9xpeAuLVc8qlr6Vlsd11xFuA+m7WiJa6ntYfM2nNbm2y1kjbMnwIhXbUgMMGLn0ZZp
         T9CWvjb3+6ou/OHjkX1FKt9XvZTG0VnRo6d5maAVpFHqHlmry2VIzf6ftIXwH/GSvCv9
         qjEA==
X-Gm-Message-State: AJcUukdRkMdk0E2twP1uKV35leYGr/xC8BEM8KBxHfpwk7SgPHOQ6hlL
        zPfr5+xt/ejSV1cFR3mia6aleGdYwXaeAEUw2yU=
X-Google-Smtp-Source: ALg8bN7H/Kkl4M9K40LCmH2lNQOAZ0A8ES4R7dCFTm5CRvAMF1270VEsTfh07va/D9EOoPREigJ2on2Z4lDb0NvYDMA=
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr3139695ljd.45.1547031456970;
 Wed, 09 Jan 2019 02:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk> <20181026232409.16100-2-linux@rasmusvillemoes.dk>
 <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com>
 <CANiq72=-2mrvBWHUcFCNsoQ_EbXQm4RmtOp061ngnGJx_Fyp0g@mail.gmail.com> <72ac8661-312c-8df9-358a-22ddb0a81f54@rasmusvillemoes.dk>
In-Reply-To: <72ac8661-312c-8df9-358a-22ddb0a81f54@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Jan 2019 11:57:26 +0100
Message-ID: <CANiq72=Z7ax5tLVsHmo+FjjEScoxcMMipq+QieFy0yy=HLzepg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] compiler_attributes.h: add __attribute__((format_arg))
 shorthand
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Fri, Nov 2, 2018 at 11:43 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 2018-11-02 11:36, Miguel Ojeda wrote:
> > Hi Rasmus,
> >
> > On Sat, Oct 27, 2018 at 2:06 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >>
> >> I did quick check and gcc >= 4.1, clang >= 3.0, icc >= 13 compilers
> >> seem to support it (or at least recognize it, even if they just ignore
> >> it), so we do not need to make it optional, no? Did I miss some case?
> >
> > compiler-attributes landed -- do you want to do the v2 of this (i.e.
> > #defining it unconditionally) or you prefer I simply fix up the patch?
>
> I'll wait a few more days for comments on fmtcheck(), and allow you to
> do the 'optional'/'required' clarification in the meantime. I hope to
> get fmtcheck() picked up for -next around -rc3 or so.

Any news about fmtcheck()? The "Optional" clarification landed a few
weeks ago, in case you wanted to know. Hopefully it is more clear now.

Cheers,
Miguel
