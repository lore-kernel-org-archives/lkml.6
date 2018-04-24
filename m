Return-Path: <sjg@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524604275; cv=none;
        d=google.com; s=arc-20160816;
        b=dxgiXHG7tOtey/eYkFBjo6a3TtRwBL3ifsUgLIt1XYUfHfsjCD8tmp7YZ4Tjxp9OhC
         OdXlXeY1e3GBp+ATK0Qc0070Zcdem9EPb4uyPM9yM1pgb7hORU2BhfMYaQbbtM1fxk+V
         wvVIQi0iuGqfjZcfsRkO71k8LF5kf0aeL/3zn9YzxZSC6rNqlae0pSm6y8H7tRLNNot2
         OsoqcOQUxg1RqPWFC+VqjhGlWOzFVjme3tc64NzPIzxUzxe4r18D7CPecABXOIZUdflV
         nBI2/hETtVG025JJLvFQ4HM25f192A9oLA9PbgD9IlRkEUKcrhrFes0es6XRvbaY/ZJE
         GMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=+qXB9x8+2GzlvXaG+IZRT7eiIqNk/l1hrph1AflcS7I=;
        b=HEFXmV3c1C+fKrD660O7zuYFozgx4Mz8K6Wy4kWOrxnr2s3JI9YMeyyRQPnJimZlsy
         zTyty6s95VsyArLTl+oMgWSdz0moHWGyJVgGtV25M3D8SWZTK2o5Q4zMQ8U5/mI78Btm
         CNd+9QzhteUnn6FjsGh1p6PNLB5V+AuKMdu5pusnn8RWzu4CsmrlItcE1n42vrSwhMIq
         Daa1/5dUj0trbHoqvwCN3WLu3J4sgI9WjjGqulOSxYuXhnVEa2FO+l1KrVmVcMuuyT6t
         ltrgyWiozgQBUHcRKXnyNPYq/XobZPWeTKM3BgNqLLmN8CO0SYOWwi0cHvaqgujTnPK+
         mD7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bRWSxw88;
       spf=pass (google.com: domain of sjg@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sjg@google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bRWSxw88;
       spf=pass (google.com: domain of sjg@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sjg@google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZpS/3hkSW7A7kS0xkSk2X2wiJXf045IhMyFleKSrdhJoPYU/6gNLRQwLHUP9v3uGee/KMw9Xg==
Sender: Simon Glass <sjg@google.com>
From: Simon Glass <sjg@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: C Shapiro <shapiroc@chromium.org>,
	Aaron Durbin <adurbin@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alex Hung <alex.hung@canonical.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	sayli karnik <karniksayli1995@gmail.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Subject: [PATCH] firmware: dmi: Add access to the SKU ID string
Date: Tue, 24 Apr 2018 15:11:11 -0600
Message-Id: <20180424211111.140374-1-sjg@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598663453447525196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is used in some systems from user space for determining the identity
of the device.

Expose this as a file so that that user-space tools don't need to read
from /sys/firmware/dmi/tables/DMI

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/firmware/dmi-id.c       | 2 ++
 drivers/firmware/dmi_scan.c     | 1 +
 include/linux/mod_devicetable.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 951b6c79f166a..fe78c7f801163 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -48,6 +48,7 @@ DEFINE_DMI_ATTR_WITH_SHOW(product_version,	0444, DMI_PRODUCT_VERSION);
 DEFINE_DMI_ATTR_WITH_SHOW(product_serial,	0400, DMI_PRODUCT_SERIAL);
 DEFINE_DMI_ATTR_WITH_SHOW(product_uuid,		0400, DMI_PRODUCT_UUID);
 DEFINE_DMI_ATTR_WITH_SHOW(product_family,	0444, DMI_PRODUCT_FAMILY);
+DEFINE_DMI_ATTR_WITH_SHOW(product_sku,		0444, DMI_PRODUCT_SKU);
 DEFINE_DMI_ATTR_WITH_SHOW(board_vendor,		0444, DMI_BOARD_VENDOR);
 DEFINE_DMI_ATTR_WITH_SHOW(board_name,		0444, DMI_BOARD_NAME);
 DEFINE_DMI_ATTR_WITH_SHOW(board_version,	0444, DMI_BOARD_VERSION);
@@ -193,6 +194,7 @@ static void __init dmi_id_init_attr_table(void)
 	ADD_DMI_ATTR(product_serial,    DMI_PRODUCT_SERIAL);
 	ADD_DMI_ATTR(product_uuid,      DMI_PRODUCT_UUID);
 	ADD_DMI_ATTR(product_family,    DMI_PRODUCT_FAMILY);
+	ADD_DMI_ATTR(product_sku,       DMI_PRODUCT_SKU);
 	ADD_DMI_ATTR(board_vendor,      DMI_BOARD_VENDOR);
 	ADD_DMI_ATTR(board_name,        DMI_BOARD_NAME);
 	ADD_DMI_ATTR(board_version,     DMI_BOARD_VERSION);
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 54e66adef2525..f2483548cde92 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -447,6 +447,7 @@ static void __init dmi_decode(const struct dmi_header *dm, void *dummy)
 		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
 		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
 		dmi_save_uuid(dm, DMI_PRODUCT_UUID, 8);
+		dmi_save_ident(dm, DMI_PRODUCT_SKU, 25);
 		dmi_save_ident(dm, DMI_PRODUCT_FAMILY, 26);
 		break;
 	case 2:		/* Base Board Information */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 7d361be2e24f4..cb8487e29d3ae 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -491,6 +491,7 @@ enum dmi_field {
 	DMI_PRODUCT_SERIAL,
 	DMI_PRODUCT_UUID,
 	DMI_PRODUCT_FAMILY,
+	DMI_PRODUCT_SKU,
 	DMI_BOARD_VENDOR,
 	DMI_BOARD_NAME,
 	DMI_BOARD_VERSION,
-- 
2.17.0.484.g0c8726318c-goog
