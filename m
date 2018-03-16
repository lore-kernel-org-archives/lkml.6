Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230832-2-10941707542600413654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230831; b=tSc+rBodBkyxRm5x4YVNfVdC5RoC7SfTGAgEQLViY/qZadI
    8d4O/Dz6wNfdo/27DZ0aZ6lwvUs6SDNoTipIuT0rHldf57+qR6urTFjz6+4DWjt6
    dBSsyWApX98zcAW45D9FFD2AkkNrw6lryXkGsom0lbABtLNbv8zj0LiV+5sJVVeg
    ECiEQohEh8rT2l/UKoUf7xs/apo2hcufLCuOvpbDObqCf017hBdjRlB4n+/MsaI2
    Dk0e5HNfangh8WII9e7/Vy3qDjNTk47qiEIhDu1p1AglhV0cHpkjxEYwTSs9MR9w
    j9gbPOhvFBPx133ebzXpi4yqneWWEfMKAXvG2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230831; bh=R
    DHwSq2NnP/m6HM+SR71afQNdtSQWvYjWFto/CXzgEM=; b=YrXp0hGSx6e241IVU
    eoGlu7Z8a5n9ho5rFHX018+Qzc6Z82wuXVLQ6INl7YU/pHcLhYqL4brnVNqtxI5z
    WvhkNmfpYs6p/82bZxYkE/2X8ob5+ApRBsb7WlsIa/qkK3DXhei8Dbnha9HfhDjn
    Se3qQCbOMB1dj+yDZjgv56hSWVOBCDY9kYrMcS7j9MhJlzq4RwtcL1x03hbSdr7Z
    3865dvW01ztC2Qm7rHbC6weITi1sRhkHwZVKTdxE7oZF+vQPAVqgoGZ957X2KVec
    HcME4BfzT21aOrIyB0cjRWicH76INM4OwgJiXKmJ+ME/wOvCLJqvnojjGO00tnCB
    BxyRQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iNBlTudj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dgFXfd28;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iNBlTudj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dgFXfd28;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuVVaAlHPvNP2UjEIoMKsX2yx2PzFSX0VKGS7y++TYDWt7Zs3b09JqF9uGIfmatItZU1SLhyQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 3/9] Staging: iio: accel: adis16201: Add _REG suffix to
 reisters
Date: Sat, 17 Mar 2018 01:36:20 +0530
Message-Id: <1521230786-18155-4-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
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
 gregkh@linuxfoundation.org, 21cnbao@gmail.com, linux-kernel@vger.kernel.org,
 Himanshu Jha <himanshujha199640@gmail.com>, pmeerw@pmeerw.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a _REG suffix to distinguish between registers and the register bit
fileds.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -reordered patch series.

 drivers/staging/iio/accel/adis16201.c | 84 +++++++++++++++++------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 6c06c0d..0c63cd0 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -24,62 +24,62 @@
 
 #define ADIS16201_FLASH_CNT      0x00
 
-#define ADIS16201_SUPPLY_OUT     0x02
+#define ADIS16201_SUPPLY_OUT_REG 0x02
 
-#define ADIS16201_XACCL_OUT      0x04
+#define ADIS16201_XACCL_OUT_REG  0x04
 
-#define ADIS16201_YACCL_OUT      0x06
+#define ADIS16201_YACCL_OUT_REG  0x06
 
-#define ADIS16201_AUX_ADC        0x08
+#define ADIS16201_AUX_ADC_REG        0x08
 
-#define ADIS16201_TEMP_OUT       0x0A
+#define ADIS16201_TEMP_OUT_REG       0x0A
 
-#define ADIS16201_XINCL_OUT      0x0C
+#define ADIS16201_XINCL_OUT_REG      0x0C
 
-#define ADIS16201_YINCL_OUT      0x0E
+#define ADIS16201_YINCL_OUT_REG      0x0E
 
-#define ADIS16201_XACCL_OFFS     0x10
+#define ADIS16201_XACCL_OFFS_REG     0x10
 
-#define ADIS16201_YACCL_OFFS     0x12
+#define ADIS16201_YACCL_OFFS_REG     0x12
 
-#define ADIS16201_XACCL_SCALE    0x14
+#define ADIS16201_XACCL_SCALE_REG    0x14
 
-#define ADIS16201_YACCL_SCALE    0x16
+#define ADIS16201_YACCL_SCALE_REG    0x16
 
-#define ADIS16201_XINCL_OFFS     0x18
+#define ADIS16201_XINCL_OFFS_REG     0x18
 
-#define ADIS16201_YINCL_OFFS     0x1A
+#define ADIS16201_YINCL_OFFS_REG     0x1A
 
-#define ADIS16201_XINCL_SCALE    0x1C
+#define ADIS16201_XINCL_SCALE_REG    0x1C
 
-#define ADIS16201_YINCL_SCALE    0x1E
+#define ADIS16201_YINCL_SCALE_REG    0x1E
 
-#define ADIS16201_ALM_MAG1       0x20
+#define ADIS16201_ALM_MAG1_REG       0x20
 
-#define ADIS16201_ALM_MAG2       0x22
+#define ADIS16201_ALM_MAG2_REG       0x22
 
-#define ADIS16201_ALM_SMPL1      0x24
+#define ADIS16201_ALM_SMPL1_REG      0x24
 
-#define ADIS16201_ALM_SMPL2      0x26
+#define ADIS16201_ALM_SMPL2_REG      0x26
 
-#define ADIS16201_ALM_CTRL       0x28
+#define ADIS16201_ALM_CTRL_REG       0x28
 
-#define ADIS16201_AUX_DAC        0x30
+#define ADIS16201_AUX_DAC_REG        0x30
 
-#define ADIS16201_GPIO_CTRL      0x32
+#define ADIS16201_GPIO_CTRL_REG      0x32
 
-#define ADIS16201_MSC_CTRL       0x34
+#define ADIS16201_MSC_CTRL_REG       0x34
 
-#define ADIS16201_SMPL_PRD       0x36
+#define ADIS16201_SMPL_PRD_REG       0x36
 
 /* Operation, filter configuration */
-#define ADIS16201_AVG_CNT        0x38
+#define ADIS16201_AVG_CNT_REG        0x38
 
-#define ADIS16201_SLP_CNT        0x3A
+#define ADIS16201_SLP_CNT_REG        0x3A
 
-#define ADIS16201_DIAG_STAT      0x3C
+#define ADIS16201_DIAG_STAT_REG      0x3C
 
-#define ADIS16201_GLOB_CMD       0x3E
+#define ADIS16201_GLOB_CMD_REG       0x3E
 
 
 #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
@@ -125,10 +125,10 @@ enum adis16201_scan {
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
@@ -232,16 +232,16 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
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
@@ -261,9 +261,9 @@ static const char * const adis16201_status_error_msgs[] = {
 
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
