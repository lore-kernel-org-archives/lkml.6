Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD7AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F8521773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe39vSFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfBKVgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:36:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44406 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBKVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:36:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so156271ljb.11;
        Mon, 11 Feb 2019 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ayADBkwFmofKHqvWRAH+Vue8LGG9Z1+7uGjkz9koYcM=;
        b=Xe39vSFNac+rK/VkT04ajuOQ5lJlOCHFjhGEiUgkKuHAj3WEPHmoJG+PMjD8kTAtot
         1B6JzKqfIcy6EcWFTXDgqkXoUxsm6Hr+xNrrk4mC/RgtueTPAFXsYdRFAA3UKOtAPnOj
         HpsVJZatEIOtIOKzG5B4qv+JduOqFWK7eVGBCZBBfz+kn6/Sl5s7O/u/xe/zhXoPULTB
         9rr7VS1zdMGKY6nAcJIqi6Nyeml5w++yJ+vly6tWGu7ipJYvryFxqurHFVyCssFDEFJj
         GURuNEAHzlUDJz05R9nBWpp7usC+uiCjxukUthVWexSXh8Jkkrph9sZbmFbSwB3tapQL
         GPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ayADBkwFmofKHqvWRAH+Vue8LGG9Z1+7uGjkz9koYcM=;
        b=Kc6aKpBswzkj2xbm/2ddtcuTohpWcMPrszNgN6+kw84/FZxtvFKBc5E037/V0fx26F
         Vcsp1Xor5cb/h72n/R2B3L6/PykPzuP0nk984e4yA0w3VoYv4tPqYOISqEPWvytQ3OPG
         WUNU07hkLDM+a11LLyAQtxfyfG49v1QIZZLhJZe890n2Aot6vVNDwNvubUYC2lXK60Qp
         FvRS7KuC1kNUTtt3kMfMHhKKO8hYgdN4EqfzpmSFmimQC0w1wlXBtmxf0D++CxyrL4se
         wrd1MzC22jJjCWGdNOkS+8CpJMBfs83ScQZcp1ttlezmeT3t1ZfuUDHNWRZlUdhKQxEn
         1Bkg==
X-Gm-Message-State: AHQUAuYY50giQJ2ElTiLUqXR/iz29p84c5RHA3j7uvLEX5XSF/o5o+Zn
        JAZIlmh6jjskOWMjgZ2QdrXYEWtL
X-Google-Smtp-Source: AHgI3IYb9zmbOW2IXNTjrt8RwKCq4HU/khKKWYxibrkw6R/AAA5C4Gne6t+7yfMcoFNaPGCyE7pzFA==
X-Received: by 2002:a2e:84c7:: with SMTP id q7-v6mr192766ljh.58.1549920993494;
        Mon, 11 Feb 2019 13:36:33 -0800 (PST)
Received: from [192.168.1.18] (dkl6.neoplus.adsl.tpnet.pl. [83.24.15.6])
        by smtp.gmail.com with ESMTPSA id 199sm689928lfa.38.2019.02.11.13.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:36:32 -0800 (PST)
Subject: Re: [PATCH 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC LEDs
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190209221213.24052-2-jekhor@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9319c977-b8d4-98cc-d719-b21df5ef5a88@gmail.com>
Date:   Mon, 11 Feb 2019 22:36:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209221213.24052-2-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yauhen,

Thank you for the patch.

Please find few comments in the code.

On 2/9/19 11:12 PM, Yauhen Kharuzhy wrote:
> Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
> PMIC. Charger and general-purpose leds are supported. Hardware blinking
> is implemented, breathing is not.
> 
> This driver was tested with Lenovo Yoga Book notebook.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/leds/Kconfig          |  11 ++
>   drivers/leds/Makefile         |   1 +
>   drivers/leds/leds-cht-wcove.c | 278 ++++++++++++++++++++++++++++++++++
>   3 files changed, 290 insertions(+)
>   create mode 100644 drivers/leds/leds-cht-wcove.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..8f50f38af57e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -106,6 +106,17 @@ config LEDS_BCM6358
>   	  This option enables support for LEDs connected to the BCM6358
>   	  LED HW controller accessed via MMIO registers.
>   
> +config LEDS_CHT_WCOVE
> +	tristate "LED support for Intel Cherry Trail Whiskey Cove PMIC"
> +	depends on LEDS_CLASS
> +	depends on INTEL_SOC_PMIC_CHTWC
> +	help
> +	  This option enables support for charger and general purpose LEDs
> +	  connected to the Intel Cherrytrail Whiskey Cove PMIC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-cht-wcove.
> +
>   config LEDS_CPCAP
>   	tristate "LED Support for Motorola CPCAP"
>   	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4c1b0054f379..1c1995d3441c 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
>   obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
>   obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
>   obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
> +obj-$(CONFIG_LEDS_CHT_WCOVE)		+= leds-cht-wcove.o
>   obj-$(CONFIG_LEDS_CPCAP)		+= leds-cpcap.o
>   obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
>   obj-$(CONFIG_LEDS_LM3530)		+= leds-lm3530.o
> diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
> new file mode 100644
> index 000000000000..82ed0845bf72
> --- /dev/null
> +++ b/drivers/leds/leds-cht-wcove.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for LEDs connected to the Intel Cherry Trail Whiskey Cove PMIC
> + *
> + * Copyright 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> + *
> + * Based on Lenovo Yoga Book Android kernel sources
> + */

Please use uniform "//" comment style above.

> +#include <linux/kernel.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define CHT_WC_LED1_CTRL		0x5e1f
> +#define CHT_WC_LED1_FSM			0x5e20
> +#define CHT_WC_LED1_PWM			0x5e21
> +
> +#define CHT_WC_LED2_CTRL		0x4fdf
> +#define CHT_WC_LED2_FSM			0x4fe0
> +#define CHT_WC_LED2_PWM			0x4fe1
> +
> +/* HW or SW control of charging led */
> +#define CHT_WC_LED1_SWCTL		BIT(0)
> +#define CHT_WC_LED1_ON			BIT(1)
> +
> +#define CHT_WC_LED2_ON			BIT(0)
> +#define CHT_WC_LED_I_MA2_5		(2 << 2)
> +/* LED current limit */
> +#define CHT_WC_LED_I_MASK		GENMASK(3, 2)
> +
> +#define CHT_WC_LED_F_1_4_HZ		(0 << 4)
> +#define CHT_WC_LED_F_1_2_HZ		(1 << 4)
> +#define CHT_WC_LED_F_1_HZ		(2 << 4)
> +#define CHT_WC_LED_F_2_HZ		(3 << 4)
> +#define CHT_WC_LED_F_MASK		0x30
> +
> +#define CHT_WC_LED_EFF_ON		BIT(1)
> +#define CHT_WC_LED_EFF_BLINKING		BIT(2)
> +#define CHT_WC_LED_EFF_BREATHING	BIT(3)
> +#define CHT_WC_LED_EFF_MASK		0x06
> +
> +struct cht_wc_led {
> +	struct led_classdev cdev;
> +	struct intel_soc_pmic *pmic;
> +	const char *name;
> +	u16	ctrl_reg;
> +	u8	enable_mask;
> +	u16	fsm_reg;
> +	u16	pwm_reg;
> +};
> +
> +static struct cht_wc_led cht_wc_leds[] = {
> +	{
> +		.name = "pmic::charge",
> +		.ctrl_reg = CHT_WC_LED1_CTRL,
> +		.fsm_reg = CHT_WC_LED1_FSM,
> +		.pwm_reg = CHT_WC_LED1_PWM,
> +		.enable_mask = CHT_WC_LED1_ON,
> +	},
> +	{
> +		.name = "pmic::gpled",
> +		.ctrl_reg = CHT_WC_LED2_CTRL,
> +		.fsm_reg = CHT_WC_LED2_FSM,
> +		.pwm_reg = CHT_WC_LED2_PWM,
> +		.enable_mask = CHT_WC_LED2_ON,
> +	},
> +};
> +
> +static int cht_wc_leds_brightness_set(struct led_classdev *cdev,
> +				      enum led_brightness value)
> +{
> +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> +	int ret;

You need mutex protection here. Think of the cases where brightness
is set from sysfs and the call from trigger jumps in the middle.

> +	if (!value) {
> +		ret = regmap_update_bits(led->pmic->regmap, led->ctrl_reg,
> +					 led->enable_mask, 0);
> +		if (ret)
> +			dev_err(cdev->dev, "Failed to turn off: %d\n", ret);
> +
> +		ret = regmap_update_bits(led->pmic->regmap, led->fsm_reg,
> +					 CHT_WC_LED_EFF_MASK,
> +					 CHT_WC_LED_EFF_ON);
> +		if (ret < 0)
> +			dev_err(cdev->dev,
> +				"Failed to update LED FSM reg: %d\n", ret);
> +	} else {
> +		ret = regmap_write(led->pmic->regmap, led->pwm_reg, value);
> +		if (ret)
> +			dev_err(cdev->dev,
> +				"Failed to set brightness: %d\n", ret);
> +
> +		ret = regmap_update_bits(led->pmic->regmap, led->ctrl_reg,
> +					 led->enable_mask, led->enable_mask);
> +		if (ret)
> +			dev_err(cdev->dev, "Failed to turn on: %d\n", ret);
> +	}
> +	return ret;
> +}
> +
> +enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
> +{
> +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> +	int ret;
> +	unsigned int val;

Ditto.

> +	ret = regmap_read(led->pmic->regmap, led->ctrl_reg, &val);
> +	if (ret < 0) {
> +		dev_err(cdev->dev, "Failed to read LED CTRL reg: %d\n", ret);
> +		return LED_OFF;
> +	}
> +
> +	val &= led->enable_mask;
> +
> +	if (!val)
> +		return LED_OFF;
> +
> +	ret = regmap_read(led->pmic->regmap, led->pwm_reg, &val);
> +	if (ret < 0) {
> +		dev_err(cdev->dev, "Failed to read LED PWM reg: %d\n", ret);
> +		return LED_ON;
> +	}
> +
> +	return val;
> +}
> +
> +/* Return blinking period for given CTRL reg value */
> +static unsigned long cht_wc_leds_get_period(int ctrl)
> +{
> +	ctrl &= CHT_WC_LED_F_MASK;
> +
> +	switch (ctrl) {
> +	case CHT_WC_LED_F_1_4_HZ:
> +		return 1000 * 4;
> +	case CHT_WC_LED_F_1_2_HZ:
> +		return 1000 * 2;
> +	case CHT_WC_LED_F_1_HZ:
> +		return 1000;
> +	case CHT_WC_LED_F_2_HZ:
> +		return 1000 / 2;
> +	};
> +
> +	return 0;
> +}
> +
> +/*
> + * Find suitable hardware blink mode for given period.
> + * period < 750 ms - select 2 HZ
> + * 750 ms <= period < 1500 ms - select 1 HZ
> + * 1500 ms <= period < 3000 ms - select 1/2 HZ
> + * 3000 ms <= period < 5000 ms - select 1/4 HZ
> + * 5000 ms <= period - return -1
> + */
> +static int cht_wc_leds_find_freq(unsigned long period)
> +{
> +	if (period < 750)
> +		return CHT_WC_LED_F_2_HZ;
> +	else if (period < 1500)
> +		return CHT_WC_LED_F_1_HZ;
> +	else if (period < 3000)
> +		return CHT_WC_LED_F_1_2_HZ;
> +	else if (period < 5000)
> +		return CHT_WC_LED_F_1_4_HZ;
> +	else
> +		return -1;
> +}
> +
> +static int cht_wc_leds_blink_set(struct led_classdev *cdev,
> +				 unsigned long *delay_on,
> +				 unsigned long *delay_off)
> +{
> +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> +	unsigned int ctrl;
> +	int ret;

mutex needed as well.

> +	if (!*delay_on && !*delay_off) {
> +		/* Return current settings */
> +		ret = regmap_read(led->pmic->regmap, led->ctrl_reg, &ctrl);

Why read? This op sets blinking. Please refer to the blink_set semantics
description from include/linux/leds.h:

/*
  * Activate hardware accelerated blink, delays are in milliseconds
  * and if both are zero then a sensible default should be chosen.
  * The call should adjust the timings in that case and if it can't
  * match the values specified exactly.
  * Deactivate blinking again when the brightness is set to LED_OFF
  * via the brightness_set() callback.
  */
int             (*blink_set)(struct led_classdev *led_cdev,
                              unsigned long *delay_on,
                              unsigned long *delay_off);

Please compare how other LED class drivers do that.

> +
> +		if (ret < 0) {
> +			dev_err(cdev->dev,
> +				"Failed to read LED CTRL reg: %d\n", ret);
> +			return ret;
> +		}
> +
> +		*delay_off = *delay_on = cht_wc_leds_get_period(ctrl) / 2;
> +
> +		return 0;
> +	}
> +
> +	ctrl = cht_wc_leds_find_freq(*delay_on + *delay_off);
> +	if (ctrl < 0) {
> +		/* Disable HW blinking */
> +		ret = regmap_update_bits(led->pmic->regmap, led->fsm_reg,
> +					 CHT_WC_LED_EFF_MASK,
> +					 CHT_WC_LED_EFF_ON);
> +		if (ret < 0)
> +			dev_err(cdev->dev,
> +				"Failed to update LED FSM reg: %d\n", ret);
> +
> +		/* Fallback to software timer */
> +		*delay_on = *delay_off = 0;
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(led->pmic->regmap, led->fsm_reg,
> +				 CHT_WC_LED_EFF_MASK, CHT_WC_LED_EFF_BLINKING);
> +	if (ret < 0)
> +		dev_err(cdev->dev,
> +			"Failed to update LED FSM reg: %d\n", ret);
> +
> +	ret = regmap_update_bits(led->pmic->regmap, led->ctrl_reg,
> +				 CHT_WC_LED_F_MASK, ctrl);
> +	if (ret < 0)
> +		dev_err(cdev->dev,
> +			"Failed to update LED CTRL reg: %d\n", ret);
> +
> +	*delay_off = *delay_on = cht_wc_leds_get_period(ctrl) / 2;
> +
> +	return 0;
> +}
> +
> +static int cht_wc_leds_probe(struct platform_device *pdev)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cht_wc_leds); i++) {
> +		struct cht_wc_led *led = &cht_wc_leds[i];
> +
> +		led->pmic = pmic;
> +		led->cdev.name = cht_wc_leds[i].name;
> +		led->cdev.brightness_set_blocking = cht_wc_leds_brightness_set;
> +		led->cdev.brightness_get = cht_wc_leds_brightness_get;
> +		led->cdev.blink_set = cht_wc_leds_blink_set;
> +		led->cdev.max_brightness = 255;
> +
> +		ret = devm_led_classdev_register(&pdev->dev, &led->cdev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(pmic->regmap, CHT_WC_LED1_CTRL,
> +				 CHT_WC_LED1_SWCTL, 1);
> +
> +	if (ret)
> +		dev_err(&pdev->dev,
> +			"Failed to set SW control bit for charger LED: %d\n",
> +			ret);
> +
> +	platform_set_drvdata(pdev, cht_wc_leds);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id cht_wc_leds_table[] = {
> +	{ .name = "cht_wcove_leds" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, cht_wc_leds_table);
> +
> +static struct platform_driver cht_wc_leds_driver = {
> +	.probe = cht_wc_leds_probe,
> +	.id_table = cht_wc_leds_table,
> +	.driver = {
> +		.name = "cht_wcove_leds",
> +	},
> +};
> +module_platform_driver(cht_wc_leds_driver);
> +
> +MODULE_DESCRIPTION("Intel Cherrytrail Whiskey Cove PMIC LEDs driver");
> +MODULE_AUTHOR("Yauhen Kharuzhy <jekhor@gmail.com>");
> +MODULE_LICENSE("GPL");

s/GPL/GPL v2/

> +
> 

-- 
Best regards,
Jacek Anaszewski
