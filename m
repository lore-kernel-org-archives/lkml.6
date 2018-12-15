Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D574FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1327208F0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeLOATj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:39 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:35538 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeLOATi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:38 -0500
Received: by mail-it1-f200.google.com with SMTP id c128so7717830itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4gZXCPlNa5Axz7t6k4+kiyTERg71KNc3vZr0O804k90=;
        b=LNFV9LAHDdWsfHQYUpmVcKZuGrFZ7OrCVurqci9ejHEzD8sFcTLpEJJibfPUhlptkJ
         5ROnlp+QgSRaIdH/sP6Qz8RAsBIRW6kxBrguTZGx/KRYgtWYqMsHnF4dpiN4CXaby8Hv
         4dphVavbLX/apeTMAM+GrH3JrWq496Z1eVOHr+2nrSJ5Cq4uw50F4RbikC/RlZkw523J
         O7TBUr9PtOwZlXDYOazl//yuqN/3F2X2nkrpdLaWXI7hElh7LvFXLXIAQtjh+fIEnJ7K
         dY7Ox2YSpv53Y/+qyLur/lscL++dfwd6+2IF0+thE2V0CNXpBZRTcoTAAVtXtMmdwsNO
         BnWg==
X-Gm-Message-State: AA+aEWZBvPNrdgA+65I2/eiXBq4SUAoKFC6RSXvPHCkhT0sVq8oO/wCQ
        eXXxuSUoPwuupeln0/4uWBhYLc+ShQTCwu+enBmZsm9v6HoqyJngXL+xHzmNcXp3PIN4K8PC4jY
        KTeaSzJndib/I5rqLLhnCnqPOcWO5XWHVLn4E2w49OK++zq01Doa9bn0RsXgBXZnX6RDgKlJVpc
        g=
X-Google-Smtp-Source: AFSGD/W9nQnMJBy9LvA5tGLW1n2G4BnX5MngdreX2q1rh5NtIjesSRTjvz9BFgI2bT/3siBpVUpK6K7HaaSnmF3O
X-Received: by 2002:a24:7d10:: with SMTP id b16mr4615069itc.23.1544833176570;
 Fri, 14 Dec 2018 16:19:36 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:36 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-4-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 03/10] CHROMIUM: wilco_ec: Add sysfs attributes
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@google.com>, Nick Crews <ncrews@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

Add some sample sysfs attributes for the Wilco EC that show how
the mailbox interface works.

> cat /sys/bus/platform/devices/GOOG000C\:00/version
Label        : 99.99.99
SVN Revision : 738ed.99
Model Number : 08;8
Build Date   : 08/30/18

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Makefile           |   3 +-
 drivers/platform/chrome/wilco_ec.h         |  14 +++
 drivers/platform/chrome/wilco_ec_mailbox.c |  12 ++
 drivers/platform/chrome/wilco_ec_sysfs.c   | 121 +++++++++++++++++++++
 4 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec_sysfs.c

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index b132ba5b3e3d..e8603bc5b095 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -13,6 +13,5 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 
-obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
-wilco_ec-objs				:= wilco_ec_mailbox.o
+wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_sysfs.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome/wilco_ec.h
index ba16fcff87c4..699f4cf744dc 100644
--- a/drivers/platform/chrome/wilco_ec.h
+++ b/drivers/platform/chrome/wilco_ec.h
@@ -94,4 +94,18 @@ struct wilco_ec_message {
  */
 int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
 
+/**
+ * wilco_ec_sysfs_init() - Create sysfs attributes.
+ * @ec: EC device.
+ *
+ * Return: 0 for success or negative error code on failure.
+ */
+int wilco_ec_sysfs_init(struct wilco_ec_device *ec);
+
+/**
+ * wilco_ec_sysfs_remove() - Remove sysfs attributes.
+ * @ec: EC device.
+ */
+void wilco_ec_sysfs_remove(struct wilco_ec_device *ec);
+
 #endif /* WILCO_EC_H */
diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platform/chrome/wilco_ec_mailbox.c
index 6613c18c2a82..414ea0a8ad03 100644
--- a/drivers/platform/chrome/wilco_ec_mailbox.c
+++ b/drivers/platform/chrome/wilco_ec_mailbox.c
@@ -361,11 +361,23 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	cros_ec_lpc_mec_init(ec->io_packet->start,
 			     ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
 
+	/* Create sysfs attributes for userspace interaction */
+	if (wilco_ec_sysfs_init(ec) < 0) {
+		dev_err(dev, "Failed to create sysfs attributes\n");
+		cros_ec_lpc_mec_destroy();
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
 static int wilco_ec_remove(struct platform_device *pdev)
 {
+	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
+
+	/* Remove sysfs attributes */
+	wilco_ec_sysfs_remove(ec);
+
 	/* Teardown cros_ec interface */
 	cros_ec_lpc_mec_destroy();
 
diff --git a/drivers/platform/chrome/wilco_ec_sysfs.c b/drivers/platform/chrome/wilco_ec_sysfs.c
new file mode 100644
index 000000000000..f9ae6cef6169
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_sysfs.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_sysfs - Sysfs attributes for Wilco Embedded Controller
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
+#include <linux/ctype.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+#include "wilco_ec.h"
+
+#define EC_COMMAND_EC_INFO		0x38
+#define EC_INFO_SIZE			 9
+#define EC_COMMAND_STEALTH_MODE		0xfc
+
+struct ec_info {
+	u8 index;
+	const char *label;
+};
+
+static ssize_t wilco_ec_show_info(struct wilco_ec_device *ec, char *buf,
+				  ssize_t count, struct ec_info *info)
+{
+	char result[EC_INFO_SIZE];
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.command = EC_COMMAND_EC_INFO,
+		.request_data = &info->index,
+		.request_size = sizeof(info->index),
+		.response_data = result,
+		.response_size = EC_INFO_SIZE,
+	};
+	int ret;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret != EC_INFO_SIZE)
+		return scnprintf(buf + count, PAGE_SIZE - count,
+				 "%-12s : ERROR %d\n", info->label, ret);
+
+	return scnprintf(buf + count, PAGE_SIZE - count,
+			 "%-12s : %s\n", info->label, result);
+}
+
+static ssize_t version_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct ec_info wilco_ec_info[] = {
+		{ 0, "Label" },
+		{ 1, "SVN Revision" },
+		{ 2, "Model Number" },
+		{ 3, "Build Date" },
+		{ 0xff, NULL },
+	};
+	struct ec_info *info = wilco_ec_info;
+	ssize_t c = 0;
+
+	for (info = wilco_ec_info; info->label; info++)
+		c += wilco_ec_show_info(ec, buf, c, info);
+
+	return c;
+}
+
+static ssize_t stealth_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	u8 param;
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.command = EC_COMMAND_STEALTH_MODE,
+		.request_data = &param,
+		.request_size = sizeof(param),
+	};
+	int ret;
+	bool enable;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	/* Invert input parameter, EC expects 0=on and 1=off */
+	param = enable ? 0 : 1;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(version);
+static DEVICE_ATTR_WO(stealth_mode);
+
+static struct attribute *wilco_ec_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_stealth_mode.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wilco_ec);
+
+int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
+{
+	return sysfs_create_groups(&ec->dev->kobj, wilco_ec_groups);
+}
+
+void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
+{
+	sysfs_remove_groups(&ec->dev->kobj, wilco_ec_groups);
+}
-- 
2.20.0.405.gbc1bbc6f85-goog

