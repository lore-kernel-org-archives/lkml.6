Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+PaTjl3mOnOiCQUFB0IugFpll7l+GxGIvmKnNuyG07N1jGnWuXr1BmacvptSwvsCAmkOm5
ARC-Seal: i=1; a=rsa-sha256; t=1522410496; cv=none;
        d=google.com; s=arc-20160816;
        b=jN4V+JXCCB6EDSOaRgl4EHORDuofXDnZd/9KitDFF/WNGSHkxmgwioz+lQqxwBH5sS
         o/ACzS0GPYDaTyZN07L42oOeDHVYgLxLR1i8mbdgb1lfb8XRRqmXEbZPFIF1GSs0jD2z
         gU1BdCvIAileattMAAwDyLMmSWTxDWGwBCRKwvjV82OoAWuydysdn0Uy5dgKm6NBL65H
         Qc/K7JJjANWi0jXshfzLcNU7SG+iwIA01ErmkkoUp+u4bx18C2yqSGDUl5TRpCRRXB5l
         DOLnc2cLqSMQ93QoDp+apUMYSvENkQAQgRIyPDrXRaEQ8/vLkSZC4MlUsHAoYDHuEhRd
         14iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=SXuMBefhduwv0EFcJcLqC7bYbfnIfDbaXGr7TxXajf4=;
        b=OY963wb8Re9fv0SzPv3U5G5zKVfNWFQzAaCx+rKaHBarmND6ygD/hYSTPbgeiIP0qQ
         6E7g+EnOEBTK5lP0ae6JvKaZmgBlOhgZ4eNCO7iQq/P0ukxoqvLakAE8QSZ9Erd1me7i
         vWVlKEy25mHce2Lp7Sku5fIvzazddTOizbIciTNxoiX4d0NSBFUnjYWEX1Iqb0wQidUZ
         MT/TcFPW3Lslkl/klQszHtEVVyB7BcgolUlyDcsVHX1lOnWFm8tMmgLAsKKWauf7a2Ht
         GfxmvCGNwrSUWmWirZUaHHBXVRINoTdPxmoGpcv31Sbg2CqDiaH2W9GWdq5I/fC3jggw
         BURQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C37E21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 12:48:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 6/6] Staging: iio: adis16209: Move adis16209 driver
 out of staging
Message-ID: <20180330124810.4f1eba09@archlinux>
In-Reply-To: <a578c1a071cacd180d8e123e96add21f8b75db85.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
	<a578c1a071cacd180d8e123e96add21f8b75db85.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596263371231583165?=
X-GMAIL-MSGID: =?utf-8?q?1596363108759973855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:52:51 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Move the adis16209 driver out of staging directory and merge to the
> mainline IIO subsystem.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Other than fixing up for the patch 5 indentation change there
was some 'fuzz' due to the adis16201 moving before this one - easily
fixed up but please check I didn't get it wrong!

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Good final series and good cleanup in general.

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Move driver adis16209 from staging to mainline IIO subsystem
> after complete cleanup of it.
> 
>  drivers/iio/accel/Kconfig             |  12 ++
>  drivers/iio/accel/Makefile            |   1 +
>  drivers/iio/accel/adis16209.c         | 330 ++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/accel/Kconfig     |  12 --
>  drivers/staging/iio/accel/Makefile    |   1 -
>  drivers/staging/iio/accel/adis16209.c | 330 ----------------------------------
>  6 files changed, 343 insertions(+), 343 deletions(-)
>  create mode 100644 drivers/iio/accel/adis16209.c
>  delete mode 100644 drivers/staging/iio/accel/adis16209.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c6d9517..f95f43c 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -5,6 +5,18 @@
>  
>  menu "Accelerometers"
>  
> +config ADIS16209
> +        tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
> +        depends on SPI
> +        select IIO_ADIS_LIB
> +        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> +        help
> +          Say Y here to build support for Analog Devices adis16209 dual-axis digital inclinometer
> +          and accelerometer.
> +
> +          To compile this driver as a module, say M here: the module will be
> +          called adis16209.
> +
>  config ADXL345
>  	tristate
>  
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 368aedb..40861b9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ADIS16209) += adis16209.o
>  obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> new file mode 100644
> index 0000000..cc50667
> --- /dev/null
> +++ b/drivers/iio/accel/adis16209.c
> @@ -0,0 +1,330 @@
> +/*
> + * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#define ADIS16209_STARTUP_DELAY_MS	220
> +#define ADIS16209_FLASH_CNT_REG		0x00
> +
> +/* Data Output Register Definitions */
> +#define ADIS16209_SUPPLY_OUT_REG	0x02
> +#define ADIS16209_XACCL_OUT_REG		0x04
> +#define ADIS16209_YACCL_OUT_REG		0x06
> +/* Output, auxiliary ADC input */
> +#define ADIS16209_AUX_ADC_REG		0x08
> +/* Output, temperature */
> +#define ADIS16209_TEMP_OUT_REG		0x0A
> +/* Output, +/- 90 degrees X-axis inclination */
> +#define ADIS16209_XINCL_OUT_REG		0x0C
> +#define ADIS16209_YINCL_OUT_REG		0x0E
> +/* Output, +/-180 vertical rotational position */
> +#define ADIS16209_ROT_OUT_REG		0x10
> +
> +/*
> + * Calibration Register Definitions.
> + * Acceleration, inclination or rotation offset null.
> + */
> +#define ADIS16209_XACCL_NULL_REG	0x12
> +#define ADIS16209_YACCL_NULL_REG	0x14
> +#define ADIS16209_XINCL_NULL_REG	0x16
> +#define ADIS16209_YINCL_NULL_REG	0x18
> +#define ADIS16209_ROT_NULL_REG		0x1A
> +
> +/* Alarm Register Definitions */
> +#define ADIS16209_ALM_MAG1_REG		0x20
> +#define ADIS16209_ALM_MAG2_REG		0x22
> +#define ADIS16209_ALM_SMPL1_REG		0x24
> +#define ADIS16209_ALM_SMPL2_REG		0x26
> +#define ADIS16209_ALM_CTRL_REG		0x28
> +
> +#define ADIS16209_AUX_DAC_REG		0x30
> +#define ADIS16209_GPIO_CTRL_REG		0x32
> +#define ADIS16209_SMPL_PRD_REG		0x36
> +#define ADIS16209_AVG_CNT_REG		0x38
> +#define ADIS16209_SLP_CNT_REG		0x3A
> +
> +#define ADIS16209_MSC_CTRL_REG			0x34
> +#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> +#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
> +#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
> +/* Data-ready polarity: 1 = active high, 0 = active low */
> +#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
> +#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> +
> +#define ADIS16209_STAT_REG			0x3C
> +#define  ADIS16209_STAT_ALARM2			BIT(9)
> +#define  ADIS16209_STAT_ALARM1			BIT(8)
> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
> +/* Power supply above 3.625 V */
> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
> +/* Power supply below 3.15 V */
> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
> +
> +#define ADIS16209_CMD_REG			0x3E
> +#define  ADIS16209_CMD_SW_RESET			BIT(7)
> +#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
> +#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
> +
> +#define ADIS16209_ERROR_ACTIVE			BIT(14)
> +
> +enum adis16209_scan {
> +	ADIS16209_SCAN_SUPPLY,
> +	ADIS16209_SCAN_ACC_X,
> +	ADIS16209_SCAN_ACC_Y,
> +	ADIS16209_SCAN_AUX_ADC,
> +	ADIS16209_SCAN_TEMP,
> +	ADIS16209_SCAN_INCLI_X,
> +	ADIS16209_SCAN_INCLI_Y,
> +	ADIS16209_SCAN_ROT,
> +};
> +
> +static const u8 adis16209_addresses[8][1] = {
> +	[ADIS16209_SCAN_SUPPLY] = { },
> +	[ADIS16209_SCAN_AUX_ADC] = { },
> +	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
> +	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
> +	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
> +	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
> +	[ADIS16209_SCAN_ROT] = { },
> +	[ADIS16209_SCAN_TEMP] = { },
> +};
> +
> +static int adis16209_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int m;
> +
> +	if (mask != IIO_CHAN_INFO_CALIBBIAS)
> +		return -EINVAL;
> +
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +		case IIO_INCLI:
> +			m = GENMASK(13, 0);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	return adis_write_reg_16(st, adis16209_addresses[chan->scan_index][0],
> +				 val & m);
> +}
> +
> +static int adis16209_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	int bits;
> +	u8 addr;
> +	s16 val16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan,
> +			ADIS16209_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = 0;
> +			switch (chan->channel) {
> +			case 0:
> +				*val2 = 305180; /* 0.30518 mV */
> +				break;
> +			case 1:
> +				*val2 = 610500; /* 0.6105 mV */
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = -470;
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +			/*
> +			 * IIO base unit for sensitivity of accelerometer
> +			 * is milli g.
> +			 * 1 LSB represents 0.244 mg.
> +			 */
> +			*val = 0;
> +			*val2 = IIO_G_TO_M_S_2(244140);
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_INCLI:
> +		case IIO_ROT:
> +			/*
> +			 * IIO base units for rotation are degrees.
> +			 * 1 LSB represents 0.025 milli degrees.
> +			 */
> +			*val = 0;
> +			*val2 = 25000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * The raw ADC value is 0x4FE when the temperature
> +		 * is 45 degrees and the scale factor per milli
> +		 * degree celcius is -470.
> +		 */
> +		*val = 25000 / -470 - 0x4FE;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			bits = 14;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		addr = adis16209_addresses[chan->scan_index][0];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(val16, bits - 1);
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adis16209_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
> +			 0, 14),
> +	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
> +			0, 0, 14),
> +	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
> +			0, 0, 14),
> +	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0, 14),
> +	IIO_CHAN_SOFT_TIMESTAMP(8)
> +};
> +
> +static const struct iio_info adis16209_info = {
> +	.read_raw = adis16209_read_raw,
> +	.write_raw = adis16209_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +};
> +
> +static const char * const adis16209_status_error_msgs[] = {
> +	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> +	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
> +	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +};
> +
> +static const struct adis_data adis16209_data = {
> +	.read_delay = 30,
> +	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16209_CMD_REG,
> +	.diag_stat_reg = ADIS16209_STAT_REG,
> +
> +	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
> +
> +	.status_error_msgs = adis16209_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16209_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16209_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16209_info;
> +	indio_dev->channels = adis16209_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16209_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +	return ret;
> +}
> +
> +static int adis16209_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adis *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16209_driver = {
> +	.driver = {
> +		.name = "adis16209",
> +	},
> +	.probe = adis16209_probe,
> +	.remove = adis16209_remove,
> +};
> +module_spi_driver(adis16209_driver);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16209");
