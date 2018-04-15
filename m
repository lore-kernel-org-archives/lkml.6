Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/65a3ipT4TI6sNIbHE7/LSWmZM8MV8qty8a4oA4tDlOAYOZa2ZHEvlF69gBjdZKBkn0j2L
ARC-Seal: i=1; a=rsa-sha256; t=1523807037; cv=none;
        d=google.com; s=arc-20160816;
        b=BMPNjk3NAxL/djfYaGNdcB+U9ZZ22ayZWnlfbqytdKSF4wFMswA4685ykXOSGQOiUU
         xOvBXHO4uvrdgb42QWd1pWuOoFW0I2xqvFFfPvKI2FR0zbhGUZYg1dfqev24A5Vqd2Gl
         nJmTB7Gq0GCdZr/CVQK6jKrVb7RIXUujQfGyBOY4/DUgGdfcnzlXVUWUbfHf+ewDZBZl
         BGCJBSE7oD42oumuGn4H9MyHgLBq+YqVyB2m2e4MQhBWwM3z+tYJFYDsgOMusxBJU+7r
         MaudGsJpiwe5mki4CNKDqtVI2UbJSodZn6+4G0nWGKDmm3ASbLiVXBEDQnYKSV58WLfb
         l2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=o+dRYApeaLXhT+5gDyGdCdT49Tf38pNwVkmJ/JG9d6w=;
        b=tuX7PsTh9FUGS/bPlaTaeQAF5Nk3tmK/idfaerzaXNjzTFCKvgMd6rjgQS3HAv8Ggg
         Xuu4448iqsCFr4vAhI/v1P/fdF8TA3jmgZ4fN52hM+IBto0IBbL/R67yeg9A1pns+c6t
         QMhaCBV5Xn22OT85c+FwKudqsd5Ux0AUeXzDyYeWkXULbDtvZV3Dhp/B1QAmMeadkB99
         jB7uOB0pc/MsInQl4+B7Bho+HZDOrtWHmM6yW/c6+ozH20IMkDDtM6eZ+OZehZqg3lIN
         PMfC29PQo9YfKDyFsXjil5+1v2WCvVzRK8y9EiQKEMirzYKeuZzwznyHF/r2JNPaFUif
         XPxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6C32077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:43:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] staging: iio: Remove ad7746 from staging
Message-ID: <20180415164351.2666a114@archlinux>
In-Reply-To: <1523637411-8531-15-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-15-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649768754128760?=
X-GMAIL-MSGID: =?utf-8?q?1597827487867229242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:51 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
Please have a single patch (with move detection turned off) for this and the
previous.

Allows easy review by showing us the code but doesn't lead to a stage in wh=
ich
two different versions will build and hence probably break bisectiblity.

Jonathan

> ---
>  .../devicetree/bindings/staging/iio/cdc/ad7746.txt |  34 -
>  drivers/staging/iio/cdc/Kconfig                    |  10 -
>  drivers/staging/iio/cdc/Makefile                   |   1 -
>  drivers/staging/iio/cdc/ad7746.c                   | 856 ---------------=
------
>  drivers/staging/iio/cdc/ad7746.h                   |  24 -
>  5 files changed, 925 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7=
746.txt
>  delete mode 100644 drivers/staging/iio/cdc/ad7746.c
>  delete mode 100644 drivers/staging/iio/cdc/ad7746.h
>=20
> diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt=
 b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> deleted file mode 100644
> index 7740f05..0000000
> --- a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Analog Devices AD7746/5/7 capacitive sensor driver
> -
> -Required properties:
> -	- compatible: Should be one of
> -		* "adi,ad7745"
> -		* "adi,ad7746"
> -	  * "adi,ad7747"
> -	- reg: The 7-bits long I2c address of the device
> -
> -Optional properties:
> -	- adi,exclvl: This property defines the excitation voltage level for the
> -    capacitance to be measured. Possible values are:
> -      * 0 =3D +-VDD/8
> -      * 1 =3D +-VDD/4
> -      * 2 =3D +-VDD * 3/8
> -      * 3 =3D +-VDD/2 (Default)
> -	- adi,nexca_en: Invert excitation output A.
> -	- adi,nexcb_en:	Invert excitation output B.
> -
> -Example:
> -Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
> -Excitation pin B would NOT be inverted.
> -
> -i2c2 {
> -
> -      < . . . >
> -
> -      ad7746: ad7746@60 {
> -              compatible =3D "ad7746";
> -              reg =3D <0x60>;
> -              adi,exclvl =3D <1>;
> -              adi,nexca_en;
> -      };
> -};
> diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kc=
onfig
> index 80211df..a170ab3 100644
> --- a/drivers/staging/iio/cdc/Kconfig
> +++ b/drivers/staging/iio/cdc/Kconfig
> @@ -23,14 +23,4 @@ config AD7152
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7152.
> =20
> -config AD7746
> -	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
> -	depends on I2C
> -	help
> -	  Say yes here to build support for Analog Devices capacitive sensors.
> -	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7746.
> -
>  endmenu
> diff --git a/drivers/staging/iio/cdc/Makefile b/drivers/staging/iio/cdc/M=
akefile
> index a5fbabf..5db1acd 100644
> --- a/drivers/staging/iio/cdc/Makefile
> +++ b/drivers/staging/iio/cdc/Makefile
> @@ -4,4 +4,3 @@
> =20
>  obj-$(CONFIG_AD7150) +=3D ad7150.o
>  obj-$(CONFIG_AD7152) +=3D ad7152.o
> -obj-$(CONFIG_AD7746) +=3D ad7746.o
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> deleted file mode 100644
> index ef0ebb5..0000000
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ /dev/null
> @@ -1,856 +0,0 @@
> -/*
> - * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> - *
> - * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/i2c.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/slab.h>
> -#include <linux/stat.h>
> -#include <linux/sysfs.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -
> -#include "ad7746.h"
> -
> -/*
> - * AD7746 Register Definition
> - */
> -
> -#define AD7746_REG_CAP_DATA_HIGH	1
> -#define AD7746_REG_VT_DATA_HIGH		4
> -#define AD7746_REG_CAP_SETUP		7
> -#define AD7746_REG_VT_SETUP		8
> -#define AD7746_REG_EXC_SETUP		9
> -#define AD7746_REG_CFG			10
> -#define AD7746_REG_CAPDACA		11
> -#define AD7746_REG_CAPDACB		12
> -#define AD7746_REG_CAP_OFFH		13
> -#define AD7746_REG_CAP_GAINH		15
> -#define AD7746_REG_VOLT_GAINH		17
> -
> -/* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SE=
TUP) */
> -#define AD7746_CAPSETUP_CAPEN		BIT(7)
> -#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
> -#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
> -#define AD7746_CAPSETUP_CACHOP		BIT(0)
> -
> -/* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SE=
TUP) */
> -#define AD7746_VTSETUP_VTEN		(1 << 7)
> -#define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
> -#define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
> -#define AD7746_VTSETUP_EXTREF		BIT(4)
> -#define AD7746_VTSETUP_VTSHORT		BIT(1)
> -#define AD7746_VTSETUP_VTCHOP		BIT(0)
> -
> -/* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
> -#define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> -#define AD7746_EXCSETUP_EXCON		BIT(6)
> -#define AD7746_EXCSETUP_EXCB		BIT(5)
> -#define AD7746_EXCSETUP_NEXCB		BIT(4)
> -#define AD7746_EXCSETUP_EXCA		BIT(3)
> -#define AD7746_EXCSETUP_NEXCA		BIT(2)
> -#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
> -
> -/* Config Register Bit Designations (AD7746_REG_CFG) */
> -#define AD7746_CONF_VTFS_SHIFT		6
> -#define AD7746_CONF_CAPFS_SHIFT		3
> -#define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
> -#define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
> -#define AD7746_CONF_MODE_IDLE		(0 << 0)
> -#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
> -#define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
> -#define AD7746_CONF_MODE_PWRDN		(3 << 0)
> -#define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
> -#define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
> -
> -/* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> -#define AD7746_CAPDAC_DACEN		BIT(7)
> -#define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
> -
> -/*
> - * struct ad7746_chip_info - chip specific information
> - */
> -
> -struct ad7746_chip_info {
> -	struct i2c_client *client;
> -	struct mutex lock; /* protect sensor state */
> -	/*
> -	 * Capacitive channel digital filter setup;
> -	 * conversion time/update rate setup per channel
> -	 */
> -	u8	config;
> -	u8	cap_setup;
> -	u8	vt_setup;
> -	u8	capdac[2][2];
> -	s8	capdac_set;
> -
> -	union {
> -		__be32 d32;
> -		u8 d8[4];
> -	} data ____cacheline_aligned;
> -};
> -
> -enum ad7746_chan {
> -	VIN,
> -	VIN_VDD,
> -	TEMP_INT,
> -	TEMP_EXT,
> -	CIN1,
> -	CIN1_DIFF,
> -	CIN2,
> -	CIN2_DIFF,
> -};
> -
> -static const struct iio_chan_spec ad7746_channels[] =3D {
> -	[VIN] =3D {
> -		.type =3D IIO_VOLTAGE,
> -		.indexed =3D 1,
> -		.channel =3D 0,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> -			AD7746_VTSETUP_VTMD_EXT_VIN,
> -	},
> -	[VIN_VDD] =3D {
> -		.type =3D IIO_VOLTAGE,
> -		.indexed =3D 1,
> -		.channel =3D 1,
> -		.extend_name =3D "supply",
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> -			AD7746_VTSETUP_VTMD_VDD_MON,
> -	},
> -	[TEMP_INT] =3D {
> -		.type =3D IIO_TEMP,
> -		.indexed =3D 1,
> -		.channel =3D 0,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> -		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> -			AD7746_VTSETUP_VTMD_INT_TEMP,
> -	},
> -	[TEMP_EXT] =3D {
> -		.type =3D IIO_TEMP,
> -		.indexed =3D 1,
> -		.channel =3D 1,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> -		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> -			AD7746_VTSETUP_VTMD_EXT_TEMP,
> -	},
> -	[CIN1] =3D {
> -		.type =3D IIO_CAPACITANCE,
> -		.indexed =3D 1,
> -		.channel =3D 0,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> -		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address =3D AD7746_REG_CAP_DATA_HIGH << 8,
> -	},
> -	[CIN1_DIFF] =3D {
> -		.type =3D IIO_CAPACITANCE,
> -		.differential =3D 1,
> -		.indexed =3D 1,
> -		.channel =3D 0,
> -		.channel2 =3D 2,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> -		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
> -			AD7746_CAPSETUP_CAPDIFF
> -	},
> -	[CIN2] =3D {
> -		.type =3D IIO_CAPACITANCE,
> -		.indexed =3D 1,
> -		.channel =3D 1,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> -		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
> -			AD7746_CAPSETUP_CIN2,
> -	},
> -	[CIN2_DIFF] =3D {
> -		.type =3D IIO_CAPACITANCE,
> -		.differential =3D 1,
> -		.indexed =3D 1,
> -		.channel =3D 1,
> -		.channel2 =3D 3,
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> -		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
> -			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
> -	}
> -};
> -
> -/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
> -static const unsigned char ad7746_vt_filter_rate_table[][2] =3D {
> -	{50, 20 + 1}, {31, 32 + 1}, {16, 62 + 1}, {8, 122 + 1},
> -};
> -
> -static const unsigned char ad7746_cap_filter_rate_table[][2] =3D {
> -	{91, 11 + 1}, {84, 12 + 1}, {50, 20 + 1}, {26, 38 + 1},
> -	{16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
> -};
> -
> -static int ad7746_select_channel(struct iio_dev *indio_dev,
> -				 struct iio_chan_spec const *chan)
> -{
> -	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	u8 vt_setup, cap_setup;
> -	int ret, delay, idx;
> -
> -	switch (chan->type) {
> -	case IIO_CAPACITANCE:
> -		cap_setup =3D (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
> -		vt_setup =3D chip->vt_setup & ~AD7746_VTSETUP_VTEN;
> -		idx =3D (chip->config & AD7746_CONF_CAPFS_MASK) >>
> -			AD7746_CONF_CAPFS_SHIFT;
> -		delay =3D ad7746_cap_filter_rate_table[idx][1];
> -
> -		if (chip->capdac_set !=3D chan->channel) {
> -			ret =3D i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACA,
> -				chip->capdac[chan->channel][0]);
> -			if (ret < 0)
> -				return ret;
> -			ret =3D i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACB,
> -				chip->capdac[chan->channel][1]);
> -			if (ret < 0)
> -				return ret;
> -
> -			chip->capdac_set =3D chan->channel;
> -		}
> -		break;
> -	case IIO_VOLTAGE:
> -	case IIO_TEMP:
> -		vt_setup =3D (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
> -		cap_setup =3D chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
> -		idx =3D (chip->config & AD7746_CONF_VTFS_MASK) >>
> -			AD7746_CONF_VTFS_SHIFT;
> -		delay =3D ad7746_cap_filter_rate_table[idx][1];
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	if (chip->cap_setup !=3D cap_setup) {
> -		ret =3D i2c_smbus_write_byte_data(chip->client,
> -						AD7746_REG_CAP_SETUP,
> -						cap_setup);
> -		if (ret < 0)
> -			return ret;
> -
> -		chip->cap_setup =3D cap_setup;
> -	}
> -
> -	if (chip->vt_setup !=3D vt_setup) {
> -		ret =3D i2c_smbus_write_byte_data(chip->client,
> -						AD7746_REG_VT_SETUP,
> -						vt_setup);
> -		if (ret < 0)
> -			return ret;
> -
> -		chip->vt_setup =3D vt_setup;
> -	}
> -
> -	return delay;
> -}
> -
> -static inline ssize_t ad7746_start_calib(struct device *dev,
> -					 struct device_attribute *attr,
> -					 const char *buf,
> -					 size_t len,
> -					 u8 regval)
> -{
> -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	int ret, timeout =3D 10;
> -	bool doit;
> -
> -	ret =3D strtobool(buf, &doit);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (!doit)
> -		return 0;
> -
> -	mutex_lock(&chip->lock);
> -	regval |=3D chip->config;
> -	ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
> -	if (ret < 0)
> -		goto unlock;
> -
> -	do {
> -		msleep(20);
> -		ret =3D i2c_smbus_read_byte_data(chip->client, AD7746_REG_CFG);
> -		if (ret < 0)
> -			goto unlock;
> -
> -	} while ((ret =3D=3D regval) && timeout--);
> -
> -	mutex_unlock(&chip->lock);
> -
> -	return len;
> -
> -unlock:
> -	mutex_unlock(&chip->lock);
> -	return ret;
> -}
> -
> -static ssize_t ad7746_start_offset_calib(struct device *dev,
> -					 struct device_attribute *attr,
> -					 const char *buf,
> -					 size_t len)
> -{
> -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -	int ret =3D ad7746_select_channel(indio_dev,
> -			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ad7746_start_calib(dev, attr, buf, len,
> -				  AD7746_CONF_MODE_OFFS_CAL);
> -}
> -
> -static ssize_t ad7746_start_gain_calib(struct device *dev,
> -				       struct device_attribute *attr,
> -				       const char *buf,
> -				       size_t len)
> -{
> -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> -	int ret =3D ad7746_select_channel(indio_dev,
> -			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
> -	if (ret < 0)
> -		return ret;
> -
> -	return ad7746_start_calib(dev, attr, buf, len,
> -				  AD7746_CONF_MODE_GAIN_CAL);
> -}
> -
> -static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
> -		       0200, NULL, ad7746_start_offset_calib, CIN1);
> -static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
> -		       0200, NULL, ad7746_start_offset_calib, CIN2);
> -static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
> -		       0200, NULL, ad7746_start_gain_calib, CIN1);
> -static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
> -		       0200, NULL, ad7746_start_gain_calib, CIN2);
> -static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
> -		       0200, NULL, ad7746_start_gain_calib, VIN);
> -
> -static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *c=
hip,
> -					      int val)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
> -		if (val >=3D ad7746_cap_filter_rate_table[i][0])
> -			break;
> -
> -	if (i >=3D ARRAY_SIZE(ad7746_cap_filter_rate_table))
> -		i =3D ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
> -
> -	chip->config &=3D ~AD7746_CONF_CAPFS_MASK;
> -	chip->config |=3D i << AD7746_CONF_CAPFS_SHIFT;
> -
> -	return 0;
> -}
> -
> -static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *ch=
ip,
> -					     int val)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
> -		if (val >=3D ad7746_vt_filter_rate_table[i][0])
> -			break;
> -
> -	if (i >=3D ARRAY_SIZE(ad7746_vt_filter_rate_table))
> -		i =3D ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
> -
> -	chip->config &=3D ~AD7746_CONF_VTFS_MASK;
> -	chip->config |=3D i << AD7746_CONF_VTFS_SHIFT;
> -
> -	return 0;
> -}
> -
> -static IIO_CONST_ATTR(in_voltage_sampling_frequency_available, "50 31 16=
 8");
> -static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
> -		       "91 84 50 26 16 13 11 9");
> -
> -static struct attribute *ad7746_attributes[] =3D {
> -	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
> -	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
> -	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
> -	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.at=
tr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ad7746_attribute_group =3D {
> -	.attrs =3D ad7746_attributes,
> -};
> -
> -static int ad7746_write_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val,
> -			    int val2,
> -			    long mask)
> -{
> -	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	int ret, reg;
> -
> -	mutex_lock(&chip->lock);
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBSCALE:
> -		if (val !=3D 1) {
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
> -		/* 2^16 in micro */
> -		val =3D (val2 * 1024) / 15625;
> -
> -		switch (chan->type) {
> -		case IIO_CAPACITANCE:
> -			reg =3D AD7746_REG_CAP_GAINH;
> -			break;
> -		case IIO_VOLTAGE:
> -			reg =3D AD7746_REG_VOLT_GAINH;
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
> -		ret =3D i2c_smbus_write_word_swapped(chip->client, reg, val);
> -		if (ret < 0)
> -			goto out;
> -
> -		ret =3D 0;
> -		break;
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		if (val < 0 || val > 0xFFFF) {
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -		ret =3D i2c_smbus_write_word_swapped(chip->client,
> -						   AD7746_REG_CAP_OFFH, val);
> -		if (ret < 0)
> -			goto out;
> -
> -		ret =3D 0;
> -		break;
> -	case IIO_CHAN_INFO_OFFSET:
> -		if (val < 0 || val > 43008000) { /* 21pF */
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
> -		/*
> -		 * CAPDAC Scale =3D 21pF_typ / 127
> -		 * CIN Scale =3D 8.192pF / 2^24
> -		 * Offset Scale =3D CAPDAC Scale / CIN Scale =3D 338646
> -		 */
> -
> -		val /=3D 338646;
> -
> -		chip->capdac[chan->channel][chan->differential] =3D val > 0 ?
> -			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
> -
> -		ret =3D i2c_smbus_write_byte_data(chip->client,
> -						AD7746_REG_CAPDACA,
> -						chip->capdac[chan->channel][0]);
> -		if (ret < 0)
> -			goto out;
> -		ret =3D i2c_smbus_write_byte_data(chip->client,
> -						AD7746_REG_CAPDACB,
> -						chip->capdac[chan->channel][1]);
> -		if (ret < 0)
> -			goto out;
> -
> -		chip->capdac_set =3D chan->channel;
> -
> -		ret =3D 0;
> -		break;
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val2) {
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
> -		switch (chan->type) {
> -		case IIO_CAPACITANCE:
> -			ret =3D ad7746_store_cap_filter_rate_setup(chip, val);
> -			break;
> -		case IIO_VOLTAGE:
> -			ret =3D ad7746_store_vt_filter_rate_setup(chip, val);
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -		}
> -		break;
> -	default:
> -		ret =3D -EINVAL;
> -	}
> -
> -out:
> -	mutex_unlock(&chip->lock);
> -	return ret;
> -}
> -
> -static int ad7746_read_raw(struct iio_dev *indio_dev,
> -			   struct iio_chan_spec const *chan,
> -			   int *val, int *val2,
> -			   long mask)
> -{
> -	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	int ret, delay, idx;
> -	u8 regval, reg;
> -
> -	mutex_lock(&chip->lock);
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -	case IIO_CHAN_INFO_PROCESSED:
> -		ret =3D ad7746_select_channel(indio_dev, chan);
> -		if (ret < 0)
> -			goto out;
> -		delay =3D ret;
> -
> -		regval =3D chip->config | AD7746_CONF_MODE_SINGLE_CONV;
> -		ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG,
> -						regval);
> -		if (ret < 0)
> -			goto out;
> -
> -		msleep(delay);
> -		/* Now read the actual register */
> -
> -		ret =3D i2c_smbus_read_i2c_block_data(chip->client,
> -						    chan->address >> 8, 3,
> -						    &chip->data.d8[1]);
> -
> -		if (ret < 0)
> -			goto out;
> -
> -		/*
> -		 * Either for Capacitance, Voltage or Temperature,
> -		 * the 0x000000 code represents negative full scale,
> -		 * the 0x800000 code represents zero scale, and
> -		 * the 0xFFFFFF code represents positive full scale.
> -		 */
> -
> -		*val =3D (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
> -
> -		switch (chan->type) {
> -		case IIO_TEMP:
> -		/*
> -		 * temperature in milli degrees Celsius
> -		 * T =3D ((*val / 2048) - 4096) * 1000
> -		 */
> -			*val =3D (*val * 125) / 256;
> -			break;
> -		case IIO_VOLTAGE:
> -
> -			/*
> -			 * The voltage from the VDD pin is internally
> -			 * attenuated by 6.
> -			 */
> -
> -			if (chan->channel =3D=3D 1) /* supply_raw */
> -				*val =3D *val * 6;
> -			break;
> -		default:
> -			break;
> -		}
> -
> -		ret =3D IIO_VAL_INT;
> -		break;
> -	case IIO_CHAN_INFO_CALIBSCALE:
> -		switch (chan->type) {
> -		case IIO_CAPACITANCE:
> -			reg =3D AD7746_REG_CAP_GAINH;
> -			break;
> -		case IIO_VOLTAGE:
> -			reg =3D AD7746_REG_VOLT_GAINH;
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
> -		ret =3D i2c_smbus_read_word_swapped(chip->client, reg);
> -		if (ret < 0)
> -			goto out;
> -		/* 1 + gain_val / 2^16 */
> -		*val =3D 1;
> -		*val2 =3D (15625 * ret) / 1024;
> -
> -		ret =3D IIO_VAL_INT_PLUS_MICRO;
> -		break;
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		ret =3D i2c_smbus_read_word_swapped(chip->client,
> -						  AD7746_REG_CAP_OFFH);
> -		if (ret < 0)
> -			goto out;
> -		*val =3D ret;
> -
> -		ret =3D IIO_VAL_INT;
> -		break;
> -	case IIO_CHAN_INFO_OFFSET:
> -
> -		/*
> -		 * CAPDAC Scale =3D 21pF_typ / 127
> -		 * CIN Scale =3D 8.192pF / 2^24
> -		 * Offset Scale =3D CAPDAC Scale / CIN Scale =3D 338646
> -		 */
> -
> -		*val =3D AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
> -					  [chan->differential]) * 338646;
> -
> -		ret =3D IIO_VAL_INT;
> -		break;
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_CAPACITANCE:
> -			/* CIN Scale: 8.192pf / 2^24 */
> -			*val =3D  0;
> -			*val2 =3D 488;
> -			ret =3D IIO_VAL_INT_PLUS_NANO;
> -			break;
> -		case IIO_VOLTAGE:
> -			/* VIN Scale: 1170mV / 2^23 */
> -			*val =3D 1170;
> -			*val2 =3D 23;
> -			ret =3D IIO_VAL_FRACTIONAL_LOG2;
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -			break;
> -		}
> -
> -		break;
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		switch (chan->type) {
> -		case IIO_CAPACITANCE:
> -			idx =3D (chip->config & AD7746_CONF_CAPFS_MASK) >>
> -				AD7746_CONF_CAPFS_SHIFT;
> -			*val =3D ad7746_cap_filter_rate_table[idx][0];
> -			ret =3D IIO_VAL_INT;
> -			break;
> -		case IIO_VOLTAGE:
> -			idx =3D (chip->config & AD7746_CONF_VTFS_MASK) >>
> -				AD7746_CONF_VTFS_SHIFT;
> -			*val =3D ad7746_vt_filter_rate_table[idx][0];
> -			ret =3D IIO_VAL_INT;
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -		}
> -		break;
> -	default:
> -		ret =3D -EINVAL;
> -	}
> -out:
> -	mutex_unlock(&chip->lock);
> -	return ret;
> -}
> -
> -static const struct iio_info ad7746_info =3D {
> -	.attrs =3D &ad7746_attribute_group,
> -	.read_raw =3D ad7746_read_raw,
> -	.write_raw =3D ad7746_write_raw,
> -};
> -
> -/*
> - * device probe and remove
> - */
> -#ifdef CONFIG_OF
> -static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> -{
> -	struct device_node *np =3D dev->of_node;
> -	struct ad7746_platform_data *pdata;
> -	unsigned int tmp;
> -	int ret;
> -
> -	/*
> -	 * The default excitation outputs are not inverted, it should be stated
> -	 * in the dt if needed.
> -	 */
> -
> -	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return NULL;
> -
> -	ret =3D of_property_read_u32(np, "adi,exclvl", &tmp);
> -	if (ret || tmp > 3) {
> -		dev_warn(dev, "Wrong exclvl value, using default\n");
> -		pdata->exclvl =3D 3;
> -	} else {
> -		pdata->exclvl =3D tmp;
> -	}
> -
> -	pdata->exca_en =3D true;
> -	pdata->excb_en =3D true;
> -	pdata->exca_inv_en =3D of_property_read_bool(np, "adi,nexca_en");
> -	pdata->excb_inv_en =3D of_property_read_bool(np, "adi,nexcb_en");
> -
> -	return pdata;
> -}
> -#else
> -static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> -{
> -	return NULL;
> -}
> -#endif
> -
> -static int ad7746_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> -{
> -	struct ad7746_platform_data *pdata =3D client->dev.platform_data;
> -	struct ad7746_chip_info *chip;
> -	struct iio_dev *indio_dev;
> -	unsigned char regval =3D 0;
> -	int ret =3D 0;
> -
> -	if (client->dev.of_node)
> -		pdata =3D ad7746_parse_dt(&client->dev);
> -	else
> -		pdata =3D client->dev.platform_data;
> -
> -	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	chip =3D iio_priv(indio_dev);
> -	mutex_init(&chip->lock);
> -	/* this is only used for device removal purposes */
> -	i2c_set_clientdata(client, indio_dev);
> -
> -	chip->client =3D client;
> -	chip->capdac_set =3D -1;
> -
> -	/* Establish that the iio_dev is a child of the i2c device */
> -	indio_dev->name =3D id->name;
> -	indio_dev->dev.parent =3D &client->dev;
> -	indio_dev->info =3D &ad7746_info;
> -	indio_dev->channels =3D ad7746_channels;
> -	if (id->driver_data =3D=3D 7746)
> -		indio_dev->num_channels =3D ARRAY_SIZE(ad7746_channels);
> -	else
> -		indio_dev->num_channels =3D  ARRAY_SIZE(ad7746_channels) - 2;
> -	indio_dev->num_channels =3D ARRAY_SIZE(ad7746_channels);
> -	indio_dev->modes =3D INDIO_DIRECT_MODE;
> -
> -	if (pdata) {
> -		if (pdata->exca_en) {
> -			if (pdata->exca_inv_en)
> -				regval |=3D AD7746_EXCSETUP_NEXCA;
> -			else
> -				regval |=3D AD7746_EXCSETUP_EXCA;
> -		}
> -
> -		if (pdata->excb_en) {
> -			if (pdata->excb_inv_en)
> -				regval |=3D AD7746_EXCSETUP_NEXCB;
> -			else
> -				regval |=3D AD7746_EXCSETUP_EXCB;
> -		}
> -
> -		regval |=3D AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> -	} else {
> -		dev_warn(&client->dev, "No platform data? using default\n");
> -		regval =3D AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> -			AD7746_EXCSETUP_EXCLVL(3);
> -	}
> -
> -	ret =3D i2c_smbus_write_byte_data(chip->client,
> -					AD7746_REG_EXC_SETUP, regval);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int ad7746_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> -	unsigned char regval;
> -	int ret;
> -
> -	mutex_lock(&chip->lock);
> -
> -	regval =3D chip->config | AD7746_CONF_MODE_PWRDN;
> -	ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
> -
> -	mutex_unlock(&chip->lock);
> -
> -	if (ret < 0) {
> -		dev_warn(&client->dev, "Could NOT Power Down!\n");
> -		goto out;
> -	}
> -
> -	iio_device_unregister(indio_dev);
> -
> -out:
> -	return ret;
> -}
> -
> -static const struct i2c_device_id ad7746_id[] =3D {
> -	{ "ad7745", 7745 },
> -	{ "ad7746", 7746 },
> -	{ "ad7747", 7747 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(i2c, ad7746_id);
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id ad7746_of_match[] =3D {
> -	{ .compatible =3D "adi,ad7745" },
> -	{ .compatible =3D "adi,ad7746" },
> -	{ .compatible =3D "adi,ad7747" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, ad7746_of_match);
> -#endif
> -
> -static struct i2c_driver ad7746_driver =3D {
> -	.driver =3D {
> -		.name =3D KBUILD_MODNAME,
> -		.of_match_table =3D of_match_ptr(ad7746_of_match),
> -	},
> -	.probe =3D ad7746_probe,
> -	.remove =3D ad7746_remove,
> -	.id_table =3D ad7746_id,
> -};
> -module_i2c_driver(ad7746_driver);
> -
> -MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> -MODULE_DESCRIPTION("Analog Devices AD7746/5/7 capacitive sensor driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/a=
d7746.h
> deleted file mode 100644
> index 2fbcee8..0000000
> --- a/drivers/staging/iio/cdc/ad7746.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> - *
> - * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
> - */
> -
> -#ifndef IIO_CDC_AD7746_H_
> -#define IIO_CDC_AD7746_H_
> -
> -/*
> - * TODO: struct ad7746_platform_data needs to go into include/linux/iio
> - */
> -
> -struct ad7746_platform_data {
> -	unsigned char exclvl;	/*Excitation Voltage Level */
> -	bool exca_en;		/* enables EXCA pin as the excitation output */
> -	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
> -	bool excb_en;		/* enables EXCB pin as the excitation output */
> -	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
> -};
> -
> -#endif /* IIO_CDC_AD7746_H_ */
