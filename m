Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDBC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FA420684
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KreJ0rIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfBYXAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:00:19 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45616 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfBYXAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551135613; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/KzxDNax0QGdbpoYNEXQX3hDuqPVfmbRut5rqSVVMU=;
        b=KreJ0rIXj3toBdx3lVX0pcfbespf+xApNtjS04c9ZOV3GFOqmJZiTFAl/2uMbtqMylVAUD
        +q6P0grFUYZv2w6cOLSvKQwfFWkhNz/to3XIpah5CYB00cCs2Ctc24D8HXh4UpoqWWYKZD
        CFiiQ8plsLReoRTXtbI4kZnRKx/FC1M=
Date:   Mon, 25 Feb 2019 19:59:52 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 04/27] clocksource: Add a new timer-ingenic driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <1551135592.24022.0@crapouillou.net>
In-Reply-To: <e50dc1da-6c19-392c-fcb6-0067b9632c00@linaro.org>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-5-paul@crapouillou.net>
        <e50dc1da-6c19-392c-fcb6-0067b9632c00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 25 f=C3=A9vr. 2019 =C3=A0 12:55, Daniel Lezcano=20
<daniel.lezcano@linaro.org> a =C3=A9crit :
> Hi Paul,
>=20
> sorry for the delay but this driver requires a bit more of attention.
>=20
> Overall I disagree the driver because of its complexity. We should not
> see that for this driver.

What's complex in this driver?

> Did you check if using node alias to specify the clocksource and the
> clockevent can fit your need.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clocksource/timer-integrator-ap.c#n199
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/integratorap.dts#n49

I'd have nothing to point the aliases to. The driver does not expose=20
individual
timers.

I thought we were good with the ingenic,pwm-channels-mask property, I
got Rob to ack the bindings and the driver is much simpler than what it
was some revisions ago. Why change it again?

> On 27/12/2018 19:12, Paul Cercueil wrote:
>>  This driver handles the TCU (Timer Counter Unit) present on the=20
>> Ingenic
>>  JZ47xx SoCs, and provides the kernel with a system timer, and=20
>> optionally
>>  with a clocksource and a sched_clock.
>>=20
>>  It also provides clocks and interrupt handling to client drivers.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v2: Use SPDX identifier for the license
>>=20
>>       v3: - Move documentation to its own patch
>>           - Search the devicetree for PWM clients, and use all the=20
>> TCU
>>      	   channels that won't be used for PWM
>>=20
>>       v4: - Add documentation about why we search for PWM clients
>>           - Verify that the PWM clients are for the TCU PWM driver
>>=20
>>       v5: Major overhaul. Too many changes to list. Consider it's a=20
>> new
>>           patch.
>>=20
>>       v6: - Add two API functions ingenic_tcu_request_channel and
>>             ingenic_tcu_release_channel. To be used by the PWM=20
>> driver to
>>             request the use of a TCU channel. The driver will now=20
>> dynamically
>>             move away the system timer or clocksource to a new TCU=20
>> channel.
>>           - The system timer now defaults to channel 0, the=20
>> clocksource now
>>             defaults to channel 1 and is no more optional. The
>>             ingenic,timer-channel and ingenic,clocksource-channel=20
>> devicetree
>>             properties are now gone.
>>           - Fix round_rate / set_rate not calculating the prescale=20
>> divider
>>             the same way. This caused problems when (parent_rate /=20
>> div) would
>>             give a non-integer result. The behaviour is correct now.
>>           - The clocksource clock is turned off on suspend now.
>>=20
>>       v7: Fix section mismatch by using=20
>> builtin_platform_driver_probe()
>>=20
>>       v8: - Removed ingenic_tcu_[request,release]_channel, and the=20
>> mechanism
>>             to dynamically change the TCU channel of the system=20
>> timer or
>>  	   the clocksource.
>>  	 - The driver's devicetree node can now have two more children
>>  	   nodes, that correspond to the system timer and clocksource.
>>  	   For these two, the driver will use the TCU timer that
>>  	   correspond to the memory resource supplied in their
>>  	   respective node.
>>=20
>>       v9: - Removed support for clocksource / timer children=20
>> devicetree
>>             nodes. Now, we use a property=20
>> "ingenic,pwm-channels-mask" to
>>  	   know which PWM channels are reserved for PWM use and should
>>  	   not be used as OS timers.
>>=20
>>   drivers/clocksource/Kconfig         |  10 +
>>   drivers/clocksource/Makefile        |   1 +
>>   drivers/clocksource/ingenic-timer.c | 901=20
>> ++++++++++++++++++++++++++++++++++++
>>   drivers/clocksource/ingenic-timer.h |  15 +
>>   include/linux/mfd/ingenic-tcu.h     |   2 +
>>   5 files changed, 929 insertions(+)
>>   create mode 100644 drivers/clocksource/ingenic-timer.c
>>   create mode 100644 drivers/clocksource/ingenic-timer.h
>>=20
>>  diff --git a/drivers/clocksource/Kconfig=20
>> b/drivers/clocksource/Kconfig
>>  index 55c77e44bb2d..4e69af15c3e7 100644
>>  --- a/drivers/clocksource/Kconfig
>>  +++ b/drivers/clocksource/Kconfig
>>  @@ -638,4 +638,14 @@ config GX6605S_TIMER
>>   	help
>>   	  This option enables support for gx6605s SOC's timer.
>>=20
>>  +config INGENIC_TIMER
>>  +	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
>>  +	depends on MIPS || COMPILE_TEST
>>  +	depends on COMMON_CLK
>>  +	select TIMER_OF
>>  +	select IRQ_DOMAIN
>>  +	select REGMAP
>>  +	help
>>  +	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>>  +
>>   endmenu
>>  diff --git a/drivers/clocksource/Makefile=20
>> b/drivers/clocksource/Makefile
>>  index dd9138104568..7c8f790dcf67 100644
>>  --- a/drivers/clocksource/Makefile
>>  +++ b/drivers/clocksource/Makefile
>>  @@ -75,6 +75,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+=3D asm9260_timer.o
>>   obj-$(CONFIG_H8300_TMR8)		+=3D h8300_timer8.o
>>   obj-$(CONFIG_H8300_TMR16)		+=3D h8300_timer16.o
>>   obj-$(CONFIG_H8300_TPU)			+=3D h8300_tpu.o
>>  +obj-$(CONFIG_INGENIC_TIMER)		+=3D ingenic-timer.o
>>   obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
>>   obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
>>   obj-$(CONFIG_ATCPIT100_TIMER)		+=3D timer-atcpit100.o
>>  diff --git a/drivers/clocksource/ingenic-timer.c=20
>> b/drivers/clocksource/ingenic-timer.c
>>  new file mode 100644
>>  index 000000000000..81faa120cfee
>>  --- /dev/null
>>  +++ b/drivers/clocksource/ingenic-timer.c
>>  @@ -0,0 +1,901 @@
>>  +// SPDX-License-Identifier: GPL-2.0
>>  +/*
>>  + * JZ47xx SoCs TCU IRQ driver
>>  + * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/bitops.h>
>>  +#include <linux/clk.h>
>>  +#include <linux/clk-provider.h>
>>  +#include <linux/clkdev.h>
>>  +#include <linux/clockchips.h>
>>  +#include <linux/clocksource.h>
>>  +#include <linux/interrupt.h>
>>  +#include <linux/irqchip.h>
>>  +#include <linux/irqchip/chained_irq.h>
>>  +#include <linux/mfd/ingenic-tcu.h>
>>  +#include <linux/of.h>
>>  +#include <linux/of_address.h>
>>  +#include <linux/of_irq.h>
>>  +#include <linux/of_platform.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/regmap.h>
>>  +#include <linux/sched_clock.h>
>>  +
>>  +#include <dt-bindings/clock/ingenic,tcu.h>
>>  +
>>  +#include "ingenic-timer.h"
>>  +
>>  +/* 8 channels max + watchdog + OST */
>>  +#define TCU_CLK_COUNT	10
>>  +
>>  +enum tcu_clk_parent {
>>  +	TCU_PARENT_PCLK,
>>  +	TCU_PARENT_RTC,
>>  +	TCU_PARENT_EXT,
>>  +};
>>  +
>>  +struct ingenic_soc_info {
>>  +	unsigned char num_channels;
>>  +	bool has_ost;
>>  +};
>>  +
>>  +struct ingenic_tcu_clk_info {
>>  +	struct clk_init_data init_data;
>>  +	u8 gate_bit;
>>  +	u8 tcsr_reg;
>>  +};
>>  +
>>  +struct ingenic_tcu_clk {
>>  +	struct clk_hw hw;
>>  +
>>  +	struct regmap *map;
>>  +	const struct ingenic_tcu_clk_info *info;
>>  +
>>  +	unsigned int idx;
>>  +};
>>  +
>>  +#define to_tcu_clk(_hw) container_of(_hw, struct ingenic_tcu_clk,=20
>> hw)
>>  +
>>  +struct ingenic_tcu {
>>  +	const struct ingenic_soc_info *soc_info;
>>  +	struct regmap *map;
>>  +	struct clk *clk, *timer_clk, *cs_clk;
>>  +
>>  +	struct irq_domain *domain;
>>  +	unsigned int nb_parent_irqs;
>>  +	u32 parent_irqs[3];
>>  +
>>  +	struct clk_hw_onecell_data *clocks;
>>  +
>>  +	unsigned int timer_channel, cs_channel;
>>  +	struct clock_event_device cevt;
>>  +	struct clocksource cs;
>>  +	char name[4];
>>  +
>>  +	unsigned long pwm_channels_mask;
>>  +};
>>  +
>>  +static struct ingenic_tcu *ingenic_tcu;
>>  +
>>  +void __iomem *ingenic_tcu_base;
>>  +EXPORT_SYMBOL_GPL(ingenic_tcu_base);
>>  +
>>  +static int ingenic_tcu_enable(struct clk_hw *hw)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +
>>  +	regmap_write(tcu_clk->map, TCU_REG_TSCR, BIT(info->gate_bit));
>>  +	return 0;
>>  +}
>>  +
>>  +static void ingenic_tcu_disable(struct clk_hw *hw)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +
>>  +	regmap_write(tcu_clk->map, TCU_REG_TSSR, BIT(info->gate_bit));
>>  +}
>>  +
>>  +static int ingenic_tcu_is_enabled(struct clk_hw *hw)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +	unsigned int value;
>>  +
>>  +	regmap_read(tcu_clk->map, TCU_REG_TSR, &value);
>>  +
>>  +	return !(value & BIT(info->gate_bit));
>>  +}
>>  +
>>  +static u8 ingenic_tcu_get_parent(struct clk_hw *hw)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +	unsigned int val =3D 0;
>>  +	int ret;
>>  +
>>  +	ret =3D regmap_read(tcu_clk->map, info->tcsr_reg, &val);
>>  +	WARN_ONCE(ret < 0, "Unable to read TCSR %i", tcu_clk->idx);
>>  +
>>  +	return ffs(val & TCU_TCSR_PARENT_CLOCK_MASK) - 1;
>>  +}
>>  +
>>  +static int ingenic_tcu_set_parent(struct clk_hw *hw, u8 idx)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +	struct regmap *map =3D tcu_clk->map;
>>  +	int ret;
>>  +
>>  +	/*
>>  +	 * Our clock provider has the CLK_SET_PARENT_GATE flag set, so we=20
>> know
>>  +	 * that the clk is in unprepared state. To be able to access TCSR
>>  +	 * we must ungate the clock supply and we gate it again when done.
>>  +	 */
>>  +
>>  +	regmap_write(map, TCU_REG_TSCR, BIT(info->gate_bit));
>>  +
>>  +	ret =3D regmap_update_bits(map, info->tcsr_reg,
>>  +				TCU_TCSR_PARENT_CLOCK_MASK, BIT(idx));
>>  +	WARN_ONCE(ret < 0, "Unable to update TCSR %i", tcu_clk->idx);
>>  +
>>  +	regmap_write(map, TCU_REG_TSSR, BIT(info->gate_bit));
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static unsigned long ingenic_tcu_recalc_rate(struct clk_hw *hw,
>>  +		unsigned long parent_rate)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +	unsigned int prescale;
>>  +	int ret;
>>  +
>>  +	ret =3D regmap_read(tcu_clk->map, info->tcsr_reg, &prescale);
>>  +	WARN_ONCE(ret < 0, "Unable to read TCSR %i", tcu_clk->idx);
>>  +
>>  +	prescale =3D (prescale & TCU_TCSR_PRESCALE_MASK) >>=20
>> TCU_TCSR_PRESCALE_LSB;
>>  +
>>  +	return parent_rate >> (prescale * 2);
>>  +}
>>  +
>>  +static u8 ingenic_tcu_get_prescale(unsigned long rate, unsigned=20
>> long req_rate)
>>  +{
>>  +	u8 prescale;
>>  +
>>  +	for (prescale =3D 0; prescale < 5; prescale++)
>>  +		if ((rate >> (prescale * 2)) <=3D req_rate)
>>  +			return prescale;
>>  +
>>  +	return 5; /* /1024 divider */
>>  +}
>>  +
>>  +static long ingenic_tcu_round_rate(struct clk_hw *hw, unsigned=20
>> long req_rate,
>>  +		unsigned long *parent_rate)
>>  +{
>>  +	unsigned long rate =3D *parent_rate;
>>  +	u8 prescale;
>>  +
>>  +	if (req_rate > rate)
>>  +		return -EINVAL;
>>  +
>>  +	prescale =3D ingenic_tcu_get_prescale(rate, req_rate);
>>  +	return rate >> (prescale * 2);
>>  +}
>>  +
>>  +static int ingenic_tcu_set_rate(struct clk_hw *hw, unsigned long=20
>> req_rate,
>>  +		unsigned long parent_rate)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk =3D to_tcu_clk(hw);
>>  +	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>>  +	struct regmap *map =3D tcu_clk->map;
>>  +	u8 prescale =3D ingenic_tcu_get_prescale(parent_rate, req_rate);
>>  +	int ret;
>>  +
>>  +	/*
>>  +	 * Our clock provider has the CLK_SET_RATE_GATE flag set, so we=20
>> know
>>  +	 * that the clk is in unprepared state. To be able to access TCSR
>>  +	 * we must ungate the clock supply and we gate it again when done.
>>  +	 */
>>  +
>>  +	regmap_write(map, TCU_REG_TSCR, BIT(info->gate_bit));
>>  +
>>  +	ret =3D regmap_update_bits(map, info->tcsr_reg,
>>  +				TCU_TCSR_PRESCALE_MASK,
>>  +				prescale << TCU_TCSR_PRESCALE_LSB);
>>  +	WARN_ONCE(ret < 0, "Unable to update TCSR %i", tcu_clk->idx);
>>  +
>>  +	regmap_write(map, TCU_REG_TSSR, BIT(info->gate_bit));
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static const struct clk_ops ingenic_tcu_clk_ops =3D {
>>  +	.get_parent	=3D ingenic_tcu_get_parent,
>>  +	.set_parent	=3D ingenic_tcu_set_parent,
>>  +
>>  +	.recalc_rate	=3D ingenic_tcu_recalc_rate,
>>  +	.round_rate	=3D ingenic_tcu_round_rate,
>>  +	.set_rate	=3D ingenic_tcu_set_rate,
>>  +
>>  +	.enable		=3D ingenic_tcu_enable,
>>  +	.disable	=3D ingenic_tcu_disable,
>>  +	.is_enabled	=3D ingenic_tcu_is_enabled,
>>  +};
>>  +
>>  +static const char * const ingenic_tcu_timer_parents[] =3D {
>>  +	[TCU_PARENT_PCLK] =3D "pclk",
>>  +	[TCU_PARENT_RTC]  =3D "rtc",
>>  +	[TCU_PARENT_EXT]  =3D "ext",
>>  +};
>>  +
>>  +#define DEF_TIMER(_name, _gate_bit, _tcsr)				\
>>  +	{								\
>>  +		.init_data =3D {						\
>>  +			.name =3D _name,					\
>>  +			.parent_names =3D ingenic_tcu_timer_parents,	\
>>  +			.num_parents =3D ARRAY_SIZE(ingenic_tcu_timer_parents),\
>>  +			.ops =3D &ingenic_tcu_clk_ops,			\
>>  +			.flags =3D CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE,\
>>  +		},							\
>>  +		.gate_bit =3D _gate_bit,					\
>>  +		.tcsr_reg =3D _tcsr,					\
>>  +	}
>>  +static const struct ingenic_tcu_clk_info ingenic_tcu_clk_info[] =3D {
>>  +	[TCU_CLK_TIMER0] =3D DEF_TIMER("timer0", 0, TCU_REG_TCSRc(0)),
>>  +	[TCU_CLK_TIMER1] =3D DEF_TIMER("timer1", 1, TCU_REG_TCSRc(1)),
>>  +	[TCU_CLK_TIMER2] =3D DEF_TIMER("timer2", 2, TCU_REG_TCSRc(2)),
>>  +	[TCU_CLK_TIMER3] =3D DEF_TIMER("timer3", 3, TCU_REG_TCSRc(3)),
>>  +	[TCU_CLK_TIMER4] =3D DEF_TIMER("timer4", 4, TCU_REG_TCSRc(4)),
>>  +	[TCU_CLK_TIMER5] =3D DEF_TIMER("timer5", 5, TCU_REG_TCSRc(5)),
>>  +	[TCU_CLK_TIMER6] =3D DEF_TIMER("timer6", 6, TCU_REG_TCSRc(6)),
>>  +	[TCU_CLK_TIMER7] =3D DEF_TIMER("timer7", 7, TCU_REG_TCSRc(7)),
>>  +};
>>  +
>>  +static const struct ingenic_tcu_clk_info=20
>> ingenic_tcu_watchdog_clk_info =3D
>>  +				DEF_TIMER("wdt", 16, TCU_REG_WDT_TCSR);
>>  +static const struct ingenic_tcu_clk_info ingenic_tcu_ost_clk_info =3D
>>  +				DEF_TIMER("ost", 15, TCU_REG_OST_TCSR);
>>  +#undef DEF_TIMER
>>  +
>>  +static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
>>  +{
>>  +	struct irq_chip *irq_chip =3D=20
>> irq_data_get_irq_chip(&desc->irq_data);
>>  +	struct irq_domain *domain =3D irq_desc_get_handler_data(desc);
>>  +	struct irq_chip_generic *gc =3D irq_get_domain_generic_chip(domain,=20
>> 0);
>>  +	struct regmap *map =3D gc->private;
>>  +	uint32_t irq_reg, irq_mask;
>>  +	unsigned int i;
>>  +
>>  +	regmap_read(map, TCU_REG_TFR, &irq_reg);
>>  +	regmap_read(map, TCU_REG_TMR, &irq_mask);
>>  +
>>  +	chained_irq_enter(irq_chip, desc);
>>  +
>>  +	irq_reg &=3D ~irq_mask;
>>  +
>>  +	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
>>  +		generic_handle_irq(irq_linear_revmap(domain, i));
>>  +
>>  +	chained_irq_exit(irq_chip, desc);
>>  +}
>>  +
>>  +static void ingenic_tcu_gc_unmask_enable_reg(struct irq_data *d)
>>  +{
>>  +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>>  +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  +	struct regmap *map =3D gc->private;
>>  +	u32 mask =3D d->mask;
>>  +
>>  +	irq_gc_lock(gc);
>>  +	regmap_write(map, ct->regs.ack, mask);
>>  +	regmap_write(map, ct->regs.enable, mask);
>>  +	*ct->mask_cache |=3D mask;
>>  +	irq_gc_unlock(gc);
>>  +}
>>  +
>>  +static void ingenic_tcu_gc_mask_disable_reg(struct irq_data *d)
>>  +{
>>  +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>>  +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  +	struct regmap *map =3D gc->private;
>>  +	u32 mask =3D d->mask;
>>  +
>>  +	irq_gc_lock(gc);
>>  +	regmap_write(map, ct->regs.disable, mask);
>>  +	*ct->mask_cache &=3D ~mask;
>>  +	irq_gc_unlock(gc);
>>  +}
>>  +
>>  +static void ingenic_tcu_gc_mask_disable_reg_and_ack(struct=20
>> irq_data *d)
>>  +{
>>  +	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>>  +	struct irq_chip_type *ct =3D irq_data_get_chip_type(d);
>>  +	struct regmap *map =3D gc->private;
>>  +	u32 mask =3D d->mask;
>>  +
>>  +	irq_gc_lock(gc);
>>  +	regmap_write(map, ct->regs.ack, mask);
>>  +	regmap_write(map, ct->regs.disable, mask);
>>  +	irq_gc_unlock(gc);
>>  +}
>>  +
>>  +static u64 notrace ingenic_tcu_timer_read(void)
>>  +{
>>  +	unsigned int channel =3D ingenic_tcu->cs_channel;
>>  +	u16 count;
>>  +
>>  +	count =3D readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));
>>  +
>>  +	return count;
>>  +}
>>  +
>>  +static inline struct ingenic_tcu *to_ingenic_tcu(struct=20
>> clock_event_device *evt)
>>  +{
>>  +	return container_of(evt, struct ingenic_tcu, cevt);
>>  +}
>>  +
>>  +static int ingenic_tcu_cevt_set_state_shutdown(struct=20
>> clock_event_device *evt)
>>  +{
>>  +	struct ingenic_tcu *tcu =3D to_ingenic_tcu(evt);
>>  +
>>  +	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
>>  +	return 0;
>>  +}
>>  +
>>  +static int ingenic_tcu_cevt_set_next(unsigned long next,
>>  +				     struct clock_event_device *evt)
>>  +{
>>  +	struct ingenic_tcu *tcu =3D to_ingenic_tcu(evt);
>>  +
>>  +	if (next > 0xffff)
>>  +		return -EINVAL;
>>  +
>>  +	regmap_write(tcu->map, TCU_REG_TDFRc(tcu->timer_channel), next);
>>  +	regmap_write(tcu->map, TCU_REG_TCNTc(tcu->timer_channel), 0);
>>  +	regmap_write(tcu->map, TCU_REG_TESR, BIT(tcu->timer_channel));
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
>>  +{
>>  +	struct clock_event_device *evt =3D dev_id;
>>  +	struct ingenic_tcu *tcu =3D to_ingenic_tcu(evt);
>>  +
>>  +	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
>>  +
>>  +	if (evt->event_handler)
>>  +		evt->event_handler(evt);
>>  +
>>  +	return IRQ_HANDLED;
>>  +}
>>  +
>>  +static int __init ingenic_tcu_register_clock(struct ingenic_tcu=20
>> *tcu,
>>  +			unsigned int idx, enum tcu_clk_parent parent,
>>  +			const struct ingenic_tcu_clk_info *info,
>>  +			struct clk_hw_onecell_data *clocks)
>>  +{
>>  +	struct ingenic_tcu_clk *tcu_clk;
>>  +	int err;
>>  +
>>  +	tcu_clk =3D kzalloc(sizeof(*tcu_clk), GFP_KERNEL);
>>  +	if (!tcu_clk)
>>  +		return -ENOMEM;
>>  +
>>  +	tcu_clk->hw.init =3D &info->init_data;
>>  +	tcu_clk->idx =3D idx;
>>  +	tcu_clk->info =3D info;
>>  +	tcu_clk->map =3D tcu->map;
>>  +
>>  +	/* Reset channel and clock divider, set default parent */
>>  +	ingenic_tcu_enable(&tcu_clk->hw);
>>  +	regmap_update_bits(tcu->map, info->tcsr_reg, 0xffff, BIT(parent));
>>  +	ingenic_tcu_disable(&tcu_clk->hw);
>>  +
>>  +	err =3D clk_hw_register(NULL, &tcu_clk->hw);
>>  +	if (err)
>>  +		goto err_free_tcu_clk;
>>  +
>>  +	err =3D clk_hw_register_clkdev(&tcu_clk->hw, info->init_data.name,=20
>> NULL);
>>  +	if (err)
>>  +		goto err_clk_unregister;
>>  +
>>  +	clocks->hws[idx] =3D &tcu_clk->hw;
>>  +	return 0;
>>  +
>>  +err_clk_unregister:
>>  +	clk_hw_unregister(&tcu_clk->hw);
>>  +err_free_tcu_clk:
>>  +	kfree(tcu_clk);
>>  +	return err;
>>  +}
>>  +
>>  +static int __init ingenic_tcu_clk_init(struct ingenic_tcu *tcu,
>>  +				       struct device_node *np)
>>  +{
>>  +	size_t i;
>>  +	int ret;
>>  +
>>  +	tcu->clocks =3D kzalloc(sizeof(*tcu->clocks) +
>>  +			 sizeof(*tcu->clocks->hws) * TCU_CLK_COUNT,
>>  +			 GFP_KERNEL);
>>  +	if (!tcu->clocks)
>>  +		return -ENOMEM;
>>  +
>>  +	tcu->clocks->num =3D TCU_CLK_COUNT;
>>  +
>>  +	for (i =3D 0; i < tcu->soc_info->num_channels; i++) {
>>  +		ret =3D ingenic_tcu_register_clock(tcu, i, TCU_PARENT_EXT,
>>  +				&ingenic_tcu_clk_info[i], tcu->clocks);
>>  +		if (ret) {
>>  +			pr_err("ingenic-timer: cannot register clock %i\n", i);
>>  +			goto err_unregister_timer_clocks;
>>  +		}
>>  +	}
>>  +
>>  +	/*
>>  +	 * We set EXT as the default parent clock for all the TCU clocks
>>  +	 * except for the watchdog one, where we set the RTC clock as the
>>  +	 * parent. Since the EXT and PCLK are much faster than the RTC=20
>> clock,
>>  +	 * the watchdog would kick after a maximum time of 5s, and we=20
>> might
>>  +	 * want a slower kicking time.
>>  +	 */
>>  +	ret =3D ingenic_tcu_register_clock(tcu, TCU_CLK_WDT, TCU_PARENT_RTC,
>>  +				&ingenic_tcu_watchdog_clk_info, tcu->clocks);
>>  +	if (ret) {
>>  +		pr_err("ingenic-timer: cannot register watchdog clock\n");
>>  +		goto err_unregister_timer_clocks;
>>  +	}
>>  +
>>  +	if (tcu->soc_info->has_ost) {
>>  +		ret =3D ingenic_tcu_register_clock(tcu, TCU_CLK_OST,
>>  +					TCU_PARENT_EXT,
>>  +					&ingenic_tcu_ost_clk_info,
>>  +					tcu->clocks);
>>  +		if (ret) {
>>  +			pr_err("ingenic-timer: cannot register ost clock\n");
>>  +			goto err_unregister_watchdog_clock;
>>  +		}
>>  +	}
>>  +
>>  +	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get,=20
>> tcu->clocks);
>>  +	if (ret) {
>>  +		pr_err("ingenic-timer: cannot add OF clock provider\n");
>>  +		goto err_unregister_ost_clock;
>>  +	}
>>  +
>>  +	return 0;
>>  +
>>  +err_unregister_ost_clock:
>>  +	if (tcu->soc_info->has_ost)
>>  +		clk_hw_unregister(tcu->clocks->hws[i + 1]);
>>  +err_unregister_watchdog_clock:
>>  +	clk_hw_unregister(tcu->clocks->hws[i]);
>>  +err_unregister_timer_clocks:
>>  +	for (i =3D 0; i < tcu->clocks->num; i++)
>>  +		if (tcu->clocks->hws[i])
>>  +			clk_hw_unregister(tcu->clocks->hws[i]);
>>  +	kfree(tcu->clocks);
>>  +	return ret;
>>  +}
>>  +
>>  +static void __init ingenic_tcu_clk_cleanup(struct ingenic_tcu *tcu,
>>  +					   struct device_node *np)
>>  +{
>>  +	unsigned int i;
>>  +
>>  +	of_clk_del_provider(np);
>>  +
>>  +	for (i =3D 0; i < tcu->clocks->num; i++)
>>  +		clk_hw_unregister(tcu->clocks->hws[i]);
>>  +	kfree(tcu->clocks);
>>  +}
>>  +
>>  +static int __init ingenic_tcu_intc_init(struct ingenic_tcu *tcu,
>>  +					struct device_node *np)
>>  +{
>>  +	struct irq_chip_generic *gc;
>>  +	struct irq_chip_type *ct;
>>  +	int err, i, irqs;
>>  +
>>  +	irqs =3D of_property_count_elems_of_size(np, "interrupts",=20
>> sizeof(u32));
>>  +	if (irqs < 0 || irqs > ARRAY_SIZE(tcu->parent_irqs))
>>  +		return -EINVAL;
>>  +
>>  +	tcu->nb_parent_irqs =3D irqs;
>>  +
>>  +	tcu->domain =3D irq_domain_add_linear(np, 32,
>>  +			&irq_generic_chip_ops, NULL);
>>  +	if (!tcu->domain)
>>  +		return -ENOMEM;
>>  +
>>  +	err =3D irq_alloc_domain_generic_chips(tcu->domain, 32, 1, "TCU",
>>  +			handle_level_irq, 0, IRQ_NOPROBE | IRQ_LEVEL, 0);
>>  +	if (err)
>>  +		goto out_domain_remove;
>>  +
>>  +	gc =3D irq_get_domain_generic_chip(tcu->domain, 0);
>>  +	ct =3D gc->chip_types;
>>  +
>>  +	gc->wake_enabled =3D IRQ_MSK(32);
>>  +	gc->private =3D tcu->map;
>>  +
>>  +	ct->regs.disable =3D TCU_REG_TMSR;
>>  +	ct->regs.enable =3D TCU_REG_TMCR;
>>  +	ct->regs.ack =3D TCU_REG_TFCR;
>>  +	ct->chip.irq_unmask =3D ingenic_tcu_gc_unmask_enable_reg;
>>  +	ct->chip.irq_mask =3D ingenic_tcu_gc_mask_disable_reg;
>>  +	ct->chip.irq_mask_ack =3D ingenic_tcu_gc_mask_disable_reg_and_ack;
>>  +	ct->chip.flags =3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
>>  +
>>  +	/* Mask all IRQs by default */
>>  +	regmap_write(tcu->map, TCU_REG_TMSR, IRQ_MSK(32));
>>  +
>>  +	/* On JZ4740, timer 0 and timer 1 have their own interrupt line;
>>  +	 * timers 2-7 share one interrupt.
>>  +	 * On SoCs >=3D JZ4770, timer 5 has its own interrupt line;
>>  +	 * timers 0-4 and 6-7 share one single interrupt.
>>  +	 *
>>  +	 * To keep things simple, we just register the same handler to
>>  +	 * all parent interrupts. The handler will properly detect which
>>  +	 * channel fired the interrupt.
>>  +	 */
>>  +	for (i =3D 0; i < irqs; i++) {
>>  +		tcu->parent_irqs[i] =3D irq_of_parse_and_map(np, i);
>>  +		if (!tcu->parent_irqs[i]) {
>>  +			err =3D -EINVAL;
>>  +			goto out_unmap_irqs;
>>  +		}
>>  +
>>  +		irq_set_chained_handler_and_data(tcu->parent_irqs[i],
>>  +				ingenic_tcu_intc_cascade, tcu->domain);
>>  +	}
>>  +
>>  +	return 0;
>>  +
>>  +out_unmap_irqs:
>>  +	for (; i > 0; i--)
>>  +		irq_dispose_mapping(tcu->parent_irqs[i - 1]);
>>  +out_domain_remove:
>>  +	irq_domain_remove(tcu->domain);
>>  +	return err;
>>  +}
>>  +
>>  +static void __init ingenic_tcu_intc_cleanup(struct ingenic_tcu=20
>> *tcu)
>>  +{
>>  +	unsigned int i;
>>  +
>>  +	for (i =3D 0; i < tcu->nb_parent_irqs; i++)
>>  +		irq_dispose_mapping(tcu->parent_irqs[i]);
>>  +
>>  +	irq_domain_remove(tcu->domain);
>>  +}
>>  +
>>  +static int __init ingenic_tcu_timer_init(struct ingenic_tcu *tcu)
>>  +{
>>  +	unsigned int timer_virq;
>>  +	unsigned long rate;
>>  +	int err;
>>  +
>>  +	tcu->timer_clk =3D tcu->clocks->hws[tcu->timer_channel]->clk;
>>  +
>>  +	err =3D clk_prepare_enable(tcu->timer_clk);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	rate =3D clk_get_rate(tcu->timer_clk);
>>  +	if (!rate) {
>>  +		err =3D -EINVAL;
>>  +		goto err_clk_disable;
>>  +	}
>>  +
>>  +	timer_virq =3D irq_create_mapping(tcu->domain, tcu->timer_channel);
>>  +	if (!timer_virq) {
>>  +		err =3D -EINVAL;
>>  +		goto err_clk_disable;
>>  +	}
>>  +
>>  +	snprintf(tcu->name, sizeof(tcu->name), "TCU");
>>  +
>>  +	err =3D request_irq(timer_virq, ingenic_tcu_cevt_cb, IRQF_TIMER,
>>  +			  tcu->name, &tcu->cevt);
>>  +	if (err)
>>  +		goto err_irq_dispose_mapping;
>>  +
>>  +	tcu->cevt.cpumask =3D cpumask_of(smp_processor_id());
>>  +	tcu->cevt.features =3D CLOCK_EVT_FEAT_ONESHOT;
>>  +	tcu->cevt.name =3D tcu->name;
>>  +	tcu->cevt.rating =3D 200;
>>  +	tcu->cevt.set_state_shutdown =3D=20
>> ingenic_tcu_cevt_set_state_shutdown;
>>  +	tcu->cevt.set_next_event =3D ingenic_tcu_cevt_set_next;
>>  +
>>  +	clockevents_config_and_register(&tcu->cevt, rate, 10, 0xffff);
>>  +
>>  +	return 0;
>>  +
>>  +err_irq_dispose_mapping:
>>  +	irq_dispose_mapping(timer_virq);
>>  +err_clk_disable:
>>  +	clk_disable_unprepare(tcu->timer_clk);
>>  +	return err;
>>  +}
>>  +
>>  +static int __init ingenic_tcu_clocksource_init(struct ingenic_tcu=20
>> *tcu)
>>  +{
>>  +	unsigned int channel =3D tcu->cs_channel;
>>  +	struct clocksource *cs =3D &tcu->cs;
>>  +	unsigned long rate;
>>  +	int err;
>>  +
>>  +	tcu->cs_clk =3D tcu->clocks->hws[channel]->clk;
>>  +
>>  +	err =3D clk_prepare_enable(tcu->cs_clk);
>>  +	if (err)
>>  +		return err;
>>  +
>>  +	rate =3D clk_get_rate(tcu->cs_clk);
>>  +	if (!rate) {
>>  +		err =3D -EINVAL;
>>  +		goto err_clk_disable;
>>  +	}
>>  +
>>  +	/* Reset channel */
>>  +	regmap_update_bits(tcu->map, TCU_REG_TCSRc(channel),
>>  +			   0xffff & ~TCU_TCSR_RESERVED_BITS, 0);
>>  +
>>  +	/* Reset counter */
>>  +	regmap_write(tcu->map, TCU_REG_TDFRc(channel), 0xffff);
>>  +	regmap_write(tcu->map, TCU_REG_TCNTc(channel), 0);
>>  +
>>  +	/* Enable channel */
>>  +	regmap_write(tcu->map, TCU_REG_TESR, BIT(channel));
>>  +
>>  +	cs->name =3D "ingenic-timer";
>>  +	cs->rating =3D 200;
>>  +	cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
>>  +	cs->mask =3D CLOCKSOURCE_MASK(16);
>>  +	cs->read =3D (u64 (*)(struct clocksource *))ingenic_tcu_timer_read;
>>  +
>>  +	err =3D clocksource_register_hz(cs, rate);
>>  +	if (err)
>>  +		goto err_clk_disable;
>>  +
>>  +	sched_clock_register(ingenic_tcu_timer_read, 16, rate);
>>  +
>>  +	return 0;
>>  +
>>  +err_clk_disable:
>>  +	clk_disable_unprepare(tcu->cs_clk);
>>  +	return err;
>>  +}
>>  +
>>  +static void __init ingenic_tcu_clocksource_cleanup(struct=20
>> ingenic_tcu *tcu)
>>  +{
>>  +	clocksource_unregister(&tcu->cs);
>>  +	clk_disable_unprepare(tcu->cs_clk);
>>  +}
>>  +
>>  +static const struct regmap_config ingenic_tcu_regmap_config =3D {
>>  +	.reg_bits =3D 32,
>>  +	.val_bits =3D 32,
>>  +	.reg_stride =3D 4,
>>  +};
>>  +
>>  +static const struct ingenic_soc_info jz4740_soc_info =3D {
>>  +	.num_channels =3D 8,
>>  +	.has_ost =3D false,
>>  +};
>>  +
>>  +static const struct ingenic_soc_info jz4725b_soc_info =3D {
>>  +	.num_channels =3D 6,
>>  +	.has_ost =3D true,
>>  +};
>>  +
>>  +static const struct ingenic_soc_info jz4770_soc_info =3D {
>>  +	.num_channels =3D 8,
>>  +	.has_ost =3D true,
>>  +};
>>  +
>>  +static const struct of_device_id ingenic_tcu_of_match[] =3D {
>>  +	{ .compatible =3D "ingenic,jz4740-tcu",  .data =3D &jz4740_soc_info,=20
>> },
>>  +	{ .compatible =3D "ingenic,jz4725b-tcu", .data =3D &jz4725b_soc_info,=
=20
>> },
>>  +	{ .compatible =3D "ingenic,jz4770-tcu",  .data =3D &jz4770_soc_info,=20
>> },
>>  +	{ }
>>  +};
>>  +
>>  +static int __init ingenic_tcu_init(struct device_node *np)
>>  +{
>>  +	const struct of_device_id *id =3D=20
>> of_match_node(ingenic_tcu_of_match, np);
>>  +	const struct ingenic_soc_info *soc_info =3D id->data;
>>  +	unsigned int max_pwm_num;
>>  +	struct ingenic_tcu *tcu;
>>  +	struct resource res;
>>  +	void __iomem *base;
>>  +	int ret;
>>  +
>>  +	of_node_clear_flag(np, OF_POPULATED);
>>  +
>>  +	tcu =3D kzalloc(sizeof(*tcu), GFP_KERNEL);
>>  +	if (!tcu)
>>  +		return -ENOMEM;
>>  +
>>  +	/*
>>  +	 * Enable all TCU channels for PWM use by default except channel 0
>>  +	 * and, if the OS Timer is present, channel 1.
>>  +	 */
>>  +	tcu->pwm_channels_mask =3D GENMASK(soc_info->num_channels - 1,
>>  +					 2 - !!soc_info->has_ost);
>>  +	of_property_read_u32(np, "ingenic,pwm-channels-mask",
>>  +			     (u32 *)&tcu->pwm_channels_mask);
>>  +
>>  +	max_pwm_num =3D soc_info->num_channels - !soc_info->has_ost - 1;
>>  +
>>  +	if (hweight8(tcu->pwm_channels_mask) > max_pwm_num) {
>>  +		pr_crit("ingenic-tcu: Invalid PWM channel mask: 0x%02lx\n",
>>  +					tcu->pwm_channels_mask);
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	tcu->soc_info =3D soc_info;
>>  +	ingenic_tcu =3D tcu;
>>  +
>>  +	tcu->timer_channel =3D find_first_zero_bit(&tcu->pwm_channels_mask,
>>  +						 soc_info->num_channels);
>>  +	if (soc_info->has_ost) {
>>  +		tcu->cs_channel =3D find_next_zero_bit(&tcu->pwm_channels_mask,
>>  +						     soc_info->num_channels,
>>  +						     tcu->timer_channel + 1);
>>  +	}
>>  +
>>  +	base =3D of_io_request_and_map(np, 0, NULL);
>>  +	if (IS_ERR(base)) {
>>  +		ret =3D PTR_ERR(base);
>>  +		goto err_free_ingenic_tcu;
>>  +	}
>>  +
>>  +	of_address_to_resource(np, 0, &res);
>>  +
>>  +	ingenic_tcu_base =3D base;
>>  +
>>  +	tcu->map =3D regmap_init_mmio(NULL, base,=20
>> &ingenic_tcu_regmap_config);
>>  +	if (IS_ERR(tcu->map)) {
>>  +		ret =3D PTR_ERR(tcu->map);
>>  +		goto err_iounmap;
>>  +	}
>>  +
>>  +	tcu->clk =3D of_clk_get_by_name(np, "tcu");
>>  +	if (IS_ERR(tcu->clk)) {
>>  +		ret =3D PTR_ERR(tcu->clk);
>>  +		pr_crit("ingenic-tcu: Unable to find TCU clock: %i\n", ret);
>>  +		goto err_free_regmap;
>>  +	}
>>  +
>>  +	ret =3D clk_prepare_enable(tcu->clk);
>>  +	if (ret) {
>>  +		pr_crit("ingenic-tcu: Unable to enable TCU clock: %i\n", ret);
>>  +		goto err_clk_put;
>>  +	}
>>  +
>>  +	ret =3D ingenic_tcu_intc_init(tcu, np);
>>  +	if (ret)
>>  +		goto err_clk_disable;
>>  +
>>  +	ret =3D ingenic_tcu_clk_init(tcu, np);
>>  +	if (ret)
>>  +		goto err_tcu_intc_cleanup;
>>  +
>>  +	if (!soc_info->has_ost) {
>>  +		ret =3D ingenic_tcu_clocksource_init(tcu);
>>  +		if (ret)
>>  +			goto err_tcu_clk_cleanup;
>>  +	}
>>  +
>>  +	ret =3D ingenic_tcu_timer_init(tcu);
>>  +	if (ret)
>>  +		goto err_tcu_clocksource_cleanup;
>>  +
>>  +
>>  +	return 0;
>>  +
>>  +err_tcu_clocksource_cleanup:
>>  +	if (!soc_info->has_ost)
>>  +		ingenic_tcu_clocksource_cleanup(tcu);
>>  +err_tcu_clk_cleanup:
>>  +	ingenic_tcu_clk_cleanup(tcu, np);
>>  +err_tcu_intc_cleanup:
>>  +	ingenic_tcu_intc_cleanup(tcu);
>>  +err_clk_disable:
>>  +	clk_disable_unprepare(tcu->clk);
>>  +err_clk_put:
>>  +	clk_put(tcu->clk);
>>  +err_free_regmap:
>>  +	regmap_exit(tcu->map);
>>  +err_iounmap:
>>  +	iounmap(base);
>>  +	release_mem_region(res.start, resource_size(&res));
>>  +err_free_ingenic_tcu:
>>  +	kfree(tcu);
>>  +	return ret;
>>  +}
>>  +
>>  +TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu", =20
>> ingenic_tcu_init);
>>  +TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu",=20
>> ingenic_tcu_init);
>>  +TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu", =20
>> ingenic_tcu_init);
>>  +
>>  +
>>  +static int __init ingenic_tcu_probe(struct platform_device *pdev)
>>  +{
>>  +	platform_set_drvdata(pdev, ingenic_tcu);
>>  +
>>  +	regmap_attach_dev(&pdev->dev, ingenic_tcu->map,
>>  +			  &ingenic_tcu_regmap_config);
>>  +
>>  +	return devm_of_platform_populate(&pdev->dev);
>>  +}
>>  +
>>  +#ifdef CONFIG_PM_SLEEP
>>  +static int ingenic_tcu_suspend(struct device *dev)
>>  +{
>>  +	struct ingenic_tcu *tcu =3D dev_get_drvdata(dev);
>>  +
>>  +	clk_disable(tcu->cs_clk);
>>  +	clk_disable(tcu->timer_clk);
>>  +	clk_disable(tcu->clk);
>>  +	return 0;
>>  +}
>>  +
>>  +static int ingenic_tcu_resume(struct device *dev)
>>  +{
>>  +	struct ingenic_tcu *tcu =3D dev_get_drvdata(dev);
>>  +	int ret;
>>  +
>>  +	ret =3D clk_enable(tcu->clk);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>  +	ret =3D clk_enable(tcu->timer_clk);
>>  +	if (ret)
>>  +		goto err_tcu_clk_disable;
>>  +
>>  +	ret =3D clk_enable(tcu->cs_clk);
>>  +	if (ret)
>>  +		goto err_tcu_timer_clk_disable;
>>  +
>>  +	return 0;
>>  +
>>  +err_tcu_timer_clk_disable:
>>  +	clk_disable(tcu->timer_clk);
>>  +err_tcu_clk_disable:
>>  +	clk_disable(tcu->clk);
>>  +	return ret;
>>  +}
>>  +
>>  +static const struct dev_pm_ops ingenic_tcu_pm_ops =3D {
>>  +	/* _noirq: We want the TCU clock to be gated last / ungated first=20
>> */
>>  +	.suspend_noirq =3D ingenic_tcu_suspend,
>>  +	.resume_noirq  =3D ingenic_tcu_resume,
>>  +};
>>  +#define INGENIC_TCU_PM_OPS (&ingenic_tcu_pm_ops)
>>  +
>>  +#else
>>  +#define INGENIC_TCU_PM_OPS NULL
>>  +#endif /* CONFIG_PM_SUSPEND */
>>  +
>>  +static struct platform_driver ingenic_tcu_driver =3D {
>>  +	.driver =3D {
>>  +		.name	=3D "ingenic-tcu",
>>  +		.pm	=3D INGENIC_TCU_PM_OPS,
>>  +		.of_match_table =3D ingenic_tcu_of_match,
>>  +	},
>>  +};
>>  +builtin_platform_driver_probe(ingenic_tcu_driver,=20
>> ingenic_tcu_probe);
>>  +
>>  +bool ingenic_tcu_pwm_can_use_chn(unsigned int channel)
>>  +{
>>  +	return !!(ingenic_tcu->pwm_channels_mask & BIT(channel));
>>  +}
>>  +EXPORT_SYMBOL_GPL(ingenic_tcu_pwm_can_use_chn);
>>  diff --git a/drivers/clocksource/ingenic-timer.h=20
>> b/drivers/clocksource/ingenic-timer.h
>>  new file mode 100644
>>  index 000000000000..fa43da836ab6
>>  --- /dev/null
>>  +++ b/drivers/clocksource/ingenic-timer.h
>>  @@ -0,0 +1,15 @@
>>  +/* SPDX-License-Identifier: GPL-2.0 */
>>  +#ifndef __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__
>>  +#define __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__
>>  +
>>  +#include <linux/compiler_types.h>
>>  +
>>  +/*
>>  + * README: For use *ONLY* by the ingenic-ost driver.
>>  + * Regular drivers which want to access the TCU registers
>>  + * must have ingenic-timer as parent and retrieve the regmap
>>  + * doing dev_get_regmap(pdev->dev.parent);
>>  + */
>>  +extern void __iomem *ingenic_tcu_base;
>>  +
>>  +#endif /* __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__ */
>>  diff --git a/include/linux/mfd/ingenic-tcu.h=20
>> b/include/linux/mfd/ingenic-tcu.h
>>  index ab16ad283def..dac3fac35c1e 100644
>>  --- a/include/linux/mfd/ingenic-tcu.h
>>  +++ b/include/linux/mfd/ingenic-tcu.h
>>  @@ -53,4 +53,6 @@
>>   #define TCU_REG_TCNTc(c)	(TCU_REG_TCNT0 + ((c) *=20
>> TCU_CHANNEL_STRIDE))
>>   #define TCU_REG_TCSRc(c)	(TCU_REG_TCSR0 + ((c) *=20
>> TCU_CHANNEL_STRIDE))
>>=20
>>  +bool ingenic_tcu_pwm_can_use_chn(unsigned int channel);
>>  +
>>   #endif /* __LINUX_MFD_INGENIC_TCU_H_ */
>>=20
>=20
>=20
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM=20
> SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
=

