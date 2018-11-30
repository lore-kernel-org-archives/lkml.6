Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AED2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="tKOEoENU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AED2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeK3PDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:03:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43687 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeK3PDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:03:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so3898937wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 19:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLB7EVU44M/0Thoz+hWTouq1G+WRlY7ECvA7v+w6x2c=;
        b=tKOEoENUgC1N4ZfPi/5P8+yD8PCwxnIPPWi2bTKzeoCwj8Md+N+uVeNriXjKxIZs52
         1pfLR+nd7IdSH+tk/iPcHdKRcpRikNoLv5sbz0c8R4W717FUX1XA86shpb5WJsf3iEWJ
         1X4NJ4u8o6BgpaCpbyRdHf+MbWoNznWgbREVb3Lhnq3aIIDzaypMoeTChhByHG3X72lN
         PXPFfN+JfaAo0BBQoI2ePjEMA+FA1ZV2YbUgQdu1L2lzNpU12TyXfCvQNWtDWmwvRZYc
         0QseBXht50pW4ncVyYiXmELLmQquVgkrgCkAZg7Nw4mlrRAlEMwOvQeQ0nttiRYBXy9O
         RfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLB7EVU44M/0Thoz+hWTouq1G+WRlY7ECvA7v+w6x2c=;
        b=Oi+PRWbsQk9sSPm9XFOtCE12U5Wg0Paj8DSRs7MOw5rux1+X6FRXA9G7Ka026X+XZC
         ycchl5F6uCWeKNK75RD86zU3H/51DBZRCVjBe9POoAk4biIptoG0uC5y/Ogp2zZBTJqG
         wJ6bTnFAj2+0tgJ3AkgwbkrfuZGF9RIF7Il4Ki0P4X0G2pqhqsc+oLjhvIvZO+zmRbwF
         +qQb3jBdqnqAZSsAZ9eL2Ax3HrtLWoJ28+TkiX20RXM123J4bplG1EqThC2YdR3XvQjH
         oHFkGP6Qb+uPvA4m5gM0VP+EiyOF4d6k2wKwXSqDhT4G+A3C+P/npkm4gpbbsQWY/OuQ
         /L6w==
X-Gm-Message-State: AA+aEWaJIvwE+NKnFQRewyqJaVDHJ/FpJDIdLUFcoIi2C88blbXNErCL
        xzEfEfheYo/oVp5cjSlTTtEdx9zu8bnlDzwiCy5W1pbE
X-Google-Smtp-Source: AFSGD/WqZsdyyVA+1A6EgFwzQDkEBs9yitOmaxA7LwPfSL57qCalfqYbL2w2pYWloPuipmIk9JsMi/AMG9uBOVCcMao=
X-Received: by 2002:adf:91a3:: with SMTP id 32mr3186865wri.99.1543550110977;
 Thu, 29 Nov 2018 19:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127100317.12809-1-anup@brainfault.org> <20181127100317.12809-4-anup@brainfault.org>
 <93356e4f-ccd9-39ba-6afe-88dcdc72945d@wdc.com>
In-Reply-To: <93356e4f-ccd9-39ba-6afe-88dcdc72945d@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 30 Nov 2018 09:25:06 +0530
Message-ID: <CAAhSdy2GP+VqfQPJ4Bif81jWJG8v+b9NF-kTNqmjtT_JuOQu+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] irqchip: sifive-plic: Differentiate between PLIC
 handler and context
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

On Fri, Nov 30, 2018 at 7:27 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 11/27/18 2:04 AM, Anup Patel wrote:
> > We explicitly differentiate between PLIC handler and context because
> > PLIC context is for given mode of HART whereas PLIC handler is per-CPU
> > software construct meant for handling interrupts from a particular
> > PLIC context.
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > ---
> >   drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 95b4b92ca9b8..ffd4deaca057 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -66,8 +66,8 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> >
> >   struct plic_hw {
> >       u32                     nr_irqs;
> > +     u32                     nr_contexts;
> >       u32                     nr_handlers;
> > -     u32                     nr_mapped;
> >       void __iomem            *regs;
> >       struct irq_domain       *irqdomain;
> >   };
> > @@ -191,10 +191,10 @@ static int __init plic_init(struct device_node *node,
> >       if (WARN_ON(!plic.nr_irqs))
> >               goto out_iounmap;
> >
> > -     plic.nr_handlers = of_irq_count(node);
> > -     if (WARN_ON(!plic.nr_handlers))
> > +     plic.nr_contexts = of_irq_count(node);
> > +     if (WARN_ON(!plic.nr_contexts))
> >               goto out_iounmap;
> > -     if (WARN_ON(plic.nr_handlers < num_possible_cpus()))
> > +     if (WARN_ON(plic.nr_contexts < num_possible_cpus()))
> >               goto out_iounmap;
> >
> >       plic.irqdomain = irq_domain_add_linear(node, plic.nr_irqs + 1,
> > @@ -202,7 +202,7 @@ static int __init plic_init(struct device_node *node,
> >       if (WARN_ON(!plic.irqdomain))
> >               goto out_iounmap;
> >
> > -     for (i = 0; i < plic.nr_handlers; i++) {
> > +     for (i = 0; i < plic.nr_contexts; i++) {
> >               struct of_phandle_args parent;
> >               struct plic_handler *handler;
> >               irq_hw_number_t hwirq;
> > @@ -225,6 +225,11 @@ static int __init plic_init(struct device_node *node,
> >
> >               cpu = riscv_hartid_to_cpuid(hartid);
> >               handler = per_cpu_ptr(&plic_handlers, cpu);
> > +             if (handler->present) {
> > +                     pr_warn("handler not available for context %d.\n", i);
> > +                     continue;
> > +             }
> > +
>
> Ahh you have the handler->present check here in this patch. This should
> be in the 2nd patch. This change doesn't match the commit text anyways.

Sure, will do.

>
> Everything else just variable renaming which can be separated.
> nr_handlers->nr_contexts
> nr_mapped->nr_handlers
>

Sure, will update commit text.

Thanks,
Anup
