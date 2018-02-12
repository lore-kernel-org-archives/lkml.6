Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227156-1518436558-2-2789428255008041458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518436557; b=clADenkQRik2qRnAKVgDleT9bs0n8k3LeYFnZu690zo86h8
    HfBRG6Xj1KnGhVD4U5k+8eg4meSejLxmO+fPE1JGLHOWO6caLp1isFnV9YbbP+he
    aa1SsiOHhOFoOFi7IlNGeISlrl0hIr7U5Zh9EiTEqLW56Qp9Zu+ZN6EEs2dmKz5f
    1zVr2bl0z8cfozX94B0Gvz1933QuNi7rKQJB8cCZ6W4KAZg+X+55UUZ4ddQ9sKE5
    JurrLsHnWPeIzvLaxXQztje9RMLAbdIMSJnIe0TLRbEF1mASlpaBhQJlS/eLQZO3
    71YBskshnawhAad/VOn+GTQzvlmcgCLBhrBMF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518436557; bh=G
    QZsP1XDneFSy6N4bKvi70Er/66YT29RO6diWJdrScc=; b=CglfOsVBymIT7ddWX
    vxQ3U2iUnHAIRqAqEHw+5+xbncQAi3V0FfOGDK5J953HFwcjuzofwytJdapRLPkx
    rb5+AoJ4/9e1AnIsIrNG1OwgYROLn+bpTLcCJFZjtgBY3H8XZt7o2SiWfW4w344X
    XGKbiHLlPbR96VcmClywDG37gQTXWfQgG9dzycRYOJcPZrebufwkprKba/XScJSd
    a7N+jhbgPbudgqL3UgO/OcZbcPA6AbE9D1lAmKVsBdeKPE3ukE8RsEgi/EJ18sEP
    53e42K6RZcvhOUxNyT8I2rfSxCQAHi9HozgQzfXctxMp0/IhOg5qwnpaBtPwKUXH
    Sp8oA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cnBiojmX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JAkSQGHN;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cnBiojmX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JAkSQGHN;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2251MowNkvlgXWNOIRH3V1Z476H6veUiM4ecE+tswRUUPgyk+qwhXc8N6IIUSGSJ578oE9ApnA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Subject: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of staging
Date: Mon, 12 Feb 2018 17:24:59 +0530
Message-Id: <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>,
 pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the adis16201 driver out of staging directory and merge to the
mainline IIO directory.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 315 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 315 ----------------------------------
 6 files changed, 328 insertions(+), 328 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index c6d9517..9416c6f 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -5,6 +5,18 @@
 
 menu "Accelerometers"
 
+config ADIS16201
+        tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
+        depends on SPI
+        select IIO_ADIS_LIB
+        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+        help
+          Say Y here to build support for Analog Devices adis16201 dual-axis
+          digital inclinometer and accelerometer.
+
+          To compile this driver as a module, say M here: the module will
+          be called adis16201.
+
 config ADXL345
 	tristate
 
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 368aedb..7832ec9 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_ADIS16201) += adis16201.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
new file mode 100644
index 0000000..6800347
--- /dev/null
+++ b/drivers/iio/accel/adis16201.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
+ *
+ * Copyright 2010 Analog Devices Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
+
+#define ADIS16201_STARTUP_DELAY_MS		220
+#define ADIS16201_FLASH_CNT_REG			0x00
+
+/* Data Output Register Definitions */
+#define ADIS16201_SUPPLY_OUT_REG		0x02
+#define ADIS16201_XACCL_OUT_REG			0x04
+#define ADIS16201_YACCL_OUT_REG			0x06
+#define ADIS16201_AUX_ADC_REG			0x08
+#define ADIS16201_TEMP_OUT_REG			0x0A
+#define ADIS16201_XINCL_OUT_REG			0x0C
+#define ADIS16201_YINCL_OUT_REG			0x0E
+
+/* Calibration Register Definitions */
+#define ADIS16201_XACCL_OFFS_REG		0x10
+#define ADIS16201_YACCL_OFFS_REG		0x12
+#define ADIS16201_XACCL_SCALE_REG		0x14
+#define ADIS16201_YACCL_SCALE_REG		0x16
+#define ADIS16201_XINCL_OFFS_REG		0x18
+#define ADIS16201_YINCL_OFFS_REG		0x1A
+#define ADIS16201_XINCL_SCALE_REG		0x1C
+#define ADIS16201_YINCL_SCALE_REG		0x1E
+
+/* Alarm Register Definitions */
+#define ADIS16201_ALM_MAG1_REG			0x20
+#define ADIS16201_ALM_MAG2_REG			0x22
+#define ADIS16201_ALM_SMPL1_REG			0x24
+#define ADIS16201_ALM_SMPL2_REG			0x26
+#define ADIS16201_ALM_CTRL_REG			0x28
+
+#define ADIS16201_AUX_DAC_REG			0x30
+#define ADIS16201_GPIO_CTRL_REG			0x32
+#define ADIS16201_SMPL_PRD_REG			0x36
+#define ADIS16201_AVG_CNT_REG			0x38
+#define ADIS16201_SLP_CNT_REG			0x3A
+
+/* MSC_CTRL */
+#define ADIS16201_MSC_CTRL_REG			0x34
+#define ADIS16201_MSC_CTRL_SELF_TEST_EN		BIT(8)
+#define ADIS16201_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define ADIS16201_MSC_CTRL_ACTIVE_HIGH		BIT(1)
+#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
+
+/* DIAG_STAT */
+#define ADIS16201_DIAG_STAT_REG			0x3C
+#define ADIS16201_DIAG_STAT_ALARM2		BIT(9)
+#define ADIS16201_DIAG_STAT_ALARM1		BIT(8)
+#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT	3
+#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT	1
+#define ADIS16201_DIAG_STAT_POWER_LOW_BIT	0
+
+/* GLOB_CMD */
+#define ADIS16201_GLOB_CMD_REG			0x3E
+#define ADIS16201_GLOB_CMD_SW_RESET		BIT(7)
+#define ADIS16201_GLOB_CMD_FACTORY_CAL		BIT(1)
+
+#define ADIS16201_ERROR_ACTIVE			BIT(14)
+
+enum adis16201_scan {
+	ADIS16201_SCAN_ACC_X,
+	ADIS16201_SCAN_ACC_Y,
+	ADIS16201_SCAN_INCLI_X,
+	ADIS16201_SCAN_INCLI_Y,
+	ADIS16201_SCAN_SUPPLY,
+	ADIS16201_SCAN_AUX_ADC,
+	ADIS16201_SCAN_TEMP,
+};
+
+static const u8 adis16201_addresses[] = {
+	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
+	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
+};
+
+static int adis16201_read_raw(struct iio_dev *indio_dev,
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
+						ADIS16201_ERROR_ACTIVE, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (chan->channel) {
+			case 0:
+				*val = 1;
+				*val2 = 220000;
+				break;
+			case 1:
+				*val = 0;
+				*val2 = 610000;
+				break;
+			default:
+				return -EINVAL;
+			}
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = -470;
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = IIO_G_TO_M_S_2(462400);
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = 100000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000 / -470 - 1278;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			bits = 12;
+			break;
+		case IIO_INCLI:
+			bits = 9;
+			break;
+		default:
+			return -EINVAL;
+		}
+		addr = adis16201_addresses[chan->scan_index];
+		ret = adis_read_reg_16(st, addr, &val16);
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(val16, bits - 1);
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adis16201_write_raw(struct iio_dev *indio_dev,
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
+			bits = 12;
+			break;
+		case IIO_INCLI:
+			bits = 9;
+			break;
+		default:
+			return -EINVAL;
+		}
+		val16 = val & ((1 << bits) - 1);
+		addr = adis16201_addresses[chan->scan_index];
+		return adis_write_reg_16(st, addr, val16);
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec adis16201_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	IIO_CHAN_SOFT_TIMESTAMP(7)
+};
+
+static const struct iio_info adis16201_info = {
+	.read_raw = adis16201_read_raw,
+	.write_raw = adis16201_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+};
+
+static const char * const adis16201_status_error_msgs[] = {
+	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
+	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
+	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
+	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+};
+
+static const struct adis_data adis16201_data = {
+	.read_delay = 20,
+	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
+	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
+	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
+
+	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
+	.self_test_no_autoclear = true,
+	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
+
+	.status_error_msgs = adis16201_status_error_msgs,
+	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
+};
+
+static int adis16201_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adis *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16201_info;
+
+	indio_dev->channels = adis16201_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis_init(st, indio_dev, spi, &adis16201_data);
+	if (ret)
+		return ret;
+
+	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	if (ret)
+		return ret;
+
+	/* Get the device into a sane initial state */
+	ret = adis_initial_startup(st);
+	if (ret)
+		goto error_cleanup_buffer_trigger;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_cleanup_buffer_trigger;
+
+	return 0;
+
+error_cleanup_buffer_trigger:
+	adis_cleanup_buffer_and_trigger(st, indio_dev);
+
+	return ret;
+}
+
+static int adis16201_remove(struct spi_device *spi)
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
+static struct spi_driver adis16201_driver = {
+	.driver = {
+		.name = "adis16201",
+	},
+	.probe = adis16201_probe,
+	.remove = adis16201_remove,
+};
+module_spi_driver(adis16201_driver);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16201");
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index c6b0f5e..2f61e21 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -3,18 +3,6 @@
 #
 menu "Accelerometers"
 
-config ADIS16201
-	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16201 dual-axis
-	  digital inclinometer and accelerometer.
-
-	  To compile this driver as a module, say M here: the module will
-	  be called adis16201.
-
 config ADIS16203
 	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 5d8ad21..7dd55410 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -2,7 +2,6 @@
 # Makefile for industrial I/O accelerometer drivers
 #
 
-obj-$(CONFIG_ADIS16201) += adis16201.o
 obj-$(CONFIG_ADIS16203) += adis16203.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
deleted file mode 100644
index 6800347..0000000
--- a/drivers/staging/iio/accel/adis16201.c
+++ /dev/null
@@ -1,315 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
- *
- * Copyright 2010 Analog Devices Inc.
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/imu/adis.h>
-
-#define ADIS16201_STARTUP_DELAY_MS		220
-#define ADIS16201_FLASH_CNT_REG			0x00
-
-/* Data Output Register Definitions */
-#define ADIS16201_SUPPLY_OUT_REG		0x02
-#define ADIS16201_XACCL_OUT_REG			0x04
-#define ADIS16201_YACCL_OUT_REG			0x06
-#define ADIS16201_AUX_ADC_REG			0x08
-#define ADIS16201_TEMP_OUT_REG			0x0A
-#define ADIS16201_XINCL_OUT_REG			0x0C
-#define ADIS16201_YINCL_OUT_REG			0x0E
-
-/* Calibration Register Definitions */
-#define ADIS16201_XACCL_OFFS_REG		0x10
-#define ADIS16201_YACCL_OFFS_REG		0x12
-#define ADIS16201_XACCL_SCALE_REG		0x14
-#define ADIS16201_YACCL_SCALE_REG		0x16
-#define ADIS16201_XINCL_OFFS_REG		0x18
-#define ADIS16201_YINCL_OFFS_REG		0x1A
-#define ADIS16201_XINCL_SCALE_REG		0x1C
-#define ADIS16201_YINCL_SCALE_REG		0x1E
-
-/* Alarm Register Definitions */
-#define ADIS16201_ALM_MAG1_REG			0x20
-#define ADIS16201_ALM_MAG2_REG			0x22
-#define ADIS16201_ALM_SMPL1_REG			0x24
-#define ADIS16201_ALM_SMPL2_REG			0x26
-#define ADIS16201_ALM_CTRL_REG			0x28
-
-#define ADIS16201_AUX_DAC_REG			0x30
-#define ADIS16201_GPIO_CTRL_REG			0x32
-#define ADIS16201_SMPL_PRD_REG			0x36
-#define ADIS16201_AVG_CNT_REG			0x38
-#define ADIS16201_SLP_CNT_REG			0x3A
-
-/* MSC_CTRL */
-#define ADIS16201_MSC_CTRL_REG			0x34
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN		BIT(8)
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN		BIT(2)
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH		BIT(1)
-#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
-
-/* DIAG_STAT */
-#define ADIS16201_DIAG_STAT_REG			0x3C
-#define ADIS16201_DIAG_STAT_ALARM2		BIT(9)
-#define ADIS16201_DIAG_STAT_ALARM1		BIT(8)
-#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT	3
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT	2
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT	1
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT	0
-
-/* GLOB_CMD */
-#define ADIS16201_GLOB_CMD_REG			0x3E
-#define ADIS16201_GLOB_CMD_SW_RESET		BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL		BIT(1)
-
-#define ADIS16201_ERROR_ACTIVE			BIT(14)
-
-enum adis16201_scan {
-	ADIS16201_SCAN_ACC_X,
-	ADIS16201_SCAN_ACC_Y,
-	ADIS16201_SCAN_INCLI_X,
-	ADIS16201_SCAN_INCLI_Y,
-	ADIS16201_SCAN_SUPPLY,
-	ADIS16201_SCAN_AUX_ADC,
-	ADIS16201_SCAN_TEMP,
-};
-
-static const u8 adis16201_addresses[] = {
-	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
-	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
-	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
-	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
-};
-
-static int adis16201_read_raw(struct iio_dev *indio_dev,
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
-						ADIS16201_ERROR_ACTIVE, val);
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			switch (chan->channel) {
-			case 0:
-				*val = 1;
-				*val2 = 220000;
-				break;
-			case 1:
-				*val = 0;
-				*val2 = 610000;
-				break;
-			default:
-				return -EINVAL;
-			}
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_TEMP:
-			*val = -470;
-			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_ACCEL:
-			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(462400);
-			return IIO_VAL_INT_PLUS_NANO;
-		case IIO_INCLI:
-			*val = 0;
-			*val2 = 100000;
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ACCEL:
-			bits = 12;
-			break;
-		case IIO_INCLI:
-			bits = 9;
-			break;
-		default:
-			return -EINVAL;
-		}
-		addr = adis16201_addresses[chan->scan_index];
-		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret)
-			return ret;
-
-		*val = sign_extend32(val16, bits - 1);
-		return IIO_VAL_INT;
-	}
-
-	return -EINVAL;
-}
-
-static int adis16201_write_raw(struct iio_dev *indio_dev,
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
-			bits = 12;
-			break;
-		case IIO_INCLI:
-			bits = 9;
-			break;
-		default:
-			return -EINVAL;
-		}
-		val16 = val & ((1 << bits) - 1);
-		addr = adis16201_addresses[chan->scan_index];
-		return adis_write_reg_16(st, addr, val16);
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
-	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
-};
-
-static const struct iio_info adis16201_info = {
-	.read_raw = adis16201_read_raw,
-	.write_raw = adis16201_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
-};
-
-static const char * const adis16201_status_error_msgs[] = {
-	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
-};
-
-static const struct adis_data adis16201_data = {
-	.read_delay = 20,
-	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
-	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
-	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
-
-	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
-	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
-
-	.status_error_msgs = adis16201_status_error_msgs,
-	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
-		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
-};
-
-static int adis16201_probe(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev;
-	struct adis *st;
-	int ret;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
-
-	indio_dev->name = spi->dev.driver->name;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->info = &adis16201_info;
-
-	indio_dev->channels = adis16201_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16201_data);
-	if (ret)
-		return ret;
-
-	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
-	if (ret)
-		return ret;
-
-	/* Get the device into a sane initial state */
-	ret = adis_initial_startup(st);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto error_cleanup_buffer_trigger;
-
-	return 0;
-
-error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-
-	return ret;
-}
-
-static int adis16201_remove(struct spi_device *spi)
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
-static struct spi_driver adis16201_driver = {
-	.driver = {
-		.name = "adis16201",
-	},
-	.probe = adis16201_probe,
-	.remove = adis16201_remove,
-};
-module_spi_driver(adis16201_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16201");
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
