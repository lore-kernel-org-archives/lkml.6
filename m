Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/hgg0gbhvYsNFMZgojKbQ0qREVI+maOkCjDVSVO/Pic0Vl6g8Jw4vsX6q8zEzW6p1SmFuN
ARC-Seal: i=1; a=rsa-sha256; t=1523819396; cv=none;
        d=google.com; s=arc-20160816;
        b=p4wJsN/WPnk/Iq2LX2OhavAXCiR60s+i3crly6ud71iAiWjQWRbyPzVFlHsw+OxQ3E
         iVmup0VFkRqKUJXVBWY1Z+CLsR1tGxKxVf76Gus1HW2QQm5k4fRlLYximOctdBaOsE/f
         7fy7o5/HUt1gCqcuRVYku5dkmwVWkHjJwxIRvi6c6muWdNmQcJd+IEomys6rhkoKie/P
         3o5eMobZlrMhcdIM5LNz7hmLhPZTvkR+T2toE8iD5ZmfEjkuqfecGOOCXppNzGe6hSkj
         ROh9FJAdzlkM1v6F6O32f7b9t2Z5PfdFBkkbaMlRbjnmpG9fUmMDQ0eJQkuTzAvcxAjA
         DD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=ij51oM56Sr7HnGPovB8zB84xeG04i2wnW+GQZbfGXj0=;
        b=MZCaRpOnYcZXPN01BssH+PihPCSNEky+UELkrfLzA9anVgMr03ZcI+aUWtl+8rbWj+
         Y0JseumzSdbzif4Fun6WTNbjO0trCU223nlrPh1SbUGEmlbpVZZvygc4C4nSMzFJosv6
         6xxcCEeYonNGtMdEfJcUdXUzyS8Pe6KbbaCxuzscA6udKHuVofmUwF6vK+JcR14hEgmx
         7c/VjwuyvCOyx+PhLNASMZoWVFwunDjmvEHVgoSsohpQxr7cXwY6ptOn9m+IlRMs29p4
         +pCwhKyT66d0PHipszGbaYf+pIsyT9T8eJN8WX+9wIh73RdMqnzYjPeySC2mtSwen+To
         DtMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703702176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 20:09:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
 <pmeerw@pmeerw.net>, <davem@davemloft.net>, <mchehab@kernel.org>,
 <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
 <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
 <Ismail.Kose@maximintegrated.com>, <lukas@wunner.de>,
 <fabrice.gasnier@st.com>, <mike.looijmans@topic.nl>,
 <kstewart@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] iio:dac:ad5686: Add
 AD5671R/75R/94/94R/95R/96/96R support
Message-ID: <20180415200949.3127e5b0@archlinux>
In-Reply-To: <1523447619-13712-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
	<1523447619-13712-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596371266008141789?=
X-GMAIL-MSGID: =?utf-8?q?1597840447588949302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018 14:53:39 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5694/AD5694R/AD5695R/AD5696/AD5696R are a family of 4 channel DACs
> with 12-bit, 14-bit and 16-bit precision respectively. The devices have
> either no built-in reference, or built-in 2.5V reference.
> 
> The AD5671R/AD5675R are similar, except that they have 8 instead of 4
> channels.
> 
> These devices are similar to AD5672R/AD5676/AD5676R and
> AD5684/AD5684R/AD5684/AD5685R/AD5686/AD5686R, except that they use i2c
> instead of spi.
> 
> Datasheets:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5671R_5675R.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5696R_5695R_5694R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
There is one bug inline that stops it building.  I've fixed up and
applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Refactored the patch
> Changes in v3:
> 	- Indented the the help text from the Konfig file with 2
> 	  additional spaces.
> 	- Changed the license description to use an SPDX tag.
> 
>  MAINTAINERS                  |  1 +
>  drivers/iio/dac/Kconfig      | 10 +++++
>  drivers/iio/dac/Makefile     |  1 +
>  drivers/iio/dac/ad5686.c     | 28 +++++++++++++
>  drivers/iio/dac/ad5686.h     |  7 ++++
>  drivers/iio/dac/ad5696-i2c.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 144 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5696-i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 637e62d..002cb01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -797,6 +797,7 @@ L:	linux-pm@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/dac/ad5686*
> +F:	drivers/iio/dac/ad5696*
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 7a81f1e..3ff8a32 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -145,6 +145,16 @@ config AD5686_SPI
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5686.
>  
> +config AD5696_I2C
> +	tristate "Analog Devices AD5696 and similar multi-channel DACs (I2C)"
> +	depends on I2C
> +	select AD5686
> +	help
> +	  Say yes here to build support for Analog Devices AD5671R, AD5675R,
> +	  AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
> +	  Analog Converter.
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad5696.
>  
>  config AD5755
>  	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 07db92e..4397e21 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
>  obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
> +obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
>  obj-$(CONFIG_AD7303) += ad7303.o
>  obj-$(CONFIG_AD8801) += ad8801.o
>  obj-$(CONFIG_CIO_DAC) += cio-dac.o
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 79abff5..89c5f08 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -202,11 +202,21 @@ DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
>  DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
>  
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
> +	[ID_AD5671R] = {
> +		.channels = ad5672_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 8,
> +	},
>  	[ID_AD5672R] = {
>  		.channels = ad5672_channels,
>  		.int_vref_mv = 2500,
>  		.num_channels = 8,
>  	},
> +	[ID_AD5675R] = {
> +		.channels = ad5676_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 8,
> +	},
>  	[ID_AD5676] = {
>  		.channels = ad5676_channels,
>  		.num_channels = 8,
> @@ -239,6 +249,24 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.int_vref_mv = 2500,
>  		.num_channels = 4,
>  	},
> +	[ID_AD5694] = {
> +		.channels = ad5684_channels,
> +		.num_channels = 4,
> +	},
> +	[ID_AD5694R] = {
> +		.channels = ad5684_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 4,
> +	},
> +	[ID_AD5696] = {
> +		.channels = ad5686_channels,
> +		.num_channels = 4,
> +	},
> +	[ID_AD5696R] = {
> +		.channels = ad5686_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 4,
> +	},
>  };
>  
>  int ad5686_probe(struct device *dev,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index c8e1565..05f0ce9 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -39,7 +39,9 @@
>   * ad5686_supported_device_ids:
>   */
>  enum ad5686_supported_device_ids {
> +	ID_AD5671R,
>  	ID_AD5672R,
> +	ID_AD5675R,
>  	ID_AD5676,
>  	ID_AD5676R,
>  	ID_AD5684,
> @@ -47,6 +49,11 @@ enum ad5686_supported_device_ids {
>  	ID_AD5685R,
>  	ID_AD5686,
>  	ID_AD5686R,
> +	ID_AD5694,
> +	ID_AD5694R,
> +	ID_AD5695R,
> +	ID_AD5696,
> +	ID_AD5696R,
>  };
>  
>  struct ad5686_state;
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> new file mode 100644
> index 0000000..088cb36
> --- /dev/null
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
> + * Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include "ad5686.h"
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +
> +static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
> +{
> +	struct i2c_client *i2c = to_i2c_client(st->dev);
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = i2c->addr,
> +			.flags = i2c->flags,
> +			.len = 3,
> +			.buf = &st->data[0].d8[1],
> +		},
> +		{
> +			.addr = i2c->addr,
> +			.flags = i2c->flags | I2C_M_RD,
> +			.len = 2,
> +			.buf = (char *)&st->data[0].d16,
> +		},
> +	};
> +	int ret;
> +
> +	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP) |
> +				      AD5686_ADDR(addr) |
> +				      0x00);
> +
> +	ret = i2c_transfer(i2c->adapter, msg, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(st->data[0].d16);
> +}
> +
> +static int ad5686_i2c_write(struct ad5686_state *st,
> +			    u8 cmd, u8 addr, u16 val)
> +{
> +	struct i2c_client *i2c = to_i2c_client(st->dev);
> +	int ret;
> +
> +	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr)
> +				      | val);
> +
> +	ret = i2c_master_send(i2c, &st->data[0].d8[1], 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (ret != 3) ? -EIO : 0;
> +}
> +
> +static int ad5686_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	return ad5686_probe(&i2c->dev, id->driver_data, id->name,
> +			    ad5686_i2c_write, ad5686_i2c_read);
> +}
> +
> +static int ad5686_i2c_remove(struct i2c_client *i2c)
> +{
> +	return ad5686_remove(&i2c->dev);
> +}
> +
> +static const struct i2c_device_id ad5686_i2c_id[] = {
> +	{"ad5671r", ID_AD5671R},
> +	{"ad5675r", ID_AD5675R},
> +	{"ad5694", ID_AD5694},
> +	{"ad5694r", ID_AD5694R},
> +	{"ad5695r", ID_AD5695R},
> +	{"ad5696", ID_AD5696},
> +	{"ad5696r", ID_AD5696R},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, i2c_device_id);
This worries me a little as it won't build...  You've
specified the type, rather than the instance.

Anyhow, I've fixed that.

Jonathan

> +
> +static struct i2c_driver ad5686_i2c_driver = {
> +	.driver = {
> +		.name = "ad5696",
> +	},
> +	.probe = ad5686_i2c_probe,
> +	.remove = ad5686_i2c_remove,
> +	.id_table = ad5686_i2c_id,
> +};
> +
> +module_i2c_driver(ad5686_i2c_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
> +MODULE_LICENSE("GPL v2");
