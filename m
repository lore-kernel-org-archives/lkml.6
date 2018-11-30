Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324EC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5D220868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Aa8CTtoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5D220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeK3Omo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:42:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33603 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Omn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:42:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so3911927wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 19:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=px///lnI5nlBDxtHhYbqL3fKd6VwAKuL64n/fMX7EZg=;
        b=Aa8CTtoAN+jIf3mFA3F9tryFcVj5Vj+1+dWCrzYkK5g+RduHKBV9AXQwWhu7cN8+Bf
         /LBTi0IsoOs6Oc89V1qskRR/+BciLG7fBzCUo90peVTWkSLFBHpScjAI+cqQDOBVXmuO
         IG6o95LsPwQaRr7lwCrCXkfODpUBIEoMb0BrbHjTHN7NGEjCNDJ7hb05+yKYXD8SsJ4H
         zJjaIMGeNM1M3xgw1Fv1VzMky6WvgDMhASRa3Skr1/oZaA51f9CXy8f7V4/yvyNSnjox
         rAGLY0fq0DB5dqDWK1Xwde7uy/LGjvbpMmNndt9rT0AWwNEQs3MSExL1tJOLNkuquEAV
         0r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=px///lnI5nlBDxtHhYbqL3fKd6VwAKuL64n/fMX7EZg=;
        b=YxEMnw0TljghX2BrdJRpw0qXJmycw0Cnj9L3+zHl7swja+TpuQNO9V/+U3ttAbAMDJ
         8fPDZ5CiF28tj+OSYesMQQIwaXNSWn4e6h3S+/8pc8lY+eYCjeX5R/wrS++hKcmAiJQd
         yx1obmiK8a7lSMQwfJBjIBAt7eaXHumzIlWrQuTTSHD4AUXkykNkUerK9J6VN6ilCFnW
         nvU8DjS4V8KEdMAzU1xxhBwdWiY0yBnntzm0MWZZTFSHwLMgkmbK6H8FU7KY33CErjWy
         zbW/yXoZODKGDSipOutA+avHQURSMkNS/EuBT6+GMfabsDMJ+FaV+QbTChQztIie51Rz
         Z30g==
X-Gm-Message-State: AA+aEWY3yumLnkndCESgyf2pUgaJ+MFvezWGwaz+fEB01mYY8ApnHTEb
        j9rnaa8SPHIODZTf8LzNismki7picRHksFdQObh65g==
X-Google-Smtp-Source: AFSGD/WXjjnHpKx3qk9Q5BFnMON4UeWnsdYtpQb3Q/2k0/5XnK9ISMruMdx+Dr1iIiMox1LCIw80GfT3aZi9JeuYyjY=
X-Received: by 2002:adf:91a3:: with SMTP id 32mr3155796wri.99.1543548891044;
 Thu, 29 Nov 2018 19:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20181127100317.12809-1-anup@brainfault.org> <20181127100317.12809-2-anup@brainfault.org>
 <b6ff2593-9113-9b95-ade5-09e7e9fa1be5@wdc.com>
In-Reply-To: <b6ff2593-9113-9b95-ade5-09e7e9fa1be5@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 30 Nov 2018 09:04:46 +0530
Message-ID: <CAAhSdy0CDxoV2qJ-Xh-4udhh_jEz2KWKPfC_5QSo79VRo4EwUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] irqchip: sifive-plic: Pre-compute context hart
 base and enable base
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 6:05 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 11/27/18 2:03 AM, Anup Patel wrote:
> > This patch does following optimizations:
> > 1. Pre-compute hart base for each context handler
> > 2. Pre-compute enable base for each context handler
> > 3. Have enable lock for each context handler instead
> > of global plic_toggle_lock
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > ---
> >   drivers/irqchip/irq-sifive-plic.c | 41 +++++++++++++------------------
> >   1 file changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 357e9daf94ae..56fce648a901 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -60,36 +60,24 @@ static void __iomem *plic_regs;
> >   struct plic_handler {
> >       bool                    present;
> >       int                     ctxid;
> > +     void __iomem            *hart_base;
> > +     raw_spinlock_t          enable_lock;
> > +     void __iomem            *enable_base;
>
> It should be u32. Otherwise, plic_toggle calculates incorrect address
> and it does not boot on Unlheased.

Good catch. I did not see this issue on QEMU because we have
very IRQs over there.

>
> >   };
> >   static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> >
> > -static inline void __iomem *plic_hart_offset(int ctxid)
> > +static inline void plic_toggle(struct plic_handler *handler,
> > +                             int hwirq, int enable)
> >   {
> > -     return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
> > -}
> > -
> > -static inline u32 __iomem *plic_enable_base(int ctxid)
> > -{
> > -     return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
> > -}
> > -
> > -/*
> > - * Protect mask operations on the registers given that we can't assume that
> > - * atomic memory operations work on them.
> > - */
>
> Should we keep the comment for enable_lock ?

Sure, I will retain the comment for enable_lock.

>
> > -static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
> > -
> > -static inline void plic_toggle(int ctxid, int hwirq, int enable)
> > -{
> > -     u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
> > +     u32 __iomem *reg = handler->enable_base + (hwirq / 32);
> >       u32 hwirq_mask = 1 << (hwirq % 32);
> >
> > -     raw_spin_lock(&plic_toggle_lock);
> > +     raw_spin_lock(&handler->enable_lock);
> >       if (enable)
> >               writel(readl(reg) | hwirq_mask, reg);
> >       else
> >               writel(readl(reg) & ~hwirq_mask, reg);
> > -     raw_spin_unlock(&plic_toggle_lock);
> > +     raw_spin_unlock(&handler->enable_lock);
> >   }
> >
> >   static inline void plic_irq_toggle(struct irq_data *d, int enable)
> > @@ -101,7 +89,7 @@ static inline void plic_irq_toggle(struct irq_data *d, int enable)
> >               struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> >
> >               if (handler->present)
> > -                     plic_toggle(handler->ctxid, d->hwirq, enable);
> > +                     plic_toggle(handler, d->hwirq, enable);
> >       }
> >   }
> >
> > @@ -150,7 +138,7 @@ static struct irq_domain *plic_irqdomain;
> >   static void plic_handle_irq(struct pt_regs *regs)
> >   {
> >       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > -     void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
> > +     void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
> >       irq_hw_number_t hwirq;
> >
> >       WARN_ON_ONCE(!handler->present);
> > @@ -240,11 +228,16 @@ static int __init plic_init(struct device_node *node,
> >               handler = per_cpu_ptr(&plic_handlers, cpu);
> >               handler->present = true;
> >               handler->ctxid = i;
> > +             handler->hart_base =
> > +                     plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> > +             raw_spin_lock_init(&handler->enable_lock);
> > +             handler->enable_base =
> > +                     plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
> >
> >               /* priority must be > threshold to trigger an interrupt */
> > -             writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
> > +             writel(0, handler->hart_base + CONTEXT_THRESHOLD);
> >               for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> > -                     plic_toggle(i, hwirq, 0);
> > +                     plic_toggle(handler, hwirq, 0);
> >               nr_mapped++;
> >       }
> >
> >
>

--
Anup
