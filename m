Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5457AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041A12184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SS0sAaeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfBLIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:36:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfBLIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:36:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so1986111wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P0voprnzgezARcYBZziF5IobeEFP7CGwDdpJV/qLzAg=;
        b=SS0sAaeUibC9r4YjPiyLEx9w4FOTwK37W08iBJy7Ysz0+UuHA0OOcua69ioYJr9Eop
         EP8AKjgirfjcpu86fKHp+YEZoH48el6BcLWjMuSY9zoAZo9+7Fv0cDBrmwlRxjCvEtMX
         jY6aKdasY052cIfovCtSjsHb1B26EDtPPtl4Me7DTPHGvSeZCFB9sonx5hlwZiwKmOo3
         6uLUnBgS6VvT3a7PboBpqYbb9DeLwtQBjRiLVEuXgW9YCAHpkoZvpsvJcSLfc1mM+c3V
         ABD+63cOTRWhwLuXg/9UFeDUqC5GwxXnAqNtfD3GCMe2DXG4elWUBg1YlW//hN662YWc
         nPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P0voprnzgezARcYBZziF5IobeEFP7CGwDdpJV/qLzAg=;
        b=YRJ8GjFgm7wupWbcqbnLu0eMHniPR0063XADptTrJhv7t1z9m64Foy5SA0TELxISxx
         ccZra0I0echQS+oVc00qvwTDVVwk1xBX7+UZbd7cRfr8mZtLbmkwPForHAqTe2psflHX
         lFA8t2Eon4SjdOmcYIFk2hXfU97etM+OY0Jlqtf5oLYkDyDlQFfdn6cJQrIoGEOakBJl
         zosguhzf6reYMeNBPXxXtn8gp8pJpKMIHQy0DdDMuIArfSN1vjPr1n17rKpYFmcmY9th
         UgvDgnI2Ybl8AVSyAHGWefjJ0osQivqqbtiaN1Hbyf6eWouwUpKCq5XZPK6LKTB8XAVK
         MX6g==
X-Gm-Message-State: AHQUAuYQWDMlSplKEOu+r70KDJY2u6X4bjudy/+v92zSNFyKknfnD2mx
        TLUX8bxdVdpPN65mL1TlVNis3Q==
X-Google-Smtp-Source: AHgI3IZnwPmFdWSTuBGruzWePG9eWfJkJEOhjpIMF4VR52u4wYWKES/TvtkXgL+qrH3AMh5qb0H3GA==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr1788881wmj.151.1549960605274;
        Tue, 12 Feb 2019 00:36:45 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id k23sm924695wmj.32.2019.02.12.00.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:36:44 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:36:42 +0000
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
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190212083642.GT20638@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205091237.6448-6-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Feb 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the core mfd driver for max77650 PMIC. We define five sub-devices
> for which the drivers will be added in subsequent patches.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mfd/Kconfig          |  11 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77650.c       | 342 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77650.h |  59 ++++++
>  4 files changed, 413 insertions(+)
>  create mode 100644 drivers/mfd/max77650.c
>  create mode 100644 include/linux/mfd/max77650.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 76f9909cf396..a80c3fe80fbe 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -734,6 +734,17 @@ config MFD_MAX77620
>  	  provides common support for accessing the device; additional drivers
>  	  must be enabled in order to use the functionality of the device.
>  
> +config MFD_MAX77650
> +	tristate "Maxim MAX77650/77651 PMIC Support"
> +	depends on I2C
> +	depends on OF || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to add support for Maxim Semiconductor MAX77650 and
> +	  MAX77651 Power Management ICs. This is the core multifunction
> +	  driver for interacting with the device.
> +
>  config MFD_MAX77686
>  	tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..3b912a4015d1 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -151,6 +151,7 @@ obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>  
>  obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
>  obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
> +obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
>  obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
> diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
> new file mode 100644
> index 000000000000..7c6164f1fde4
> --- /dev/null
> +++ b/drivers/mfd/max77650.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 BayLibre SAS
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +//
> +// Core MFD driver for MAXIM 77650/77651 charger/power-supply.
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define MAX77650_INT_GPI_F_MSK		BIT(0)
> +#define MAX77650_INT_GPI_R_MSK		BIT(1)
> +#define MAX77650_INT_GPI_MSK \
> +			(MAX77650_INT_GPI_F_MSK | MAX77650_INT_GPI_R_MSK)
> +#define MAX77650_INT_nEN_F_MSK		BIT(2)
> +#define MAX77650_INT_nEN_R_MSK		BIT(3)
> +#define MAX77650_INT_TJAL1_R_MSK	BIT(4)
> +#define MAX77650_INT_TJAL2_R_MSK	BIT(5)
> +#define MAX77650_INT_DOD_R_MSK		BIT(6)
> +
> +#define MAX77650_INT_THM_MSK		BIT(0)
> +#define MAX77650_INT_CHG_MSK		BIT(1)
> +#define MAX77650_INT_CHGIN_MSK		BIT(2)
> +#define MAX77650_INT_TJ_REG_MSK		BIT(3)
> +#define MAX77650_INT_CHGIN_CTRL_MSK	BIT(4)
> +#define MAX77650_INT_SYS_CTRL_MSK	BIT(5)
> +#define MAX77650_INT_SYS_CNFG_MSK	BIT(6)
> +
> +#define MAX77650_INT_GLBL_OFFSET	0
> +#define MAX77650_INT_CHG_OFFSET		1
> +
> +#define MAX77650_SBIA_LPM_MASK		BIT(5)
> +#define MAX77650_SBIA_LPM_DISABLED	0x00
> +
> +enum {
> +	MAX77650_INT_GPI = 0,
> +	MAX77650_INT_nEN_F,
> +	MAX77650_INT_nEN_R,
> +	MAX77650_INT_TJAL1_R,
> +	MAX77650_INT_TJAL2_R,
> +	MAX77650_INT_DOD_R,
> +	MAX77650_INT_THM,
> +	MAX77650_INT_CHG,
> +	MAX77650_INT_CHGIN,
> +	MAX77650_INT_TJ_REG,
> +	MAX77650_INT_CHGIN_CTRL,
> +	MAX77650_INT_SYS_CTRL,
> +	MAX77650_INT_SYS_CNFG,
> +};
> +
> +enum {
> +	MAX77650_CELL_REGULATOR = 0,
> +	MAX77650_CELL_CHARGER,
> +	MAX77650_CELL_GPIO,
> +	MAX77650_CELL_LED,
> +	MAX77650_CELL_ONKEY,
> +	MAX77650_NUM_CELLS,
> +};
> +
> +struct max77650_irq_mapping {
> +	int cell_num;
> +	const int *irqs;
> +	const char *const *irq_names;
> +	unsigned int num_irqs;
> +};
> +
> +static const int max77650_charger_irqs[] = {
> +	MAX77650_INT_CHG,
> +	MAX77650_INT_CHGIN,
> +};
> +
> +static const int max77650_gpio_irqs[] = {
> +	MAX77650_INT_GPI,
> +};
> +
> +static const int max77650_onkey_irqs[] = {
> +	MAX77650_INT_nEN_F,
> +	MAX77650_INT_nEN_R,
> +};
> +
> +static const char *const max77650_charger_irq_names[] = {
> +	"CHG",
> +	"CHGIN",
> +};
> +
> +static const char *const max77650_gpio_irq_names[] = {
> +	"GPI",
> +};
> +
> +static const char *const max77650_onkey_irq_names[] = {
> +	"nEN_F",
> +	"nEN_R",
> +};
> +
> +static const struct max77650_irq_mapping max77650_irq_mapping_table[] = {
> +	{
> +		.cell_num	= MAX77650_CELL_CHARGER,
> +		.irqs		= max77650_charger_irqs,
> +		.irq_names	= max77650_charger_irq_names,
> +		.num_irqs	= ARRAY_SIZE(max77650_charger_irqs),
> +	},
> +	{
> +		.cell_num	= MAX77650_CELL_GPIO,
> +		.irqs		= max77650_gpio_irqs,
> +		.irq_names	= max77650_gpio_irq_names,
> +		.num_irqs	= ARRAY_SIZE(max77650_gpio_irqs),
> +	},
> +	{
> +		.cell_num	= MAX77650_CELL_ONKEY,
> +		.irqs		= max77650_onkey_irqs,
> +		.irq_names	= max77650_onkey_irq_names,
> +		.num_irqs	= ARRAY_SIZE(max77650_onkey_irqs),
> +	},
> +};

This is all a bit convoluted and nasty TBH.

> +static const struct mfd_cell max77650_cells[] = {
> +	[MAX77650_CELL_REGULATOR] = {
> +		.name		= "max77650-regulator",
> +		.of_compatible	= "maxim,max77650-regulator",
> +	},
> +	[MAX77650_CELL_CHARGER] = {
> +		.name		= "max77650-charger",
> +		.of_compatible	= "maxim,max77650-charger",
> +	},
> +	[MAX77650_CELL_GPIO] = {
> +		.name		= "max77650-gpio",
> +		.of_compatible	= "maxim,max77650-gpio",
> +	},
> +	[MAX77650_CELL_LED] = {
> +		.name		= "max77650-led",
> +		.of_compatible	= "maxim,max77650-led",
> +	},
> +	[MAX77650_CELL_ONKEY] = {
> +		.name		= "max77650-onkey",
> +		.of_compatible	= "maxim,max77650-onkey",
> +	},
> +};

Why are you numbering the cells?  There is no need to do this.

> +static const struct regmap_irq max77650_irqs[] = {
> +	[MAX77650_INT_GPI] = {
> +		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
> +		.mask			= MAX77650_INT_GPI_MSK,
> +		.type = {
> +			.type_falling_val	= MAX77650_INT_GPI_F_MSK,
> +			.type_rising_val	= MAX77650_INT_GPI_R_MSK,
> +			.types_supported	= IRQ_TYPE_EDGE_BOTH,
> +		},
> +	},
> +	[MAX77650_INT_nEN_F] = {
> +		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
> +		.mask			= MAX77650_INT_nEN_F_MSK,
> +	},
> +	[MAX77650_INT_nEN_R] = {
> +		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
> +		.mask			= MAX77650_INT_nEN_R_MSK,
> +	},
> +	[MAX77650_INT_TJAL1_R] = {
> +		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
> +		.mask			= MAX77650_INT_TJAL1_R_MSK,
> +	},
> +	[MAX77650_INT_TJAL2_R] = {
> +		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
> +		.mask			= MAX77650_INT_TJAL2_R_MSK,
> +	},
> +	[MAX77650_INT_DOD_R] = {
> +		.reg_offset		= MAX77650_INT_GLBL_OFFSET,
> +		.mask			= MAX77650_INT_DOD_R_MSK,
> +	},
> +	[MAX77650_INT_THM] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_THM_MSK,
> +	},
> +	[MAX77650_INT_CHG] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_CHG_MSK,
> +	},
> +	[MAX77650_INT_CHGIN] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_CHGIN_MSK,
> +	},
> +	[MAX77650_INT_TJ_REG] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_TJ_REG_MSK,
> +	},
> +	[MAX77650_INT_CHGIN_CTRL] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_CHGIN_CTRL_MSK,
> +	},
> +	[MAX77650_INT_SYS_CTRL] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_SYS_CTRL_MSK,
> +	},
> +	[MAX77650_INT_SYS_CNFG] = {
> +		.reg_offset		= MAX77650_INT_CHG_OFFSET,
> +		.mask			= MAX77650_INT_SYS_CNFG_MSK,
> +	},
> +};

If you get rid of all of the horrible hoop jumping in *_setup_irqs(),
you can use REGMAP_IRQ_REG() like everyone else does.

> +static const struct regmap_irq_chip max77650_irq_chip = {
> +	.name			= "max77650-irq",
> +	.irqs			= max77650_irqs,
> +	.num_irqs		= ARRAY_SIZE(max77650_irqs),
> +	.num_regs		= 2,
> +	.status_base		= MAX77650_REG_INT_GLBL,
> +	.mask_base		= MAX77650_REG_INTM_GLBL,
> +	.type_in_mask		= true,
> +	.type_invert		= true,
> +	.init_ack_masked	= true,
> +	.clear_on_unmask	= true,
> +};
> +
> +static const struct regmap_config max77650_regmap_config = {
> +	.name		= "max77650",
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +};
> +
> +static int max77650_setup_irqs(struct device *dev, struct mfd_cell *cells)
> +{
> +	const struct max77650_irq_mapping *mapping;
> +	struct regmap_irq_chip_data *irq_data;
> +	struct i2c_client *i2c;
> +	struct mfd_cell *cell;
> +	struct resource *res;
> +	struct regmap *map;
> +	int i, j, irq, rv;
> +
> +	i2c = to_i2c_client(dev);
> +
> +	map = dev_get_regmap(dev, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	rv = devm_regmap_add_irq_chip(dev, map, i2c->irq,
> +				      IRQF_ONESHOT | IRQF_SHARED, -1,

What is -1?  Are you sure this isn't defined somewhere?

> +				      &max77650_irq_chip, &irq_data);
> +	if (rv)
> +		return rv;
> +
> +	for (i = 0; i < ARRAY_SIZE(max77650_irq_mapping_table); i++) {
> +		mapping = &max77650_irq_mapping_table[i];
> +		cell = &cells[mapping->cell_num];
> +
> +		res = devm_kcalloc(dev, sizeof(*res),
> +				   mapping->num_irqs, GFP_KERNEL);
> +		if (!res)
> +			return -ENOMEM;
> +
> +		cell->resources = res;
> +		cell->num_resources = mapping->num_irqs;
> +
> +		for (j = 0; j < mapping->num_irqs; j++) {
> +			irq = regmap_irq_get_virq(irq_data, mapping->irqs[j]);
> +			if (irq < 0)
> +				return irq;
> +
> +			res[j].start = res[j].end = irq;
> +			res[j].flags = IORESOURCE_IRQ;
> +			res[j].name = mapping->irq_names[j];
> +		}
> +	}

This is the first time I've seen it done like this (and I hate it).

Why are you storing the virqs in resources?

I think this is highly irregular.

> +	return 0;
> +}
> +
> +static int max77650_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct mfd_cell *cells;
> +	struct regmap *map;
> +	unsigned int val;
> +	int rv;
> +
> +	map = devm_regmap_init_i2c(i2c, &max77650_regmap_config);
> +	if (IS_ERR(map))

What error messages does devm_regmap_init_i2c() report?  Does it print
out its own error messages internally?  If not it would be better to
provide a suitable error message here.

> +		return PTR_ERR(map);
> +
> +	rv = regmap_read(map, MAX77650_REG_CID, &val);
> +	if (rv)

Better to provide a suitable error message here.

> +		return rv;
> +
> +	switch (MAX77650_CID_BITS(val)) {
> +	case MAX77650_CID_77650A:
> +	case MAX77650_CID_77650C:
> +	case MAX77650_CID_77651A:
> +	case MAX77650_CID_77651B:
> +		break;
> +	default:

Better to provide a suitable error message here.

> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * This IC has a low-power mode which reduces the quiescent current
> +	 * consumption to ~5.6uA but is only suitable for systems consuming
> +	 * less than ~2mA. Since this is not likely the case even on
> +	 * linux-based wearables - keep the chip in normal power mode.
> +	 */
> +	rv = regmap_update_bits(map,
> +				MAX77650_REG_CNFG_GLBL,
> +				MAX77650_SBIA_LPM_MASK,
> +				MAX77650_SBIA_LPM_DISABLED);
> +	if (rv)

Better to provide a suitable error message here.

> +		return rv;
> +
> +	cells = devm_kmemdup(dev, max77650_cells,
> +			     sizeof(max77650_cells), GFP_KERNEL);
> +	if (!cells)
> +		return -ENOMEM;
> +
> +	rv = max77650_setup_irqs(dev, cells);
> +	if (rv)
> +		return rv;
> +
> +	return devm_mfd_add_devices(dev, -1, cells,

Use the correct defines instead of -1.

`git grep mfd_add_devices`

> +				    MAX77650_NUM_CELLS, NULL, 0, NULL);
> +}
> +
> +static const struct of_device_id max77650_of_match[] = {
> +	{ .compatible = "maxim,max77650" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77650_of_match);
> +
> +static struct i2c_driver max77650_i2c_driver = {
> +	.driver = {
> +		.name = "max77650",
> +		.of_match_table = of_match_ptr(max77650_of_match),
> +	},
> +	.probe_new = max77650_i2c_probe,
> +};
> +module_i2c_driver(max77650_i2c_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 multi-function core driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/max77650.h b/include/linux/mfd/max77650.h
> new file mode 100644
> index 000000000000..c809e211a8cd
> --- /dev/null
> +++ b/include/linux/mfd/max77650.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + *
> + * Common definitions for MAXIM 77650/77651 charger/power-supply.
> + */
> +
> +#ifndef MAX77650_H
> +#define MAX77650_H
> +
> +#include <linux/bits.h>
> +
> +#define MAX77650_REG_INT_GLBL		0x00
> +#define MAX77650_REG_INT_CHG		0x01
> +#define MAX77650_REG_STAT_CHG_A		0x02
> +#define MAX77650_REG_STAT_CHG_B		0x03
> +#define MAX77650_REG_ERCFLAG		0x04
> +#define MAX77650_REG_STAT_GLBL		0x05
> +#define MAX77650_REG_INTM_GLBL		0x06
> +#define MAX77650_REG_INTM_CHG		0x07
> +#define MAX77650_REG_CNFG_GLBL		0x10
> +#define MAX77650_REG_CID		0x11
> +#define MAX77650_REG_CNFG_GPIO		0x12
> +#define MAX77650_REG_CNFG_CHG_A		0x18
> +#define MAX77650_REG_CNFG_CHG_B		0x19
> +#define MAX77650_REG_CNFG_CHG_C		0x1a
> +#define MAX77650_REG_CNFG_CHG_D		0x1b
> +#define MAX77650_REG_CNFG_CHG_E		0x1c
> +#define MAX77650_REG_CNFG_CHG_F		0x1d
> +#define MAX77650_REG_CNFG_CHG_G		0x1e
> +#define MAX77650_REG_CNFG_CHG_H		0x1f
> +#define MAX77650_REG_CNFG_CHG_I		0x20
> +#define MAX77650_REG_CNFG_SBB_TOP	0x28
> +#define MAX77650_REG_CNFG_SBB0_A	0x29
> +#define MAX77650_REG_CNFG_SBB0_B	0x2a
> +#define MAX77650_REG_CNFG_SBB1_A	0x2b
> +#define MAX77650_REG_CNFG_SBB1_B	0x2c
> +#define MAX77650_REG_CNFG_SBB2_A	0x2d
> +#define MAX77650_REG_CNFG_SBB2_B	0x2e
> +#define MAX77650_REG_CNFG_LDO_A		0x38
> +#define MAX77650_REG_CNFG_LDO_B		0x39
> +#define MAX77650_REG_CNFG_LED0_A	0x40
> +#define MAX77650_REG_CNFG_LED1_A	0x41
> +#define MAX77650_REG_CNFG_LED2_A	0x42
> +#define MAX77650_REG_CNFG_LED0_B	0x43
> +#define MAX77650_REG_CNFG_LED1_B	0x44
> +#define MAX77650_REG_CNFG_LED2_B	0x45
> +#define MAX77650_REG_CNFG_LED_TOP	0x46
> +
> +#define MAX77650_CID_MASK		GENMASK(3, 0)
> +#define MAX77650_CID_BITS(_reg)		(_reg & MAX77650_CID_MASK)
> +
> +#define MAX77650_CID_77650A		0x03
> +#define MAX77650_CID_77650C		0x0a
> +#define MAX77650_CID_77651A		0x06
> +#define MAX77650_CID_77651B		0x08
> +
> +#endif /* MAX77650_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
