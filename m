Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C6C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAB621473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBYPr/Dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAB621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeLBCyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:54:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C0920673;
        Sat,  1 Dec 2018 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543678892;
        bh=lO0ZEoKuRZ6H4kjCx0LGAwPGDMRttkxNWUgl4r/W85Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LBYPr/DrFEBeyaX2hB2uIpQmHJJVf4rMXp82Y5Yzf9GF9/nnmyBrzLrnEr2oJigFS
         2bc8FgTwFGHjPL1SUgQ6BXTox6tpkt2PRna2Y81E0Mxc7lQqAs3oA28HNApZOmKGm3
         ZwYIiAGwgT5trhDxM7dUyRR6vVW75CqUMDEx5ZQM=
Date:   Sat, 1 Dec 2018 15:41:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "victorcolombo@gmail.com" <victorcolombo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] staging:iio:ad2s90: Move out of staging
Message-ID: <20181201154127.4020c8a6@archlinux>
In-Reply-To: <a1b8b1fe23cd707e5988d42aa3d76e6daae5bd5e.camel@analog.com>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-8-matheus.bernardino@usp.br>
        <a1b8b1fe23cd707e5988d42aa3d76e6daae5bd5e.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 07:34:35 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2018-11-23 at 22:23 -0200, Matheus Tavares wrote:
> > Move ad2s90 resolver driver out of staging to the main tree.
> >   
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alexandru,

I took that to apply to the whole series, hope you don't mind.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> > ---
> > Changes in v3:
> >  - none
> > 
> > Changes in v2:
> >  - Disabled git move detection, to see the whole code, as Jonathan
> >  suggested
> > 
> >  drivers/iio/resolver/Kconfig          |  10 ++
> >  drivers/iio/resolver/Makefile         |   1 +
> >  drivers/iio/resolver/ad2s90.c         | 131 ++++++++++++++++++++++++++
> >  drivers/staging/iio/resolver/Kconfig  |  10 --
> >  drivers/staging/iio/resolver/Makefile |   1 -
> >  drivers/staging/iio/resolver/ad2s90.c | 131 --------------------------
> >  6 files changed, 142 insertions(+), 142 deletions(-)
> >  create mode 100644 drivers/iio/resolver/ad2s90.c
> >  delete mode 100644 drivers/staging/iio/resolver/ad2s90.c
> > 
> > diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
> > index 2ced9f22aa70..786801be54f6 100644
> > --- a/drivers/iio/resolver/Kconfig
> > +++ b/drivers/iio/resolver/Kconfig
> > @@ -3,6 +3,16 @@
> >  #
> >  menu "Resolver to digital converters"
> >  
> > +config AD2S90
> > +	tristate "Analog Devices ad2s90 driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Analog Devices spi resolver
> > +	  to digital converters, ad2s90, provides direct access via sysfs.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad2s90.
> > +
> >  config AD2S1200
> >  	tristate "Analog Devices ad2s1200/ad2s1205 driver"
> >  	depends on SPI
> > diff --git a/drivers/iio/resolver/Makefile
> > b/drivers/iio/resolver/Makefile
> > index 4e1dccae07e7..398d82d50028 100644
> > --- a/drivers/iio/resolver/Makefile
> > +++ b/drivers/iio/resolver/Makefile
> > @@ -2,4 +2,5 @@
> >  # Makefile for Resolver/Synchro drivers
> >  #
> >  
> > +obj-$(CONFIG_AD2S90) += ad2s90.o
> >  obj-$(CONFIG_AD2S1200) += ad2s1200.o
> > diff --git a/drivers/iio/resolver/ad2s90.c
> > b/drivers/iio/resolver/ad2s90.c
> > new file mode 100644
> > index 000000000000..a41f5cb10da5
> > --- /dev/null
> > +++ b/drivers/iio/resolver/ad2s90.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ad2s90.c simple support for the ADI Resolver to Digital Converters:
> > AD2S90
> > + *
> > + * Copyright (c) 2010-2010 Analog Devices Inc.
> > + */
> > +#include <linux/types.h>
> > +#include <linux/mutex.h>
> > +#include <linux/device.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +/*
> > + * Although chip's max frequency is 2Mhz, it needs 600ns between CS and
> > the
> > + * first falling edge of SCLK, so frequency should be at most 1 / (2 *
> > 6e-7)
> > + */
> > +#define AD2S90_MAX_SPI_FREQ_HZ  830000
> > +
> > +struct ad2s90_state {
> > +	struct mutex lock; /* lock to protect rx buffer */
> > +	struct spi_device *sdev;
> > +	u8 rx[2] ____cacheline_aligned;
> > +};
> > +
> > +static int ad2s90_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val,
> > +			   int *val2,
> > +			   long m)
> > +{
> > +	int ret;
> > +	struct ad2s90_state *st = iio_priv(indio_dev);
> > +
> > +	if (chan->type != IIO_ANGL)
> > +		return -EINVAL;
> > +
> > +	switch (m) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/* 2 * Pi / 2^12 */
> > +		*val = 6283; /* mV */
> > +		*val2 = 12;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&st->lock);
> > +		ret = spi_read(st->sdev, st->rx, 2);
> > +		if (ret < 0) {
> > +			mutex_unlock(&st->lock);
> > +			return ret;
> > +		}
> > +		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >>
> > 4);
> > +
> > +		mutex_unlock(&st->lock);
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info ad2s90_info = {
> > +	.read_raw = ad2s90_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec ad2s90_chan = {
> > +	.type = IIO_ANGL,
> > +	.indexed = 1,
> > +	.channel = 0,
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > BIT(IIO_CHAN_INFO_SCALE),
> > +};
> > +
> > +static int ad2s90_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct ad2s90_state *st;
> > +
> > +	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
> > +		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
> > +			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
> > +		return -EINVAL;
> > +	}
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +	st = iio_priv(indio_dev);
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	mutex_init(&st->lock);
> > +	st->sdev = spi;
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->info = &ad2s90_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = &ad2s90_chan;
> > +	indio_dev->num_channels = 1;
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +
> > +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > +}
> > +
> > +static const struct of_device_id ad2s90_of_match[] = {
> > +	{ .compatible = "adi,ad2s90", },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, ad2s90_of_match);
> > +
> > +static const struct spi_device_id ad2s90_id[] = {
> > +	{ "ad2s90" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(spi, ad2s90_id);
> > +
> > +static struct spi_driver ad2s90_driver = {
> > +	.driver = {
> > +		.name = "ad2s90",
> > +		.of_match_table = ad2s90_of_match,
> > +	},
> > +	.probe = ad2s90_probe,
> > +	.id_table = ad2s90_id,
> > +};
> > +module_spi_driver(ad2s90_driver);
> > +
> > +MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> > +MODULE_DESCRIPTION("Analog Devices AD2S90 Resolver to Digital SPI
> > driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/staging/iio/resolver/Kconfig
> > b/drivers/staging/iio/resolver/Kconfig
> > index 6a469ee6101f..4a727c17bb8f 100644
> > --- a/drivers/staging/iio/resolver/Kconfig
> > +++ b/drivers/staging/iio/resolver/Kconfig
> > @@ -3,16 +3,6 @@
> >  #
> >  menu "Resolver to digital converters"
> >  
> > -config AD2S90
> > -	tristate "Analog Devices ad2s90 driver"
> > -	depends on SPI
> > -	help
> > -	  Say yes here to build support for Analog Devices spi resolver
> > -	  to digital converters, ad2s90, provides direct access via sysfs.
> > -
> > -	  To compile this driver as a module, choose M here: the
> > -	  module will be called ad2s90.
> > -
> >  config AD2S1210
> >  	tristate "Analog Devices ad2s1210 driver"
> >  	depends on SPI
> > diff --git a/drivers/staging/iio/resolver/Makefile
> > b/drivers/staging/iio/resolver/Makefile
> > index 8d901dc7500b..b2049f2ce36e 100644
> > --- a/drivers/staging/iio/resolver/Makefile
> > +++ b/drivers/staging/iio/resolver/Makefile
> > @@ -2,5 +2,4 @@
> >  # Makefile for Resolver/Synchro drivers
> >  #
> >  
> > -obj-$(CONFIG_AD2S90) += ad2s90.o
> >  obj-$(CONFIG_AD2S1210) += ad2s1210.o
> > diff --git a/drivers/staging/iio/resolver/ad2s90.c
> > b/drivers/staging/iio/resolver/ad2s90.c
> > deleted file mode 100644
> > index a41f5cb10da5..000000000000
> > --- a/drivers/staging/iio/resolver/ad2s90.c
> > +++ /dev/null
> > @@ -1,131 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * ad2s90.c simple support for the ADI Resolver to Digital Converters:
> > AD2S90
> > - *
> > - * Copyright (c) 2010-2010 Analog Devices Inc.
> > - */
> > -#include <linux/types.h>
> > -#include <linux/mutex.h>
> > -#include <linux/device.h>
> > -#include <linux/spi/spi.h>
> > -#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> > -#include <linux/module.h>
> > -
> > -#include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > -
> > -/*
> > - * Although chip's max frequency is 2Mhz, it needs 600ns between CS and
> > the
> > - * first falling edge of SCLK, so frequency should be at most 1 / (2 *
> > 6e-7)
> > - */
> > -#define AD2S90_MAX_SPI_FREQ_HZ  830000
> > -
> > -struct ad2s90_state {
> > -	struct mutex lock; /* lock to protect rx buffer */
> > -	struct spi_device *sdev;
> > -	u8 rx[2] ____cacheline_aligned;
> > -};
> > -
> > -static int ad2s90_read_raw(struct iio_dev *indio_dev,
> > -			   struct iio_chan_spec const *chan,
> > -			   int *val,
> > -			   int *val2,
> > -			   long m)
> > -{
> > -	int ret;
> > -	struct ad2s90_state *st = iio_priv(indio_dev);
> > -
> > -	if (chan->type != IIO_ANGL)
> > -		return -EINVAL;
> > -
> > -	switch (m) {
> > -	case IIO_CHAN_INFO_SCALE:
> > -		/* 2 * Pi / 2^12 */
> > -		*val = 6283; /* mV */
> > -		*val2 = 12;
> > -		return IIO_VAL_FRACTIONAL_LOG2;
> > -	case IIO_CHAN_INFO_RAW:
> > -		mutex_lock(&st->lock);
> > -		ret = spi_read(st->sdev, st->rx, 2);
> > -		if (ret < 0) {
> > -			mutex_unlock(&st->lock);
> > -			return ret;
> > -		}
> > -		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >>
> > 4);
> > -
> > -		mutex_unlock(&st->lock);
> > -
> > -		return IIO_VAL_INT;
> > -	default:
> > -		break;
> > -	}
> > -
> > -	return -EINVAL;
> > -}
> > -
> > -static const struct iio_info ad2s90_info = {
> > -	.read_raw = ad2s90_read_raw,
> > -};
> > -
> > -static const struct iio_chan_spec ad2s90_chan = {
> > -	.type = IIO_ANGL,
> > -	.indexed = 1,
> > -	.channel = 0,
> > -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > BIT(IIO_CHAN_INFO_SCALE),
> > -};
> > -
> > -static int ad2s90_probe(struct spi_device *spi)
> > -{
> > -	struct iio_dev *indio_dev;
> > -	struct ad2s90_state *st;
> > -
> > -	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
> > -		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
> > -			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
> > -		return -EINVAL;
> > -	}
> > -
> > -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > -	if (!indio_dev)
> > -		return -ENOMEM;
> > -	st = iio_priv(indio_dev);
> > -	spi_set_drvdata(spi, indio_dev);
> > -
> > -	mutex_init(&st->lock);
> > -	st->sdev = spi;
> > -	indio_dev->dev.parent = &spi->dev;
> > -	indio_dev->info = &ad2s90_info;
> > -	indio_dev->modes = INDIO_DIRECT_MODE;
> > -	indio_dev->channels = &ad2s90_chan;
> > -	indio_dev->num_channels = 1;
> > -	indio_dev->name = spi_get_device_id(spi)->name;
> > -
> > -	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > -}
> > -
> > -static const struct of_device_id ad2s90_of_match[] = {
> > -	{ .compatible = "adi,ad2s90", },
> > -	{}
> > -};
> > -MODULE_DEVICE_TABLE(of, ad2s90_of_match);
> > -
> > -static const struct spi_device_id ad2s90_id[] = {
> > -	{ "ad2s90" },
> > -	{}
> > -};
> > -MODULE_DEVICE_TABLE(spi, ad2s90_id);
> > -
> > -static struct spi_driver ad2s90_driver = {
> > -	.driver = {
> > -		.name = "ad2s90",
> > -		.of_match_table = ad2s90_of_match,
> > -	},
> > -	.probe = ad2s90_probe,
> > -	.id_table = ad2s90_id,
> > -};
> > -module_spi_driver(ad2s90_driver);
> > -
> > -MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> > -MODULE_DESCRIPTION("Analog Devices AD2S90 Resolver to Digital SPI
> > driver");
> > -MODULE_LICENSE("GPL v2");  

