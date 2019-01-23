Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1D8218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323908;
	bh=HJ0D68f0FnhyyonQDtJeyMGBBrdEWrRCjElLR+Zdvq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y+oa/HvJrkJmw5oHMrvozKENv+RyxSlrL7eiZdNUP6sNXaanE9SrYa9Vgu7zcZbn3
	 9kaoWJXItG+q1VZjtdPCcFxhsWwd2atrEeLeHI0+/6SA24wo8b/duE3IThMOQXH5tH
	 yE+FQNqK7tBVttqY4DfXg6W0NgnGHfAxvVN+62SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfAXJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfAXJ6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:14 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F93218D9;
        Thu, 24 Jan 2019 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323892;
        bh=HJ0D68f0FnhyyonQDtJeyMGBBrdEWrRCjElLR+Zdvq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndXLvoGY7ybwPSHYvHEEJM917dtibsrXH2zDZH75zBeCvA2wrfdcHMJN9LgVcpqka
         jNyjMznFf8f0/RBhb2qMVG+5+Yrdr7U1uNJJQV28JjGE6wq29qzoVJqoAeBOo2qxpy
         htkwHydI41aP4HYGi+uF097L1zpYczzurGztv0zc=
Received: by earth.universe (Postfix, from userid 1000)
        id 6AE123C08DF; Wed, 23 Jan 2019 19:27:38 +0100 (CET)
Date:   Wed, 23 Jan 2019 19:27:38 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 09/13] power: supply: max77650: add support for battery
 charger
Message-ID: <20190123182738.wtskerasrzmrufrn@earth.universe>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l65ke3pvpc2acxdd"
Content-Disposition: inline
In-Reply-To: <20190118134244.22253-10-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l65ke3pvpc2acxdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

Looks mostly ok, I have a few comments inline towards the end.

On Fri, Jan 18, 2019 at 02:42:40PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add basic support for the battery charger for max77650 PMIC.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77650-charger.c | 347 ++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/power/supply/max77650-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..0230c96fa94d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -499,6 +499,13 @@ config CHARGER_DETECTOR_MAX14656
>  	  Revision 1.2 and can be found e.g. in Kindle 4/5th generation
>  	  readers and certain LG devices.
> =20
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
> @@ -70,6 +70,7 @@ obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
>  obj-$(CONFIG_CHARGER_LTC3651)	+=3D ltc3651-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
> +obj-$(CONFIG_CHARGER_MAX77650)	+=3D max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> new file mode 100644
> index 000000000000..fb9d8f933174
> --- /dev/null
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + *
> + * Battery charger driver for MAXIM 77650/77651 charger/power-supply.
> + */
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
> +static enum power_supply_property max77650_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE
> +};
> +
> +static const unsigned int max77650_charger_vchgin_min_table[] =3D {
> +	4000000, 4100000, 4200000, 4300000, 4400000, 4500000, 4600000, 4700000
> +};
> +
> +static const unsigned int max77650_charger_ichgin_lim_table[] =3D {
> +	95000, 190000, 285000, 380000, 475000
> +};
> +
> +static int max77650_charger_set_vchgin_min(struct max77650_charger_data =
*chg,
> +					   unsigned int val)
> +{
> +	int i, rv;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(max77650_charger_vchgin_min_table); i++) {
> +		if (val =3D=3D max77650_charger_vchgin_min_table[i]) {
> +			rv =3D regmap_update_bits(chg->map,
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
> +static int max77650_charger_set_ichgin_lim(struct max77650_charger_data =
*chg,
> +					   unsigned int val)
> +{
> +	int i, rv;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(max77650_charger_ichgin_lim_table); i++) {
> +		if (val =3D=3D max77650_charger_ichgin_lim_table[i]) {
> +			rv =3D regmap_update_bits(chg->map,
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
> +	rv =3D regmap_update_bits(chg->map,
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
> +	rv =3D regmap_update_bits(chg->map,
> +				MAX77650_REG_CNFG_CHG_B,
> +				MAX77650_CHARGER_CHG_EN_MASK,
> +				MAX77650_CHARGER_DISABLED);
> +	if (rv)
> +		dev_err(chg->dev, "unable to disable the charger: %d\n", rv);
> +}
> +
> +static irqreturn_t max77650_charger_check_status(int irq, void *data)
> +{
> +	struct max77650_charger_data *chg =3D data;
> +	int rv, reg;
> +
> +	rv =3D regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +	if (rv) {
> +		dev_err(chg->dev,
> +			"unable to read the charger status: %d\n", rv);
> +		return IRQ_HANDLED;
> +	}
> +
> +	switch (MAX77650_CHARGER_CHGIN_DTLS_BITS(reg)) {
> +	case MAX77650_CHARGER_CHGIN_UVL:
> +		dev_err(chg->dev, "undervoltage lockout detected, disabling charger\n"=
);
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
> +	struct max77650_charger_data *chg =3D power_supply_get_drvdata(psy);
> +	int rv, reg;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		rv =3D regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +		if (rv)
> +			return rv;
> +
> +		if (MAX77650_CHARGER_CHG_CHARGING(reg)) {
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +		}
> +
> +		switch (MAX77650_CHARGER_CHG_DTLS_BITS(reg)) {
> +		case MAX77650_CHARGER_CHG_OFF:
> +		case MAX77650_CHARGER_CHG_SUSP_PF:
> +		case MAX77650_CHARGER_CHG_SUSP_FCF:
> +		case MAX77650_CHARGER_CHG_SUSP_BTF:
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			break;
> +		case MAX77650_CHARGER_CHG_PREQ:
> +		case MAX77650_CHARGER_CHG_ON_CURR:
> +		case MAX77650_CHARGER_CHG_ON_JCURR:
> +		case MAX77650_CHARGER_CHG_ON_VOLT:
> +		case MAX77650_CHARGER_CHG_ON_JVOLT:
> +		case MAX77650_CHARGER_CHG_ON_TOPOFF:
> +		case MAX77650_CHARGER_CHG_ON_JTOPOFF:
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +		case MAX77650_CHARGER_CHG_DONE:
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			break;
> +		default:
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		rv =3D regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +		if (rv)
> +			return rv;
> +
> +		val->intval =3D MAX77650_CHARGER_CHG_CHARGING(reg);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		rv =3D regmap_read(chg->map, MAX77650_REG_STAT_CHG_B, &reg);
> +		if (rv)
> +			return rv;
> +
> +		if (!MAX77650_CHARGER_CHG_CHARGING(reg)) {
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			break;
> +		}
> +
> +		switch (MAX77650_CHARGER_CHG_DTLS_BITS(reg)) {
> +		case MAX77650_CHARGER_CHG_PREQ:
> +		case MAX77650_CHARGER_CHG_ON_CURR:
> +		case MAX77650_CHARGER_CHG_ON_JCURR:
> +		case MAX77650_CHARGER_CHG_ON_VOLT:
> +		case MAX77650_CHARGER_CHG_ON_JVOLT:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +			break;
> +		case MAX77650_CHARGER_CHG_ON_TOPOFF:
> +		case MAX77650_CHARGER_CHG_ON_JTOPOFF:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		default:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct power_supply_desc max77650_battery_desc =3D {
> +	.name		=3D "max77650",
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,

This is a charger, not a battery. BATTERY type is for the fuel
gauges. You should be using POWER_SUPPLY_TYPE_USB for USB based
battery chargers and POWER_SUPPLY_TYPE_MAINS otherwise.

> +	.get_property	=3D max77650_charger_get_property,
> +	.properties	=3D max77650_charger_properties,
> +	.num_properties	=3D ARRAY_SIZE(max77650_charger_properties),
> +};
> +
> +static int max77650_charger_probe(struct platform_device *pdev)
> +{
> +	struct regmap_irq_chip_data *irq_data;
> +	struct power_supply_config pscfg =3D {};
> +	struct max77650_charger_data *chg;
> +	struct power_supply *battery;
> +	struct device *dev, *parent;
> +	int rv, chg_irq, chgin_irq;
> +	struct i2c_client *i2c;
> +	unsigned int prop;
> +
> +	dev =3D &pdev->dev;
> +	parent =3D dev->parent;
> +	i2c =3D to_i2c_client(parent);
> +	irq_data =3D i2c_get_clientdata(i2c);
> +
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	chg->map =3D dev_get_regmap(parent, NULL);
> +	if (!chg->map)
> +		return -ENODEV;
> +
> +	chg->dev =3D dev;
> +
> +	pscfg.of_node =3D dev->of_node;
> +	pscfg.drv_data =3D chg;
> +
> +	chg_irq =3D regmap_irq_get_virq(irq_data, MAX77650_INT_CHG);
> +	if (chg_irq <=3D 0)
> +		return -EINVAL;
> +
> +	chgin_irq =3D regmap_irq_get_virq(irq_data, MAX77650_INT_CHGIN);
> +	if (chgin_irq <=3D 0)
> +		return -EINVAL;
> +
> +	rv =3D devm_request_threaded_irq(dev, chg_irq, NULL,
> +				       max77650_charger_check_status,
> +				       IRQF_ONESHOT, "chg", chg);
> +	if (rv)
> +		return rv;
> +
> +	rv =3D devm_request_threaded_irq(dev, chgin_irq, NULL,
> +				       max77650_charger_check_status,
> +				       IRQF_ONESHOT, "chgin", chg);
> +	if (rv)
> +		return rv;
> +
> +	battery =3D devm_power_supply_register(dev,
> +					     &max77650_battery_desc, &pscfg);
> +	if (IS_ERR(battery))
> +		return PTR_ERR(battery);
> +
> +	rv =3D of_property_read_u32(dev->of_node, "maxim,vchgin-min", &prop);
> +	if (rv =3D=3D 0) {
> +		rv =3D max77650_charger_set_vchgin_min(chg, prop);
> +		if (rv)
> +			return rv;
> +	}
> +
> +	rv =3D of_property_read_u32(dev->of_node, "maxim,ichgin-lim", &prop);
> +	if (rv =3D=3D 0) {
> +		rv =3D max77650_charger_set_ichgin_lim(chg, prop);
> +		if (rv)
> +			return rv;
> +	}
> +
> +	return regmap_update_bits(chg->map,
> +				  MAX77650_REG_CNFG_CHG_B,
> +				  MAX77650_CHARGER_CHG_EN_MASK,
> +				  MAX77650_CHARGER_ENABLED);

should this be disabled on module remove?

> +}
> +
> +static struct platform_driver max77650_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77650-charger",
> +	},
> +	.probe =3D max77650_charger_probe,
> +};
> +module_platform_driver(max77650_charger_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 charger driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL");

This is GPL2 or later, but "SPDX-License-Identifier: GPL-2.0" is not.

-- Sebastian

--l65ke3pvpc2acxdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIshcACgkQ2O7X88g7
+ppaFQ/+MilWAKunLL5jC5uZ+hE8DXIj3QLHKLYR7N1VbKuZ9gkIVP8SN3PLrZIg
PTpYB699fRP8I8ouyg2eaKRJP8OnNhTqvBGMSek4NIRzBFrKCKFC3RG6AbHT2F3y
ZdBI1GE0c0SP/YVHnWodeKVAoBRz0eSs2jq66p764qAjOJvGUKvCedHVhraFx74O
+Q+PZh1mNsGk6ZyR89v9Ow5Q21QAMqo5H0Kk9q7LHbDmlTTZOaWJnWmp4VdAUcCu
TGblwu4JSpciTRI3aK1CgHpQhncKKARTAPE9IvizL52ykmBf25bxCefYjRME/Quq
0VQUn42n6DoLjJVg8LZOHPJ+/0FHdcoxyvzDQOH7kz99S3fsvSJ4nJi6673dZK0X
xkKCWB2eV9yGfpm4NSRDtA1qhLfBKaAc1Dxfv/6WgdUHvXzzLxyKa4iG2dHnkVYJ
nEuypH2tk78qSEj6jOpBek53Sfxxd9osqZpnRTV5rEPEg9gUTDQ76je6Dry0mYDQ
F17hL1fT0gBfD19w12EzveuNoEpAbq9WzQlyZQIwTOaqZykt6rkjaCB/WNsyhDjj
9M9Jqr4feJTqiobNhjeY0yk+RDUIcyjTDn2nyClzB30CACFsCU2oiM8sbq5SLWb+
7x42oE7F7MorMYBMSzSjCt2sAoZPfmpyZQvTO1y47gX9Hw7YNV0=
=ha6j
-----END PGP SIGNATURE-----

--l65ke3pvpc2acxdd--
