Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E2C04E83
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF93E21536
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiU2pudc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF93E21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeHSWFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:05:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41449 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeHSWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:04:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so9909379ljy.8;
        Sun, 19 Aug 2018 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYiZUOlKDeo+TV2Yf8VfSi1QMlisAyvEs/zT8d7e8UI=;
        b=uiU2pudc3klfe4gzJYu4N6rzpyj7W1SNRrlG+PK8dZxRBq3ILfoGi8nglRQpVbVxaz
         tM4zSmd90qViqF5KywY1siPUvykQsD8ICZTbVAoop02P2PxxjrQvMufAqM8RtQv46TJ0
         S68U+gctYkFsR2SBmHUMm+3i1O2K01fWCNcWwu+z/DKYVHX934rmT7raRz2j6c0Ua9tF
         FkjHuHTefwlkCupfnmBvW2fUJKEUnXeMPlUOX6mq57Zdzsle4ZybxVDWU34jT67r+GCI
         dmMhomhd/ZeoRlNiTROqij4kEdeylJ51qHY0pTcwYkOQ3QVDFd2NCTTu07Y42YqztRdb
         2LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYiZUOlKDeo+TV2Yf8VfSi1QMlisAyvEs/zT8d7e8UI=;
        b=T2+3cgAouO1xF1kMo6rIzGZ7OHEWgld7ZCbVH+P7qjDNNxIKUEzgyek5B+97LXE/GV
         RwEi1o/2RY4cqwkUiw/+7FyBCBHM4SYw7ugHno0r7EIgDu+ICPfexM4nN3zShGVleBl+
         yUPBce2Fl793qrJ/vqQtTM653N3h7yNOIGBV8Z6lzAKB7QHsyb6PCsf0OfIARxp3pgcQ
         LeQLuCl4FfB2VvvAVQu9bGOsQsI5bNu1co0mFFE5P8pKoxS6x5K8JInaaR62fkOltt0O
         dumjJJcGSWbAaUNyDrLlCbunjdZj7bWvEfUU2CnRtgY+DmJIu2LgmZtrsUbI877tfn+a
         eSig==
X-Gm-Message-State: AOUpUlFgpggAI/ZDIIKRZlhzNbTjcR/1OCmLPkU7IcttZcRiHwvpSfRs
        /ogB/ypogudhm3GChlSQXkA=
X-Google-Smtp-Source: AA+uWPxiLymbuQPkV6yX8iBIHVghFx8Cm/41jvyluueFf5YdtNLynV0geKmV/Q05A7TE/rpvNO1+yg==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr23906185ljj.33.1534704750336;
        Sun, 19 Aug 2018 11:52:30 -0700 (PDT)
Received: from gmail.com (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id v20-v6sm1268959ljc.94.2018.08.19.11.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 11:52:28 -0700 (PDT)
Date:   Sun, 19 Aug 2018 20:52:46 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: dac: add support for ltc166x
Message-ID: <20180819185246.GA5217@gmail.com>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
 <20180819173850.3d55ea7e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20180819173850.3d55ea7e@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for your comments!

On Sun, Aug 19, 2018 at 05:38:50PM +0100, Jonathan Cameron wrote:
> On Sat, 11 Aug 2018 22:02:24 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter
> > (DAC) with eight individual channels.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>=20
> So first rule we try to stick to that this breaks is never use wild cards
> in drivers.  You probably wouldn't believe how often this has gone wrong =
with
> a manufacturer deciding to use other values that wild card covers...

Hah, I can imagine. I will switch do use ltc1660 all over the place.
>=20
> Please pick a part and name everything after that.  Either one is fine.
>=20
> A few really minor things inline.  Nice little driver.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/iio/dac/Kconfig   |  10 ++
> >  drivers/iio/dac/Makefile  |   1 +
> >  drivers/iio/dac/ltc166x.c | 244 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 255 insertions(+)
> >  create mode 100644 drivers/iio/dac/ltc166x.c
> >=20
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 76db0768e454..04cfa6bb9dc1 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -120,6 +120,16 @@ config AD5624R_SPI
> >  	  Say yes here to build support for Analog Devices AD5624R, AD5644R a=
nd
> >  	  AD5664R converters (DAC). This driver uses the common SPI interface.
> > =20
> > +config LTC166X
> > +	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Linear Technology
> > +	  LTC1660 and LTC1665 Digital to Analog Converters.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ltc166x.
> > +
> >  config LTC2632
> >  	tristate "Linear Technology LTC2632-12/10/8 DAC spi driver"
> >  	depends on SPI
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > index 81e710ed7491..380749c87c26 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_CIO_DAC) +=3D cio-dac.o
> >  obj-$(CONFIG_DPOT_DAC) +=3D dpot-dac.o
> >  obj-$(CONFIG_DS4424) +=3D ds4424.o
> >  obj-$(CONFIG_LPC18XX_DAC) +=3D lpc18xx_dac.o
> > +obj-$(CONFIG_LTC166X) +=3D ltc166x.o
> >  obj-$(CONFIG_LTC2632) +=3D ltc2632.o
> >  obj-$(CONFIG_M62332) +=3D m62332.o
> >  obj-$(CONFIG_MAX517) +=3D max517.o
> > diff --git a/drivers/iio/dac/ltc166x.c b/drivers/iio/dac/ltc166x.c
> > new file mode 100644
> > index 000000000000..0031f2b50f14
> > --- /dev/null
> > +++ b/drivers/iio/dac/ltc166x.c
> > @@ -0,0 +1,244 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Linear Technology LTC1665/LTC1660, 8 channels DAC
> > + *
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define LTC166X_REG_WAKE	0x0
> > +#define LTC166X_REG_DAC_A	0x1
> > +#define LTC166X_REG_DAC_B	0x2
> > +#define LTC166X_REG_DAC_C	0x3
> > +#define LTC166X_REG_DAC_D	0x4
> > +#define LTC166X_REG_DAC_E	0x5
> > +#define LTC166X_REG_DAC_F	0x6
> > +#define LTC166X_REG_DAC_G	0x7
> > +#define LTC166X_REG_DAC_H	0x8
> > +#define LTC166X_REG_SLEEP	0xe
> > +
> > +#define LTC166X_NUM_CHANNELS	8
> > +
> > +static const struct regmap_config ltc166x_regmap_config =3D {
> > +	.reg_bits =3D 4,
> > +	.val_bits =3D 12,
> > +};
> > +
> > +enum ltc166x_supported_device_ids {
> > +	ID_LTC1660,
> > +	ID_LTC1665,
> > +};
> > +
> > +struct ltc166x_priv {
> > +	struct spi_device *spi;
> > +	struct regmap *regmap;
> > +	struct regulator *vref_reg;
> > +	unsigned int value[LTC166X_NUM_CHANNELS];
> > +	unsigned int vref_mv;
> > +};
> > +
> > +static int ltc166x_read_raw(struct iio_dev *indio_dev,
> > +		struct iio_chan_spec const *chan,
> > +		int *val,
> > +		int *val2,
> > +		long mask)
> > +{
> > +	struct ltc166x_priv *priv =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		*val =3D priv->value[chan->channel];
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D priv->vref_mv;
> > +		*val2 =3D chan->scan_type.realbits;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ltc166x_write_raw(struct iio_dev *indio_dev,
> > +		struct iio_chan_spec const *chan,
> > +		int val,
> > +		int val2,
> > +		long mask)
> > +{
> > +	struct ltc166x_priv *priv =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val2 !=3D 0)
> > +			return -EINVAL;
> > +		if (val > GENMASK(chan->scan_type.realbits-1, 0))
> > +			return -EINVAL;
>=20
> nothing makes val positive..  Also spaces around the '-'.
>=20
>=20

You are right.
I will go for
	val &=3D  GENMASK(chan->scan_type.realbits - 1, 0);
instead.

> > +		priv->value[chan->channel] =3D val;
> > +		val <<=3D chan->scan_type.shift;
> > +		return regmap_write(priv->regmap, chan->channel, val);
>=20
> Given that this could fail, usual convention is set the cached value
> priv->value[] only after we know the write succeeded. =20

I will switch the order, thanks.

>=20
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +#define LTC166X_CHAN(chan, bits) {			\
> > +	.type =3D IIO_VOLTAGE,				\
> > +	.indexed =3D 1,					\
> > +	.output =3D 1,					\
> > +	.channel =3D chan,				\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),	\
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
> > +	.scan_type =3D {					\
> > +		.sign =3D 'u',				\
>=20
> Supplying this for a DAC is unusual given scan_type only becomes relevant
> (in the IIO core) when we have buffers involved.  For output devices
> we don't currently have buffered support.
>=20
> Hmm. You are using it as a convenient stashing location though so perhaps
> fair enough.. You could only specify the realbits and shift, but that see=
ms
> a bit odd so perhaps best to leave this as it is.

Yeah, I was actually struggling with how I should handle the different
bit-lengts, then I saw that other drivers (most of all DAC drivers for Anal=
og
Devices) was using the "buffer variables" for stashing these values.

>=20
>=20
> > +		.realbits =3D (bits),			\
> > +		.storagebits =3D 16,			\
> > +		.shift =3D 12 - (bits),			\
> > +	},						\
> > +}
> > +
> > +#define  LTC166X_OCTAL_CHANNELS(bits) {			\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_A, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_B, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_C, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_D, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_E, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_F, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_G, bits),	\
> > +		LTC166X_CHAN(LTC166X_REG_DAC_H, bits),	\
> > +}
> > +
> > +static const struct iio_chan_spec ltc166x_channels[][LTC166X_NUM_CHANN=
ELS] =3D {
> > +	[ID_LTC1660] =3D LTC166X_OCTAL_CHANNELS(10),
> > +	[ID_LTC1665] =3D LTC166X_OCTAL_CHANNELS(8),
> > +};
> > +
> > +static const struct iio_info ltc166x_info =3D {
> > +	.read_raw =3D &ltc166x_read_raw,
> > +	.write_raw =3D &ltc166x_write_raw,
> > +};
> > +
> > +static int __maybe_unused ltc166x_suspend(struct device *dev)
> > +{
> > +	struct ltc166x_priv *priv =3D iio_priv(spi_get_drvdata(
> > +						to_spi_device(dev)));
> > +	return regmap_write(priv->regmap, LTC166X_REG_SLEEP, 0x00);
> > +}
> > +
> > +static int __maybe_unused ltc166x_resume(struct device *dev)
> > +{
> > +	struct ltc166x_priv *priv =3D iio_priv(spi_get_drvdata(
> > +						to_spi_device(dev)));
> > +	return regmap_write(priv->regmap, LTC166X_REG_WAKE, 0x00);
> > +}
> > +static SIMPLE_DEV_PM_OPS(ltc166x_pm_ops, ltc166x_suspend, ltc166x_resu=
me);
> > +
> > +static int ltc166x_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct ltc166x_priv *priv;
> > +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> > +	if (indio_dev =3D=3D NULL)
> > +		return -ENOMEM;
> > +
> > +	priv =3D iio_priv(indio_dev);
> > +	priv->regmap =3D devm_regmap_init_spi(spi, &ltc166x_regmap_config);
> > +	if (IS_ERR(priv->regmap)) {
> > +		dev_err(&spi->dev, "failed to register spi regmap %ld\n",
> > +			PTR_ERR(priv->regmap));
> > +		return PTR_ERR(priv->regmap);
> > +	}
> > +
> > +	priv->vref_reg =3D devm_regulator_get(&spi->dev, "vref");
> > +	if (IS_ERR(priv->vref_reg)) {
> > +		dev_err(&spi->dev, "vref regulator not specified\n");
> > +		return PTR_ERR(priv->vref_reg);
> > +	}
> > +
> > +	ret =3D regulator_enable(priv->vref_reg);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "failed to enable vref regulator: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D regulator_get_voltage(priv->vref_reg);
> > +	if (ret < 0) {
> > +		dev_err(&spi->dev, "failed to read vref regulator: %d\n",
> > +				ret);
> > +		goto error_disable_reg;
> > +	}
> > +	priv->vref_mv =3D ret / 1000;
>=20
> It is admittedly fairly unlikely that someone might share this regulator
> across multiple devices, but in theory this might change.
>=20
> So I'd slightly prefer this read being done where we actually need
> the answer, so in the read_raw callback.
>=20
> Lots of drivers do it in the wrong place and given how unlikely such
> as setup is, I'm not that fussy about it.  However as you need to respin
> anyway for the naming, we might as well make this perfect.

Will do, thanks!

>=20
> > +
> > +	priv->spi =3D spi;
> > +	spi_set_drvdata(spi, indio_dev);
> > +	indio_dev->dev.parent =3D &spi->dev;
> > +	indio_dev->info =3D &ltc166x_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D ltc166x_channels[id->driver_data];
> > +	indio_dev->num_channels =3D LTC166X_NUM_CHANNELS;
> > +	indio_dev->name =3D id->name;
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "failed to register iio device: %d\n",
> > +				ret);
> > +		goto error_disable_reg;
> > +	}
> > +
> > +	return 0;
> > +
> > +error_disable_reg:
> > +	regulator_disable(priv->vref_reg);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ltc166x_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > +	struct ltc166x_priv *priv =3D iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	regulator_disable(priv->vref_reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ltc166x_dt_ids[] =3D {
> > +	{ .compatible =3D "lltc,ltc1660", .data =3D (void *)ID_LTC1660 },
> > +	{ .compatible =3D "lltc,ltc1665", .data =3D (void *)ID_LTC1665 },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ltc166x_dt_ids);
> > +
> > +static const struct spi_device_id ltc166x_id[] =3D {
> > +	{"ltc1660", ID_LTC1660},
> > +	{"ltc1665", ID_LTC1665},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, ltc166x_id);
> > +
> > +static struct spi_driver ltc166x_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ltc166x",
> > +		.of_match_table =3D ltc166x_dt_ids,
> > +		.pm =3D &ltc166x_pm_ops,
> > +	},
> > +	.probe	=3D ltc166x_probe,
> > +	.remove =3D ltc166x_remove,
> > +	.id_table =3D ltc166x_id,
> > +};
> > +module_spi_driver(ltc166x_driver);
> > +
> > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > +MODULE_DESCRIPTION("Linear Technology LTC166X DAC");
> > +MODULE_LICENSE("GPL v2");
>=20

Best regards
Marcus Folkesson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt5vHoACgkQiIBOb1ld
UjJmphAAqam/rtwJoimBI1JWx7vhW4CskmBTeN+dcMqIuu/srFDXXLEBMPRaELRq
VLkWEBQ0Oq6G7wBioGRcP3lKGynKgIHvidk5eNn20mzp0OHF5NakfuqWCxDLYzHB
nom8c1xI7/WI/jJ069pyuxa0/yA6tifvhxBfGXZR8ipWNrSRoQ6AK/cgmGdLwA6T
PUOCMHPgmtMutqrnzYdoy1aSiEuHfNhBl+N1tPYo3Zrj4KQ/Sw6Ohk9xTzL6pycl
YAjOXNBZvm7eqh4rdafaVf410mJrOdwYDG24n1ASNn2sFQCRJ3C6WoTeoYprGgtW
A+jTTMTSZSKaS/KDJF9NH0ssVJuzZNlCHaPITkcrWfcoDTXlsrcJEgIt/gnt+AK5
V13SIz4uGdrH12RRWInZEnhg470ELqCppYHzRxCET7gE9o+8DNgIX2xvj1/OW1Hv
ZwXclPJJqhWJSuMdap9F0+TNrQ+qmwII+RE8LbnLbol1cgQFYUCAOSnGCSeSLVK2
g8m2CahcV4r0l9L/Tyzk2jc1IM+1bPbkg/mBYwde/FA1BAzlDdPsFdCWosNADbDz
vl3iLCgIg6LcUEGeTFxIcHbo5cuB1cVaOgpAaK3tyts6yBytZFsJRTCXzFxkJspe
nRAiS+HChCWe+6zuyNuhgKKBaVEh6N5h9uOVHYkbAQ0uxJVtv8E=
=/yNU
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
