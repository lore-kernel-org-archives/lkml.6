Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08674C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92279205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Wg7PnavM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLRKcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:32:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38482 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeLRKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:32:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so15316979wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YTuC8veEqcdC00DnB8iCpbVjsjm1RFbphabmuAgDsY=;
        b=Wg7PnavMsDxylnR64ewsOx6DVp9Ym5mrsCv5anM6FNWkBF+s2w4wdJjgz6BcJ8fQ8R
         WATAxridgmlUOqtvY2gdSEaQRAW6iyZSmohh6SOWCyYNTYmN22HvsT/Edx4W9b1Bq8sK
         +Nse9P6eeXSObtFHUY4c6apd0AsrHHdjSoGQ0fCg8qmbsg1nzP2D5i/fqEK3qNjupdnb
         6+31LhYqwpDv2UyncJ0PZRADXCu7j3Cjy3XNNJvEKEpHjjeo58SZ06n+NxDIjJ2YxPjl
         mduXfJ5ANr1vPcE1aXjeWMXVJidAOs9V0uddYbwZ4hWGvyTDxmvFvw3+7xfsrXdj3r55
         L2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YTuC8veEqcdC00DnB8iCpbVjsjm1RFbphabmuAgDsY=;
        b=sggUYQaiB7nK27TX3xEZCSpM4+5aHh7564WpO84KSAzqIyTuSankJ2mpkGiYlzg8w9
         ZWSC+ULsEP7WHh+Ad2khU+lktQpEWlmY7ZjJWG10fbLGFFgNzxheC7u5v9wAiviH1Q0T
         CxhxfydxJKfcNPqiPGlGaJpFMy1I9KRpQ3fDT2bFOEV5uANphROj5m6Ej7QkGNYd57IL
         URiOhJAm0RE8tJD4mB8DFcag+7r2XZBi2QAldNch6OuFZaJDYW+bHA9OYO7Qta9R5qbA
         l9v1XdGULLZTiA5+hKs9TP4aMVNE+GrgUxLTCTkf/oMZLM+/86viwu6YOYmSNBc+n4yI
         jvDQ==
X-Gm-Message-State: AA+aEWamxBCE0nqh6MLKY3KeMeIZi4aTK1WP4HzyJQ1+O1MlY387Brr3
        39uiz0ICn4ydpT5ODzJp4y0laEXH3Y7enycqIocV1A==
X-Google-Smtp-Source: AFSGD/VNsQJo/cgSrZWNhedsB3N29uldBE0TMTipUrWJ01nxqEXtAA724qc6HtMDu75hSPp9SstQcUY6GaKZKSJjn9Y=
X-Received: by 2002:adf:ee07:: with SMTP id y7mr14648797wrn.187.1545129140582;
 Tue, 18 Dec 2018 02:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20181130080207.20505-1-anup@brainfault.org> <20181130080207.20505-7-anup@brainfault.org>
 <20181217183220.GE7086@infradead.org>
In-Reply-To: <20181217183220.GE7086@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Dec 2018 16:02:09 +0530
Message-ID: <CAAhSdy3=Hz7uuT=AEJqmZ7OJZg5Zt9MSg8QiBjEzH5wcsOH1-Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] irqchip: sifive-plic: Implement irq_set_affinity()
 for SMP host
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:02 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 30, 2018 at 01:32:07PM +0530, Anup Patel wrote:
> > This patch provides irq_set_affinity() implementation for PLIC driver.
> > It also updates irq_enable() such that PLIC interrupts are only enabled
> > for one of CPUs specified in IRQ affinity mask.
>
> But normally our affinity masks are that - masks of CPUs that can take
> it.  It seems a bit odd to then just pick the first one, as this means
> with default all-CPU masks we'll have all interrupts handled by the
> first CPU only.

Yes, affinity mask are CPUs which can take but there is also effective
affinity mask which represent CPUs which will actually receive IRQ.

Interrupt controllers (unlike PLIC) can support hardware IRQ balancing.
For such interrupt controllers, we inform all CPUs that can take IRQ but
interrupt controller will only deliver IRQ to only one of the CPUs.

There are quite a few interrupt controllers which only allow IRQ to
be taken by exactly one CPU. For such interrupt controllers, the
interrupt controller driver has to to pick one CPU out of CPUs which
can take IRQ (Example GICv2, GICv3, etc).

>
>
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -106,14 +106,42 @@ static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
> >
> >  static void plic_irq_enable(struct irq_data *d)
> >  {
> > -     plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
> > +     unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> > +                                        cpu_online_mask);
> > +     WARN_ON(cpu >= nr_cpu_ids);
>
> I think this should be WARN_ON_ONCE and actually return instead of then
> proceeding using the invalid cpu index.

Sure, will update.

>
> > +#ifdef CONFIG_SMP
> static int plic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> > +                         bool force)
> > +{
> > +     unsigned int cpu;
> > +
> > +     if (!force)
> > +             cpu = cpumask_any_and(mask_val, cpu_online_mask);
> > +     else
> > +             cpu = cpumask_first(mask_val);
>
> maybe swap the two branches around to avoid the inversion of the force
> flag?

Sure, will update.

Regards,
Anup
