Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6CBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99073218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="MZ65MInY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfAYK4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:56:45 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:45445 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfAYK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:56:45 -0500
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 2D2FC598111F;
        Fri, 25 Jan 2019 13:56:42 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback7j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 36oHdN1ph2-ufXGGG2d;
        Fri, 25 Jan 2019 13:56:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548413802;
        bh=vQLxyh6P0iKcS/E/jVe+FtkT48AE5Oxvkn7EYp+YsRU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=MZ65MInYaUSmKsrXbWnh/crnNg/CwYe0qaHSW7k0WGfWFY8IN7UcR4kdnCnfoGP8p
         v5BGlv/JAHWqUP+E2mCH5abPt2rga9X8t2jHviljBeGuWT0kaKrfif65gDX5lO8+9G
         I2gxXMA0wMTJs7CXAhrU7HXIcVeeD8B5rs0nXDtY=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id b7OpyjULBp-uaZuNKrq;
        Fri, 25 Jan 2019 13:56:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v3 1/2] irqchip: Add driver for Loongson-1 interrupt
 controller
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-mips@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
 <20190124032730.18237-1-jiaxun.yang@flygoat.com>
 <20190124032730.18237-2-jiaxun.yang@flygoat.com>
 <86pnsm8jon.wl-marc.zyngier@arm.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <a0041cdb-1db6-9fee-411a-ae9d2a575349@flygoat.com>
Date:   Fri, 25 Jan 2019 18:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <86pnsm8jon.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

Thanks for your suggestions, I'm working on v4 and I would like to ask 
if it is better to have a driver for only one irqchip

and create dt nodes for each chip, or just register all the chips in a 
single driver with only one dt node.

ÔÚ 2019/1/24 ÏÂÎç5:54, Marc Zyngier Ð´µÀ:
> On Thu, 24 Jan 2019 03:27:29 +0000,
> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> This controller appeared on Loongson-1 family MCUs
>> including Loongson-1B and Loongson-1C.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   drivers/irqchip/Kconfig    |   9 ++
>>   drivers/irqchip/Makefile   |   1 +
>>   drivers/irqchip/irq-ls1x.c | 176 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 186 insertions(+)
>>   create mode 100644 drivers/irqchip/irq-ls1x.c
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 3d1e60779078..5dcb5456cd14 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -406,6 +406,15 @@ config IMX_IRQSTEER
>>   	help
>>   	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
>>   
>> +config LS1X_IRQ
>> +	bool "Loongson-1 Interrupt Controller"
>> +	depends on MACH_LOONGSON32
>> +	default y
>> +	select IRQ_DOMAIN
>> +	select GENERIC_IRQ_CHIP
>> +	help
>> +	  Support for the Loongson-1 platform Interrupt Controller.
>> +
>>   endmenu
>>   
>>   config SIFIVE_PLIC
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index c93713d24b86..7acd0e36d0b4 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
>>   obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>>   obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>>   obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>> +obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>> diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
>> new file mode 100644
>> index 000000000000..de92ca04cf9f
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ls1x.c
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2019, Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + *  Loongson-1 platform IRQ support
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/ioport.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/io.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +
>> +#include <asm/mach-loongson32/irq.h>
>> +
>> +
>> +#define MAX_CHIPS	5
>> +#define LS_REG_INTC_STATUS	0x00
>> +#define LS_REG_INTC_EN	0x04
>> +#define LS_REG_INTC_SET	0x08
>> +#define LS_REG_INTC_CLR	0x0c
>> +#define LS_REG_INTC_POL	0x10
>> +#define LS_REG_INTC_EDGE	0x14
>> +#define CHIP_SIZE	0x18
>> +
>> +static void ls_chained_handle_irq(struct irq_desc *desc)
>> +{
>> +	struct irq_chip_generic *gc = irq_desc_get_handler_data(desc);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	u32 pending;
>> +
>> +	chained_irq_enter(chip, desc);
>> +	pending = readl(gc->reg_base + LS_REG_INTC_STATUS) &
>> +			readl(gc->reg_base + LS_REG_INTC_EN);
>> +
>> +	if (!pending) {
>> +		spurious_interrupt();
>> +		chained_irq_exit(chip, desc);
>> +		return;
>> +	}
> Given the context, this is the same as writing:
>
> 	if (!pending)
> 		spurious_interrupt();
>
> and let it go through.
>
>> +
>> +	while (pending) {
>> +		int bit = __ffs(pending);
>> +
>> +		generic_handle_irq(gc->irq_base + bit);
>> +		pending &= ~BIT(bit);
>> +	}
>> +
>> +	chained_irq_exit(chip, desc);
>> +}
>> +
>> +static void ls_intc_set_bit(struct irq_chip_generic *gc,
>> +							unsigned int offset,
>> +							u32 mask, bool set)
>> +{
>> +	if (set)
>> +		writel(readl(gc->reg_base + offset) | mask,
>> +		gc->reg_base + offset);
>> +	else
>> +		writel(readl(gc->reg_base + offset) & ~mask,
>> +		gc->reg_base + offset);
>> +}
>> +
>> +static int ls_intc_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +	u32 mask = data->mask;
>> +
>> +	switch (type) {
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
>> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
>> +		break;
>> +	case IRQ_TYPE_LEVEL_LOW:
>> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
>> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
>> +		break;
>> +	case IRQ_TYPE_EDGE_RISING:
>> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
>> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
>> +		break;
>> +	case IRQ_TYPE_EDGE_FALLING:
>> +		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
>> +		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
>> +		break;
>> +	case IRQ_TYPE_NONE:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> I just realised that in your DT binding, you define the interrupt
> specifier as having a single cell. Which means that you never describe
> the interrupt trigger there. Why?
>
> Does it mean that all the drivers have to configure their interrupt
> trigger themselves, and cannot rely on DT to do it? This seems quite
> backward.

My fault, will fix it later.

>
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static int __init ls_intc_of_init(struct device_node *node,
>> +				       struct device_node *parent)
>> +{
>> +	struct irq_chip_generic *gc[MAX_CHIPS];
>> +	struct irq_chip_type *ct;
>> +	struct irq_domain *domain;
>> +	void __iomem *base;
>> +	int parent_irq[MAX_CHIPS], err = 0;
>> +	unsigned int i = 0;
>> +
>> +	unsigned int num_chips = of_irq_count(node);
>> +
>> +	base = of_iomap(node, 0);
>> +	if (!base)
>> +		return -ENODEV;
>> +
>> +	for (i = 0; i < num_chips; i++) {
>> +		/* Mask all irqs */
>> +		writel(0x0, base + (i * CHIP_SIZE) +
>> +		       LS_REG_INTC_EN);
>> +
>> +		/* Set all irqs to high level triggered */
>> +		writel(0xffffffff, base + (i * CHIP_SIZE) +
>> +		       LS_REG_INTC_POL);
>> +
>> +		parent_irq[i] = irq_of_parse_and_map(node, i);
>> +
>> +		if (!parent_irq[i]) {
>> +			pr_warn("unable to get parent irq for irqchip %u\n", i);
>> +			goto out_err;
>> +		}
>> +
>> +		gc[i] = irq_alloc_generic_chip("INTC", 1,
>> +					    LS1X_IRQ_BASE + (i * 32),
>> +					    base + (i * CHIP_SIZE),
>> +					    handle_level_irq);
>> +
>> +		ct = gc[i]->chip_types;
>> +		ct->regs.mask = LS_REG_INTC_EN;
>> +		ct->regs.ack = LS_REG_INTC_CLR;
>> +		ct->chip.irq_unmask = irq_gc_mask_set_bit;
>> +		ct->chip.irq_mask = irq_gc_mask_clr_bit;
>> +		ct->chip.irq_ack = irq_gc_ack_set_bit;
>> +		ct->chip.irq_set_type = ls_intc_set_type;
>> +
>> +		irq_setup_generic_chip(gc[i], IRQ_MSK(32), 0, 0,
>> +				       IRQ_NOPROBE | IRQ_LEVEL);
>> +	}
>> +
>> +	domain = irq_domain_add_legacy(node, num_chips * 32, LS1X_IRQ_BASE, 0,
>> +		&irq_domain_simple_ops, NULL);
> Why a legacy domain? This is usually reserved to old drivers that are
> converted to a new infrastructure, while needing some form of platform
> hacks. I don't see this being the case here.
>
> It is also worrying that although you have up to 5 irqchips, they all
> share a single domain. What does this mean? each irqchip is expected
> to have its own domain.

Yes, I do like this for backward compatible reason. I'm turning

a legacy platform device mach(arch/mips/loongson32) in to

dt based generic mach and I would like to do it step by step rather than 
one time.

So I use legacy domain in order to keep IRQ same with the

old driver exist on arch/mips/loongson32/common/irq.c

>> +	if (!domain) {
>> +		pr_warn("unable to register IRQ domain\n");
>> +		err = -EINVAL;
>> +		goto out_err;
>> +	}
>> +
>> +	for (i = 0; i < num_chips; i++)
>> +		irq_set_chained_handler_and_data(parent_irq[i],
>> +		ls_chained_handle_irq, gc[i]);
>> +
>> +	pr_info("ls1x-irq: %u chips registered\n", num_chips);
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	for (i = 0; i < MAX_CHIPS; i++) {
>> +		if (gc[i])
> But you've never initialised gc[], nor parent_irq[]. So you'll get
> whatever the stack had at this point. Not great.
>
>> +			irq_destroy_generic_chip(gc[i], IRQ_MSK(32),
>> +				       IRQ_NOPROBE | IRQ_LEVEL, 0);
>> +		if (parent_irq[i])
>> +			irq_dispose_mapping(parent_irq[i]);
>> +	}
>> +	return err;
>> +}
>> +
>> +IRQCHIP_DECLARE(ls1x_intc, "loongson,ls1x-intc", ls_intc_of_init);
>> -- 
>> 2.20.1
>>
> Thanks,
>
> 	M.
>
