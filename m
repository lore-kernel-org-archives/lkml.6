Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227156-1518436537-2-15151562571448797854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518436537; b=cfAwstboN3KFtdcH1xUkQtQMOMxjB0GktaV6SE9QG/EX+xg
    lIZGuRHPrpN28JK/It5DI/mAt1g2/cxPYnkPTCQsya31IQI3xXwvNydqNlzk/8M2
    MxRtzMeDmEOKApZTuuP35WQnAvs7Mp3Zi1Bij79x19WvsQej+QnJS/gJ/Zif0X9k
    nAmm3zduo5+FVUt3yobMMgbQbh1xyhi4Kf1qlBGwVvpKUnq+SpKjt2Hx5McdwSBB
    93D5KByWVMBFS9eDmJw9voy5PrKeqb9mEtUeZpRKcCDP6Cq36JqVKEXASUZo4yj6
    CXg7phD7zAbet+gMdaVB8uxYZZqU1U+Z9nZ240g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518436537; bh=Q
    fBM8DBB8L1p3KAvgA61h12llRHLLZVfJvNqvmOdIWY=; b=Ew0eUb1sXNLc3oQ6Y
    cGfSiEE7N65aeaMxM+RmLhC+KBnuT2Y59zZiazkM0gSEhfvAwhCsEy78nsjzvA1F
    n9fHZzZ+xRyRa28Ef1eBkqaW8r1AZC+kKmp7HqjTINjUDxR05CBN0r2y6urQf7vo
    OOHqJrEm+peF2bV/bL928oJPtiBqsCTXGLjbOEMphrEbtRUviKd9flRQbgW4CeDU
    kGOm/G11IIOQ3v4sxkdU5xj0iNaqoS/xqktBQv7zcaD5IvuMnbnFmq2bGe1PHuN7
    OSEzoHRMmhCb3tDvXprLSDBHeD5YkK6Ec9RHXDn/+FeLx97fciplsoMhkvfpYOJp
    tDhDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FpAdTZ7/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TzkbrAxz;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FpAdTZ7/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TzkbrAxz;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226nAvZe5Qv/er6b2LXZvldBgSRMJAbcql4IgL10zA0AeGdE4te8tBVMKIXOSdpgR6dYmlOjSw==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Subject: [PATCH 1/4] staging: iio: accel: adis16201: Use SPDX identifier
Date: Mon, 12 Feb 2018 17:24:56 +0530
Message-Id: <1518436499-8584-2-git-send-email-himanshujha199640@gmail.com>
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

Use SPDX identifier format instead of GPLv2. Also, rearrange the headers
in the alphabetical order.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 2ebd275..b2145c9 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -1,19 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
