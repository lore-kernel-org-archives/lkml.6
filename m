Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F1205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJQBa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:30:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40562 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeJQBa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:30:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A8180D;
        Tue, 16 Oct 2018 10:38:57 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3256C3F71C;
        Tue, 16 Oct 2018 10:38:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] irqchip: add driver for imx-irqsteer controller
To:     Lucas Stach <l.stach@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
References: <20181016164218.3736-1-l.stach@pengutronix.de>
 <20181016164218.3736-2-l.stach@pengutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 xsFNBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABzSNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPsLBewQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AFAk6NvYYCGQEACgkQI9DQutE9ekObww/+NcUATWXOcnoPflpYG43GZ0XjQLng
 LQFjBZL+CJV5+1XMDfz4ATH37cR+8gMO1UwmWPv5tOMKLHhw6uLxGG4upPAm0qxjRA/SE3LC
 22kBjWiSMrkQgv5FDcwdhAcj8A+gKgcXBeyXsGBXLjo5UQOGvPTQXcqNXB9A3ZZN9vS6QUYN
 TXFjnUnzCJd+PVI/4jORz9EUVw1q/+kZgmA8/GhfPH3xNetTGLyJCJcQ86acom2liLZZX4+1
 6Hda2x3hxpoQo7pTu+XA2YC4XyUstNDYIsE4F4NVHGi88a3N8yWE+Z7cBI2HjGvpfNxZnmKX
 6bws6RQ4LHDPhy0yzWFowJXGTqM/e79c1UeqOVxKGFF3VhJJu1nMlh+5hnW4glXOoy/WmDEM
 UMbl9KbJUfo+GgIQGMp8mwgW0vK4HrSmevlDeMcrLdfbbFbcZLNeFFBn6KqxFZaTd+LpylIH
 bOPN6fy1Dxf7UZscogYw5Pt0JscgpciuO3DAZo3eXz6ffj2NrWchnbj+SpPBiH4srfFmHY+Y
 LBemIIOmSqIsjoSRjNEZeEObkshDVG5NncJzbAQY+V3Q3yo9og/8ZiaulVWDbcpKyUpzt7pv
 cdnY3baDE8ate/cymFP5jGJK++QCeA6u6JzBp7HnKbngqWa6g8qDSjPXBPCLmmRWbc5j0lvA
 6ilrF8nOwU0ETol/RQEQAM/2pdLYCWmf3rtIiP8Wj5NwyjSL6/UrChXtoX9wlY8a4h3EX6E3
 64snIJVMLbyr4bwdmPKULlny7T/R8dx/mCOWu/DztrVNQiXWOTKJnd/2iQblBT+W5W8ep/nS
 w3qUIckKwKdplQtzSKeE+PJ+GMS+DoNDDkcrVjUnsoCEr0aK3cO6g5hLGu8IBbC1CJYSpple
 VVb/sADnWF3SfUvJ/l4K8Uk4B4+X90KpA7U9MhvDTCy5mJGaTsFqDLpnqp/yqaT2P7kyMG2E
 w+eqtVIqwwweZA0S+tuqput5xdNAcsj2PugVx9tlw/LJo39nh8NrMxAhv5aQ+JJ2I8UTiHLX
 QvoC0Yc/jZX/JRB5r4x4IhK34Mv5TiH/gFfZbwxd287Y1jOaD9lhnke1SX5MXF7eCT3cgyB+
 hgSu42w+2xYl3+rzIhQqxXhaP232t/b3ilJO00ZZ19d4KICGcakeiL6ZBtD8TrtkRiewI3v0
 o8rUBWtjcDRgg3tWx/PcJvZnw1twbmRdaNvsvnlapD2Y9Js3woRLIjSAGOijwzFXSJyC2HU1
 AAuR9uo4/QkeIrQVHIxP7TJZdJ9sGEWdeGPzzPlKLHwIX2HzfbdtPejPSXm5LJ026qdtJHgz
 BAb3NygZG6BH6EC1NPDQ6O53EXorXS1tsSAgp5ZDSFEBklpRVT3E0NrDABEBAAHCwV8EGAEC
 AAkFAk6Jf0UCGwwACgkQI9DQutE9ekMLBQ//U+Mt9DtFpzMCIHFPE9nNlsCm75j22lNiw6mX
 mx3cUA3pl+uRGQr/zQC5inQNtjFUmwGkHqrAw+SmG5gsgnM4pSdYvraWaCWOZCQCx1lpaCOl
 MotrNcwMJTJLQGc4BjJyOeSH59HQDitKfKMu/yjRhzT8CXhys6R0kYMrEN0tbe1cFOJkxSbV
 0GgRTDF4PKyLT+RncoKxQe8lGxuk5614aRpBQa0LPafkirwqkUtxsPnarkPUEfkBlnIhAR8L
 kmneYLu0AvbWjfJCUH7qfpyS/FRrQCoBq9QIEcf2v1f0AIpA27f9KCEv5MZSHXGCdNcbjKw1
 39YxYZhmXaHFKDSZIC29YhQJeXWlfDEDq6nIhvurZy3mSh2OMQgaIoFexPCsBBOclH8QUtMk
 a3jW/qYyrV+qUq9Wf3SKPrXf7B3xB332jFCETbyZQXqmowV+2b3rJFRWn5hK5B+xwvuxKyGq
 qDOGjof2dKl2zBIxbFgOclV7wqCVkhxSJi/QaOj2zBqSNPXga5DWtX3ekRnJLa1+ijXxmdjz
 hApihi08gwvP5G9fNGKQyRETePEtEAWt0b7dOqMzYBYGRVr7uS4uT6WP7fzOwAJC4lU7ZYWZ
 yVshCa0IvTtp1085RtT3qhh9mobkcZ+7cQOY+Tx2RGXS9WeOh2jZjdoWUv6CevXNQyOUXMM=
Organization: ARM Ltd
Message-ID: <d3aa8a2e-7b98-2f7c-ffa6-dbbc4d336752@arm.com>
Date:   Tue, 16 Oct 2018 18:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016164218.3736-2-l.stach@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 16/10/18 17:42, Lucas Stach wrote:
> The irqsteer block is a interrupt multiplexer/remapper found on the
> i.MX8 line of SoCs.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> This submission is a heavily cleaned up version of the downstream driver.
> ---
>  drivers/irqchip/Kconfig            |   8 +
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-imx-irqsteer.c | 281 +++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/irqchip/irq-imx-irqsteer.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 383e7b70221d..07290b30abd2 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -371,6 +371,14 @@ config QCOM_PDC
>  	  Power Domain Controller driver to manage and configure wakeup
>  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
>  
> +config IMX_IRQSTEER
> +	bool "i.MX IRQSTEER support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	default ARCH_MXC
> +	select IRQ_DOMAIN
> +	help
> +	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
> +
>  endmenu
>  
>  config SIFIVE_PLIC
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index fbd1ec8070ef..2c77ba4cc3cc 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
>  obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>  obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
> +obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> new file mode 100644
> index 000000000000..3ff0698ea7bd
> --- /dev/null
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2017 NXP
> + * Copyright (C) 2018 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_platform.h>
> +#include <linux/spinlock.h>
> +
> +#define CHANREG_OFF(_t)	(_t * 4)
> +#define CHANCTRL		0x0
> +#define CHANMASK(n, t)		(0x4 + (0x4 * (n)) + (CHANREG_OFF(t) * 0))
> +#define CHANSET(n, t)		(0x4 + (0x4 * (n)) + (CHANREG_OFF(t) * 1))
> +#define CHANSTATUS(n, t)	(0x4 + (0x4 * (n)) + (CHANREG_OFF(t) * 2))
> +#define CHAN_MINTDIS(t)		(0x4 + (CHANREG_OFF(t) * 3))
> +#define CHAN_MASTRSTAT(t)	(0x8 + (CHANREG_OFF(t) * 3))
> +
> +struct irqsteer_irqchip_data {
> +	spinlock_t lock;

raw_spinlock_t, please.

> +	struct platform_device *pdev;
> +	void __iomem *regs;
> +	struct clk *ipg_clk;
> +	int irq;
> +	int channum;
> +	int big_endian;

bool?

> +	struct irq_domain *domain;
> +	int *saved_reg;
> +};
> +
> +static int imx_irqsteer_get_reg_index(struct irqsteer_irqchip_data *data,
> +				      unsigned long irqnum)
> +{
> +	if (data->big_endian)
> +		return (data->channum - irqnum / 32 - 1);
> +	else
> +		return irqnum / 32;
> +}
> +
> +static void imx_irqsteer_irq_unmask(struct irq_data *d)
> +{
> +	struct irqsteer_irqchip_data *data = d->chip_data;
> +	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
> +	u32 val;
> +
> +	spin_lock(&data->lock);
> +	val = readl_relaxed(data->regs + CHANMASK(idx, data->channum));
> +	val |= 1 << (d->hwirq % 32);
> +	writel_relaxed(val, data->regs + CHANMASK(idx, data->channum));
> +	spin_unlock(&data->lock);

If you take an interrupt within this sequence (because a driver is
calling enable_irq/disable_irq, for example), and that you try to mask
or unmask (which your flow handler will do), you're in for a nice
deadlock. Consider using the irqsave/irqrestore variants.

> +}
> +
> +static void imx_irqsteer_irq_mask(struct irq_data *d)
> +{
> +	struct irqsteer_irqchip_data *data = d->chip_data;
> +	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
> +	u32 val;
> +
> +	spin_lock(&data->lock);
> +	val = readl_relaxed(data->regs + CHANMASK(idx, data->channum));
> +	val &= ~(1 << (d->hwirq % 32));
> +	writel_relaxed(val, data->regs + CHANMASK(idx, data->channum));
> +	spin_unlock(&data->lock);
> +}
> +
> +static int imx_irqsteer_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	if ((flow_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_LEVEL_HIGH)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip imx_irqsteer_irq_chip = {
> +	.name		= "irqsteer",
> +	.irq_eoi	= irq_chip_eoi_parent,

What does it mean to call into the parent while this is a chained
interrupt controller which, by definition, doesn't have any parent?

> +	.irq_mask	= imx_irqsteer_irq_mask,
> +	.irq_unmask	= imx_irqsteer_irq_unmask,
> +	.irq_set_type	= imx_irqsteer_set_type,
> +};
> +
> +static int imx_irqsteer_irq_map(struct irq_domain *h, unsigned int irq,
> +				irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_data(irq, h->host_data);
> +	irq_set_chip_and_handler(irq, &imx_irqsteer_irq_chip, handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops imx_irqsteer_domain_ops = {
> +	.map		= imx_irqsteer_irq_map,
> +	.xlate		= irq_domain_xlate_twocell,
> +};
> +
> +static void imx_irqsteer_irq_handler(struct irq_desc *desc)
> +{
> +	struct irqsteer_irqchip_data *data = irq_desc_get_handler_data(desc);
> +	u32 val;
> +	int i;
> +
> +	chained_irq_enter(irq_desc_get_chip(desc), desc);
> +
> +	val = readl_relaxed(data->regs + CHAN_MASTRSTAT(data->channum));
> +	if (!val)
> +		goto out;
> +
> +	for (i = 0; i < data->channum; i++) {
> +		int idx = data->big_endian ? (data->channum - i - 1) : i;

How about reusing your imx_irqsteer_get_reg_index helper here?

Also what is the use of val? Shouldn't you only read the status register
for channels that have interrupts pending (assuming I understand how
this thing works)?

> +		unsigned long irqmap;
> +		int pos, virq;
> +
> +		irqmap = readl_relaxed(data->regs +
> +				       CHANSTATUS(idx, data->channum));
> +
> +		for_each_set_bit(pos, &irqmap, 32) {
> +			virq = irq_find_mapping(data->domain, pos);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +
> +out:
> +	chained_irq_exit(irq_desc_get_chip(desc), desc);

I guess you can have a local variable caching this irq_desc_get_chip().

> +}
> +
> +static int imx_irqsteer_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct irqsteer_irqchip_data *data;
> +	struct resource *res;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->regs)) {
> +		dev_err(&pdev->dev, "failed to initialize reg\n");
> +		return PTR_ERR(data->regs);
> +	}
> +
> +	data->irq = platform_get_irq(pdev, 0);
> +	if (data->irq <= 0) {
> +		dev_err(&pdev->dev, "failed to get irq\n");
> +		return -ENODEV;
> +	}
> +
> +	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(data->ipg_clk)) {
> +		ret = PTR_ERR(data->ipg_clk);
> +		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* default to 1 channel and little endian */
> +	data->channum = 1;
> +	data->big_endian  = 0;

s/0/false/

> +	data->pdev = pdev;
> +	spin_lock_init(&data->lock);
> +
> +	of_property_read_u32(np, "fsl,channel", &data->channum);
> +	of_property_read_u32(np, "fsl,endian", &data->big_endian);

If you're reading a u32, please use the same type in the data structure.

> +
> +	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> +		data->saved_reg = devm_kzalloc(&pdev->dev,
> +					       sizeof(u32) * data->channum + 1,
> +					       GFP_KERNEL);

Use the appropriate type for saved_reg.

> +		if (!data->saved_reg)
> +			return -ENOMEM;
> +	}
> +
> +	ret = clk_prepare_enable(data->ipg_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* enable channel 1 by default */
> +	writel_relaxed(1, data->regs + CHANCTRL);

Is that channel 1? or channel 0? Also, who enables the other channels? I
have the feeling that this driver is unable to service more than the
first 32 interrupts... But again, I'm guessing how the HW works here.

> +
> +	data->domain = irq_domain_add_linear(np, data->channum * 32,
> +					     &imx_irqsteer_domain_ops, data);
> +	if (!data->domain) {
> +		dev_err(&data->pdev->dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
> +					 data);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static int imx_irqsteer_remove(struct platform_device *pdev)
> +{
> +	struct irqsteer_irqchip_data *irqsteer_data = platform_get_drvdata(pdev);
> +
> +	irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
> +	irq_domain_remove(irqsteer_data->domain);
> +
> +	clk_disable_unprepare(irqsteer_data->ipg_clk);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static void imx_irqsteer_save_regs(struct irqsteer_irqchip_data *data)
> +{
> +	int num;
> +
> +	data->saved_reg[0] = readl_relaxed(data->regs + CHANCTRL);
> +	for (num = 0; num < data->channum; num++)
> +		data->saved_reg[num + 1] = readl_relaxed(data->regs +
> +						CHANMASK(num, data->channum));
> +}
> +
> +static void imx_irqsteer_restore_regs(struct irqsteer_irqchip_data *data)
> +{
> +	int num;
> +
> +	writel_relaxed(data->saved_reg[0], data->regs + CHANCTRL);
> +	for (num = 0; num < data->channum; num++)
> +		writel_relaxed(data->saved_reg[num + 1],
> +			       data->regs + CHANMASK(num, data->channum));
> +}
> +
> +static int imx_irqsteer_suspend(struct device *dev)
> +{
> +	struct irqsteer_irqchip_data *irqsteer_data = dev_get_drvdata(dev);
> +
> +	imx_irqsteer_save_regs(irqsteer_data);
> +	clk_disable_unprepare(irqsteer_data->ipg_clk);
> +
> +	return 0;
> +}
> +
> +static int imx_irqsteer_resume(struct device *dev)
> +{
> +	struct irqsteer_irqchip_data *irqsteer_data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(irqsteer_data->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +	imx_irqsteer_restore_regs(irqsteer_data);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops imx_irqsteer_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_irqsteer_suspend, imx_irqsteer_resume)
> +};
> +
> +static const struct of_device_id imx_irqsteer_dt_ids[] = {
> +	{ .compatible = "fsl,imx-irqsteer", },
> +	{},
> +};
> +
> +static struct platform_driver imx_irqsteer_driver = {
> +	.driver = {
> +		.name = "imx-irqsteer",
> +		.of_match_table = imx_irqsteer_dt_ids,
> +		.pm = &imx_irqsteer_pm_ops,
> +	},
> +	.probe = imx_irqsteer_probe,
> +	.remove = imx_irqsteer_remove,
> +};
> +builtin_platform_driver(imx_irqsteer_driver);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
