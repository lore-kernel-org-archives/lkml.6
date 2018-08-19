Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28940C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8D520C0C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJcD0Y2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8D520C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeHSWaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:30:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41373 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeHSWaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:30:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id v22-v6so9312213lfe.8;
        Sun, 19 Aug 2018 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9hBeHIZs0P5rwW605BMx5H2K97rQeBPUr4VyXUNX8U=;
        b=vJcD0Y2GR+4+o1BhXKgKAPXr87ibSLLg4LS58JxqKULrUMn/CbJGnTFZYam53OnqWZ
         dbchWOPkHezjKXaJKwe5BFATL0hPC8Tc6xm5NFj6Bq78qhoyy7Xo/RWtuHlgsEKbjOaU
         KIIIDvk64KHH3gV9BnUp1P4xgTnCOz4E0T/v8SN+gFS2OdueeTeSFgJmTTs9v4K/4pd2
         yQ68KHZWrBrDh5Pr/9F+wuLtaAT8SWZeGn8enkRPDZGjUPTTiEjleXtaKiwX9d1/eTzq
         hUn14m7nh/mW6uq21GRXvujSiEPo6fkdJdtA+skeqG0MpsHumj9yQLvS2eFHjkYH+/tm
         kzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9hBeHIZs0P5rwW605BMx5H2K97rQeBPUr4VyXUNX8U=;
        b=U/kjW2KV5Ekx6U3hRYhS4EmdVyW+JNr2wBVLUMX+nIye2b6IBJuP8+BUwH8O69osKc
         87JdC2Jq8DZioVVhz9HyOH544ou/mYDmu0a6s6TYpMZuWKKEYXNJMYaPP9Mv+GEVd2m+
         5JOYfTLWxn0+oCEBm533MDr+AWBKSjOtbFurfC1CNcO+p8tJg6Dy9rJCoxcJsAaiB2TZ
         lEHsZpeP02xZR9bp77cMNhXOmCd/MGNrc2o7Iayt+MruSZovyqDHb3MHpzTodFqBg74n
         /wEDDJXhQXcjK/Jd1qOhWBJxBaOsLvTasse5Qc2AZBkUdUdX5kufZPKxDWbhpI0V7PXf
         PejQ==
X-Gm-Message-State: AOUpUlG6yqyruFMwrCjnegXY/INamwaCUpPrda9EWjR04AycQYI6GyA+
        PE5eFmUw+Vc6jcJA8/HuyRbjyJX+e+0=
X-Google-Smtp-Source: AA+uWPzOkew1vT8McaWxpzP0/XJwNXq0TiSmM8m1hefElIqJ2IO5USajGjkgjMLGFd16/wSxZnisSQ==
X-Received: by 2002:a19:f015:: with SMTP id p21-v6mr26495631lfc.77.1534706249440;
        Sun, 19 Aug 2018 12:17:29 -0700 (PDT)
Received: from gmail.com (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id j26-v6sm1282264ljc.54.2018.08.19.12.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 12:17:28 -0700 (PDT)
Date:   Sun, 19 Aug 2018 21:17:51 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: add support for mcp3911
Message-ID: <20180819191751.GB5217@gmail.com>
References: <20180808080917.2427-1-marcus.folkesson@gmail.com>
 <20180819200257.3e465759@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20180819200257.3e465759@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 08:02:57PM +0100, Jonathan Cameron wrote:
> On Wed,  8 Aug 2018 10:09:15 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> >=20
> > Co-Developed-by: Kent Gustavsson <kent@minoris.se>
> checkpatch points out..
> Co-developed-by is the 'official' form of the tag. I'll fixup.
> (first time I've seen one of these ;)

Yep, I also noticed that checkpatch is not Co-developed-by-aware yet.
I tried to fix it, but Perl is just such a terrible language that I
considered it impossible.

>=20
> > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.=20
>=20
> A few really trivial comments inline.  Also some slightly odd alignment
> I'll fix up that I haven't noted, but not every parameter second line
> lines up with the opening brackets correctly.

Thank you.
>=20
> Jonathan
>=20
> > ---
> >=20
> > Notes:
> >     v4:
> >     	- remove defined(CONFIG_OF) and of_match_ptr() macro
> >     	- do not check adc->clki as clock api is NULL-aware
> >     	- add Kent as co-developer
> >     v3:
> >     	- rename adc_clk to clki
> >     	- add error handling/cleanup for clock
> >     v2:
> >     	- cleanups and bugfixes (thanks Peter Meerwald-Stadler)
> >     	- drop hardware gain
> >     	- use the presence or lack of regulator to indicate if we go for i=
nternal or external voltage reference
> >     	- do not store device node in private struct
> >     	- drop support to set width in devicetree
> >     	- use the presence or lack of clock to indicate if we go for inter=
nal or external clock
> >=20
> >  drivers/iio/adc/Kconfig   |  10 ++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/mcp3911.c | 361 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 372 insertions(+)
> >  create mode 100644 drivers/iio/adc/mcp3911.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 15606f237480..f9a41fa96fcc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -501,6 +501,16 @@ config MCP3422
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called mcp3422.
> > =20
> > +config MCP3911
> > +	tristate "Microchip Technology MCP3911 driver"
> > +	depends on SPI
> > +	help
> > +	  Say yes here to build support for Microchip Technology's MCP3911
> > +	  analog to digital converter.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called mcp3911.
> > +
> >  config MEDIATEK_MT6577_AUXADC
> >          tristate "MediaTek AUXADC driver"
> >          depends on ARCH_MEDIATEK || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 28a9423997f3..3cfebfff7d26 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_MAX1363) +=3D max1363.o
> >  obj-$(CONFIG_MAX9611) +=3D max9611.o
> >  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> > +obj-$(CONFIG_MCP3911) +=3D mcp3911.o
> >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) +=3D mt6577_auxadc.o
> >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> >  obj-$(CONFIG_MESON_SARADC) +=3D meson_saradc.o
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > new file mode 100644
> > index 000000000000..540c8fbcce89
> > --- /dev/null
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -0,0 +1,361 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Microchip MCP3911, Two-channel Analog Front End
> > + *
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define MCP3911_REG_CHANNEL0		0x00
> > +#define MCP3911_REG_CHANNEL1		0x03
> > +#define MCP3911_REG_MOD			0x06
> > +#define MCP3911_REG_PHASE		0x07
> > +#define MCP3911_REG_GAIN		0x09
> > +
> > +#define MCP3911_REG_STATUSCOM		0x0a
> > +#define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
> > +#define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
> > +#define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> > +#define MCP3911_STATUSCOM_EN_GAINCAL	BIT(1)
> > +
> > +#define MCP3911_REG_CONFIG		0x0c
> > +#define MCP3911_CONFIG_CLKEXT		BIT(1)
> > +#define MCP3911_CONFIG_VREFEXT		BIT(2)
> > +
> > +#define MCP3911_REG_OFFCAL_CH0		0x0e
> > +#define MCP3911_REG_GAINCAL_CH0		0x11
> > +#define MCP3911_REG_OFFCAL_CH1		0x14
> > +#define MCP3911_REG_GAINCAL_CH1		0x17
> > +#define MCP3911_REG_VREFCAL		0x1a
> > +
> > +#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
> > +#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
> > +
> > +/* Internal voltage reference in uV */
> > +#define MCP3911_INT_VREF_UV		1200000
> > +
> > +#define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 <<=
 0)) & 0xff)
> > +#define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 <=
< 0)) & 0xff)
> > +
> > +#define MCP3911_NUM_CHANNELS		2
> > +
> > +struct mcp3911 {
> > +	struct spi_device *spi;
> > +	struct mutex lock;
> > +	struct regulator *vref;
> > +	struct clk *clki;
> > +	u32 dev_addr;
> > +};
> > +
> > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> > +{
> > +	int ret;
> > +
> > +	reg =3D MCP3911_REG_READ(reg, adc->dev_addr);
> > +	ret =3D spi_write_then_read(adc->spi, &reg, 1, val, len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	be32_to_cpus(val);
> > +	*val >>=3D ((4 - len) * 8);
> > +	dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
> > +			reg>>1);
>=20
> Spaces around that >> preferred - I'll add them.
>=20
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> > +{
> > +	dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", val, reg);
> > +
> > +	val <<=3D (3 - len) * 8;
> > +	cpu_to_be32s(&val);
> > +	val |=3D MCP3911_REG_WRITE(reg, adc->dev_addr);
> > +
> > +	return spi_write(adc->spi, &val, len + 1);
> > +}
> > +
> > +static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
> > +		u32 val, u8 len)
> > +{
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	ret =3D mcp3911_read(adc, reg, &tmp, len);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val &=3D mask;
> > +	val |=3D tmp & ~mask;
> > +	return mcp3911_write(adc, reg, val, len);
> > +}
> > +
> > +static int mcp3911_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +	int ret =3D -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D mcp3911_read(adc,
> > +				MCP3911_CHANNEL(channel->channel), val, 3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		ret =3D mcp3911_read(adc,
> > +				MCP3911_OFFCAL(channel->channel), val, 3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (adc->vref) {
> > +			ret =3D regulator_get_voltage(adc->vref);
> > +			if (ret < 0) {
> > +				dev_err(indio_dev->dev.parent,
> > +					"failed to get vref voltage: %d\n",
> > +				       ret);
> > +				goto out;
> > +			}
> > +
> > +			*val =3D ret / 1000;
> > +		} else {
> > +			*val =3D MCP3911_INT_VREF_UV;
> > +		}
> > +
> > +		*val2 =3D 24;
> > +		ret =3D IIO_VAL_FRACTIONAL_LOG2;
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int val,
> > +			    int val2, long mask)
> > +{
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +	int ret =3D -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		if (val2 !=3D 0) {
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> Nitpick that I don't care about enough to delay on this.  Could have
> moved the lock into the case statement then done the check outside the lo=
ck
> which would have been slightly nicer.
> > +
> > +		/* Write offset */
> > +		ret =3D mcp3911_write(adc, MCP3911_OFFCAL(channel->channel), val,
> > +				3);
> > +		if (ret)
> > +			goto out;
> > +
> > +		/* Enable offset*/
> > +		ret =3D mcp3911_update(adc, MCP3911_REG_STATUSCOM,
> > +				MCP3911_STATUSCOM_EN_OFFCAL,
> > +				MCP3911_STATUSCOM_EN_OFFCAL, 2);
> > +		break;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +	return ret;
> > +}
> > +
> > +#define MCP3911_CHAN(idx) {					\
> > +		.type =3D IIO_VOLTAGE,				\
> > +		.indexed =3D 1,					\
> > +		.channel =3D idx,					\
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> > +			BIT(IIO_CHAN_INFO_OFFSET) |		\
> > +			BIT(IIO_CHAN_INFO_SCALE),		\
> > +}
> > +
> > +static const struct iio_chan_spec mcp3911_channels[] =3D {
> > +	MCP3911_CHAN(0),
> > +	MCP3911_CHAN(1),
> > +};
> > +
> > +static const struct iio_info mcp3911_info =3D {
> > +	.read_raw =3D mcp3911_read_raw,
> > +	.write_raw =3D mcp3911_write_raw,
> > +};
> > +
> > +static int mcp3911_config(struct mcp3911 *adc, struct device_node *of_=
node)
> > +{
> > +	u32 configreg;
> > +	int ret;
> > +
> > +	of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
> > +	if (adc->dev_addr > 3) {
> > +		dev_err(&adc->spi->dev,
> > +				"invalid device address (%i). Must be in range 0-3.\n",
> > +				adc->dev_addr);
> > +		return -EINVAL;
> > +	}
> > +	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> > +
> > +	ret =3D mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (adc->vref) {
> > +		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
> > +		configreg |=3D MCP3911_CONFIG_VREFEXT;
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use internal voltage reference (1.2V)\n");
> > +		configreg &=3D ~MCP3911_CONFIG_VREFEXT;
> > +	}
> > +
> > +	if (adc->clki) {
> > +		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
> > +		configreg |=3D MCP3911_CONFIG_CLKEXT;
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use crystal oscillator as clocksource\n");
> > +		configreg &=3D ~MCP3911_CONFIG_CLKEXT;
> > +	}
> > +
> > +	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> > +}
> > +
> > +static int mcp3911_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct mcp3911 *adc;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	adc =3D iio_priv(indio_dev);
> > +	adc->spi =3D spi;
> > +
> > +	adc->vref =3D devm_regulator_get_optional(&adc->spi->dev, "vref");
> > +	if (IS_ERR(adc->vref)) {
> > +		if (PTR_ERR(adc->vref) =3D=3D -ENODEV) {
> > +			adc->vref =3D NULL;
> > +		} else {
> > +			dev_err(&adc->spi->dev,
> > +					"failed to get regulator (%ld)\n",
> > +					PTR_ERR(adc->vref));
> > +			return PTR_ERR(adc->vref);
> > +		}
> > +
> > +	} else {
> > +		ret =3D regulator_enable(adc->vref);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	adc->clki =3D devm_clk_get(&adc->spi->dev, NULL);
> > +	if (IS_ERR(adc->clki)) {
> > +		if (PTR_ERR(adc->clki) =3D=3D -ENOENT) {
> > +			adc->clki =3D NULL;
> > +		} else {
> > +			dev_err(&adc->spi->dev,
> > +					"failed to get adc clk (%ld)\n",
> > +					PTR_ERR(adc->clki));
> > +			ret =3D PTR_ERR(adc->clki);
> > +			goto reg_disable;
> > +		}
> > +	} else {
> > +		ret =3D clk_prepare_enable(adc->clki);
> > +		if (ret < 0) {
> > +			dev_err(&adc->spi->dev,
> > +				"Failed to enable clki: %d\n", ret);
> > +			goto reg_disable;
> > +		}
> > +	}
> > +
> > +	ret =3D mcp3911_config(adc, spi->dev.of_node);
> > +	if (ret)
> > +		goto clk_disable;
> > +
> > +	indio_dev->dev.parent =3D &spi->dev;
> > +	indio_dev->dev.of_node =3D spi->dev.of_node;
> > +	indio_dev->name =3D spi_get_device_id(spi)->name;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->info =3D &mcp3911_info;
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->channels =3D mcp3911_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(mcp3911_channels);
> > +
> > +	mutex_init(&adc->lock);
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret)
> > +		goto clk_disable;
> > +
> > +	return ret;
> > +
> > +clk_disable:
> > +	clk_disable_unprepare(adc->clki);
> > +reg_disable:
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mcp3911_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	clk_disable_unprepare(adc->clki);
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mcp3911_dt_ids[] =3D {
> > +	{ .compatible =3D "microchip,mcp3911" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
> > +
> > +static const struct spi_device_id mcp3911_id[] =3D {
> > +	{ "mcp3911", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, mcp3911_id);
> > +
> > +static struct spi_driver mcp3911_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "mcp3911",
> > +		.of_match_table =3D mcp3911_dt_ids,
> > +	},
> > +	.probe =3D mcp3911_probe,
> > +	.remove =3D mcp3911_remove,
> > +	.id_table =3D mcp3911_id,
> > +};
> > +module_spi_driver(mcp3911_driver);
> > +
> > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > +MODULE_AUTHOR("Kent Gustavsson <kent@minoris.se>");
> > +MODULE_DESCRIPTION("Microchip Technology MCP3911");
> > +MODULE_LICENSE("GPL v2");
>=20

Best regards
Marcus Folkesson

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt5wloACgkQiIBOb1ld
UjKJbhAAh1niAtpsuw9kznYidCxgHTYQQf8j8vVFjOFLjHzxrLKbOC2vqMUrYG/X
05AJbNAamTXYJgjFY10iH+xoagNcYgQUwoDTRHAUNdoX1TfZc8Rc0yXEmtKxC+0X
Rp5iImRxnpyrrXIjvXmdiRMx3gFlF9eVkCrpxMzn2/YTVc+Onus2UFLsSUnNyBAf
dTUruGiVpY6C2Idp6ei71R5d8YvvBFAnOvpaOt3MQ5nfNJvcqlLLBh5UUUC8IDu4
efmFzQQvnuAOzunhFuK+Grcq0vIZ/NU4ipMlkAMQa1yQ/7i7UmAXPS6V9UQh95+y
r6mZDQd8oY55SQMwExDS5LSOYuTDe3ThLVZjVZ2WWxVtPHIvpbZAe/1qKGjqh9ER
z3CmZaW6GGexw0Y8i3vJbntfWrqhPa/INEs/AtcJxYZE/xlQcfZcU4lZ3cA1b8U7
TRYqMj+ZVtjWCEX7/8v2/uJF4gRG5cR/F9v3RtxCftMnDse2YUquj1WIPMg71qP3
XwxljE+WBJ+alR1NWFc1yBaosdN8FWNAZo3PPNG3L8695h5pDANk+RUOfr17B8BD
uKYZj3RaZNAr13iYTVD+FvY5K5Z7dtccgGmXOj7GaxWYiEbQvqRqGTX/mxj/mIJh
UCL4VgPIZXUUmnaJKryp2uKjFooWfzvFce7VSgoFlD05zLqE6Bg=
=0A6d
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
