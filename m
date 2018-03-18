Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521367768-2-11192519600195450120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521367766; b=TAAQHtq6MwZn3IMB0UGsrgz9xjn9IF0/0wZ6Hwhyohd1i9+
    40rv3AAIRglWoYztxsvsVP+HVuEh6MHeLm/4EmHExpM7P1ZketBWDcsDVT/Ktb7Y
    A3gHCzdQiBWvNWdMTUvA5JQSwlcrmZu6B8ZQdIe2uLKUICIr85ghgweYxiMTGKXb
    OUQw/eZUy/rAi0PUlCdd7NHSlyk9qXAqDwy5Au47MCodzE3ly6v+fLnPFLgQs71k
    OMce82lDwMdZsfq5TFa6dLclb0yxNGBKdSCVfQt+y3dcrYQvynUeXeRP8fQLz/GM
    AHnLM3f43DTxanPl2S58QgONvCDtD551LK5TLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521367766; bh=I
    XDEuX4lP1BLaLr8LRwRAaVCnVaujlcBeGMnLNseECc=; b=jvK3zRgWBaGTjix1m
    4YEkVsQ6IP5bBWbEdgN1cB+Kxsgr7TdIQowdYaY5cSyH9ntnrpMv0l1LHUcX4fr/
    W4QzBqBR7giVUPPF5cllfUP86pIQD9nijSnCTc5GTNO7l0aTWbmHziWGzrLUswBL
    nsIaCG7B3OH7xixsV6Ec4HaOvt2eSFrNiwnzgYFEyU61VSl3Aun+XPD0e0WPW+2d
    WwwLaVqPKFj3GJ34p+/2RbqIN3UZAaSyGjwmncBuLMEpql8SFnCJZjZhMMMYUMlI
    JZ5EUV0zVBD4EJD2lGLfxl5+8pOcpt3Jby5KzjCw7nkclzVS/0WE2uP416hHy/mz
    JSJzg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075C720685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 10:09:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v2] Staging: iio: adis16209: Move adis16209 driver out
 of staging
Message-ID: <20180318100907.1a582d52@archlinux>
In-Reply-To: <C8AE11A6-48CC-4EBD-AA5C-A08DDCD6970F@gmail.com>
References: <1520677223-11505-1-git-send-email-shreeya.patel23498@gmail.com>
 <20180310155731.7b7f584d@archlinux>
 <C8AE11A6-48CC-4EBD-AA5C-A08DDCD6970F@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 18 Mar 2018 15:18:44 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On 10 March 2018 21:27:31 GMT+05:30, Jonathan Cameron <jic23@kernel.org>
> 
> Hi Jonathan
> 
> >On Sat, 10 Mar 2018 15:50:23 +0530
> >Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> >  
> >> Move the adis16209 driver out of staging directory and merge to the
> >> mainline IIO subsystem.
> >> 
> >> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>  
> >As this has a clear dependency on the previous patch, please put them
> >in the same series for the next version.  That way I won't miss one!
> >
> >This also doesn't actually seem to have all the patches in place.
> >The sign extend one is definitely missing for some reason.
> >
> >One question on the ABI choice of X for the rotation axis.
> >I think the logical choice is actually Z but would like to know what
> >you and others think.
> >
> >All existing users of IIO_ROT (outside staging) have been magnetometer
> >where we don't have an axis, but rather a magnetic reference frame or
> >a quaternion output which includes all the axes.
> >
> >Jonathan
> >  
> >> ---
> >> 
> >> Changes in v2
> >>   -Re-send the patch after having some cleanups in the
> >> file included in this patch.
> >> 
> >>  drivers/iio/accel/Kconfig             |  12 ++
> >>  drivers/iio/accel/Makefile            |   1 +
> >>  drivers/iio/accel/adis16209.c         | 329  
> >++++++++++++++++++++++++++++++++++  
> >>  drivers/staging/iio/accel/Kconfig     |  12 --
> >>  drivers/staging/iio/accel/Makefile    |   1 -
> >>  drivers/staging/iio/accel/adis16209.c | 329  
> >----------------------------------  
> >>  6 files changed, 342 insertions(+), 342 deletions(-)
> >>  create mode 100644 drivers/iio/accel/adis16209.c
> >>  delete mode 100644 drivers/staging/iio/accel/adis16209.c
> >> 
> >> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> >> index c6d9517..f95f43c 100644
> >> --- a/drivers/iio/accel/Kconfig
> >> +++ b/drivers/iio/accel/Kconfig
> >> @@ -5,6 +5,18 @@
> >>  
> >>  menu "Accelerometers"
> >>  
> >> +config ADIS16209
> >> +        tristate "Analog Devices ADIS16209 Dual-Axis Digital  
> >Inclinometer and Accelerometer"  
> >> +        depends on SPI
> >> +        select IIO_ADIS_LIB
> >> +        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> >> +        help
> >> +          Say Y here to build support for Analog Devices adis16209  
> >dual-axis digital inclinometer  
> >> +          and accelerometer.
> >> +
> >> +          To compile this driver as a module, say M here: the module  
> >will be  
> >> +          called adis16209.
> >> +
> >>  config ADXL345
> >>  	tristate
> >>  
> >> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> >> index 368aedb..40861b9 100644
> >> --- a/drivers/iio/accel/Makefile
> >> +++ b/drivers/iio/accel/Makefile
> >> @@ -4,6 +4,7 @@
> >>  #
> >>  
> >>  # When adding new entries keep the list in alphabetical order
> >> +obj-$(CONFIG_ADIS16209) += adis16209.o
> >>  obj-$(CONFIG_ADXL345) += adxl345_core.o
> >>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
> >>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> >> diff --git a/drivers/iio/accel/adis16209.c  
> >b/drivers/iio/accel/adis16209.c  
> >> new file mode 100644
> >> index 0000000..ed2e89f
> >> --- /dev/null
> >> +++ b/drivers/iio/accel/adis16209.c
> >> @@ -0,0 +1,329 @@
> >> +/*
> >> + * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
> >> + *
> >> + * Copyright 2010 Analog Devices Inc.
> >> + *
> >> + * Licensed under the GPL-2 or later.
> >> + */
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/device.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/list.h>
> >> +#include <linux/module.h>
> >> +#include <linux/spi/spi.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/sysfs.h>
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/imu/adis.h>
> >> +
> >> +#define ADIS16209_STARTUP_DELAY_MS	220
> >> +#define ADIS16209_FLASH_CNT_REG		0x00
> >> +
> >> +/* Data Output Register Definitions */
> >> +#define ADIS16209_SUPPLY_OUT_REG	0x02
> >> +#define ADIS16209_XACCL_OUT_REG		0x04
> >> +#define ADIS16209_YACCL_OUT_REG		0x06
> >> +/* Output, auxiliary ADC input */
> >> +#define ADIS16209_AUX_ADC_REG		0x08
> >> +/* Output, temperature */
> >> +#define ADIS16209_TEMP_OUT_REG		0x0A
> >> +/* Output, +/- 90 degrees X-axis inclination */
> >> +#define ADIS16209_XINCL_OUT_REG		0x0C
> >> +#define ADIS16209_YINCL_OUT_REG		0x0E
> >> +/* Output, +/-180 vertical rotational position */
> >> +#define ADIS16209_ROT_OUT_REG		0x10
> >> +
> >> +/*
> >> + * Calibration Register Definitions.
> >> + * Acceleration, inclination or rotation offset null.
> >> + */
> >> +#define ADIS16209_XACCL_NULL_REG	0x12
> >> +#define ADIS16209_YACCL_NULL_REG	0x14
> >> +#define ADIS16209_XINCL_NULL_REG	0x16
> >> +#define ADIS16209_YINCL_NULL_REG	0x18
> >> +#define ADIS16209_ROT_NULL_REG		0x1A
> >> +
> >> +/* Alarm Register Definitions */
> >> +#define ADIS16209_ALM_MAG1_REG		0x20
> >> +#define ADIS16209_ALM_MAG2_REG		0x22
> >> +#define ADIS16209_ALM_SMPL1_REG		0x24
> >> +#define ADIS16209_ALM_SMPL2_REG		0x26
> >> +#define ADIS16209_ALM_CTRL_REG		0x28  
> 
> I see that these alarm registers are not being used anywhere in the driver and yet we have it's declaration. 
> Is it the left out work that will be done in future? 
It is never a obvious decision on whether to leave in defines
for unused parts of the register map.  Potentially someone
may want them in the future and they don't cause any confusion or
hurt the readability of the code, so I would leave them in.

> 
> >> +
> >> +#define ADIS16209_AUX_DAC_REG		0x30
> >> +#define ADIS16209_GPIO_CTRL_REG		0x32
> >> +#define ADIS16209_SMPL_PRD_REG		0x36
> >> +#define ADIS16209_AVG_CNT_REG		0x38
> >> +#define ADIS16209_SLP_CNT_REG		0x3A
> >> +
> >> +#define ADIS16209_MSC_CTRL_REG			0x34
> >> +#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> >> +#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
> >> +#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
> >> +/* Data-ready polarity: 1 = active high, 0 = active low */
> >> +#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
> >> +#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> >> +
> >> +#define ADIS16209_STAT_REG			0x3C
> >> +#define  ADIS16209_STAT_ALARM2			BIT(9)
> >> +#define  ADIS16209_STAT_ALARM1			BIT(8)  
> 
> Even here
> 
> >> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> >> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
> >> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
> >> +/* Power supply above 3.625 V */
> >> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
> >> +/* Power supply below 3.15 V */
> >> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
> >> +
> >> +#define ADIS16209_CMD_REG			0x3E
> >> +#define  ADIS16209_CMD_SW_RESET			BIT(7)
> >> +#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
> >> +#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
> >> +  
> 
> Here also we are just using the register and not the bit macros anywhere.
> 
> I would like to know the reason behind this. 
You guessed it.  No one wrote that support yet.  They might do in future
if someone who has hardware is sufficiently interested to do so.

For now they do no real harm and act as a kind of documentation
(though Analog never seem to remove old datasheets so that shouldn't be a
problem for these parts).

> 
> Thanks
> 
> >> +#define ADIS16209_ERROR_ACTIVE			BIT(14)
> >> +
> >> +enum adis16209_scan {
> >> +	ADIS16209_SCAN_SUPPLY,
> >> +	ADIS16209_SCAN_ACC_X,
> >> +	ADIS16209_SCAN_ACC_Y,
> >> +	ADIS16209_SCAN_AUX_ADC,
> >> +	ADIS16209_SCAN_TEMP,
> >> +	ADIS16209_SCAN_INCLI_X,
> >> +	ADIS16209_SCAN_INCLI_Y,
> >> +	ADIS16209_SCAN_ROT,
> >> +};
> >> +
> >> +static const u8 adis16209_addresses[8][1] = {
> >> +	[ADIS16209_SCAN_SUPPLY] = { },
> >> +	[ADIS16209_SCAN_AUX_ADC] = { },
> >> +	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
> >> +	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
> >> +	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
> >> +	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
> >> +	[ADIS16209_SCAN_ROT] = { },
> >> +	[ADIS16209_SCAN_TEMP] = { },
> >> +};
> >> +
> >> +static int adis16209_write_raw(struct iio_dev *indio_dev,
> >> +			       struct iio_chan_spec const *chan,
> >> +			       int val,
> >> +			       int val2,
> >> +			       long mask)
> >> +{
> >> +	struct adis *st = iio_priv(indio_dev);
> >> +	int bits;
> >> +	s16 val16;
> >> +	u8 addr;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_CALIBBIAS:
> >> +		switch (chan->type) {
> >> +		case IIO_ACCEL:
> >> +		case IIO_INCLI:
> >> +			bits = 14;
> >> +			break;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		val16 = val & ((1 << bits) - 1);
> >> +		addr = adis16209_addresses[chan->scan_index][0];
> >> +		return adis_write_reg_16(st, addr, val16);
> >> +	}
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +static int adis16209_read_raw(struct iio_dev *indio_dev,
> >> +			      struct iio_chan_spec const *chan,
> >> +			      int *val, int *val2,
> >> +			      long mask)
> >> +{
> >> +	struct adis *st = iio_priv(indio_dev);
> >> +	int ret;
> >> +	int bits;
> >> +	u8 addr;
> >> +	s16 val16;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		return adis_single_conversion(indio_dev, chan,
> >> +			ADIS16209_ERROR_ACTIVE, val);
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		switch (chan->type) {
> >> +		case IIO_VOLTAGE:
> >> +			*val = 0;
> >> +			if (chan->channel == 0)
> >> +				*val2 = 305180; /* 0.30518 mV */
> >> +			else
> >> +				*val2 = 610500; /* 0.6105 mV */
> >> +			return IIO_VAL_INT_PLUS_MICRO;
> >> +		case IIO_TEMP:
> >> +			*val = -470;
> >> +			*val2 = 0;
> >> +			return IIO_VAL_INT_PLUS_MICRO;
> >> +		case IIO_ACCEL:
> >> +			/*
> >> +			 * IIO base unit for sensitivity of accelerometer
> >> +			 * is milli g.
> >> +			 * 1 LSB represents 0.244 mg.
> >> +			 */
> >> +			*val = 0;
> >> +			*val2 = IIO_G_TO_M_S_2(244140);
> >> +			return IIO_VAL_INT_PLUS_NANO;
> >> +		case IIO_INCLI:
> >> +		case IIO_ROT:
> >> +			/*
> >> +			 * IIO base units for rotation are degrees.
> >> +			 * 1 LSB represents 0.025 milli degrees.
> >> +			 */
> >> +			*val = 0;
> >> +			*val2 = 25000;
> >> +			return IIO_VAL_INT_PLUS_MICRO;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		break;
> >> +	case IIO_CHAN_INFO_OFFSET:
> >> +		/*
> >> +		 * The raw ADC value is 0x4FE when the temperature
> >> +		 * is 45 degrees and the scale factor per milli
> >> +		 * degree celcius is -470.
> >> +		 */
> >> +		*val = 25000 / -470 - 0x4FE;
> >> +		return IIO_VAL_INT;
> >> +	case IIO_CHAN_INFO_CALIBBIAS:
> >> +		switch (chan->type) {
> >> +		case IIO_ACCEL:
> >> +			bits = 14;
> >> +			break;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +		addr = adis16209_addresses[chan->scan_index][0];
> >> +		ret = adis_read_reg_16(st, addr, &val16);
> >> +		if (ret)
> >> +			return ret;
> >> +		val16 &= (1 << bits) - 1;
> >> +		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> >> +		*val = val16;  
> >Something odd here as this isn't the current code - doesn't have the
> >sign extend patch in place.
> >  
> >> +		return IIO_VAL_INT;
> >> +	}
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +static const struct iio_chan_spec adis16209_channels[] = {
> >> +	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
> >> +			 0, 14),
> >> +	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
> >> +	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
> >> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >> +	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
> >> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >> +	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0,  
> >12),  
> >> +	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
> >> +			0, 0, 14),
> >> +	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
> >> +			0, 0, 14),
> >> +	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0,  
> >14),
> >This raises an interesting question.  How do we define rotation axes?
> >I would assume it was rotation about the axis, as such I think the
> >correct
> >axis for this is Z.
> >
> >However, then we consider the two inclination axis. Again fiddly.  I
> >suppose
> >it is inclination 'from' an axis, but in what plane?  I guess x and y
> >is about as good as we can do on those ones with the assumption they
> >are aligned to perpendicular to the vertical.
> >  
> >> +	IIO_CHAN_SOFT_TIMESTAMP(8)
> >> +};
> >> +
> >> +static const struct iio_info adis16209_info = {
> >> +	.read_raw = adis16209_read_raw,
> >> +	.write_raw = adis16209_write_raw,
> >> +	.update_scan_mode = adis_update_scan_mode,
> >> +};
> >> +
> >> +static const char * const adis16209_status_error_msgs[] = {
> >> +	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> >> +	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
> >> +	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
> >> +	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> >> +	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> >> +};
> >> +
> >> +static const struct adis_data adis16209_data = {
> >> +	.read_delay = 30,
> >> +	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
> >> +	.glob_cmd_reg = ADIS16209_CMD_REG,
> >> +	.diag_stat_reg = ADIS16209_STAT_REG,
> >> +
> >> +	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
> >> +	.self_test_no_autoclear = true,
> >> +	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
> >> +
> >> +	.status_error_msgs = adis16209_status_error_msgs,
> >> +	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
> >> +		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
> >> +		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
> >> +		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
> >> +		BIT(ADIS16209_STAT_POWER_LOW_BIT),
> >> +};
> >> +
> >> +static int adis16209_probe(struct spi_device *spi)
> >> +{
> >> +	int ret;
> >> +	struct adis *st;
> >> +	struct iio_dev *indio_dev;  
> >It's not one I personally feel strongly about but when there is no
> >reason not to do it, reverse Christmas tree ordering is preferred for
> >variable declarations.
> >  
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;  
> >Blank line here.
> >  
> >> +	st = iio_priv(indio_dev);
> >> +	spi_set_drvdata(spi, indio_dev);
> >> +
> >> +	indio_dev->name = spi->dev.driver->name;
> >> +	indio_dev->dev.parent = &spi->dev;
> >> +	indio_dev->info = &adis16209_info;
> >> +	indio_dev->channels = adis16209_channels;
> >> +	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +
> >> +	ret = adis_init(st, indio_dev, spi, &adis16209_data);
> >> +	if (ret)
> >> +		return ret;  
> >Blank line here.
> >  
> >> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = adis_initial_startup(st);
> >> +	if (ret)
> >> +		goto error_cleanup_buffer_trigger;
> >> +	ret = iio_device_register(indio_dev);
> >> +	if (ret)
> >> +		goto error_cleanup_buffer_trigger;
> >> +
> >> +	return 0;
> >> +
> >> +error_cleanup_buffer_trigger:
> >> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> >> +	return ret;
> >> +}
> >> +
> >> +static int adis16209_remove(struct spi_device *spi)
> >> +{
> >> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >> +	struct adis *st = iio_priv(indio_dev);
> >> +
> >> +	iio_device_unregister(indio_dev);
> >> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct spi_driver adis16209_driver = {
> >> +	.driver = {
> >> +		.name = "adis16209",
> >> +	},
> >> +	.probe = adis16209_probe,
> >> +	.remove = adis16209_remove,
> >> +};
> >> +module_spi_driver(adis16209_driver);
> >> +
> >> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> >> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital  
> >Inclinometer and Accelerometer");  
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_ALIAS("spi:adis16209");]  
> >
> ><snip>  
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
