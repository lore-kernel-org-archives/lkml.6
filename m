Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1EBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA7F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9BOmU0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfBLIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:23:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34897 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfBLIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:23:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so1977673wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C9aPS+jAvFTrxRIe8c4Q6whOxRaODr/vBwvPBvjMRiU=;
        b=L9BOmU0WNwjzCPE9uROJuRE7n9BeMaejnGToyR+5/KM/OiV8jJm40RkUVbtS+7LZvu
         N/IqXxp96ibMqi12Ai0SuvRPZ/K0HXZ7hfdiSCBs0TUTGVlghghVmTguWS6Xt2rFiePw
         f00eQLLrJjqeAd2tX1LOlehdOPQYbtkBTeMFr1m+6oHDDBXGbN012Alwsuvv4tWshhhB
         yt1s1ODGxKeyJjqLJ2wm34D6jRoYtYwh/aaDZ4ZVNL66Ar3GhckeGYt7cXT8/4bevJ+s
         SkmZdK1NtiiE5kgBjUfruMhxZAGmBCRM3ecmLbXCUE6TB4tEsKCoNjNMOROBGcJjploj
         baJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C9aPS+jAvFTrxRIe8c4Q6whOxRaODr/vBwvPBvjMRiU=;
        b=qsjpFKXICTNkc28s1vdQ0SPefVy3AKcNXTeMYLX2JBJvxINu7Xg6bYBNUHotS6uLQY
         B+k10m2IUAsBjTi4UHmdnnNTdQaZE2Jc8kVdsi99m+imkcYv4De6H4CihlpaVGDCDmbH
         vGBRlA8AuKRO3BPtfCNEfk29ghy666FWqPPCAN0RXMzxYVgqBoj051zwO3iYAHe7GOjy
         EdKF4gWeEjRm8dUOq5dRluz/Xd6yyYm0YrjaMEZkR/XEWSakVDBfrww2T8axROMsoE5Y
         b0cXJH5Vl8LuDNt5yOQQh5ZS4rte0J9oAi764FGot4worTHCyYiOgdOKVhB+0AEO3tt7
         njqw==
X-Gm-Message-State: AHQUAuZYf/MB/mvVn5tFH+/+dqcXR0+Mye3qUIDFmnCDsBh3C6O1y12W
        8V+m+g91dUJXPpZydh3FiyaAJA==
X-Google-Smtp-Source: AHgI3IZCGZdQtdeeTRUFGeDhZ+S6BtZk0NMDkSLAMIIsdJWcFGn2NGvbZfQ3/mWzux9yhXHafV0Ghw==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr1875680wmb.80.1549959827258;
        Tue, 12 Feb 2019 00:23:47 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id h71sm5026197wme.20.2019.02.12.00.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:23:46 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:23:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 06/10] power: supply: max77650: add support for
 battery charger
Message-ID: <20190212082344.GS20638@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205091237.6448-7-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

Just waiting on your Ack for the set.

Could you review this please?

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add basic support for the battery charger for max77650 PMIC.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77650-charger.c | 355 ++++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/power/supply/max77650-charger.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..0230c96fa94d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -499,6 +499,13 @@ config CHARGER_DETECTOR_MAX14656
>  	  Revision 1.2 and can be found e.g. in Kindle 4/5th generation
>  	  readers and certain LG devices.
>  
> +config CHARGER_MAX77650
> +	tristate "Maxim MAX77650 battery charger driver"
> +	depends on MFD_MAX77650
> +	help
> +	  Say Y to enable support for the battery charger control of MAX77650
> +	  PMICs.
> +
>  config CHARGER_MAX77693
>  	tristate "Maxim MAX77693 battery charger driver"
>  	depends on MFD_MAX77693
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a9b695..b73eb8c5c1a9 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
>  obj-$(CONFIG_CHARGER_LTC3651)	+= ltc3651-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
> +obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
> new file mode 100644
> index 000000000000..7055c9b5ee24
> --- /dev/null
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 BayLibre SAS
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +//
> +// Battery charger driver for MAXIM 77650/77651 charger/power-supply.
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77650_CHARGER_ENABLED		BIT(0)
> +#define MAX77650_CHARGER_DISABLED		0x00
> +#define MAX77650_CHARGER_CHG_EN_MASK		BIT(0)
> +
> +#define MAX77650_CHARGER_CHG_DTLS_MASK		GENMASK(7, 4)
> +#define MAX77650_CHARGER_CHG_DTLS_BITS(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHG_DTLS_MASK) >> 4)
> +
> +#define MAX77650_CHARGER_CHG_OFF		0x00
> +#define MAX77650_CHARGER_CHG_PREQ		0x01
> +#define MAX77650_CHARGER_CHG_ON_CURR		0x02
> +#define MAX77650_CHARGER_CHG_ON_JCURR		0x03
> +#define MAX77650_CHARGER_CHG_ON_VOLT		0x04
> +#define MAX77650_CHARGER_CHG_ON_JVOLT		0x05
> +#define MAX77650_CHARGER_CHG_ON_TOPOFF		0x06
> +#define MAX77650_CHARGER_CHG_ON_JTOPOFF		0x07
> +#define MAX77650_CHARGER_CHG_DONE		0x08
> +#define MAX77650_CHARGER_CHG_JDONE		0x09
> +#define MAX77650_CHARGER_CHG_SUSP_PF		0x0a
> +#define MAX77650_CHARGER_CHG_SUSP_FCF		0x0b
> +#define MAX77650_CHARGER_CHG_SUSP_BTF		0x0c
> +
> +#define MAX77650_CHARGER_CHGIN_DTLS_MASK	GENMASK(3, 2)
> +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)
> +
> +#define MAX77650_CHARGER_CHGIN_UVL		0x00
> +#define MAX77650_CHARGER_CHGIN_OVL		0x01
> +#define MAX77650_CHARGER_CHGIN_OKAY		0x11
> +
> +#define MAX77650_CHARGER_CHG_MASK	BIT(1)
> +#define MAX77650_CHARGER_CHG_CHARGING(_reg) \
> +		(((_reg) & MAX77650_CHARGER_CHG_MASK) > 1)
> +
> +#define MAX77650_CHARGER_VCHGIN_MIN_MASK	0xc0
> +#define MAX77650_CHARGER_VCHGIN_MIN_SHIFT(_val)	((_val) << 5)
> +
> +#define MAX77650_CHARGER_ICHGIN_LIM_MASK	0x1c
> +#define MAX77650_CHARGER_ICHGIN_LIM_SHIFT(_val)	((_val) << 2)
> +
> +struct max77650_charger_data {
> +	struct regmap *map;
> +	struct device *dev;
> +};
> +
> +static enum power_supply_property max77650_charger_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE
> +};
> +
> +static const unsigned int max77650_charger_vchgin_min_table[] = {
> +	4000000, 4100000, 4200000, 4300000, 4400000, 4500000, 4600000, 4700000
> +};
> +
> +static const unsigned int max77650_charger_ichgin_lim_table[] = {
> +	95000, 190000, 285000, 380000, 475000
> +};
> +
> +static int max77650_charger_set_vchgin_min(struct max77650_charger_data *chg,
> +					   unsigned int val)
> +{
> +	int i, rv;
> +
> +	for (i = 0; i < ARRAY_SIZE(max77650_charger_vchgin_min_table); i++) {
> +		if (val == max77650_charger_vchgin_min_table[i]) {
> +			rv = regmap_update_bits(chg->map,
> +					MAX77650_REG_CNFG_CHG_B,
> +					MAX77650_CHARGER_VCHGIN_MIN_MASK,
> +					MAX77650_CHARGER_VCHGIN_MIN_SHIFT(i));
> +			if (rv)
> +				return rv;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int max77650_charger_set_ichgin_lim(struct max77650_charger_data *chg,
> +					   unsigned int val)
> +{
> +	int i, rv;
> +
> +	for (i = 0; i < ARRAY_SIZE(max77650_charger_ichgin_lim_table); i++) {
> +		if (val == max77650_charger_ichgin_lim_table[i]) {
> +			rv = regmap_update_bits(chg->map,
> +					MAX77650_REG_CNFG_CHG_B,
> +					MAX77650_CHARGER_ICHGIN_LIM_MASK,
> +					MAX77650_CHARGER_ICHGIN_LIM_SHIFT(i));
> +			if (rv)
> +				return rv;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void max77650_charger_enable(struct max77650_charger_data *chg)
> +{
> +	int rv;
> +
> +	rv = regmap_update_bits(chg->map,
> +				MAX77650_REG_CNFG_CHG_B,
> +				MAX77650_CHARGER_CHG_EN_MASK,
> +				MAX77650_CHARGER_ENABLED);
> +	if (rv)
> +		dev_err(chg->dev, "unable to enable the charger: %d\n", rv);
> +}
> +
> +static void max77650_charger_disable(struct max77650_charger_data *chg)
> +{
> +	int rv;
> +
> +	rv = regmap_update_bits(chg->map,
> +				MAX77650_REG_CNFG_CHG_B,
> +				MAX77650_CHARGER_CHG_EN_MASK,
> +				MAX77650_CHARGER_DISABLED);
> +	if (rv)
> +		dev_err(chg->dev, "unable to disable the charger: %d\n", rv);
> +}
> +
> +static irqreturn_t max77650_charger_check_status(int irq, void *data)
> +{
> +	struct max77650_charger_data *chg = data;
> +	int rv, reg;
> +
> +	rv = regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +	if (rv) {
> +		dev_err(chg->dev,
> +			"unable to read the charger status: %d\n", rv);
> +		return IRQ_HANDLED;
> +	}
> +
> +	switch (MAX77650_CHARGER_CHGIN_DTLS_BITS(reg)) {
> +	case MAX77650_CHARGER_CHGIN_UVL:
> +		dev_err(chg->dev, "undervoltage lockout detected, disabling charger\n");
> +		max77650_charger_disable(chg);
> +		break;
> +	case MAX77650_CHARGER_CHGIN_OVL:
> +		dev_err(chg->dev, "overvoltage lockout detected, disabling charger\n");
> +		max77650_charger_disable(chg);
> +		break;
> +	case MAX77650_CHARGER_CHGIN_OKAY:
> +		max77650_charger_enable(chg);
> +		break;
> +	default:
> +		/* May be 0x10 - debouncing */
> +		break;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max77650_charger_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	struct max77650_charger_data *chg = power_supply_get_drvdata(psy);
> +	int rv, reg;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		rv = regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +		if (rv)
> +			return rv;
> +
> +		if (MAX77650_CHARGER_CHG_CHARGING(reg)) {
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +		}
> +
> +		switch (MAX77650_CHARGER_CHG_DTLS_BITS(reg)) {
> +		case MAX77650_CHARGER_CHG_OFF:
> +		case MAX77650_CHARGER_CHG_SUSP_PF:
> +		case MAX77650_CHARGER_CHG_SUSP_FCF:
> +		case MAX77650_CHARGER_CHG_SUSP_BTF:
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			break;
> +		case MAX77650_CHARGER_CHG_PREQ:
> +		case MAX77650_CHARGER_CHG_ON_CURR:
> +		case MAX77650_CHARGER_CHG_ON_JCURR:
> +		case MAX77650_CHARGER_CHG_ON_VOLT:
> +		case MAX77650_CHARGER_CHG_ON_JVOLT:
> +		case MAX77650_CHARGER_CHG_ON_TOPOFF:
> +		case MAX77650_CHARGER_CHG_ON_JTOPOFF:
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +		case MAX77650_CHARGER_CHG_DONE:
> +			val->intval = POWER_SUPPLY_STATUS_FULL;
> +			break;
> +		default:
> +			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		rv = regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +		if (rv)
> +			return rv;
> +
> +		val->intval = MAX77650_CHARGER_CHG_CHARGING(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		rv = regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +		if (rv)
> +			return rv;
> +
> +		if (!MAX77650_CHARGER_CHG_CHARGING(reg)) {
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			break;
> +		}
> +
> +		switch (MAX77650_CHARGER_CHG_DTLS_BITS(reg)) {
> +		case MAX77650_CHARGER_CHG_PREQ:
> +		case MAX77650_CHARGER_CHG_ON_CURR:
> +		case MAX77650_CHARGER_CHG_ON_JCURR:
> +		case MAX77650_CHARGER_CHG_ON_VOLT:
> +		case MAX77650_CHARGER_CHG_ON_JVOLT:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +			break;
> +		case MAX77650_CHARGER_CHG_ON_TOPOFF:
> +		case MAX77650_CHARGER_CHG_ON_JTOPOFF:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		default:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct power_supply_desc max77650_battery_desc = {
> +	.name		= "max77650",
> +	.type		= POWER_SUPPLY_TYPE_USB,
> +	.get_property	= max77650_charger_get_property,
> +	.properties	= max77650_charger_properties,
> +	.num_properties	= ARRAY_SIZE(max77650_charger_properties),
> +};
> +
> +static int max77650_charger_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config pscfg = {};
> +	struct max77650_charger_data *chg;
> +	struct power_supply *battery;
> +	struct device *dev, *parent;
> +	int rv, chg_irq, chgin_irq;
> +	unsigned int prop;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +
> +	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, chg);
> +
> +	chg->map = dev_get_regmap(parent, NULL);
> +	if (!chg->map)
> +		return -ENODEV;
> +
> +	chg->dev = dev;
> +
> +	pscfg.of_node = dev->of_node;
> +	pscfg.drv_data = chg;
> +
> +	chg_irq = platform_get_irq_byname(pdev, "CHG");
> +	if (chg_irq < 0)
> +		return chg_irq;
> +
> +	chgin_irq = platform_get_irq_byname(pdev, "CHGIN");
> +	if (chgin_irq < 0)
> +		return chgin_irq;
> +
> +	rv = devm_request_any_context_irq(dev, chg_irq,
> +					  max77650_charger_check_status,
> +					  IRQF_ONESHOT, "chg", chg);
> +	if (rv < 0)
> +		return rv;
> +
> +	rv = devm_request_any_context_irq(dev, chgin_irq,
> +					  max77650_charger_check_status,
> +					  IRQF_ONESHOT, "chgin", chg);
> +	if (rv < 0)
> +		return rv;
> +
> +	battery = devm_power_supply_register(dev,
> +					     &max77650_battery_desc, &pscfg);
> +	if (IS_ERR(battery))
> +		return PTR_ERR(battery);
> +
> +	rv = of_property_read_u32(dev->of_node, "maxim,vchgin-min", &prop);
> +	if (rv == 0) {
> +		rv = max77650_charger_set_vchgin_min(chg, prop);
> +		if (rv)
> +			return rv;
> +	}
> +
> +	rv = of_property_read_u32(dev->of_node, "maxim,ichgin-lim", &prop);
> +	if (rv == 0) {
> +		rv = max77650_charger_set_ichgin_lim(chg, prop);
> +		if (rv)
> +			return rv;
> +	}
> +
> +	return regmap_update_bits(chg->map,
> +				  MAX77650_REG_CNFG_CHG_B,
> +				  MAX77650_CHARGER_CHG_EN_MASK,
> +				  MAX77650_CHARGER_ENABLED);
> +}
> +
> +static int max77650_charger_remove(struct platform_device *pdev)
> +{
> +	struct max77650_charger_data *chg = platform_get_drvdata(pdev);
> +
> +	return regmap_update_bits(chg->map,
> +				  MAX77650_REG_CNFG_CHG_B,
> +				  MAX77650_CHARGER_CHG_EN_MASK,
> +				  MAX77650_CHARGER_DISABLED);
> +}
> +
> +static struct platform_driver max77650_charger_driver = {
> +	.driver = {
> +		.name = "max77650-charger",
> +	},
> +	.probe = max77650_charger_probe,
> +	.remove = max77650_charger_remove,
> +};
> +module_platform_driver(max77650_charger_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 charger driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
