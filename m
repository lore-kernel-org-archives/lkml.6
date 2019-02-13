Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39612082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395297AbfBMWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:43:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44894 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388771AbfBMWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:43:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so3371845edw.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GtDih4D0vy/l+e1jHHRmIPEHZl1GE6fjvQFYie1z6tI=;
        b=dUqN6P2dq6f70zw1TSqW9Qa07SNL9xxmZVSQGRN5rjwyI0S1V/265JN/TPSycRJ70g
         V8WSG4e0HioO7EP8ZzDjlzo3BT61xpUoxrr3L+MAEcWZXHoB+ufQvSZGfIf+lDXodVE/
         f9Mx1DX3cIYfv8B7qqlmDKt2ASkFYqIa6E/XTIhJWXF2OlB+WqzjEONoG8IuOcYxNS2S
         UenhOQxk65YYj1MBShf6sjvAlTbXtPaciIqoYgkE/3E5Tdv/J8pV+e1yy+5qS3gt4Ytg
         6XFGX5UxLHXwqWSrOk/RA22UfEYSp2yIU7K3Znm56XTHfGubdhqZO6htmOmNktCbv3Ia
         QP2w==
X-Gm-Message-State: AHQUAuZcgGOcvD0gdXT0/haT5XP570tRCzsTfmqfbeUoFXUhteSO1LuS
        XrHoirxsO+xsTiV7BSNcCAxS3A==
X-Google-Smtp-Source: AHgI3IYz5sh2ozbKAVMNRpOWySF+nWSoHo29q5gRe+0zEvDdrZkeefMgtrGIanKHFzjNcXkDSJI/OA==
X-Received: by 2002:a17:906:5fc9:: with SMTP id k9mr315951ejv.206.1550097811491;
        Wed, 13 Feb 2019 14:43:31 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p93sm156639edp.7.2019.02.13.14.43.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:43:30 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
Date:   Wed, 13 Feb 2019 23:43:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190212205901.13037-2-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-02-19 21:59, Yauhen Kharuzhy wrote:
> Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
> PMIC. Charger and general-purpose leds are supported. Hardware blinking
> is implemented, breathing is not.
> 
> This driver was tested with Lenovo Yoga Book notebook.

Thank you for working on this. The CHT Whiskey Cove PMIC is
also used on the GPD win and GPD pocket devices and there LED1
by default indicates the charging status.

Since your driver forces the LED into SWCTL mode on probe()
this means that any kernel with it enabled will break the
charging LEDs OOTB function, this is undesirable.

I believe it would be best to add a custom "mode" attribute
to the led classdev, with "manual" and "on-when-charging"
modes, this would then control bits 0-1 of reg 0x5e1f and
by default these bits should be left as is when the driver
loads.

Note that in my experience the "charging" mode only works
when bits 0-1 have the value 10. I've some written notes from
when I played with this myself and they say:

    -CHT WC powerled control 0x5e1f: bits 0-1:
     0: ????
     1: Off
     2: On when charging
     3: On
    -CHT WC powerled pattern control 0x5e20: bits 1-2:
     0: Off
     1: On
     2: Blinking
     3: Glowing

Also note that the 0x5e20 notes do not match with your
defines, I believe this is a small bug in your code, see
comments in line below.

As for the 0x5e20 settings, I believe another custom
sysfs attribute, called "breathing" would be a good idea to
export the breathing functionality.

The way I see this working is that writing "1" to this will
turn on glowing mode, and writing 0 to it, or 0 to brightness
will turn it off. Reading it will return 1/0 depending on
whether the LED is in glowing mode or not.

For an example of adding custom sysfs attributes to a
led-class device see kbd_led_groups and kbd_led_attrs in:
drivers/platform/x86/dell-laptop.c

> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/leds/Kconfig          |  11 ++
>   drivers/leds/Makefile         |   1 +
>   drivers/leds/leds-cht-wcove.c | 293 ++++++++++++++++++++++++++++++++++
>   3 files changed, 305 insertions(+)
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
> index 000000000000..ee4287f8e806
> --- /dev/null
> +++ b/drivers/leds/leds-cht-wcove.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Driver for LEDs connected to the Intel Cherry Trail Whiskey Cove PMIC
> +//
> +// Copyright 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> +//
> +// Based on Lenovo Yoga Book Android kernel sources
> +
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

So your MASK is correct here, but the values used should
be based on that, so you get:

#define CHT_WC_LED_EFF_ON		(1 << 1)
#define CHT_WC_LED_EFF_BLINKING		(2 << 1)
#define CHT_WC_LED_EFF_BREATHING	(3 << 1)

Note that this effectively only changes the value of
CHT_WC_LED_EFF_BREATHING, so that it now to fits in your
mask.

Regards,

Hans




> +
> +struct cht_wc_led {
> +	struct led_classdev cdev;
> +	struct intel_soc_pmic *pmic;
> +	const char *name;
> +	const char *default_trigger;
> +	struct mutex mutex;
> +	u16	ctrl_reg;
> +	u8	enable_mask;
> +	u16	fsm_reg;
> +	u16	pwm_reg;
> +};
> +
> +static struct cht_wc_led cht_wc_leds[] = {
> +	{
> +		.name = "platform::charging",
> +		.default_trigger = "bq27542-0-charging-blink-full-solid",
> +		.ctrl_reg = CHT_WC_LED1_CTRL,
> +		.fsm_reg = CHT_WC_LED1_FSM,
> +		.pwm_reg = CHT_WC_LED1_PWM,
> +		.enable_mask = CHT_WC_LED1_ON,
> +	},
> +	{
> +		.name = "status-led::",
> +		.default_trigger = "default-on",
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
> +
> +	mutex_lock(&led->mutex);
> +
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
> +
> +	mutex_unlock(&led->mutex);
> +
> +	return ret;
> +}
> +
> +enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
> +{
> +	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
> +	int ret;
> +	unsigned int val;
> +
> +	mutex_lock(&led->mutex);
> +
> +	ret = regmap_read(led->pmic->regmap, led->ctrl_reg, &val);
> +	if (ret < 0) {
> +		dev_err(cdev->dev, "Failed to read LED CTRL reg: %d\n", ret);
> +		ret = LED_OFF;
> +		goto done;
> +	}
> +
> +	val &= led->enable_mask;
> +
> +	if (!val) {
> +		ret = LED_OFF;
> +		goto done;
> +	}
> +
> +	ret = regmap_read(led->pmic->regmap, led->pwm_reg, &val);
> +	if (ret < 0) {
> +		dev_err(cdev->dev, "Failed to read LED PWM reg: %d\n", ret);
> +		ret = LED_ON;
> +		goto done;
> +	}
> +
> +	ret = val;
> +done:
> +	mutex_unlock(&led->mutex);
> +
> +	return ret;
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
> +
> +	mutex_lock(&led->mutex);
> +
> +	if (!*delay_on && !*delay_off)
> +		*delay_on = *delay_off = 1000;
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
> +		ret = -EINVAL;
> +		goto done;
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
> +done:
> +	mutex_unlock(&led->mutex);
> +
> +	return ret;
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
> +		mutex_init(&led->mutex);
> +		led->cdev.name = cht_wc_leds[i].name;
> +		led->cdev.brightness_set_blocking = cht_wc_leds_brightness_set;
> +		led->cdev.brightness_get = cht_wc_leds_brightness_get;
> +		led->cdev.blink_set = cht_wc_leds_blink_set;
> +		led->cdev.max_brightness = 255;
> +		led->cdev.default_trigger = led->default_trigger;
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
> +MODULE_DESCRIPTION("Intel Cherry Trail Whiskey Cove PMIC LEDs driver");
> +MODULE_AUTHOR("Yauhen Kharuzhy <jekhor@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> +
> 
