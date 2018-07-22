Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC85C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B4E20671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 19:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+6bsOEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B4E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbeGVT62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:58:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37482 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbeGVT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:58:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so4916486lfb.4;
        Sun, 22 Jul 2018 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=As+42rLREkjkcCiGD6A+tGYfhIiBynMHHYqTLzR4oJk=;
        b=e+6bsOECDj+TKbpkwsgYdfyu8hF1TVR+iDYhEZcy6pcsJEGHuOULsjmvKfSnkQj8K1
         A+GSiBd+q1Yx24tMC5kfJcRpcTECHX90iTwOnHlu6bpl7h1Y/LVF3en5p0wEQK8JscFO
         AFkSRYhRieeFyageEQSZeB0Uev97vbskCUnO3suG4fqRr0o+H4/+sCri6e16oL6tncLy
         DO4U6i5mqgkWyBoOAsXMspupS51yDBpEB9iH3ufiv4gZCGycjkrZogwLrN75lPsqplJU
         HX+8R0iQDCxCP+JJEq5PstiGwpimKmdz3IOA4d2oJ/ENMIGy/TB4qqqFXx4Z2pnzrVfJ
         D3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=As+42rLREkjkcCiGD6A+tGYfhIiBynMHHYqTLzR4oJk=;
        b=k3G/1PcnydhYtwD9vWYAz7nAx7OrRgM+vQt0v64SxfAlKsUnlwKzrmEj/UzXgQCEHB
         LzWF9bKISDs5sDgsUO9i5YluV8gZwJxRKhNEKpgE6/q0ANTohx0WBW8JFSsCULAtLtsw
         9LBBHbcTt/xuBEhyxR23zqSORNokEyDrEFxX0PxEtxvGhuznFxn3/sTpWKcw/ccSdZhO
         /YxsMSfcFBowEBAee9XYtRJ6YadQf2zNkoXXGghCMbEDoF/+vQz3T6QOTt1Bn9szYHMI
         eNr8G2WlXTUKZP1LUy3Nb7fTwwp9enwj5gIrJL3o4bOfHFy5jS08phn4y07iAcltJJ4S
         LjhQ==
X-Gm-Message-State: AOUpUlH7gYCsw/UR+P8ULgOSix5omgi+3DJKdpmXMLJl6Vobi/KbBEfR
        mQ+7OSfkZhuaE53+zLbwf50AjNLs+WM=
X-Google-Smtp-Source: AAOMgpfq4elpcAB13CJRyHqh9EpnpOumTBb3453rCQ+UlVBfDYOCHYAqhgHV125MO/ns19wr2sf99g==
X-Received: by 2002:a19:8d07:: with SMTP id p7-v6mr5827798lfd.117.1532286044637;
        Sun, 22 Jul 2018 12:00:44 -0700 (PDT)
Received: from gmail.com (c-2ec2f9f0-74736162.cust.telenor.se. [46.194.249.240])
        by smtp.gmail.com with ESMTPSA id 14-v6sm1447634ljc.74.2018.07.22.12.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 12:00:43 -0700 (PDT)
Date:   Sun, 22 Jul 2018 21:00:51 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: add support for mcp3911
Message-ID: <20180722190051.GB27516@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
 <alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
 <20180722090838.0080aaf5@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20180722090838.0080aaf5@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks, all good catches.

On Sun, Jul 22, 2018 at 09:08:38AM +0100, Jonathan Cameron wrote:
> On Sat, 21 Jul 2018 23:19:48 +0200 (CEST)
> Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>=20
> > Hello,
> >=20
> > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC). =
=20
> >=20
> > some comments below...
>=20
> +CC Mark for the unusual SPI addressing stuff.  I'm mostly interested in =
what
> precedent there is for bindings etc.
>=20

Yep, I'm not entirely sure that the SPI framework can handle multiple
clients on the same CS.
The reason why we created device-addr is that the chip supports that and
may have hardcoded chip address from factory.
The chip address is also part of the protocol so we have to specify it.

> > =20
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > > ---
> > >  drivers/iio/adc/Kconfig   |  10 ++
> > >  drivers/iio/adc/Makefile  |   1 +
> > >  drivers/iio/adc/mcp3911.c | 444 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 455 insertions(+)
> > >  create mode 100644 drivers/iio/adc/mcp3911.c
> > >=20
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 15606f237480..f9a41fa96fcc 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -501,6 +501,16 @@ config MCP3422
> > >  	  This driver can also be built as a module. If so, the module will=
 be
> > >  	  called mcp3422.
> > > =20
> > > +config MCP3911
> > > +	tristate "Microchip Technology MCP3911 driver"
> > > +	depends on SPI
> > > +	help
> > > +	  Say yes here to build support for Microchip Technology's MCP3911
> > > +	  analog to digital converter.
> > > +
> > > +	  This driver can also be built as a module. If so, the module will=
 be
> > > +	  called mcp3911.
> > > +
> > >  config MEDIATEK_MT6577_AUXADC
> > >          tristate "MediaTek AUXADC driver"
> > >          depends on ARCH_MEDIATEK || COMPILE_TEST
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 28a9423997f3..3cfebfff7d26 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -47,6 +47,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o
> > >  obj-$(CONFIG_MAX9611) +=3D max9611.o
> > >  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> > >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> > > +obj-$(CONFIG_MCP3911) +=3D mcp3911.o
> > >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) +=3D mt6577_auxadc.o
> > >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> > >  obj-$(CONFIG_MESON_SARADC) +=3D meson_saradc.o
> > > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > > new file mode 100644
> > > index 000000000000..be74cb15827b
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/mcp3911.c
> > > @@ -0,0 +1,444 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for Microchip MCP3911, Two-channel Analog Front End
> > > + *
> > > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
> > > + *
>=20
> No need for blank line here.
>=20

Ok

> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#define MCP3911_REG_CHANNEL0		0x00
> > > +#define MCP3911_REG_CHANNEL1		0x03
> > > +#define MCP3911_REG_MOD			0x06
> > > +#define MCP3911_REG_PHASE		0x07
> > > +
> > > +#define MCP3911_REG_GAIN		0x09
> > > +#define MCP3911_GAIN_MASK(ch)		(0x7 << 3*ch) =20
> >=20
> > space around * operator, maybe parenthesis around variable, i.e
> > (0x07 << (3 * (ch)))
> >=20
> > > +#define MCP3911_GAIN_VAL(ch, val)	((val << 3*ch) & MCP3911_GAIN_MASK=
(ch))
> > > +
> > > +#define MCP3911_REG_STATUSCOM		0x0a
> > > +#define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
> > > +#define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
> > > +#define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> > > +#define MCP3911_STATUSCOM_EN_GAINCAL	BIT(1)
> > > +
> > > +#define MCP3911_REG_CONFIG		0x0c
> > > +#define MCP3911_CONFIG_CLKEXT		BIT(1)
> > > +#define MCP3911_CONFIG_VREFEXT		BIT(2)
> > > +
> > > +#define MCP3911_REG_OFFCAL_CH0		0x0e
> > > +#define MCP3911_REG_GAINCAL_CH0		0x11
> > > +#define MCP3911_REG_OFFCAL_CH1		0x14
> > > +#define MCP3911_REG_GAINCAL_CH1		0x17
> > > +#define MCP3911_REG_VREFCAL		0x1a
> > > +
> > > +#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
> > > +#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
> > > +#define MCP3911_GAINCAL(x)		(MCP3911_REG_GAINCAL_CH0 + x * 6)
> > > + =20
> >=20
> > delete newline
> >=20
> > > +
> > > +/* Internal voltage reference in uV */
> > > +#define MCP3911_INT_VREF_UV		1200000
> > > +
> > > +#define REG_READ(reg, id)	(((reg << 1) | (id << 5) | (1 << 0)) & 0xf=
f)
> > > +#define REG_WRITE(reg, id)	(((reg << 1) | (id << 5) | (0 << 0)) & 0x=
ff) =20
> >=20
> > MCP3911_ prefix please
> > parenthesis around variables
> >=20
> > > +
> > > +#define MCP3911_NUM_CHANNELS		2
> > > +
> > > +
> > > +struct mcp3911 {
> > > +	struct spi_device *spi;
> > > +	struct device_node *np;
> > > +	struct mutex lock;
> > > +
> > > +	u32 gain[MCP3911_NUM_CHANNELS];
> > > +	u32 width[MCP3911_NUM_CHANNELS];
> > > +
> > > +	u32 dev_addr;
> > > +	bool vrefext;
> > > +	struct regulator *vref;
> > > +};
> > > +
> > > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 le=
n)
> > > +{
> > > +	int ret;
> > > +
> > > +	reg =3D REG_READ(reg, adc->dev_addr);
> > > +	ret =3D spi_write_then_read(adc->spi, &reg, 1, val, len);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val <<=3D ((4-len)*8); =20
> >=20
> > space around - and * operator, here and elsewhere
> >=20
> > shouldn't the endiness conversion happen before the value is shifted?=
=20
> > (here and below)?
> >=20
> > > +	be32_to_cpus(val);
> > > +	dev_dbg(&adc->spi->dev, "Reading 0x%x from register 0x%x\n", *val,
> > > +			reg>>1);
> > > +	return ret;
> > > +}
> > > +
> > > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 le=
n)
> > > +{
> > > +	dev_dbg(&adc->spi->dev, "Writing 0x%x to register 0x%x\n", val, reg=
);
> > > +
> > > +	cpu_to_be32s(&val);
> > > +	val >>=3D (3-len)*8;
> Hmm. It might be worth considering regmap here to handle all this stuff f=
or
> you rather than re rolling the same stuff.
>=20

We were looking at regmap, but it does not seems to support registers of
different size.
This chip has register values of 8, 16 and 24 bits.

> > > +	val |=3D REG_WRITE(reg, adc->dev_addr);
> > > +
> > > +	return spi_write(adc->spi, &val, len+1);
> > > +}
> > > +
> > > +static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
> > > +		u32 val, u8 len)
> > > +{
> > > +	u32 tmp;
> > > +	int ret;
> > > +
> > > +	ret =3D mcp3911_read(adc, reg, &tmp, len);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val &=3D mask;
> > > +	val |=3D tmp & ~mask;
> > > +	return mcp3911_write(adc, reg, val, len);
> > > +}
> > > +
> > > +static int mcp3911_get_hwgain(struct mcp3911 *adc, u8 channel, u32 *=
val)
> > > +{
> > > +	int ret =3D mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val >>=3D channel*3;
> > > +	*val &=3D 0x07;
> > > +	*val =3D (1 << *val);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mcp3911_read_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *channel, int *val,
> > > +			    int *val2, long mask)
> > > +{
> > > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > > +	int ret =3D -EINVAL;
> > > +
> > > +	mutex_lock(&adc->lock);
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret =3D mcp3911_read(adc,
> > > +				MCP3911_CHANNEL(channel->channel), val, 3);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		ret =3D IIO_VAL_INT;
> > > +		break;
> > > +
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > +		ret =3D mcp3911_read(adc,
> > > +				MCP3911_OFFCAL(channel->channel), val, 3);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		ret =3D IIO_VAL_INT;
> > > +		break;
> > > +
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +		ret =3D mcp3911_get_hwgain(adc, channel->channel, val);
>=20
> I'm not convinced it's useful to expose this as it right control for this
> is scale.
>=20

Hmm, all other drivers that are using HARDWAREGAIN (ina2xx-adc, stx104 +
a few more that are not ADC:s) are, what I can tell, exposing it.

But maybe it should'nt.

> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		ret =3D IIO_VAL_INT;
> > > +		break;
> > > +
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		if (adc->vrefext) {
> > > +			ret =3D regulator_get_voltage(adc->vref);
> > > +			if (ret < 0) {
> > > +				dev_err(indio_dev->dev.parent,
> > > +					"failed to get vref voltage:%d\n", ret); =20
> >=20
> > start message consistently with upper/lowercase
> > maybe space before :
> >=20
> > > +				goto out;
> > > +			}
> > > +
> > > +			*val =3D ret / 1000;
> > > +		} else {
> > > +			*val =3D MCP3911_INT_VREF_UV;
> > > +		}
> > > +
> > > +		/* apply with gain value */
> > > +		*val /=3D adc->gain[channel->channel];
> > > +		*val2 =3D adc->width[channel->channel];
> > > +
> > > +		ret =3D IIO_VAL_FRACTIONAL_LOG2;
> > > +		break;
> > > +	}
> > > +
> > > +out:
> > > +	mutex_unlock(&adc->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int mcp3911_write_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *channel, int val,
> > > +			    int val2, long mask)
> > > +{
> > > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > > +	int ret =3D -EINVAL;
> > > +
> > > +	mutex_lock(&adc->lock);
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > + =20
> >=20
> > val2 should probably be zero and checked?
> >=20
> > > +		/* Write offset */
> > > +		ret =3D mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
> > > +				3);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		/* Enable offset*/
> > > +		ret =3D mcp3911_update(adc, MCP3911_REG_STATUSCOM,
> > > +				MCP3911_STATUSCOM_EN_OFFCAL,
> > > +				MCP3911_STATUSCOM_EN_OFFCAL, 2);
> > > +		if (ret)
> > > +			goto out;
>=20
> We go there anyway so why bother with the goto?
>=20

Yep, the goto will be removed.

> > > +
> > > +		break;
> > > +
> > > +	case IIO_CHAN_INFO_HARDWAREGAIN: =20
>=20
> Default choice (by precedent) is to control variable gain
> front ends via the scale parameter.   Hardware gain
> is not meant to have any 'visible' impact on the output
> value - most commonly used when the thing we are measuring
> is not amplitude of anything.

Hmm, Ok. I'm not sure I understand how hardware gain is supposed to work
then.
Maybe I just remove it.

>=20
> >=20
> > val2?
> >=20
> > > +		if (!is_power_of_2(val) && val <=3D 32) { =20
> >=20
> > the check looks suspicious, maybe || val > 32
> >=20
> > > +			ret =3D -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		adc->gain[channel->channel] =3D val;
> > > +
> > > +		val =3D ilog2(val);
> > > +		ret =3D mcp3911_update(adc, MCP3911_REG_GAIN,
> > > +					MCP3911_GAIN_MASK(channel->channel),
> > > +					MCP3911_GAIN_VAL(channel->channel,
> > > +						val), 1);
> > > +		break;
> > > +	}
> > > +
> > > +out:
> > > +	mutex_unlock(&adc->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct iio_chan_spec mcp3911_channels[] =3D {
> > > +	{ =20
> >=20
> > maybe use a MACRO(), e.g. MCP3911_CHANNEL(idx) ...
> >=20
> > > +		.type =3D IIO_VOLTAGE,
> > > +		.indexed =3D 1,
> > > +		.channel =3D 0,
> > > +		.address =3D MCP3911_REG_CHANNEL0,
> > > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > +			BIT(IIO_CHAN_INFO_OFFSET) |
> > > +			BIT(IIO_CHAN_INFO_SCALE) |
> > > +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > > +	},
> > > +	{
> > > +		.type =3D IIO_VOLTAGE,
> > > +		.indexed =3D 1,
> > > +		.channel =3D 1,
> > > +		.address =3D MCP3911_REG_CHANNEL1,
> > > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > +			BIT(IIO_CHAN_INFO_OFFSET) |
> > > +			BIT(IIO_CHAN_INFO_SCALE) |
> > > +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> > > +	},
> > > +};
> > > +
> > > +static const struct iio_info mcp3911_info =3D {
> > > +	.read_raw =3D mcp3911_read_raw,
> > > +	.write_raw =3D mcp3911_write_raw,
> > > +};
> > > +
> > > +static int mcp3911_config_of(struct mcp3911 *adc)
> > > +{
> > > +	u32 configreg;
> > > +	u32 statuscomreg;
> > > +	int ret;
> > > +
> > > +	of_property_read_u32(adc->np, "device-addr", &adc->dev_addr);
> This is 'interesting' - I wonder if there is any precedence for it.
>=20

I guess we still need it since the device may have a hardcoded (from
factory) address that we need to deal with.

> Mark, =20
> > > +	if (adc->dev_addr > 3) {
> > > +		dev_err(&adc->spi->dev,
> > > +				"invalid device address (%i). Must be in range 0-3.\n",
> > > +				adc->dev_addr);
> > > +		return -EINVAL;
> > > +	}
> > > +	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> > > +
> > > +	ret =3D mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	adc->vrefext =3D of_property_read_bool(adc->np, "external-vref");
>=20
> Why not just use the presence or lack of a regulator being supplied to in=
dicate
> this?  Use the regulator_get_optional functionality to avoid getting a st=
ub
> regulator if you need to know there isn't one there to connect.
> Here you need the _optional form.

Ah!
I wanted it to work that way, but got the dummy regulator when no
regulator was provided.
So _optional is the thing.
Thanks!

>=20
> > > +	if (adc->vrefext) {
> > > +		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
> > > +		configreg |=3D MCP3911_CONFIG_VREFEXT;
> > > +
> > > +	} else {
> > > +		dev_dbg(&adc->spi->dev, "use internal voltage reference (1.2V)\n");
> > > +		configreg &=3D ~MCP3911_CONFIG_VREFEXT;
> > > +	}
> > > +
> > > +	if (of_property_read_bool(adc->np, "external-clock")) {
> > > +		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
> > > +		configreg |=3D MCP3911_CONFIG_CLKEXT;
> > > +	} else {
> > > +		dev_dbg(&adc->spi->dev, "use crystal oscillator as clocksource\n");
> > > +		configreg &=3D ~MCP3911_CONFIG_CLKEXT;
> > > +	}
>=20
> Sort of feels like this should be handled a bit like the regulator.
> The kernel has bindings and software support for clocks. Would be nice
> to use them.
>=20

Indeed. I will go for the clocks instead.

> > > +
> > > +	ret =3D  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +
> > > +	ret =3D mcp3911_read(adc, MCP3911_REG_STATUSCOM, &statuscomreg, 2);
> > > +	if (ret)
> > > +		return ret;
> > > + =20
> >=20
> > no duplicate newlines (here and elsewhere)
> >=20
> > > +
> > > +	of_property_read_u32(adc->np, "ch0-width", &adc->width[0]);
> > > +	switch (adc->width[0]) {
> > > +	case 24:
> > > +		statuscomreg &=3D ~MCP3911_STATUSCOM_CH0_24WIDTH;
> > > +		dev_dbg(&adc->spi->dev, "set channel 0 into 24bit mode\n");
> > > +		break;
> > > +	case 16:
> > > +		statuscomreg |=3D MCP3911_STATUSCOM_CH0_24WIDTH;
> > > +		dev_dbg(&adc->spi->dev, "set channel 0 into 16bit mode\n");
> > > +		break;
> > > +	default:
> > > +		adc->width[0] =3D 24;
> > > +		dev_info(&adc->spi->dev, "invalid width for channel 0. Use 24bit.\=
n");
> > > +		break;
> > > +	}
> This feels like something that isn't really a dt choice, as it's not down=
 to
> wiring but rather down to precision desired.

You are right. I will remove them and stick to 24bit width.

>=20
> Now variable resolution isn't something IIO has traditionally dealt
> with very well - particularly as it causes problems when we add in
> buffered interfaces (as it changes the data layout etc).
>=20
> > > +
> > > +	of_property_read_u32(adc->np, "ch1-width", &adc->width[1]);
> > > +	switch (adc->width[1]) {
> > > +	case 24:
> > > +		statuscomreg &=3D ~MCP3911_STATUSCOM_CH1_24WIDTH;
> > > +		dev_dbg(&adc->spi->dev, "set channel 1 into 24bit mode\n");
> > > +		break;
> > > +	case 16:
> > > +		statuscomreg |=3D MCP3911_STATUSCOM_CH1_24WIDTH;
> > > +		dev_dbg(&adc->spi->dev, "set channel 1 into 16bit mode\n");
> > > +		break;
> > > +	default:
> > > +		adc->width[1] =3D 24;
> > > +		dev_info(&adc->spi->dev, "invalid width for channel 1. Use 24bit.\=
n");
> > > +		break;
> > > +	}
> > > +
> > > +	return mcp3911_write(adc, MCP3911_REG_STATUSCOM, statuscomreg, 2);
> > > +}
> > > +
> > > +static int mcp3911_probe(struct spi_device *spi)
> > > +{
> > > +	struct iio_dev *indio_dev;
> > > +	struct mcp3911 *adc;
> > > +	int ret;
> > > +
> > > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	adc =3D iio_priv(indio_dev);
> > > +	adc->spi =3D spi;
> > > +	adc->np =3D spi->dev.of_node;
>=20
> np is is rather unusual naming.  Why not of_node?
> Also, why do we need to keep a copy of this?

I guess the drivers I was looking at called it 'np'.
However, I guess there is no need to keep a copy of it.
I will remove it.

>=20
> > > +
> > > +	ret =3D mcp3911_config_of(adc);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (adc->vrefext) {
> > > +		adc->vref =3D devm_regulator_get(&adc->spi->dev, "vref");
>=20
> As I mention above, use devm_regulator_get_optional if you need
> to be able to do something different dependent on whether the regulator
> is actually there, if not just use devm_regulator_get and without
> any if (adc->vrefext) and you'll get a 'fake' regulator which you can
> enable and disable without it doing anything.

Got it. Thanks!

>=20
> > > +		if (IS_ERR(adc->vref))
> > > +			return PTR_ERR(adc->vref);
> > > +
> > > +		ret =3D regulator_enable(adc->vref);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	}
> > > +
> > > +	/* Store gain values to better calculate scale values */
> > > +	mcp3911_get_hwgain(adc, 0, &adc->gain[0]);
> > > +	mcp3911_get_hwgain(adc, 1, &adc->gain[1]);
> > > +
> > > +	indio_dev->dev.parent =3D &spi->dev;
> > > +	indio_dev->dev.of_node =3D spi->dev.of_node;
> > > +	indio_dev->name =3D spi_get_device_id(spi)->name;
> > > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +	indio_dev->info =3D &mcp3911_info;
> > > +	spi_set_drvdata(spi, indio_dev);
> > > +
> > > +	indio_dev->channels =3D mcp3911_channels;
> > > +	indio_dev->num_channels =3D ARRAY_SIZE(mcp3911_channels);
> > > +
> > > +	mutex_init(&adc->lock);
> > > +
> > > +	ret =3D iio_device_register(indio_dev);
> > > +	if (ret)
> > > +		goto reg_disable;
> > > +
> > > +	return ret;
> > > +
> > > +reg_disable:
> > > +	if (adc->vref)
> > > +		regulator_disable(adc->vref);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int mcp3911_remove(struct spi_device *spi)
> > > +{
> > > +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > > +
> > > +	iio_device_unregister(indio_dev);
> > > +
> > > +	if (adc->vref)
> > > +		regulator_disable(adc->vref);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#if defined(CONFIG_OF)
> > > +static const struct of_device_id mcp3911_dt_ids[] =3D {
> > > +	{ .compatible =3D "microchip,mcp3911" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
> > > +#endif
> > > +
> > > +static const struct spi_device_id mcp3911_id[] =3D {
> > > +	{ "mcp3911", 0 },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, mcp3911_id);
> > > +
> > > +static struct spi_driver mcp3911_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "mcp3911",
> > > +		.of_match_table =3D of_match_ptr(mcp3911_dt_ids),
> > > +	},
> > > +	.probe =3D mcp3911_probe,
> > > +	.remove =3D mcp3911_remove,
> > > +	.id_table =3D mcp3911_id,
> > > +};
> > > +module_spi_driver(mcp3911_driver);
> > > +
> > > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > > +MODULE_AUTHOR("Kent Gustavsson <kent@minoris.se>");
> > > +MODULE_DESCRIPTION("Microchip Technology MCP3911");
> > > +MODULE_LICENSE("GPL v2");
> > >  =20
> >=20
>=20

Best regards
Marcus Folkesson

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltU1F4ACgkQiIBOb1ld
UjKt5Q/+OW95/B9omkFXfIHfGOm4NNdCdUV4q+M0bmfPdFkjLL7ki7/T12TyqEGf
ltYBDWjTJJogBr2bNUUBNpxeKkWHa9V7vfF58nYL1SsgOfKAyH04gpeo2wZj8fBe
x2mhhBwu/IO0wuA4d/vLBy3YwvnZa3UTE3rmu7jx9xdBt/gsbwxqntHLQReqjOel
jmngOfWEVon6sSAr2lRcTvPpOia+FzWPraARwq3pf3n0/xtEU+qF56KmkW8yzaLr
W8v3lZ6ay4oDwFA09xsgnWMqdPpjzcCQW1F+h3uOxUcFjSJns1nleIKhcsKklEfk
l2+TOB5r3BuZLzkhIbVTdm4hcesPW/AKEIDStEiQk2CfxZYRr+UjoRObaW8enZ8h
hGIUK3dtX31HQd97xmyUoGEOubRcfJPomstLEpWlgc5X0TvI/Pi+caNFJOu+fKZi
Lp4jHLjMlK8mPkqeWKXJeLbDJVBJZmA89/osPVWPdhkjFAmVlkqcp5RfyZAjtzGN
Fi0ycv/cYTtbuPTJQXphTP0jdE490mDUqNiWQGNYtHtPHJ48WUFLqlUpqzB9M9Fz
jRn3yZ4RwlUkDzJTxINxpa7voqQhZ9ZyaIOkqO6zlwXm3KT5eKSxqJrp6tH2DPCL
RdR+GHL+TBIzcm58mC8fslXxOVdjcqD4yJE9W517GINoubjgDzs=
=kyk1
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
