Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E21ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD1E2083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWJwkW+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD1E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeJVBz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeJVBz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:55:57 -0400
Received: from archlinux (host-89-242-135-188.as13285.net [89.242.135.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678CD20779;
        Sun, 21 Oct 2018 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540143652;
        bh=+Z35zo5UlKVftZH/AH07C9vTQZwZqeQfPuQJzdAUPYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MWJwkW+ogyQUi+4Z7qdXauMgbfxDylrWK6d1/Ioj0XxlHy2OKdpAtRMY7c4fA5+Qk
         a/ca1is5Y+Gd7KpC9TB99/wPEGWORFL0BDlkndcvNaClZjCc78GOUmzUcvQx8s2ntQ
         s6OdeG0dvlOthkxUj8fvIkKtuPx053TdzNCLnhYA=
Date:   Sun, 21 Oct 2018 18:40:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
Message-ID: <20181021184047.6f32c04e@archlinux>
In-Reply-To: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 12:10:32 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Move ad7606 ADC driver out of staging and into the mainline.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Hi Stefan,

Great to be moving forward on this.  A few comments inline.  There are
some somewhat old school structures in here we can do better now ;)

Thanks

Jonathan

> ---
>  MAINTAINERS                          |   7 +
>  drivers/iio/adc/Kconfig              |  34 +++
>  drivers/iio/adc/Makefile             |   3 +
>  drivers/iio/adc/ad7606.c             | 565 +++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7606.h             | 106 +++++++
>  drivers/iio/adc/ad7606_par.c         | 113 +++++++
>  drivers/iio/adc/ad7606_spi.c         |  79 +++++
>  drivers/staging/iio/adc/Kconfig      |  34 ---
>  drivers/staging/iio/adc/Makefile     |   3 -
>  drivers/staging/iio/adc/ad7606.c     | 565 -----------------------------------
>  drivers/staging/iio/adc/ad7606.h     | 106 -------
>  drivers/staging/iio/adc/ad7606_par.c | 113 -------
>  drivers/staging/iio/adc/ad7606_spi.c |  79 -----
>  13 files changed, 907 insertions(+), 900 deletions(-)
>  create mode 100644 drivers/iio/adc/ad7606.c
>  create mode 100644 drivers/iio/adc/ad7606.h
>  create mode 100644 drivers/iio/adc/ad7606_par.c
>  create mode 100644 drivers/iio/adc/ad7606_spi.c
>  delete mode 100644 drivers/staging/iio/adc/ad7606.c
>  delete mode 100644 drivers/staging/iio/adc/ad7606.h
>  delete mode 100644 drivers/staging/iio/adc/ad7606_par.c
>  delete mode 100644 drivers/staging/iio/adc/ad7606_spi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f642044..843545d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -839,6 +839,13 @@ S:	Supported
>  F:	drivers/iio/dac/ad5758.c
>  F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  
> +ANALOG DEVICES INC AD7606 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/adc/ad7606.c
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a52fea8..22bafdc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -58,6 +58,40 @@ config AD7476
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7476.
>  
> +config AD7606
> +	tristate "Analog Devices AD7606 ADC driver"
> +	depends on GPIOLIB || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices:
> +	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7606.
There is little point in having all 3 of these selectable individually. I would
have the two interface types select this.
Simplifies the Kconfig menu a little

> +
> +config AD7606_IFACE_PARALLEL
> +	tristate "parallel interface support"
> +	depends on AD7606
> +	help
> +	  Say yes here to include parallel interface support on the AD7606
> +	  ADC driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7606_parallel.
> +
> +config AD7606_IFACE_SPI
> +	tristate "spi interface support"
> +	depends on AD7606
> +	depends on SPI
> +	help
> +	  Say yes here to include parallel interface support on the AD7606
> +	  ADC driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7606_spi.
> +
>  config AD7766
>  	tristate "Analog Devices AD7766/AD7767 ADC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a6e6a0b..b734f4f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -8,6 +8,9 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7298) += ad7298.o
> +obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
> +obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> +obj-$(CONFIG_AD7606) += ad7606.o
>  obj-$(CONFIG_AD7923) += ad7923.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7766) += ad7766.o
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> new file mode 100644
> index 0000000..0b728b6
> --- /dev/null
> +++ b/drivers/iio/adc/ad7606.c
> @@ -0,0 +1,565 @@
> +/*
> + * AD7606 SPI ADC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/sched.h>
> +#include <linux/module.h>
Nice to have these in alphabetical order (as you are tidying up anyway ;)
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include "ad7606.h"
> +
> +/*
> + * Scales are computed as 5000/32768 and 10000/32768 respectively,
> + * so that when applied to the raw values they provide mV values
> + */
> +static const unsigned int scale_avail[2][2] = {
> +	{0, 152588}, {0, 305176}
> +};
> +
> +static int ad7606_reset(struct ad7606_state *st)
> +{
> +	if (st->gpio_reset) {
> +		gpiod_set_value(st->gpio_reset, 1);
> +		ndelay(100); /* t_reset >= 100ns */
> +		gpiod_set_value(st->gpio_reset, 0);
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int ad7606_read_samples(struct ad7606_state *st)
> +{
> +	unsigned int num = st->chip_info->num_channels;
> +	u16 *data = st->data;
> +	int ret;
> +
> +	/*
> +	 * The frstdata signal is set to high while and after reading the sample
> +	 * of the first channel and low for all other channels. This can be used
> +	 * to check that the incoming data is correctly aligned. During normal
> +	 * operation the data should never become unaligned, but some glitch or
> +	 * electrostatic discharge might cause an extra read or clock cycle.
> +	 * Monitoring the frstdata signal allows to recover from such failure
> +	 * situations.
> +	 */
> +
> +	if (st->gpio_frstdata) {
> +		ret = st->bops->read_block(st->dev, 1, data);
> +		if (ret)
> +			return ret;
> +
> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> +			ad7606_reset(st);
> +			return -EIO;
> +		}
> +
> +		data++;
> +		num--;
> +	}
> +
> +	return st->bops->read_block(st->dev, num, data);
> +}
> +
> +static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct ad7606_state *st = iio_priv(pf->indio_dev);
> +
> +	gpiod_set_value(st->gpio_convst, 1);

I'd worry a little here about sleeping gpio chip writes...

> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
> + * @work_s:	the work struct through which this was scheduled
> + *
> + * Currently there is no option in this driver to disable the saving of
> + * timestamps within the ring.
That's a problem given I'm fairly sure you will be able to wiggle the
relevant sysfs control and then userspace will expect it to be disabled...

Though I'm also fairly sure this comment isn't true as it's not in the control
of this code :)

> + * I think the one copy of this at a time was to avoid problems if the
> + * trigger was set far too high and the reads then locked up the computer.

No idea what this comment is about...

As I commented below, I think this should be a threaded interrupt.

> + */
> +static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
> +{
> +	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
> +						poll_work);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	int ret;
> +
> +	ret = ad7606_read_samples(st);
> +	if (ret == 0)
> +		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +						   iio_get_time_ns(indio_dev));
> +
> +	gpiod_set_value(st->gpio_convst, 0);
> +	iio_trigger_notify_done(indio_dev->trig);
> +}
> +
> +static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->done = false;
> +	gpiod_set_value(st->gpio_convst, 1);
> +
> +	ret = wait_event_interruptible(st->wq_data_avail, st->done);
> +	if (ret)
> +		goto error_ret;
> +
> +	ret = ad7606_read_samples(st);
> +	if (ret == 0)
> +		ret = st->data[ch];
> +
> +error_ret:
> +	gpiod_set_value(st->gpio_convst, 0);
> +
> +	return ret;
> +}
> +
> +static int ad7606_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
> +{
> +	int ret;
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = ad7606_scan_direct(indio_dev, chan->address);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		if (ret < 0)
> +			return ret;
> +		*val = (short)ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = scale_avail[st->range][0];
> +		*val2 = scale_avail[st->range][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->oversampling;
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static ssize_t in_voltage_scale_available_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
> +				 scale_avail[i][0], scale_avail[i][1]);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
> +
> +static int ad7606_oversampling_get_index(unsigned int val)
> +{
> +	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(supported); i++)
> +		if (val == supported[i])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +static int ad7606_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int values[3];
> +	int ret, i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = -EINVAL;
> +		mutex_lock(&st->lock);
> +		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
> +			if (val2 == scale_avail[i][1]) {
> +				gpiod_set_value(st->gpio_range, i);
> +				st->range = i;
> +
> +				ret = 0;
> +				break;
> +			}
> +		mutex_unlock(&st->lock);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2)
> +			return -EINVAL;
> +		ret = ad7606_oversampling_get_index(val);
> +		if (ret < 0)
> +			return ret;
> +
> +		values[0] = (ret >> 0) & 1;
> +		values[1] = (ret >> 1) & 1;
> +		values[2] = (ret >> 2) & 1;
> +
> +		mutex_lock(&st->lock);
> +		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
> +				      values);
> +		st->oversampling = val;
> +		mutex_unlock(&st->lock);
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
> +
> +static struct attribute *ad7606_attributes_os_and_range[] = {
> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7606_attribute_group_os_and_range = {
> +	.attrs = ad7606_attributes_os_and_range,
> +};
> +
> +static struct attribute *ad7606_attributes_os[] = {
> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7606_attribute_group_os = {
> +	.attrs = ad7606_attributes_os,
> +};
> +
> +static struct attribute *ad7606_attributes_range[] = {
> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7606_attribute_group_range = {
> +	.attrs = ad7606_attributes_range,
> +};
> +
> +#define AD760X_CHANNEL(num, mask)				\
> +	{							\
> +		.type = IIO_VOLTAGE,				\
> +		.indexed = 1,					\
> +		.channel = num,					\
> +		.address = num,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> +		.info_mask_shared_by_all = mask,		\

Brackets around num and mask through out.  One of the static checkers
will likely moan at us for it being fragile otherwise!

> +		.scan_index = num,				\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 16,				\
> +			.storagebits = 16,			\
> +			.endianness = IIO_CPU,			\
Hmm. This is only true for the spi case due to swapping in the read
function.  However, it would be a pain to deal with that given the parallel
interface will normally be correct, so lets leave this as is.

> +		},						\
> +	}
> +
> +#define AD7605_CHANNEL(num)	\
> +	AD760X_CHANNEL(num, 0)
> +
> +#define AD7606_CHANNEL(num)	\
> +	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +
> +static const struct iio_chan_spec ad7605_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +	AD7605_CHANNEL(0),
> +	AD7605_CHANNEL(1),
> +	AD7605_CHANNEL(2),
> +	AD7605_CHANNEL(3),
> +};
> +
> +static const struct iio_chan_spec ad7606_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +	AD7606_CHANNEL(0),
> +	AD7606_CHANNEL(1),
> +	AD7606_CHANNEL(2),
> +	AD7606_CHANNEL(3),
> +	AD7606_CHANNEL(4),
> +	AD7606_CHANNEL(5),
> +	AD7606_CHANNEL(6),
> +	AD7606_CHANNEL(7),
> +};
> +
> +static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
> +	/*
> +	 * More devices added in future

It's a single line comment. Use single line syntax.

> +	 */
> +	[ID_AD7605_4] = {
> +		.channels = ad7605_channels,
> +		.num_channels = 5,
> +	},
> +	[ID_AD7606_8] = {
> +		.channels = ad7606_channels,
> +		.num_channels = 9,
> +		.has_oversampling = true,
> +	},
> +	[ID_AD7606_6] = {
> +		.channels = ad7606_channels,
> +		.num_channels = 7,
> +		.has_oversampling = true,
> +	},
> +	[ID_AD7606_4] = {
> +		.channels = ad7606_channels,
> +		.num_channels = 5,
> +		.has_oversampling = true,
> +	},
> +};
> +
> +static int ad7606_request_gpios(struct ad7606_state *st)
> +{
> +	struct device *dev = st->dev;
> +
> +	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_convst))
> +		return PTR_ERR(st->gpio_convst);
> +
> +	st->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_reset))
> +		return PTR_ERR(st->gpio_reset);
> +
> +	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_range))
> +		return PTR_ERR(st->gpio_range);
> +
> +	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_standby))
> +		return PTR_ERR(st->gpio_standby);
> +
> +	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
> +						    GPIOD_IN);
> +	if (IS_ERR(st->gpio_frstdata))
> +		return PTR_ERR(st->gpio_frstdata);
> +
> +	if (!st->chip_info->has_oversampling)
> +		return 0;
> +
> +	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
> +			GPIOD_OUT_LOW);
> +	return PTR_ERR_OR_ZERO(st->gpio_os);
> +}
> +
> +/**
> + *  Interrupt handler
This is kernel-doc.  It probably should be though for consistency
with a lot of the rest of the code.
> + */
> +static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		schedule_work(&st->poll_work);

Why not just do a threaded interrupt?

> +	} else {
> +		st->done = true;
> +		wake_up_interruptible(&st->wq_data_avail);
> +	}
> +
> +	return IRQ_HANDLED;
> +};
> +
> +static const struct iio_info ad7606_info_no_os_or_range = {
> +	.read_raw = &ad7606_read_raw,
> +};
> +
> +static const struct iio_info ad7606_info_os_and_range = {
> +	.read_raw = &ad7606_read_raw,
> +	.write_raw = &ad7606_write_raw,
> +	.attrs = &ad7606_attribute_group_os_and_range,
> +};
> +
> +static const struct iio_info ad7606_info_os = {
> +	.read_raw = &ad7606_read_raw,
> +	.write_raw = &ad7606_write_raw,
> +	.attrs = &ad7606_attribute_group_os,
> +};
> +
> +static const struct iio_info ad7606_info_range = {
> +	.read_raw = &ad7606_read_raw,
> +	.write_raw = &ad7606_write_raw,
> +	.attrs = &ad7606_attribute_group_range,
> +};
> +
> +int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> +		 const char *name, unsigned int id,
> +		 const struct ad7606_bus_ops *bops)
> +{
> +	struct ad7606_state *st;
> +	int ret;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->dev = dev;
> +	mutex_init(&st->lock);
> +	st->bops = bops;
> +	st->base_address = base_address;
> +	/* tied to logic low, analog input range is +/- 5V */
> +	st->range = 0;
> +	st->oversampling = 1;
> +	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
> +
> +	st->reg = devm_regulator_get(dev, "avcc");
> +	if (IS_ERR(st->reg))
> +		return PTR_ERR(st->reg);
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable specified AVcc supply\n");
> +		return ret;
> +	}
> +
> +	st->chip_info = &ad7606_chip_info_tbl[id];
> +
> +	ret = ad7606_request_gpios(st);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	indio_dev->dev.parent = dev;
> +	if (st->gpio_os) {
> +		if (st->gpio_range)
> +			indio_dev->info = &ad7606_info_os_and_range;
> +		else
> +			indio_dev->info = &ad7606_info_os;
> +	} else {
> +		if (st->gpio_range)
> +			indio_dev->info = &ad7606_info_range;
> +		else
> +			indio_dev->info = &ad7606_info_no_os_or_range;
> +	}
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = name;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +
> +	init_waitqueue_head(&st->wq_data_avail);
> +
> +	ret = ad7606_reset(st);
> +	if (ret)
> +		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
> +
> +	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
> +			  indio_dev);
> +	if (ret)
> +		goto error_disable_reg;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
> +					 NULL, NULL);
> +	if (ret)
> +		goto error_free_irq;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_unregister_ring;
> +
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	return 0;
> +error_unregister_ring:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +error_free_irq:
> +	free_irq(irq, indio_dev);
> +
> +error_disable_reg:
> +	regulator_disable(st->reg);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ad7606_probe);
> +
> +int ad7606_remove(struct device *dev, int irq)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	free_irq(irq, indio_dev);
> +	regulator_disable(st->reg);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ad7606_remove);
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int ad7606_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	if (st->gpio_standby) {
> +		gpiod_set_value(st->gpio_range, 1);
> +		gpiod_set_value(st->gpio_standby, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7606_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	if (st->gpio_standby) {
> +		gpiod_set_value(st->gpio_range, st->range);
> +		gpiod_set_value(st->gpio_standby, 1);
> +		ad7606_reset(st);
> +	}
> +
> +	return 0;
> +}
> +
> +SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
> +EXPORT_SYMBOL_GPL(ad7606_pm_ops);
> +
> +#endif
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> new file mode 100644
> index 0000000..8618805
> --- /dev/null
> +++ b/drivers/iio/adc/ad7606.h
> @@ -0,0 +1,106 @@
> +/*
> + * AD7606 ADC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
SPDX.  I'll stop banging on about that ;)

> + */
> +
> +#ifndef IIO_ADC_AD7606_H_
> +#define IIO_ADC_AD7606_H_
> +
> +/**
> + * struct ad7606_chip_info - chip specific information
> + * @channels:		channel specification
> + * @num_channels:	number of channels
> + * @has_oversampling:   whether the device has oversampling support
> + */
> +
Normal convention is no gap between docs and structure.

> +struct ad7606_chip_info {
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
> +	bool				has_oversampling;
> +};
> +
> +/**
> + * struct ad7606_state - driver instance specific data
> + * @dev		pointer to kernel device
> + * @chip_info		entry in the table of chips that describes this device
> + * @reg		regulator info for the the power supply of the device
> + * @poll_work		work struct for continuously reading data from the device
> + *			into an IIO triggered buffer
> + * @wq_data_avail	wait queue struct for buffer mode
> + * @bops		bus operations (SPI or parallel)
> + * @range		voltage range selection, selects which scale to apply
> + * @oversampling	oversampling selection
> + * @done		marks whether reading data is done
> + * @base_address	address from where to read data in parallel operation
> + * @lock		protect sensor state from concurrent accesses to GPIOs
> + * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
> + * @gpio_reset		GPIO descriptor for device hard-reset
> + * @gpio_range		GPIO descriptor for range selection
> + * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
> + *			controls power-down mode of device
> + * @gpio_frstdata	GPIO descriptor for reading from device when data
> + *			is being read on the first channel
> + * @gpio_os		GPIO descriptors to control oversampling on the device
> + * @data		buffer for reading data from the device
> + */
> +
> +struct ad7606_state {
> +	struct device			*dev;
> +	const struct ad7606_chip_info	*chip_info;
> +	struct regulator		*reg;
> +	struct work_struct		poll_work;
> +	wait_queue_head_t		wq_data_avail;
> +	const struct ad7606_bus_ops	*bops;
> +	unsigned int			range;
> +	unsigned int			oversampling;
> +	bool				done;
> +	void __iomem			*base_address;
> +
> +	struct mutex			lock; /* protect sensor state */
> +	struct gpio_desc		*gpio_convst;
> +	struct gpio_desc		*gpio_reset;
> +	struct gpio_desc		*gpio_range;
> +	struct gpio_desc		*gpio_standby;
> +	struct gpio_desc		*gpio_frstdata;
> +	struct gpio_descs		*gpio_os;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 * 8 * 16-bit samples + 64-bit timestamp
> +	 */
> +	unsigned short			data[12] ____cacheline_aligned;
> +};
> +
> +/**
> + * struct ad7606_bus_ops - driver bus operations
> + * @read_block		function pointer for reading blocks of data
> + */
> +struct ad7606_bus_ops {
> +	/* more methods added in future? */
> +	int (*read_block)(struct device *dev, int num, void *data);
> +};
> +
> +int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> +		 const char *name, unsigned int id,
> +		 const struct ad7606_bus_ops *bops);
> +int ad7606_remove(struct device *dev, int irq);
> +
> +enum ad7606_supported_device_ids {
> +	ID_AD7605_4,
> +	ID_AD7606_8,
> +	ID_AD7606_6,
> +	ID_AD7606_4
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +extern const struct dev_pm_ops ad7606_pm_ops;
> +#define AD7606_PM_OPS (&ad7606_pm_ops)
> +#else
> +#define AD7606_PM_OPS NULL
> +#endif
> +
> +#endif /* IIO_ADC_AD7606_H_ */
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> new file mode 100644
> index 0000000..8bd86e7
> --- /dev/null
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -0,0 +1,113 @@
> +/*
> + * AD7606 Parallel Interface ADC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
SPDX preferred.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <linux/iio/iio.h>
> +#include "ad7606.h"
> +
> +static int ad7606_par16_read_block(struct device *dev,
> +				   int count, void *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	insw((unsigned long)st->base_address, buf, count);
> +
> +	return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_par16_bops = {
> +	.read_block	= ad7606_par16_read_block,
> +};
> +
> +static int ad7606_par8_read_block(struct device *dev,
> +				  int count, void *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	insb((unsigned long)st->base_address, buf, count * 2);
> +
> +	return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_par8_bops = {
> +	.read_block	= ad7606_par8_read_block,
> +};
> +
> +static int ad7606_par_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	struct resource *res;
> +	void __iomem *addr;
> +	resource_size_t remap_size;
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq: %d\n", irq);
> +		return irq;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	addr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	remap_size = resource_size(res);
> +
> +	return ad7606_probe(&pdev->dev, irq, addr,
> +			    id->name, id->driver_data,
> +			    remap_size > 1 ? &ad7606_par16_bops :
> +			    &ad7606_par8_bops);
> +}
> +
> +static int ad7606_par_remove(struct platform_device *pdev)
> +{
> +	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
> +}
> +
> +static const struct platform_device_id ad7606_driver_ids[] = {
> +	{
> +		.name		= "ad7605-4",
> +		.driver_data	= ID_AD7605_4,
> +	}, {
> +		.name		= "ad7606-8",
> +		.driver_data	= ID_AD7606_8,
> +	}, {
> +		.name		= "ad7606-6",
> +		.driver_data	= ID_AD7606_6,
> +	}, {
> +		.name		= "ad7606-4",
> +		.driver_data	= ID_AD7606_4,
> +	},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
> +
> +static struct platform_driver ad7606_driver = {
> +	.probe = ad7606_par_probe,
> +	.remove	= ad7606_par_remove,
> +	.id_table = ad7606_driver_ids,
> +	.driver = {
> +		.name	 = "ad7606",
> +		.pm	 = AD7606_PM_OPS,
> +	},
> +};
> +
> +module_platform_driver(ad7606_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> new file mode 100644
> index 0000000..b76ca5a
> --- /dev/null
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -0,0 +1,79 @@
> +/*
> + * AD7606 SPI ADC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
SPDX preferred.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +#include "ad7606.h"
> +
> +#define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
> +
> +static int ad7606_spi_read_block(struct device *dev,
> +				 int count, void *buf)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	int i, ret;
> +	unsigned short *data = buf;
> +	__be16 *bdata = buf;
> +
> +	ret = spi_read(spi, buf, count * 2);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "SPI read error\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < count; i++)
> +		data[i] = be16_to_cpu(bdata[i]);
This looks a bit like we should have been doing the spi handling
with a 16 bit word.. However, seems unlikely you have a be platform
so we'd mostly end up swaping the bytes anyway.  Guess it's just
as easy assuming an 8 bit word.

> +
> +	return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_spi_bops = {
> +	.read_block	= ad7606_spi_read_block,

No real point in the tab alignment tricks with only one entry.
Doesn't do much harm though so I don't really care ;)

> +};
> +
> +static int ad7606_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	return ad7606_probe(&spi->dev, spi->irq, NULL,
> +			    id->name, id->driver_data,
> +			    &ad7606_spi_bops);
> +}
> +
> +static int ad7606_spi_remove(struct spi_device *spi)
> +{
> +	return ad7606_remove(&spi->dev, spi->irq);
> +}
> +
> +static const struct spi_device_id ad7606_id[] = {
> +	{"ad7605-4", ID_AD7605_4},
> +	{"ad7606-8", ID_AD7606_8},
> +	{"ad7606-6", ID_AD7606_6},
> +	{"ad7606-4", ID_AD7606_4},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad7606_id);

I'd like to see an explicit device_tree id table as
well to include the manufacturer id stuff.

One day we might actually stop matching on these IDs
though efforts that way seem to have reduced recently.


> +
> +static struct spi_driver ad7606_driver = {
> +	.driver = {
> +		.name = "ad7606",
> +		.pm = AD7606_PM_OPS,
> +	},
> +	.probe = ad7606_spi_probe,
> +	.remove = ad7606_spi_remove,
> +	.id_table = ad7606_id,
> +};
> +module_spi_driver(ad7606_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> +MODULE_LICENSE("GPL v2");
...
