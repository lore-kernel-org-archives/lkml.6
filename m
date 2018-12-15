Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0D3206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeLOAUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:20:00 -0500
Received: from mail-yw1-f72.google.com ([209.85.161.72]:41405 "EHLO
        mail-yw1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbeLOATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:52 -0500
Received: by mail-yw1-f72.google.com with SMTP id q185so4282714ywf.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DZJrgCGmyVSypGtXKFJ+jFeSAUr0hyqVsiVZYLXeLP8=;
        b=uluHohGaL5AJ6muI/cd3U196OwHCz/hn4KBAVWVZXVBrpqEfyeS6DqYRn7cMurSs7O
         zuhzlpaHxb9XrfqYaFtT+FI1ukri0PCmmU8dvd13ZnTRN9kKMq2n0gpAQ5oMnpwMmkeC
         5ytuKzl21d5nRX67dvMAtP3KGrdr1awjAd8fr0QsgRIu6eRkHaYLsFmJfHNpW/H1dR8u
         QMZTU3LK3iVnPJS/iPJ/d4MTHQ7zWU36VnuDPtfZkIg0XkfyMLpjRXpVS72XH/C0GU6J
         yX+vat0EkXcTdBCHVXQUfRZ7WXW/Xuvzg+aplCfjqGB4x4bYmgww6nJa+TzMXvX3ztf5
         idMw==
X-Gm-Message-State: AA+aEWYRLDFR333tcL7Cw/yuOrB4sziaeKgeCj1Ygm0r023ZHGQdymdf
        tCR+4dJaGagVv+ToQH4AK6SqB7mjQL7l/Ya8vos4h7KQmykxIPR9PezociN25pgqZpusjgnzUO/
        3W1gdOOJy5lYupDWafkor+rtFbWLyKSdbcEAuy3jKq0vJs9GKTM2qPuGEg3htaqV0cs/avUynnG
        8=
X-Google-Smtp-Source: AFSGD/WESibIXsjLnHkuyzfNBHDrbIM2CWK0cZJLDQBmoCTzEpAR+5HxvLNNi1EklbOV26CGAPrhNEdfE3Etydte
X-Received: by 2002:a81:3c45:: with SMTP id j66mr3090021ywa.9.1544833190957;
 Fri, 14 Dec 2018 16:19:50 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:43 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-11-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 10/10] CHROMIUM: wilco_ec: Add binary telemetry attributes
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Crews <ncrews@google.com>, Olof Johansson <olof@lixom.net>,
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

 drivers/platform/chrome/Makefile             |  3 +-
 drivers/platform/chrome/wilco_ec_sysfs.c     | 17 ++++-
 drivers/platform/chrome/wilco_ec_telemetry.c | 66 ++++++++++++++++++++
 drivers/platform/chrome/wilco_ec_telemetry.h | 42 +++++++++++++
 4 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec_telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec_telemetry.h

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index c9d3d44098f9..62444887ce18 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -17,5 +17,6 @@ wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_event.o \
 					   wilco_ec_rtc.o wilco_ec_legacy.o \
 					   wilco_ec_sysfs.o \
 					   wilco_ec_properties.o \
-					   wilco_ec_adv_power.o
+					   wilco_ec_adv_power.o  \
+					   wilco_ec_telemetry.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec_sysfs.c b/drivers/platform/chrome/wilco_ec_sysfs.c
index 81dded951058..0019d17c0cf9 100644
--- a/drivers/platform/chrome/wilco_ec_sysfs.c
+++ b/drivers/platform/chrome/wilco_ec_sysfs.c
@@ -19,6 +19,7 @@
 #include "wilco_ec_legacy.h"
 #include "wilco_ec_properties.h"
 #include "wilco_ec_adv_power.h"
+#include "wilco_ec_telemetry.h"
 
 #define WILCO_EC_ATTR_RO(_name)						\
 __ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
@@ -46,7 +47,21 @@ static struct attribute *wilco_ec_toplevel_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(wilco_ec_toplevel);
+static struct bin_attribute telem_attr = TELEMETRY_BIN_ATTR(telemetry);
+static struct bin_attribute *telem_attrs[] = {
+	&telem_attr,
+	NULL
+};
+
+static const struct attribute_group wilco_ec_toplevel_group = {
+	.attrs = wilco_ec_toplevel_attrs,
+	.bin_attrs = telem_attrs,
+};
+
+static const struct attribute_group *wilco_ec_toplevel_groups[] = {
+	&wilco_ec_toplevel_group,
+	NULL,
+};
 
 /* Make property attributes, which will live inside GOOG000C:00/properties/  */
 
diff --git a/drivers/platform/chrome/wilco_ec_telemetry.c b/drivers/platform/chrome/wilco_ec_telemetry.c
new file mode 100644
index 000000000000..5b8168754b43
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_telemetry.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_legacy - Telemetry sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include "wilco_ec.h"
+#include "wilco_ec_sysfs_util.h"
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
diff --git a/drivers/platform/chrome/wilco_ec_telemetry.h b/drivers/platform/chrome/wilco_ec_telemetry.h
new file mode 100644
index 000000000000..874873284080
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_telemetry.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * wilco_ec_telemetry - Telemetry sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef WILCO_EC_TELEMETRY_H
+#define WILCO_EC_TELEMETRY_H
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include "wilco_ec.h"
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
2.20.0.405.gbc1bbc6f85-goog

