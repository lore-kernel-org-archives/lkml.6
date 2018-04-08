Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx48RwMpvqAqwaFfcJMNbJLvREtxJYlsPOj/1NG162qi6YTD/f/hTnQ0rfOv92OeVbKp2kzKp
ARC-Seal: i=1; a=rsa-sha256; t=1523206511; cv=none;
        d=google.com; s=arc-20160816;
        b=czbAWikbbDK+Swyn/hF5yY3HiKZwC5Vhwmy289v9BN5rQp0x57O/fLDhS4LEFAdgGp
         YLubyYu/AYtyWcb98QXEnVBonty+l9m/uXkKHd6hduZM79LLNsKKaVKJTN8F5H0H9o9C
         14s/SGwK+9mvOvTkAF5QRo4+96pUePbLu7LDd+oV2dzBvoOnUuG5+IpB+hS6IKWtJqfP
         p1j2YWLZgxq74c5t5+8VLW7fNHfGcQffzOm3YtFLfG2wruKN5aa7E0ZPbu9BmYqOfVev
         kwxxZnPJrK3drDbMA0PmEI9k59z1l68cNHiRdxv2xmk7rRSg+5KqltHOyLJLUunBTff7
         yqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=6mH6PNBn8Gn1nYYGBpiFW0hBcDQaWuhs4EKe8vCorQ0=;
        b=AUhAyUqMQDmd6zs1hnw2riiYNqjmwgwCrRWpRxBXwoFmBiKgVdED6/xUs6F6MfjcSH
         jJNSNZPkoWtX8IPN/FJHezOcmuK5fzyfTVf9vzfPDcJ4k2SIaAgOOq6cqZFV6DD3itaD
         3ghaCSUR2XFRLRmqWNkut4Dc+1yAcTRqHuXSOo8L7aWZlp533YzIqI0UX5IkyCLYl51d
         zzb9NoMwvSScWDf1l2E9VoFDCaW7gVZ+8uC/LhzBbeoRlQsDOwRR99PAPRlBnbEGXA3l
         lfHfC1u/Fx7eXvckX91FMUfPrkHfeCy3NmWPzMfsTJzMRWWOaqExtUdbiyx//D3WQ37Q
         8Z+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1E521738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 8 Apr 2018 17:55:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: afe: unit-converter: new driver
Message-ID: <20180408175503.43334cff@archlinux>
In-Reply-To: <20180403153635.8228-3-peda@axentia.se>
References: <20180403153635.8228-1-peda@axentia.se>
	<20180403153635.8228-3-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739887853490430?=
X-GMAIL-MSGID: =?utf-8?q?1597197790169227498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue,  3 Apr 2018 17:36:35 +0200
Peter Rosin <peda@axentia.se> wrote:

> If an ADC channel measures the midpoint of a voltage divider, the
> interesting voltage is often the voltage over the full resistance.
> E.g. if the full voltage is too big for the ADC to handle.
> Likewise, if an ADC channel measures the voltage across a resistor,
> the interesting value is often the current through the resistor.
> 
> This driver solves both problems by allowing to linearly scale a channel
> and by allowing changes to the type of the channel. Or both.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
One passing comment inline but nothing that really matters..

Looks good to me and I'll be happy to take it once we are
sure everyone is happy with the devicetree bindings.

Thanks,

Jonathan

> ---
>  MAINTAINERS                          |   1 +
>  drivers/iio/Kconfig                  |   1 +
>  drivers/iio/Makefile                 |   1 +
>  drivers/iio/afe/Kconfig              |  18 +++
>  drivers/iio/afe/Makefile             |   6 +
>  drivers/iio/afe/iio-unit-converter.c | 257 +++++++++++++++++++++++++++++++++++
>  6 files changed, 284 insertions(+)
>  create mode 100644 drivers/iio/afe/Kconfig
>  create mode 100644 drivers/iio/afe/Makefile
>  create mode 100644 drivers/iio/afe/iio-unit-converter.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9dbe5019c6bd..f9835521eec6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6895,6 +6895,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> +F:	drivers/iio/afe/iio-unit-converter.c
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
> index 000000000000..75acbe7eed15
> --- /dev/null
> +++ b/drivers/iio/afe/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# Analog Front End drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Analog Front Ends"
> +
> +config IIO_UNIT_CONVERTER
> +	tristate "IIO unit converter"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the IIO unit converter
> +	  that handles voltage dividers and current sense circuits.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called iio-unit-converter.
> +
> +endmenu
> diff --git a/drivers/iio/afe/Makefile b/drivers/iio/afe/Makefile
> new file mode 100644
> index 000000000000..7691cc5b809a
> --- /dev/null
> +++ b/drivers/iio/afe/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O Analog Front Ends (AFE)
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_IIO_UNIT_CONVERTER) += iio-unit-converter.o
> diff --git a/drivers/iio/afe/iio-unit-converter.c b/drivers/iio/afe/iio-unit-converter.c
> new file mode 100644
> index 000000000000..43429543cc29
> --- /dev/null
> +++ b/drivers/iio/afe/iio-unit-converter.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO unit converter
> + *
> + * Copyright (C) 2018 Axentia Technologies AB
> + *
> + * Author: Peter Rosin <peda@axentia.se>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct unit_converter_cfg {
> +	enum iio_chan_type type;
> +};
> +
> +enum unit_converter_variant {
> +	CURRENT_SENSE_CIRCUIT,
> +	VOLTAGE_DIVIDER,
> +};
> +
> +static const struct unit_converter_cfg unit_converter_cfg[] = {
> +	[CURRENT_SENSE_CIRCUIT] = {
> +		.type = IIO_CURRENT,
> +	},
> +	[VOLTAGE_DIVIDER] = {
> +		.type = IIO_VOLTAGE,
> +	},
> +};
> +
> +struct unit_converter {
> +	const struct unit_converter_cfg *cfg;
> +	struct iio_channel *source;
> +	struct iio_dev *indio_dev;
> +	struct iio_chan_spec chan;
> +	struct iio_chan_spec_ext_info *ext_info;
> +	s32 numerator;
> +	s32 denominator;
> +};
> +
> +static int unit_converter_read_raw(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +	unsigned long long tmp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return iio_read_channel_raw(uc->source, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_read_channel_scale(uc->source, val, val2);
> +		switch (ret) {
> +		case IIO_VAL_FRACTIONAL:
> +			*val *= uc->numerator;
> +			*val2 *= uc->denominator;
> +			return ret;
> +		case IIO_VAL_INT:
> +			*val *= uc->numerator;
> +			if (uc->denominator == 1)
> +				return ret;
> +			*val2 = uc->denominator;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp = *val * 1000000000LL;
> +			do_div(tmp, uc->denominator);
> +			tmp *= uc->numerator;
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
> +static int unit_converter_read_avail(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     const int **vals, int *type, int *length,
> +				     long mask)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*type = IIO_VAL_INT;
> +		return iio_read_avail_channel_raw(uc->source, vals, length);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info unit_converter_info = {
> +	.read_raw = unit_converter_read_raw,
> +	.read_avail = unit_converter_read_avail,
> +};
> +
> +static ssize_t unit_converter_read_ext_info(struct iio_dev *indio_dev,
> +					    uintptr_t private,
> +					    struct iio_chan_spec const *chan,
> +					    char *buf)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	return iio_read_channel_ext_info(uc->source,
> +					 uc->ext_info[private].name,
> +					 buf);
> +}
> +
> +static ssize_t unit_converter_write_ext_info(struct iio_dev *indio_dev,
> +					     uintptr_t private,
> +					     struct iio_chan_spec const *chan,
> +					     const char *buf, size_t len)
> +{
> +	struct unit_converter *uc = iio_priv(indio_dev);
> +
> +	return iio_write_channel_ext_info(uc->source,
> +					  uc->ext_info[private].name,
> +					  buf, len);
> +}
> +
> +static int unit_converter_configure_channel(struct device *dev,
> +					    struct unit_converter *uc)
> +{
> +	struct iio_chan_spec *chan = &uc->chan;
> +	struct iio_chan_spec const *schan = uc->source->channel;
> +
> +	chan->indexed = 1;
> +	chan->output = schan->output;
> +	chan->ext_info = uc->ext_info;
> +	chan->type = uc->cfg->type;
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
> +static const struct of_device_id unit_converter_match[] = {
> +	{ .compatible = "current-sense-circuit",
> +	  .data = &unit_converter_cfg[CURRENT_SENSE_CIRCUIT], },
> +	{ .compatible = "voltage-divider",
> +	  .data = &unit_converter_cfg[VOLTAGE_DIVIDER], },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, unit_converter_match);
> +
> +static int unit_converter_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct iio_channel *source;
> +	struct unit_converter *uc;
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
> +		sizeof_ext_info *= sizeof(*uc->ext_info);
> +	}
> +
> +	sizeof_priv = sizeof(*uc) + sizeof_ext_info;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof_priv);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	uc = iio_priv(indio_dev);
> +
> +	uc->cfg = of_device_get_match_data(dev);
> +	uc->numerator = 1;
> +	uc->denominator = 1;
> +	device_property_read_u32(dev, "numerator", &uc->numerator);
> +	device_property_read_u32(dev, "denominator", &uc->denominator);
> +	if (!uc->numerator || !uc->denominator) {
> +		dev_err(dev, "invalid scaling factor.\n");
> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	uc->source = source;
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &unit_converter_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &uc->chan;
> +	indio_dev->num_channels = 1;
> +	if (sizeof_ext_info) {
> +		uc->ext_info = devm_kmemdup(dev,
> +					    source->channel->ext_info,
> +					    sizeof_ext_info, GFP_KERNEL);
> +		if (!uc->ext_info)
> +			return -ENOMEM;
> +
> +		for (i = 0; uc->ext_info[i].name; ++i) {
> +			if (source->channel->ext_info[i].read)
> +				uc->ext_info[i].read = unit_converter_read_ext_info;
> +			if (source->channel->ext_info[i].write)
> +				uc->ext_info[i].write = unit_converter_write_ext_info;
> +			uc->ext_info[i].private = i;
> +		}
> +	}
> +
> +	ret = unit_converter_configure_channel(dev, uc);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		dev_err(dev, "failed to register iio device\n");
This made me check if we already report errors if registration fails.
We do in a lot of cases but not quite all.

It might make sense to improve that error reporting in the core and
drop it in any drivers.

I don't care that strongly about it though...

> +
> +	return ret;
> +}
> +
> +static struct platform_driver unit_converter_driver = {
> +	.probe = unit_converter_probe,
> +	.driver = {
> +		.name = "iio-unit-converter",
> +		.of_match_table = unit_converter_match,
> +	},
> +};
> +module_platform_driver(unit_converter_driver);
> +
> +MODULE_DESCRIPTION("IIO unit converter driver");
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_LICENSE("GPL v2");
