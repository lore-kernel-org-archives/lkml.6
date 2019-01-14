Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93209C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE66205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfANWE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:28 -0500
Received: from mail-vs1-f69.google.com ([209.85.217.69]:47424 "EHLO
        mail-vs1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfANWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:28 -0500
Received: by mail-vs1-f69.google.com with SMTP id y139so230603vsc.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MXwESgpW0h5exF+bsp70XCY7V6x0NoAqfEcRctyuUuI=;
        b=mXEcuk3XEsxtid+y/in1Fphq3jleHwGlT5+VL823P1fsrm2YUxnjoomYuxUL64uTZv
         k9dFaKn28pjL/PmDwJgHdXX8Tip1Wqqqeb2a6xzoi8Ry0n6cEa6URBj5jXr+gD5fwszX
         67FewBEaX8fEsW9SLXX3lZ0BqGprNdBgl1093wm4Qu5WhNUBmO6l+3Hh2rrrIlOWg3PF
         JQMk5mFmlN80Gdm0G+zPZ1x2votGXYJxtnsBZuYkFUTiJTJfvzY8kgM4LrTrZMLZyfD4
         oRjARf460B5RAR8CZkAVRMYGKp/aTl0N/WM+fDswUISHNYCA+py/jlErmmOGeRF9PnnE
         aP4g==
X-Gm-Message-State: AJcUukf4YjlqdHFJQT2KdSbDH4rQHSb/jVUvhh87omkKpMcUN8nDaMSL
        rHfGsULUfNxZgHaZ9+r7nFzOdOg5ERdjyJzS2lTTeKWoQZuq38mV/y+L84h/99tbD1McHPTje84
        m84/sGYsi2ch2QFYz1UpzVWyxx9GJGHf4aI/sCO37ud2drdNdKR4m6Zs/0Oozg8rZcfmJtnTyH1
        I=
X-Google-Smtp-Source: ALg8bN4kKMae7UYYE1wuInsF2ELm/G7F5O26QVR5O5401HH+tBdMRp3HBB9YvNX/aioeNpBloeXTW0f+dO885uEM
X-Received: by 2002:a67:3d06:: with SMTP id k6mr474929vsa.32.1547503465526;
 Mon, 14 Jan 2019 14:04:25 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:03:50 -0700
In-Reply-To: <20190114220356.108916-1-ncrews@google.com>
Message-Id: <20190114220356.108916-4-ncrews@google.com>
Mime-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 3/9] platform/chrome: Add sysfs attributes
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

Add some sample sysfs attributes for the Wilco EC that show how
the mailbox interface works. "Legacy" attributes are those that
existed in the EC before it was adapted to ChromeOS.

> cat /sys/bus/platform/devices/GOOG000C\:00/version
Label        : 99.99.99
SVN Revision : 738ed.99
Model Number : 08;8
Build Date   : 08/30/18

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

Changes in v2:
- Remove license boiler plate
- Remove "wilco_ec_sysfs -" docstring prefix
- Fix accidental Makefile deletion
- Add documentation for sysfs entries
- Change "enable ? 0 : 1" to "!enable"
- No longer override error code from sysfs_init()
- Put attributes in the legacy file to begin with, don't move later
- Remove duplicate error messages in sysfs_init() and its caller

 .../ABI/testing/sysfs-platform-wilcoec        | 26 ++++++
 drivers/platform/chrome/wilco_ec/Makefile     |  2 +-
 drivers/platform/chrome/wilco_ec/core.c       | 15 +++
 drivers/platform/chrome/wilco_ec/legacy.c     | 91 +++++++++++++++++++
 drivers/platform/chrome/wilco_ec/legacy.h     | 47 ++++++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 66 ++++++++++++++
 include/linux/platform_data/wilco-ec.h        | 14 +++
 7 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilcoec
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.h
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-platform-wilcoec b/Documentation/ABI/testing/sysfs-platform-wilcoec
new file mode 100644
index 000000000000..09552338c160
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-wilcoec
@@ -0,0 +1,26 @@
+What:		/sys/bus/platform/devices/GOOG000C\:00/version
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Display Wilco Embedded Controller version info
+
+		Output will be similar to the example below:
+		Label        : 95.00.06
+		SVN Revision : 5960a.06
+		Model Number : 08;8
+		Build Date   : 11/29/18
+
+		Although this contains multiple pieces of data in a single sysfs
+		attribute (inconsistent with normal sysfs conventions),
+		this format was chosen to be consistent with the version
+		attribute in /sys/class/chomeos/<device>/version
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/stealth_mode
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Turn stealth_mode on or off on EC. Stealth mode means that the
+		various LEDs, the LCD backlight, and onboard speakers are turned
+		off and remain off even if activated from the off state.
+		External monitors connected to the system are not affected.
+		In addition Wireless devices are turned off.
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 03b32301dc61..7965a39e2e7a 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-wilco_ec-objs				:= core.o mailbox.o
+wilco_ec-objs				:= core.o mailbox.o sysfs.o legacy.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 2d1d8d3f9a94..3193e8b2ec91 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -64,11 +64,26 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	cros_ec_lpc_mec_init(ec->io_packet->start,
 			     ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
 
+	/* Create sysfs attributes for userspace interaction */
+	ret = wilco_ec_sysfs_init(ec);
+	if (ret < 0) {
+		dev_err(dev, "Failed to create sysfs attributes\n");
+		goto destroy_lpc_mec;
+	}
 	return 0;
+
+destroy_lpc_mec:
+	cros_ec_lpc_mec_destroy();
+	return ret;
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
 
diff --git a/drivers/platform/chrome/wilco_ec/legacy.c b/drivers/platform/chrome/wilco_ec/legacy.c
new file mode 100644
index 000000000000..1fdf94d22f57
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/legacy.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Legacy (non-Chrome-specific) sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ */
+
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/platform_data/wilco-ec.h>
+
+#include "legacy.h"
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
+ssize_t wilco_ec_version_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
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
+ssize_t wilco_ec_stealth_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
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
+	if (ret) {
+		dev_err(dev, "Unable to parse '%s' to bool", buf);
+		return ret;
+	}
+
+	/* Invert input parameter, EC expects 0=on and 1=off */
+	param = !enable;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
diff --git a/drivers/platform/chrome/wilco_ec/legacy.h b/drivers/platform/chrome/wilco_ec/legacy.h
new file mode 100644
index 000000000000..5c857cb57fa9
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/legacy.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Legacy (non-Chrome-specific) sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ */
+
+#ifndef WILCO_EC_LEGACY_H
+#define WILCO_EC_LEGACY_H
+
+#include <linux/device.h>
+
+#define EC_COMMAND_EC_INFO		0x38
+#define EC_INFO_SIZE			9
+#define EC_COMMAND_STEALTH_MODE		0xfc
+
+/**
+ * wilco_ec_version_show() - Display Wilco Embedded Controller version info
+ *
+ * Output will be similar to the example below:
+ * Label        : 95.00.06
+ * SVN Revision : 5960a.06
+ * Model Number : 08;8
+ * Build Date   : 11/29/18
+ *
+ * Although this contains multiple pieces of data in a single sysfs attribute
+ * (inconsistent with normal sysfs conventions), this format was chosen to be
+ * consistent with the version attribute in ../cros_ec_sysfs.c
+ */
+ssize_t wilco_ec_version_show(struct device *dev, struct device_attribute *attr,
+			      char *buf);
+
+/**
+ * wilco_ec_stealth_mode_store() - Turn stealth_mode on or off on EC
+ * @dev: Device representing the EC
+ * @attr: The attribute in question
+ * @buf: Input buffer, should be parseable by kstrtobool(). Anything parsed to
+ *	 True means enable stealth mode (turn off screen, etc)
+ * @count: Number of bytes in input buffer
+ *
+ * Return: Number of bytes consumed from input, negative error code on failure
+ */
+ssize_t wilco_ec_stealth_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count);
+
+#endif /* WILCO_EC_LEGACY_H */
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
new file mode 100644
index 000000000000..e78a3ec3506b
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sysfs attributes for Wilco Embedded Controller
+ *
+ * Copyright 2018 Google LLC
+ *
+ * The sysfs attributes appear under /sys/bus/platform/devices/GOOG000C\:00/
+ * To actually learn what each attribute does, read the corresponding _show() or
+ * _store() function source.
+ */
+
+#include <linux/ctype.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#include "legacy.h"
+
+#define WILCO_EC_ATTR_RO(_name)						\
+__ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
+
+#define WILCO_EC_ATTR_WO(_name)						\
+__ATTR(_name, 0200, NULL, wilco_ec_##_name##_store)
+
+#define WILCO_EC_ATTR_RW(_name)						\
+__ATTR(_name, 0644, wilco_ec_##_name##_show, wilco_ec_##_name##_store)
+
+/* Make top-level attributes, which will live inside GOOG000C:00/ */
+static struct device_attribute version_attr = WILCO_EC_ATTR_RO(version);
+static struct device_attribute stealth_attr = WILCO_EC_ATTR_WO(stealth_mode);
+static struct attribute *wilco_ec_toplevel_attrs[] = {
+	&version_attr.attr,
+	&stealth_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wilco_ec_toplevel);
+
+/**
+ * wilco_ec_sysfs_init() - Initialize the sysfs directories and attributes
+ * @dev: The device representing the EC
+ *
+ * Creates the sysfs directory structure and populates it with all attributes.
+ * If there is a problem it will clean up the entire filesystem.
+ *
+ * Return 0 on success, -ENOMEM on failure creating directories or attibutes.
+ */
+int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
+{
+	struct device *dev = ec->dev;
+	int ret;
+
+	/* add the top-level attributes */
+	ret = sysfs_create_groups(&dev->kobj, wilco_ec_toplevel_groups);
+	if (ret)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
+{
+	struct device *dev = ec->dev;
+
+	/* go upwards through the directory structure */
+	sysfs_remove_groups(&dev->kobj, wilco_ec_toplevel_groups);
+}
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 5477b8802f81..7c6ab6de7239 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -135,4 +135,18 @@ struct wilco_ec_response {
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
-- 
2.20.1.97.g81188d93c3-goog

