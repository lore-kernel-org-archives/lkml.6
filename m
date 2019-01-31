Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4765C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FCA20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+qSiaHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfAaViJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:38:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAaViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:38:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so4975254wrb.2;
        Thu, 31 Jan 2019 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m51owCmAzqpdPIe0bel5kuQfssDl03B7H1XZ+TMrpvE=;
        b=p+qSiaHlme55YOE4KHbPlGef1PkFAzihUO9+js13248WFWRW1ygbC2JanzQirbZl1d
         gY06IJmJHLiaFULD+gXlkiKyR7C2WCn0rShs7SHKMrN1PgjeFVO6DP3N5Tt3ymJFImZV
         qdhbrBMqbNfwfZYdz45RKx08fK9KdXywzsJJBecFZ+JYVukbx9EI9U1gH2Ao013cUzzD
         PJoT3E7h/s7+xmHLQITxgqfaOD6l/Hyg9BLV7x+fivkMn16sJzppXuj9Fq9cRERRGeI+
         omnAslJvWMzFEHUkWNuOjNKqZtvWOEMJJBSV5RgxBqzXzITVNolimF/AsEAldlyuP4vM
         LvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m51owCmAzqpdPIe0bel5kuQfssDl03B7H1XZ+TMrpvE=;
        b=SMBZSXdhay5WyOnkL2grTPcozmqpvNgH0xcUMP7cy0Uze47jwAWd82WVn6Hv7uft4G
         55UJVm2zBP6dB1gSa8CQ9Ph2I3Vm4v+/5JBPpQXAry9T7J2k/QYAtWc3Oe07FXjMnYaw
         c8CJZ6teDum6oIVTPdz2iP1HVESne50sL8rya12eBrZR6O0n8dfdPfiduEjiUYOvLprc
         WsgIBqKYdSzQSofiFefBtQuNbsNoeXqMy1Hpl+ptkGUuSz0MMtFGsKiqyEtYog1DPExD
         Y22Tmwj5qo0Qw0AerZDnb8EBugNkAo77jktLDNFLjz/5mRwTs2SFqijv9msopPnK2Krd
         pHew==
X-Gm-Message-State: AJcUukcIFcC+rhWHjdApx3vgEO+5Ae0zRY2XLg0MrcscwZAX8cUtT10V
        ZtNGqzVzIE3Gkp3bhW3Y5PdZrOX9
X-Google-Smtp-Source: ALg8bN6oXHTI48tvjYr85Ld5mV7XVuWjjDdmEaxrexG1SZpGL3sLe/lkDMttnNjoHzPaHn7tCOpguQ==
X-Received: by 2002:adf:e846:: with SMTP id d6mr36883794wrn.72.1548970685280;
        Thu, 31 Jan 2019 13:38:05 -0800 (PST)
Received: from [192.168.1.18] (chf233.neoplus.adsl.tpnet.pl. [83.31.3.233])
        by smtp.gmail.com with ESMTPSA id l14sm8102767wrp.55.2019.01.31.13.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 13:38:04 -0800 (PST)
Subject: Re: [PATCH 1/5] leds: Add support for AXP20X CHGLED
To:     Stefan Mavrodiev <stefan@olimex.com>, Pavel Machek <pavel@ucw.cz>,
        Chen-Yu Tsai <wens@csie.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
References: <20190131082308.22522-1-stefan@olimex.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c6901193-78d7-65c7-4528-3f526e5fe4b1@gmail.com>
Date:   Thu, 31 Jan 2019 22:38:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131082308.22522-1-stefan@olimex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch.

On 1/31/19 9:23 AM, Stefan Mavrodiev wrote:
> Most of AXP20x PMIC chips have built-in battery charger with LED indicator.
> The LED can be controlled ether by the charger or manually by a register.
> 
> The default is (except for AXP209) manual control, which makes this LED
> useless, since there is no device driver.
> 
> The driver rely on AXP20X MFD driver.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>   drivers/leds/Kconfig       |  10 ++
>   drivers/leds/Makefile      |   1 +
>   drivers/leds/leds-axp20x.c | 283 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 294 insertions(+)
>   create mode 100644 drivers/leds/leds-axp20x.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..82dce9063d41 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -766,6 +766,16 @@ config LEDS_NIC78BX
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called leds-nic78bx.
>   
> +config LEDS_AXP20X
> +	tristate "LED support for X-Powers PMICs"
> +	depends on MFD_AXP20X
> +	help
> +	  This option enables support for CHGLED found on most of X-Powers
> +	  PMICs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-axp20x.
> +
>   comment "LED Triggers"
>   source "drivers/leds/trigger/Kconfig"
>   
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4c1b0054f379..d3fb76e119d8 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -79,6 +79,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
>   obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
>   obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
>   obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
> +obj-$(CONFIG_LEDS_AXP20X)		+= leds-axp20x.o
>   
>   # LED SPI Drivers
>   obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
> diff --git a/drivers/leds/leds-axp20x.c b/drivers/leds/leds-axp20x.c
> new file mode 100644
> index 000000000000..9c03410833a3
> --- /dev/null
> +++ b/drivers/leds/leds-axp20x.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2019 Stefan Mavrodiev <stefan@olimex.com>
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/axp20x.h>
> +
> +#define AXP20X_CHGLED_CTRL_REG		AXP20X_OFF_CTRL
> +#define AXP20X_CHGLED_FUNC_MASK			GENMASK(5, 4)
> +#define AXP20X_CHGLED_FUNC_OFF			(0 << 4)
> +#define AXP20X_CHGLED_FUNC_1HZ			(1 << 4)
> +#define AXP20X_CHGLED_FUNC_4HZ			(2 << 4)
> +#define AXP20X_CHGLED_FUNC_FULL			(3 << 4)
> +#define AXP20X_CHGLED_CTRL_MASK			BIT(3)
> +#define AXP20X_CHGLED_CTRL_MANUAL		0
> +#define AXP20X_CHGLED_CTRL_CHARGER		1
> +#define AXP20X_CHGLED_CTRL(_ctrl)		(_ctrl << 3)
> +
> +#define AXP20X_CHGLED_MODE_REG		AXP20X_CHRG_CTRL2
> +#define AXP20X_CHGLED_MODE_MASK			BIT(4)
> +#define AXP20X_CHGLED_MODE_A			0
> +#define AXP20X_CHGLED_MODE_B			1
> +#define AXP20X_CHGLED_MODE(_mode)		(_mode << 4)
> +
> +struct axp20x_led {
> +	struct led_classdev cdev;
> +	enum led_brightness current_brightness;

You don't need this. Please use the one from struct led_classdev.

> +	u8 mode : 1;
> +	u8 ctrl : 1;
> +	u8 ctrl_inverted : 1;
> +	struct axp20x_dev *axp20x;
> +};
> +
> +static inline struct axp20x_led *to_axp20x_led(struct led_classdev *cdev)
> +{
> +	return container_of(cdev, struct axp20x_led, cdev);
> +}
> +
> +static int axp20x_led_setup(struct axp20x_led *priv)
> +{
> +	int ret;
> +	u8 val;
> +
> +	/* Invert the logic, if necessary */
> +	val = priv->ctrl ^ priv->ctrl_inverted;

You need mutex protection in all places where the hardware is accessed.
It is possible that brightness_set_blocking() will be called from
trigger e.g. after first regmap_update_bits_below().

> +
> +	ret = regmap_update_bits(priv->axp20x->regmap, AXP20X_CHGLED_CTRL_REG,
> +				 AXP20X_CHGLED_CTRL_MASK,
> +				 AXP20X_CHGLED_CTRL(val));
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(priv->axp20x->regmap, AXP20X_CHGLED_MODE_REG,
> +				  AXP20X_CHGLED_MODE_MASK,
> +				  AXP20X_CHGLED_MODE(priv->mode));
> +}
> +
> +static ssize_t control_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct led_classdev *cdev = dev_get_drvdata(dev);
> +	struct axp20x_led *priv = to_axp20x_led(cdev);
> +
> +	return sprintf(buf, "%d\n", priv->ctrl);

s/%d/%u/

> +}
> +
> +static ssize_t control_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t size)
> +{
> +	struct led_classdev *cdev = dev_get_drvdata(dev);
> +	struct axp20x_led *priv = to_axp20x_led(cdev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/**
> +	 * Supported values are:
> +	 *   - 0 : Manual control
> +	 *   - 1 : Charger control
> +	 */
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	priv->ctrl = val;
> +
> +	return axp20x_led_setup(priv) ? : size;
> +}
> +static DEVICE_ATTR_RW(control);
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct led_classdev *cdev = dev_get_drvdata(dev);
> +	struct axp20x_led *priv = to_axp20x_led(cdev);
> +
> +	return sprintf(buf, "%d\n", priv->mode);

Ditto.

> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t size)
> +{
> +	struct led_classdev *cdev = dev_get_drvdata(dev);
> +	struct axp20x_led *priv = to_axp20x_led(cdev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +	/**
> +	 * Supported values are:
> +	 *   - 0 : Mode A
> +	 *   - 1 : Mode B
> +	 */
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	priv->mode = val;
> +
> +	return axp20x_led_setup(priv) ? : size;
> +}
> +static DEVICE_ATTR_RW(mode);
> +
> +static struct attribute *axp20x_led_attrs[] = {
> +	&dev_attr_control.attr,
> +	&dev_attr_mode.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(axp20x_led);
> +
> +enum led_brightness axp20x_led_brightness_get(struct led_classdev *cdev)
> +{
> +	struct axp20x_led *priv = to_axp20x_led(cdev);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(priv->axp20x->regmap, AXP20X_CHGLED_CTRL_REG, &val);
> +	if (ret < 0)
> +		return LED_OFF;
> +
> +	return (val & AXP20X_CHGLED_FUNC_FULL) ? LED_FULL : LED_OFF;
> +}
> +
> +static int axp20x_led_brightness_set_blocking(struct led_classdev *cdev,
> +					      enum led_brightness brightness)
> +{
> +	struct axp20x_led *priv = to_axp20x_led(cdev);
> +	int ret = 0;
> +
> +	if (!priv->current_brightness && brightness)
> +		ret = regmap_update_bits(priv->axp20x->regmap,
> +					 AXP20X_CHGLED_CTRL_REG,
> +					 AXP20X_CHGLED_FUNC_MASK,
> +					 AXP20X_CHGLED_FUNC_FULL);
> +	else if (priv->current_brightness && !brightness)
> +		ret = regmap_update_bits(priv->axp20x->regmap,
> +					 AXP20X_CHGLED_CTRL_REG,
> +					 AXP20X_CHGLED_FUNC_MASK,
> +					 AXP20X_CHGLED_FUNC_OFF);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->current_brightness = brightness;
> +	return 0;
> +}
> +
> +static int axp20x_led_parse_dt(struct axp20x_led *priv, struct device_node *np)
> +{
> +	const char *state;
> +	int ret = 0;
> +	u8 value;
> +
> +	priv->cdev.name = of_get_property(np, "label", NULL) ? : np->name;

We now compose LED names differently. Please refer e.g. to:
drivers/leds/leds-cr0014114.c.

> +
> +	if (!of_property_read_u8(np, "x-powers,charger-mode", &value)) {
> +		priv->ctrl = AXP20X_CHGLED_CTRL_CHARGER;
> +		priv->mode = (value < 2) ? value : 0;
> +	} else {
> +		priv->ctrl = AXP20X_CHGLED_CTRL_MANUAL;
> +	}
> +
> +	priv->cdev.default_trigger = of_get_property(np,
> +						     "linux,default-trigger",
> +						     NULL);
> +
> +	state = of_get_property(np, "default-state", NULL);
> +	if (state) {
> +		if (!strcmp(state, "keep")) {
> +			ret = axp20x_led_brightness_get(&priv->cdev);
> +			if (ret < 0)
> +				return ret;
> +			priv->current_brightness = ret;
> +		} else if (!strcmp(state, "on")) {
> +			ret = axp20x_led_brightness_set_blocking(&priv->cdev,
> +								 LED_FULL);
> +		} else  {
> +			ret = axp20x_led_brightness_set_blocking(&priv->cdev,
> +								 LED_OFF);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id axp20x_led_of_match[] = {
> +	{ .compatible = "x-powers,axp20x-led" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_led_of_match);
> +
> +static int axp20x_led_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_led *priv;
> +	int ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_led),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->axp20x = dev_get_drvdata(pdev->dev.parent);
> +	if (!priv->axp20x) {
> +		dev_err(&pdev->dev, "Failed to get parent data\n");
> +		return -ENXIO;
> +	}
> +
> +	priv->cdev.max_brightness = LED_FULL;

LED core will initialize it to LED_FULL when set to 0 by kzalloc().

> +	priv->cdev.brightness_set_blocking = axp20x_led_brightness_set_blocking;
> +	priv->cdev.brightness_get = axp20x_led_brightness_get;
> +	priv->cdev.groups = axp20x_led_groups;
> +
> +	ret = axp20x_led_parse_dt(priv, pdev->dev.of_node);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set parameters\n");
> +		return ret;
> +	}
> +
> +	/**
> +	 * For some reason in AXP209 the bit that controls CHGLED is with
> +	 * inverted logic compared to all other PMICs.
> +	 * If the PMIC is actually AXP209, set inverted flag and later use it
> +	 * when configuring the LED.
> +	 */
> +	if (priv->axp20x->variant == AXP209_ID)
> +		priv->ctrl_inverted = 1;
> +
> +	ret =  axp20x_led_setup(priv);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to configure led");
> +		return ret;
> +	}
> +
> +	return devm_led_classdev_register(&pdev->dev, &priv->cdev);
> +}
> +
> +static struct platform_driver axp20x_led_driver = {
> +	.driver = {
> +		.name	= "axp20x-led",
> +		.of_match_table = of_match_ptr(axp20x_led_of_match),
> +	},
> +	.probe = axp20x_led_probe,
> +};
> +
> +module_platform_driver(axp20x_led_driver);
> +
> +MODULE_AUTHOR("Stefan Mavrodiev <stefan@olimex.com");
> +MODULE_DESCRIPTION("X-Powers PMIC CHGLED driver");
> +MODULE_LICENSE("GPL");
> 

-- 
Best regards,
Jacek Anaszewski
