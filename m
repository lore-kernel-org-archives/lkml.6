Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519997169-2-11979246922693178145
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrofr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519997168; b=TLYYSQW2bhNFmaTVkJonwEvS//mNLxRRMfKVerISYCxi6Gj
    iJaa6ZJkOo2x6UsYOhUgEIRzSuTvb9vnYFN6wulnqnL3c+Iqx3ImGfcAbHNcfzo3
    +KW6nd68QvOXPDkbYIE6OryI+IGyqOms1dvCQ0Ub/KUqcBGZEm/IiZPFL1eOE9i4
    W3ssePa+6Yq9+Ia2ngNzIEPeX1q0KDHcxZ752mqr9EBIIWX7P25lAXkjwo4eCQZB
    c7c143Ja+NRhlTWhpV0XUkx1wZwMLEBBdtXiefhuUjrjMu/Sd6uxNHvuXIAA4urS
    UjoTjiVN4Q106vTVqdnn33ZL2fnEv36MS/FhXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519997168; bh=x
    89jsLBytwYaLBRIcWBKl62nGTruVx3GKgwmdhS/Uq4=; b=FXE2NTfG86rwgao2u
    h7Bcx/NZPDPi2uVm6TdQd9K57QAi8ARlJtgh8v6cn39vc4lzBUg9QXm07/meWfXr
    8XM421OelBi8WXBOvAHcG6lwekwsvfoTPnqLBaMuoljRBxaHE3BP6UadLkTREDbX
    GB6epbMVVemnfk/iITAO4akg8Nldvt1aHkLZ5wEQ5nrveqV/CNdxZ3z9yd47fUYg
    qwUZh3UL/FzvQERpEHlsebH/6FCRQ4h+PvNjfN//dkrw+IRuDNsXZX9kvC5CS56I
    BkCM92D+j070m1bQMLltz7JwPddEEkho42ddLX/GIG0UzO4EghBSbnBabxh0YCfl
    SEf+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nHn6sGTi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q56p81su;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nHn6sGTi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q56p81su;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsGYWrxNl8wu0OVgbtTQA+dmDvJOL4R0y83QNsPwcJZ6hClyHZHXeXiDaQu07UiJBsNiH3M4A==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH 3/6] Staging: iio: adis16209: Add _REG postfix for registers
Date: Fri,  2 Mar 2018 18:55:56 +0530
Message-Id: <36a368e0dfc4ddbad460a4af117e088e80441a03.1519995673.git.shreeya.patel23498@gmail.com>
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

The defined names for registers does not make it very
clear that they are registers and hence, add _REG postfix.
This improves the readability of the code.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 85 ++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 830c278..151120f 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -23,85 +23,85 @@
 #define ADIS16209_STARTUP_DELAY_MS	220
 
 /* Flash memory write count */
-#define ADIS16209_FLASH_CNT      0x00
+#define ADIS16209_FLASH_CNT_REG		0x00
 
 /* Output, power supply */
-#define ADIS16209_SUPPLY_OUT     0x02
+#define ADIS16209_SUPPLY_OUT_REG	0x02
 
 /* Output, x-axis accelerometer */
-#define ADIS16209_XACCL_OUT      0x04
+#define ADIS16209_XACCL_OUT_REG		0x04
 
 /* Output, y-axis accelerometer */
-#define ADIS16209_YACCL_OUT      0x06
+#define ADIS16209_YACCL_OUT_REG		0x06
 
 /* Output, auxiliary ADC input */
-#define ADIS16209_AUX_ADC        0x08
+#define ADIS16209_AUX_ADC_REG		0x08
 
 /* Output, temperature */
-#define ADIS16209_TEMP_OUT       0x0A
+#define ADIS16209_TEMP_OUT_REG		0x0A
 
 /* Output, x-axis inclination */
-#define ADIS16209_XINCL_OUT      0x0C
+#define ADIS16209_XINCL_OUT_REG		0x0C
 
 /* Output, y-axis inclination */
-#define ADIS16209_YINCL_OUT      0x0E
+#define ADIS16209_YINCL_OUT_REG		0x0E
 
 /* Output, +/-180 vertical rotational position */
-#define ADIS16209_ROT_OUT        0x10
+#define ADIS16209_ROT_OUT_REG		0x10
 
 /* Calibration, x-axis acceleration offset null */
-#define ADIS16209_XACCL_NULL     0x12
+#define ADIS16209_XACCL_NULL_REG	0x12
 
 /* Calibration, y-axis acceleration offset null */
-#define ADIS16209_YACCL_NULL     0x14
+#define ADIS16209_YACCL_NULL_REG	0x14
 
 /* Calibration, x-axis inclination offset null */
-#define ADIS16209_XINCL_NULL     0x16
+#define ADIS16209_XINCL_NULL_REG	0x16
 
 /* Calibration, y-axis inclination offset null */
-#define ADIS16209_YINCL_NULL     0x18
+#define ADIS16209_YINCL_NULL_REG	0x18
 
 /* Calibration, vertical rotation offset null */
-#define ADIS16209_ROT_NULL       0x1A
+#define ADIS16209_ROT_NULL_REG		0x1A
 
 /* Alarm 1 amplitude threshold */
-#define ADIS16209_ALM_MAG1       0x20
+#define ADIS16209_ALM_MAG1_REG		0x20
 
 /* Alarm 2 amplitude threshold */
-#define ADIS16209_ALM_MAG2       0x22
+#define ADIS16209_ALM_MAG2_REG		0x22
 
 /* Alarm 1, sample period */
-#define ADIS16209_ALM_SMPL1      0x24
+#define ADIS16209_ALM_SMPL1_REG		0x24
 
 /* Alarm 2, sample period */
-#define ADIS16209_ALM_SMPL2      0x26
+#define ADIS16209_ALM_SMPL2_REG		0x26
 
 /* Alarm control */
-#define ADIS16209_ALM_CTRL       0x28
+#define ADIS16209_ALM_CTRL_REG		0x28
 
 /* Auxiliary DAC data */
-#define ADIS16209_AUX_DAC        0x30
+#define ADIS16209_AUX_DAC_REG		0x30
 
 /* General-purpose digital input/output control */
-#define ADIS16209_GPIO_CTRL      0x32
+#define ADIS16209_GPIO_CTRL_REG		0x32
 
 /* Miscellaneous control */
-#define ADIS16209_MSC_CTRL       0x34
+#define ADIS16209_MSC_CTRL_REG		0x34
 
 /* Internal sample period (rate) control */
-#define ADIS16209_SMPL_PRD       0x36
+#define ADIS16209_SMPL_PRD_REG		0x36
 
 /* Operation, filter configuration */
-#define ADIS16209_AVG_CNT        0x38
+#define ADIS16209_AVG_CNT_REG		0x38
 
 /* Operation, sleep mode control */
-#define ADIS16209_SLP_CNT        0x3A
+#define ADIS16209_SLP_CNT_REG		0x3A
 
 /* Diagnostics, system status register */
-#define ADIS16209_DIAG_STAT      0x3C
+#define ADIS16209_DIAG_STAT_REG		0x3C
 
 /* Operation, system command register */
-#define ADIS16209_GLOB_CMD       0x3E
+#define ADIS16209_GLOB_CMD_REG		0x3E
 
 /* MSC_CTRL */
 
@@ -165,10 +165,10 @@ enum adis16209_scan {
 static const u8 adis16209_addresses[8][1] = {
 	[ADIS16209_SCAN_SUPPLY] = { },
 	[ADIS16209_SCAN_AUX_ADC] = { },
-	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL },
-	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL },
-	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL },
-	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL },
+	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL_REG },
+	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL_REG },
+	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL_REG },
+	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL_REG },
 	[ADIS16209_SCAN_ROT] = { },
 	[ADIS16209_SCAN_TEMP] = { },
 };
@@ -266,18 +266,19 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_chan_spec adis16209_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 0, 14),
-	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 0, 12),
-	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
+	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT_REG, ADIS16209_SCAN_SUPPLY,
+			 0, 14),
+	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT_REG, ADIS16209_SCAN_TEMP, 0, 12),
+	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT_REG, ADIS16209_SCAN_ACC_X,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
+	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT_REG, ADIS16209_SCAN_ACC_Y,
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X,
+	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC_REG, ADIS16209_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT_REG, ADIS16209_SCAN_INCLI_X,
 			0, 0, 14),
-	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y,
+	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT_REG, ADIS16209_SCAN_INCLI_Y,
 			0, 0, 14),
-	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 0, 14),
+	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT_REG, ADIS16209_SCAN_ROT, 0, 0, 14),
 	IIO_CHAN_SOFT_TIMESTAMP(8)
 };
 
@@ -297,9 +298,9 @@ static const char * const adis16209_status_error_msgs[] = {
 
 static const struct adis_data adis16209_data = {
 	.read_delay = 30,
-	.msc_ctrl_reg = ADIS16209_MSC_CTRL,
-	.glob_cmd_reg = ADIS16209_GLOB_CMD,
-	.diag_stat_reg = ADIS16209_DIAG_STAT,
+	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
+	.glob_cmd_reg = ADIS16209_GLOB_CMD_REG,
+	.diag_stat_reg = ADIS16209_DIAG_STAT_REG,
 
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
