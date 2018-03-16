Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230837-2-10097944262249208074
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
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
    t=1521230836; b=HF4pcx4VfwBLqb5rxe9PQ8+ahiF8clKjL3h4zGWkyBoJlAG
    gza4AGo/Z5NqCNZPtVAGMeavqpt42bJ8Rp6CC3KWPGmhFD/Oy44jW07Bgt27uQ6N
    I7gFq+Qr05dVlBCK0qtbcxVRETbJ80rtevRyUv+cncU1wJa3jhzvS9LXWOJR2U+4
    /octkTV2KSqZ7F0rSaFRnWws6T9311wyp/fX8icDoWUOJ3qQzwiITakikaLgCDPe
    WTL5z1NVy373s4b3inqXI9orzv0JZSXKD0WEA53j7bu9veyEbTsY9SOvfoiPXFnL
    qT+Uv9lA2fefb8BXKOjs+WnG87lUASwZQG26/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230836; bh=p
    IAnkQh+dbWVG2A2DGzmtLFC/qUpPPas4qsE+MFc6mo=; b=mQY05WrjSiphnnIJM
    uUn/nYxNX45P9mXKkErO+I+ChXnjQF16ROTdmJ5hadu0Z3f/jMd0guWpxo9KOy4N
    THjx8VvdiGTnKXPLhDe5bi5M+Aezg75b6sPii/A011MhKPRb/ACEd/2HrOl9YkL9
    goALauN+93CDAX9LOBGg7f2DfjN9eiKwhRQZKq7p0curR2/adD4EdcbaInk/ooFb
    f1FQFG/PUBuxX2AtYzwLxFzwdYuVZqxuQVSaYQC6pdY6YBbypJfHSSIeIuhjxXcd
    KIcL/hFw86kHKG3MOERkUG/2mozYIZF/w/oTAWXF1sCOI5XuACUldUp8/ohfk+H2
    UIw0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oJ1tmKSi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WrrSLLYl;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oJ1tmKSi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WrrSLLYl;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvTVeH+9MK7HRhJGcrYTh1VoXCTrU3BEPw8/mcoGCgAZ54IzfkQ7zx19PnpzsQfhtEycP7q2g==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 4/9] Staging: iio: accel: adis16201: Group register
 definitions
Date: Sat, 17 Mar 2018 01:36:21 +0530
Message-Id: <1521230786-18155-5-git-send-email-himanshujha199640@gmail.com>
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

Group register definitions with its register field bits to improve
readability and easy identification. A small comment is also added to
denote the purpose/functionality of the grouped register definitions.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -reordered patch series.

 drivers/staging/iio/accel/adis16201.c | 138 +++++++++++++---------------------
 1 file changed, 54 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0c63cd0..8de3f27 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,99 +20,69 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY_MS	220
-
-#define ADIS16201_FLASH_CNT      0x00
-
-#define ADIS16201_SUPPLY_OUT_REG 0x02
-
-#define ADIS16201_XACCL_OUT_REG  0x04
-
-#define ADIS16201_YACCL_OUT_REG  0x06
-
-#define ADIS16201_AUX_ADC_REG        0x08
-
-#define ADIS16201_TEMP_OUT_REG       0x0A
-
-#define ADIS16201_XINCL_OUT_REG      0x0C
-
-#define ADIS16201_YINCL_OUT_REG      0x0E
-
-#define ADIS16201_XACCL_OFFS_REG     0x10
-
-#define ADIS16201_YACCL_OFFS_REG     0x12
-
-#define ADIS16201_XACCL_SCALE_REG    0x14
-
-#define ADIS16201_YACCL_SCALE_REG    0x16
-
-#define ADIS16201_XINCL_OFFS_REG     0x18
-
-#define ADIS16201_YINCL_OFFS_REG     0x1A
-
-#define ADIS16201_XINCL_SCALE_REG    0x1C
-
-#define ADIS16201_YINCL_SCALE_REG    0x1E
-
-#define ADIS16201_ALM_MAG1_REG       0x20
-
-#define ADIS16201_ALM_MAG2_REG       0x22
-
-#define ADIS16201_ALM_SMPL1_REG      0x24
-
-#define ADIS16201_ALM_SMPL2_REG      0x26
-
-#define ADIS16201_ALM_CTRL_REG       0x28
-
-#define ADIS16201_AUX_DAC_REG        0x30
-
-#define ADIS16201_GPIO_CTRL_REG      0x32
-
-#define ADIS16201_MSC_CTRL_REG       0x34
-
-#define ADIS16201_SMPL_PRD_REG       0x36
-
+#define ADIS16201_STARTUP_DELAY_MS			220
+#define ADIS16201_FLASH_CNT				0x00
+
+/* Data Output Register Information */
+#define ADIS16201_SUPPLY_OUT_REG			0x02
+#define ADIS16201_XACCL_OUT_REG				0x04
+#define ADIS16201_YACCL_OUT_REG				0x06
+#define ADIS16201_AUX_ADC_REG				0x08
+#define ADIS16201_TEMP_OUT_REG				0x0A
+#define ADIS16201_XINCL_OUT_REG				0x0C
+#define ADIS16201_YINCL_OUT_REG				0x0E
+
+/* Calibration Register Definition */
+#define ADIS16201_XACCL_OFFS_REG			0x10
+#define ADIS16201_YACCL_OFFS_REG			0x12
+#define ADIS16201_XACCL_SCALE_REG			0x14
+#define ADIS16201_YACCL_SCALE_REG			0x16
+#define ADIS16201_XINCL_OFFS_REG			0x18
+#define ADIS16201_YINCL_OFFS_REG			0x1A
+#define ADIS16201_XINCL_SCALE_REG			0x1C
+#define ADIS16201_YINCL_SCALE_REG			0x1E
+
+/* Alarm Register Definition */
+#define ADIS16201_ALM_MAG1_REG				0x20
+#define ADIS16201_ALM_MAG2_REG				0x22
+#define ADIS16201_ALM_SMPL1_REG				0x24
+#define ADIS16201_ALM_SMPL2_REG				0x26
+#define ADIS16201_ALM_CTRL_REG				0x28
+
+#define ADIS16201_AUX_DAC_REG				0x30
+#define ADIS16201_GPIO_CTRL_REG				0x32
+#define ADIS16201_SMPL_PRD_REG				0x36
 /* Operation, filter configuration */
-#define ADIS16201_AVG_CNT_REG        0x38
-
-#define ADIS16201_SLP_CNT_REG        0x3A
-
-#define ADIS16201_DIAG_STAT_REG      0x3C
-
-#define ADIS16201_GLOB_CMD_REG       0x3E
-
-
-#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
+#define ADIS16201_AVG_CNT_REG				0x38
+#define ADIS16201_SLP_CNT_REG				0x3A
 
+/* Miscellaneous Control Register Definition */
+#define ADIS16201_MSC_CTRL_REG				0x34
+#define  ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
 /* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
+#define  ADIS16201_MSC_CTRL_DATA_RDY_EN			BIT(2)
 /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
-
+#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	BIT(1)
 /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
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
+#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1		BIT(0)
+
+/* Diagnostics System Status Register Definition */
+#define ADIS16201_DIAG_STAT_REG				0x3C
+#define  ADIS16201_DIAG_STAT_ALARM2			BIT(9)
+#define  ADIS16201_DIAG_STAT_ALARM1			BIT(8)
+#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT		3
+#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
 /* Power supply above 3.625 V */
-#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
-
+#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		1
 /* Power supply below 3.15 V */
-#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
-
+#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		0
 
-#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
+/* System Command Register Definition */
+#define ADIS16201_GLOB_CMD_REG				0x3E
+#define  ADIS16201_GLOB_CMD_SW_RESET			BIT(7)
+#define  ADIS16201_GLOB_CMD_FACTORY_RESET		BIT(1)
 
-#define ADIS16201_ERROR_ACTIVE          BIT(14)
+#define ADIS16201_ERROR_ACTIVE				BIT(14)
 
 enum adis16201_scan {
 	ADIS16201_SCAN_ACC_X,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
