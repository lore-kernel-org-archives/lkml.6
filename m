Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519997036-2-3404664958229129511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519997035; b=HAfMpa2TqozPm2CpG0x8YRHmBfi9ReSyeol7wueryd9VUIH
    2zB/mrRJjtlU1+iU+0ds+1uhOGtIULsAux/BZYOMlOASLNy+FtE+ns7pSLutIQns
    9IpSstJPTKYdYCq27xITHgUKL6mNzJXWpWrxpc/yGkZzpaa8KF0bi+e+5MDShgkJ
    IfGrtZEhWYpu8vHTzkNH3184g/ChQwIgoG1rgaeumgoJ+6gOOdby3Sm8y+1r9T5K
    V5cV3ObNQ5VZZrk8DFiphNFDEhojVVXG9zoWt0h63tfpYTgzUT0YcZHNA40r5nRs
    a7A92Ue6PKEOvIhkw2KK3MNGsvvEIAJ6AuCGjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519997035; bh=T
    V7PKYrgurlp36G2aNkk7GxlovaloYsoE1QEOvVXgZM=; b=uxXPz1H1cXDyNSnDD
    NJ9tDniIHsDLr74JQOUGiOnTwa8x7zS5CTBInEF+jJM7EH+3E7OZfmcpwJ3hOCk1
    YExHmnIp2ysJuT3bkHEBeUIYq/hKrDf21nCUXqeQUjCjwiNQhbDG8yIV+dxZppJC
    hicN3QJOpkcACeyBEHIiAvpXZOBMrc6T8HfmswIUAV9X7/tA1PFzMx/HP2lOiQKG
    3N0KKsrINssetSxqq/KQ1b/Qll+ZX/+/bz+vza5ZnfQJleNlQ9Fp3mxeBaY3fsJ0
    oIh4tx06hDBEK5n39mK3nBhcAYxAKGxLVLhB3gmmXU+2I58NsHfOJ3exyr3eG8dS
    ef2EQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LMyfi5UM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=twltyPiL;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LMyfi5UM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=twltyPiL;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtrSxFweki/8X9KwSAv0U9T3PwSlqvPHVYIQSTlmXjq24+gBqcBNOLiKmg52cGBvjphLcztlw==
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: [PATCH 2/6] Staging: iio: adis16209: Change the definition name
Date: Fri,  2 Mar 2018 18:53:41 +0530
Message-Id: <646c1e2ac1311db1879a5cae58f5f0a0c07114a5.1519995673.git.shreeya.patel23498@gmail.com>
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

The change in the definition name makes it then obvious
what the units are throughout the driver and there will
be no need of the comment.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 58f604d..830c278 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -20,7 +20,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16209_STARTUP_DELAY	220 /* ms */
+#define ADIS16209_STARTUP_DELAY_MS	220
 
 /* Flash memory write count */
 #define ADIS16209_FLASH_CNT      0x00
@@ -303,7 +303,7 @@ static const struct adis_data adis16209_data = {
 
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16209_STARTUP_DELAY,
+	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16209_status_error_msgs,
 	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
