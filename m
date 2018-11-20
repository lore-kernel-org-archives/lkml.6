Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B464CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D03120671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D03120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeKTVXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:23:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38677 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeKTVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:23:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so2078452qkg.5;
        Tue, 20 Nov 2018 02:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ytHfs+LGC7Kt7FaIlYKMVZnBQtU1xZYDUo378mjB9o=;
        b=JiE1xIwv7PaaudY7bDWzE2e4eGfeIUe9acw5UibAM1rMztm8bmmiHGycn023T2V1XJ
         xempRkDthD/h9KjJP5QX0RhqXStask4UOLMfHMKRk9NseHQUKZY+YuUTdaGx6Gebbini
         cLG2f6Rf9oqA2EZftAb4WI8p622ITTNub8MEM3TwDoB3TnD0FpCb0x1fJ+wWP8IMkLbq
         YXTQ5syon8j+EuLOUDDbgkxo004J6rwxSgVHiAG3B104ObPZWoDeC/K0TIBylCKmHbYt
         4wuaGZgaL0leVaV+ZQ4ePbl+fmvScSbw9rkOhLp8pdWYKS2BCYU2cMh1L4f/7ltSxDib
         iOsA==
X-Gm-Message-State: AGRZ1gLhl8MJm/TBYCV705oxjzx7Gx5PV2LRlf8t32Dtf2ivKXZOLAoz
        +A+bWksw7J7cu6qWHu+4yBW0HwreLeoSRzmbfUg=
X-Google-Smtp-Source: AFSGD/VizlVYkgxMIG1ZsBTMuRYvngW0qZnrMXdfe/kM5yV6rlc7zlymK9L6gA5VjGA35dK2yarO7eZvMqm8e3WfwUI=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr1320428qtl.343.1542711271032;
 Tue, 20 Nov 2018 02:54:31 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-4-git-send-email-firoz.khan@linaro.org> <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
In-Reply-To: <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 20 Nov 2018 11:54:07 +0100
Message-ID: <CAK8P3a2o+jKd0EF81TezmJbTLBPRN9frCBf3wvxySa0sEbC+-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mips: remove syscall table entries
To:     Paul Burton <paul.burton@mips.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:29 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Nov 15, 2018 at 11:44:19AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> > index a9b895f..4eee437 100644
> > --- a/arch/mips/kernel/scall32-o32.S
> > +++ b/arch/mips/kernel/scall32-o32.S
> > @@ -208,6 +208,18 @@ einval: li       v0, -ENOSYS
> >       jr      ra
> >       END(sys_syscall)
> >
> > +#ifdef CONFIG_MIPS_MT_FPAFF
> > +     /*
> > +      * For FPU affinity scheduling on MIPS MT processors, we need to
> > +      * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> > +      * in kernel/sched/core.c.  Considered only temporary we only support
> > +      * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> > +      * atm.
> > +      */
> > +#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
> > +#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity
>
> Is this backwards? ie. should it be:
>
>     #define sys_sched_setaffinity mipsmt_sys_sched_setaffinity
>     #define sys_sched_getaffinity mipsmt_sys_sched_getaffinity
>
> ?
>
> I don't see how the mipsmt_* functions will ever be used after this
> patch.

Good catch!

> > -      * atm.
> > -      */
> > -     PTR     mipsmt_sys_sched_setaffinity
> > -     PTR     mipsmt_sys_sched_getaffinity
> > -#else
> >       PTR     sys_sched_setaffinity
> >       PTR     sys_sched_getaffinity           /* 4240 */
> > -#endif /* CONFIG_MIPS_MT_FPAFF */
> >       PTR     sys_io_setup

My guess would be that he removed the wrong lines here instead,
and the first half was intentional.

       Arnd
