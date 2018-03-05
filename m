Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520236210-2-6445315273116102525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236209; b=NuyVu69ObNtlUOF9DMSAyw8pKxUaVTD7IWF8JW/Zs115pg2
    YcKHGjvsLePewe9Z1AQwBCUOoUNMIGuIacc5VvHgLT5oNA5YfaN/wXpGYoCQ5OS0
    Whozh6i6yGRdvvB66jGoKGMYn+Yte+nqyGp6bYF88TUJfIKv9Jj3OBnZtHXtwM2B
    AcWeEyBDllHO7fEcybl/Yb1nAw7sRMZgdFTfyozyPEaw9pf1Qrh8Ojn+Yx49qrPg
    n79VcZwmPZXuQWdzabDV5xwHTENC7ld72cBYy5+AWCkvksAsQhoYgVh4/3po3+/9
    vwplR+RD9jFhiHyZd0Rcuf1hx27yvHKlIgANQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236209; bh=w
    fbLzGHEApHXHsCm4galNtFLtzx6gdXpng8ZL3UhQes=; b=goxMCzuBcYBVyrxOL
    pVnB97jp3QODZedEf75jjXtaAL5hsf+n+mZT3NUDAEue/5VbSN0MQaZBwI63UJKz
    KMznAwDmWEXUPfOjeFEM7oxfaCTR2llNOo1v47pbtNZBBZfMolkrdz5P7GLMsBlz
    aeEVdwfdJanfiGpoZi/0aChxor/gVg32ZRN7WGyI+I/cIR6DgKdI3shJxW7ch7I2
    CL4enZQ6Fl6SThY5NsVFCljiT95cCd5hdYlrT8vBfnNxeiwZYrvuExqvJA0TrkEx
    XjzJeDAShea1urkRMdOTnbq4DEOvbb3C1eY+n9vsX3wekoCmP8W/WUp1OR9tsWp0
    iBtYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eBvnqlxa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nkvJO/yb;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eBvnqlxa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nkvJO/yb;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuNpbug4A6ys7SXRrXOhDACtRbuhEgIf+gXxxCcq8JoXopwfcF7MwjcwXnVtd/dxeYmljTCoQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 03/11] Staging: iio: accel: Remove unnecessary comments
Date: Mon,  5 Mar 2018 13:19:22 +0530
Message-Id: <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net, knaack.h@gmx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary comments since the definitions are pretty clear
with their macro names.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 82 +++++------------------------------
 1 file changed, 10 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0fae8aa..59c1166 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,87 +20,42 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY	220 /* ms */
+#define ADIS16201_STARTUP_DELAY		220
 
-/* Flash memory write count */
 #define ADIS16201_FLASH_CNT      0x00
 
-/* Output, power supply */
+/* Data Output Register Information */
 #define ADIS16201_SUPPLY_OUT     0x02
-
-/* Output, x-axis accelerometer */
 #define ADIS16201_XACCL_OUT      0x04
-
-/* Output, y-axis accelerometer */
 #define ADIS16201_YACCL_OUT      0x06
-
-/* Output, auxiliary ADC input */
 #define ADIS16201_AUX_ADC        0x08
-
-/* Output, temperature */
 #define ADIS16201_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
 #define ADIS16201_XINCL_OUT      0x0C
-
-/* Output, y-axis inclination */
 #define ADIS16201_YINCL_OUT      0x0E
 
-/* Calibration, x-axis acceleration offset */
+/* Calibration Register Definition */
 #define ADIS16201_XACCL_OFFS     0x10
-
-/* Calibration, y-axis acceleration offset */
 #define ADIS16201_YACCL_OFFS     0x12
-
-/* x-axis acceleration scale factor */
 #define ADIS16201_XACCL_SCALE    0x14
-
-/* y-axis acceleration scale factor */
 #define ADIS16201_YACCL_SCALE    0x16
-
-/* Calibration, x-axis inclination offset */
 #define ADIS16201_XINCL_OFFS     0x18
-
-/* Calibration, y-axis inclination offset */
 #define ADIS16201_YINCL_OFFS     0x1A
-
-/* x-axis inclination scale factor */
 #define ADIS16201_XINCL_SCALE    0x1C
-
-/* y-axis inclination scale factor */
 #define ADIS16201_YINCL_SCALE    0x1E
 
-/* Alarm 1 amplitude threshold */
+/* Alarm Register Definition */
 #define ADIS16201_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
 #define ADIS16201_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
 #define ADIS16201_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
 #define ADIS16201_ALM_SMPL2      0x26
-
-/* Alarm control */
 #define ADIS16201_ALM_CTRL       0x28
 
-/* Auxiliary DAC data */
 #define ADIS16201_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
 #define ADIS16201_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
 #define ADIS16201_MSC_CTRL       0x34
 
-/* Internal sample period (rate) control */
 #define ADIS16201_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
 #define ADIS16201_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
 #define ADIS16201_SLP_CNT        0x3A
 
 /* Diagnostics, system status register */
@@ -109,42 +64,28 @@
 /* Operation, system command register */
 #define ADIS16201_GLOB_CMD       0x3E
 
-/* MSC_CTRL */
 
-/* Self-test enable */
 #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
 
-/* Data-ready enable: 1 = enabled, 0 = disabled */
 #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
 
-/* Data-ready polarity: 1 = active high, 0 = active low */
 #define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
 
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
-/* DIAG_STAT */
 
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
 
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
 
-/* SPI communications failure */
 #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
 
-/* Flash update failure */
 #define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
 
-/* Power supply above 3.625 V */
 #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
 
-/* Power supply below 3.15 V */
 #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
 
-/* GLOB_CMD */
-
 #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
 #define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
 
@@ -187,30 +128,30 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			if (chan->channel == 0) {
 				*val = 1;
-				*val2 = 220000; /* 1.22 mV */
+				*val2 = 220000;
 			} else {
 				*val = 0;
-				*val2 = 610000; /* 0.610 mV */
+				*val2 = 610000;
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
-			*val = -470; /* 0.47 C */
+			*val = -470;
 			*val2 = 0;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
+			*val2 = IIO_G_TO_M_S_2(462400);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 100000; /* 0.1 degree */
+			*val2 = 100000;
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
+		*val = 25000 / -470 - 1278;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
@@ -318,13 +259,11 @@ static int adis16201_probe(struct spi_device *spi)
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
@@ -343,7 +282,6 @@ static int adis16201_probe(struct spi_device *spi)
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
