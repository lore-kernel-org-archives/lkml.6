Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B30C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4102087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA1PU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:20:58 -0500
Received: from foss.arm.com ([217.140.101.70]:47010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfA1PU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:20:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99DFB80D;
        Mon, 28 Jan 2019 07:20:57 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A7C33F589;
        Mon, 28 Jan 2019 07:20:56 -0800 (PST)
Subject: Re: [PATCH v4 1/2] irqchip: Add driver for Loongson-1 interrupt
 controller
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190128144631.31289-1-jiaxun.yang@flygoat.com>
 <20190128144631.31289-2-jiaxun.yang@flygoat.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <7d937af7-4e1e-3f04-9097-7a7fa6aaa940@arm.com>
Date:   Mon, 28 Jan 2019 15:20:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128144631.31289-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 14:46, Jiaxun Yang wrote:
> This controller appeared on Loongson-1 family MCUs
> including Loongson-1B and Loongson-1C.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/irqchip/Kconfig    |   9 ++
>  drivers/irqchip/Makefile   |   1 +
>  drivers/irqchip/irq-ls1x.c | 196 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/irqchip/irq-ls1x.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3d1e60779078..5dcb5456cd14 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -406,6 +406,15 @@ config IMX_IRQSTEER
>  	help
>  	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
>  
> +config LS1X_IRQ
> +	bool "Loongson-1 Interrupt Controller"
> +	depends on MACH_LOONGSON32
> +	default y
> +	select IRQ_DOMAIN
> +	select GENERIC_IRQ_CHIP
> +	help
> +	  Support for the Loongson-1 platform Interrupt Controller.
> +
>  endmenu
>  
>  config SIFIVE_PLIC
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index c93713d24b86..7acd0e36d0b4 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>  obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
> +obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
> diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
> new file mode 100644
> index 000000000000..41f856b5d7b3
> --- /dev/null
> +++ b/drivers/irqchip/irq-ls1x.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2019, Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *  Loongson-1 platform IRQ support
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/io.h>
> +#include <linux/irqchip/chained_irq.h>
> +
> +#define LS_REG_INTC_STATUS	0x00
> +#define LS_REG_INTC_EN	0x04
> +#define LS_REG_INTC_SET	0x08
> +#define LS_REG_INTC_CLR	0x0c
> +#define LS_REG_INTC_POL	0x10
> +#define LS_REG_INTC_EDGE	0x14
> +
> +/**
> + * struct ls1x_intc_priv - private ls1x-intc data.
> + * @domain:		IRQ domain.
> + * @intc_base:	IO Base of intc registers.
> + */
> +
> +struct ls1x_intc_priv {
> +	struct irq_domain	*domain;
> +	void __iomem		*intc_base;
> +};
> +
> +
> +static void ls1x_chained_handle_irq(struct irq_desc *desc)
> +{
> +	struct ls1x_intc_priv *priv = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 pending;
> +
> +	chained_irq_enter(chip, desc);
> +	pending = readl(priv->intc_base + LS_REG_INTC_STATUS) &
> +			readl(priv->intc_base + LS_REG_INTC_EN);
> +
> +	if (!pending) {
> +		spurious_interrupt();
> +		chained_irq_exit(chip, desc);
> +		return;
> +	}

As I wrote previously, this can be simplified.

> +
> +	while (pending) {
> +		int bit = __ffs(pending);
> +
> +		generic_handle_irq(irq_find_mapping(priv->domain, bit));
> +		pending &= ~BIT(bit);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void ls_intc_set_bit(struct irq_chip_generic *gc,
> +							unsigned int offset,
> +							u32 mask, bool set)
> +{
> +	if (set)
> +		writel(readl(gc->reg_base + offset) | mask,
> +		gc->reg_base + offset);
> +	else
> +		writel(readl(gc->reg_base + offset) & ~mask,
> +		gc->reg_base + offset);
> +}
> +
> +static int ls_intc_set_type(struct irq_data *data, unsigned int type)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	u32 mask = data->mask;
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
> +		break;
> +	case IRQ_TYPE_EDGE_RISING:
> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
> +		break;
> +	case IRQ_TYPE_NONE:
> +		break;

What does this mean? I can't see how that can lean to anything valid.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	irqd_set_trigger_type(data, type);
> +	return irq_setup_alt_chip(data, type);
> +}
> +
> +
> +static int __init ls1x_intc_of_init(struct device_node *node,
> +				       struct device_node *parent)
> +{
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +	struct ls1x_intc_priv *priv;
> +	int parent_irq, err = 0;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->intc_base = of_iomap(node, 0);
> +	if (!priv->intc_base) {
> +		err = -ENODEV;
> +		goto out_free_priv;
> +	}
> +
> +	parent_irq = irq_of_parse_and_map(node, 0);
> +	if (!parent_irq) {
> +		pr_err("ls1x-irq: unable to get parent irq\n");
> +		err =  -ENODEV;
> +		goto out_free_priv;

This is leaking the MMIO mapping.

> +	}
> +
> +	/* Set up an IRQ domain */
> +	priv->domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops,
> +					     NULL);
> +	if (!priv->domain) {
> +		pr_err("ls1x-irq: cannot add IRQ domain\n");
> +		goto out_free_priv;
> +	}
> +
> +

Spurious empty line.

> +	err = irq_alloc_domain_generic_chips(priv->domain, 32, 2,
> +		node->full_name, handle_level_irq,
> +		IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0,
> +		IRQ_GC_INIT_MASK_CACHE);
> +	if (err) {
> +		pr_err("ls1x-irq: unable to register IRQ domain\n");
> +		goto out_free_domain;
> +	}
> +
> +	/* Mask all irqs */
> +	writel(0x0, priv->intc_base + LS_REG_INTC_EN);
> +
> +	/* Ack all irqs */
> +	writel(0xffffffff, priv->intc_base + LS_REG_INTC_CLR);
> +
> +	/* Set all irqs to high level triggered */
> +	writel(0xffffffff, priv->intc_base + LS_REG_INTC_POL);
> +
> +	gc = irq_get_domain_generic_chip(priv->domain, 0);
> +
> +	gc->reg_base = priv->intc_base;
> +
> +	ct = gc->chip_types;
> +	ct[0].type = IRQ_TYPE_LEVEL_MASK;
> +	ct[0].regs.mask = LS_REG_INTC_EN;
> +	ct[0].regs.ack = LS_REG_INTC_CLR;
> +	ct[0].chip.irq_unmask = irq_gc_mask_set_bit;
> +	ct[0].chip.irq_mask = irq_gc_mask_clr_bit;
> +	ct[0].chip.irq_ack = irq_gc_ack_set_bit;
> +	ct[0].chip.irq_set_type = ls_intc_set_type;
> +	ct[0].handler = handle_level_irq;
> +
> +	ct[1].type = IRQ_TYPE_EDGE_BOTH;
> +	ct[1].regs.mask = LS_REG_INTC_EN;
> +	ct[1].regs.ack = LS_REG_INTC_CLR;
> +	ct[1].chip.irq_unmask = irq_gc_mask_set_bit;
> +	ct[1].chip.irq_mask = irq_gc_mask_clr_bit;
> +	ct[1].chip.irq_ack = irq_gc_ack_set_bit;
> +	ct[1].chip.irq_set_type = ls_intc_set_type;
> +	ct[1].handler = handle_edge_irq;
> +
> +
> +	irq_set_chained_handler_and_data(parent_irq,
> +		ls1x_chained_handle_irq, priv);
> +
> +	return 0;
> +
> +out_free_domain:
> +	irq_domain_remove(priv->domain);
> +out_free_priv:
> +	kfree(priv);
> +	return err;
> +}
> +
> +IRQCHIP_DECLARE(ls1x_intc, "loongson,ls1x-intc", ls1x_intc_of_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
