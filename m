Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C423205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfANWEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:53 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198]:36742 "EHLO
        mail-qk1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfANWEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:49 -0500
Received: by mail-qk1-f198.google.com with SMTP id b185so579504qkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2USd8oylB/AQ6UUFpnCn42bI2ExHUjABVsWVnHn6X0=;
        b=Fzh0nWyUxUsygYW7umW+hqvseGl6Yj92y+LF1/MkTRydWUdtCyTtEtQUw4nSsbzc+n
         eM21TBAchpyP/Ie32un/0CdsslmECIDyAC/9saKovnmm+8fcT7NdvXvq11d/9PDLn9CP
         QLRlUr1lS3vYpBN2K7X8hErlp/j4vZ/0jAlu2yOQTQQAfR5z/qXAupFKGIiMWBRg2NNK
         m1XmcsHbg2DVS4IRnaink2WguV7eVVFQ/lUPToCw1S34hzVtCdY61SiaIJ99dDk9rpSF
         sSZG6hWq2FFlCu/jNuS0wZE09Wb/eQeHae8jXdAWKesSkRpH71OvixWj2xuGBK3gSquB
         mxTg==
X-Gm-Message-State: AJcUukeJ3GItWfbMtj2BVcM6yGc6QLqL47zggEZeivIK8hfl0SAy81YI
        Jw9T/NDK0I/vzVc8yIOES6F21VMWjQmmJnA4oJFlYeBLM3oXw31lq/e8OaghaO5Yzt2ttAdmTAy
        EKXQ+/QxG6+3eXihaCCe4Qs4b1bDjATIuV9noEQx1eYTC8YE+jtdNU0J782s0CAso63QHUWtNw2
        A=
X-Google-Smtp-Source: ALg8bN6cDkWv6dBYD1fnckZlCxOBMXiVKvwps9qgGjI0/75N6Lh9Pf3y+dWlTXtME7PEHcKucjqHJLCmSsyWcHDa
X-Received: by 2002:a37:f517:: with SMTP id l23mr361272qkk.55.1547503487298;
 Mon, 14 Jan 2019 14:04:47 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:03:56 -0700
In-Reply-To: <20190114220356.108916-1-ncrews@google.com>
Message-Id: <20190114220356.108916-10-ncrews@google.com>
Mime-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 9/9] platform/chrome: Add binary telemetry attributes
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dlaurie@chromium.org,
        Nick Crews <ncrews@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes in v2:
- rm "wilco_ec_telemetry - " prefix from docstring
- rm license boiler plate
- Fix commit msg tag

 .../ABI/testing/sysfs-platform-wilcoec        |  6 ++
 drivers/platform/chrome/wilco_ec/Makefile     |  3 +-
 drivers/platform/chrome/wilco_ec/sysfs.c      | 15 ++++-
 drivers/platform/chrome/wilco_ec/telemetry.c  | 66 +++++++++++++++++++
 drivers/platform/chrome/wilco_ec/telemetry.h  | 41 ++++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.h

diff --git a/Documentation/ABI/testing/sysfs-platform-wilcoec b/Documentation/ABI/testing/sysfs-platform-wilcoec
index 2489b9e3fc99..de1fcb1a6b7c 100644
--- a/Documentation/ABI/testing/sysfs-platform-wilcoec
+++ b/Documentation/ABI/testing/sysfs-platform-wilcoec
@@ -168,3 +168,9 @@ Date:		January 2019
 KernelVersion:	4.19
 Description:
 		Enable/disable the Advanced Battery Charging policy
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/telemetry
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Send and receive opaque binary telemetry data to/from the EC.
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 5220a3ff63bd..7a10501123c5 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 wilco_ec-objs				:= core.o mailbox.o sysfs.o legacy.o \
-					   event.o properties.o adv_power.o
+					   event.o properties.o adv_power.o \
+					   telemetry.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index c5657bf7672a..f8c4b0870cf2 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -17,6 +17,7 @@
 #include "legacy.h"
 #include "properties.h"
 #include "adv_power.h"
+#include "telemetry.h"
 
 #define WILCO_EC_ATTR_RO(_name)						\
 __ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
@@ -41,7 +42,19 @@ static struct attribute *wilco_ec_toplevel_attrs[] = {
 #endif
 	NULL
 };
-ATTRIBUTE_GROUPS(wilco_ec_toplevel);
+static struct bin_attribute telem_attr = TELEMETRY_BIN_ATTR(telemetry);
+static struct bin_attribute *telem_attrs[] = {
+	&telem_attr,
+	NULL
+};
+static const struct attribute_group wilco_ec_toplevel_group = {
+	.attrs = wilco_ec_toplevel_attrs,
+	.bin_attrs = telem_attrs,
+};
+static const struct attribute_group *wilco_ec_toplevel_groups[] = {
+	&wilco_ec_toplevel_group,
+	NULL,
+};
 
 /* Make property attributes, which will live inside GOOG000C:00/properties/  */
 BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_global_mic_mute_led,
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
new file mode 100644
index 000000000000..cf3ae92bdab7
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -0,0 +1,66 @@
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
+
+	return count;
+}
+
+ssize_t wilco_ec_telem_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf, loff_t off,
+			    size_t count)
+{
+	memcpy(buf, telemetry_data, min_t(unsigned long, count,
+	       EC_MAILBOX_DATA_SIZE_EXTENDED));
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
2.20.1.97.g81188d93c3-goog

