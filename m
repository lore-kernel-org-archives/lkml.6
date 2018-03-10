Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2931883-1520677238-2-11784044928465931477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520677236; b=Mb/CPx0Zfu0+xx7igBka6SD5S86eqHLzY7Ryw6V0792iZkA
    2G47V5jfeaORfth5ej2sF/rrtDMm2PBbSHk7VY7wFcJb+/AwrBDGakfh90z5fSaf
    O2CYzIJjQuxCE0oHhf0z+bQvWqXUAFjRmWeruO02hiLLR/uBWyTrXd3FgqjKcPLR
    hEMlyvPhDoCMVledsPRd1xQ4ksrUTss0ybCJ0fMAAllxELnCKsDwE3fZtrdQoud5
    zv8YhSU5GtnLdTAUMhVLCyJcaBJ4js1LxjhZuNZvFHh4/IlKaJi5wvmpjdbPxCVK
    cRplfUJr+QVbQ0dGiCjzbB46qepvP2vVa8geNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520677236; bh=R
    iGYWXWhCM68vFhW1m63PadEKr6crDXG6Vcjcrk6Rlo=; b=PKDQn3GoDzgr5dl6V
    YKQY2sMKf9Q5cnxFwxHSjWN2YFUN/JwhMd8cOqpR3Oug6FhzwWAKmkLGELGe3SYY
    x+nWrRYVF5yKWHQ5HA2UFDn3IYmAziSjytHzwY1+dsrYpzqGxWM9F6yhqMP/aGF4
    GC7ryQrGDOWBPdpGtuuW/gr+z/R5gJqPGe6kqPqnTA405s3pOOUsfdj+hYeEKGqN
    HcIqBtrEhmRElgesVGzR8hdicO7/jQqH7bZ0iUAl2Ndbjsc3zXfZUxDWLhTYEQIk
    4iY6I/xHuiLyOavW+Pkqa0Q1RA6dQcF+F6IBnmZMyObdNXeDmad1jjdWfNeWI2HO
    AyVUg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rXlbLKxX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l8LjotFH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rXlbLKxX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l8LjotFH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvOoc0pWniK77RguljoN0AvNg2ry7YIwPFnQ6jwgXv6vcW35HiRBLyHwxQEdDJF+hAmj4LuVQ==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH v2] Staging: iio: adis16209: Move adis16209 driver out of
 staging
Date: Sat, 10 Mar 2018 15:50:23 +0530
Message-Id: <1520677223-11505-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the adis16209 driver out of staging directory and merge to the
mainline IIO subsystem.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v2
  -Re-send the patch after having some cleanups in the
file included in this patch.

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16209.c         | 329 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16209.c | 329 ----------------------------------
 6 files changed, 342 insertions(+), 342 deletions(-)
 create mode 100644 drivers/iio/accel/adis16209.c
 delete mode 100644 drivers/staging/iio/accel/adis16209.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index c6d9517..f95f43c 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -5,6 +5,18 @@
 
 menu "Accelerometers"
 
+config ADIS16209
+        tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
+        depends on SPI
+        select IIO_ADIS_LIB
+        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+        help
+          Say Y here to build support for Analog Devices adis16209 dual-axis digital inclinometer
+          and accelerometer.
+
+          To compile this driver as a module, say M here: the module will be
+          called adis16209.
+
 config ADXL345
 	tristate
 
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 368aedb..40861b9 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
new file mode 100644
index 0000000..ed2e89f
--- /dev/null
+++ b/drivers/iio/accel/adis16209.c
@@ -0,0 +1,329 @@
+/*
+ * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
+
+#define ADIS16209_STARTUP_DELAY_MS	220
+#define ADIS16209_FLASH_CNT_REG		0x00
+
+/* Data Output Register Definitions */
+#define ADIS16209_SUPPLY_OUT_REG	0x02
+#define ADIS16209_XACCL_OUT_REG		0x04
+#define ADIS16209_YACCL_OUT_REG		0x06
+/* Output, auxiliary ADC input */
+#define ADIS16209_AUX_ADC_REG		0x08
+/* Output, temperature */
+#define ADIS16209_TEMP_OUT_REG		0x0A
+/* Output, +/- 90 degrees X-axis inclination */
+#define ADIS16209_XINCL_OUT_REG		0x0C
+#define ADIS16209_YINCL_OUT_REG		0x0E
+/* Output, +/-180 vertical rotational position */
+#define ADIS16209_ROT_OUT_REG		0x10
+
+/*
+ * Calibration Register Definitions.
+ * Acceleration, inclination or rotation offset null.
+ */
+#define ADIS16209_XACCL_NULL_REG	0x12
+#define ADIS16209_YACCL_NULL_REG	0x14
+#define ADIS16209_XINCL_NULL_REG	0x16
+#define ADIS16209_YINCL_NULL_REG	0x18
+#define ADIS16209_ROT_NULL_REG		0x1A
+
+/* Alarm Register Definitions */
+#define ADIS16209_ALM_MAG1_REG		0x20
+#define ADIS16209_ALM_MAG2_REG		0x22
+#define ADIS16209_ALM_SMPL1_REG		0x24
+#define ADIS16209_ALM_SMPL2_REG		0x26
+#define ADIS16209_ALM_CTRL_REG		0x28
+
+#define ADIS16209_AUX_DAC_REG		0x30
+#define ADIS16209_GPIO_CTRL_REG		0x32
+#define ADIS16209_SMPL_PRD_REG		0x36
+#define ADIS16209_AVG_CNT_REG		0x38
+#define ADIS16209_SLP_CNT_REG		0x3A
+
+#define ADIS16209_MSC_CTRL_REG			0x34
+#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
+#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
+#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
+/* Data-ready polarity: 1 = active high, 0 = active low */
+#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
+#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
+
+#define ADIS16209_STAT_REG			0x3C
+#define  ADIS16209_STAT_ALARM2			BIT(9)
+#define  ADIS16209_STAT_ALARM1			BIT(8)
+#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
+#define  ADIS16209_STAT_SPI_FAIL_BIT		3
+#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
+/* Power supply above 3.625 V */
+#define  ADIS16209_STAT_POWER_HIGH_BIT		1
+/* Power supply below 3.15 V */
+#define  ADIS16209_STAT_POWER_LOW_BIT		0
+
+#define ADIS16209_CMD_REG			0x3E
+#define  ADIS16209_CMD_SW_RESET			BIT(7)
+#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
+#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
+
+#define ADIS16209_ERROR_ACTIVE			BIT(14)
+
+enum adis16209_scan {
+	ADIS16209_SCAN_SUPPLY,
+	ADIS16209_SCAN_ACC_X,
+	ADIS16209_SCAN_ACC_Y,
+	ADIS16209_SCAN_AUX_ADC,
+	ADIS16209_SCAN_TEMP,
+	ADIS16209_SCAN_INCLI_X,
+	ADIS16209_SCAN_INCLI_Y,
+	ADIS16209_SCAN_ROT,
+};
+
+static const u8 adis16209_addresses[8][1] = {
+	[ADIS16209_SCAN_SUPPLY] = { },
+	[ADIS16209_SCAN_AUX_ADC] = { },
+	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
+	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
+	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
+	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
+	[ADIS16209_SCAN_ROT] = { },
+	[ADIS16209_SCAN_TEMP] = { },
+};
+
+static int adis16209_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct adis *st = iio_priv(indio_dev);
+	int bits;
+	s16 val16;
+	u8 addr;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_ACCEL:
+		case IIO_INCLI:
+			bits = 14;
+			break;
+		default:
+			return -EINVAL;
+		}
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16209_addresses[chan->scan_index][0];
+		return adis_write_reg_16(st, addr, val16);
+	}
+	return -EINVAL;
+}
+
+static int adis16209_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct adis *st = iio_priv(indio_dev);
+	int ret;
+	int bits;
+	u8 addr;
+	s16 val16;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return adis_single_conversion(indio_dev, chan,
+			ADIS16209_ERROR_ACTIVE, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = 0;
+			if (chan->channel == 0)
+				*val2 = 305180; /* 0.30518 mV */
+			else
+				*val2 = 610500; /* 0.6105 mV */
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = -470;
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			/*
+			 * IIO base unit for sensitivity of accelerometer
+			 * is milli g.
+			 * 1 LSB represents 0.244 mg.
+			 */
+			*val = 0;
+			*val2 = IIO_G_TO_M_S_2(244140);
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_INCLI:
+		case IIO_ROT:
+			/*
+			 * IIO base units for rotation are degrees.
+			 * 1 LSB represents 0.025 milli degrees.
+			 */
+			*val = 0;
+			*val2 = 25000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * The raw ADC value is 0x4FE when the temperature
+		 * is 45 degrees and the scale factor per milli
+		 * degree celcius is -470.
+		 */
+		*val = 25000 / -470 - 0x4FE;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			bits = 14;
+			break;
+		default:
+			return -EINVAL;
+		}
+		addr = adis16209_addresses[chan->scan_index][0];
+		ret = adis_read_reg_16(st, addr, &val16);
+		if (ret)
+			return ret;
+		val16 &= (1 << bits) - 1;
+		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
+		*val = val16;
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec adis16209_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
+			 0, 14),
+	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
+	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
+			0, 0, 14),
+	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
+			0, 0, 14),
+	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0, 14),
+	IIO_CHAN_SOFT_TIMESTAMP(8)
+};
+
+static const struct iio_info adis16209_info = {
+	.read_raw = adis16209_read_raw,
+	.write_raw = adis16209_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+};
+
+static const char * const adis16209_status_error_msgs[] = {
+	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
+	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
+	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
+	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
+	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+};
+
+static const struct adis_data adis16209_data = {
+	.read_delay = 30,
+	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
+	.glob_cmd_reg = ADIS16209_CMD_REG,
+	.diag_stat_reg = ADIS16209_STAT_REG,
+
+	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
+	.self_test_no_autoclear = true,
+	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
+
+	.status_error_msgs = adis16209_status_error_msgs,
+	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
+		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
+		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16209_STAT_POWER_LOW_BIT),
+};
+
+static int adis16209_probe(struct spi_device *spi)
+{
+	int ret;
+	struct adis *st;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16209_info;
+	indio_dev->channels = adis16209_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis_init(st, indio_dev, spi, &adis16209_data);
+	if (ret)
+		return ret;
+	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	if (ret)
+		return ret;
+
+	ret = adis_initial_startup(st);
+	if (ret)
+		goto error_cleanup_buffer_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_cleanup_buffer_trigger;
+
+	return 0;
+
+error_cleanup_buffer_trigger:
+	adis_cleanup_buffer_and_trigger(st, indio_dev);
+	return ret;
+}
+
+static int adis16209_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct adis *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	adis_cleanup_buffer_and_trigger(st, indio_dev);
+
+	return 0;
+}
+
+static struct spi_driver adis16209_driver = {
+	.driver = {
+		.name = "adis16209",
+	},
+	.probe = adis16209_probe,
+	.remove = adis16209_remove,
+};
+module_spi_driver(adis16209_driver);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16209");
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index c6b0f5e..bf8e43b 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -27,18 +27,6 @@ config ADIS16203
 	  To compile this driver as a module, say M here: the module will be
 	  called adis16203.
 
-config ADIS16209
-	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16209 dual-axis digital inclinometer
-	  and accelerometer.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16209.
-
 config ADIS16240
 	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 5d8ad21..ccbcac2 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -4,5 +4,4 @@
 
 obj-$(CONFIG_ADIS16201) += adis16201.o
 obj-$(CONFIG_ADIS16203) += adis16203.o
-obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
deleted file mode 100644
index ed2e89f..0000000
--- a/drivers/staging/iio/accel/adis16209.c
+++ /dev/null
@@ -1,329 +0,0 @@
-/*
- * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
- *
- * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/imu/adis.h>
-
-#define ADIS16209_STARTUP_DELAY_MS	220
-#define ADIS16209_FLASH_CNT_REG		0x00
-
-/* Data Output Register Definitions */
-#define ADIS16209_SUPPLY_OUT_REG	0x02
-#define ADIS16209_XACCL_OUT_REG		0x04
-#define ADIS16209_YACCL_OUT_REG		0x06
-/* Output, auxiliary ADC input */
-#define ADIS16209_AUX_ADC_REG		0x08
-/* Output, temperature */
-#define ADIS16209_TEMP_OUT_REG		0x0A
-/* Output, +/- 90 degrees X-axis inclination */
-#define ADIS16209_XINCL_OUT_REG		0x0C
-#define ADIS16209_YINCL_OUT_REG		0x0E
-/* Output, +/-180 vertical rotational position */
-#define ADIS16209_ROT_OUT_REG		0x10
-
-/*
- * Calibration Register Definitions.
- * Acceleration, inclination or rotation offset null.
- */
-#define ADIS16209_XACCL_NULL_REG	0x12
-#define ADIS16209_YACCL_NULL_REG	0x14
-#define ADIS16209_XINCL_NULL_REG	0x16
-#define ADIS16209_YINCL_NULL_REG	0x18
-#define ADIS16209_ROT_NULL_REG		0x1A
-
-/* Alarm Register Definitions */
-#define ADIS16209_ALM_MAG1_REG		0x20
-#define ADIS16209_ALM_MAG2_REG		0x22
-#define ADIS16209_ALM_SMPL1_REG		0x24
-#define ADIS16209_ALM_SMPL2_REG		0x26
-#define ADIS16209_ALM_CTRL_REG		0x28
-
-#define ADIS16209_AUX_DAC_REG		0x30
-#define ADIS16209_GPIO_CTRL_REG		0x32
-#define ADIS16209_SMPL_PRD_REG		0x36
-#define ADIS16209_AVG_CNT_REG		0x38
-#define ADIS16209_SLP_CNT_REG		0x3A
-
-#define ADIS16209_MSC_CTRL_REG			0x34
-#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
-#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
-#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
-#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
-
-#define ADIS16209_STAT_REG			0x3C
-#define  ADIS16209_STAT_ALARM2			BIT(9)
-#define  ADIS16209_STAT_ALARM1			BIT(8)
-#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
-#define  ADIS16209_STAT_SPI_FAIL_BIT		3
-#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
-/* Power supply above 3.625 V */
-#define  ADIS16209_STAT_POWER_HIGH_BIT		1
-/* Power supply below 3.15 V */
-#define  ADIS16209_STAT_POWER_LOW_BIT		0
-
-#define ADIS16209_CMD_REG			0x3E
-#define  ADIS16209_CMD_SW_RESET			BIT(7)
-#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
-#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
-
-#define ADIS16209_ERROR_ACTIVE			BIT(14)
-
-enum adis16209_scan {
-	ADIS16209_SCAN_SUPPLY,
-	ADIS16209_SCAN_ACC_X,
-	ADIS16209_SCAN_ACC_Y,
-	ADIS16209_SCAN_AUX_ADC,
-	ADIS16209_SCAN_TEMP,
-	ADIS16209_SCAN_INCLI_X,
-	ADIS16209_SCAN_INCLI_Y,
-	ADIS16209_SCAN_ROT,
-};
-
-static const u8 adis16209_addresses[8][1] = {
-	[ADIS16209_SCAN_SUPPLY] = { },
-	[ADIS16209_SCAN_AUX_ADC] = { },
-	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
-	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
-	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
-	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
-	[ADIS16209_SCAN_ROT] = { },
-	[ADIS16209_SCAN_TEMP] = { },
-};
-
-static int adis16209_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int bits;
-	s16 val16;
-	u8 addr;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ACCEL:
-		case IIO_INCLI:
-			bits = 14;
-			break;
-		default:
-			return -EINVAL;
-		}
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16209_addresses[chan->scan_index][0];
-		return adis_write_reg_16(st, addr, val16);
-	}
-	return -EINVAL;
-}
-
-static int adis16209_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int ret;
-	int bits;
-	u8 addr;
-	s16 val16;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		return adis_single_conversion(indio_dev, chan,
-			ADIS16209_ERROR_ACTIVE, val);
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			*val = 0;
-			if (chan->channel == 0)
-				*val2 = 305180; /* 0.30518 mV */
-			else
-				*val2 = 610500; /* 0.6105 mV */
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_TEMP:
-			*val = -470;
-			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_ACCEL:
-			/*
-			 * IIO base unit for sensitivity of accelerometer
-			 * is milli g.
-			 * 1 LSB represents 0.244 mg.
-			 */
-			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(244140);
-			return IIO_VAL_INT_PLUS_NANO;
-		case IIO_INCLI:
-		case IIO_ROT:
-			/*
-			 * IIO base units for rotation are degrees.
-			 * 1 LSB represents 0.025 milli degrees.
-			 */
-			*val = 0;
-			*val2 = 25000;
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case IIO_CHAN_INFO_OFFSET:
-		/*
-		 * The raw ADC value is 0x4FE when the temperature
-		 * is 45 degrees and the scale factor per milli
-		 * degree celcius is -470.
-		 */
-		*val = 25000 / -470 - 0x4FE;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ACCEL:
-			bits = 14;
-			break;
-		default:
-			return -EINVAL;
-		}
-		addr = adis16209_addresses[chan->scan_index][0];
-		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret)
-			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
-		return IIO_VAL_INT;
-	}
-	return -EINVAL;
-}
-
-static const struct iio_chan_spec adis16209_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
-			 0, 14),
-	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
-			0, 0, 14),
-	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
-			0, 0, 14),
-	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0, 14),
-	IIO_CHAN_SOFT_TIMESTAMP(8)
-};
-
-static const struct iio_info adis16209_info = {
-	.read_raw = adis16209_read_raw,
-	.write_raw = adis16209_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
-};
-
-static const char * const adis16209_status_error_msgs[] = {
-	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
-	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
-	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
-};
-
-static const struct adis_data adis16209_data = {
-	.read_delay = 30,
-	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
-	.glob_cmd_reg = ADIS16209_CMD_REG,
-	.diag_stat_reg = ADIS16209_STAT_REG,
-
-	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
-	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
-
-	.status_error_msgs = adis16209_status_error_msgs,
-	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
-		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
-		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16209_STAT_POWER_LOW_BIT),
-};
-
-static int adis16209_probe(struct spi_device *spi)
-{
-	int ret;
-	struct adis *st;
-	struct iio_dev *indio_dev;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
-
-	indio_dev->name = spi->dev.driver->name;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->info = &adis16209_info;
-	indio_dev->channels = adis16209_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16209_data);
-	if (ret)
-		return ret;
-	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
-	if (ret)
-		return ret;
-
-	ret = adis_initial_startup(st);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-
-	return 0;
-
-error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-	return ret;
-}
-
-static int adis16209_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-
-	return 0;
-}
-
-static struct spi_driver adis16209_driver = {
-	.driver = {
-		.name = "adis16209",
-	},
-	.probe = adis16209_probe,
-	.remove = adis16209_remove,
-};
-module_spi_driver(adis16209_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16209");
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
