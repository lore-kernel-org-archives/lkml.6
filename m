Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AIpwx48Ub6OycbHPsV3KCsQ3YYmHVqbB9IYMA0RBjVv9I0XIgP90tIhsJwqwJKEpB8+BA2yl0OZb
ARC-Seal: i=1; a=rsa-sha256; t=1523028787; cv=none;
        d=google.com; s=arc-20160816;
        b=LD/8Ci9A6IIZ/X8RBjnM+N1pOUaqYkpxgY+mLeXEl+pNLcGxaGU0C5pHdRGP+WYTUR
         3L+4C6ARWtr2mkGMqF91jt5Av0Gb7C4gW9XRitxhD+655VcoQZruDoXh1jXA17abuyJp
         GEFn/H1Eg3CpSph6SnOmOhCLj8MnzM8XMxD3PZYzvz86baIr4TJLF4L09wLKxD4EtDSF
         gAB0dCpU/z1pwTyGpcLYPeSNMHeAix6Ng0yHeAADVtc30MoTGVit5bXI6cPFwB0lWdqF
         yP8Z90O6Iqg7mWev5B81hQ/hgH/HFkhUgV5wFbnEQJ7If2asnLw85A48ZMKKHTNCm7Yu
         MTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=cL1CCOmejkzuus3RfY+Des8dT2AG07lqkMkKlkwn4o4=;
        b=0D5SRJP4F9dD9bbwCo+Ox3Z0RYq/PNSsias55ObadJNh45gXIyJn+BWjgM+vOGTtjq
         ayy6rXfI43J4SO7dgc/HYEiRBASIie3C1S2tSjX2cyuoDF2FU6yX45JI8YtPo6ZtuA2h
         ZXtXteVPTTpsr/0t1CwKiTwmfUfBpUyHG2c9iVzpjfYu/MUa8YtjjiaGyG42To7q6qBu
         jzbc07POTWruIKsvCg8DjNG4en51OWCJpXEatGmrsGp5jjzUJZVgf7HGTzhhfATBJUyg
         GFIUbgJJ08ky/8//bKcZEcuyghD4aHPfoVa2dxOFtei0ZxUWlQ+x+mrIaHUGKb9s1K5s
         3VWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Fri, 6 Apr 2018 16:32:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Stefan Popa <stefan.popa@analog.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <davem@davemloft.net>,
	<gregkh@linuxfoundation.org>, <mchehab@kernel.org>,
	<linus.walleij@linaro.org>, <rdunlap@infradead.org>,
	<Ismail.Kose@maximintegrated.com>, <lukas@wunner.de>,
	<mike.looijmans@topic.nl>, <fabrice.gasnier@st.com>,
	<linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R
 support
Message-ID: <20180406163238.000014b0@huawei.com>
In-Reply-To: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
References: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596371266008141789?=
X-GMAIL-MSGID: =?utf-8?q?1597011434080148811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 30 Mar 2018 16:56:49 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5694/AD5694R/AD5695R/AD5696/AD5696R are a family of 4 channel DAC
> s with 12-bit, 14-bit and 16-bit precision respectively. The devices have
> either no built-in reference, or built-in 2.5V reference.
> 
> The AD5671R/AD5675R are similar, except that they have 8 instead of 4
> channels.
> 
> These devices are similar to AD5672R/AD5676/AD5676R and
> AD5684/AD5684R/AD5684/AD5685R/AD5686/AD5686R, except that they use i2c
> instead of spi. In order to add support in the previously existing driver,
> three modules were created. One baseline module that has all the
> chip-logic and then one module for SPI and one for I2C.
> 
> Datasheets:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5671R_5675R.pdf
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5696R_5695R_5694R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Should be multiple patches.  First refactor then follow up with the new stuff.

Comments inline.

> ---
>  MAINTAINERS                  |   8 ++
>  drivers/iio/dac/Kconfig      |  27 ++++--
>  drivers/iio/dac/ad5686-spi.c |  93 ++++++++++++++++++
>  drivers/iio/dac/ad5686.c     | 222 +++++++++++++------------------------------
>  drivers/iio/dac/ad5686.h     | 114 ++++++++++++++++++++++
>  drivers/iio/dac/ad5696-i2c.c |  98 +++++++++++++++++++
>  6 files changed, 400 insertions(+), 162 deletions(-)
>  create mode 100644 drivers/iio/dac/ad5686-spi.c
>  create mode 100644 drivers/iio/dac/ad5686.h
>  create mode 100644 drivers/iio/dac/ad5696-i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 473ac00..002cb01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -791,6 +791,14 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
>  S:	Supported
>  F:	drivers/macintosh/ams/
>  
> +ANALOG DEVICES INC AD5686 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-pm@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/dac/ad5686*
> +F:	drivers/iio/dac/ad5696*
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 965d5c0..dab0b8a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -131,15 +131,30 @@ config LTC2632
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
> +	Say yes here to build support for Analog Devices AD5672R, AD5676,
> +	AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
> +	Voltage Output Digital to Analog Converter.
>  
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad5686.
> +	To compile this driver as a module, choose M here: the
> +	module will be called ad5686.
> +
> +config AD5696_I2C
> +	tristate "Analog Devices AD5696 and similar multi-channel DACs (I2C)"
> +	depends on I2C
> +	select AD5686
> +	help
> +	Say yes here to build support for Analog Devices AD5671R, AD5675R,
> +	AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
> +	Analog Converter.
> +	To compile this driver as a module, choose M here: the module will be
> +	called ad5696.
>  
>  config AD5755
>  	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> new file mode 100644
> index 0000000..d68579b
> --- /dev/null
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -0,0 +1,93 @@
> +/*
> + * AD5672R, AD5676, AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R
> + * Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
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
> index 5fb0179..e4ea0dc 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -11,7 +11,6 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -#include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
> @@ -19,128 +18,28 @@
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
> +#include "ad5686.h"
>  
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
> +static const char * const ad5686_powerdown_modes[] = {
> +	"1kohm_to_gnd",
> +	"100kohm_to_gnd",
> +	"three_state"
>  };
>  
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
> +static int ad5686_write(struct ad5686_state *st,
> +			u8 cmd, u8 addr, u16 val, u8 shift)
>  {
>  	val <<= shift;

Given the shift is only applied in one location in the code (and that
one is pretty obvious), I would push the shift inline then
drop the wrapper around st->write in favour of calling
st->write directly.

>  
> -	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -			      AD5686_ADDR(addr) |
> -			      val);
> -
> -	return spi_write(st->spi, &st->data[0].d8[1], 3);
> +	return st->write(st, cmd, addr, val);
>  }
>  
> -static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> +static int ad5686_read(struct ad5686_state *st, u8 addr)
>  {
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
>  
> -	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_READBACK_ENABLE) |
> -			      AD5686_ADDR(addr));
> -	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
> -
> -	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> -	if (ret < 0)
> -		return ret;
> -
> -	return be32_to_cpu(st->data[2].d32);
This wrapper adds very little, just call st->read directly.

> +	return st->read(st, addr);
>  }
>  
> -static const char * const ad5686_powerdown_modes[] = {
> -	"1kohm_to_gnd",
> -	"100kohm_to_gnd",
> -	"three_state"
> -};
> -
>  static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan)
>  {
> @@ -196,8 +95,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	else
>  		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
>  
> -	ret = ad5686_spi_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
> -			       st->pwr_down_mask & st->pwr_down_mode, 0);
> +	ret = ad5686_write(st, AD5686_CMD_POWERDOWN_DAC, 0,
> +			   st->pwr_down_mask & st->pwr_down_mode, 0);
>  
>  	return ret ? ret : len;
>  }
> @@ -214,7 +113,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&indio_dev->mlock);
> -		ret = ad5686_spi_read(st, chan->address);
> +		ret = ad5686_read(st, chan->address);
>  		mutex_unlock(&indio_dev->mlock);
>  		if (ret < 0)
>  			return ret;
> @@ -243,11 +142,11 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		mutex_lock(&indio_dev->mlock);
> -		ret = ad5686_spi_write(st,
> -				 AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> -				 chan->address,
> -				 val,
> -				 chan->scan_type.shift);
> +		ret = ad5686_write(st,
> +				   AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> +				   chan->address,
> +				   val,
> +				   chan->scan_type.shift);
>  		mutex_unlock(&indio_dev->mlock);
>  		break;
>  	default:
> @@ -318,11 +217,21 @@ DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
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
> @@ -355,22 +264,47 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
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
> @@ -383,28 +317,25 @@ static int ad5686_probe(struct spi_device *spi)
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
> +	ret = ad5686_write(st, AD5686_CMD_INTERNAL_REFER_SETUP,
> +			   0, !!voltage_uv, 0);
>  	if (ret)
>  		goto error_disable_reg;
>  
> @@ -419,10 +350,11 @@ static int ad5686_probe(struct spi_device *spi)
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
> @@ -431,29 +363,7 @@ static int ad5686_remove(struct spi_device *spi)
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
> index 0000000..b2b0110
> --- /dev/null
> +++ b/drivers/iio/dac/ad5686.h
> @@ -0,0 +1,114 @@
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
> +	ID_AD5671R,
> +	ID_AD5672R,
> +	ID_AD5675R,
> +	ID_AD5676,
> +	ID_AD5676R,
> +	ID_AD5684,
> +	ID_AD5684R,
> +	ID_AD5685R,
> +	ID_AD5686,
> +	ID_AD5686R,
> +	ID_AD5694,
> +	ID_AD5694R,
> +	ID_AD5695R,
> +	ID_AD5696,
> +	ID_AD5696R,
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
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> new file mode 100644
> index 0000000..c9187de
> --- /dev/null
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -0,0 +1,98 @@
> +/*
> + * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
> + * Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
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
