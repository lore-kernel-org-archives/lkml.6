Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776F2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c444eM5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfB0Ukn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:40:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35669 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfB0Ukn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:40:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id t13so10733471lji.2;
        Wed, 27 Feb 2019 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F0ASySfLTww1EwMvFEgZd5AwcoC6MbJDH5ObWrfRqR4=;
        b=c444eM5F2PyHv1VQwDdo+cAAS1Z/D6qFHB260C5Ab8g1LHzA+f9S7UcMD1t8LepmMz
         ETKbiSJMjlKNUEoXEO3USKzx22IESNESBBcF+8LLX6b0fsRPUncNGCRuZPWK7366d+VF
         96N383O6N8kT5IlLCZpWIAXZ2rqJrzVnwgcmlCvlpnLtaZpmuDS01kJa+xCCcdNJqL8L
         gI7cGNMLW5AJtCN2gJjtuq3tHJJ/wwxNmGnvo/jXKFc4cW9o3hYLdPlrku3yvpr8ISIQ
         qdoJodopz/WzuszNR4MuSZO3YhEdLPDz73AaG0IjtsnSJeJG1ZPOGDXiTgFT0Xj5215z
         U4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F0ASySfLTww1EwMvFEgZd5AwcoC6MbJDH5ObWrfRqR4=;
        b=F7Yrob9ZuFDd1kZTd2N+pS9SzOk+qewHgeK8AWhhit86ayr3MonKUIEzF0wI4ih9fq
         /ZxZs56mQpUIupS4AcOJ1+Ecq1neu5gjzNTgWDt3obM/Ffc2DotmDtp8GD080/BqQtQ9
         /goKrRj7B3c57shkd7+l5bQTK9ITjKRn5tNjh/FqMkxVJRikQE/w9wcq2Ie2sUngS0D8
         aBAIIBk8NUyCKW9kp+XOW8MgaLoJwAdwvrM4GU+B/Pghpt4JwRiwo2a12ZrUJbRcip+R
         ag3PT6KE6gcZN2Syy9W2cdgP86qn+6u+RQIe4YuCpXkPnqub2eMesnJfNOvHfzv5Dfeg
         Nrpw==
X-Gm-Message-State: AHQUAuYvzI4FDnGtav2kCs9iHXmdD6Z+6CuFwCIswJ3sDIjXb079Vb0m
        T0ipY76ozSO3sGCWsuhwHseK0fc3R1A=
X-Google-Smtp-Source: APXvYqygrKw9uaPil9FkW5Wbsa5hlrCRxTfgNp7K4TCLuN+m++3m5KNbnWoHeSVfV3gy7jD90qkDsQ==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr2308696ljj.99.1551300038449;
        Wed, 27 Feb 2019 12:40:38 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id i15sm3662099ljb.48.2019.02.27.12.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 12:40:37 -0800 (PST)
Date:   Wed, 27 Feb 2019 21:40:12 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3]     iio: light: Add driver for ap3216c
Message-ID: <20190227204011.GA3931@arch>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Comments inline.

On Sun, Feb 24, 2019 at 12:34:51PM -0800, Robert Eshleman wrote:
>     This patch adds support for the ap3216c ambient light and proximity
>     sensor.
>
>     Supported features include:
>
>     * Illuminance (lux)
>     * Proximity (raw)
>     * IR (raw)
>     * Rising/falling threshold events for illuminance and proximity
>     * Calibration scale for illuminance
>     * Calibration bias for proximity
>
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
> Changes in v2:
> - Add mutex protection in IRQ handler
> - Support interrupt clearing for PS and ALS separately
> - Mask away reserved bits when reading device registers
> - Use regmap_bulk_read and regmap_bulk_write when possible
> - Style cleanup
>
>  drivers/iio/light/Kconfig   |  11 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/ap3216c.c | 809 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 821 insertions(+)
>  create mode 100644 drivers/iio/light/ap3216c.c
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 36f458433480..74688d19beb1 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -41,6 +41,17 @@ config AL3320A
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called al3320a.
>
> +config AP3216C
> +	tristate "AP3216C Ambient Light and Proximity sensor"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for the AP3216C Ambient Light and
> +	  Proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ap3216c.
> +
>  config APDS9300
>  	tristate "APDS9300 ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 286bf3975372..7d2f8fa0f30d 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_AL3320A)		+= al3320a.o
> +obj-$(CONFIG_AP3216C)		+= ap3216c.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
> diff --git a/drivers/iio/light/ap3216c.c b/drivers/iio/light/ap3216c.c
> new file mode 100644
> index 000000000000..aaa319b932e6
> --- /dev/null
> +++ b/drivers/iio/light/ap3216c.c
> @@ -0,0 +1,809 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AP3216C Ambient Light and Infrared Proximity Sensor
> + *
> + * Copyright (c) 2019, Robert Eshleman.
> + *
> + * Datasheet: https://pdf-datasheet-datasheet.netdna-ssl.com/pdf-down/A/P/3/AP3216C-LITE-ON.pdf
> + *
> + * 7-bit I2C slave address 0x1E
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/bits.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +

Do we want these includes to be in alphabetical order?

> +#define AP3216C_DRV_NAME "ap3216c"
> +
> +/* register addresses */
> +#define AP3216C_SYS 0x0
> +#define AP3216C_INT_STATUS 0x01
> +#define AP3216C_INT_CLR 0x02
> +#define AP3216C_IR_DATA_LO 0x0A
> +#define AP3216C_IR_DATA_HI 0x0B
> +#define AP3216C_ALS_DATA_LO 0x0C
> +#define AP3216C_ALS_DATA_HI 0x0D
> +#define AP3216C_PS_DATA_LO 0x0E
> +#define AP3216C_PS_DATA_HI 0x0F
> +#define AP3216C_ALS_CFG 0x10
> +#define AP3216C_ALS_CALIB 0x19
> +#define AP3216C_ALS_LO_THR_LO 0x1A
> +#define AP3216C_ALS_LO_THR_HI 0x1B
> +#define AP3216C_ALS_HI_THR_LO 0x1C
> +#define AP3216C_ALS_HI_THR_HI 0x1D
> +#define AP3216C_PS_CFG 0x20
> +#define AP3216C_PS_CALIB_LO 0x28
> +#define AP3216C_PS_CALIB_HI 0x29
> +#define AP3216C_PS_LO_THR_LO 0x2A
> +#define AP3216C_PS_LO_THR_HI 0x2B
> +#define AP3216C_PS_HI_THR_LO 0x2C
> +#define AP3216C_PS_HI_THR_HI 0x2D
> +
> +/* SYS_MODE mask and config value */
> +#define AP3216C_SYS_MODE_ALS_PS 0x3
> +
> +/* INT_STATUS masks and config value */
> +#define AP3216C_INT_STATUS_ALS_MASK BIT(0)
> +#define AP3216C_INT_STATUS_PS_MASK BIT(1)
> +#define AP3216C_INT_STATUS_CLR GENMASK(1, 0)
> +#define AP3216C_INT_ALS_CLR BIT(0)
> +#define AP3216C_INT_PS_CLR BIT(1)
> +#define AP3216C_INT_CLR_MANUAL 1
> +
> +/* IR_DATA mask/shift */
> +#define AP3216C_IR_DATA_LO_MASK GENMASK(1, 0)
> +#define AP3216C_IR_DATA_HI_SHIFT 2
> +
> +/* ALS_DATA shift and fractional helper */
> +#define AP3216C_ALS_DATA_HI_SHIFT 8
> +#define AP3216C_ALS_DATA_DENOM 100000
> +
> +/* ALS_CALIB masks/shifts */
> +#define AP3216C_ALS_CALIB_INT_MASK GENMASK(7, 6)
> +#define AP3216C_ALS_CALIB_INT_SHIFT 6
> +#define AP3216C_ALS_CALIB_DEC_MASK GENMASK(5, 0)
> +
> +/* PS_DATA shifts/masks/bits */
> +#define AP3216C_PS_DATA_LO_MASK GENMASK(3, 0)
> +#define AP3216C_PS_DATA_LO_IR_OF BIT(6)
> +#define AP3216C_PS_DATA_HI_MASK GENMASK(5, 0)
> +#define AP3216C_PS_DATA_HI_SHIFT 4
> +#define AP3216C_PS_DATA_HI_IR_OF BIT(6)
> +
> +/* ALS_CFG masks */
> +#define AP3216C_ALS_CFG_GAIN_MASK GENMASK(5, 4)
> +#define AP3216C_ALS_CFG_GAIN_SHIFT 4
> +
> +/* ALS_CALIB shifts */
> +#define AP3216C_ALS_CALIB_INT_SHIFT 6
> +
> +/* ALS_HI_THR masks and shifts */
> +#define AP3216C_ALS_HI_THR_LO_MASK GENMASK(7, 0)
> +#define AP3216C_ALS_HI_THR_HI_SHIFT 8
> +#define AP3216C_ALS_HI_THR_HI_MASK GENMASK(16, 8)
> +#define AP3216C_ALS_HI_THR_HI_READ_MASK GENMASK(7, 0)
> +#define AP3216C_ALS_HI_THR_HI_SHIFT 8
> +
> +#define AP3216C_ALS_THR_HI_SHIFT 8
> +
> +/* ALS_LO_THR masks and shifts */
> +#define AP3216C_ALS_LO_THR_LO_MASK GENMASK(7, 0)
> +#define AP3216C_ALS_LO_THR_HI_MASK GENMASK(16, 8)
> +#define AP3216C_ALS_LO_THR_HI_SHIFT 8
> +
> +/* PS_CFG reg mask/shift/bit values */
> +#define AP3216C_PS_CFG_GAIN_MASK GENMASK(3, 2)
> +#define AP3216C_PS_CFG_GAIN_SHIFT 2
> +#define AP3216C_PS_CFG_GAIN(val) \
> +	(1 << ((val & AP3216C_PS_CFG_GAIN_MASK) >> AP3216C_PS_CFG_GAIN_SHIFT))
> +
> +/* PS_LO and PS_HI multiplier values */
> +#define AP3216C_PS_LO_THR_HI_MULT 4
> +#define AP3216C_PS_HI_THR_HI_MULT 4
> +#define AP3216C_PS_THR_HI_MULT 4
> +
> +/* PS_THR_LO and PS_THR_HI masks/shifts */
> +#define AP3216C_PS_THR_LO_MASK GENMASK(1, 0)
> +#define AP3216C_PS_THR_HI_MASK GENMASK(10, 2)
> +#define AP3216C_PS_THR_HI_SHIFT 2
> +
> +/* PS_CALIB_HI and PS_CALIB_LO shift/mask/bit values */
> +#define AP3216C_PS_CALIB_HI_SHIFT 1
> +#define AP3216C_PS_CALIB_HI_MASK GENMASK(8, 1)
> +#define AP3216C_PS_CALIB_LO_MASK BIT(0)
> +
> +/* ALS fractional helper values */
> +#define AP3216C_ALS_INTEG_MULT 1000
> +#define AP3216C_ALS_FRACT_DIV 100
> +
> +/* ALS_CALIB min/max values (0.0 <= ALS_CALIB <= 3.984375) */
> +#define AP3216C_ALS_CALIB_INT_MIN 0
> +#define AP3216C_ALS_CALIB_DEC_MIN 0
> +#define AP3216C_ALS_CALIB_INT_MAX 3
> +#define AP3216C_ALS_CALIB_DEC_MAX 984375
> +
> +/* ALS_CALIB conversion denominator */
> +#define AP3216C_ALS_CALIB_DENOM 64
> +
> +#define AP3216C_IIO_MULT 1000000
> +#define AP3216C_PS_THR_MAX (BIT(10) - 1)
> +
> +/* See ALS configuration ALS_GAIN field in datasheet */
> +#define AP3216C_ALS_THR_MAX 20661
> +
> +static const u16 ap3216c_gain_array[] = {
> +	3500,  /* 0.3500 lux resolution */
> +	 788,  /* 0.0788 lux resolution */
> +	 197,  /* 0.0197 lux resolution */
> +	  49,  /* 0.0049 lux resolution */
> +};
> +
> +static const u16 ap3216c_als_max_thr_array[] = {
> +	20661,  /* max thr when gain is 0.3500 */
> +	 5162,  /* max thr when gain is 0.0788 */
> +	 1291,  /* max thr when gain is 0.0197 */
> +	  323,  /* max thr when gain is 0.0049*/
> +};
> +
> +struct ap3216c_data {
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	bool als_thresh_en;
> +	bool prox_thresh_en;
> +};
> +
> +static const struct iio_event_spec ap3216c_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec ap3216c_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_CALIBSCALE),
> +		.event_spec = ap3216c_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ap3216c_event_spec),
> +	},
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.event_spec = ap3216c_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ap3216c_event_spec),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};
> +
> +static int ap3216c_read_gain(struct ap3216c_data *data, u16 *gain)
> +{
> +	unsigned int cfg;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, AP3216C_ALS_CFG, &cfg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*gain = ap3216c_gain_array[(cfg & AP3216C_ALS_CFG_GAIN_MASK) >>
> +				    AP3216C_ALS_CFG_GAIN_SHIFT];
> +	return 0;
> +}
> +
> +static int ap3216c_read_max_thr(struct ap3216c_data *data, u16 *max_thr)
> +{
> +	unsigned int cfg;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, AP3216C_ALS_CFG, &cfg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* max thr is derived from the gain bits of ALS_CFG */
> +	*max_thr = ap3216c_als_max_thr_array[
> +			(cfg & AP3216C_ALS_CFG_GAIN_MASK) >>
> +			 AP3216C_ALS_CFG_GAIN_SHIFT];
> +	return 0;
> +}
> +
> +static int ap3216c_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	u8 vals[2];
> +	int integral, fractional;
> +	u16 thr, max_thr, gain;
> +	int ret;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		ret = ap3216c_read_max_thr(data, &max_thr);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val > max_thr)
> +			val = max_thr;
> +
> +		ret = ap3216c_read_gain(data, &gain);
> +		if (ret < 0)
> +			return ret;
> +
> +		integral = val * AP3216C_ALS_INTEG_MULT / gain;
> +		fractional = val2 / AP3216C_ALS_FRACT_DIV / gain;
> +
> +		thr = integral + fractional;
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			vals[0] = thr & AP3216C_ALS_HI_THR_LO_MASK;
> +			vals[1] = (thr & AP3216C_ALS_HI_THR_HI_MASK) >>
> +				   AP3216C_ALS_HI_THR_HI_SHIFT;
> +
> +			return regmap_bulk_write(data->regmap,
> +						 AP3216C_ALS_HI_THR_LO,
> +						 vals, 2);
> +
> +		case IIO_EV_DIR_FALLING:
> +			vals[0] = thr & AP3216C_ALS_LO_THR_LO_MASK;
> +			vals[1] = (thr & AP3216C_ALS_LO_THR_HI_MASK) >>
> +				   AP3216C_ALS_LO_THR_HI_SHIFT;
> +
> +			return regmap_bulk_write(data->regmap,
> +						 AP3216C_ALS_LO_THR_LO,
> +						 vals, 2);
> +		default:
> +			return -EINVAL;
> +		}
> +
> +
> +	case IIO_PROXIMITY:
> +		if (val > AP3216C_PS_THR_MAX)
> +			val = AP3216C_PS_THR_MAX;
> +
> +		vals[0] = val & AP3216C_PS_THR_LO_MASK;
> +		vals[1] = (val & AP3216C_PS_THR_HI_MASK) >>
> +			   AP3216C_PS_THR_HI_SHIFT;
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return regmap_bulk_write(data->regmap,
> +						 AP3216C_PS_HI_THR_LO,
> +						 vals, 2);
> +
> +		case IIO_EV_DIR_FALLING:
> +			return regmap_bulk_write(data->regmap,
> +						 AP3216C_PS_LO_THR_LO,
> +						 vals, 2);
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ap3216c_get_als_reg(enum iio_event_direction dir)
> +{
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return AP3216C_ALS_HI_THR_LO;
> +
> +	case IIO_EV_DIR_FALLING:
> +		return AP3216C_ALS_LO_THR_LO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ap3216c_get_ps_reg(enum iio_event_direction dir)
> +{
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return AP3216C_PS_HI_THR_LO;
> +
> +	case IIO_EV_DIR_FALLING:
> +		return AP3216C_PS_LO_THR_LO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ap3216c_read_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int *val, int *val2)
> +{
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	u16 gain;
> +	u8 vals[2];
> +	int reg, ret;
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		reg = ap3216c_get_als_reg(dir);
> +		if (reg < 0)
> +			return reg;
> +
> +		ret = regmap_bulk_read(data->regmap, reg, vals, 2);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = ap3216c_read_gain(data, &gain);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ((vals[1] << AP3216C_ALS_THR_HI_SHIFT) | vals[0]) *
> +			 gain / AP3216C_ALS_INTEG_MULT;
> +		return IIO_VAL_INT;
> +
> +	case IIO_PROXIMITY:
> +		reg = ap3216c_get_ps_reg(dir);
> +		if (reg < 0)
> +			return reg;
> +
> +		ret = regmap_bulk_read(data->regmap, reg, vals, 2);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = (vals[1] << 2) | (vals[0] & AP3216C_PS_THR_LO_MASK);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ap3216c_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		ret = data->als_thresh_en;
> +		break;
> +
> +	case IIO_PROXIMITY:
> +		ret = data->prox_thresh_en;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int ap3216c_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int state)
> +{
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->lock);
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		data->als_thresh_en = state;
> +		break;
> +
> +	case IIO_PROXIMITY:
> +		data->prox_thresh_en = state;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static const struct regmap_config ap3216c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AP3216C_PS_HI_THR_HI,
> +};
> +
> +/**
> + * Returns integral part of decimal between 0.0 and 3.984275
> + */
> +static int ap3216c_als_calibscale_int(int val)
> +{
> +	if (val > AP3216C_ALS_CALIB_INT_MAX)
> +		return AP3216C_ALS_CALIB_INT_MAX;
> +
> +	if (val <= AP3216C_ALS_CALIB_INT_MIN)
> +		return AP3216C_ALS_CALIB_INT_MIN;
> +
> +	return val;
> +}
> +
> +/**
> + * Returns decimal part of decimal number between 0.0 and 3.984275
> + */
> +static int ap3216c_als_calibscale_dec(int val, int val2)
> +{
> +	/* Return max decimal if number exceeds calibscale max */
> +	if (val > AP3216C_ALS_CALIB_INT_MAX ||
> +	    (val == AP3216C_ALS_CALIB_INT_MAX &&
> +	     val2 > AP3216C_ALS_CALIB_DEC_MAX))
> +		return AP3216C_ALS_CALIB_DEC_MAX;
> +
> +	/* Floor the decimal if integral below minimum */
> +	if (val <= AP3216C_ALS_CALIB_INT_MIN)
> +		return AP3216C_ALS_CALIB_DEC_MIN;
> +
> +	/* Floor the decimal if decimal below minimum */
> +	if (val2 < AP3216C_ALS_CALIB_DEC_MIN)
> +		return AP3216C_ALS_CALIB_DEC_MIN;
> +
> +	/* Return max decimal if decimal above maximum */
> +	if (val2 > AP3216C_ALS_CALIB_DEC_MAX)
> +		return AP3216C_ALS_CALIB_DEC_MAX;
> +
> +	return val2;
> +}
> +
> +static int ap3216c_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	int integral, decimal;
> +	u8 vals[2];
> +	int tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			integral = ap3216c_als_calibscale_int(val);
> +			decimal = ap3216c_als_calibscale_dec(val, val2);
> +
> +			tmp = integral << AP3216C_ALS_CALIB_INT_SHIFT;
> +
> +			/*
> +			 * Reverse scaling by multiplying by the scaling
> +			 * denominator and dividing by IIO multiplier.
> +			 */
> +			tmp |= (decimal * AP3216C_ALS_CALIB_DENOM) /
> +				AP3216C_IIO_MULT;
> +
> +			return regmap_write(data->regmap,
> +					    AP3216C_ALS_CALIB, tmp);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			vals[0] = val & AP3216C_PS_CALIB_LO_MASK;
> +			vals[1] = (val & AP3216C_PS_CALIB_HI_MASK) >>
> +				   AP3216C_PS_CALIB_HI_SHIFT;
> +
> +			return regmap_bulk_write(data->regmap,
> +						 AP3216C_PS_CALIB_LO,
> +						 vals, 2);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ap3216c_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	u16 gain;
> +	u8 vals[2];
> +	int cfg, tmp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = regmap_read(data->regmap,
> +					  AP3216C_ALS_CALIB, &tmp);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* Scale is multiplied by 1/64 */
> +			*val = tmp;
> +			*val2 = AP3216C_ALS_CALIB_DENOM;
> +
> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = regmap_bulk_read(data->regmap,
> +					       AP3216C_PS_CALIB_LO,
> +					       vals, 2);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = (vals[0] & AP3216C_PS_CALIB_LO_MASK) |
> +			       ((vals[1] & AP3216C_PS_CALIB_HI_MASK) <<
> +				AP3216C_PS_CALIB_HI_SHIFT);
> +
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = regmap_bulk_read(data->regmap,
> +					       AP3216C_ALS_DATA_LO,
> +					       vals, 2);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = ap3216c_read_gain(data, &gain);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = ((vals[1] << AP3216C_ALS_DATA_HI_SHIFT) |
> +				 vals[0]) * gain;
> +			*val2 = AP3216C_ALS_DATA_DENOM;
> +
> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			if (chan->channel2 != IIO_MOD_LIGHT_IR)
> +				return -EINVAL;
> +
> +			ret = regmap_bulk_read(data->regmap,
> +					       AP3216C_IR_DATA_LO,
> +					       vals, 2);
> +
> +			*val = (vals[0] & AP3216C_IR_DATA_LO_MASK) |
> +			       (vals[1] << AP3216C_IR_DATA_HI_SHIFT);
> +
> +
> +			return IIO_VAL_INT;
> +
> +		case IIO_PROXIMITY:
> +			ret = regmap_bulk_read(data->regmap,
> +					       AP3216C_PS_DATA_LO,
> +					       vals, 2);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = regmap_read(data->regmap,
> +					  AP3216C_PS_CFG, &cfg);
> +			if (ret < 0)
> +				return ret;
> +
> +			tmp = vals[0] & AP3216C_PS_DATA_LO_MASK;
> +			tmp |= (vals[1] & AP3216C_PS_DATA_HI_MASK) <<
> +				AP3216C_PS_DATA_HI_SHIFT;
> +			*val = tmp * AP3216C_PS_CFG_GAIN(cfg);
> +
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ap3216c_info = {
> +	.read_raw = ap3216c_read_raw,
> +	.write_raw = ap3216c_write_raw,
> +	.read_event_value = ap3216c_read_event_value,
> +	.write_event_value = ap3216c_write_event_value,
> +	.read_event_config = ap3216c_read_event_config,
> +	.write_event_config = ap3216c_write_event_config,
> +};
> +
> +static irqreturn_t ap3216c_event_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct ap3216c_data *data = iio_priv(indio_dev);
> +	int status;
> +	s64 timestamp;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
> +	if (ret) {
> +		dev_err(&data->client->dev, "error reading IRQ status\n");
> +		goto done;
> +	}
> +
> +	/* The IRQ was not from this device */
> +	if (!status) {
> +		mutex_unlock(&data->lock);
> +		return IRQ_NONE;
> +	}
> +
> +	timestamp = iio_get_time_ns(indio_dev);
> +	if (status & AP3216C_INT_STATUS_PS_MASK) {
> +		if (data->prox_thresh_en)
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +
> +		ret = regmap_write(data->regmap,
> +				   AP3216C_INT_STATUS, AP3216C_INT_PS_CLR);
> +		if (ret < 0)
> +			dev_err(&data->client->dev, "error clearing PS interrupt\n");
> +	}
> +
> +	if (status & AP3216C_INT_STATUS_ALS_MASK) {
> +		if (data->als_thresh_en)
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +
> +		ret = regmap_write(data->regmap,
> +				   AP3216C_INT_STATUS, AP3216C_INT_ALS_CLR);
> +		if (ret < 0)
> +			dev_err(&data->client->dev, "error clearing ALS interrupt\n");
> +	}
> +
> +done:
> +	mutex_unlock(&data->lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int ap3216c_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct ap3216c_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &ap3216c_info;
> +	indio_dev->name = AP3216C_DRV_NAME;
> +	indio_dev->channels = ap3216c_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ap3216c_channels);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ap3216c_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "Failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	/* Default to thresh events disabled */
> +	data->als_thresh_en = false;
> +	data->prox_thresh_en = false;
> +
> +	/*
> +	 * Require that that the interrupt is cleared only when the INT_STATUS
> +	 * register is written to, instead of when data is read.
> +	 */
> +	ret = regmap_write(data->regmap,
> +			   AP3216C_INT_CLR, AP3216C_INT_CLR_MANUAL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, AP3216C_INT_STATUS,
> +			   AP3216C_INT_PS_CLR | AP3216C_INT_ALS_CLR);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "error clearing interrupts\n");
> +		return ret;
> +	}
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, ap3216c_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_SHARED | IRQF_ONESHOT,
> +						client->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable ALS and PS+IR */
> +	ret = regmap_write(data->regmap, AP3216C_SYS, AP3216C_SYS_MODE_ALS_PS);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ap3216c_of_match[] = {
> +	{ .compatible = "liteon,ap3216c", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ap3216c_of_match);
> +
> +static const struct i2c_device_id ap3216c_id[] = {
> +	{"ap3216c", 0},
> +	{ }

You can add comma here to be consistent with of_match table.

> +};
> +MODULE_DEVICE_TABLE(i2c, ap3216c_id);
> +
> +static struct i2c_driver ap3216c_driver = {
> +	.driver = {
> +		.name	= AP3216C_DRV_NAME,
> +	},
> +	.probe		= ap3216c_probe,

New drivers should use probe_new. In your case it should be rather
easy switch as you are not using id argument.

> +	.id_table	= ap3216c_id,
> +};
> +module_i2c_driver(ap3216c_driver);
> +
> +MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
> +MODULE_DESCRIPTION("AP3216C Ambient Light and Proximity Sensor");
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>
