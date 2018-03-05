Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1088053-1520236215-3-6588656335065986285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520236215; b=ovwTb+dJWEVk6/YkBCk+eqZ3C1v4zr4+MygV0JAPAeppdHb
    H52YkdG7lxywMbbx8EDC9ipUMNaWf9rNf0p0uxedJXFX9/F3Y/qs4ko0RPT7/KhG
    ZdUgTHmGEfakrXkj0nBasp+I+8VqiVCprCb4DIcaoa9swhOHX4qGH17JWppurLcG
    ANy+/1YC63ZZYsf1Uz/YcM2iHC0joqnnrHsURiDTQZujEzgHjo0u/khCxbJ8fBUz
    6F9RIgsy/rpbc5MIqmsEkE35L7izV6S/DYh25wNMlaGtu7SLB+suasPVd/oaD3zG
    l4Nqc2Pu2yXIIJVdj2aQ7qt+g62fLmbJDbrSiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520236215; bh=J
    5TxvmV2uEbn1nL/6w5eo+9ZpxFVprHdmOfemSxrhMs=; b=i81fqTQPyArTYD9QE
    VruUAifAzXeQ9fIOWIohSo2DnN+m1C4eJ4xw7WVjL0MgEgFXRlXD9EGRDNKUiaO0
    6Sf662keNIyHqHX+7t4fC0oXbsQbevyTAtjtKyEGakVRnwg1ZH/qbjvBTgBOSZCp
    zFcby+7ymfp8y2gS/87nqd+o1kSl2wLer/c92sXWF7xdLwkS/v9DXK0RLtNTFcb1
    q+wgeWvd4zmZA6daT7kbGgg9pFkLw9fFJzr7kGP0qzRt547wV5wcFOg4a9wpZLqo
    SnkR3qP74zvLwfwVlS2irBVsm93figr2EIETUiVX64YziQSu9wQPWkNow6GuUqaM
    /MSkw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tii2PzKn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KExR/a+t;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tii2PzKn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KExR/a+t;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuk0saIawEKeiPLx4ML91whBkBoDjLXFCVG6+LMnYFf3dLmmWgurtNVnu4HB7cthD9s7U3Jxg==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 04/11] Staging: iio: accel: Rename few macro definitions
Date: Mon,  5 Mar 2018 13:19:23 +0530
Message-Id: <1520236170-14668-5-git-send-email-himanshujha199640@gmail.com>
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

Rename few macros with appropriate names specifying their usage/function.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 59c1166..445cb56 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,9 +20,8 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY		220
-
-#define ADIS16201_FLASH_CNT      0x00
+#define ADIS16201_STARTUP_DELAY_MS	220
+#define ADIS16201_FLASH_CNT		0x00
 
 /* Data Output Register Information */
 #define ADIS16201_SUPPLY_OUT     0x02
@@ -69,7 +68,7 @@
 
 #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
 
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
+#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
 
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
@@ -80,14 +79,14 @@
 
 #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
 
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
+#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
 
 #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
 
 #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
 
 #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16201_GLOB_CMD_FACTORY	BIT(1)
 
 #define ADIS16201_ERROR_ACTIVE          BIT(14)
 
@@ -231,7 +230,7 @@ static const struct iio_info adis16201_info = {
 
 static const char * const adis16201_status_error_msgs[] = {
 	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
+	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
 	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
 };
@@ -244,11 +243,11 @@ static const struct adis_data adis16201_data = {
 
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
