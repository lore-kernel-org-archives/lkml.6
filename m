Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35572C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C3B2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUpVdt6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfB0OPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:15:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38463 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfB0OPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:15:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id g37so5281710plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2najj2oqtyzPXUw6QzCb/Dfnly0L/pDDQ4ohEoh6l88=;
        b=TUpVdt6DGbr7ClZ2xUJrvMJw1SuWLy0+HQelkRuv6WnCpTZ1y8XqOI98TuBgWBZvK6
         pol5Hx8NtHqfKhT56ibwc1wy7Foh2T67gkFP4nV61ocwm+MNy2BPSeRorDPva1WpBXGR
         IykCDw3isYxBEsX2q0Ts3oSDSjWxShXhKJUKXdCgraM/0clet8w6WDnj9eWUbC0tRuFA
         X0l7QslaJSOZ6DiJG1LFBIj2RjiwkLNHgUoD4bv6XWRDES7ZMTTcCvML8HckODFVZNsQ
         GbmQ03k2ALmLZpWg3i8+HUb76U8hF/myrIGoINvpsDu7LCstceCliIA8KHmIVRAxaLwG
         P7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2najj2oqtyzPXUw6QzCb/Dfnly0L/pDDQ4ohEoh6l88=;
        b=cpKTDjfTN9EDtHATJxvQc5Swb2xecYwxpQSTf+vDbMBsOTwxEvVv/HanM06jGUgtHv
         alX4vbwwjo81xCqI1GkW924crgQJdD8vP00qZMUYkXB6hlUTjmNviGidNwTV1gdoq95V
         aFPR2ILOdV5BEyEHMWERUImAM0bCUF5ddGU+J8vcKl+OPI9UquJfQXb01a6wd6Xlq/Wj
         exqJBq+LMt5u1OSPeEVt+iR8wgB41v5hm7iWNAswpBDUlc9qCLhRdgdl3Qlit8JJATE1
         wECMKbRubAD2pTOzW6PFzxkAA0+UZEfZSdSxCEICP6Kp7+KY/kGfTmagdiuQDkitua9q
         k2SA==
X-Gm-Message-State: AHQUAubYJG0fwJgEydbRo8UKhyRTmX3M7OGpLR1cSt2Uk7U1BBSHduil
        uNhbFb3otJIAYqChjIGt6K18Nayg26QbYLZ3EY0=
X-Google-Smtp-Source: AHgI3IYaVk2QnojMuRQFwV5wwFJXEa/szRGmpZk4mxeouoGoR72uR2KrJq2u/7XJIVTwxCCk00ZYcA9h/bnYpOFyKnU=
X-Received: by 2002:a17:902:48c8:: with SMTP id u8mr2410148plh.87.1551276949265;
 Wed, 27 Feb 2019 06:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20190227085050.30000-1-alexandru.ardelean@analog.com>
 <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
 <CAHp75VdgwM_ybfymh28iqxu2qOfzZo79VOF+XE+brj70Aji6YQ@mail.gmail.com> <26f1c0d1a7d98a6a41301d58e53bd9abc1d2f5c9.camel@analog.com>
In-Reply-To: <26f1c0d1a7d98a6a41301d58e53bd9abc1d2f5c9.camel@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Feb 2019 16:15:37 +0200
Message-ID: <CAHp75Vcup+UUYmqo7stwC4FOmG3GWqOOuewmmG_dSiDoeBms7w@mail.gmail.com>
Subject: Re: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "bhole_prashant_q7@lab.ntt.co.jp" <bhole_prashant_q7@lab.ntt.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 2:26 PM Ardelean, Alexandru
<Alex.Ardelean@analog.com> wrote:
>
> On Wed, 2019-02-27 at 11:46 +0200, Andy Shevchenko wrote:
> > [External]
> >
> >
> > +Cc Vinod
> >
> > On Wed, Feb 27, 2019 at 11:45 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, Feb 27, 2019 at 10:51 AM Alexandru Ardelean
> > > <alexandru.ardelean@analog.com> wrote:
> > > >
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > >
> > > > Sometimes the user needs to split each entry on the mapped scatter
> > > > list
> > > > due to DMA length constrains. This helper returns a number of
> > > > entities
> > > > assuming that each of them is not bigger than supplied maximum
> > > > length.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > >
> > > Hmm... Usually we don't accept generic API without users.
> > > Do you have any use case in mind?
>
> Yep: this one:
> https://patchwork.kernel.org/patch/10814527/
>
> But, I can rework this patch to work without the helper.

Ah, okay, worth to mention this in comments (in addition to what you
put about the patch below).

> > > > Patch was sent in 2016 initially to the DMA engine sub-system.
> > > > Link:
> > > >   https://patchwork.kernel.org/patch/9389821/
> > > > This was part of a larger series:
> > > >
> > > > https://patchwork.kernel.org/project/linux-dmaengine/list/?q=sg_nents_for_dma&archive=both&series=&submitter=&delegate=&state=*
> > > >
> > > > I'm not sure if this is supposed to go into DMAEngine or
> > > > lib/scatterlist.
> > > > It doesn't look like lib/scatterlist is managed by DMAEngine, so (by
> > > > using
> > > > the `get_maintainers.pl` script) I'm sending this patch to this group
> > > > of
> > > > parties.
> > >
> > > The problem the patch tried to solve is much deeper and correct
> > > solution should be more generic, i.e.
> > > each channel should provide a set of parameters, such as DMA segment
> > > size, to the users (via DMA engine API) and users should prepare the
> > > SG list according to the limits of the channel.
> > > In that case we don't need to re-split/re-allocate given SG list at
> > > all, which would simplify DMA slave drivers and their users.
> > >
>
> I don't think I managed to follow [or find] the full length of that
> discussion. Or, the conclusion wasn't that obvious to me, from what I
> found.
> I assumed this may have been dropped/forgotten.
>
> In any case, I am fine with just reworking.

It's fine to apply it, my point that it help to solve a symptom in a
short-term (however this short-term can be easily a long one due to no
guarantee that all drivers using SG for DMA will be converted).
So, please, update the comments and resubmit as a new version.

-- 
With Best Regards,
Andy Shevchenko
