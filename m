Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1250878-1518436545-2-12872045330698651423
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518436544; b=K8kqoSx0OIQxVk5njLzajeTlPc/kPJjVc3+LB/KsfSTY0hG
    GDMRU1H8ZFpB/2UjXlN0tURTUWXVwSh/JAo9+8hi0H1Cn+yEXX12mm5aXQNI8Ou/
    0eDYO55IPCKqBdBOewIjnYCYtnKnWKSmKIac/2rDEuCnmi9nakBAI1b6IHAVmhGC
    CIZfwiAlD6rK/rFgsIKvILGeLTbsOv6tIx+jnRaw9v2YotaC0CDlemPpJVi/wZT0
    gmsfoPT7Vzcv2tSTTNySjFI4EaptEsrCaG83QomjKhHDMjegpuzX97VUgUWmD0hW
    2FKwrocCYM9OHsgaNwAWuGP1YyDDQJIj1JZ7k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518436544; bh=7
    auoPNXdnPc5+drdCo2xG1wpQh7p6A5YrhkZ8C0utvQ=; b=RDAvBu35s9NCgpEab
    L4BD6//Hxzu3qTVxp8nEb7dxrJNCaxI7sMvH0obfjV8uJE7xkSBNTtRiafsCF5pp
    FEZ7xd3Jg9Qy1cW22YPxvJs41BPmfHTYix8qLH46I925si7+0DF3XZg1d7no3skj
    yhgXDmmVabqjidj3rhnz41ncEw6AdBSSw0U2TWhoCMU4lhdyRdsqXeFyRYEtb6xb
    8a20Qr5qHQSE03XaN0M+ReSSsvXRFF8SIzN+Q0G6jUlzhR7TmvNrqZaaqe0cHpVB
    EZ1b3iUHq4WHCbfNl8chJLjDzvRlbZOenslEzHGIrnowh8Wa4+7mdqxCOOu/+psw
    e/EcQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ii7VIUDO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N2fR1+d8;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ii7VIUDO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N2fR1+d8;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226yBdBxwgfZcmv6V6/+2Fk++km9GK5knucUt3OeM3kxcH9ZBkgHrL9GUrHQI+fjb3yf3cDxmQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Subject: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and add
 suitable suffix
Date: Mon, 12 Feb 2018 17:24:57 +0530
Message-Id: <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
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

Remove some unnecessary comments by giving appropriate name to macros.
Therefore, add _REG suffix for control registers. Also, align function
arguments to match open parentheses using tabs.
Group the control register and register field macros together.

Blank line before some returns improves code readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 226 ++++++++++++----------------------
 1 file changed, 79 insertions(+), 147 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index b2145c9..011d2c5 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -19,135 +19,63 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY	220 /* ms */
-
-/* Flash memory write count */
-#define ADIS16201_FLASH_CNT      0x00
-
-/* Output, power supply */
-#define ADIS16201_SUPPLY_OUT     0x02
-
-/* Output, x-axis accelerometer */
-#define ADIS16201_XACCL_OUT      0x04
-
-/* Output, y-axis accelerometer */
-#define ADIS16201_YACCL_OUT      0x06
-
-/* Output, auxiliary ADC input */
-#define ADIS16201_AUX_ADC        0x08
-
-/* Output, temperature */
-#define ADIS16201_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
-#define ADIS16201_XINCL_OUT      0x0C
-
-/* Output, y-axis inclination */
-#define ADIS16201_YINCL_OUT      0x0E
-
-/* Calibration, x-axis acceleration offset */
-#define ADIS16201_XACCL_OFFS     0x10
-
-/* Calibration, y-axis acceleration offset */
-#define ADIS16201_YACCL_OFFS     0x12
-
-/* x-axis acceleration scale factor */
-#define ADIS16201_XACCL_SCALE    0x14
-
-/* y-axis acceleration scale factor */
-#define ADIS16201_YACCL_SCALE    0x16
-
-/* Calibration, x-axis inclination offset */
-#define ADIS16201_XINCL_OFFS     0x18
-
-/* Calibration, y-axis inclination offset */
-#define ADIS16201_YINCL_OFFS     0x1A
-
-/* x-axis inclination scale factor */
-#define ADIS16201_XINCL_SCALE    0x1C
-
-/* y-axis inclination scale factor */
-#define ADIS16201_YINCL_SCALE    0x1E
-
-/* Alarm 1 amplitude threshold */
-#define ADIS16201_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
-#define ADIS16201_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
-#define ADIS16201_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
-#define ADIS16201_ALM_SMPL2      0x26
-
-/* Alarm control */
-#define ADIS16201_ALM_CTRL       0x28
-
-/* Auxiliary DAC data */
-#define ADIS16201_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
-#define ADIS16201_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
-#define ADIS16201_MSC_CTRL       0x34
-
-/* Internal sample period (rate) control */
-#define ADIS16201_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
-#define ADIS16201_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
-#define ADIS16201_SLP_CNT        0x3A
-
-/* Diagnostics, system status register */
-#define ADIS16201_DIAG_STAT      0x3C
-
-/* Operation, system command register */
-#define ADIS16201_GLOB_CMD       0x3E
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
 
 /* MSC_CTRL */
-
-/* Self-test enable */
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
-
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
+#define ADIS16201_MSC_CTRL_REG			0x34
+#define ADIS16201_MSC_CTRL_SELF_TEST_EN		BIT(8)
+#define ADIS16201_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define ADIS16201_MSC_CTRL_ACTIVE_HIGH		BIT(1)
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
 /* DIAG_STAT */
-
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
-
-/* SPI communications failure */
-#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
-
-/* Flash update failure */
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
-
-/* Power supply above 3.625 V */
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
-
-/* Power supply below 3.15 V */
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
+#define ADIS16201_DIAG_STAT_REG			0x3C
+#define ADIS16201_DIAG_STAT_ALARM2		BIT(9)
+#define ADIS16201_DIAG_STAT_ALARM1		BIT(8)
+#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT	3
+#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT	1
+#define ADIS16201_DIAG_STAT_POWER_LOW_BIT	0
 
 /* GLOB_CMD */
+#define ADIS16201_GLOB_CMD_REG			0x3E
+#define ADIS16201_GLOB_CMD_SW_RESET		BIT(7)
+#define ADIS16201_GLOB_CMD_FACTORY_CAL		BIT(1)
 
-#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
-
-#define ADIS16201_ERROR_ACTIVE          BIT(14)
+#define ADIS16201_ERROR_ACTIVE			BIT(14)
 
 enum adis16201_scan {
 	ADIS16201_SCAN_ACC_X,
@@ -160,10 +88,10 @@ enum adis16201_scan {
 };
 
 static const u8 adis16201_addresses[] = {
-	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
-	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
-	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
-	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
+	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
+	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
+	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
 };
 
 static int adis16201_read_raw(struct iio_dev *indio_dev,
@@ -180,36 +108,36 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return adis_single_conversion(indio_dev, chan,
-				ADIS16201_ERROR_ACTIVE, val);
+						ADIS16201_ERROR_ACTIVE, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
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
@@ -226,11 +154,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
+
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
 		return IIO_VAL_INT;
 	}
+
 	return -EINVAL;
 }
 
@@ -261,20 +191,21 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 		addr = adis16201_addresses[chan->scan_index];
 		return adis_write_reg_16(st, addr, val16);
 	}
+
 	return -EINVAL;
 }
 
 static const struct iio_chan_spec adis16201_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
-	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
+	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
+	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
+	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
+	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
+	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
+	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
@@ -294,13 +225,13 @@ static const char * const adis16201_status_error_msgs[] = {
 
 static const struct adis_data adis16201_data = {
 	.read_delay = 20,
-	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
-	.glob_cmd_reg = ADIS16201_GLOB_CMD,
-	.diag_stat_reg = ADIS16201_DIAG_STAT,
+	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
+	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
+	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16201_STARTUP_DELAY,
+	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16201_status_error_msgs,
 	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
@@ -311,17 +242,15 @@ static const struct adis_data adis16201_data = {
 
 static int adis16201_probe(struct spi_device *spi)
 {
-	int ret;
-	struct adis *st;
 	struct iio_dev *indio_dev;
+	struct adis *st;
+	int ret;
 
-	/* setup the industrialio driver allocated elements */
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
@@ -335,6 +264,7 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = adis_init(st, indio_dev, spi, &adis16201_data);
 	if (ret)
 		return ret;
+
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
@@ -347,10 +277,12 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_cleanup_buffer_trigger;
+
 	return 0;
 
 error_cleanup_buffer_trigger:
 	adis_cleanup_buffer_and_trigger(st, indio_dev);
+
 	return ret;
 }
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
