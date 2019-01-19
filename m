Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A1EC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49CB2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P01fC/zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfASAOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:14:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35554 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfASAOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:14:43 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so8157322itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/c4/Iv0gdmINcdL9FFr/Gx7jYVIbDl5QbzWWve07+k=;
        b=P01fC/zqqAj6WdVrpaKRD9Fp903LapjK1xRrpOhThjQAE9vjEsTKyfHXoh7gqHYgj1
         yiaIDS4BafDmp6sHDkSi1m3c2t4NuYmlVDc/OxTGPkMOQ6gmnHm/BsA+eQ/grH/TW440
         5CIwpSIWyHTNl3vkW+TSrEbJD6zdElw6PNKRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/c4/Iv0gdmINcdL9FFr/Gx7jYVIbDl5QbzWWve07+k=;
        b=L/3u8gcl6kF3zjt8YudmSLYXPrXRNBZjpMswceUrZH9hKeLDddsKOuxKRppfp/cs6V
         juv+HNem6r2mxD3dGBZJlnVA52KzAGGGgEHRKWumOnyYVxzWHeA4D3zN7Hnog5EOe/5M
         O06LUwU/vjnEFWI8GN6KcEUWs3H34X/dnq9EVe2TQ72tDd9EkgnGdjBffWRqftHlMbVb
         cREWmBAGxM9Xv6V5q/rDwXORzsoYS0oE0VYDRZQ7o/iC6p2FIPum2l1M8h9vuPVaT423
         J2H3rVb2tcNMxbCXQLTlqfN1vaSDr5yITbCehnZLZgz7cziYa5A0cvfgV4Kc9XNu82qI
         Fd6g==
X-Gm-Message-State: AJcUukfXipkS2VxwvhB4odUXQGI3vdaiNhGuy3FywXC1UZLu6jd4+p3C
        0S9RmGh2MybSJsb0hZ8Qb2kPzXfRuAc=
X-Google-Smtp-Source: ALg8bN5u9u2Kb24C3Cze17sVOk0acVaJcf5irCpBvrh09oFC0LGjmjgn4RdU9p7iFiG8V/QRZj6Drg==
X-Received: by 2002:a24:af0a:: with SMTP id t10mr13224270ite.159.1547856881941;
        Fri, 18 Jan 2019 16:14:41 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id e22sm2382062iod.47.2019.01.18.16.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:14:40 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, djkurtz@google.com,
        dlaurie@chromium.org, Nick Crews <ncrews@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 9/9] platform/chrome: Add binary telemetry attributes
Date:   Fri, 18 Jan 2019 17:14:22 -0700
Message-Id: <20190119001422.48186-10-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190119001422.48186-1-ncrews@chromium.org>
References: <20190119001422.48186-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Crews <ncrews@google.com>

The Wilco Embedded Controller is able to send telemetry data
which is useful for enterprise applications. A daemon running on
the OS sends a command (possibly with args) to the EC via
this sysfs interface, and the EC responds over the sysfs interface
with the response. Both the request and the response are in an opaque
binary format so that information which is proprietary to the
enterprise service provider is secure.

At this point, the Wilco EC does not implement this telemetry
functionality, so any request using the WILCO_EC_MSG_TELEMETRY
command returns an error. This is just an initial change for
comments, until the EC code is implemented.

Signed-off-by: Nick Crews <ncrews@google.com>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v3:
- add err check on returned data size
- add check on read request offset and size

Changes in v2: None

 drivers/platform/chrome/wilco_ec/Makefile    |  2 +-
 drivers/platform/chrome/wilco_ec/core.c      |  2 +-
 drivers/platform/chrome/wilco_ec/sysfs.c     |  7 ++
 drivers/platform/chrome/wilco_ec/telemetry.c | 73 ++++++++++++++++++++
 drivers/platform/chrome/wilco_ec/telemetry.h | 41 +++++++++++
 5 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.h

diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 23378d9469a8..00683c96bf78 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -2,5 +2,5 @@
 
 wilco_ec-objs				:= core.o mailbox.o debugfs.o sysfs.o \
 					   legacy.o event.o properties.o \
-					   adv_power.o
+					   adv_power.o telemetry.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 65588cfcc7a2..a6bda44e30e4 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -90,7 +90,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	 * dev is unregistered.
 	 */
 	child_pdev = platform_device_register_data(dev, "rtc-wilco-ec",
-						   PLATFORM_DEVID_AUTO,
+						   PLATFORM_DEVID_NONE,
 						   NULL, 0);
 	if (IS_ERR(child_pdev)) {
 		dev_err(dev, "Failed to create RTC platform device\n");
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 83de0daef265..f01d782b4c96 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -17,6 +17,7 @@
 #include "legacy.h"
 #include "properties.h"
 #include "adv_power.h"
+#include "telemetry.h"
 
 #define WILCO_EC_ATTR_RO(_name)						\
 __ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
@@ -42,8 +43,14 @@ static struct attribute *wilco_ec_toplevel_attrs[] = {
 	&stealth_attr.attr,
 	NULL
 };
+static struct bin_attribute telem_attr = TELEMETRY_BIN_ATTR(telemetry);
+static struct bin_attribute *telem_attrs[] = {
+	&telem_attr,
+	NULL
+};
 static const struct attribute_group wilco_ec_toplevel_group = {
 	.attrs = wilco_ec_toplevel_attrs,
+	.bin_attrs = telem_attrs,
 };
 static const struct attribute_group *wilco_ec_toplevel_groups[] = {
 	&wilco_ec_toplevel_group,
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
new file mode 100644
index 000000000000..b577a22654cf
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Telemetry sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * The Wilco Embedded Controller is able to send telemetry data
+ * which is useful for enterprise applications. A daemon running on
+ * the OS sends a command (possibly with args) to the EC via
+ * this sysfs interface, and the EC responds over the sysfs interface
+ * with the response. Both the request and the response are in an opaque
+ * binary format so that information which is proprietary to the
+ * enterprise service provider is secure.
+ */
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include "util.h"
+
+/* Data buffer for holding EC's response for telemtry data */
+static u8 telemetry_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+
+ssize_t wilco_ec_telem_write(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf, loff_t loff,
+			     size_t count)
+{
+	struct wilco_ec_message msg;
+	int ret;
+	struct device *dev = device_from_kobject(kobj);
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+
+	if (count < 1 || count > EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EINVAL;
+
+	/* Clear response data buffer */
+	memset(telemetry_data, 0, EC_MAILBOX_DATA_SIZE_EXTENDED);
+
+	msg.type = WILCO_EC_MSG_TELEMETRY;
+	msg.flags = WILCO_EC_FLAG_RAW | WILCO_EC_FLAG_EXTENDED_DATA;
+	msg.command = buf[0];
+	msg.request_data = buf + 1;
+	msg.request_size = EC_MAILBOX_DATA_SIZE;
+	msg.response_data = &telemetry_data;
+	msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+
+	/* Send the requested command + data as raw transaction */
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (ret != EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EBADMSG;
+
+	return count;
+}
+
+ssize_t wilco_ec_telem_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf, loff_t off,
+			    size_t count)
+{
+	if (off)
+		return -EINVAL;
+	if (count != EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EINVAL;
+
+	memcpy(buf, telemetry_data, count);
+
+	return count;
+}
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.h b/drivers/platform/chrome/wilco_ec/telemetry.h
new file mode 100644
index 000000000000..d68cc067b97a
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/telemetry.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Telemetry sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * The Wilco Embedded Controller is able to send telemetry data
+ * which is useful for enterprise applications. A daemon running on
+ * the OS sends a command (possibly with args) to the EC via
+ * this sysfs interface, and the EC responds over the sysfs interface
+ * with the response. Both the request and the response are in an opaque
+ * binary format so that information which is proprietary to the
+ * enterprise service provider is secure.
+ */
+
+#ifndef WILCO_EC_TELEMETRY_H
+#define WILCO_EC_TELEMETRY_H
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+ssize_t wilco_ec_telem_write(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf, loff_t loff,
+			     size_t count);
+
+ssize_t wilco_ec_telem_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf, loff_t off,
+			    size_t count);
+
+#define TELEMETRY_BIN_ATTR(_name) {					\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },		\
+	.size = EC_MAILBOX_DATA_SIZE_EXTENDED,				\
+	.read = wilco_ec_telem_read,					\
+	.write = wilco_ec_telem_write,					\
+}
+
+#endif /* WILCO_EC_TELEMETRY_H */
-- 
2.20.1.321.g9e740568ce-goog

