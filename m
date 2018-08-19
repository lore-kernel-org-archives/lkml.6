Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2912C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9720C0F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 17:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO68YDPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C9720C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeHSUMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeHSUMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:12:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A029C208C3;
        Sun, 19 Aug 2018 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534698026;
        bh=m23K+Fi/q3MD0sqc7y8CBGUH+VtEhVOIuhKicvrLQeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FO68YDPlidyeRy9EohQyhvQGvDIVgAQfxzmDwIMUcPH27Iya3VY/z4ONPRPX9tW8p
         c3gtbN1YzW5oiEO6GS1bPpc90YTUS+tJqQQQchv9P5HvrAI4Dc1296fEEzp+6UpB7e
         x9vet4s/orlPst8ZyIEh33BsVIZcYcEqZ4o5R7kY=
Date:   Sun, 19 Aug 2018 18:00:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/6] iio: adxl372: New driver for Analog Devices
 ADXL372 Accelerometer
Message-ID: <20180819180020.462f492e@archlinux>
In-Reply-To: <1533890783-13456-2-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
        <1533890783-13456-2-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 11:46:18 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch adds basic support for Analog Devices ADXL372 SPI-Bus
> Three-Axis Digital Accelerometer.
> 
> The device is probed and configured the with some initial default
> values. With this basic driver, it is possible to read raw acceleration
> data.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

I fixed up the module license - assuming you are fine with the or later
version given that is what was documented by SPDX.

Thanks,

Jonathan

> ---
>  MAINTAINERS                 |   6 +
>  drivers/iio/accel/Kconfig   |  11 +
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/adxl372.c | 525 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 543 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl372.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60b1028..2ba47bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/input/misc/adxl34x.c
>  
> +ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/accel/adxl372.c
> +
>  AF9013 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 62ae7e5..1b496ef 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -60,6 +60,17 @@ config ADXL345_SPI
>  	  will be called adxl345_spi and you will also get adxl345_core
>  	  for the core module.
>  
> +config ADXL372
> +	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to add support for the Analog Devices ADXL372 triaxial
> +	  acceleration sensor.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adxl372.
> +
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 636d4d1..5758ffc 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
>  obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> +obj-$(CONFIG_ADXL372) += adxl372.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> new file mode 100644
> index 0000000..db9ecd2
> --- /dev/null
> +++ b/drivers/iio/accel/adxl372.c
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL372 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* ADXL372 registers definition */
> +#define ADXL372_DEVID			0x00
> +#define ADXL372_DEVID_MST		0x01
> +#define ADXL372_PARTID			0x02
> +#define ADXL372_REVID			0x03
> +#define ADXL372_STATUS_1		0x04
> +#define ADXL372_STATUS_2		0x05
> +#define ADXL372_FIFO_ENTRIES_2		0x06
> +#define ADXL372_FIFO_ENTRIES_1		0x07
> +#define ADXL372_X_DATA_H		0x08
> +#define ADXL372_X_DATA_L		0x09
> +#define ADXL372_Y_DATA_H		0x0A
> +#define ADXL372_Y_DATA_L		0x0B
> +#define ADXL372_Z_DATA_H		0x0C
> +#define ADXL372_Z_DATA_L		0x0D
> +#define ADXL372_X_MAXPEAK_H		0x15
> +#define ADXL372_X_MAXPEAK_L		0x16
> +#define ADXL372_Y_MAXPEAK_H		0x17
> +#define ADXL372_Y_MAXPEAK_L		0x18
> +#define ADXL372_Z_MAXPEAK_H		0x19
> +#define ADXL372_Z_MAXPEAK_L		0x1A
> +#define ADXL372_OFFSET_X		0x20
> +#define ADXL372_OFFSET_Y		0x21
> +#define ADXL372_OFFSET_Z		0x22
> +#define ADXL372_X_THRESH_ACT_H		0x23
> +#define ADXL372_X_THRESH_ACT_L		0x24
> +#define ADXL372_Y_THRESH_ACT_H		0x25
> +#define ADXL372_Y_THRESH_ACT_L		0x26
> +#define ADXL372_Z_THRESH_ACT_H		0x27
> +#define ADXL372_Z_THRESH_ACT_L		0x28
> +#define ADXL372_TIME_ACT		0x29
> +#define ADXL372_X_THRESH_INACT_H	0x2A
> +#define ADXL372_X_THRESH_INACT_L	0x2B
> +#define ADXL372_Y_THRESH_INACT_H	0x2C
> +#define ADXL372_Y_THRESH_INACT_L	0x2D
> +#define ADXL372_Z_THRESH_INACT_H	0x2E
> +#define ADXL372_Z_THRESH_INACT_L	0x2F
> +#define ADXL372_TIME_INACT_H		0x30
> +#define ADXL372_TIME_INACT_L		0x31
> +#define ADXL372_X_THRESH_ACT2_H		0x32
> +#define ADXL372_X_THRESH_ACT2_L		0x33
> +#define ADXL372_Y_THRESH_ACT2_H		0x34
> +#define ADXL372_Y_THRESH_ACT2_L		0x35
> +#define ADXL372_Z_THRESH_ACT2_H		0x36
> +#define ADXL372_Z_THRESH_ACT2_L		0x37
> +#define ADXL372_HPF			0x38
> +#define ADXL372_FIFO_SAMPLES		0x39
> +#define ADXL372_FIFO_CTL		0x3A
> +#define ADXL372_INT1_MAP		0x3B
> +#define ADXL372_INT2_MAP		0x3C
> +#define ADXL372_TIMING			0x3D
> +#define ADXL372_MEASURE			0x3E
> +#define ADXL372_POWER_CTL		0x3F
> +#define ADXL372_SELF_TEST		0x40
> +#define ADXL372_RESET			0x41
> +#define ADXL372_FIFO_DATA		0x42
> +
> +#define ADXL372_DEVID_VAL		0xAD
> +#define ADXL372_PARTID_VAL		0xFA
> +#define ADXL372_RESET_CODE		0x52
> +
> +/* ADXL372_POWER_CTL */
> +#define ADXL372_POWER_CTL_MODE_MSK		GENMASK_ULL(1, 0)
> +#define ADXL372_POWER_CTL_MODE(x)		(((x) & 0x3) << 0)
> +
> +/* ADXL372_MEASURE */
> +#define ADXL372_MEASURE_LINKLOOP_MSK		GENMASK_ULL(5, 4)
> +#define ADXL372_MEASURE_LINKLOOP_MODE(x)	(((x) & 0x3) << 4)
> +#define ADXL372_MEASURE_BANDWIDTH_MSK		GENMASK_ULL(2, 0)
> +#define ADXL372_MEASURE_BANDWIDTH_MODE(x)	(((x) & 0x7) << 0)
> +
> +/* ADXL372_TIMING */
> +#define ADXL372_TIMING_ODR_MSK			GENMASK_ULL(7, 5)
> +#define ADXL372_TIMING_ODR_MODE(x)		(((x) & 0x7) << 5)
> +
> +/* ADXL372_FIFO_CTL */
> +#define ADXL372_FIFO_CTL_FORMAT_MSK		GENMASK(5, 3)
> +#define ADXL372_FIFO_CTL_FORMAT_MODE(x)		(((x) & 0x7) << 3)
> +#define ADXL372_FIFO_CTL_MODE_MSK		GENMASK(2, 1)
> +#define ADXL372_FIFO_CTL_MODE_MODE(x)		(((x) & 0x3) << 1)
> +#define ADXL372_FIFO_CTL_SAMPLES_MSK		BIT(1)
> +#define ADXL372_FIFO_CTL_SAMPLES_MODE(x)	(((x) > 0xFF) ? 1 : 0)
> +
> +/* ADXL372_STATUS_1 */
> +#define ADXL372_STATUS_1_DATA_RDY(x)		(((x) >> 0) & 0x1)
> +#define ADXL372_STATUS_1_FIFO_RDY(x)		(((x) >> 1) & 0x1)
> +#define ADXL372_STATUS_1_FIFO_FULL(x)		(((x) >> 2) & 0x1)
> +#define ADXL372_STATUS_1_FIFO_OVR(x)		(((x) >> 3) & 0x1)
> +#define ADXL372_STATUS_1_USR_NVM_BUSY(x)	(((x) >> 5) & 0x1)
> +#define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
> +#define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
> +
> +/* ADXL372_INT1_MAP */
> +#define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
> +#define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
> +#define ADXL372_INT1_MAP_FIFO_RDY_MSK		BIT(1)
> +#define ADXL372_INT1_MAP_FIFO_RDY_MODE(x)	(((x) & 0x1) << 1)
> +#define ADXL372_INT1_MAP_FIFO_FULL_MSK		BIT(2)
> +#define ADXL372_INT1_MAP_FIFO_FULL_MODE(x)	(((x) & 0x1) << 2)
> +#define ADXL372_INT1_MAP_FIFO_OVR_MSK		BIT(3)
> +#define ADXL372_INT1_MAP_FIFO_OVR_MODE(x)	(((x) & 0x1) << 3)
> +#define ADXL372_INT1_MAP_INACT_MSK		BIT(4)
> +#define ADXL372_INT1_MAP_INACT_MODE(x)		(((x) & 0x1) << 4)
> +#define ADXL372_INT1_MAP_ACT_MSK		BIT(5)
> +#define ADXL372_INT1_MAP_ACT_MODE(x)		(((x) & 0x1) << 5)
> +#define ADXL372_INT1_MAP_AWAKE_MSK		BIT(6)
> +#define ADXL372_INT1_MAP_AWAKE_MODE(x)		(((x) & 0x1) << 6)
> +#define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
> +#define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
> +
> +/*
> + * At +/- 200g with 12-bit resolution, scale is computed as:
> + * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
> + */
> +#define ADXL372_USCALE	958241
> +
> +enum adxl372_op_mode {
> +	ADXL372_STANDBY,
> +	ADXL372_WAKE_UP,
> +	ADXL372_INSTANT_ON,
> +	ADXL372_FULL_BW_MEASUREMENT,
> +};
> +
> +enum adxl372_act_proc_mode {
> +	ADXL372_DEFAULT,
> +	ADXL372_LINKED,
> +	ADXL372_LOOPED,
> +};
> +
> +enum adxl372_th_activity {
> +	ADXL372_ACTIVITY,
> +	ADXL372_ACTIVITY2,
> +	ADXL372_INACTIVITY,
> +};
> +
> +enum adxl372_odr {
> +	ADXL372_ODR_400HZ,
> +	ADXL372_ODR_800HZ,
> +	ADXL372_ODR_1600HZ,
> +	ADXL372_ODR_3200HZ,
> +	ADXL372_ODR_6400HZ,
> +};
> +
> +enum adxl372_bandwidth {
> +	ADXL372_BW_200HZ,
> +	ADXL372_BW_400HZ,
> +	ADXL372_BW_800HZ,
> +	ADXL372_BW_1600HZ,
> +	ADXL372_BW_3200HZ,
> +};
> +
> +static const unsigned int adxl372_th_reg_high_addr[3] = {
> +	[ADXL372_ACTIVITY] = ADXL372_X_THRESH_ACT_H,
> +	[ADXL372_ACTIVITY2] = ADXL372_X_THRESH_ACT2_H,
> +	[ADXL372_INACTIVITY] = ADXL372_X_THRESH_INACT_H,
> +};
> +
> +#define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
> +	.type = IIO_ACCEL,						\
> +	.address = reg,							\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +}
> +
> +static const struct iio_chan_spec adxl372_channels[] = {
> +	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
> +	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
> +	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
> +};
> +
> +struct adxl372_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	enum adxl372_op_mode		op_mode;
> +	enum adxl372_act_proc_mode	act_proc_mode;
> +	enum adxl372_odr		odr;
> +	enum adxl372_bandwidth		bw;
> +	u32				act_time_ms;
> +	u32				inact_time_ms;
> +};
> +
> +static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
> +{
> +	__be16 regval;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, addr, &regval, sizeof(regval));
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(regval);
> +}
> +
> +static int adxl372_set_op_mode(struct adxl372_state *st,
> +			       enum adxl372_op_mode op_mode)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL372_POWER_CTL,
> +				 ADXL372_POWER_CTL_MODE_MSK,
> +				 ADXL372_POWER_CTL_MODE(op_mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	st->op_mode = op_mode;
> +
> +	return ret;
> +}
> +
> +static int adxl372_set_odr(struct adxl372_state *st,
> +			   enum adxl372_odr odr)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL372_TIMING,
> +				 ADXL372_TIMING_ODR_MSK,
> +				 ADXL372_TIMING_ODR_MODE(odr));
> +	if (ret < 0)
> +		return ret;
> +
> +	st->odr = odr;
> +
> +	return ret;
> +}
> +
> +static int adxl372_set_bandwidth(struct adxl372_state *st,
> +				 enum adxl372_bandwidth bw)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL372_MEASURE,
> +				 ADXL372_MEASURE_BANDWIDTH_MSK,
> +				 ADXL372_MEASURE_BANDWIDTH_MODE(bw));
> +	if (ret < 0)
> +		return ret;
> +
> +	st->bw = bw;
> +
> +	return ret;
> +}
> +
> +static int adxl372_set_act_proc_mode(struct adxl372_state *st,
> +				     enum adxl372_act_proc_mode mode)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap,
> +				 ADXL372_MEASURE,
> +				 ADXL372_MEASURE_LINKLOOP_MSK,
> +				 ADXL372_MEASURE_LINKLOOP_MODE(mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	st->act_proc_mode = mode;
> +
> +	return ret;
> +}
> +
> +static int adxl372_set_activity_threshold(struct adxl372_state *st,
> +					  enum adxl372_th_activity act,
> +					  bool ref_en, bool enable,
> +					  unsigned int threshold)
> +{
> +	unsigned char buf[6];
> +	unsigned char th_reg_high_val, th_reg_low_val, th_reg_high_addr;
> +
> +	/* scale factor is 100 mg/code */
> +	th_reg_high_val = (threshold / 100) >> 3;
> +	th_reg_low_val = ((threshold / 100) << 5) | (ref_en << 1) | enable;
> +	th_reg_high_addr = adxl372_th_reg_high_addr[act];
> +
> +	buf[0] = th_reg_high_val;
> +	buf[1] = th_reg_low_val;
> +	buf[2] = th_reg_high_val;
> +	buf[3] = th_reg_low_val;
> +	buf[4] = th_reg_high_val;
> +	buf[5] = th_reg_low_val;
> +
> +	return regmap_bulk_write(st->regmap, th_reg_high_addr,
> +				 buf, ARRAY_SIZE(buf));
> +}
> +
> +static int adxl372_set_activity_time_ms(struct adxl372_state *st,
> +					unsigned int act_time_ms)
> +{
> +	unsigned int reg_val, scale_factor;
> +	int ret;
> +
> +	/*
> +	 * 3.3 ms per code is the scale factor of the TIME_ACT register for
> +	 * ODR = 6400 Hz. It is 6.6 ms per code for ODR = 3200 Hz and below.
> +	 */
> +	if (st->odr == ADXL372_ODR_6400HZ)
> +		scale_factor = 3300;
> +	else
> +		scale_factor = 6600;
> +
> +	reg_val = DIV_ROUND_CLOSEST(act_time_ms * 1000, scale_factor);
> +
> +	/* TIME_ACT register is 8 bits wide */
> +	if (reg_val > 0xFF)
> +		reg_val = 0xFF;
> +
> +	ret = regmap_write(st->regmap, ADXL372_TIME_ACT, reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->act_time_ms = act_time_ms;
> +
> +	return ret;
> +}
> +
> +static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
> +					  unsigned int inact_time_ms)
> +{
> +	unsigned int reg_val_h, reg_val_l, res, scale_factor;
> +	int ret;
> +
> +	/*
> +	 * 13 ms per code is the scale factor of the TIME_INACT register for
> +	 * ODR = 6400 Hz. It is 26 ms per code for ODR = 3200 Hz and below.
> +	 */
> +	if (st->odr == ADXL372_ODR_6400HZ)
> +		scale_factor = 13;
> +	else
> +		scale_factor = 26;
> +
> +	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
> +	reg_val_h = (res >> 8) & 0xFF;
> +	reg_val_l = res & 0xFF;
> +
> +	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_L, reg_val_l);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->inact_time_ms = inact_time_ms;
> +
> +	return ret;
> +}
> +
> +static int adxl372_setup(struct adxl372_state *st)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL372_DEVID, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (regval != ADXL372_DEVID_VAL) {
> +		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
> +		return -ENODEV;
> +	}
> +
> +	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set threshold for activity detection to 1g */
> +	ret = adxl372_set_activity_threshold(st, ADXL372_ACTIVITY,
> +					     true, true, 1000);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set threshold for inactivity detection to 100mg */
> +	ret = adxl372_set_activity_threshold(st, ADXL372_INACTIVITY,
> +					     true, true, 100);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set activity processing in Looped mode */
> +	ret = adxl372_set_act_proc_mode(st, ADXL372_LOOPED);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = adxl372_set_bandwidth(st, ADXL372_BW_3200HZ);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set activity timer to 1ms */
> +	ret = adxl372_set_activity_time_ms(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set inactivity timer to 10s */
> +	ret = adxl372_set_inactivity_time_ms(st, 10000);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the mode of operation to full bandwidth measurement mode */
> +	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
> +}
> +
> +static int adxl372_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int adxl372_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adxl372_read_axis(st, chan->address);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret >> chan->scan_type.shift,
> +				     chan->scan_type.realbits - 1);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = ADXL372_USCALE;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info adxl372_info = {
> +	.read_raw = adxl372_read_raw,
> +	.debugfs_reg_access = &adxl372_reg_access,
> +};
> +
> +static const struct regmap_config adxl372_spi_regmap_config = {
> +	.reg_bits = 7,
> +	.pad_bits = 1,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(0),
> +};
> +
> +static int adxl372_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adxl372_state *st;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi = spi;
> +
> +	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	st->regmap = regmap;
> +
> +	indio_dev->channels = adxl372_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->info = &adxl372_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adxl372_setup(st);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id adxl372_id[] = {
> +	{ "adxl372", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adxl372_id);
> +
> +static struct spi_driver adxl372_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +	.probe = adxl372_probe,
> +	.id_table = adxl372_id,
> +};
> +
> +module_spi_driver(adxl372_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
> +MODULE_LICENSE("GPL v2");

