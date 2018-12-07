Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA1620882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ieOtFERH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA1620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLGCae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:30:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46994 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:30:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2324842wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 18:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyIUJyfH0fsnc29YOAnZAeFtg8S1AAXJx1uXbtvDs5Y=;
        b=ieOtFERHdhgYkSx5Jp3wMyQvcAPcDnsZ96zEVKrB5XGy1p6TvB8n4Uie+yBMz/oXlH
         6dyEpuVnKoaPXpdhSWxaX1zpMh5bqWUXU9gQjplVaidd/l129tV79y3D+NjA8HWvPktp
         WYbno9E8tN4J3P3ZNo4uZekQwp0WAyQhhLtZ0EOLzjlPb6Wm1L/ki1Zu/Fbn4Jri/4Fk
         mulZmRzC2DD7BoWGzMPaslLjawqkDPIsDVVGQek7+giPb+gddPTc1hvHhi1ol7wQ2z+n
         UVHv2SbQqqRE6ChjbWlh7A1ccurxqYOj57eTcRlyEtZHIjPmcSnADqVFcutk2fzqNjk2
         MJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyIUJyfH0fsnc29YOAnZAeFtg8S1AAXJx1uXbtvDs5Y=;
        b=pisnngaKT3auK8gymCjt/ewCi00JQPcUoE7Wg57sJDPL1sb93ybXoZ9ingYj9jUII3
         Vbrjh7AfQJemQvtFtkQ8ziVktTJ8+RNUnHit6/X0/AtTGKSqjpDOssoigNtyH81Gungo
         z+Y1W2xi/JwHgGEvBcmAA7XhCTcfywMTyiTQNwmQibqLA1ia36XOT/eI7bisNtBkw6g5
         QJIb5VuwUMoV47ieNThsxhHYu+fkedUZ1murkoiGDk5pEM32Q1/SI4i8WGnrZY8VBtNG
         OqkKDuYOJX+OAe3mdhyi3fJLXSg1rbm6Qjt2XFPBev+ZyH3r+m301JX+3jdEhFwG5HON
         Y3iQ==
X-Gm-Message-State: AA+aEWatsAkUYorDj6NQlMMbny//fyT7tHBk4j5WCgW6hRMxW7z3ciQV
        zQN/IFTJ6VcF40Kg1rP6ehu+ZoXehxEz7g66dLZT4g==
X-Google-Smtp-Source: AFSGD/Xb0M7R+/40hXSK8QKEnSPKnMLN6zKkeVw/GycWY33wzQMt6M4ekQZENq2KYsDN3o1iFBmaCAtrN2UOkYSCjjc=
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr296187wrv.187.1544149832601;
 Thu, 06 Dec 2018 18:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20181203123524.11778-1-anup@brainfault.org> <mhng-41a72f59-6506-420f-a01e-b01c81ab6e33@palmer-si-x1c4>
In-Reply-To: <mhng-41a72f59-6506-420f-a01e-b01c81ab6e33@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 7 Dec 2018 07:57:26 +0530
Message-ID: <CAAhSdy2g_-kYYrW4VJffLPA8evK9mjby06izC6FmNkRe3SceSQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource: riscv_timer: Provide sched_clock
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 2:02 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 03 Dec 2018 04:35:24 PST (-0800), anup@brainfault.org wrote:
> > Currently, we don't have a sched_clock registered for RISC-V systems.
> > This means Linux time keeping will use jiffies (running at HZ) as the
> > default sched_clock.
> >
> > To avoid this, we explicity provide sched_clock using RISC-V rdtime
> > instruction (similar to riscv_timer clocksource).
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > ---
> >  drivers/clocksource/riscv_timer.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> > index 084e97dc10ed..431892200a08 100644
> > --- a/drivers/clocksource/riscv_timer.c
> > +++ b/drivers/clocksource/riscv_timer.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/delay.h>
> >  #include <linux/irq.h>
> > +#include <linux/sched_clock.h>
> >  #include <asm/smp.h>
> >  #include <asm/sbi.h>
> >
> > @@ -49,6 +50,11 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
> >       return get_cycles64();
> >  }
> >
> > +static u64 riscv_sched_clock(void)
> > +{
> > +     return get_cycles64();
> > +}
> > +
> >  static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
> >       .name           = "riscv_clocksource",
> >       .rating         = 300,
> > @@ -97,6 +103,9 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> >       cs = per_cpu_ptr(&riscv_clocksource, cpuid);
> >       clocksource_register_hz(cs, riscv_timebase);
> >
> > +     sched_clock_register(riscv_sched_clock,
> > +                     BITS_PER_LONG, riscv_timebase);
>
> Shouldn't this just be 64, not BITS_PER_LONG?  We have 64-bit counters on
> RV32I.

Ahh, yes. I got mislead by "mask" field of clocksource.

I will change this to 64 and add another patch on fix "mask" of
clocksource as well.

Regards,
Anup
