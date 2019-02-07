Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02002C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950052175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKolw5pP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBGOBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:01:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37278 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfBGOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:01:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so4859193wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 06:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Tg7tPXf42si89yYu1C19H2DIUnk2xWCH+9FGuF+gtBw=;
        b=KKolw5pPgQDPXSsB5/8WTZEckWRJVnFpEKRbUt4Ow1oLd6KPiRNRp5FRxv7ZpEWexh
         q3/qlPdZL9GWnUbz1UD7pUSXiD8+HP5yveqrnrBzmu4CXwUev61ThgntekkGEVnQHXw7
         gXjWj35unPSYKEqLrEO9Ekghv4m5Dl5ulN/pN7WHWMoVopsDbMOYAvDsP3U2Z7+XCzJc
         pOOH0B0NMASpxE9kJDkcZhwwv2VAzfqFxsnyx7Nj9cLSsBgLNnkUl5OJUsjrSQEnpDGI
         YHltvVwJWeccTNgQtN0qnC6zYUJF/1EJEfvAPo5DDH8noxxPryZP5f0FPuAB0SDGxz9c
         QHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Tg7tPXf42si89yYu1C19H2DIUnk2xWCH+9FGuF+gtBw=;
        b=adSSfmHLYhqrhCVBq8pdOVhrUulZ7A4zzxcuSD87sHUuDOHOub0yDgKjCwWkxo4Gfw
         EKSFo6XieUdAp1EoSMbpgIuJRD5bJvxPqp3dzZtCjYqpYKsuIcaWD2wHjszjebc4PJSY
         Z47n9qiUE7vzCqA1ssDClgWn8TcJvCWf5FWoCzTwrWE6piEPCX6eXcp95rrQXaJHcxB7
         rpOz2LWcq4dmM5XSh5T4IEO39WzqdjKS73LoSXWQoer0B0gnS32pNbFrUxQhA0TaGpZ+
         3noBdTRs/f5yXGc4JjkuEN6GPDjvAQLF9I2ja4O0cJ72oNJYIU7i054i+gA1G7p7J00b
         y1Og==
X-Gm-Message-State: AHQUAuZwwoW57l8sDtmqTLjc623hMcwMAxpchk5nJJWN7N44xdMsRX9x
        6b7GVL2SpRH2BTc4pt80OF6dbA==
X-Google-Smtp-Source: AHgI3IbfkHVkUZ0yYzyvcw6vLXrmEYwfHeZzZgFBhSPQ6X0sTn4mN2uq7rqfOcnCJAb5G7wo3BKAkg==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr12810621wru.45.1549548056763;
        Thu, 07 Feb 2019 06:00:56 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id y20sm34507203wra.51.2019.02.07.06.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 06:00:55 -0800 (PST)
Date:   Thu, 7 Feb 2019 14:00:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190207140053.GG20638@dell>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Matti Vaittinen wrote:

> ROHM BD70528MWV is an ultra-low quiescent current general
> purpose single-chip power management IC for battery-powered
> portable devices.
> 
> Add MFD core which enables chip access for following subdevices:
> 	- regulators/LED drivers
> 	- battery-charger
> 	- gpios
> 	- 32.768kHz clk
> 	- RTC
> 	- watchdog
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/Kconfig              |  17 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd70528.c       | 410 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd70528.h | 392 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 820 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd70528.c
>  create mode 100644 include/linux/mfd/rohm-bd70528.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..f1a0574cebb1 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1847,6 +1847,23 @@ config MFD_ROHM_BD718XX
>  	  NXP i.MX8. It contains 8 BUCK outputs and 7 LDOs, voltage monitoring
>  	  and emergency shut down as well as 32,768KHz clock output.
>  
> +config MFD_ROHM_BD70528
> +	tristate "ROHM BD70528 Power Management IC"
> +	depends on I2C=y
> +	depends on OF
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select MFD_CORE
> +	help
> +	  Select this option to get support for the ROHM BD70528 Power
> +	  Management IC. BD71837 is general purpose single-chip power
> +	  management IC for battery-powered portable devices. It contains
> +	  3 ultra-low current consumption buck converters, 3 LDOs and 2 LED
> +	  Drivers. Also included are 4 GPIOs, a real-time clock (RTC), a 32kHz
> +	  crystal oscillator, high-accuracy VREF for use with an external ADC,
> +	  10 bits SAR ADC for battery temperature monitor and 1S battery
> +	  charger.
> +
>  config MFD_STM32_LPTIMER
>  	tristate "Support for STM32 Low-Power Timer"
>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..fc9b1408e39b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -241,4 +241,5 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>  obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
> +obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
>  
> diff --git a/drivers/mfd/rohm-bd70528.c b/drivers/mfd/rohm-bd70528.c
> new file mode 100644
> index 000000000000..580164addeeb
> --- /dev/null
> +++ b/drivers/mfd/rohm-bd70528.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Copyright (C) 2018 ROHM Semiconductors

This needs updating.

> +// ROHM BD70528 PMIC driver
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rohm-bd70528.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define BD70528_INT_RES(_reg, _name)		\
> +	{					\
> +		.start = (_reg),		\
> +		.end = (_reg),			\
> +		.name = (_name),		\
> +		.flags = IORESOURCE_IRQ,	\
> +	}

I think you're looking for DEFINE_RES_IRQ_NAMED()

> +static const struct resource rtc_irqs[] = {
> +	BD70528_INT_RES(BD70528_INT_RTC_ALARM, "bd70528-rtc-alm"),
> +	BD70528_INT_RES(BD70528_INT_ELPS_TIM, "bd70528-elapsed-timer"),
> +};
> +
> +static const struct resource charger_irqs[] = {
> +	BD70528_INT_RES(BD70528_INT_BAT_OV_RES, "bd70528-bat-ov-res"),
> +	BD70528_INT_RES(BD70528_INT_BAT_OV_DET, "bd70528-bat-ov-det"),
> +	BD70528_INT_RES(BD70528_INT_DBAT_DET, "bd70528-bat-dead"),
> +	BD70528_INT_RES(BD70528_INT_BATTSD_COLD_RES, "bd70528-bat-warmed"),
> +	BD70528_INT_RES(BD70528_INT_BATTSD_COLD_DET, "bd70528-bat-cold"),
> +	BD70528_INT_RES(BD70528_INT_BATTSD_HOT_RES, "bd70528-bat-cooled"),
> +	BD70528_INT_RES(BD70528_INT_BATTSD_HOT_DET, "bd70528-bat-hot"),
> +	BD70528_INT_RES(BD70528_INT_CHG_TSD, "bd70528-chg-tshd"),
> +	BD70528_INT_RES(BD70528_INT_BAT_RMV, "bd70528-bat-removed"),
> +	BD70528_INT_RES(BD70528_INT_BAT_DET, "bd70528-bat-detected"),
> +	BD70528_INT_RES(BD70528_INT_DCIN2_OV_RES, "bd70528-dcin2-ov-res"),
> +	BD70528_INT_RES(BD70528_INT_DCIN2_OV_DET, "bd70528-dcin2-ov-det"),
> +	BD70528_INT_RES(BD70528_INT_DCIN2_RMV, "bd70528-dcin2-removed"),
> +	BD70528_INT_RES(BD70528_INT_DCIN2_DET, "bd70528-dcin2-detected"),
> +	BD70528_INT_RES(BD70528_INT_DCIN1_RMV, "bd70528-dcin1-removed"),
> +	BD70528_INT_RES(BD70528_INT_DCIN1_DET, "bd70528-dcin1-detected"),
> +};
> +
> +static struct mfd_cell bd70528_mfd_cells[] = {
> +	{ .name = "bd70528-pmic", },
> +	{ .name = "bd70528-gpio", },
> +	/*
> +	 * We use BD71837 driver to drive the clk block. Only differences to
> +	 * BD70528 clock gate are the register address and mask.
> +	 */
> +	{ .name = "bd718xx-clk", },
> +	{ .name = "bd70528-wdt", },
> +	{
> +		.name = "bd70528-power",
> +		.resources = &charger_irqs[0],

Why not just, 'charger_irqs'?

> +		.num_resources = ARRAY_SIZE(charger_irqs),

> +	},
> +	{

These should be on the same line.

> +		.name = "bd70528-rtc",
> +		.resources = &rtc_irqs[0],

As above.

> +		.num_resources = ARRAY_SIZE(rtc_irqs),
> +	},
> +};
> +
> +static const struct regmap_range volatile_ranges[] = {
> +	/* IRQ regs */
> +	{
> +		.range_min = BD70528_REG_INT_MAIN,
> +		.range_max = BD70528_REG_INT_OP_FAIL,
> +	},
> +	/* RTC regs */
> +	{
> +		.range_min = BD70528_REG_RTC_COUNT_H,
> +		.range_max = BD70528_REG_RTC_ALM_REPEAT,
> +	},
> +	/*
> +	 * WDT control reg is special. Magic values must be
> +	 * written to it in order to change the control. Should
> +	 * not be cached.
> +	 */
> +	{
> +		.range_min = BD70528_REG_WDT_CTRL,
> +		.range_max = BD70528_REG_WDT_CTRL,
> +	},
> +	/*
> +	 * bd70528 contains also few other registers which require

"BD70528"

I don't think this means what you think it does.

I think you want to say "also contains a few".

> +	 * magic sequence to be written in order to update the value.

"sequences"

> +	 * At least SHIPMODE, HWRESET, WARMRESET,and STANDBY
> +	 */
> +	{
> +		.range_min = BD70528_REG_SHIPMODE,
> +		.range_max = BD70528_REG_STANDBY,
> +	},
> +};
> +
> +static const struct regmap_access_table volatile_regs = {
> +	.yes_ranges = &volatile_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(volatile_ranges),
> +};
> +
> +static struct regmap_config bd70528_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.volatile_table = &volatile_regs,
> +	.max_register = BD70528_MAX_REGISTER,
> +	.cache_type = REGCACHE_RBTREE,
> +};

'\n' here.

> +/* bit [0] - Shutdown register */
> +unsigned int bit0_offsets[] = {0};
> +/* bit [1] - Power failure register */
> +unsigned int bit1_offsets[] = {1};
> +/* bit [2] - VR FAULT register */
> +unsigned int bit2_offsets[] = {2};
> +/* bit [3] - PMU register interrupts */
> +unsigned int bit3_offsets[] = {3};
> +/* bit [4] - Charger 1 and Charger 2 registers */
> +unsigned int bit4_offsets[] = {4, 5};
> +/* bit [5] - RTC register */
> +unsigned int bit5_offsets[] = {6};
> +/* bit [6] - GPIO register */
> +unsigned int bit6_offsets[] = {7};
> +/* bit [7] - Invalid operation register */
> +unsigned int bit7_offsets[] = {8};

What on earth is this?

> +static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] = {
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
> +};

This looks totally hairy.  What is it mean to look like?

> +static struct regmap_irq irqs[] = {
> +	REGMAP_IRQ_REG(BD70528_INT_LONGPUSH, 0, BD70528_INT_LONGPUSH_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_WDT, 0, BD70528_INT_WDT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_HWRESET, 0, BD70528_INT_HWRESET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_RSTB_FAULT, 0, BD70528_INT_RSTB_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_VBAT_UVLO, 0, BD70528_INT_VBAT_UVLO_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_TSD, 0, BD70528_INT_TSD_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_RSTIN, 0, BD70528_INT_RSTIN_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK1_FAULT, 1,
> +		       BD70528_INT_BUCK1_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK2_FAULT, 1,
> +		       BD70528_INT_BUCK2_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK3_FAULT, 1,
> +		       BD70528_INT_BUCK3_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LDO1_FAULT, 1, BD70528_INT_LDO1_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LDO2_FAULT, 1, BD70528_INT_LDO2_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LDO3_FAULT, 1, BD70528_INT_LDO3_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LED1_FAULT, 1, BD70528_INT_LED1_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LED2_FAULT, 1, BD70528_INT_LED2_FAULT_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK1_OCP, 2, BD70528_INT_BUCK1_OCP_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK2_OCP, 2, BD70528_INT_BUCK2_OCP_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK3_OCP, 2, BD70528_INT_BUCK3_OCP_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LED1_OCP, 2, BD70528_INT_LED1_OCP_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LED2_OCP, 2, BD70528_INT_LED2_OCP_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK1_FULLON, 2,
> +		       BD70528_INT_BUCK1_FULLON_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK2_FULLON, 2,
> +		       BD70528_INT_BUCK2_FULLON_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_SHORTPUSH, 3, BD70528_INT_SHORTPUSH_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_AUTO_WAKEUP, 3,
> +		       BD70528_INT_AUTO_WAKEUP_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_STATE_CHANGE, 3,
> +		       BD70528_INT_STATE_CHANGE_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BAT_OV_RES, 4, BD70528_INT_BAT_OV_RES_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BAT_OV_DET, 4, BD70528_INT_BAT_OV_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DBAT_DET, 4, BD70528_INT_DBAT_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BATTSD_COLD_RES, 4,
> +		       BD70528_INT_BATTSD_COLD_RES_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BATTSD_COLD_DET, 4,
> +		       BD70528_INT_BATTSD_COLD_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BATTSD_HOT_RES, 4,
> +		       BD70528_INT_BATTSD_HOT_RES_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BATTSD_HOT_DET, 4,
> +		       BD70528_INT_BATTSD_HOT_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_CHG_TSD, 4, BD70528_INT_CHG_TSD_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BAT_RMV, 5, BD70528_INT_BAT_RMV_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BAT_DET, 5, BD70528_INT_BAT_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DCIN2_OV_RES, 5,
> +		       BD70528_INT_DCIN2_OV_RES_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DCIN2_OV_DET, 5,
> +		       BD70528_INT_DCIN2_OV_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DCIN2_RMV, 5, BD70528_INT_DCIN2_RMV_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DCIN2_DET, 5, BD70528_INT_DCIN2_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DCIN1_RMV, 5, BD70528_INT_DCIN1_RMV_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_DCIN1_DET, 5, BD70528_INT_DCIN1_DET_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_RTC_ALARM, 6, BD70528_INT_RTC_ALARM_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_ELPS_TIM, 6, BD70528_INT_ELPS_TIM_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_GPIO0, 7, BD70528_INT_GPIO0_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_GPIO1, 7, BD70528_INT_GPIO1_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_GPIO2, 7, BD70528_INT_GPIO2_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_GPIO3, 7, BD70528_INT_GPIO3_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK1_DVS_OPFAIL, 8,
> +		       BD70528_INT_BUCK1_DVS_OPFAIL_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK2_DVS_OPFAIL, 8,
> +		       BD70528_INT_BUCK2_DVS_OPFAIL_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_BUCK3_DVS_OPFAIL, 8,
> +		       BD70528_INT_BUCK3_DVS_OPFAIL_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LED1_VOLT_OPFAIL, 8,
> +		       BD70528_INT_LED1_VOLT_OPFAIL_MASK),
> +	REGMAP_IRQ_REG(BD70528_INT_LED2_VOLT_OPFAIL, 8,
> +		       BD70528_INT_LED2_VOLT_OPFAIL_MASK),
> +};
> +
> +static struct regmap_irq_chip bd70528_irq_chip = {
> +	.name = "bd70528_irq",
> +	.main_status = BD70528_REG_INT_MAIN,
> +	.irqs = &irqs[0],
> +	.num_irqs = ARRAY_SIZE(irqs),
> +	.status_base = BD70528_REG_INT_SHDN,
> +	.mask_base = BD70528_REG_INT_SHDN_MASK,
> +	.ack_base = BD70528_REG_INT_SHDN,
> +	.type_base = BD70528_REG_GPIO1_IN,
> +	.init_ack_masked = true,
> +	.num_regs = 9,
> +	.num_main_regs = 1,
> +	.num_type_reg = 4,
> +	.sub_reg_offsets = &bd70528_sub_irq_offsets[0],
> +	.num_main_status_bits = 8,
> +	.irq_reg_stride = 1,
> +};
> +
> +#define WD_CTRL_MAGIC1 0x55
> +#define WD_CTRL_MAGIC2 0xAA
> +
> +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable, int *old_state)
> +{
> +	int ret, i;
> +	unsigned int tmp;
> +	u8 wd_ctrl_arr[3] = { WD_CTRL_MAGIC1, WD_CTRL_MAGIC2, 0 };
> +	u8 *wd_ctrl = &wd_ctrl_arr[2];
> +
> +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	*wd_ctrl = (u8)tmp;
> +
> +	if (old_state) {
> +		if (*wd_ctrl & BD70528_MASK_WDT_EN)
> +			*old_state |= BD70528_WDT_STATE_BIT;
> +		else
> +			*old_state &= ~BD70528_WDT_STATE_BIT;
> +		if ((!enable) == (!(*old_state & BD70528_WDT_STATE_BIT)))
> +			return 0;
> +	}
> +
> +	if (enable) {
> +		if (*wd_ctrl & BD70528_MASK_WDT_EN)
> +			return 0;
> +		*wd_ctrl |= BD70528_MASK_WDT_EN;
> +	} else {
> +		if (*wd_ctrl & BD70528_MASK_WDT_EN)
> +			*wd_ctrl &= ~BD70528_MASK_WDT_EN;
> +		else
> +			return 0;
> +	}
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = regmap_write(bd70528->chip.regmap, BD70528_REG_WDT_CTRL,
> +				   wd_ctrl_arr[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &tmp);
> +	if ((tmp & BD70528_MASK_WDT_EN) != (*wd_ctrl & BD70528_MASK_WDT_EN)) {
> +		dev_err(bd70528->chip.dev,
> +			"Watchdog ctrl mismatch (hw) 0x%x (set) 0x%x\n",
> +			tmp, *wd_ctrl);
> +		ret = -EIO;
> +	}
> +
> +	return ret;
> +}

Shouldn't this be one in the WDT driver?

> +static int bd70528_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct bd70528 *bd70528;
> +	struct regmap_irq_chip_data *irq_data;
> +	int ret, i;
> +	struct mutex *rtc_mutex;
> +
> +	if (!i2c->irq) {
> +		dev_err(&i2c->dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}

'\n' here.

> +	bd70528 = devm_kzalloc(&i2c->dev, sizeof(*bd70528), GFP_KERNEL);
> +

Remove this line.

> +	if (!bd70528)
> +		return -ENOMEM;
> +
> +	mutex_init(&bd70528->rtc_timer_lock);

Shouldn't this in the RTC driver?

> +	dev_set_drvdata(&i2c->dev, bd70528);

'\n' here.

> +	bd70528->chip.chip_type = ROHM_CHIP_TYPE_BD70528;
> +	bd70528->wdt_set = bd70528_wdt_set;

Why?

> +	bd70528->chip.regmap = devm_regmap_init_i2c(i2c, &bd70528_regmap);
> +	if (IS_ERR(bd70528->chip.regmap)) {
> +		dev_err(&i2c->dev, "regmap initialization failed\n");
> +		return PTR_ERR(bd70528->chip.regmap);
> +	}
> +
> +	/*
> +	 * Disallow type setting for all IRQs by default as
> +	 *  most of them do not support setting type.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(irqs); i++)
> +		irqs[i].type.types_supported = 0;
> +
> +	irqs[BD70528_INT_GPIO0].type.type_reg_offset = 0;
> +	irqs[BD70528_INT_GPIO0].type.type_rising_val = 0x20;
> +	irqs[BD70528_INT_GPIO0].type.type_falling_val = 0x10;
> +	irqs[BD70528_INT_GPIO0].type.type_level_high_val = 0x40;
> +	irqs[BD70528_INT_GPIO0].type.type_level_low_val = 0x50;
> +	irqs[BD70528_INT_GPIO0].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> +	irqs[BD70528_INT_GPIO1].type.type_reg_offset = 2;
> +	irqs[BD70528_INT_GPIO1].type.type_rising_val = 0x20;
> +	irqs[BD70528_INT_GPIO1].type.type_falling_val = 0x10;
> +	irqs[BD70528_INT_GPIO1].type.type_level_high_val = 0x40;
> +	irqs[BD70528_INT_GPIO1].type.type_level_low_val = 0x50;
> +	irqs[BD70528_INT_GPIO1].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> +	irqs[BD70528_INT_GPIO2].type.type_reg_offset = 4;
> +	irqs[BD70528_INT_GPIO2].type.type_rising_val = 0x20;
> +	irqs[BD70528_INT_GPIO2].type.type_falling_val = 0x10;
> +	irqs[BD70528_INT_GPIO2].type.type_level_high_val = 0x40;
> +	irqs[BD70528_INT_GPIO2].type.type_level_low_val = 0x50;
> +	irqs[BD70528_INT_GPIO2].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> +	irqs[BD70528_INT_GPIO3].type.type_reg_offset = 6;
> +	irqs[BD70528_INT_GPIO3].type.type_rising_val = 0x20;
> +	irqs[BD70528_INT_GPIO3].type.type_falling_val = 0x10;
> +	irqs[BD70528_INT_GPIO3].type.type_level_high_val = 0x40;
> +	irqs[BD70528_INT_GPIO3].type.type_level_low_val = 0x50;
> +	irqs[BD70528_INT_GPIO3].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);

Could you please explain:

a) what you're doing here
b) why you don't mass assign them
    - seeing as most of the data is identical.

> +	ret = devm_regmap_add_irq_chip(&i2c->dev, bd70528->chip.regmap,
> +				       i2c->irq, IRQF_ONESHOT, 0,
> +				       &bd70528_irq_chip, &irq_data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to add irq_chip\n");
> +		return ret;
> +	}

'\n' here.

> +	dev_dbg(&i2c->dev, "Registered %d irqs for chip\n",
> +			bd70528_irq_chip.num_irqs);

Is this really required/useful?

> +	/*
> +	 * BD70528 irq controller is not touching the main mask register.

"IRQ"

> +	 * So enable the GPIO block interrupts at main level. We can just
> +	 * leave them enabled as irq-controller should disable irqs

"the IRQ controller"
"IRQs"

> +	 * from sub-registers when IRQ is disabled or freed.
> +	 */
> +	ret = regmap_update_bits(bd70528->chip.regmap,
> +				 BD70528_REG_INT_MAIN_MASK,
> +				 BD70528_INT_GPIO_MASK, 0);
> +
> +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				   bd70528_mfd_cells,
> +				   ARRAY_SIZE(bd70528_mfd_cells), NULL, 0,
> +				   regmap_irq_get_domain(irq_data));
> +	if (ret)
> +		dev_err(&i2c->dev, "Failed to create subdevices\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id bd70528_of_match[] = {
> +	{
> +		.compatible = "rohm,bd70528",
> +	},

This can be placed on a single line.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bd70528_of_match);
> +
> +static struct i2c_driver bd70528_drv = {
> +	.driver = {
> +		.name = "rohm-bd70528",
> +		.of_match_table = bd70528_of_match,
> +	},
> +	.probe = &bd70528_i2c_probe,
> +};
> +
> +static int __init bd70528_init(void)
> +{
> +	return i2c_add_driver(&bd70528_drv);
> +}
> +subsys_initcall(bd70528_init);

Does it need to be initialised this early?

> +static void __exit bd70528_exit(void)
> +{
> +	i2c_del_driver(&bd70528_drv);
> +}
> +module_exit(bd70528_exit);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("ROHM BD70528 Power Management IC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/rohm-bd70528.h b/include/linux/mfd/rohm-bd70528.h
> new file mode 100644
> index 000000000000..576b672870b7
> --- /dev/null
> +++ b/include/linux/mfd/rohm-bd70528.h
> @@ -0,0 +1,392 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright (C) 2018 ROHM Semiconductors */
> +
> +#ifndef __LINUX_MFD_BD70528_H__
> +#define __LINUX_MFD_BD70528_H__
> +
> +#include <linux/device.h>
> +#include <linux/mfd/rohm-generic.h>
> +#include <linux/regmap.h>
> +
> +struct bd70528 {
> +	/*
> +	 * Please keep this as the first member here as some
> +	 * drivers (clk) supporting more than one chip may only know this
> +	 * generic struct 'struct rohm_regmap_dev' and assume it is
> +	 * the first chunk of parent device's private data.
> +	 */
> +	struct rohm_regmap_dev chip;
> +	/* wdt_set must be called rtc_timer_lock held */

This doesn't make sense.

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
