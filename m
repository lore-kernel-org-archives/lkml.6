Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230821-2-18427195661956360766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230820; b=MMbOMMQhTjF86kF8HrRPf2G3TIkzE3XVe2Qbh5qCVdN9G14
    LGyaAte9ETFtIMs8APOWjt8GwHSel2rL6rWMOmYj2aBVEbbn9/JEiWjv1Xx/+6k+
    bJd3ljeZCuCsW3vzEa4u+fgbW1vUvoExXigNPTshlemgNBtNp79c2wYpS680wPRc
    uHQJHKTqHLZM8A0bZVhjzpBVkcM+QdhP2MWPROHDJ2dFJGwT5ek+3xYKOGx3IhHS
    2HY526kYeBUSXkuuBr0YEyhRYSPemZO8u/EMaSHYTOeqPT/ZYrkfZUteH9cMuF0a
    ciqziz6tCfCuFNjivrzv4uivKVBINyICh5UcdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230820; bh=t
    fNj/pvVezWa/k3GHq7G6AeLnUNF2+eNIjlqrX6uH7Y=; b=KD1MsnKul8L6MlJPa
    JFshnxETO9Y8n8jotnZdNfiY6UsHVZsO8pqfMJnSOLHFd0rmH2i91Bce6TLrBPC8
    Gg6/psGR+TyNcUuYyo1spGovEyBw6zC8ARO8hN7/mtvo+CHx0pu0ww7OdIyAWkX3
    jiTX/OJnvGyvGrrurruR7RuFINpSVA2FYqLxoxeFGTE4MjgIfOkHNymNj3eP7bM2
    tpEum43tK8aai5RfWpfdAgOkK9pF6mSqSeiO3ETeDI1OOCerAn73aMfhz+B/y6b0
    jpEyk0ak9V20Uz7/ashwcPuDkDV88SYbSFiq4XIU6P6p/zk5m3684XRvBwFoxEQe
    JFu8Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UPiA34HL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hshV4u4c;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UPiA34HL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hshV4u4c;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsbSk+hJb8h2UVwMt3dkNpCFPiH2VX2cLpZrFTAy0j/S5+KFhiiGvmrjT+LPO/Si1X8WA4PVg==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 1/9] Staging: iio: accel: adis16201: Rename few macro
 definitions
Date: Sat, 17 Mar 2018 01:36:18 +0530
Message-Id: <1521230786-18155-2-git-send-email-himanshujha199640@gmail.com>
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

Rename the macro definitions with suitable names specifying their
purpose.

* ADIS16201_STARTUP_DELAY_MS: Remove the comment specifying the delay in
  microseconds and rename it with addtition of _MS suffix.

* ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH: Rename the macro to make it
  similar to other misc control registers which denotes the data ready
  polarity.

* ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT: Rename to denote it is a
  failure bit.

* ADIS16201_GLOB_CMD_FACTORY_RESET: Remove ambiguous _CAL suffix and add
  _RESET suffix instead to denote factory reset command.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -explained every change in the process of renaming macros. 

 drivers/staging/iio/accel/adis16201.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0fae8aa..767ebf0 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,7 +20,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY	220 /* ms */
+#define ADIS16201_STARTUP_DELAY_MS	220
 
 /* Flash memory write count */
 #define ADIS16201_FLASH_CNT      0x00
@@ -118,7 +118,7 @@
 #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
 
 /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
+#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
 
 /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
@@ -135,7 +135,7 @@
 #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
 
 /* Flash update failure */
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
+#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
 
 /* Power supply above 3.625 V */
 #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
@@ -146,7 +146,7 @@
 /* GLOB_CMD */
 
 #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
 
 #define ADIS16201_ERROR_ACTIVE          BIT(14)
 
@@ -290,7 +290,7 @@ static const struct iio_info adis16201_info = {
 
 static const char * const adis16201_status_error_msgs[] = {
 	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
+	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
 	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
 };
@@ -303,11 +303,11 @@ static const struct adis_data adis16201_data = {
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16201_STARTUP_DELAY,
+	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16201_status_error_msgs,
 	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
 		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
 		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
 };
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
