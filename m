Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520236220-2-13623198872061264371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236219; b=Js+4cNtBsqhxDxLtmHHgjVPR0loCWimPpwEWUz0CHTfeeFi
    Cr0xIENcv55Ka5Krojvtd2zOmRrO9CnspxtgSbUTJjqW5/1RlEN86ov77roOZ2df
    2d0Zf5QDlWVSu3Y0j++0IHqRUEGgdfPiBjANFbLEfTPVFlQv0COEXWThWS2Ni/ZT
    b5B4ztb6hzOKK7TBJ0BGWxG6PxULX45EC7Ysoy8HI0Kux4mk/19f3dnZ2Fv8pbLi
    OWhlovhyoCqvDve0/9ylnKnK+SxlPkvx1Jq/MpCrKLr2SSYC6dIYUY+YHCsuzKf2
    XYt17/l8t2KWOuOa8R9ZvzwMFhhTgBKMR7hfbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236219; bh=o
    X3/tIwHUu5bJHRCbynGcPiel5gUny18dehoAImPSDg=; b=dSXdq4KoFzagH1BmB
    j14Ix5yaMj5xiTwErP79BWdRRla26mjIT95mvZeVh1QyuVhIOtHhv1r0H+yQLV4Z
    thx61CUXlOJ3ivS7XbbzkeMBA5ED86d0Vm6bP1phFBKtnCLK2nKDibM3X1wspEPy
    GBTsqJGQ420yfyopgWgmIKgjb3sJElOUCTicCeJ4Rfxlskj+8O+fl55MabZwrEEC
    q595KnXyZHcgFLMc3deeUfAelg6eP4CkrBCMujXXM5wOqiuRbw7yho7EbmKQXeWP
    S0nxaxey2WDaVCyjm5oXxUPD68Inc2qGLdqyLUK3tn0P7EQzORcRb1Y5HAc4a5W+
    cDHYA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MVuhgJEH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N8k52gw6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MVuhgJEH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N8k52gw6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs+wWkME/Br6PIRSl1Gg8MRz6zenLNLelIELQYCXOtt+JollUqhJwzv2D4BIcBEGPP/L7aF3g==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 05/11] Staging: iio: accel: Add _REG suffix to registers
Date: Mon,  5 Mar 2018 13:19:24 +0530
Message-Id: <1520236170-14668-6-git-send-email-himanshujha199640@gmail.com>
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

Addition of _REG suffix to the register definitions allows a distinction
between registers and register fields. The various registers and its field
bits are grouped together to improve readability and easy indentification.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 133 ++++++++++++++++------------------
 1 file changed, 61 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 445cb56..476b1c3 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,75 +20,64 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY_MS	220
-#define ADIS16201_FLASH_CNT		0x00
+#define ADIS16201_STARTUP_DELAY_MS				220
+#define ADIS16201_FLASH_CNT					0x00
 
 /* Data Output Register Information */
-#define ADIS16201_SUPPLY_OUT     0x02
-#define ADIS16201_XACCL_OUT      0x04
-#define ADIS16201_YACCL_OUT      0x06
-#define ADIS16201_AUX_ADC        0x08
-#define ADIS16201_TEMP_OUT       0x0A
-#define ADIS16201_XINCL_OUT      0x0C
-#define ADIS16201_YINCL_OUT      0x0E
+#define ADIS16201_SUPPLY_OUT_REG				0x02
+#define ADIS16201_XACCL_OUT_REG					0x04
+#define ADIS16201_YACCL_OUT_REG					0x06
+#define ADIS16201_AUX_ADC_REG					0x08
+#define ADIS16201_TEMP_OUT_REG					0x0A
+#define ADIS16201_XINCL_OUT_REG					0x0C
+#define ADIS16201_YINCL_OUT_REG					0x0E
 
 /* Calibration Register Definition */
-#define ADIS16201_XACCL_OFFS     0x10
-#define ADIS16201_YACCL_OFFS     0x12
-#define ADIS16201_XACCL_SCALE    0x14
-#define ADIS16201_YACCL_SCALE    0x16
-#define ADIS16201_XINCL_OFFS     0x18
-#define ADIS16201_YINCL_OFFS     0x1A
-#define ADIS16201_XINCL_SCALE    0x1C
-#define ADIS16201_YINCL_SCALE    0x1E
+#define ADIS16201_XACCL_OFFS_REG				0x10
+#define ADIS16201_YACCL_OFFS_REG				0x12
+#define ADIS16201_XACCL_SCALE_REG				0x14
+#define ADIS16201_YACCL_SCALE_REG				0x16
+#define ADIS16201_XINCL_OFFS_REG				0x18
+#define ADIS16201_YINCL_OFFS_REG				0x1A
+#define ADIS16201_XINCL_SCALE_REG				0x1C
+#define ADIS16201_YINCL_SCALE_REG				0x1E
 
 /* Alarm Register Definition */
-#define ADIS16201_ALM_MAG1       0x20
-#define ADIS16201_ALM_MAG2       0x22
-#define ADIS16201_ALM_SMPL1      0x24
-#define ADIS16201_ALM_SMPL2      0x26
-#define ADIS16201_ALM_CTRL       0x28
-
-#define ADIS16201_AUX_DAC        0x30
-#define ADIS16201_GPIO_CTRL      0x32
-#define ADIS16201_MSC_CTRL       0x34
-
-#define ADIS16201_SMPL_PRD       0x36
-#define ADIS16201_AVG_CNT        0x38
-#define ADIS16201_SLP_CNT        0x3A
+#define ADIS16201_ALM_MAG1_REG					0x20
+#define ADIS16201_ALM_MAG2_REG					0x22
+#define ADIS16201_ALM_SMPL1_REG					0x24
+#define ADIS16201_ALM_SMPL2_REG					0x26
+#define ADIS16201_ALM_CTRL_REG					0x28
+
+#define ADIS16201_AUX_DAC_REG					0x30
+#define ADIS16201_GPIO_CTRL_REG					0x32
+#define ADIS16201_MSC_CTRL_REG					0x34
+#define ADIS16201_SMPL_PRD_REG					0x36
+#define ADIS16201_AVG_CNT_REG					0x38
+#define ADIS16201_SLP_CNT_REG					0x3A
+
+/* Miscellaneous Control Register Definition */
+#define ADIS16201_MSC_CTRL_REG					0x34
+#define  ADIS16201_MSC_CTRL_SELF_TEST_EN			BIT(8)
+#define  ADIS16201_MSC_CTRL_DATA_RDY_EN				BIT(2)
+#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH		BIT(1)
+#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1			BIT(0)
 
 /* Diagnostics, system status register */
-#define ADIS16201_DIAG_STAT      0x3C
+#define ADIS16201_DIAG_STAT_REG					0x3C
+#define  ADIS16201_DIAG_STAT_ALARM2				BIT(9)
+#define  ADIS16201_DIAG_STAT_ALARM1				BIT(8)
+#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT			3
+#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT			2
+#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT			1
+#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT			0
 
 /* Operation, system command register */
-#define ADIS16201_GLOB_CMD       0x3E
-
-
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
-
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
-#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
-
-#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
-
-
-#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
-
-#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
-
-#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
-
-#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
-
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
-
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
-
-#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY	BIT(1)
+#define ADIS16201_GLOB_CMD_REG					0x3E
+#define  ADIS16201_GLOB_CMD_SW_RESET				BIT(7)
+#define  ADIS16201_GLOB_CMD_FACTORY				BIT(1)
 
-#define ADIS16201_ERROR_ACTIVE          BIT(14)
+#define ADIS16201_ERROR_ACTIVE					BIT(14)
 
 enum adis16201_scan {
 	ADIS16201_SCAN_ACC_X,
@@ -101,10 +90,10 @@ enum adis16201_scan {
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
@@ -208,16 +197,16 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
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
@@ -237,9 +226,9 @@ static const char * const adis16201_status_error_msgs[] = {
 
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
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
