Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2925832-1520676655-2-16145161000158575829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520676654; b=OWAeA5hFohsUfyZy+MWyIOqxsPPyh2Q10vXKnBRTuuMUelS
    V1FB3Ex2J8uHwmYdHZU3H+sbF1fNmD3d3d2pmydbUi2S9drKB78jQBvPKmicCrLP
    uQMwY38F1cEoyc4esvM2IX+N/fB+LgyqOPLu+gfpzZPwCS6doxjyidhUo5qA31Rc
    3N9gafrVUetG/EZNXqg4jegilQWpcTIK8bKx5X1BPTG1iX2XyarYONKxH9CUvt2r
    j/nvSD3W76qeXoo2TKevywn+Uw5rY6qs0Xg9qZu91plgIDNYBOUJnoWyTTTn6kud
    rJN+5qQ2jcBPd/9hbfByOj+QIgRCLar+yPn30gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520676654; bh=+
    QHMg1u7Eak7JZVGkOxcVGUFtbEvRrffYu0jeUTK3wQ=; b=jIIx0/XSsC9xZnLjV
    imBOtKzV0hy1lodw9cnRndSfesmAkP1txvdlL6p3JuZFGuZGfW2+WEpUmCPChE2q
    NTB6vR9FAIIKWKzq11BaHaWjmBDZKaoOIBY+viviVAM6pDAp9CLh2M5XbXnh+Cs8
    4eDvQso0ZQ+lQb3a9IXjyby2xfxmrFbW5oMuG8MAJfDXpV6e1weJcWyDtLLEhz/g
    qjuRkgIpynM7DjeaLO2OFkvV5k7Frw3nj++IthhRuDt433NruIu9+LRG1atEM/iH
    Svt+62OHPUp04dwKIxmBRLTQRYarSqPPZ8Pdvra5OLHC/EHp9VOUO05EnLjEN7xj
    9qRLA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o+yGdu+D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QpbHOj10;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o+yGdu+D x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QpbHOj10;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsw6qJHe0wBgjgcna2R/TEnroFjRHvX0zcNODNahStAJ7UcjAVCDYV/lWLZ25k8Ze+vHSwKVQ==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH v5] Staging: iio: adis16209: Change some macro names
Date: Sat, 10 Mar 2018 15:40:14 +0530
Message-Id: <1520676614-9556-1-git-send-email-shreeya.patel23498@gmail.com>
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

Make some of the macro names according to the names
given in the datasheet of the adis16209 driver and
have slight indentation in field definitions to make
them clearly different from the register addresses.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v5
  -Re-send the corrected patch.

 drivers/staging/iio/accel/adis16209.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index d8aef9c..ed2e89f 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -68,21 +68,21 @@
 #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
 #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
 
-#define ADIS16209_DIAG_STAT_REG			0x3C
-#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
-#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
-#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
-#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
-#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16209_STAT_REG			0x3C
+#define  ADIS16209_STAT_ALARM2			BIT(9)
+#define  ADIS16209_STAT_ALARM1			BIT(8)
+#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
+#define  ADIS16209_STAT_SPI_FAIL_BIT		3
+#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
 /* Power supply above 3.625 V */
-#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
+#define  ADIS16209_STAT_POWER_HIGH_BIT		1
 /* Power supply below 3.15 V */
-#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
+#define  ADIS16209_STAT_POWER_LOW_BIT		0
 
-#define ADIS16209_GLOB_CMD_REG			0x3E
-#define  ADIS16209_GLOB_CMD_SW_RESET		BIT(7)
-#define  ADIS16209_GLOB_CMD_CLEAR_STAT		BIT(4)
-#define  ADIS16209_GLOB_CMD_FACTORY_CAL		BIT(1)
+#define ADIS16209_CMD_REG			0x3E
+#define  ADIS16209_CMD_SW_RESET			BIT(7)
+#define  ADIS16209_CMD_CLEAR_STAT		BIT(4)
+#define  ADIS16209_CMD_FACTORY_CAL		BIT(1)
 
 #define ADIS16209_ERROR_ACTIVE			BIT(14)
 
@@ -238,29 +238,29 @@ static const struct iio_info adis16209_info = {
 };
 
 static const char * const adis16209_status_error_msgs[] = {
-	[ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
-	[ADIS16209_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16209_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16209_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16209_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
+	[ADIS16209_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
+	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
+	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
+	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
+	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
 };
 
 static const struct adis_data adis16209_data = {
 	.read_delay = 30,
 	.msc_ctrl_reg = ADIS16209_MSC_CTRL_REG,
-	.glob_cmd_reg = ADIS16209_GLOB_CMD_REG,
-	.diag_stat_reg = ADIS16209_DIAG_STAT_REG,
+	.glob_cmd_reg = ADIS16209_CMD_REG,
+	.diag_stat_reg = ADIS16209_STAT_REG,
 
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16209_status_error_msgs,
-	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
-		BIT(ADIS16209_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16209_DIAG_STAT_FLASH_UPT_BIT) |
-		BIT(ADIS16209_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16209_DIAG_STAT_POWER_LOW_BIT),
+	.status_error_mask = BIT(ADIS16209_STAT_SELFTEST_FAIL_BIT) |
+		BIT(ADIS16209_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16209_STAT_FLASH_UPT_FAIL_BIT) |
+		BIT(ADIS16209_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16209_STAT_POWER_LOW_BIT),
 };
 
 static int adis16209_probe(struct spi_device *spi)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
