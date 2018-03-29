Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460763-1522315389-2-10666295056771322162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522315387; b=BTnuRg+Rh+oRc2KhBG16MJfLZ3mQ4vAPlaWpxCTbF+q9kq/cCW
    s147C+LK1Oj50EBM+ZpE9cRFllGqPJND649nah1+yaGDNF5RrFG3mvWoRyr2jMeq
    rc5I5UHqQBFQ/TdRPC/z8d6CjUvzeskPBqCZX7bL+SPWW7iSx2YNT2T5o3GxIDpI
    EE1SLvvJ3Ccz1cjhh5jYhLlZwHHnp2k9H5LSY6tsv2pjW4NBteHMalg1jMh+4rG+
    ypKbiItAKmxG8pTBBu5r6/uVfInznUmhsox3yVzofpU8ttGnCpfkZHCS9nKwZ5RZ
    pEzNHRYta+zF3LWaJxcM1TMCvYsmXbkaIgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522315387; bh=ZyJH0
    hFPcli1iUzaNpz07wviIxltPrwVMRsNcaNix5w=; b=SdzgX6ajW/0njIHHCo/U0
    eNxsLRSnIDv3ljn1KVK8vcg4QPfZZVFbILMnildQJiLTaQ/rEZEt9Ha/PNDU6gon
    Pe7Vvo7+hDoOlZ1vJQQRu/zmjeGe+m0WKr2n5MzgGqgF9gm5+QRVAsqtmqybl6Gf
    C0fXkpyxIqzHw9Xl4gewEqeHjWskuHTA8UrIwy4DNL/L4BYyP8Yu62I9TQ6w6ieS
    2s6fwiPiCe2fE/xMvVZHFsbRunls5fTs64BVIxHrAUb1Xf2AfDSQu14AOSSbmHJc
    nHpDe5r1fRj4+SjMtpnbHC5wccQhN9YxIDCiubUIN655r3OMAWN9kIFW4fWnXpb/
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cFFITWdc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r6wtB9d5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cFFITWdc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r6wtB9d5;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLkD3g+eY9jSjLcoLeynzLs5NEHdBF+4yumvaWE9ZkxljFi/eegGsxmOs0gwsozYJzUZn4DudLADnuyj7Mq6FVYnLDM9SfHTys898d8M78doDoaESf6W
    ts4CjJ6jHdb1vOGsfo9olA/iowYwG8HIudaS7vHOVIepY463px8cPAGuE6M8U5jClaWhcAPx2v1IIQFvPrWEGiHAc04rJVGjgDAJBu5v0vxpPChP8LUKYyIH
    dqX1fusOwg4XDft1aEpKwA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MsQ-QqnFFZYA:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=dbVcwzvTv3M-IleO-4kA:9
    a=oPmY6LPmLzY5Znyt:21 a=K7W_1vSGZAWPHknw:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49TbCIkzq5zw5eyHySQKKI342ZPRBbFOAGj430rXNoQmZdR7/Iz+nSFiB4/TxOnwQJIILKfZA==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: [PATCH v6 6/6] Staging: iio: adis16209: Move adis16209 driver out of
 staging
Date: Thu, 29 Mar 2018 14:52:51 +0530
Message-Id: <a578c1a071cacd180d8e123e96add21f8b75db85.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
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

Changes in v6
  -Move driver adis16209 from staging to mainline IIO subsystem
after complete cleanup of it.

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16209.c         | 330 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16209.c | 330 ----------------------------------
 6 files changed, 343 insertions(+), 343 deletions(-)
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
index 0000000..cc50667
--- /dev/null
+++ b/drivers/iio/accel/adis16209.c
@@ -0,0 +1,330 @@
+/*
+ * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/iio.h>
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
+	int m;
+
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
+
+		switch (chan->type) {
+		case IIO_ACCEL:
+		case IIO_INCLI:
+			m = GENMASK(13, 0);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+	return adis_write_reg_16(st, adis16209_addresses[chan->scan_index][0],
+				 val & m);
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
+			switch (chan->channel) {
+			case 0:
+				*val2 = 305180; /* 0.30518 mV */
+				break;
+			case 1:
+				*val2 = 610500; /* 0.6105 mV */
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
+
+		*val = sign_extend32(val16, bits - 1);
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
+	indio_dev->info = &adis16209_info;
+	indio_dev->channels = adis16209_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis_init(st, indio_dev, spi, &adis16209_data);
+	if (ret)
+		return ret;
+
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
index cc50667..0000000
--- a/drivers/staging/iio/accel/adis16209.c
+++ /dev/null
@@ -1,330 +0,0 @@
-/*
- * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
- *
- * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-
-#include <linux/iio/iio.h>
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
-	int m;
-
-	if (mask != IIO_CHAN_INFO_CALIBBIAS)
-		return -EINVAL;
-
-		switch (chan->type) {
-		case IIO_ACCEL:
-		case IIO_INCLI:
-			m = GENMASK(13, 0);
-			break;
-		default:
-			return -EINVAL;
-		}
-
-	return adis_write_reg_16(st, adis16209_addresses[chan->scan_index][0],
-				 val & m);
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
-			switch (chan->channel) {
-			case 0:
-				*val2 = 305180; /* 0.30518 mV */
-				break;
-			case 1:
-				*val2 = 610500; /* 0.6105 mV */
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
-
-		*val = sign_extend32(val16, bits - 1);
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
-	indio_dev->info = &adis16209_info;
-	indio_dev->channels = adis16209_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16209_data);
-	if (ret)
-		return ret;
-
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
