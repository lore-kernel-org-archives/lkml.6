Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2993AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21AA21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21AA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeKUTPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:15:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43766 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbeKUTPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:15:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 863D5353C;
        Wed, 21 Nov 2018 00:41:29 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B079E3F575;
        Wed, 21 Nov 2018 00:41:26 -0800 (PST)
Subject: Re: [PATCH v2 08/15] irqchip: Add RDA8810PL interrupt driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-9-manivannan.sadhasivam@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <83f70f64-79f1-c6e5-0328-09cc567f2686@arm.com>
Date:   Wed, 21 Nov 2018 08:41:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181121033652.12247-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 03:36, Manivannan Sadhasivam wrote:
> Add interrupt driver for RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/mach-rda/Kconfig      |   1 +
>  drivers/irqchip/Kconfig        |   4 ++
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/irq-rda-intc.c | 113 +++++++++++++++++++++++++++++++++
>  4 files changed, 119 insertions(+)
>  create mode 100644 drivers/irqchip/irq-rda-intc.c
> 
> diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> index dafab78d7aab..29012bc68ca4 100644
> --- a/arch/arm/mach-rda/Kconfig
> +++ b/arch/arm/mach-rda/Kconfig
> @@ -3,5 +3,6 @@ menuconfig ARCH_RDA
>  	depends on ARCH_MULTI_V7
>  	select COMMON_CLK
>  	select GENERIC_IRQ_CHIP
> +	select RDA_INTC
>  	help
>  	  This enables support for the RDA Micro 8810PL SoC family.
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 51a5ef0e96ed..9d54645870ad 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -195,6 +195,10 @@ config JCORE_AIC
>  	help
>  	  Support for the J-Core integrated AIC.
>  
> +config RDA_INTC
> +	bool
> +	select IRQ_DOMAIN
> +
>  config RENESAS_INTC_IRQPIN
>  	bool
>  	select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 794c13d3ac3d..417108027e40 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
>  obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
>  obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
>  obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
> +obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
> new file mode 100644
> index 000000000000..1b372bdb23bc
> --- /dev/null
> +++ b/drivers/irqchip/irq-rda-intc.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RDA8810PL SoC irqchip driver
> + *
> + * Copyright RDA Microelectronics Company Limited
> + * Copyright (c) 2017 Andreas Färber
> + * Copyright (c) 2018 Manivannan Sadhasivam
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/irq.h>

You shouldn't need to include this.

> +#include <asm/exception.h>
> +
> +#define RDA_INTC_FINALSTATUS	0x00
> +#define RDA_INTC_STATUS		0x04
> +#define RDA_INTC_MASK_SET	0x08
> +#define RDA_INTC_MASK_CLR	0x0c
> +#define RDA_INTC_WAKEUP_MASK	0x18
> +#define RDA_INTC_CPU_SLEEP	0x1c

Half of these constants are unused. Do we really need them?

> +
> +#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
> +
> +#define RDA_NR_IRQS 32

Surely the mask can be derived from the number of interrupts?

> +
> +static void __iomem *base;

Everything in this driver is prefixed with rda_. It would seem valuable
to  do the same here, as "base" is a bit too generic.

> +
> +static void rda_intc_mask_irq(struct irq_data *d)
> +{
> +	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);
> +}
> +
> +static void rda_intc_unmask_irq(struct irq_data *d)
> +{
> +	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_SET);

Are the names MASK_CLR and MASK_SET from the datasheet? They seem to be
backward (you set the mask to unmask...), and seem to behave like an
enable instead. That's not a big issue, just curious.

> +}
> +
> +static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	/* Hardware supports only level triggered interrupts */
> +	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> +		irq_set_handler(data->irq, handle_level_irq);

Why do you need to do this? You've already configured it at map time,
and it is not changing under your feet. This should be written as:

if ((flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) == flow_type)
	return 0;

return -EINVAL;

> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static struct irq_domain *rda_irq_domain;

Please move this to the top of the file, next to "base".

> +
> +static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
> +{
> +	u32 stat = readl_relaxed(base + RDA_INTC_FINALSTATUS);
> +	u32 hwirq;
> +
> +	while (stat) {
> +		hwirq = __fls(stat);
> +		handle_domain_irq(rda_irq_domain, hwirq, regs);
> +		stat &= ~(1 << hwirq);
> +	}
> +}
> +
> +static struct irq_chip rda_irq_chip = {
> +	.name		= "rda-intc",
> +	.irq_mask	= rda_intc_mask_irq,
> +	.irq_unmask	= rda_intc_unmask_irq,
> +	.irq_set_type	= rda_intc_set_type,
> +};
> +
> +static int rda_irq_map(struct irq_domain *d,
> +		       unsigned int virq, irq_hw_number_t hw)
> +{
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_chip_and_handler(virq, &rda_irq_chip, handle_level_irq);
> +	irq_set_chip_data(virq, d->host_data);
> +	irq_set_probe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops rda_irq_domain_ops = {
> +	.map = rda_irq_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static int __init rda8810_intc_init(struct device_node *node,
> +				    struct device_node *parent)
> +{
> +	base = of_io_request_and_map(node, 0, "rda-intc");
> +	if (!base)
> +		return -ENXIO;
> +
> +	/* Mask, and invalidate all interrupt sources */

What does "invalidate" mean here?

> +	writel_relaxed(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
> +
> +	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
> +						  &rda_irq_domain_ops, base);
> +	if (WARN_ON(!rda_irq_domain)) {
> +		iounmap(base);
> +		return -ENODEV;

Why ENODEV? ENOMEM seems more appropriate. The WARN_ON is a bit
superfluous, as the failing probe should be noisy enough.

> +	}
> +
> +	set_handle_irq(rda_handle_irq);
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
> 

You've already posted two versions in 3 days, please allow for a week
between versions.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
