Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FADEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB5B21569
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJOjP7JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB5B21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeHBUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:51:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34233 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeHBUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:51:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id n96-v6so2327833lfi.1;
        Thu, 02 Aug 2018 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SSCNjVjenfgrQhVStd6CTXQ3Mlz8cV5vbSgIg8OhV4o=;
        b=XJOjP7JE8KHAzZAgaigfoNAKI3Pn+qs2qHDQF4P6iZCU3hSGMjl9UnrT054zQKplZo
         gvKRzcKrMuPcYDa0dFpfzfGBIQ/3JK40pjVj6Y3LsiQ5zl/5Jdxebe0QfEEcIrXLKjXa
         1TaRj3sgvXWhkVYdvNLpisQ7t12ipWmiwVINK8caWhQcNHqMbomY1nOWemmJKPQjz6Dy
         ctNqvXQK+VEpUhZBCNbSHAKugr0mXdBzu2K6u6Hntr5etCzKdLCHwzUnbqiSIvMtFpjO
         8qgclO5y2jcaeJBhbxHoJhexMbJQC+/+fM/bE1Mr33JsU4tQ09SN8skttAGDepWSBPAx
         r9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSCNjVjenfgrQhVStd6CTXQ3Mlz8cV5vbSgIg8OhV4o=;
        b=K4N9j3T5hDDxdyZqg2sLeE/anCWASMCMv7DEBdkwnJjKAnXw++2CGTevn712JMTOiQ
         cZanSRqQdJ7RIL8rwyKHT9OJm1H7WlUQH/ZeV/rUB3niV+tvXhmqAvX4Ss6qaA34KsND
         BGN4CKYvi+BBVvrrtL2BAId6HHL8saBtYg/yXL1A8RjvZX+KBb/EDZZupC1scHv6nnxd
         trDu7VTFHfSK65z/IBbZI7v0Hgg17ViOtkiSRHVk4oE/ZglkwXLAQCFppBPZ6kdw19ia
         15KCyucctEYwJ9CfE5vSU6R3T8OuVwCeun53DO0UdFTY75fxCA54mHh8/g0mV5pwnmlL
         SpKA==
X-Gm-Message-State: AOUpUlGRWyK6sVh1f7Cgil48vgLHG3pDPO+aBJ3dsY9MGXahqxhLU7vP
        5a6oMWghL4psT51/LP1K4+E=
X-Google-Smtp-Source: AAOMgpd2L+lH1919A7WCCWWnQrKGlaFa7F4Fa1xXHX1i8aW48VPmkgfueF97UHKnzOtJMcpAItk7Wg==
X-Received: by 2002:a19:3b11:: with SMTP id i17-v6mr2570698lfa.146.1533236330878;
        Thu, 02 Aug 2018 11:58:50 -0700 (PDT)
Received: from gmail.com ([46.194.111.21])
        by smtp.gmail.com with ESMTPSA id n24-v6sm531323ljc.7.2018.08.02.11.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 11:58:49 -0700 (PDT)
Date:   Thu, 2 Aug 2018 20:59:01 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] iio: adc: add support for mcp3911
Message-ID: <20180802185835.GA1727@gmail.com>
References: <20180724183004.20279-1-marcus.folkesson@gmail.com>
 <20180729124422.28b3ac04@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20180729124422.28b3ac04@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Sorry for the delay, I've been away from keyboard for a few days.

On Sun, Jul 29, 2018 at 12:44:22PM +0100, Jonathan Cameron wrote:
> On Tue, 24 Jul 2018 20:30:02 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Signed-off-by: Kent Gustavsson <kent@minoris.se>
> Hi
>=20
> I think you missed cleaning up the clock enable in the remove.
> If it is safe to not do so it should also be safe in the error path
> of probe.

I've actually noticed this and had it prepared in v4 :-)

>=20
> A couple of trivial other things jumped out at me whilst reading.

Thank you so much, I will fix these.
>=20
> Thanks,
>=20
> Jonathan
> > ---
> >=20
> > Notes:
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
> >  drivers/iio/adc/mcp3911.c | 366 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 377 insertions(+)
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
> > index 000000000000..29aa39930ead
> > --- /dev/null
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -0,0 +1,366 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Microchip MCP3911, Two-channel Analog Front End
> > + *
> > + * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
> > + *
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
> > +	struct clk *adc_clk;
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
> > +	return spi_write(adc->spi, &val, len+1);
>=20
> Spaces around operators needed everywhere.  Please check the=20
> kernel coding style docs.
>=20
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
> > +
> The blank line here is inconsistent with other near by blocks (nitpick ;)
> > +	} else {
> > +		dev_dbg(&adc->spi->dev, "use internal voltage reference (1.2V)\n");
> > +		configreg &=3D ~MCP3911_CONFIG_VREFEXT;
> > +	}
> > +
> > +	if (adc->adc_clk) {
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
> > +
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
> > +	adc->adc_clk =3D devm_clk_get(&adc->spi->dev, "adc_clk");
> > +	if (IS_ERR(adc->adc_clk)) {
> > +		if (PTR_ERR(adc->adc_clk) =3D=3D -ENOENT) {
> > +			adc->adc_clk =3D NULL;
> > +		} else {
> > +			dev_err(&adc->spi->dev,
> > +					"failed to get adc clk (%ld)\n",
> > +					PTR_ERR(adc->adc_clk));
> > +			ret =3D PTR_ERR(adc->adc_clk);
> > +			goto reg_disable;
> > +		}
> > +	} else {
> > +		ret =3D clk_prepare_enable(adc->adc_clk);
> > +		if (ret < 0) {
> > +			dev_err(&adc->spi->dev,
> > +				"Failed to enable adc_clk: %d\n", ret);
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
> > +	if (adc->adc_clk)
> > +		clk_disable_unprepare(adc->adc_clk);
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
>=20
> You need to also disable_unprepare the clock in remove as well.
>=20
> > +	if (adc->vref)
> > +		regulator_disable(adc->vref);
> > +
> > +	return 0;
> > +}
> > +
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id mcp3911_dt_ids[] =3D {
> > +	{ .compatible =3D "microchip,mcp3911" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mcp3911_dt_ids);
> > +#endif
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
> > +		.of_match_table =3D of_match_ptr(mcp3911_dt_ids),
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

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltjVHAACgkQiIBOb1ld
UjJICA//Wxf+SwL0gy9zVGipM5TcHFIOVJUw/Q5LOg+AH1KRlJKdIdUQ7OKeRb1I
3UBTijAzSd/ynk+USfGIkmLiGoMouS9HLXDshpavIEC+qG50OzF4FS+fVdgUn89O
ndgPH37BB7EdgMZSuX1/anTAFhTWuvousg2PqexBBuIvSjzduZWVeQwFKYM/rSXV
DOkMnw4jaQ2bA3TzcTJNtnaRaNMm57u1GS2bA2Rz+Ts9pIFQBOjxxWAUQR4RRBMs
zBpQaq8/AXyiUMPNbPURvOKma8YtQoJJTFGeKJlV12wXFSm91VLVfz4qdfghS1he
omm1jeuuLFdi328ck3OjvAfkm0tSkNbRocPXJWdqloiNZW3NJVnmCfaRgmUM4ab8
3lUTQL3v4b3lFYBjYvHCXVP/Ip0v7Rc7ekm415SyewsOkctW0zYxAykKOjYcc69G
aU9wMfMdl+BALD2N+w46nxbsssx/AMir4k6ugOhb+7UBArtc/SENuiiqUmnSDe4i
3RRmHKe0hpKAeS69fAcGCfWabJn08aXDRahgmX7Gf2K7usfP29VaHkUKulqLNZ4L
tHOmtyFjzMcxqcr6qHnLKkJwqdEptth2bLhvUfJm5HUk7re5PRydpSKAIs+U5lsD
0nEgI18riJpT6nzzjBoEJU54qpQlPhp5x+dztrK9eh1weNN7fyQ=
=wcuk
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
