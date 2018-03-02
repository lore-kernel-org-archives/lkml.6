Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1633200-1519997355-2-2132495823403435140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519997354; b=HB+4f0gWOgP/HkQkVpTYOrWeeUAN9G8ACLvZO2ciLSDfCro
    qem3u0Aq+g0fauXQsx95UQnYO5p/a5ZPBgjgV2dTlWRByM/+tLk89JDxg8v2AAeA
    XkQQ5Wbdl6Uka2BBlAp8z6r8asZwI/HYiBhOb25TNX7GLLQKwRIkCP5exH2y2CG9
    71dnNjDZnOUIaetf6fhj8boLcj4yGt85RiwnAztxKIYQHJ7D5NAcvTeUKzZrkYpm
    To6RZzSdXUiLC+ibhxST9mkpSMK7UJ8qVBPDtXKpJMmaQ7cykg7NPFmstLvLH4Os
    DFh7ksGVVrDAAHB4eemoyVB8hYFDhwM1YQCG0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519997354; bh=u
    Sna3YDI7jp0aTXFAWCnFS0+lbc9rxPQQ40y0ZefcVw=; b=ePDFfRzLZf2X0wak9
    v6H5wEWGXI+GXl4mB6bQMPpViU8pjInVBrVLdRDeuzX7nbc1XRt2CyzhhotZf2LG
    gBUFxtjv/6LU/3V2sA+GV+XmS5L+O+Xu2EHcjGM4qqdJfdr7554Ie2XwL9rWHQc/
    2buwAf8wA2j2Wr+2nyRcPt1d+18QggDkEOGZx5Q6ypE3321pr6OyIlGTBi2qNnvy
    Q/7Agq1tYu7+9oaamy1jn24GTu3tIgD9IIMIEj9ziM3Zd1HjdRk8X397G9ek2QU8
    OeBPeQXnJURm9RQETxzHGlV1nMQtVz2eXM2UXTIk+atImE6PC9SImqU8thcnodhw
    zznsQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DS7iLAuX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oO1Hm/C7;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DS7iLAuX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oO1Hm/C7;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuzQLDU1OevRCmvYuBDYD2IlUuY2wHlx4uYdIL1K/WPYCTtK49ZOwdCHCOSpDIGgXvCZ09csA==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH 4/6] Staging: iio: adis16209: Remove unnecessary comments and
 group the definitions
Date: Fri,  2 Mar 2018 18:58:55 +0530
Message-Id: <9e9bfe51f4ff1bc8555fe5c80d3c23ab7d5c6157.1519995673.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
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

Remove some unnecessay comments and group the control
register and register field macros together.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 116 ++++++----------------------------
 1 file changed, 19 insertions(+), 97 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 151120f..d2d1254 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -21,135 +21,60 @@
 #include <linux/iio/imu/adis.h>
 
 #define ADIS16209_STARTUP_DELAY_MS	220
-
-/* Flash memory write count */
 #define ADIS16209_FLASH_CNT_REG		0x00
 
-/* Output, power supply */
+/* Data Output Register Definitions */
 #define ADIS16209_SUPPLY_OUT_REG	0x02
-
-/* Output, x-axis accelerometer */
 #define ADIS16209_XACCL_OUT_REG		0x04
-
-/* Output, y-axis accelerometer */
 #define ADIS16209_YACCL_OUT_REG		0x06
-
-/* Output, auxiliary ADC input */
 #define ADIS16209_AUX_ADC_REG		0x08
-
-/* Output, temperature */
 #define ADIS16209_TEMP_OUT_REG		0x0A
-
-/* Output, x-axis inclination */
 #define ADIS16209_XINCL_OUT_REG		0x0C
-
-/* Output, y-axis inclination */
 #define ADIS16209_YINCL_OUT_REG		0x0E
-
-/* Output, +/-180 vertical rotational position */
 #define ADIS16209_ROT_OUT_REG		0x10
 
-/* Calibration, x-axis acceleration offset null */
+/* Calibration Register Definitions */
 #define ADIS16209_XACCL_NULL_REG	0x12
-
-/* Calibration, y-axis acceleration offset null */
 #define ADIS16209_YACCL_NULL_REG	0x14
-
-/* Calibration, x-axis inclination offset null */
 #define ADIS16209_XINCL_NULL_REG	0x16
-
-/* Calibration, y-axis inclination offset null */
 #define ADIS16209_YINCL_NULL_REG	0x18
-
-/* Calibration, vertical rotation offset null */
 #define ADIS16209_ROT_NULL_REG		0x1A
 
-/* Alarm 1 amplitude threshold */
+/* Alarm Register Definitions */
 #define ADIS16209_ALM_MAG1_REG		0x20
-
-/* Alarm 2 amplitude threshold */
 #define ADIS16209_ALM_MAG2_REG		0x22
-
-/* Alarm 1, sample period */
 #define ADIS16209_ALM_SMPL1_REG		0x24
-
-/* Alarm 2, sample period */
 #define ADIS16209_ALM_SMPL2_REG		0x26
-
-/* Alarm control */
 #define ADIS16209_ALM_CTRL_REG		0x28
 
-/* Auxiliary DAC data */
 #define ADIS16209_AUX_DAC_REG		0x30
-
-/* General-purpose digital input/output control */
 #define ADIS16209_GPIO_CTRL_REG		0x32
-
-/* Miscellaneous control */
-#define ADIS16209_MSC_CTRL_REG		0x34
-
-/* Internal sample period (rate) control */
 #define ADIS16209_SMPL_PRD_REG		0x36
-
-/* Operation, filter configuration */
 #define ADIS16209_AVG_CNT_REG		0x38
-
-/* Operation, sleep mode control */
 #define ADIS16209_SLP_CNT_REG		0x3A
 
-/* Diagnostics, system status register */
-#define ADIS16209_DIAG_STAT_REG		0x3C
-
-/* Operation, system command register */
-#define ADIS16209_GLOB_CMD_REG		0x3E
-
-/* MSC_CTRL */
-
-/* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
-
-/* Self-test enable */
-#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
+#define ADIS16209_MSC_CTRL_REG			0x34
+#define  ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
+#define  ADIS16209_MSC_CTRL_SELF_TEST_EN	BIT(8)
+#define  ADIS16209_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
+#define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
 
-/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
-#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
-
-/* DIAG_STAT */
-
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
-
-/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
+#define ADIS16209_DIAG_STAT_REG			0x3C
+#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
+#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
 #define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
-
-/* SPI communications failure */
 #define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
-
-/* Flash update failure */
 #define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
-
-/* Power supply above 3.625 V */
 #define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
-
-/* Power supply below 3.15 V */
 #define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
 
-/* GLOB_CMD */
-
-#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
-#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16209_GLOB_CMD_REG			0x3E
+#define  ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
+#define  ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
+#define  ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
 
-#define ADIS16209_ERROR_ACTIVE          BIT(14)
+#define ADIS16209_ERROR_ACTIVE			BIT(14)
 
 enum adis16209_scan {
 	ADIS16209_SCAN_SUPPLY,
@@ -226,7 +151,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 				*val2 = 610500; /* 0.6105 mV */
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = -470; /* -0.47 C */
+			*val = -470;
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
@@ -243,7 +168,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
+		*val = 25000 / -470 - 0x4FE;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
@@ -320,12 +245,10 @@ static int adis16209_probe(struct spi_device *spi)
 	struct adis *st;
 	struct iio_dev *indio_dev;
 
-	/* setup the industrialio driver allocated elements */
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
@@ -342,7 +265,6 @@ static int adis16209_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(st);
 	if (ret)
 		goto error_cleanup_buffer_trigger;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
