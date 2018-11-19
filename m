Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6440C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738962145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738962145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbeKTEBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:01:22 -0500
Received: from foss.arm.com ([217.140.101.70]:35508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389841AbeKTEBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:01:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC17E1596;
        Mon, 19 Nov 2018 09:36:53 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F1593F5B7;
        Mon, 19 Nov 2018 09:36:51 -0800 (PST)
Subject: Re: [PATCH 09/16] irqchip: Add RDA8810PL interrupt driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-10-manivannan.sadhasivam@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <29ddffae-b61b-be92-c235-a79ecdf7512c@arm.com>
Date:   Mon, 19 Nov 2018 17:36:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181119170939.19153-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan,

On 19/11/2018 17:09, Manivannan Sadhasivam wrote:
> Add interrupt driver for RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/mach-rda/Kconfig      |   1 +
>  drivers/irqchip/Kconfig        |   4 ++
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/irq-rda-intc.c | 116 +++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
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
> index 000000000000..89be55a11823
> --- /dev/null
> +++ b/drivers/irqchip/irq-rda-intc.c
> @@ -0,0 +1,116 @@
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
> +#include <asm/exception.h>
> +
> +#define RDA_INTC_FINALSTATUS	0x00
> +#define RDA_INTC_STATUS		0x04
> +#define RDA_INTC_MASK_SET	0x08
> +#define RDA_INTC_MASK_CLR	0x0c
> +#define RDA_INTC_WAKEUP_MASK	0x18
> +#define RDA_INTC_CPU_SLEEP	0x1c
> +
> +#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
> +
> +#define RDA_NR_IRQS 32
> +
> +void __iomem *base;

Should be static?

> +
> +static void rda_intc_mask_irq(struct irq_data *d)
> +{
> +	void __iomem *base = (void __iomem *)irq_data_get_irq_chip_data(d);

Aliases with the above. Please choose whether you want a global or a
per-interrupt base.

> +
> +	writel(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);

writel_relaxed()

> +}
> +
> +static void rda_intc_unmask_irq(struct irq_data *d)
> +{
> +	void __iomem *base = (void __iomem *)irq_data_get_irq_chip_data(d);
> +
> +	writel(BIT(d->hwirq), base + RDA_INTC_MASK_SET);

Same here.

> +}
> +
> +static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
> +		irq_set_handler(data->irq, handle_edge_irq);
> +	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> +		irq_set_handler(data->irq, handle_level_irq);

So you don't need to set anything in your interrupt controller for this
to switch between level and edge? That'd be a first...

> +
> +	return 0;
> +}
> +
> +struct irq_domain *rda_irq_domain;

static?

> +
> +static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
> +{
> +	u32 stat = readl(base + RDA_INTC_FINALSTATUS);
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
> +	.irq_ack	= rda_intc_mask_irq,

You're joking, right? What does it mean to implement both ack as mask
when you already have mask?

> +	.irq_mask	= rda_intc_mask_irq,
> +	.irq_unmask	= rda_intc_unmask_irq,
> +	.irq_set_type	= rda_intc_set_type,
> +	.irq_disable	= rda_intc_mask_irq,

What is this disable for? Implementing enable/disable only makes sense
if their different implementation differs from mask/unmask (and that
they add some real value, such as allocating resource).

> +};
> +
> +static int rda_irq_map(struct irq_domain *d,
> +		       unsigned int virq, irq_hw_number_t hw)
> +{
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_chip_and_handler(virq, &rda_irq_chip, handle_level_irq);

The set_type callback is specially puzzling when you set everything to
be level...

> +	irq_set_chip_data(virq, d->host_data);
> +	irq_set_probe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops rda_irq_domain_ops = {
> +	.map = rda_irq_map,
> +	.xlate = irq_domain_xlate_onecell,

... and don't have any way to express an edge interrupt in DT.

> +};
> +
> +static int __init rda8810_intc_init(struct device_node *node,
> +				    struct device_node *parent)
> +{
> +	base = of_io_request_and_map(node, 0, "rda-intc");
> +	if (!base)
> +		return -ENXIO;
> +	/*
> +	 * Mask, and invalid all interrupt sources
> +	 */
> +	writel(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
> +
> +	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
> +						  &rda_irq_domain_ops, base);
> +	WARN_ON(!rda_irq_domain);

Just WARN_ON(), and carry on? Please implement some error handling.

> +
> +	set_handle_irq(rda_handle_irq);
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
