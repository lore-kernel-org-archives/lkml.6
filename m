Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3509029-1525402456-2-8662670370161277427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525402455; b=bRkss5ej8FZLPz3Dlm+InWpLcUiSJVeZJN0fXXLhz+kZ8ltlxQ
    Kttqs/OPpvDy+Ml5XPOuyZXukg6ax7Wgj57bnYb1d15PCAeuCxX6Yncfj208cp+D
    g4YN5nfcM11MlYO8xo+X2k177zTJ+RyTaH4KbB/zs9dZIUu3gmqxZxqUqgCT00Ny
    ZbMnuR9CQuVUdjD4kMrV+oxHLBTADi9IjcOqjm6J3k4nfcTYWBEDsq68GjqI7eik
    QC3oGImOcyJWIVUgDkR6ekE4lyl8ZAwQIMaN78qAl+UG27uSxYiUIisWKiPgOFHl
    75GfpmzxrjxPWS77zZNC+a+xbYW2pqc9lFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525402455; bh=pMqBS
    vRBipXoOA+mReW9nHb6Zy81I1WgaNUYJsSkaAs=; b=ElQBqlHHeXTICGQndUDO5
    xftlE00uT/LYWxtPiSQaBk5LZFCi+xKKvvsa2akt8zL5sqBWgk7UMQOBavkAfs18
    EP78JThHTYEp1omR0UgwC56uurDw8Ef4/n5zb+8U2Az/9TFE+c5+xzy+uLQfZa22
    fVQXux7VgMJ5+SMMHUZ/llo/04/sIH2A37XmMKjWQrj2KiR8Hjm+w1WqzYVFsOx/
    3szUzU8ma/o8DQMgw6vM+2iAVl3HBLf6kwiEm0jvR7cu2+cDvUMREQBl6Jb+s9Lb
    S+HIhZZu/1pjZ7Ptr5srGuTwy+U8i0bVNYpKYMyqVcB6oFS2E8o+M9qBdP0LvLf/
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=onstation.org header.i=@onstation.org header.b=kMq5y7r+
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=onstation.org
    header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=onstation.org header.i=@onstation.org header.b=kMq5y7r+
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=onstation.org
      header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDfZZ7hnxng3oMTQeBYDDa+BEhyr18aaG6U9pLOzahiE+qx+ZQJiGfRbLJpAtmvG04Y+XVfNMRqzelc6i+aK4X9Xcdv4lAClEXnPlxTr1A1w1BqifMXK
    tk43CueXJjyb/5LBk0+SJcpdzXJJvIJrMEVg/Fpx8vEjWYIinz3iMwXrdz8bPAe3r3817rMJUWSMFuijnzH67+/o9iZ+KT6yHYWnXjzu2fFL3xChaXpvVLf5
    nNPNnkIeDDC7hBmgLEHKKA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=ZsMrO5bvJk-p6YYnrhgA:9 a=cOwgQbRpFzj1FF_y:21 a=CjuIK1q_8ugA:10
    a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 11/11] staging: iio: tsl2x7x/tsl2772: move out of staging
Date: Thu,  3 May 2018 22:53:19 -0400
Message-Id: <20180504025319.28953-12-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 drew.paterson@ams.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the tsl2772 driver out of staging and into mainline.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/Kconfig                                  |  8 ++++++++
 drivers/iio/light/Makefile                                 |  1 +
 drivers/{staging => }/iio/light/tsl2772.c                  |  2 +-
 drivers/staging/iio/Kconfig                                |  1 -
 drivers/staging/iio/Makefile                               |  1 -
 drivers/staging/iio/light/Kconfig                          | 14 --------------
 drivers/staging/iio/light/Makefile                         |  5 -----
 .../iio/light => include/linux/platform_data}/tsl2772.h    |  0
 8 files changed, 10 insertions(+), 22 deletions(-)
 rename drivers/{staging => }/iio/light/tsl2772.c (99%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename {drivers/staging/iio/light => include/linux/platform_data}/tsl2772.h (100%)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 074e50657366..c7ef8d1862d6 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -409,6 +409,14 @@ config TSL2583
 	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
 	 Access ALS data via iio, sysfs.
 
+config TSL2772
+	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
+	depends on I2C
+	help
+	 Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
+	 tmd2672, tsl2772, tmd2772 devices.
+	 Provides iio_events and direct access via sysfs.
+
 config TSL4531
 	tristate "TAOS TSL4531 ambient light sensors"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f1777036d4f8..80943af5d627 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
 obj-$(CONFIG_TCS3414)		+= tcs3414.o
 obj-$(CONFIG_TCS3472)		+= tcs3472.o
 obj-$(CONFIG_TSL2583)		+= tsl2583.o
+obj-$(CONFIG_TSL2772)		+= tsl2772.o
 obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
diff --git a/drivers/staging/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
similarity index 99%
rename from drivers/staging/iio/light/tsl2772.c
rename to drivers/iio/light/tsl2772.c
index 146527e41969..7ed72c98ce1a 100644
--- a/drivers/staging/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -19,7 +19,7 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include "tsl2772.h"
+#include <linux/platform_data/tsl2772.h>
 
 /* Cal defs */
 #define PROX_STAT_CAL			0
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 8abc1ab3c0c7..ca001510782d 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -11,7 +11,6 @@ source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/impedance-analyzer/Kconfig"
-source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
 source "drivers/staging/iio/trigger/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 455bffc29649..5c168403b873 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -10,7 +10,6 @@ obj-y += cdc/
 obj-y += frequency/
 obj-y += gyro/
 obj-y += impedance-analyzer/
-obj-y += light/
 obj-y += meter/
 obj-y += resolver/
 obj-y += trigger/
diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
deleted file mode 100644
index dfa37386ad2c..000000000000
--- a/drivers/staging/iio/light/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-#
-# Light sensors
-#
-menu "Light sensors"
-
-config TSL2772
-	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
-	depends on I2C
-	help
-	 Support for: tsl2571, tsl2671, tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
-	 tmd2672, tsl2772, tmd2772 devices.
-	 Provides iio_events and direct access via sysfs.
-
-endmenu
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
deleted file mode 100644
index e7e77a11f02a..000000000000
--- a/drivers/staging/iio/light/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for industrial I/O Light sensors
-#
-
-obj-$(CONFIG_TSL2772)	+= tsl2772.o
diff --git a/drivers/staging/iio/light/tsl2772.h b/include/linux/platform_data/tsl2772.h
similarity index 100%
rename from drivers/staging/iio/light/tsl2772.h
rename to include/linux/platform_data/tsl2772.h
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
