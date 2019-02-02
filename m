Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2697C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1AA2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549103373;
	bh=ALmiRPnI8cNv8VdDIEpLRN1PVLiDfCBLYBVSO3lBnOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=awLLQOTKgNCK9B2i9SUnpqUA4X5NuFlNGGaucSMfvPVrPKgMOY6yreO0TwPFHGP25
	 ZEJYnpz07yJkPHXlg9LhQC4W36KXlhTPKbUnjCXnoo5gzj6oos3X953ovWJcD/OfRd
	 U4+12oz+W5FTF8aehNK7rQfYIwGyWzDW4WrG0wXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfBBK3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfBBK3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:29:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FC720870;
        Sat,  2 Feb 2019 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549103369;
        bh=ALmiRPnI8cNv8VdDIEpLRN1PVLiDfCBLYBVSO3lBnOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QO23eHElpAOPK4lV69x9IzAqpUXTXeW3IfRvmFr4S4HQmFS814qiBqX/6qEZFlEuX
         +wiLGihRy5k4ebb8cL0aJi+QdaRo1glZ1uEfa0uiTGSE8rn74FKkQde3bIfxHz2JSV
         Briiu7CpYGUuubT7yEtLDMMhWO7DUJiIk0kHwKz0=
Date:   Sat, 2 Feb 2019 10:29:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: adc: Add AD7768-1 ADC basic support
Message-ID: <20190202102923.181d7cc0@archlinux>
In-Reply-To: <1548951651-28405-1-git-send-email-stefan.popa@analog.com>
References: <1548951651-28405-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 18:20:51 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The ad7768-1 is a single channel, precision 24-bit analog to digital
> converter (ADC).
> 
> This basic patch configures the device in fast mode, with 32 kSPS and
> leaves the default sinc5 filter.
> 
> Two data conversion modes are made available. When data is retrieved by
> using the read_raw attribute, one shot single conversion mode is set.
> The continuous conversion mode is enabled when the triggered buffer
> mechanism is used. To assure correct data retrieval, the driver waits
> for the interrupt triggered by the low to high transition of the DRDY
> pin.
> 
> Datasheets:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Added values to all the elements of ad7768_pwrmode enum.
> 	- Removed the ad7768_ids enum, as the driver supports only one device.
> 	- Added a new data union which is part of the ad7768_state struct. This 
> 	  union, now includes a d8 field.
> 	- Used spi_write_then_read() in ad7768_spi_reg_read().
> 	- Called spi_read() instead of spi_sync_transfer() in ad7768_trigger_handler().
> 	- Used the devm_request_irq() instead of devm_request_threaded_irq(); called
> 	  iio_trigger_poll() instead of iio_trigger_poll_chained().
> Changes in v3:
> 	- Changed module license from GPL to GPL v2
> 
>  MAINTAINERS                |   7 +
>  drivers/iio/adc/Kconfig    |  13 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/ad7768-1.c | 459 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 480 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7768-1.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d039f66..3ba3811 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -862,6 +862,13 @@ S:	Supported
>  F:	drivers/iio/adc/ad7606.c
>  F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
>  
> +ANALOG DEVICES INC AD7768-1 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/adc/ad7768-1.c
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f3cc7a3..6c19dfe 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -108,6 +108,19 @@ config AD7766
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7766.
>  
> +config AD7768_1
> +	tristate "Analog Devices AD7768-1 ADC driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices AD7768-1 SPI
> +	  simultaneously sampling sigma-delta analog to digital converter (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7768-1.
> +
>  config AD7791
>  	tristate "Analog Devices AD7791 ADC driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ea50313..9d50f7b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
>  obj-$(CONFIG_AD7606) += ad7606.o
>  obj-$(CONFIG_AD7766) += ad7766.o
> +obj-$(CONFIG_AD7768_1) += ad7768-1.o
>  obj-$(CONFIG_AD7791) += ad7791.o
>  obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> new file mode 100644
> index 0000000..78449e9
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD7768-1 SPI ADC driver
> + *
> + * Copyright 2017 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +/* AD7768 registers definition */
> +#define AD7768_REG_CHIP_TYPE		0x3
> +#define AD7768_REG_PROD_ID_L		0x4
> +#define AD7768_REG_PROD_ID_H		0x5
> +#define AD7768_REG_CHIP_GRADE		0x6
> +#define AD7768_REG_SCRATCH_PAD		0x0A
> +#define AD7768_REG_VENDOR_L		0x0C
> +#define AD7768_REG_VENDOR_H		0x0D
> +#define AD7768_REG_INTERFACE_FORMAT	0x14
> +#define AD7768_REG_POWER_CLOCK		0x15
> +#define AD7768_REG_ANALOG		0x16
> +#define AD7768_REG_ANALOG2		0x17
> +#define AD7768_REG_CONVERSION		0x18
> +#define AD7768_REG_DIGITAL_FILTER	0x19
> +#define AD7768_REG_SINC3_DEC_RATE_MSB	0x1A
> +#define AD7768_REG_SINC3_DEC_RATE_LSB	0x1B
> +#define AD7768_REG_DUTY_CYCLE_RATIO	0x1C
> +#define AD7768_REG_SYNC_RESET		0x1D
> +#define AD7768_REG_GPIO_CONTROL		0x1E
> +#define AD7768_REG_GPIO_WRITE		0x1F
> +#define AD7768_REG_GPIO_READ		0x20
> +#define AD7768_REG_OFFSET_HI		0x21
> +#define AD7768_REG_OFFSET_MID		0x22
> +#define AD7768_REG_OFFSET_LO		0x23
> +#define AD7768_REG_GAIN_HI		0x24
> +#define AD7768_REG_GAIN_MID		0x25
> +#define AD7768_REG_GAIN_LO		0x26
> +#define AD7768_REG_SPI_DIAG_ENABLE	0x28
> +#define AD7768_REG_ADC_DIAG_ENABLE	0x29
> +#define AD7768_REG_DIG_DIAG_ENABLE	0x2A
> +#define AD7768_REG_ADC_DATA		0x2C
> +#define AD7768_REG_MASTER_STATUS	0x2D
> +#define AD7768_REG_SPI_DIAG_STATUS	0x2E
> +#define AD7768_REG_ADC_DIAG_STATUS	0x2F
> +#define AD7768_REG_DIG_DIAG_STATUS	0x30
> +#define AD7768_REG_MCLK_COUNTER		0x31
> +
> +/* AD7768_REG_CONVERSION */
> +#define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
> +#define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
> +
> +#define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
> +#define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
> +
> +enum ad7768_conv_mode {
> +	AD7768_CONTINUOUS,
> +	AD7768_ONE_SHOT,
> +	AD7768_SINGLE,
> +	AD7768_PERIODIC,
> +	AD7768_STANDBY
> +};
> +
> +enum ad7768_pwrmode {
> +	AD7768_ECO_MODE = 0,
> +	AD7768_MED_MODE = 2,
> +	AD7768_FAST_MODE = 3
> +};
> +
> +static const struct iio_chan_spec ad7768_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = 0,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.shift = 8,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +};
> +
> +struct ad7768_state {
> +	struct spi_device *spi;
> +	struct regulator *vref;
> +	struct mutex lock;
> +	struct completion completion;
> +	struct iio_trigger *trig;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	union {
> +		__be32 d32;
> +		u8 d8[2];
> +	} data ____cacheline_aligned;
> +};
> +
> +static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
> +			       unsigned int len)
> +{
> +	unsigned int shift;
> +	int ret;
> +
> +	shift = 32 - (8 * len);
> +	st->data.d8[0] = AD7768_RD_FLAG_MSK(addr);
> +
> +	ret = spi_write_then_read(st->spi, st->data.d8, 1,
> +				  &st->data.d32, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (be32_to_cpu(st->data.d32) >> shift);
> +}
> +
> +static int ad7768_spi_reg_write(struct ad7768_state *st,
> +				unsigned int addr,
> +				unsigned int val)
> +{
> +	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
> +	st->data.d8[1] = val & 0xFF;
> +
> +	return spi_write(st->spi, st->data.d8, 2);
> +}
> +
> +static int ad7768_set_mode(struct ad7768_state *st,
> +			   enum ad7768_conv_mode mode)
> +{
> +	int regval;
> +
> +	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
> +	if (regval < 0)
> +		return regval;
> +
> +	regval &= ~AD7768_CONV_MODE_MSK;
> +	regval |= AD7768_CONV_MODE(mode);
> +
> +	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
> +}
> +
> +static int ad7768_scan_direct(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int readval, ret;
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> +	if (readval < 0)
> +		return readval;
> +	/*
> +	 * Any SPI configuration of the AD7768-1 can only be
> +	 * performed in continuous conversion mode.
> +	 */
> +	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	return readval;
> +}
> +
> +static int ad7768_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (readval) {
> +		ret = ad7768_spi_reg_read(st, reg, 1);
> +		if (ret < 0)
> +			goto err_unlock;
> +		*readval = ret;
> +		ret = 0;
> +	} else {
> +		ret = ad7768_spi_reg_write(st, reg, writeval);
> +	}
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad7768_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int scale_uv, ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = ad7768_scan_direct(indio_dev);
> +		if (ret >= 0)
> +			*val = ret;
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		scale_uv = regulator_get_voltage(st->vref);
> +		if (scale_uv < 0)
> +			return scale_uv;
> +
> +		*val = (scale_uv * 2) / 1000;
> +		*val2 = chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ad7768_info = {
> +	.read_raw = &ad7768_read_raw,
> +	.debugfs_reg_access = &ad7768_reg_access,
> +};
> +
> +static int ad7768_setup(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
> +	 * a software reset. The bits must first be set to 11, and then
> +	 * to 10. When the sequence is detected, the reset occurs.
> +	 * See the datasheet, page 70.
> +	 */
> +	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
> +	if (ret)
> +		return ret;
> +
> +	/* Set power mode to fast */
> +	return ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK,
> +				    AD7768_FAST_MODE);
> +}
> +
> +static irqreturn_t ad7768_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = spi_read(st->spi, &st->data.d32, 3);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.d32,
> +					   iio_get_time_ns(indio_dev));
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ad7768_interrupt(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll(st->trig);
> +	else
> +		complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +};
> +
> +static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	iio_triggered_buffer_postenable(indio_dev);
> +	/*
> +	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
> +	 * continuous read mode. Subsequent data reads do not require an
> +	 * initial 8-bit write to query the ADC_DATA register.
> +	 */
> +	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
> +}
> +
> +static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * To exit continuous read mode, perform a single read of the ADC_DATA
> +	 * reg (0x2C), which allows further configuration of the device.
> +	 */
> +	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}
> +
> +static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
> +	.postenable = &ad7768_buffer_postenable,
> +	.predisable = &ad7768_buffer_predisable,
> +};
> +
> +static const struct iio_trigger_ops ad7768_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static void ad7768_regulator_disable(void *data)
> +{
> +	struct ad7768_state *st = data;
> +
> +	regulator_disable(st->vref);
> +}
> +
> +static int ad7768_probe(struct spi_device *spi)
> +{
> +	struct ad7768_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	st->vref = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(st->vref))
> +		return PTR_ERR(st->vref);
> +
> +	ret = regulator_enable(st->vref);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified vref supply\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad7768_regulator_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	mutex_init(&st->lock);
> +
> +	indio_dev->channels = ad7768_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->info = &ad7768_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> +
> +	ret = ad7768_setup(st);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "AD7768 setup failed\n");
> +		return ret;
> +	}
> +
> +	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +					  indio_dev->name, indio_dev->id);
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7768_trigger_ops;
> +	st->trig->dev.parent = &spi->dev;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_request_irq(&spi->dev, spi->irq,
> +			       &ad7768_interrupt,
> +			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			       indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad7768_trigger_handler,
> +					      &ad7768_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad7768_id_table[] = {
> +	{ "ad7768-1", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad7768_id_table);
> +
> +static const struct of_device_id ad7768_of_match[] = {
> +	{ .compatible = "adi,ad7768-1" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ad7768_of_match);
> +
> +static struct spi_driver ad7768_driver = {
> +	.driver = {
> +		.name = "ad7768-1",
> +		.of_match_table = ad7768_of_match,
> +	},
> +	.probe = ad7768_probe,
> +	.id_table = ad7768_id_table,
> +};
> +module_spi_driver(ad7768_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7768-1 ADC driver");
> +MODULE_LICENSE("GPL v2");

