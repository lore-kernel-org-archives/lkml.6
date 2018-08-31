Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D975D20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyUlvb6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D975D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeHaTqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:46:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35510 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeHaTqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:46:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so10454401ljg.2;
        Fri, 31 Aug 2018 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=56qGPYHW/gOpHa0fMKtcYIm0+mwfK8AtoU+b3R4qOnY=;
        b=LyUlvb6JsaP4hvhRw8u5kC3mM5t6PAoatR2Y8IXN9zmv3zUXhkpha4qAjEwSthp4x+
         ELMTMgFBim5iABnXNCOze4uVhBSZXez81lPyckOUpEOBPRyVyD/Elkcqh9+LGX317BCA
         uR38TtVi1m25Jo5GpXXlSJMixlsJtjZSHbK/nwNvJSb6afHKrQWO4XqVG7BWnsCkuLco
         PNeLuMdh4/9j4MWmEqAJVuFKpYe91HfRJt3XPl3GWw6x1WqQK0A0T/BU/ZL/PRBQVurr
         czCSQJqsAIf1PhNTghgjv6KB/TJqTp2EuhrfEnq8K148YJeEiZ9+UkJ3AfeqUyRmoM2V
         YOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=56qGPYHW/gOpHa0fMKtcYIm0+mwfK8AtoU+b3R4qOnY=;
        b=JW2mzteOiG24Mf1nuvFIrt1DzeB2HvI8Z/aQ/0sX7jBh3q7BLc1FoZQlho4X9Jcba5
         X/myQueAODvFHxCb66tV9yikPhUiYEJCg4JiEbiA88yaDSeVZ2WSw88R6lbU46/55mBI
         1Hadv3jiQHilnHqH6iddE3lMsGd9hRwxEerKne6plZfamH7uKGhih1Ft+9Ial8CdSHsg
         Fu7hjVoBPsV5M8RAURrCyHaKmIvrQGMXo7AQtentm2+CDld/hzWEv9EwH+l/7uMBFL3P
         tzALj35GkP4YnHnGGF6bOtJkL1daGE+xJeqfqnH7plq+feiuSPZ746J7Dokx0TC/UbbX
         53qQ==
X-Gm-Message-State: APzg51Bz9N1PaWvKi6HopcBX2RKmxVsqvmAOxklOU2TI2RitNuWJA/Hr
        7GQ6hyhzQGxIKp9+kf6Vnlc=
X-Google-Smtp-Source: ANB0VdbZiijnBe3jZIFoDXMoxBZ/Lc4EGKKmsgRmpJcE7MAGJbBGdiDq+e//qXXGyxPGHO8oejSR5A==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr10644927ljj.142.1535729908732;
        Fri, 31 Aug 2018 08:38:28 -0700 (PDT)
Received: from localhost (89-70-31-6.dynamic.chello.pl. [89.70.31.6])
        by smtp.gmail.com with ESMTPSA id 23-v6sm1047863lfw.48.2018.08.31.08.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:38:28 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:35:49 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: gyro: add support for fxas21002c
Message-ID: <20180831153548.GA2679@arch>
References: <20180830211825.12202-1-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830211825.12202-1-afonsobordado@az8.co>
User-Agent: Mutt/1.6.2 (2016-07-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:18:22PM +0100, Afonso Bordado wrote:
> FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
>
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  Changes in v2
>    - Use ANSI C Comments
>    - Minor cleanups
>    - More dscriptive devicetree bindings
>
>  drivers/iio/gyro/Kconfig      |  11 +
>  drivers/iio/gyro/Makefile     |   1 +
>  drivers/iio/gyro/fxas21002c.c | 367 ++++++++++++++++++++++++++++++++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 drivers/iio/gyro/fxas21002c.c
>
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 3126cf05e6b9..d71e33ea9fa4 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -73,6 +73,17 @@ config BMG160_SPI
>  	tristate
>  	select REGMAP_SPI
>
> +config FXAS21002C
> +	tristate "Freescale FXAS21002C Gyroscope"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the Freescale FXAS21002C Gyroscope
> +	  driver connected via I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called fxas21002c.
> +
>  config HID_SENSOR_GYRO_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 295ec780c4eb..ec3e2aeae92a 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_ADXRS450) += adxrs450.o
>  obj-$(CONFIG_BMG160) += bmg160_core.o
>  obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>  obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
> +obj-$(CONFIG_FXAS21002C) += fxas21002c.o
>
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> new file mode 100644
> index 000000000000..261b73629544
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FXAS21002C - Digital Angular Rate Gyroscope driver
> + *
> + * Copyright (c) 2018, Afonso Bordado <afonsobordado@az8.co>
> + *
> + * IIO driver for FXAS21002C (7-bit I2C slave address 0x20 or 0x21).
> + * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
> + * TODO:
> + *        ODR / Scale Support
> + *        Devicetree
> + *        Power management
> + *        LowPass/HighPass Filters
> + *        Buffers
> + *        Interrupts
> + *        Alarms
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>
> +
> +#define FXAS21002C_DRV_NAME "fxas21002c"
> +
> +#define FXAS21002C_MAX_TRANSITION_TIME_MS 61
> +
> +#define FXAS21002C_CHIP_ID             0xD7
> +
> +#define FXAS21002C_REG_STATUS          0x00
> +#define FXAS21002C_REG_OUT_X_MSB       0x01
> +#define FXAS21002C_REG_OUT_X_LSB       0x02
> +#define FXAS21002C_REG_OUT_Y_MSB       0x03
> +#define FXAS21002C_REG_OUT_Y_LSB       0x04
> +#define FXAS21002C_REG_OUT_Z_MSB       0x05
> +#define FXAS21002C_REG_OUT_Z_LSB       0x06
> +#define FXAS21002C_REG_DR_STATUS       0x07
> +#define FXAS21002C_REG_F_STATUS        0x08
> +#define FXAS21002C_REG_F_SETUP         0x09
> +#define FXAS21002C_REG_F_EVENT         0x0A
> +#define FXAS21002C_REG_INT_SRC_FLAG    0x0B
> +#define FXAS21002C_REG_WHO_AM_I        0x0C
> +#define FXAS21002C_REG_CTRL_REG0       0x0D
> +#define FXAS21002C_REG_RT_CFG          0x0E
> +#define FXAS21002C_REG_RT_SRC          0x0F
> +#define FXAS21002C_REG_RT_THS          0x10
> +#define FXAS21002C_REG_RT_COUNT        0x11
> +#define FXAS21002C_REG_TEMP            0x12
> +
> +#define FXAS21002C_REG_CTRL_REG1       0x13
> +#define FXAS21002C_RST_BIT             BIT(6)
> +#define FXAS21002C_ACTIVE_BIT          BIT(1)
> +#define FXAS21002C_READY_BIT           BIT(0)
> +
> +#define FXAS21002C_REG_CTRL_REG2       0x14
> +#define FXAS21002C_REG_CTRL_REG3       0x15
> +
> +#define FXAS21002C_DEFAULT_ODR_HZ      800
> +
> +/* 0.0625 deg/s */
> +#define FXAS21002C_DEFAULT_SENSITIVITY IIO_DEGREE_TO_RAD(62500)
> +
> +#define FXAS21002C_TEMP_SCALE          1000
> +
> +enum fxas21002c_id {

It looks like your are not using this named enum anywhere
in the code so perhaps drop the name. Besides the name
collides with i2c_device_id table's name. Just a suggestion though.

> +	ID_FXAS21002C,
> +};
> +
> +enum fxas21002c_operating_mode {
> +	FXAS21002C_OM_BOOT,
> +	FXAS21002C_OM_STANDBY,
> +	FXAS21002C_OM_READY,
> +	FXAS21002C_OM_ACTIVE,
> +};
> +
> +struct fxas21002c_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_range fxas21002c_writable_ranges[] = {
> +	regmap_reg_range(FXAS21002C_REG_F_SETUP, FXAS21002C_REG_F_SETUP),
> +	regmap_reg_range(FXAS21002C_REG_CTRL_REG0, FXAS21002C_REG_RT_CFG),
> +	regmap_reg_range(FXAS21002C_REG_RT_THS, FXAS21002C_REG_RT_COUNT),
> +	regmap_reg_range(FXAS21002C_REG_CTRL_REG1, FXAS21002C_REG_CTRL_REG3),
> +};
> +
> +static const struct regmap_access_table fxas21002c_writable_table = {
> +	.yes_ranges = fxas21002c_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_writable_ranges),
> +};
> +
> +static const struct regmap_range fxas21002c_volatile_ranges[] = {
> +	regmap_reg_range(FXAS21002C_REG_STATUS, FXAS21002C_REG_F_STATUS),
> +	regmap_reg_range(FXAS21002C_REG_F_EVENT, FXAS21002C_REG_INT_SRC_FLAG),
> +	regmap_reg_range(FXAS21002C_REG_RT_COUNT, FXAS21002C_REG_CTRL_REG1),
> +};
> +
> +static const struct regmap_access_table fxas21002c_volatile_table = {
> +	.yes_ranges = fxas21002c_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(fxas21002c_volatile_ranges),
> +};
> +
> +const struct regmap_config fxas21002c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = FXAS21002C_REG_CTRL_REG3,
> +	/* We don't specify a .rd_table because everything is readable */
> +	.wr_table = &fxas21002c_writable_table,
> +	.volatile_table = &fxas21002c_volatile_table,
> +};
> +EXPORT_SYMBOL(fxas21002c_regmap_config);
> +
> +#define FXAS21002C_GYRO_CHAN(_axis) {					\
> +	.type = IIO_ANGL_VEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_ ## _axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.address = FXAS21002C_REG_OUT_ ## _axis ## _MSB,		\
> +}
> +
> +static const struct iio_chan_spec fxas21002c_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = FXAS21002C_REG_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	FXAS21002C_GYRO_CHAN(X),
> +	FXAS21002C_GYRO_CHAN(Y),
> +	FXAS21002C_GYRO_CHAN(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int fxas21002c_set_operating_mode(struct fxas21002c_data *data,
> +					 enum fxas21002c_operating_mode om)
> +{
> +	int ret;
> +	int mask;
> +
> +	switch (om) {
> +	case FXAS21002C_OM_STANDBY:
> +		mask = 0;
> +		break;
> +	case FXAS21002C_OM_READY:
> +		mask = FXAS21002C_READY_BIT;
> +		break;
> +	case FXAS21002C_OM_ACTIVE:
> +		mask = FXAS21002C_ACTIVE_BIT;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(data->regmap, FXAS21002C_REG_CTRL_REG1, mask);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +			"could not switch operating mode\n");
> +		return ret;
> +	}
> +
> +	msleep(FXAS21002C_MAX_TRANSITION_TIME_MS);
> +
> +	return 0;
> +}
> +
> +static void fxas21002c_standby(void *_data)
> +{
> +	struct fxas21002c_data *data = _data;
> +
> +	fxas21002c_set_operating_mode(data, FXAS21002C_OM_STANDBY);
> +}
> +
> +static int fxas21002c_reset(struct fxas21002c_data *data)
> +{
> +	int ret;
> +
> +	/*
> +	 * On issuing a Software Reset command over an I2C interface,
> +	 * the device immediately resets and does not send any
> +	 * acknowledgment (ACK) of the written byte to the Master.
> +	 *
> +	 * This is documented in table 46 on the datasheet. Due to this
> +	 * the write will fail with EREMOTEIO.
> +	 */
> +	ret = regmap_write(data->regmap,
> +			   FXAS21002C_REG_CTRL_REG1, FXAS21002C_RST_BIT);
> +
> +	if (ret != -EREMOTEIO) {
> +		dev_err(&data->client->dev, "could not reset device\n");
> +		return ret;
> +	}
> +
> +	regcache_mark_dirty(data->regmap);
> +
> +	/* Wait for device to boot up */
> +	msleep(FXAS21002C_MAX_TRANSITION_TIME_MS);
> +
> +	return 0;
> +}
> +
> +static int fxas21002c_verify_chip(struct fxas21002c_data *data)
> +{
> +	int ret;
> +	int chip_id;
> +
> +	ret = regmap_read(data->regmap, FXAS21002C_REG_WHO_AM_I, &chip_id);
> +	if (ret) {
> +		dev_err(&data->client->dev, "could not read device id\n");
> +		return ret;
> +	}
> +
> +	if (chip_id != FXAS21002C_CHIP_ID) {
> +		dev_err(&data->client->dev,
> +			"unsupported chip id %02x\n", chip_id);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fxas21002c_read_oneshot(struct fxas21002c_data *data,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	int ret;
> +	__be16 bulk_raw;
> +
> +	switch (chan->type) {
> +	case IIO_ANGL_VEL:
> +		ret = regmap_bulk_read(data->regmap, chan->address,
> +				       &bulk_raw, sizeof(bulk_raw));
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(be16_to_cpu(bulk_raw), 15);
> +		return IIO_VAL_INT;
> +	case IIO_TEMP:
> +		ret = regmap_read(data->regmap, chan->address, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int fxas21002c_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan, int *val,
> +			       int *val2, long mask)
> +{
> +	struct fxas21002c_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return fxas21002c_read_oneshot(data, chan, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val = 0;
> +			*val2 = FXAS21002C_DEFAULT_SENSITIVITY;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = FXAS21002C_TEMP_SCALE;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (chan->type != IIO_ANGL_VEL)
> +			return -EINVAL;
> +
> +		*val = FXAS21002C_DEFAULT_ODR_HZ;
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info fxas21002c_info = {
> +	.read_raw		= fxas21002c_read_raw,
> +};
> +
> +static int fxas21002c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct fxas21002c_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &fxas21002c_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		ret = PTR_ERR(data->regmap);
> +		dev_err(&client->dev,
> +			"Failed to allocate regmap, err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = fxas21002c_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(fxas21002c_channels);
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &fxas21002c_info;
> +
> +	ret = fxas21002c_verify_chip(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fxas21002c_reset(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fxas21002c_set_operating_mode(data, FXAS21002C_OM_ACTIVE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action(&client->dev, fxas21002c_standby, data);
> +	if (ret < 0) {
> +		fxas21002c_standby(data);
> +		dev_err(&client->dev, "failed to add standby action\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to register iio device\n");
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id fxas21002c_id[] = {
> +	{"fxas21002c", ID_FXAS21002C},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
> +
> +static struct i2c_driver fxas21002c_driver = {
> +	.driver = {
> +		.name = FXAS21002C_DRV_NAME,
> +	},
> +	.probe		= fxas21002c_probe,
> +	.id_table	= fxas21002c_id,
> +};
> +
> +module_i2c_driver(fxas21002c_driver);
> +
> +MODULE_AUTHOR("Afonso Bordado <afonsobordado@az8.co>");
> +MODULE_DESCRIPTION("FXAS21002C Digital Angular Rate Gyroscope driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.18.0
>
>
