Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3849152-1521230827-2-11715329795305109726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 1.1
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230826; b=Bl+Yu8IhK8nxSj9eFkPGtZX6viztSPAnE/dwX8o5L9dz+n6
    20T5lP0giK2b0u4EOURm6nSDcB29dY77Xajb+BfrmSMTT2A4Sp47O/8Nlp3IaHiM
    a8+lpip8UEhu8XnxfQHJ7DLSFfNyN3Qi8kpwxXgXdPkhQHBZr875W2xpghH5rhKU
    2QAyEcNySLQWHHDVlUuUxikn9R3TFrXNQbW+V3zGkMmO9BK/nIvhVHK1Yu2httJF
    a/MiHbc14z/fyXe0uuGQ84hykwDBJ1rqtdZYnsrr8OyCpcyLDYaNSc7ooNLG0GHh
    W2chaoM/dSKPd13AocSR+4W/EGXdHDRlXdtNb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230826; bh=p
    /VUwC8BDGFm82l0RmOWqAf9PE3eKR+FrvtAsnEajdU=; b=UY3xHiLeJXYPOGyf+
    SQEdiVcsngUQN+/ukzTsWxTvdTNkknm7KZG5ZPsarYLJGxlohlgNV7jDJZLBeUoe
    l7x8uaRveuBYsT7gZe9HVL6tvcHbhJAxdxbLQxv/0Ihlf1XTBZkH8LiL7z2e8yKM
    y6M/O+9+SGKCp1Qm+rzvZ6MlFaRh3iGPLX8T11jNtWdI/w+jP6FfplSp5Y+PpZmc
    SZ4JKbBhNMOihGuCVpZcXI1hXemq3mm8dSKx8M+4VYNza9cKe+BOOW3GZsQ34gEa
    g5MxKrXUh7N5nKGs3gNOsDwt8RvdEBMGsMJd0AgVI6t4cVhIpvBKAeP0N2Hbj34d
    e3csg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Iv04PV7y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CrbOu6f1;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Iv04PV7y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CrbOu6f1;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtUt9RKQPJLZdaLUWroZNeaC/khPXC/zTNyEsFuw7/JWt24rfmL7HOMmnugud4OBxW6yjxDDQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Subject: [PATCH v2 2/9] Staging: iio: accel: adis16201: Remove unnecessary
 comments
Date: Sat, 17 Mar 2018 01:36:19 +0530
Message-Id: <1521230786-18155-3-git-send-email-himanshujha199640@gmail.com>
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

Remove few unnecessary comments since the macro definitions clearly
justify their purpose.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -reodered patch series.

 drivers/staging/iio/accel/adis16201.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 767ebf0..6c06c0d 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -22,96 +22,66 @@
 
 #define ADIS16201_STARTUP_DELAY_MS	220
 
-/* Flash memory write count */
 #define ADIS16201_FLASH_CNT      0x00
 
-/* Output, power supply */
 #define ADIS16201_SUPPLY_OUT     0x02
 
-/* Output, x-axis accelerometer */
 #define ADIS16201_XACCL_OUT      0x04
 
-/* Output, y-axis accelerometer */
 #define ADIS16201_YACCL_OUT      0x06
 
-/* Output, auxiliary ADC input */
 #define ADIS16201_AUX_ADC        0x08
 
-/* Output, temperature */
 #define ADIS16201_TEMP_OUT       0x0A
 
-/* Output, x-axis inclination */
 #define ADIS16201_XINCL_OUT      0x0C
 
-/* Output, y-axis inclination */
 #define ADIS16201_YINCL_OUT      0x0E
 
-/* Calibration, x-axis acceleration offset */
 #define ADIS16201_XACCL_OFFS     0x10
 
-/* Calibration, y-axis acceleration offset */
 #define ADIS16201_YACCL_OFFS     0x12
 
-/* x-axis acceleration scale factor */
 #define ADIS16201_XACCL_SCALE    0x14
 
-/* y-axis acceleration scale factor */
 #define ADIS16201_YACCL_SCALE    0x16
 
-/* Calibration, x-axis inclination offset */
 #define ADIS16201_XINCL_OFFS     0x18
 
-/* Calibration, y-axis inclination offset */
 #define ADIS16201_YINCL_OFFS     0x1A
 
-/* x-axis inclination scale factor */
 #define ADIS16201_XINCL_SCALE    0x1C
 
-/* y-axis inclination scale factor */
 #define ADIS16201_YINCL_SCALE    0x1E
 
-/* Alarm 1 amplitude threshold */
 #define ADIS16201_ALM_MAG1       0x20
 
-/* Alarm 2 amplitude threshold */
 #define ADIS16201_ALM_MAG2       0x22
 
-/* Alarm 1, sample period */
 #define ADIS16201_ALM_SMPL1      0x24
 
-/* Alarm 2, sample period */
 #define ADIS16201_ALM_SMPL2      0x26
 
-/* Alarm control */
 #define ADIS16201_ALM_CTRL       0x28
 
-/* Auxiliary DAC data */
 #define ADIS16201_AUX_DAC        0x30
 
-/* General-purpose digital input/output control */
 #define ADIS16201_GPIO_CTRL      0x32
 
-/* Miscellaneous control */
 #define ADIS16201_MSC_CTRL       0x34
 
-/* Internal sample period (rate) control */
 #define ADIS16201_SMPL_PRD       0x36
 
 /* Operation, filter configuration */
 #define ADIS16201_AVG_CNT        0x38
 
-/* Operation, sleep mode control */
 #define ADIS16201_SLP_CNT        0x3A
 
-/* Diagnostics, system status register */
 #define ADIS16201_DIAG_STAT      0x3C
 
-/* Operation, system command register */
 #define ADIS16201_GLOB_CMD       0x3E
 
-/* MSC_CTRL */
 
-/* Self-test enable */
 #define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
 
 /* Data-ready enable: 1 = enabled, 0 = disabled */
@@ -123,18 +93,13 @@
 /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
-/* DIAG_STAT */
 
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
 
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
 #define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
 
-/* SPI communications failure */
 #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
 
-/* Flash update failure */
 #define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
 
 /* Power supply above 3.625 V */
@@ -143,7 +108,6 @@
 /* Power supply below 3.15 V */
 #define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
 
-/* GLOB_CMD */
 
 #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
 #define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
