Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D79E2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D79E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeKTEVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:21:50 -0500
Received: from foss.arm.com ([217.140.101.70]:36530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbeKTEVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:21:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB6A1596;
        Mon, 19 Nov 2018 09:57:16 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E07BD3F5B7;
        Mon, 19 Nov 2018 09:57:13 -0800 (PST)
Subject: Re: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com>
Date:   Mon, 19 Nov 2018 17:57:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 17:09, Manivannan Sadhasivam wrote:
> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> and HWTIMER.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/mach-rda/Kconfig       |   1 +
>  drivers/clocksource/Kconfig     |   7 ++
>  drivers/clocksource/Makefile    |   1 +
>  drivers/clocksource/timer-rda.c | 187 ++++++++++++++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/clocksource/timer-rda.c
> 
> diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> index 29012bc68ca4..1ea753f57b2d 100644
> --- a/arch/arm/mach-rda/Kconfig
> +++ b/arch/arm/mach-rda/Kconfig
> @@ -4,5 +4,6 @@ menuconfig ARCH_RDA
>  	select COMMON_CLK
>  	select GENERIC_IRQ_CHIP
>  	select RDA_INTC
> +	select RDA_TIMER
>  	help
>  	  This enables support for the RDA Micro 8810PL SoC family.
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 55c77e44bb2d..f51eee3a72ea 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -105,6 +105,13 @@ config OWL_TIMER
>  	help
>  	  Enables the support for the Actions Semi Owl timer driver.
>  
> +config RDA_TIMER
> +	bool "RDA timer driver" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS
> +	select CLKSRC_MMIO
> +	help
> +	  Enables the support for the RDA Micro timer driver.
> +
>  config SUN4I_TIMER
>  	bool "Sun4i timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dd9138104568..150020a90707 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
>  obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
>  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
>  obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
> +obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
>  
>  obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
>  obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
> diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
> new file mode 100644
> index 000000000000..3aa684d92c5d
> --- /dev/null
> +++ b/drivers/clocksource/timer-rda.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RDA8810PL SoC timer driver
> + *
> + * Copyright RDA Microelectronics Company Limited
> + * Copyright (c) 2017 Andreas Färber
> + * Copyright (c) 2018 Manivannan Sadhasivam
> + */
> +
> +#include <linux/clockchips.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define RDA_OSTIMER_LOADVAL_L	0x000
> +#define RDA_OSTIMER_CTRL	0x004
> +#define RDA_HWTIMER_LOCKVAL_L	0x024
> +#define RDA_HWTIMER_LOCKVAL_H	0x028
> +#define RDA_TIMER_IRQ_MASK_SET	0x02c
> +#define RDA_TIMER_IRQ_CLR	0x034
> +
> +#define RDA_OSTIMER_CTRL_ENABLE		BIT(24)
> +#define RDA_OSTIMER_CTRL_REPEAT		BIT(28)
> +#define RDA_OSTIMER_CTRL_LOAD		BIT(30)
> +
> +#define RDA_TIMER_IRQ_MASK_SET_OSTIMER	BIT(0)
> +
> +#define RDA_TIMER_IRQ_CLR_OSTIMER	BIT(0)
> +
> +static void __iomem *rda_timer_base;
> +
> +static u64 rda_hwtimer_read(struct clocksource *cs)
> +{
> +	u32 lo, hi;
> +
> +	/* Always read low 32 bits first */
> +	lo = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_L);
> +	hi = readl(rda_timer_base + RDA_HWTIMER_LOCKVAL_H);

Please use the relaxed accessors throughout this driver. There is zero
reason to use the non-relaxed versions here.

Now, I'm pretty sure this thing isn't correct.

	<timer = 0x00000000ffffffff>
	lo = 0xffffffff;
	<tick, timer = 0x0000000100000000>
	hi = 0x00000001;

Bingo. You cannot read a 64bit counter with only two 32bit accesses.

> +
> +	return ((u64)hi << 32) | lo;
> +}
> +
> +static struct clocksource rda_clocksource = {
> +	.name           = "rda-timer",
> +	.rating         = 400,
> +	.read           = rda_hwtimer_read,
> +	.mask           = CLOCKSOURCE_MASK(64),

This is a 64bit counter? See below.

> +	.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static int rda_ostimer_start(bool periodic, u64 cycles)
> +{
> +	u32 ctrl, load_l;
> +
> +	load_l = (u32)cycles;
> +	ctrl = ((cycles >> 32) & 0xffffff);
> +	ctrl |= RDA_OSTIMER_CTRL_LOAD | RDA_OSTIMER_CTRL_ENABLE;
> +	if (periodic)
> +		ctrl |= RDA_OSTIMER_CTRL_REPEAT;
> +
> +	/* Enable ostimer interrupt first */
> +	writel(RDA_TIMER_IRQ_MASK_SET_OSTIMER,
> +	       rda_timer_base + RDA_TIMER_IRQ_MASK_SET);

Is it masking or enabling the interrupt?

> +
> +	/* Write low 32 bits first, high 24 bits are with ctrl */

You're saying that you can only write 56 bits? This contradicts the 64bt
counter thing above.

> +	writel(load_l, rda_timer_base + RDA_OSTIMER_LOADVAL_L);
> +	writel(ctrl, rda_timer_base + RDA_OSTIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_stop(void)
> +{
> +	/* Disable ostimer interrupt first */
> +	writel(0, rda_timer_base + RDA_TIMER_IRQ_MASK_SET);
> +
> +	writel(0, rda_timer_base + RDA_OSTIMER_CTRL);
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	rda_ostimer_stop();
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	rda_ostimer_stop();
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_state_periodic(struct clock_event_device *evt)
> +{
> +	unsigned long cycles_per_jiffy;
> +
> +	rda_ostimer_stop();
> +
> +	cycles_per_jiffy = ((unsigned long long)NSEC_PER_SEC / HZ *
> +			     evt->mult) >> evt->shift;
> +	rda_ostimer_start(true, cycles_per_jiffy);
> +
> +	return 0;
> +}
> +
> +static int rda_ostimer_tick_resume(struct clock_event_device *evt)
> +{
> +	return 0;
> +}
> +
> +static int rda_ostimer_set_next_event(unsigned long evt,
> +				      struct clock_event_device *ev)
> +{
> +	rda_ostimer_start(false, evt);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device rda_clockevent = {
> +	.name			= "rda-ostimer",
> +	.rating			= 250,
> +	.features		= CLOCK_EVT_FEAT_PERIODIC |
> +				  CLOCK_EVT_FEAT_ONESHOT |
> +				  CLOCK_EVT_FEAT_DYNIRQ,
> +	.set_state_shutdown	= rda_ostimer_set_state_shutdown,
> +	.set_state_oneshot	= rda_ostimer_set_state_oneshot,
> +	.set_state_periodic	= rda_ostimer_set_state_periodic,
> +	.tick_resume		= rda_ostimer_tick_resume,
> +	.set_next_event		= rda_ostimer_set_next_event,
> +};
> +
> +static irqreturn_t rda_ostimer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +
> +	/* clear timer int */
> +	writel(RDA_TIMER_IRQ_CLR_OSTIMER, rda_timer_base + RDA_TIMER_IRQ_CLR);
> +
> +	if (evt->event_handler)
> +		evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init rda_timer_init(struct device_node *node)
> +{
> +	unsigned long rate = 2000000;
> +	int ostimer_irq, ret;
> +
> +	rda_timer_base = of_io_request_and_map(node, 0, "rda-timer");
> +	if (IS_ERR(rda_timer_base)) {
> +		pr_err("Can't map timer registers");
> +		return PTR_ERR(rda_timer_base);
> +	}
> +
> +	ostimer_irq = of_irq_get_byname(node, "ostimer");
> +	if (ostimer_irq <= 0) {
> +		pr_err("Can't parse ostimer IRQ");
> +		return -EINVAL;

Leaking IO space.

> +	}
> +
> +	clocksource_register_hz(&rda_clocksource, rate);
> +
> +	ret = request_irq(ostimer_irq, rda_ostimer_interrupt, IRQF_TIMER,
> +			  "rda-ostimer", &rda_clockevent);
> +	if (ret) {
> +		pr_err("failed to request irq %d\n", ostimer_irq);
> +		return ret;

Same here.

> +	}
> +
> +	irq_force_affinity(ostimer_irq, cpumask_of(0));

Why?

> +
> +	rda_clockevent.cpumask = cpumask_of(0);
> +	rda_clockevent.irq = ostimer_irq;
> +	clockevents_config_and_register(&rda_clockevent, rate,
> +					0x2, 0xffffffff);
> +
> +	return 0;
> +}
> +
> +TIMER_OF_DECLARE(rda8810pl, "rda,8810pl-timer", rda_timer_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
