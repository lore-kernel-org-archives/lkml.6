Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F14C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0569720880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0569720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeIYTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:38:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728272AbeIYTit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:38:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 654BA57887CDE;
        Tue, 25 Sep 2018 21:31:08 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 21:31:06 +0800
Date:   Tue, 25 Sep 2018 14:30:54 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Song Qiang <songqiang1304521@gmail.com>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <preid@electromag.com.au>, <rtresidd@electromag.com.au>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20180925143054.00007fcb@huawei.com>
In-Reply-To: <20180925031724.21399-2-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20180925031724.21399-2-songqiang1304521@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 11:17:24 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> composed of 3 single sensors and a processing chip with MagI2C Interface.
> 
> Following functions are available:
> - Single-shot measurement from
>   /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> - Triggerd buffer measurement.
> - Both i2c and spi interface are supported.
> - Both interrupt and polling measurement is supported, depands on if
>   the 'interrupts' in DT is declared.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Various minor comments inline.  Definitely heading in the right direction.

Good work.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Add scale channel.
> 	- Add EXPORT_SYMBOL_GPL() to export regmap confuguration
> 	  structures.
> 	- Add sampling frequency available attribute.
> 	- Clean up headers and License declarations.
> 	- Change axis number to 3.
> 	- Remove bus specific part in compatible string.
> 	- Remove le32_to_cpu().
> 	- Check cycle count registers at *_probe().
> 	- Format comments.
> 	- Spell check.
> 	- Change prefix from RM_* to RM3100_*.
> 	- Check all error return paths.
> 	- Add devm_add_action() to avoid race condition when remove.
> 
>  MAINTAINERS                            |   7 +
>  drivers/iio/magnetometer/Kconfig       |  29 ++
>  drivers/iio/magnetometer/Makefile      |   4 +
>  drivers/iio/magnetometer/rm3100-core.c | 470 +++++++++++++++++++++++++
>  drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
>  drivers/iio/magnetometer/rm3100-spi.c  |  64 ++++
>  drivers/iio/magnetometer/rm3100.h      |  73 ++++
>  7 files changed, 705 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>  create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>  create mode 100644 drivers/iio/magnetometer/rm3100.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 967ce8cdd1cc..14eeeb072403 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11393,6 +11393,13 @@ M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  S:	Maintained
>  F:	drivers/pnp/
>  
> +PNI RM3100 IIO DRIVER
> +M:	Song Qiang <songqiang1304521@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/magnetometer/rm3100*
> +F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> +
>  POSIX CLOCKS and TIMERS
>  M:	Thomas Gleixner <tglx@linutronix.de>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index ed9d776d01af..f130b866a4fc 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -175,4 +175,33 @@ config SENSORS_HMC5843_SPI
>  	  - hmc5843_core (core functions)
>  	  - hmc5843_spi (support for HMC5983)
>  
> +config SENSORS_RM3100
> +	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +
> +config SENSORS_RM3100_I2C
> +	tristate "PNI RM3100 9-Axis Magnetometer (I2C)"
> +	depends on I2C
> +	select SENSORS_RM3100
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to add support for the PNI RM3100 9-Axis Magnetometer.

Still doesn't have 9 axes ;)

> +
> +	  This driver can also be compiled as a module.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rm3100-i2c.
> +
> +config SENSORS_RM3100_SPI
> +	tristate "PNI RM3100 9-Axis Magnetometer (SPI)"
> +	depends on SPI_MASTER
> +	select SENSORS_RM3100
> +	select REGMAP_SPI
> +	help
> +	  Say Y here to add support for the PNI RM3100 9-Axis Magnetometer.
> +
> +	  This driver can also be compiled as a module.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rm3100-spi.
> +
>  endmenu
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 664b2f866472..ba1bc34b82fa 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -24,3 +24,7 @@ obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
>  obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
>  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
>  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
> +
> +obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
> +obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
> +obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> new file mode 100644
> index 000000000000..5d28b53b7a04
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -0,0 +1,470 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PNI RM3100 3-axis geomagnetic sensor driver core.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * User Manual available at
> + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> + *
> + * TODO: event generaton, pm.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>

If there is no other reason for a particular order of header includes
alphabetical is always preferred.

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_range rm3100_readable_ranges[] = {
> +	regmap_reg_range(RM3100_W_REG_START, RM3100_W_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_readable_table = {
> +	.yes_ranges = rm3100_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rm3100_readable_ranges),
> +};
> +EXPORT_SYMBOL_GPL(rm3100_readable_table);
> +
> +static const struct regmap_range rm3100_writable_ranges[] = {
> +	regmap_reg_range(RM3100_R_REG_START, RM3100_R_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_writable_table = {
> +	.yes_ranges = rm3100_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rm3100_writable_ranges),
> +};
> +EXPORT_SYMBOL_GPL(rm3100_writable_table);
> +
> +static const struct regmap_range rm3100_volatile_ranges[] = {
> +	regmap_reg_range(RM3100_V_REG_START, RM3100_V_REG_END),
> +};
> +
> +const struct regmap_access_table rm3100_volatile_table = {
> +	.yes_ranges = rm3100_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
> +};
> +EXPORT_SYMBOL_GPL(rm3100_volatile_table);
> +
> +static irqreturn_t rm3100_irq_handler(int irq, void *d)
> +{
> +	struct rm3100_data *data = d;
> +
> +	complete(&data->measuring_done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rm3100_wait_measurement(struct rm3100_data *data)
> +{
> +	struct regmap *regmap = data->regmap;
> +	unsigned int val;
> +	int tries = 20;
> +	int ret;
> +
> +	/*
> +	 * A read cycle of 400kbits i2c; bus is about 20us, plus the time
> +	 * used for scheduling, a read cycle of fast mode of this device
> +	 * can reach 1.7ms, it may be possible for data to arrive just
> +	 * after we check the RM3100_REG_STATUS. In this case, irq_handler is
> +	 * called before measuring_done is reinitialized, it will wait
> +	 * forever for data that has already been ready.
> +	 * Reinitialize measuring_done before looking up makes sure we
> +	 * will always capture interrupt no matter when it happened.
> +	 */
> +	if (data->use_interrupt)
> +		reinit_completion(&data->measuring_done);
> +
> +	ret = regmap_read(regmap, RM3100_REG_STATUS, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((val & RM3100_STATUS_DRDY) != RM3100_STATUS_DRDY) {
> +		if (data->use_interrupt) {
> +			ret = wait_for_completion_timeout(&data->measuring_done,
> +				msecs_to_jiffies(data->conversion_time));
> +			if (ret < 0)
> +				return -ETIMEDOUT;
> +		} else {
> +			do {
> +				usleep_range(1000, 5000);
> +
> +				ret = regmap_read(regmap, RM3100_REG_STATUS,
> +						  &val);
> +				if (ret < 0)
> +					return ret;
> +
> +				if (val & RM3100_STATUS_DRDY)
> +					break;
> +			} while (--tries);
> +			if (!tries)
> +				return -ETIMEDOUT;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	u8 buffer[3];
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = rm3100_wait_measurement(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> +			     23);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +#define RM3100_CHANNEL(axis, idx)					\
> +	{								\
> +		.type = IIO_MAGN,					\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.scan_index = idx,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 24,					\
> +			.storagebits = 32,				\
> +			.shift = 8,					\
> +			.endianness = IIO_LE,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec rm3100_channels[] = {
> +	RM3100_CHANNEL(X, 0),
> +	RM3100_CHANNEL(Y, 1),
> +	RM3100_CHANNEL(Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const unsigned long rm3100_scan_masks[] = {GENMASK(2, 0), 0};

This is really three separate enables, so I'd put it long hand
as BIT(0) | BIT(1) | BIT(2) to make that apparent in the code.

> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> +	"600 300 150 75 37 18 9 4.5 2.3 1.2 0.6 0.3 0.015 0.075"
> +);
> +
> +static struct attribute *rm3100_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group rm3100_attribute_group = {
> +	.attrs = rm3100_attributes,
> +};
> +
> +#define RM3100_SAMP_NUM			14
> +
> +/*
> + * Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
> + * Time between reading: rm3100_sam_rates[][2]ms.
> + * The first one is actually 1.7ms.
> + */
> +static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] = {
> +	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
> +	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
> +	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
> +	{0, 15000, 6700},  {0, 75000, 13000}
> +};
> +
> +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
> +{
> +	int ret;
> +	int tmp;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> +	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
> +{
> +	int ret;
> +	u8 i;
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, 100);

Does this write it to the same value irrespective of the value of val?
Seems odd.

> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (val == 50)

Switch would be nicer.  Also why have all other values call back to
2 rather than generating an error?

> +		data->cycle_count_index = 0;
> +	else if (val == 100)
> +		data->cycle_count_index = 1;
> +	else
> +		data->cycle_count_index = 2;
> +
> +	return 0;
> +}
> +
> +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int cycle_count;
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&data->lock);

Why are you taking this lock? It's not well documented what it protects
so it's not clear in this path why it is taken.
(hint add a comment to the definition of the lock to make it clear!)
- note I'm not saying it shouldn't be taken here, just that there is no
comment to justify it..

> +	/* All cycle count registers use the same value. */
> +	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	for (i = 0; i < RM3100_SAMP_NUM; i++) {
> +		if (val == rm3100_samp_rates[i][0] &&
> +		    val2 == rm3100_samp_rates[i][1])
> +			break;
> +	}
> +	if (i == RM3100_SAMP_NUM) {
> +		ret = -EINVAL;
> +		goto unlock_return;
> +	}
> +
> +	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	/* Checking if cycle count registers need changing. */
> +	if (val == 600 && cycle_count == 200) {
> +		ret = rm3100_set_cycle_count(data, 100);
> +		if (ret < 0)
> +			goto unlock_return;
> +	} else if (val != 600 && cycle_count == 100) {
> +		ret = rm3100_set_cycle_count(data, 200);
> +		if (ret < 0)
> +			goto unlock_return;
> +	}
> +
> +	/* Writing TMRC registers requires CMM reset. */
> +	ret = regmap_write(regmap, RM3100_REG_CMM, 0);
> +	if (ret < 0)
> +		goto unlock_return;
> +	ret = regmap_write(regmap, RM3100_REG_CMM,
> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);
> +	mutex_unlock(&data->lock);

I would move this unlock until after setting the value below
(only slightly wider scope than the minimum)
then have a single exit point by moving the unlock_return label
above it and returning ret in all cases.

> +	if (ret < 0)
> +		return ret;
> +
> +	data->conversion_time = rm3100_samp_rates[i][2] + 3000;
> +	return 0;
> +
> +unlock_return:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/*
> + * Scale of this sensor depends on cycle count value, these three values
> + * are corresponding to cycle count value 50, 100, 200.
> + * scale = output / gain * 10e4.
> + */
> +const static int rm3100_scale[] = {500, 263, 133};
> +
> +static int rm3100_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0) {
> +			iio_device_release_direct_mode(indio_dev);

Check what happens when claim_direct_mode fails.

You don't need to release it in this path.  Any kernel function
should handle it's own error paths (and this one definitely does)
so if you get an error you should never need to clean up after
the function that gave it.

> +			return ret;
> +		}
> +		ret = rm3100_read_mag(data, chan->scan_index, val);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = rm3100_scale[data->cycle_count_index];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return rm3100_get_samp_freq(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rm3100_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return rm3100_set_samp_freq(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +}
> +
> +static const struct iio_info rm3100_info = {
> +	.attrs = &rm3100_attribute_group,
> +	.read_raw = rm3100_read_raw,
> +	.write_raw = rm3100_write_raw,
> +};
> +
> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct rm3100_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	u8 buffer[9];
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&data->lock);
> +	ret = rm3100_wait_measurement(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		goto done;
> +	}
> +
> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
> +	mutex_unlock(&data->lock);

data->lock is I assume to protect the buffer.  We are still using it
so you need to hold it longer...  In fact all the way to the
done label.  So just move your unlock down there for all paths.

> +	if (ret < 0)
> +		goto done;
> +
> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> +	for (i = 0; i < 3; i++)
> +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);

Firstly X doesn't need copying.
Secondly the copy of Y actually overwrites the value of Z
XXXYYYZZZxxx
XXXxYYYZZxxx
XXXxYYYxYZZx

I think...

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +			iio_get_time_ns(indio_dev));

Align with opening bracket. 

> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void rm3100_remove(void *dh)
> +{
> +	struct rm3100_data *data = (struct rm3100_data *)dh;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, RM3100_REG_CMM, 0x00);
> +	if (ret < 0)
> +		dev_err(data->dev, "failed to stop device.\n");
> +}
> +
> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> +{
> +	struct iio_dev *indio_dev;
> +	struct rm3100_data *data;
> +	int tmp;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +	data->buffer = devm_kzalloc(dev, RM3100_SCAN_BYTES, GFP_KERNEL);
> +	if (!data->buffer)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = "rm3100";
> +	indio_dev->info = &rm3100_info;
> +	indio_dev->channels = rm3100_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = rm3100_scan_masks;
> +
> +	if (!irq)
> +		data->use_interrupt = false;
> +	else {
> +		data->use_interrupt = true;
> +		ret = devm_request_irq(dev,
> +				       irq,
> +				       rm3100_irq_handler,
> +				       IRQF_TRIGGER_RISING,
> +				       indio_dev->name,
> +				       data);
> +		if (ret < 0) {
> +			dev_err(dev, "request irq line failed.\n");
> +			return ret;
> +		}
> +		init_completion(&data->measuring_done);
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      rm3100_trigger_handler, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* 3sec more wait time. */

I have no idea what this comment is referring to..
Not seeing any waiting here...

> +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> +	if (ret < 0)
> +		return ret;
> +	data->conversion_time =
> +		rm3100_samp_rates[tmp-RM3100_TMRC_OFFSET][2] + 3000;

spacing around -  
Please check this throughout.

> +
> +	/* Cycle count values may not be what we want. */
> +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> +	if (ret < 0)
> +		return ret;
> +	if ((tmp - RM3100_TMRC_OFFSET) == 0)
> +		rm3100_set_cycle_count(data, 100);
> +	else
> +		rm3100_set_cycle_count(data, 200);
> +
> +	/* Starting all channels' conversion. */
> +	ret = regmap_write(regmap, RM3100_REG_CMM,
> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action(dev, rm3100_remove, data);

This is in the wrong order.  If you were to get an error
from devm_iio_device_register you would not unwind the stuff
in remove.

Note however there is a nasty corner in that devm_add_action can
fail. If that fails, you need to manually call your unwind function
before returning.


> +}
> +EXPORT_SYMBOL_GPL(rm3100_common_probe);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
> new file mode 100644
> index 000000000000..e8b84fac771b
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-i2c.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for PNI RM3100 3-axis geomagnetic sensor a i2c bus.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + *
> + * i2c slave address 0x20 + SA1 << 1 + SA0.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_config rm3100_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.rd_table = &rm3100_readable_table,
> +	.wr_table = &rm3100_writable_table,
> +	.volatile_table = &rm3100_volatile_table,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int rm3100_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	regmap =  devm_regmap_init_i2c(client, &rm3100_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return rm3100_common_probe(&client->dev, regmap, client->irq);
> +}
> +
> +static const struct of_device_id rm3100_dt_match[] = {
> +	{ .compatible = "pni,rm3100", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> +
> +static struct i2c_driver rm3100_driver = {
> +	.driver = {
> +		.name = "rm3100-i2c",
> +		.of_match_table = rm3100_dt_match,
> +	},
> +	.probe_new = rm3100_probe,
> +};
> +module_i2c_driver(rm3100_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
> new file mode 100644
> index 000000000000..1a7a69fb9872
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100-spi.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Support for PNI RM3100 3-axis geomagnetic sensor a spi bus.
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "rm3100.h"
> +
> +static const struct regmap_config rm3100_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.rd_table = &rm3100_readable_table,
> +	.wr_table = &rm3100_writable_table,
> +	.volatile_table = &rm3100_volatile_table,
> +
> +	.read_flag_mask = 0x80,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int rm3100_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	/* Actually this device supports both mode 0 and mode 3. */
> +	spi->mode = SPI_MODE_0;
> +	/* Data rates cannot exceed 1Mbits. */
> +	spi->max_speed_hz = 1000000;
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret)
> +		return ret;
> +
> +	regmap =  devm_regmap_init_spi(spi, &rm3100_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
> +}
> +
> +static const struct of_device_id rm3100_dt_match[] = {
> +	{ .compatible = "pni,rm3100", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> +
> +static struct spi_driver rm3100_driver = {
> +	.driver = {
> +		.name = "rm3100-spi",
> +		.of_match_table = rm3100_dt_match,
> +	},
> +	.probe = rm3100_probe,
> +};
> +module_spi_driver(rm3100_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer spi driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetometer/rm3100.h
> new file mode 100644
> index 000000000000..673647574add
> --- /dev/null
> +++ b/drivers/iio/magnetometer/rm3100.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for PNI RM3100 driver
> + *
> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + */
> +
> +#ifndef RM3100_CORE_H
> +#define RM3100_CORE_H
> +
> +#include <linux/regmap.h>
> +

Superficially it seems unlikely that any of the REG definitions
will ever be accessed from anywhere other than the -core.c file.

So it would be good to move them there.

General principle in the kernel is to limit the scope of anything
to the relevant files if possible.

> +#define RM3100_REG_REV_ID		0x36
> +
> +/* Cycle Count Registers. */
> +#define RM3100_REG_CC_X			0x05
> +#define RM3100_REG_CC_Y			0x07
> +#define RM3100_REG_CC_Z			0x09
> +
> +/* Continues Measurement Mode register. */
> +#define RM3100_REG_CMM			0x01
> +#define RM3100_CMM_START		BIT(0)
> +#define RM3100_CMM_X			BIT(4)
> +#define RM3100_CMM_Y			BIT(5)
> +#define RM3100_CMM_Z			BIT(6)
> +
> +/* TiMe Rate Configuration register. */
> +#define RM3100_REG_TMRC			0x0B
> +#define RM3100_TMRC_OFFSET		0x92
> +
> +/* Result Status register. */
> +#define RM3100_REG_STATUS		0x34
> +#define RM3100_STATUS_DRDY		BIT(7)
> +
> +/* Measurement result registers. */
> +#define RM3100_REG_MX2			0x24
> +#define RM3100_REG_MY2			0x27
> +#define RM3100_REG_MZ2			0x2a
> +
> +#define RM3100_W_REG_START		RM3100_REG_CMM
> +#define RM3100_W_REG_END		RM3100_REG_REV_ID
> +#define RM3100_R_REG_START		RM3100_REG_CMM
> +#define RM3100_R_REG_END		RM3100_REG_STATUS
> +#define RM3100_V_REG_START		RM3100_REG_MX2
> +#define RM3100_V_REG_END		RM3100_REG_STATUS
> +
> +#define RM3100_SCAN_BYTES		24
> +
> +struct rm3100_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct completion measuring_done;
> +	bool use_interrupt;
> +
> +	int conversion_time;
> +	int cycle_count_index;
> +
> +	u8 *buffer;
> +
> +	/*
> +	 * To protect consistency of every measurement and sampling
> +	 * frequency change operations.
> +	 */
> +	struct mutex lock;
> +};
This doesn't seem to be used in the i2c and spi files either - so move
the definition to the top of the -core.c file.

> +
> +extern const struct regmap_access_table rm3100_readable_table;
> +extern const struct regmap_access_table rm3100_writable_table;
> +extern const struct regmap_access_table rm3100_volatile_table;
> +
> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> +
> +#endif /* RM3100_CORE_H */


