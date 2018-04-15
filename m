Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+xkKcGiRPvi19pfscpjmijHRZ8imVrWqwiMx9gLD7/9x8PYbiITgSNPLdyAFGDWF/eYESN
ARC-Seal: i=1; a=rsa-sha256; t=1523811896; cv=none;
        d=google.com; s=arc-20160816;
        b=OSKB+D0Io4DMRv2hSnSBGfJZnwXUr6KqLM5nkjTMPq3HIHDoZmYfXRGierknDU0bKP
         Xz4JX0CX7FCKTXcw0d0+OauuW8fe2PMP+2Y7lJ8H9bfh+WxMxqA4mp38ws3MSKvnyumt
         5jMjBDhm62MCI9dVWYoaFXcehe6Jndzd8HW2Z/NGzN+8cmP0rAmnKugtqc6+8dsArbMO
         XVQvT7nwc57JnA3E5IP4IsPsiEBbXJm6l8VLYEXA11TJLbmFVSuS40Q4e776qYFf0JHB
         Ugfkqtc1/FiZqGvtoYy5k01HTsguogC6q5KbRJs2xI/Oo4MhJeZRzM4OTMz0g11HY8jf
         tNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=8T8/7wmhsJz1Vo5eqV5XPa9NLGdEaXAmGI+ULA/OnIo=;
        b=PYpTI0h3nV7FpGAnrWajpD4NK8TeIEegXYI4P3WbddgaXwtEat9g+d2+UzmXYHvXR+
         ysvdZtacCIdcgfQ4KP5RfSNoBZ8c95GTFpv7U8UIt00mxMIPnX+o26BH9AS6mmJOcIpu
         i7mJ50qjRprAPz5ByOPqlgbYn1VGmpsdWwfLgmKyegfeh+t5sdawJV+vv61Gfb6vhQ3W
         lUttDGUdg+4F9P+dNTE1UIWgfrVp55+xPjgih/ZYyKYpAFLsyk3KcBd3b4lZyBPfLNKD
         qQXkjmINkfPVwOtw9C/eEyWXOv/C4cjHl36IrZIKmh6pYZxNp7XM56hXTjt3EACQ5ETz
         rU/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BF92177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 18:04:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] Move ad7746 out of staging
Message-ID: <20180415180451.4d538830@archlinux>
In-Reply-To: <1523637411-8531-14-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-14-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649762786653919?=
X-GMAIL-MSGID: =?utf-8?q?1597832583327665561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:50 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
A few comments inline.

Also nice to have a bit of a description of the driver in the patch
moving it out of staging.  It's a patch people might actually notice
as to many people it is some new hardware support (as they won't run
staging drivers).

A few comments inline, including some I missed in earlier patches that
could do with tidying up.  Ideally I'd like to see if Michael can
sanity check that the driver actually works.  If that is going to
take a while, I don't mind moving it on the basis we'll fix up any
issues that show up at a later date.

Thanks for your hard work on this.

Jonathan

> ---
>  .../devicetree/bindings/iio/cdc/ad7746.txt         |  34 +

Hmm. Thinking about it, there is no actual need for the driver to be out of=
 staging
to put the devicetree bindings in place outside staging.
I would do that in the first place rather than introducing them then moving=
=20
them a few patches later.


>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/cdc/Kconfig                            |  16 +
>  drivers/iio/cdc/Makefile                           |   5 +
>  drivers/iio/cdc/ad7746.c                           | 855 +++++++++++++++=
++++++
>  include/linux/iio/cdc/ad7746.h                     |  20 +
>  7 files changed, 932 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/ad7746.txt
>  create mode 100644 drivers/iio/cdc/Kconfig
>  create mode 100644 drivers/iio/cdc/Makefile
>  create mode 100644 drivers/iio/cdc/ad7746.c
>  create mode 100644 include/linux/iio/cdc/ad7746.h
>=20
> diff --git a/Documentation/devicetree/bindings/iio/cdc/ad7746.txt b/Docum=
entation/devicetree/bindings/iio/cdc/ad7746.txt
> new file mode 100644
> index 0000000..7740f05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/cdc/ad7746.txt
> @@ -0,0 +1,34 @@
> +Analog Devices AD7746/5/7 capacitive sensor driver
> +
> +Required properties:
> +	- compatible: Should be one of
> +		* "adi,ad7745"
> +		* "adi,ad7746"
> +	  * "adi,ad7747"
> +	- reg: The 7-bits long I2c address of the device
> +
> +Optional properties:
> +	- adi,exclvl: This property defines the excitation voltage level for the
> +    capacitance to be measured. Possible values are:
> +      * 0 =3D +-VDD/8
> +      * 1 =3D +-VDD/4
> +      * 2 =3D +-VDD * 3/8
> +      * 3 =3D +-VDD/2 (Default)
> +	- adi,nexca_en: Invert excitation output A.
> +	- adi,nexcb_en:	Invert excitation output B.
> +
> +Example:
> +Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
> +Excitation pin B would NOT be inverted.
> +
> +i2c2 {
> +
> +      < . . . >
> +
> +      ad7746: ad7746@60 {
> +              compatible =3D "ad7746";
> +              reg =3D <0x60>;
> +              adi,exclvl =3D <1>;
> +              adi,nexca_en;
> +      };
> +};
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index b3c8c6e..d1c309b 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -71,6 +71,7 @@ config IIO_TRIGGERED_EVENT
>  source "drivers/iio/accel/Kconfig"
>  source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
> +source "drivers/iio/cdc/Kconfig"
>  source "drivers/iio/chemical/Kconfig"
>  source "drivers/iio/common/Kconfig"
>  source "drivers/iio/counter/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index b16b2e9..18bea8d 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -17,6 +17,7 @@ obj-y +=3D accel/
>  obj-y +=3D adc/
>  obj-y +=3D amplifiers/
>  obj-y +=3D buffer/
> +obj-y +=3D cdc/
>  obj-y +=3D chemical/
>  obj-y +=3D common/
>  obj-y +=3D counter/
> diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
> new file mode 100644
> index 0000000..d3a8600
> --- /dev/null
> +++ b/drivers/iio/cdc/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# CDC drivers
> +#
> +menu "Capacitance to digital converters"
> +
> +config AD7746
> +	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Analog Devices capacitive sensors.
> +	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7746.
> +
> +endmenu
> diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
> new file mode 100644
> index 0000000..1f71283
> --- /dev/null
> +++ b/drivers/iio/cdc/Makefile
> @@ -0,0 +1,5 @@
> +#
> +#Makeefile for industrial I/O CDC drivers
> +#
> +
> +obj-$(CONFIG_AD7746) +=3D ad7746.o
> diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
> new file mode 100644
> index 0000000..f283819
> --- /dev/null
> +++ b/drivers/iio/cdc/ad7746.c
> @@ -0,0 +1,855 @@
> +/*
> + * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/cdc/ad7746.h>
There is a standard location for all platform data headers these days and
this isn't it.  This changed since some of the IIO drivers were written
so not surprising if some are still in the wrong place.


linux/platform_data/
> +
> +/*
> + * AD7746 Register Definition
Somewhat stating the obvious and also wrong comment syntax..
I'd get rid of this comment.

> + */
> +
> +#define AD7746_REG_CAP_DATA_HIGH	1
> +#define AD7746_REG_VT_DATA_HIGH		4
> +#define AD7746_REG_CAP_SETUP		7
> +#define AD7746_REG_VT_SETUP		8
> +#define AD7746_REG_EXC_SETUP		9
> +#define AD7746_REG_CFG			10
> +#define AD7746_REG_CAPDACA		11
> +#define AD7746_REG_CAPDACB		12
> +#define AD7746_REG_CAP_OFFH		13
> +#define AD7746_REG_CAP_GAINH		15
> +#define AD7746_REG_VOLT_GAINH		17
> +
> +/* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SE=
TUP) */
> +#define AD7746_CAPSETUP_CAPEN		BIT(7)
> +#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
> +#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
> +#define AD7746_CAPSETUP_CACHOP		BIT(0)
> +
> +/* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SE=
TUP) */
> +#define AD7746_VTSETUP_VTEN		(1 << 7)
The one above looks like it could be a BIT(7)?

> +#define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
> +#define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
> +#define AD7746_VTSETUP_EXTREF		BIT(4)
> +#define AD7746_VTSETUP_VTSHORT		BIT(1)
> +#define AD7746_VTSETUP_VTCHOP		BIT(0)
> +
> +/* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
> +#define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> +#define AD7746_EXCSETUP_EXCON		BIT(6)
> +#define AD7746_EXCSETUP_EXCB		BIT(5)
> +#define AD7746_EXCSETUP_NEXCB		BIT(4)
> +#define AD7746_EXCSETUP_EXCA		BIT(3)
> +#define AD7746_EXCSETUP_NEXCA		BIT(2)
> +#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
> +
> +/* Config Register Bit Designations (AD7746_REG_CFG) */
> +#define AD7746_CONF_VTFS_SHIFT		6
> +#define AD7746_CONF_CAPFS_SHIFT		3
> +#define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
> +#define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
> +#define AD7746_CONF_MODE_IDLE		(0 << 0)
> +#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
> +#define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
> +#define AD7746_CONF_MODE_PWRDN		(3 << 0)
> +#define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
> +#define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
> +
> +/* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> +#define AD7746_CAPDAC_DACEN		BIT(7)
> +#define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
> +
> +/*
> + * struct ad7746_chip_info - chip specific information
Name of the structure makes this pretty obvious :)  Perhaps
this comment (which should be in single line style anyway,
could be dropped).
> + */
> +
> +struct ad7746_chip_info {
> +	struct i2c_client *client;
> +	struct mutex lock; /* protect sensor state */
> +	/*
> +	 * Capacitive channel digital filter setup;
> +	 * conversion time/update rate setup per channel
> +	 */
> +	u8	config;
> +	u8	cap_setup;
> +	u8	vt_setup;
> +	u8	capdac[2][2];
> +	s8	capdac_set;
> +
> +	union {
> +		__be32 d32;
> +		u8 d8[4];
> +	} data ____cacheline_aligned;
> +};
> +
> +enum ad7746_chan {
> +	VIN,
> +	VIN_VDD,
> +	TEMP_INT,
> +	TEMP_EXT,
> +	CIN1,
> +	CIN1_DIFF,
> +	CIN2,
> +	CIN2_DIFF,
> +};
> +
> +static const struct iio_chan_spec ad7746_channels[] =3D {
> +	[VIN] =3D {
> +		.type =3D IIO_VOLTAGE,
> +		.indexed =3D 1,
> +		.channel =3D 0,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> +			AD7746_VTSETUP_VTMD_EXT_VIN,
Hmm. I never like to see a single location used to hold two different thing=
s.
I would suggest perhaps having address be an enum then have have a lookup
into an array of structures that have the two elements separately.
(use the ad7746_chan enum again for this?)

> +	},
> +	[VIN_VDD] =3D {
> +		.type =3D IIO_VOLTAGE,
> +		.indexed =3D 1,
> +		.channel =3D 1,
> +		.extend_name =3D "supply",
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> +			AD7746_VTSETUP_VTMD_VDD_MON,
> +	},
> +	[TEMP_INT] =3D {
> +		.type =3D IIO_TEMP,
> +		.indexed =3D 1,
> +		.channel =3D 0,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> +			AD7746_VTSETUP_VTMD_INT_TEMP,
> +	},
> +	[TEMP_EXT] =3D {
> +		.type =3D IIO_TEMP,
> +		.indexed =3D 1,
> +		.channel =3D 1,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
> +			AD7746_VTSETUP_VTMD_EXT_TEMP,
> +	},
> +	[CIN1] =3D {
> +		.type =3D IIO_CAPACITANCE,
> +		.indexed =3D 1,
> +		.channel =3D 0,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D AD7746_REG_CAP_DATA_HIGH << 8,
> +	},
> +	[CIN1_DIFF] =3D {
> +		.type =3D IIO_CAPACITANCE,
> +		.differential =3D 1,
> +		.indexed =3D 1,
> +		.channel =3D 0,
> +		.channel2 =3D 2,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
> +			AD7746_CAPSETUP_CAPDIFF
> +	},
> +	[CIN2] =3D {
> +		.type =3D IIO_CAPACITANCE,
> +		.indexed =3D 1,
> +		.channel =3D 1,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
> +			AD7746_CAPSETUP_CIN2,
> +	},
> +	[CIN2_DIFF] =3D {
> +		.type =3D IIO_CAPACITANCE,
> +		.differential =3D 1,
> +		.indexed =3D 1,
> +		.channel =3D 1,
> +		.channel2 =3D 3,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
> +			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
> +	}
> +};
> +
> +/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
> +static const unsigned char ad7746_vt_filter_rate_table[][2] =3D {
> +	{50, 20 + 1}, {31, 32 + 1}, {16, 62 + 1}, {8, 122 + 1},
> +};
> +
> +static const unsigned char ad7746_cap_filter_rate_table[][2] =3D {
> +	{91, 11 + 1}, {84, 12 + 1}, {50, 20 + 1}, {26, 38 + 1},
> +	{16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
> +};
> +
> +static int ad7746_select_channel(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan)
> +{
> +	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> +	u8 vt_setup, cap_setup;
> +	int ret, delay, idx;
> +
> +	switch (chan->type) {
> +	case IIO_CAPACITANCE:
> +		cap_setup =3D (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
> +		vt_setup =3D chip->vt_setup & ~AD7746_VTSETUP_VTEN;
> +		idx =3D (chip->config & AD7746_CONF_CAPFS_MASK) >>
> +			AD7746_CONF_CAPFS_SHIFT;
> +		delay =3D ad7746_cap_filter_rate_table[idx][1];
> +
> +		if (chip->capdac_set !=3D chan->channel) {
> +			ret =3D i2c_smbus_write_byte_data(chip->client,
> +				AD7746_REG_CAPDACA,
> +				chip->capdac[chan->channel][0]);
> +			if (ret < 0)
> +				return ret;
> +			ret =3D i2c_smbus_write_byte_data(chip->client,
> +				AD7746_REG_CAPDACB,
> +				chip->capdac[chan->channel][1]);
> +			if (ret < 0)
> +				return ret;
> +
> +			chip->capdac_set =3D chan->channel;
> +		}
> +		break;
> +	case IIO_VOLTAGE:
> +	case IIO_TEMP:
> +		vt_setup =3D (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
> +		cap_setup =3D chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
> +		idx =3D (chip->config & AD7746_CONF_VTFS_MASK) >>
> +			AD7746_CONF_VTFS_SHIFT;
> +		delay =3D ad7746_cap_filter_rate_table[idx][1];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (chip->cap_setup !=3D cap_setup) {
> +		ret =3D i2c_smbus_write_byte_data(chip->client,
> +						AD7746_REG_CAP_SETUP,
> +						cap_setup);
> +		if (ret < 0)
> +			return ret;
> +
> +		chip->cap_setup =3D cap_setup;
> +	}
> +
> +	if (chip->vt_setup !=3D vt_setup) {
> +		ret =3D i2c_smbus_write_byte_data(chip->client,
> +						AD7746_REG_VT_SETUP,
> +						vt_setup);
> +		if (ret < 0)
> +			return ret;
> +
> +		chip->vt_setup =3D vt_setup;
> +	}
> +
> +	return delay;
> +}
> +
> +static inline ssize_t ad7746_start_calib(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t len,
> +					 u8 regval)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> +	int ret, timeout =3D 10;
> +	bool doit;
> +
> +	ret =3D strtobool(buf, &doit);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!doit)
> +		return 0;
> +
> +	mutex_lock(&chip->lock);
This feels like the wrong level to be taking the lock at.  We aren't
preventing race problems (see below).

> +	regval |=3D chip->config;
> +	ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	do {
> +		msleep(20);
> +		ret =3D i2c_smbus_read_byte_data(chip->client, AD7746_REG_CFG);
> +		if (ret < 0)
> +			goto unlock;
> +
> +	} while ((ret =3D=3D regval) && timeout--);
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return len;
> +
> +unlock:
> +	mutex_unlock(&chip->lock);
> +	return ret;
> +}
> +
> +static ssize_t ad7746_start_offset_calib(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t len)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	int ret =3D ad7746_select_channel(indio_dev,
> +			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad7746_start_calib(dev, attr, buf, len,
> +				  AD7746_CONF_MODE_OFFS_CAL);
> +}
> +
> +static ssize_t ad7746_start_gain_calib(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t len)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);

No race possibilities in here? Nothing stops two instances of this running
at once, with different channels...  It is worth checking for
similar problems elsewhere in the driver.


> +	int ret =3D ad7746_select_channel(indio_dev,
> +			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad7746_start_calib(dev, attr, buf, len,
> +				  AD7746_CONF_MODE_GAIN_CAL);
> +}
> +
> +static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
> +		       0200, NULL, ad7746_start_offset_calib, CIN1);
> +static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
> +		       0200, NULL, ad7746_start_offset_calib, CIN2);
> +static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
> +		       0200, NULL, ad7746_start_gain_calib, CIN1);
> +static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
> +		       0200, NULL, ad7746_start_gain_calib, CIN2);
> +static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
> +		       0200, NULL, ad7746_start_gain_calib, VIN);
> +

Seems a little odd to have this next block of code here, before the
use of the above attrs?  Perhaps a bit of reorganization is needed?

> +static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *c=
hip,
> +					      int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
> +		if (val >=3D ad7746_cap_filter_rate_table[i][0])
> +			break;
> +
> +	if (i >=3D ARRAY_SIZE(ad7746_cap_filter_rate_table))
> +		i =3D ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
> +
> +	chip->config &=3D ~AD7746_CONF_CAPFS_MASK;
> +	chip->config |=3D i << AD7746_CONF_CAPFS_SHIFT;
> +
> +	return 0;
> +}
> +
> +static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *ch=
ip,
> +					     int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
> +		if (val >=3D ad7746_vt_filter_rate_table[i][0])
> +			break;
> +
> +	if (i >=3D ARRAY_SIZE(ad7746_vt_filter_rate_table))
> +		i =3D ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
> +
> +	chip->config &=3D ~AD7746_CONF_VTFS_MASK;
> +	chip->config |=3D i << AD7746_CONF_VTFS_SHIFT;
> +
> +	return 0;
> +}
> +
> +static IIO_CONST_ATTR(in_voltage_sampling_frequency_available, "50 31 16=
 8");
> +static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
> +		       "91 84 50 26 16 13 11 9");
> +
> +static struct attribute *ad7746_attributes[] =3D {
> +	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
> +	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
> +	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
> +	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.at=
tr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad7746_attribute_group =3D {
> +	.attrs =3D ad7746_attributes,
> +};
> +
> +static int ad7746_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
> +{
> +	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> +	int ret, reg;
> +
> +	mutex_lock(&chip->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val !=3D 1) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		/* 2^16 in micro */
> +		val =3D (val2 * 1024) / 15625;
> +
> +		switch (chan->type) {
> +		case IIO_CAPACITANCE:
> +			reg =3D AD7746_REG_CAP_GAINH;
> +			break;
> +		case IIO_VOLTAGE:
> +			reg =3D AD7746_REG_VOLT_GAINH;
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		ret =3D i2c_smbus_write_word_swapped(chip->client, reg, val);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret =3D 0;
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < 0 || val > 0xFFFF) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		ret =3D i2c_smbus_write_word_swapped(chip->client,
> +						   AD7746_REG_CAP_OFFH, val);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret =3D 0;
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (val < 0 || val > 43008000) { /* 21pF */
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		/*
> +		 * CAPDAC Scale =3D 21pF_typ / 127
> +		 * CIN Scale =3D 8.192pF / 2^24
> +		 * Offset Scale =3D CAPDAC Scale / CIN Scale =3D 338646
> +		 */
> +
> +		val /=3D 338646;
> +
> +		chip->capdac[chan->channel][chan->differential] =3D val > 0 ?
> +			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
> +
> +		ret =3D i2c_smbus_write_byte_data(chip->client,
> +						AD7746_REG_CAPDACA,
> +						chip->capdac[chan->channel][0]);
> +		if (ret < 0)
> +			goto out;
> +		ret =3D i2c_smbus_write_byte_data(chip->client,
> +						AD7746_REG_CAPDACB,
> +						chip->capdac[chan->channel][1]);
> +		if (ret < 0)
> +			goto out;
> +
> +		chip->capdac_set =3D chan->channel;
> +
> +		ret =3D 0;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val2) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		switch (chan->type) {
> +		case IIO_CAPACITANCE:
> +			ret =3D ad7746_store_cap_filter_rate_setup(chip, val);
> +			break;
> +		case IIO_VOLTAGE:
> +			ret =3D ad7746_store_vt_filter_rate_setup(chip, val);
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	mutex_unlock(&chip->lock);
As with the raw_read below, this lock is held over lots of things
that don't need it. I would push it up to limit it's scope.

> +	return ret;
> +}
> +
> +static int ad7746_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2,
> +			   long mask)
> +{
> +	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> +	int ret, delay, idx;
> +	u8 regval, reg;
> +
> +	mutex_lock(&chip->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret =3D ad7746_select_channel(indio_dev, chan);
> +		if (ret < 0)
> +			goto out;
> +		delay =3D ret;
> +
> +		regval =3D chip->config | AD7746_CONF_MODE_SINGLE_CONV;
> +		ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG,
> +						regval);
> +		if (ret < 0)
> +			goto out;
> +
> +		msleep(delay);
> +		/* Now read the actual register */
> +
> +		ret =3D i2c_smbus_read_i2c_block_data(chip->client,
> +						    chan->address >> 8, 3,
> +						    &chip->data.d8[1]);
> +
> +		if (ret < 0)
> +			goto out;
> +
> +		/*
> +		 * Either for Capacitance, Voltage or Temperature,
> +		 * the 0x000000 code represents negative full scale,
> +		 * the 0x800000 code represents zero scale, and
> +		 * the 0xFFFFFF code represents positive full scale.
> +		 */
> +
> +		*val =3D (be32_to_cpu(chip->data.d32) & 0xFFFFFF) - 0x800000;
> +
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +		/*
> +		 * temperature in milli degrees Celsius
> +		 * T =3D ((*val / 2048) - 4096) * 1000
> +		 */
I missed this earlier, but the comment should probably be indented one step=
 more.

> +			*val =3D (*val * 125) / 256;
> +			break;
> +		case IIO_VOLTAGE:
> +
> +			/*
> +			 * The voltage from the VDD pin is internally
> +			 * attenuated by 6.
> +			 */
> +
> +			if (chan->channel =3D=3D 1) /* supply_raw */
> +				*val =3D *val * 6;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		switch (chan->type) {
> +		case IIO_CAPACITANCE:
> +			reg =3D AD7746_REG_CAP_GAINH;
> +			break;
> +		case IIO_VOLTAGE:
> +			reg =3D AD7746_REG_VOLT_GAINH;
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		ret =3D i2c_smbus_read_word_swapped(chip->client, reg);
> +		if (ret < 0)
> +			goto out;
> +		/* 1 + gain_val / 2^16 */
> +		*val =3D 1;
> +		*val2 =3D (15625 * ret) / 1024;
> +
> +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret =3D i2c_smbus_read_word_swapped(chip->client,
> +						  AD7746_REG_CAP_OFFH);
> +		if (ret < 0)
> +			goto out;
> +		*val =3D ret;
> +
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +
> +		/*
> +		 * CAPDAC Scale =3D 21pF_typ / 127
> +		 * CIN Scale =3D 8.192pF / 2^24
> +		 * Offset Scale =3D CAPDAC Scale / CIN Scale =3D 338646
> +		 */
> +
> +		*val =3D AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
> +					  [chan->differential]) * 338646;
> +
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_CAPACITANCE:
Why are these inside the lock?
Seems odd given they are constant.
I would pull the lock in so it only covers cases that need locking.
It may well make sense to pull a few of the case statements' contents out
as utility functions to simply the unlocking in error paths etc.

This is particularly true for _RAW and _PROCESSED block above.


> +			/* CIN Scale: 8.192pf / 2^24 */
> +			*val =3D  0;
> +			*val2 =3D 488;
> +			ret =3D IIO_VAL_INT_PLUS_NANO;
> +			break;
> +		case IIO_VOLTAGE:
> +			/* VIN Scale: 1170mV / 2^23 */
> +			*val =3D 1170;
> +			*val2 =3D 23;
> +			ret =3D IIO_VAL_FRACTIONAL_LOG2;
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_CAPACITANCE:
> +			idx =3D (chip->config & AD7746_CONF_CAPFS_MASK) >>
> +				AD7746_CONF_CAPFS_SHIFT;
> +			*val =3D ad7746_cap_filter_rate_table[idx][0];
> +			ret =3D IIO_VAL_INT;
> +			break;
> +		case IIO_VOLTAGE:
> +			idx =3D (chip->config & AD7746_CONF_VTFS_MASK) >>
> +				AD7746_CONF_VTFS_SHIFT;
> +			*val =3D ad7746_vt_filter_rate_table[idx][0];
> +			ret =3D IIO_VAL_INT;
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret =3D -EINVAL;
Comment above is partly about avoiding this tree of default statements.
There is little point in having a lock for these error cases.

> +	}
> +out:
> +	mutex_unlock(&chip->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info ad7746_info =3D {
> +	.attrs =3D &ad7746_attribute_group,
> +	.read_raw =3D ad7746_read_raw,
> +	.write_raw =3D ad7746_write_raw,
> +};
> +
> +/*
> + * device probe and remove
> + */
> +#ifdef CONFIG_OF
> +static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct ad7746_platform_data *pdata;
> +	unsigned int tmp;
> +	int ret;
> +
> +	/*
> +	 * The default excitation outputs are not inverted, it should be stated
> +	 * in the dt if needed.
> +	 */
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	ret =3D of_property_read_u32(np, "adi,exclvl", &tmp);
> +	if (ret || tmp > 3) {
> +		dev_warn(dev, "Wrong exclvl value, using default\n");
> +		pdata->exclvl =3D 3;
> +	} else {
> +		pdata->exclvl =3D tmp;
> +	}
> +
> +	pdata->exca_en =3D true;
> +	pdata->excb_en =3D true;
> +	pdata->exca_inv_en =3D of_property_read_bool(np, "adi,nexca_en");
> +	pdata->excb_inv_en =3D of_property_read_bool(np, "adi,nexcb_en");
> +
> +	return pdata;
> +}
> +#else
> +static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +static int ad7746_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct ad7746_platform_data *pdata =3D client->dev.platform_data;
> +	struct ad7746_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	unsigned char regval =3D 0;
> +	int ret =3D 0;

There doesn't seem to be a path on which ret isn't set to something else.

> +
> +	if (client->dev.of_node)
> +		pdata =3D ad7746_parse_dt(&client->dev);
> +	else
> +		pdata =3D client->dev.platform_data;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	chip =3D iio_priv(indio_dev);
> +	mutex_init(&chip->lock);
> +	/* this is only used for device removal purposes */
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	chip->client =3D client;
> +	chip->capdac_set =3D -1;
> +
> +	/* Establish that the iio_dev is a child of the i2c device */
> +	indio_dev->name =3D id->name;
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->info =3D &ad7746_info;
> +	indio_dev->channels =3D ad7746_channels;
> +	if (id->driver_data =3D=3D 7746)
> +		indio_dev->num_channels =3D ARRAY_SIZE(ad7746_channels);
> +	else
> +		indio_dev->num_channels =3D  ARRAY_SIZE(ad7746_channels) - 2;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ad7746_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	if (pdata) {
> +		if (pdata->exca_en) {
> +			if (pdata->exca_inv_en)
> +				regval |=3D AD7746_EXCSETUP_NEXCA;
> +			else
> +				regval |=3D AD7746_EXCSETUP_EXCA;
> +		}
> +
> +		if (pdata->excb_en) {
> +			if (pdata->excb_inv_en)
> +				regval |=3D AD7746_EXCSETUP_NEXCB;
> +			else
> +				regval |=3D AD7746_EXCSETUP_EXCB;
> +		}
> +
> +		regval |=3D AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> +	} else {
> +		dev_warn(&client->dev, "No platform data? using default\n");
> +		regval =3D AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> +			AD7746_EXCSETUP_EXCLVL(3);
> +	}
> +
> +	ret =3D i2c_smbus_write_byte_data(chip->client,
> +					AD7746_REG_EXC_SETUP, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(indio_dev->dev.parent, indio_dev);
If it is worth turning the power off in the remove, then it is worth
turning it off on error in probe.

Also, return devm_iio_device_register would other otherwise be neater.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ad7746_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> +	unsigned char regval;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	regval =3D chip->config | AD7746_CONF_MODE_PWRDN;
> +	ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
> +
> +	mutex_unlock(&chip->lock);
> +
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "Could NOT Power Down!\n");
> +		goto out;
> +	}
> +
> +	iio_device_unregister(indio_dev);
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct i2c_device_id ad7746_id[] =3D {
> +	{ "ad7745", 7745 },
> +	{ "ad7746", 7746 },
> +	{ "ad7747", 7747 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ad7746_id);
> +
> +#ifdef CONFIG_OF
Mark it __maybe_unused and drop the ifdef (I missed this
in the patch that introduced it). =20
The size cost is tiny, for a gain in readability.

> +static const struct of_device_id ad7746_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7745" },
> +	{ .compatible =3D "adi,ad7746" },
> +	{ .compatible =3D "adi,ad7747" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7746_of_match);
> +#endif
> +
> +static struct i2c_driver ad7746_driver =3D {
> +	.driver =3D {
> +		.name =3D KBUILD_MODNAME,
> +		.of_match_table =3D of_match_ptr(ad7746_of_match),
> +	},
> +	.probe =3D ad7746_probe,
> +	.remove =3D ad7746_remove,
> +	.id_table =3D ad7746_id,
> +};
> +module_i2c_driver(ad7746_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> +MODULE_DESCRIPTION("Analog Devices AD7746/5/7 capacitive sensor driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/cdc/ad7746.h b/include/linux/iio/cdc/ad774=
6.h
> new file mode 100644
> index 0000000..46ff25e
> --- /dev/null
> +++ b/include/linux/iio/cdc/ad7746.h
> @@ -0,0 +1,20 @@
> +/*
> + * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#ifndef IIO_CDC_AD7746_H_
> +#define IIO_CDC_AD7746_H_
> +
> +struct ad7746_platform_data {
> +	unsigned char exclvl;	/*Excitation Voltage Level */
> +	bool exca_en;		/* enables EXCA pin as the excitation output */
> +	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
> +	bool excb_en;		/* enables EXCB pin as the excitation output */
> +	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
> +};
> +
> +#endif /* IIO_CDC_AD7746_H_ */
