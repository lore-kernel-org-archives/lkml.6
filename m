Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F41C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A72086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLm/CTWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33A72086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeIHTQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeIHTQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:16:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E34A2086B;
        Sat,  8 Sep 2018 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536417023;
        bh=jxmp7M0M+ezeiWhJ86CB6JKrrXxAHfErCyTNhjusPow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JLm/CTWbJeiC0KrvKNrJLRo0c2hNP9schSvIbfQeKefRl5Ld7JWH8ht2R/MF2cR5f
         O0JjNez6ZMydhZ86/XgP7/CiIe04MVTosKFfmJiJTnGcnYMEVsnK6pvhsDy2bXbV/a
         L0qmTxi/Mf7To80KQC8Z6mH/O/n6x7k4Pym1z9xY=
Date:   Sat, 8 Sep 2018 15:30:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: adxl372: Add support for I2C communication
Message-ID: <20180908153018.5346f75c@archlinux>
In-Reply-To: <1536070352-5571-1-git-send-email-stefan.popa@analog.com>
References: <1536070352-5571-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 17:12:32 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The adxl372 is designed to communicate in either SPI or I2C protocol. It
> autodetects the format being used, requiring no configuration control to
> select the format.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied.

Thanks,

Jonathan
> ---
>  MAINTAINERS                     |  1 +
>  drivers/iio/accel/Kconfig       | 11 ++++++++
>  drivers/iio/accel/Makefile      |  1 +
>  drivers/iio/accel/adxl372.c     |  1 -
>  drivers/iio/accel/adxl372.h     |  2 ++
>  drivers/iio/accel/adxl372_i2c.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/accel/adxl372_i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2938632..2b9a364 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -549,6 +549,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/accel/adxl372.c
>  F:	drivers/iio/accel/adxl372_spi.c
> +F:	drivers/iio/accel/adxl372_i2c.c
>  F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
>  
>  AF9013 MEDIA DRIVER
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index bed5da8..7993a67 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -76,6 +76,17 @@ config ADXL372_SPI
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adxl372_spi.
>  
> +config ADXL372_I2C
> +	tristate "Analog Devices ADXL372 3-Axis Accelerometer I2C Driver"
> +	depends on I2C
> +	select ADXL372
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to add support for the Analog Devices ADXL372 triaxial
> +	  acceleration sensor.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adxl372_i2c.
> +
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index c9c5db9..56bd021 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
>  obj-$(CONFIG_ADXL372) += adxl372.o
> +obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
>  obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_spi.o
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index f1df89d..3b84cb2 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -26,7 +26,6 @@
>  #define ADXL372_DEVID			0x00
>  #define ADXL372_DEVID_MST		0x01
>  #define ADXL372_PARTID			0x02
> -#define ADXL372_REVID			0x03
>  #define ADXL372_STATUS_1		0x04
>  #define ADXL372_STATUS_2		0x05
>  #define ADXL372_FIFO_ENTRIES_2		0x06
> diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
> index 5da89b1..80a0aa9 100644
> --- a/drivers/iio/accel/adxl372.h
> +++ b/drivers/iio/accel/adxl372.h
> @@ -8,6 +8,8 @@
>  #ifndef _ADXL372_H_
>  #define _ADXL372_H_
>  
> +#define ADXL372_REVID	0x03
> +
>  int adxl372_probe(struct device *dev, struct regmap *regmap,
>  		  int irq, const char *name);
>  bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg);
> diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
> new file mode 100644
> index 0000000..e1affe4
> --- /dev/null
> +++ b/drivers/iio/accel/adxl372_i2c.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL372 3-Axis Digital Accelerometer I2C driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "adxl372.h"
> +
> +static const struct regmap_config adxl372_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.readable_noinc_reg = adxl372_readable_noinc_reg,
> +};
> +
> +static int adxl372_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	unsigned int regval;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &adxl372_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_read(regmap, ADXL372_REVID, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Starting with the 3rd revision an I2C chip bug was fixed */
> +	if (regval < 3)
> +		dev_warn(&client->dev,
> +		"I2C might not work properly with other devices on the bus");
> +
> +	return adxl372_probe(&client->dev, regmap, client->irq, id->name);
> +}
> +
> +static const struct i2c_device_id adxl372_i2c_id[] = {
> +	{ "adxl372", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
> +
> +static struct i2c_driver adxl372_i2c_driver = {
> +	.driver = {
> +		.name = "adxl372_i2c",
> +	},
> +	.probe = adxl372_i2c_probe,
> +	.id_table = adxl372_i2c_id,
> +};
> +
> +module_i2c_driver(adxl372_i2c_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
> +MODULE_LICENSE("GPL");

