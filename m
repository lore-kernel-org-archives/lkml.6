Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AB8JxZqKMiw7S0VZeKlTFD5gp3E92cIjrbHcRN5mzTOe3xY11tc9bOuunXU66fkOCD7gBGIBfNye
ARC-Seal: i=1; a=rsa-sha256; t=1524935118; cv=none;
        d=google.com; s=arc-20160816;
        b=rM46wyKcAux6/XIJhkNqBxNNh3RstO0iCkd78Sw6kgDW9kelTZY0nsCKIfSlLL1UwB
         GSgbb+ZxyKpxYrx++W8YeedL1PxdYVAuGfOm1b/MAOR+7l1AyFjx0RN7crhVyuY1Iwcw
         CjJCKqBboaQkdag20zQ+wtNdhsUR770V2urjqMofeKTx/K8ycLKhhFZWf2UZ2nPLj1r8
         cuUSM8dcToF6MPhknX5jmgTLI3c/lvrlYd7G1uXjp4kABOZ0TNHFr1zFsDsIcRZK8TXU
         PFKQx0r0Qb9hY8c7H27ps1aDgWrGgLi7tshEOKSkv3p+iJGF97q8/4y6j/ZPousYcLOM
         F32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=4jS96nHKa+nEtfj4cm8VwcYRgx/qa2MnZNOeUuzOOWU=;
        b=ZdUjl+buRkG8EZcd5TBd9ZYf93gQXtzKZX6t3aDL4eq5DDP26KVUa2JVp0wlLg8C2x
         j/Nx1yzS8kpjLmJUgg94nG0PoHEdHMrkfBLYKJwuIRk/hNQDjTuQKxX5b7CSf0JHLzV7
         M1OceWeAu49prLFRJ4WnnHCHBwbSrlWFHFlladyOmBKrjqU/Xno6TekrzXAzuJ8WiB+w
         uqW19nU/jwhfulHEAaKcpxWxxII3oxIaPsqVz2bR0NCUm5YesR6tKXzvYdG5u9Wh7fuc
         +X+leuRMeO1G/tZl1JzqlQ/+mYELF3byPw24astI1B9GHnxGNUGgSYrI6YSkAJHcWOq6
         fEHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED1122570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 28 Apr 2018 18:05:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew
 Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: afe: rescale: new driver
Message-ID: <20180428180511.66c4d9cf@archlinux>
In-Reply-To: <20180423210809.29586-5-peda@axentia.se>
References: <20180423210809.29586-1-peda@axentia.se>
	<20180423210809.29586-5-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572702079869779?=
X-GMAIL-MSGID: =?utf-8?q?1599010366925189643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018 23:08:09 +0200
Peter Rosin <peda@axentia.se> wrote:

> If an ADC channel measures the midpoint of a voltage divider, the
> interesting voltage is often the voltage over the full resistance.
> E.g. if the full voltage is too big for the ADC to handle.
> Likewise, if an ADC channel measures the voltage across a shunt
> resistor, with or without amplification, the interesting value is
> often the current through the resistor.
> 
> This driver solves these problems by allowing to linearly scale a channel
> and/or by allowing changes to the type of the channel.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Great work.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  MAINTAINERS                   |   1 +
>  drivers/iio/Kconfig           |   1 +
>  drivers/iio/Makefile          |   1 +
>  drivers/iio/afe/Kconfig       |  19 +++
>  drivers/iio/afe/Makefile      |   6 +
>  drivers/iio/afe/iio-rescale.c | 359 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 387 insertions(+)
>  create mode 100644 drivers/iio/afe/Kconfig
>  create mode 100644 drivers/iio/afe/Makefile
>  create mode 100644 drivers/iio/afe/iio-rescale.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b23e9ebff9c..73b8fc5dd2a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6896,6 +6896,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> +F:	drivers/iio/afe/iio-rescale.c
>  
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b3c8c6ef0dff..d69e85a8bdc3 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
>  
>  source "drivers/iio/accel/Kconfig"
>  source "drivers/iio/adc/Kconfig"
> +source "drivers/iio/afe/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
>  source "drivers/iio/chemical/Kconfig"
>  source "drivers/iio/common/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index b16b2e9ddc40..d8cba9c229c0 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
>  
>  obj-y += accel/
>  obj-y += adc/
> +obj-y += afe/
>  obj-y += amplifiers/
>  obj-y += buffer/
>  obj-y += chemical/
> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
> new file mode 100644
> index 000000000000..c91eef04825a
> --- /dev/null
> +++ b/drivers/iio/afe/Kconfig
> @@ -0,0 +1,19 @@
> +#
> +# Analog Front End drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Analog Front Ends"
> +
> +config IIO_RESCALE
> +	tristate "IIO rescale"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the IIO rescaling
> +	  that handles voltage dividers, current sense shunts and
> +	  current sense amplifiers.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called iio-rescale.
> +
> +endmenu
> diff --git a/drivers/iio/afe/Makefile b/drivers/iio/afe/Makefile
> new file mode 100644
> index 000000000000..5fabb7bcac47
> --- /dev/null
> +++ b/drivers/iio/afe/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O Analog Front Ends (AFE)
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_IIO_RESCALE) += iio-rescale.o
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> new file mode 100644
> index 000000000000..e9ceee66d1e7
> --- /dev/null
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO rescale driver
> + *
> + * Copyright (C) 2018 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gcd.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct rescale;
> +
> +struct rescale_cfg {
> +	enum iio_chan_type type;
> +	int (*props)(struct device *dev, struct rescale *rescale);
> +};
> +
> +struct rescale {
> +	const struct rescale_cfg *cfg;
> +	struct iio_channel *source;
> +	struct iio_chan_spec chan;
> +	struct iio_chan_spec_ext_info *ext_info;
> +	s32 numerator;
> +	s32 denominator;
> +};
> +
> +static int rescale_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct rescale *rescale = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_read_channel_raw(rescale->source, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_read_channel_scale(rescale->source, val, val2);
> +		switch (ret) {
> +		case IIO_VAL_FRACTIONAL:
> +			*val *= rescale->numerator;
> +			*val2 *= rescale->denominator;
> +			return ret;
> +		case IIO_VAL_INT:
> +			*val *= rescale->numerator;
> +			if (rescale->denominator == 1)
> +				return ret;
> +			*val2 = rescale->denominator;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = *val * 1000000000LL;
> +			do_div(tmp, rescale->denominator);
> +			tmp *= rescale->numerator;
> +			do_div(tmp, 1000000000LL);
> +			*val = tmp;
> +			return ret;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rescale_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct rescale *rescale = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*type = IIO_VAL_INT;
> +		return iio_read_avail_channel_raw(rescale->source,
> +						  vals, length);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info rescale_info = {
> +	.read_raw = rescale_read_raw,
> +	.read_avail = rescale_read_avail,
> +};
> +
> +static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     struct iio_chan_spec const *chan,
> +				     char *buf)
> +{
> +	struct rescale *rescale = iio_priv(indio_dev);
> +
> +	return iio_read_channel_ext_info(rescale->source,
> +					 rescale->ext_info[private].name,
> +					 buf);
> +}
> +
> +static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      struct iio_chan_spec const *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct rescale *rescale = iio_priv(indio_dev);
> +
> +	return iio_write_channel_ext_info(rescale->source,
> +					  rescale->ext_info[private].name,
> +					  buf, len);
> +}
> +
> +static int rescale_configure_channel(struct device *dev,
> +				     struct rescale *rescale)
> +{
> +	struct iio_chan_spec *chan = &rescale->chan;
> +	struct iio_chan_spec const *schan = rescale->source->channel;
> +
> +	chan->indexed = 1;
> +	chan->output = schan->output;
> +	chan->ext_info = rescale->ext_info;
> +	chan->type = rescale->cfg->type;
> +
> +	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
> +	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> +		dev_err(dev, "source channel does not support raw/scale\n");
> +		return -EINVAL;
> +	}
> +
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE);
> +
> +	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> +
> +	return 0;
> +}
> +
> +static int rescale_current_sense_amplifier_props(struct device *dev,
> +						 struct rescale *rescale)
> +{
> +	u32 sense;
> +	u32 gain_mult = 1;
> +	u32 gain_div = 1;
> +	u32 factor;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "sense-resistor-micro-ohms",
> +				       &sense);
> +	if (ret) {
> +		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
> +		return ret;
> +	}
> +
> +	device_property_read_u32(dev, "sense-gain-mult", &gain_mult);
> +	device_property_read_u32(dev, "sense-gain-div", &gain_div);
> +
> +	/*
> +	 * Calculate the scaling factor, 1 / (gain * sense), or
> +	 * gain_div / (gain_mult * sense), while trying to keep the
> +	 * numerator/denominator from overflowing.
> +	 */
> +	factor = gcd(sense, 1000000);
> +	rescale->numerator = 1000000 / factor;
> +	rescale->denominator = sense / factor;
> +
> +	factor = gcd(rescale->numerator, gain_mult);
> +	rescale->numerator /= factor;
> +	rescale->denominator *= gain_mult / factor;
> +
> +	factor = gcd(rescale->denominator, gain_div);
> +	rescale->numerator *= gain_div / factor;
> +	rescale->denominator /= factor;
> +
> +	return 0;
> +}
> +
> +static int rescale_current_sense_shunt_props(struct device *dev,
> +					     struct rescale *rescale)
> +{
> +	u32 shunt;
> +	u32 factor;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				       &shunt);
> +	if (ret) {
> +		dev_err(dev, "failed to read the shunt resistance: %d\n", ret);
> +		return ret;
> +	}
> +
> +	factor = gcd(shunt, 1000000);
> +	rescale->numerator = 1000000 / factor;
> +	rescale->denominator = shunt / factor;
> +
> +	return 0;
> +}
> +
> +static int rescale_voltage_divider_props(struct device *dev,
> +					 struct rescale *rescale)
> +{
> +	int ret;
> +	u32 factor;
> +
> +	ret = device_property_read_u32(dev, "output-ohms",
> +				       &rescale->denominator);
> +	if (ret) {
> +		dev_err(dev, "failed to read output-ohms: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "full-ohms",
> +				       &rescale->numerator);
> +	if (ret) {
> +		dev_err(dev, "failed to read full-ohms: %d\n", ret);
> +		return ret;
> +	}
> +
> +	factor = gcd(rescale->numerator, rescale->denominator);
> +	rescale->numerator /= factor;
> +	rescale->denominator /= factor;
> +
> +	return 0;
> +}
> +
> +enum rescale_variant {
> +	CURRENT_SENSE_AMPLIFIER,
> +	CURRENT_SENSE_SHUNT,
> +	VOLTAGE_DIVIDER,
> +};
> +
> +static const struct rescale_cfg rescale_cfg[] = {
> +	[CURRENT_SENSE_AMPLIFIER] = {
> +		.type = IIO_CURRENT,
> +		.props = rescale_current_sense_amplifier_props,
> +	},
> +	[CURRENT_SENSE_SHUNT] = {
> +		.type = IIO_CURRENT,
> +		.props = rescale_current_sense_shunt_props,
> +	},
> +	[VOLTAGE_DIVIDER] = {
> +		.type = IIO_VOLTAGE,
> +		.props = rescale_voltage_divider_props,
> +	},
> +};
> +
> +static const struct of_device_id rescale_match[] = {
> +	{ .compatible = "current-sense-amplifier",
> +	  .data = &rescale_cfg[CURRENT_SENSE_AMPLIFIER], },
> +	{ .compatible = "current-sense-shunt",
> +	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
> +	{ .compatible = "voltage-divider",
> +	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rescale_match);
> +
> +static int rescale_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct iio_channel *source;
> +	struct rescale *rescale;
> +	int sizeof_ext_info;
> +	int sizeof_priv;
> +	int i;
> +	int ret;
> +
> +	source = devm_iio_channel_get(dev, NULL);
> +	if (IS_ERR(source)) {
> +		if (PTR_ERR(source) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get source channel\n");
> +		return PTR_ERR(source);
> +	}
> +
> +	sizeof_ext_info = iio_get_channel_ext_info_count(source);
> +	if (sizeof_ext_info) {
> +		sizeof_ext_info += 1; /* one extra entry for the sentinel */
> +		sizeof_ext_info *= sizeof(*rescale->ext_info);
> +	}
> +
> +	sizeof_priv = sizeof(*rescale) + sizeof_ext_info;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	rescale = iio_priv(indio_dev);
> +
> +	rescale->cfg = of_device_get_match_data(dev);
> +	rescale->numerator = 1;
> +	rescale->denominator = 1;
> +
> +	ret = rescale->cfg->props(dev, rescale);
> +	if (ret)
> +		return ret;
> +
> +	if (!rescale->numerator || !rescale->denominator) {
> +		dev_err(dev, "invalid scaling factor.\n");
> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	rescale->source = source;
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &rescale_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &rescale->chan;
> +	indio_dev->num_channels = 1;
> +	if (sizeof_ext_info) {
> +		rescale->ext_info = devm_kmemdup(dev,
> +						 source->channel->ext_info,
> +						 sizeof_ext_info, GFP_KERNEL);
> +		if (!rescale->ext_info)
> +			return -ENOMEM;
> +
> +		for (i = 0; rescale->ext_info[i].name; ++i) {
> +			struct iio_chan_spec_ext_info *ext_info =
> +				&rescale->ext_info[i];
> +
> +			if (source->channel->ext_info[i].read)
> +				ext_info->read = rescale_read_ext_info;
> +			if (source->channel->ext_info[i].write)
> +				ext_info->write = rescale_write_ext_info;
> +			ext_info->private = i;
> +		}
> +	}
> +
> +	ret = rescale_configure_channel(dev, rescale);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static struct platform_driver rescale_driver = {
> +	.probe = rescale_probe,
> +	.driver = {
> +		.name = "iio-rescale",
> +		.of_match_table = rescale_match,
> +	},
> +};
> +module_platform_driver(rescale_driver);
> +
> +MODULE_DESCRIPTION("IIO rescale driver");
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_LICENSE("GPL v2");
