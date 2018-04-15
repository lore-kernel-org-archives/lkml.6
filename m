Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx48rJUFFOEThNfTR4ljRXupolXa4qT++7eONMusodwupUu53lNdR9P5NPQtOEcI89GWQw5gD
ARC-Seal: i=1; a=rsa-sha256; t=1523817457; cv=none;
        d=google.com; s=arc-20160816;
        b=jiWSdMurEOqfLXYKPy/8M8EginacgjOuJ6a0O3WSHLWHNqMDxrjWdmwO5UsriJXEz6
         FdUNFXKFB0sJp3z7QTAKtrTQ95ANcJTJYzE8bbcxaMSuT/5sbsD5ActE4PGAbzPM91oZ
         ws7ZeZoZGOh1WGYLXas3FfaWyNgVG3UFLw6cJ2ZCrNbJaEi4gM/d1yHmDj5SIoGfdTzN
         FurTrXq3OwQw1bbIdCHh19wJPkXtHlIHEAdPmvHRWfm6dP16VLa6kJ4YwbTKd6dd4Ngq
         D2TFGNWTWv9TxaRWfgHEVetLTpHZpeKiFfzAlNYyWkMyG4vr4GRYZ1591CAMwwaWN/ai
         E24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=K2nTqnwzNPW6IXTdpDbEG8r81Jw688/q8HHU+BEzXHI=;
        b=fqmnfgFWErxZ4V1/AR/4EkufmY3CJRoS3Ztz4Af0TPnOC0PBqg5BwP0dt0ApfnYDYz
         wPq93nEBUICf/MuKDDczPH81qzEzPf6sAIVGwqzanEtJEFPSSqhozaQjLobRv0J1qmHE
         tLitN9Io8Pmxa/sSs081J2lfqYgdKTgqltY/1CbMTn6ahlbFqbJnko0EANr6nExBzNFO
         Fs57kED9/f02ellpYRMeBP2EJ7VPvkEti1mXKKL9PgLnS83wAgBLo/kC1OD3P5xuOHKB
         10jifNUh645+oS2bZQHp3wDwuKcwoP6Sg0xU/l5/TTYvDPelbObS0rzb3pfqs90mvrDz
         KEEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D818E2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 19:37:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
 <pmeerw@pmeerw.net>, <davem@davemloft.net>, <mchehab@kernel.org>,
 <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
 <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
 <Ismail.Kose@maximintegrated.com>, <lukas@wunner.de>,
 <fabrice.gasnier@st.com>, <mike.looijmans@topic.nl>,
 <pombredanne@nexb.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] iio:dac:ad5686: Refactor the driver
Message-ID: <20180415193729.4952dc59@archlinux>
In-Reply-To: <1523447597-13604-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
	<1523447597-13604-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597450610505827135?=
X-GMAIL-MSGID: =?utf-8?q?1597838414136997105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018 14:53:17 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> In this patch restructures the existing ad5686 driver by adding a module
> for SPI and a header file, while the baseline module deals with the
> chip-logic.
> 
> This is a necessary step, as this driver should support in the future
> similar devices which differ only in the type of interface used (I2C
> instead of SPI).
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git (carrying forward the change
I made earlier).  Again please check I didn't mess it up.

Jonathan

> ---
> Changes in v2:
> 	- Refactored the patch
> 	- Use st->write directly instead of the ad5686_write() wrapper
> 	- Use st->read directly instead of the ad5686_read() wrapper
> Changes in v3:
> 	- Indented the the help text from the Konfig file with 2
> 	  additional spaces.
> 	- Changed the license description to use an SPDX tag.
> 
>  MAINTAINERS                  |   7 ++
>  drivers/iio/dac/Kconfig      |  13 ++-
>  drivers/iio/dac/Makefile     |   1 +
>  drivers/iio/dac/ad5686-spi.c |  92 +++++++++++++++++++++
>  drivers/iio/dac/ad5686.c     | 190 +++++++------------------------------------
>  drivers/iio/dac/ad5686.h     | 114 ++++++++++++++++++++++++++
>  6 files changed, 252 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/iio/dac/ad5686-spi.c
>  create mode 100644 drivers/iio/dac/ad5686.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 473ac00..637e62d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -791,6 +791,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
>  S:	Supported
>  F:	drivers/macintosh/ams/
>  
> +ANALOG DEVICES INC AD5686 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-pm@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/dac/ad5686*
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 965d5c0..7a81f1e 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -131,16 +131,21 @@ config LTC2632
>  	  module will be called ltc2632.
>  
>  config AD5686
> -	tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
> +	tristate
> +
> +config AD5686_SPI
> +	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
>  	depends on SPI
> +	select AD5686
>  	help
> -	  Say yes here to build support for Analog Devices AD5686R, AD5685R,
> -	  AD5684R, AD5791 Voltage Output Digital to
> -	  Analog Converter.
> +	  Say yes here to build support for Analog Devices AD5672R, AD5676,
> +	  AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
> +	  Voltage Output Digital to Analog Converter.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5686.
>  
> +
>  config AD5755
>  	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 81e710e..07db92e 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_AD5761) += ad5761.o
>  obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
> +obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
>  obj-$(CONFIG_AD7303) += ad7303.o
>  obj-$(CONFIG_AD8801) += ad8801.o
>  obj-$(CONFIG_CIO_DAC) += cio-dac.o
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> new file mode 100644
> index 0000000..1cc807b
> --- /dev/null
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
> + * Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include "ad5686.h"
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +static int ad5686_spi_write(struct ad5686_state *st,
> +			    u8 cmd, u8 addr, u16 val)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +
> +	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> +				      AD5686_ADDR(addr) |
> +				      val);
> +
> +	return spi_write(spi, &st->data[0].d8[1], 3);
> +}
> +
> +static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> +{
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->data[0].d8[1],
> +			.len = 3,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = &st->data[1].d8[1],
> +			.rx_buf = &st->data[2].d8[1],
> +			.len = 3,
> +		},
> +	};
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	int ret;
> +
> +	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
> +				      AD5686_ADDR(addr));
> +	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
> +
> +	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return be32_to_cpu(st->data[2].d32);
> +}
> +
> +static int ad5686_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	return ad5686_probe(&spi->dev, id->driver_data, id->name,
> +			    ad5686_spi_write, ad5686_spi_read);
> +}
> +
> +static int ad5686_spi_remove(struct spi_device *spi)
> +{
> +	return ad5686_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id ad5686_spi_id[] = {
> +	{"ad5672r", ID_AD5672R},
> +	{"ad5676", ID_AD5676},
> +	{"ad5676r", ID_AD5676R},
> +	{"ad5684", ID_AD5684},
> +	{"ad5684r", ID_AD5684R},
> +	{"ad5685r", ID_AD5685R},
> +	{"ad5686", ID_AD5686},
> +	{"ad5686r", ID_AD5686R},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
> +
> +static struct spi_driver ad5686_spi_driver = {
> +	.driver = {
> +		.name = "ad5686",
> +	},
> +	.probe = ad5686_spi_probe,
> +	.remove = ad5686_spi_remove,
> +	.id_table = ad5686_spi_id,
> +};
> +
> +module_spi_driver(ad5686_spi_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 54f67d5..79abff5 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -10,7 +10,6 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -#include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
> @@ -18,121 +17,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#define AD5686_ADDR(x)				((x) << 16)
> -#define AD5686_CMD(x)				((x) << 20)
> -
> -#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
> -#define AD5686_ADDR_ALL_DAC			0xF
> -
> -#define AD5686_CMD_NOOP				0x0
> -#define AD5686_CMD_WRITE_INPUT_N		0x1
> -#define AD5686_CMD_UPDATE_DAC_N			0x2
> -#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N	0x3
> -#define AD5686_CMD_POWERDOWN_DAC		0x4
> -#define AD5686_CMD_LDAC_MASK			0x5
> -#define AD5686_CMD_RESET			0x6
> -#define AD5686_CMD_INTERNAL_REFER_SETUP		0x7
> -#define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
> -#define AD5686_CMD_READBACK_ENABLE		0x9
> -
> -#define AD5686_LDAC_PWRDN_NONE			0x0
> -#define AD5686_LDAC_PWRDN_1K			0x1
> -#define AD5686_LDAC_PWRDN_100K			0x2
> -#define AD5686_LDAC_PWRDN_3STATE		0x3
> -
> -/**
> - * struct ad5686_chip_info - chip specific information
> - * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> - * @num_channels:	number of channels
> - * @channel:		channel specification
> -*/
> -
> -struct ad5686_chip_info {
> -	u16				int_vref_mv;
> -	unsigned int			num_channels;
> -	struct iio_chan_spec		*channels;
> -};
> -
> -/**
> - * struct ad5446_state - driver instance specific data
> - * @spi:		spi_device
> - * @chip_info:		chip model specific constants, available modes etc
> - * @reg:		supply regulator
> - * @vref_mv:		actual reference voltage used
> - * @pwr_down_mask:	power down mask
> - * @pwr_down_mode:	current power down mode
> - * @data:		spi transfer buffers
> - */
> -
> -struct ad5686_state {
> -	struct spi_device		*spi;
> -	const struct ad5686_chip_info	*chip_info;
> -	struct regulator		*reg;
> -	unsigned short			vref_mv;
> -	unsigned			pwr_down_mask;
> -	unsigned			pwr_down_mode;
> -	/*
> -	 * DMA (thus cache coherency maintenance) requires the
> -	 * transfer buffers to live in their own cache lines.
> -	 */
> -
> -	union {
> -		__be32 d32;
> -		u8 d8[4];
> -	} data[3] ____cacheline_aligned;
> -};
> -
> -/**
> - * ad5686_supported_device_ids:
> - */
> -
> -enum ad5686_supported_device_ids {
> -	ID_AD5672R,
> -	ID_AD5676,
> -	ID_AD5676R,
> -	ID_AD5684,
> -	ID_AD5684R,
> -	ID_AD5685R,
> -	ID_AD5686,
> -	ID_AD5686R
> -};
> -static int ad5686_spi_write(struct ad5686_state *st,
> -			     u8 cmd, u8 addr, u16 val, u8 shift)
> -{
> -	val <<= shift;
> -
> -	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -			      AD5686_ADDR(addr) |
> -			      val);
> -
> -	return spi_write(st->spi, &st->data[0].d8[1], 3);
> -}
> -
> -static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> -{
> -	struct spi_transfer t[] = {
> -		{
> -			.tx_buf = &st->data[0].d8[1],
> -			.len = 3,
> -			.cs_change = 1,
> -		}, {
> -			.tx_buf = &st->data[1].d8[1],
> -			.rx_buf = &st->data[2].d8[1],
> -			.len = 3,
> -		},
> -	};
> -	int ret;
> -
> -	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
> -			      AD5686_ADDR(addr));
> -	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
> -
> -	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> -	if (ret < 0)
> -		return ret;
> -
> -	return be32_to_cpu(st->data[2].d32);
> -}
> +#include "ad5686.h"
>  
>  static const char * const ad5686_powerdown_modes[] = {
>  	"1kohm_to_gnd",
> @@ -195,8 +80,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	else
>  		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
>  
> -	ret = ad5686_spi_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
> -			       st->pwr_down_mask & st->pwr_down_mode, 0);
> +	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0,
> +			st->pwr_down_mask & st->pwr_down_mode);
> +
>  
>  	return ret ? ret : len;
>  }
> @@ -213,7 +99,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&indio_dev->mlock);
> -		ret = ad5686_spi_read(st, chan->address);
> +		ret = st->read(st, chan->address);
>  		mutex_unlock(&indio_dev->mlock);
>  		if (ret < 0)
>  			return ret;
> @@ -242,11 +128,10 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		mutex_lock(&indio_dev->mlock);
> -		ret = ad5686_spi_write(st,
> -				 AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> -				 chan->address,
> -				 val,
> -				 chan->scan_type.shift);
> +		ret = st->write(st,
> +				AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> +				chan->address,
> +				val << chan->scan_type.shift);
>  		mutex_unlock(&indio_dev->mlock);
>  		break;
>  	default:
> @@ -356,20 +241,27 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  	},
>  };
>  
> -static int ad5686_probe(struct spi_device *spi)
> +int ad5686_probe(struct device *dev,
> +		 enum ad5686_supported_device_ids chip_type,
> +		 const char *name, ad5686_write_func write,
> +		 ad5686_read_func read)
>  {
>  	struct ad5686_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, voltage_uv = 0;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return  -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	st->dev = dev;
> +	st->write = write;
> +	st->read = read;
>  
> -	st->reg = devm_regulator_get_optional(&spi->dev, "vcc");
> +	st->reg = devm_regulator_get_optional(dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> @@ -382,28 +274,25 @@ static int ad5686_probe(struct spi_device *spi)
>  		voltage_uv = ret;
>  	}
>  
> -	st->chip_info =
> -		&ad5686_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> +	st->chip_info = &ad5686_chip_info_tbl[chip_type];
>  
>  	if (voltage_uv)
>  		st->vref_mv = voltage_uv / 1000;
>  	else
>  		st->vref_mv = st->chip_info->int_vref_mv;
>  
> -	st->spi = spi;
> -
>  	/* Set all the power down mode for all channels to 1K pulldown */
>  	st->pwr_down_mode = 0x55;
>  
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = name;
>  	indio_dev->info = &ad5686_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> -	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
> -				!!voltage_uv, 0);
> +	ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
> +			0, !!voltage_uv);
>  	if (ret)
>  		goto error_disable_reg;
>  
> @@ -418,10 +307,11 @@ static int ad5686_probe(struct spi_device *spi)
>  		regulator_disable(st->reg);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ad5686_probe);
>  
> -static int ad5686_remove(struct spi_device *spi)
> +int ad5686_remove(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> @@ -430,29 +320,7 @@ static int ad5686_remove(struct spi_device *spi)
>  
>  	return 0;
>  }
> -
> -static const struct spi_device_id ad5686_id[] = {
> -	{"ad5672r", ID_AD5672R},
> -	{"ad5676", ID_AD5676},
> -	{"ad5676r", ID_AD5676R},
> -	{"ad5684", ID_AD5684},
> -	{"ad5684r", ID_AD5684R},
> -	{"ad5685r", ID_AD5685R},
> -	{"ad5686", ID_AD5686},
> -	{"ad5686r", ID_AD5686R},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(spi, ad5686_id);
> -
> -static struct spi_driver ad5686_driver = {
> -	.driver = {
> -		   .name = "ad5686",
> -		   },
> -	.probe = ad5686_probe,
> -	.remove = ad5686_remove,
> -	.id_table = ad5686_id,
> -};
> -module_spi_driver(ad5686_driver);
> +EXPORT_SYMBOL_GPL(ad5686_remove);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>  MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> new file mode 100644
> index 0000000..c8e1565
> --- /dev/null
> +++ b/drivers/iio/dac/ad5686.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * This file is part of AD5686 DAC driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#ifndef __DRIVERS_IIO_DAC_AD5686_H__
> +#define __DRIVERS_IIO_DAC_AD5686_H__
> +
> +#include <linux/types.h>
> +#include <linux/cache.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +
> +#define AD5686_ADDR(x)				((x) << 16)
> +#define AD5686_CMD(x)				((x) << 20)
> +
> +#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
> +#define AD5686_ADDR_ALL_DAC			0xF
> +
> +#define AD5686_CMD_NOOP				0x0
> +#define AD5686_CMD_WRITE_INPUT_N		0x1
> +#define AD5686_CMD_UPDATE_DAC_N			0x2
> +#define AD5686_CMD_WRITE_INPUT_N_UPDATE_N	0x3
> +#define AD5686_CMD_POWERDOWN_DAC		0x4
> +#define AD5686_CMD_LDAC_MASK			0x5
> +#define AD5686_CMD_RESET			0x6
> +#define AD5686_CMD_INTERNAL_REFER_SETUP		0x7
> +#define AD5686_CMD_DAISY_CHAIN_ENABLE		0x8
> +#define AD5686_CMD_READBACK_ENABLE		0x9
> +
> +#define AD5686_LDAC_PWRDN_NONE			0x0
> +#define AD5686_LDAC_PWRDN_1K			0x1
> +#define AD5686_LDAC_PWRDN_100K			0x2
> +#define AD5686_LDAC_PWRDN_3STATE		0x3
> +
> +/**
> + * ad5686_supported_device_ids:
> + */
> +enum ad5686_supported_device_ids {
> +	ID_AD5672R,
> +	ID_AD5676,
> +	ID_AD5676R,
> +	ID_AD5684,
> +	ID_AD5684R,
> +	ID_AD5685R,
> +	ID_AD5686,
> +	ID_AD5686R,
> +};
> +
> +struct ad5686_state;
> +
> +typedef int (*ad5686_write_func)(struct ad5686_state *st,
> +				 u8 cmd, u8 addr, u16 val);
> +
> +typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
> +
> +/**
> + * struct ad5686_chip_info - chip specific information
> + * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> + * @num_channels:	number of channels
> + * @channel:		channel specification
> + */
> +
> +struct ad5686_chip_info {
> +	u16				int_vref_mv;
> +	unsigned int			num_channels;
> +	struct iio_chan_spec		*channels;
> +};
> +
> +/**
> + * struct ad5446_state - driver instance specific data
> + * @spi:		spi_device
> + * @chip_info:		chip model specific constants, available modes etc
> + * @reg:		supply regulator
> + * @vref_mv:		actual reference voltage used
> + * @pwr_down_mask:	power down mask
> + * @pwr_down_mode:	current power down mode
> + * @data:		spi transfer buffers
> + */
> +
> +struct ad5686_state {
> +	struct device			*dev;
> +	const struct ad5686_chip_info	*chip_info;
> +	struct regulator		*reg;
> +	unsigned short			vref_mv;
> +	unsigned int			pwr_down_mask;
> +	unsigned int			pwr_down_mode;
> +	ad5686_write_func		write;
> +	ad5686_read_func		read;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +
> +	union {
> +		__be32 d32;
> +		__be16 d16;
> +		u8 d8[4];
> +	} data[3] ____cacheline_aligned;
> +};
> +
> +
> +int ad5686_probe(struct device *dev,
> +		 enum ad5686_supported_device_ids chip_type,
> +		 const char *name, ad5686_write_func write,
> +		 ad5686_read_func read);
> +
> +int ad5686_remove(struct device *dev);
> +
> +
> +#endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
