Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D4C61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2452087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KDr+HHSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfASAOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:14:40 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:32876 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbfASAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:14:36 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so2250779itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zo4uuBgxdUgNFs//yNasRwYzEnKisGYDnUla5Wq9OUA=;
        b=KDr+HHSLMwOWvG9yK7k5USoWE510Oblo6hlJFxlqBUorivvQSpQneUmlxAUHenJazb
         1N2HojBbhpG2kc5xU23CHHGtIZP0czVEE09uwSg8abaNA7Sw/+FWBqEJ0PbtG6AA0GNf
         8k++tlF1PB+qOXvBGBdMjSzeOAHE+585INxjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zo4uuBgxdUgNFs//yNasRwYzEnKisGYDnUla5Wq9OUA=;
        b=gVyJNjNctbPqzpf9ASIfj3cto7L0lnBCXtNLM6m0MzYp/myi2PzI+J+tvaXGqvH3S9
         rRxVtqYvmYagVNI/NL/scH4d8KbeTSLNQ3AJ4oO4+fa+eueUm+TE1k7YyNfoplIL2FSS
         C8j6Q3N6sl47BQWQ8rkbJ44Xl2ACeC+xteXQCxSCp+K+qqzF6iC2H/xmGuddWk4sR6zx
         DOxUDFjq/ldJGDcxjv11sHCt73O22uWPNkw/cgwkgHUad1UP92i/VQ8J7rKsTCm6AJqL
         0x3IEF9m1/X0Xm7II5Ple3TweWcVCR2mzQvMEkO2QnT2+jSENuSgwmQoqOxxlJIymiu8
         LPJg==
X-Gm-Message-State: AJcUukdhM7NOQR9WHDUMQvlOvkGp0O1gl7WjzXPlczdu2G6VnhfgStYo
        Zmn6u+VjeXtD5FB/rZ6ldtIN0CwUic4=
X-Google-Smtp-Source: ALg8bN6bezlEVWy6222Kmcrw/Kj3dRrZrR6xxKkAkxPVOI1um6Ja+XcCyn9C0jLxVfOSnGb4PLYYEg==
X-Received: by 2002:a02:b015:: with SMTP id p21mr12517945jah.17.1547856875094;
        Fri, 18 Jan 2019 16:14:35 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id e22sm2382062iod.47.2019.01.18.16.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:14:34 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, djkurtz@google.com,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 4/9] platform/chrome: Add sysfs attributes
Date:   Fri, 18 Jan 2019 17:14:17 -0700
Message-Id: <20190119001422.48186-5-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190119001422.48186-1-ncrews@chromium.org>
References: <20190119001422.48186-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v3:
- explicitly define toplevel_groups from the start,
so adding telem later makes sense
- Break version attribute into individual attributes
- rm unused WILCO_EC_ATTR_RW macro
- Moved some #defines from legacy.h to legacy.c

Changes in v2:
- Remove license boiler plate
- Remove "wilco_ec_sysfs -" docstring prefix
- Fix accidental Makefile deletion
- Add documentation for sysfs entries
- Change "enable ? 0 : 1" to "!enable"
- No longer override error code from sysfs_init()
- Put attributes in the legacy file to begin with, don't move later
- Remove duplicate error messages when init()ing sysfs

 .../ABI/testing/sysfs-platform-wilco-ec       |  42 +++++++
 drivers/platform/chrome/wilco_ec/Makefile     |   3 +-
 drivers/platform/chrome/wilco_ec/core.c       |  12 ++
 drivers/platform/chrome/wilco_ec/legacy.c     | 103 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/legacy.h     |  79 ++++++++++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      |  79 ++++++++++++++
 include/linux/platform_data/wilco-ec.h        |  14 +++
 7 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.h
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
new file mode 100644
index 000000000000..fd2400844470
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
@@ -0,0 +1,42 @@
+What:		/sys/bus/platform/devices/GOOG000C\:00/version_label
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Display Wilco Embedded Controller firmware version label.
+		Output will a version string be similar to the example below:
+		95.00.06
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/version_svn_revision
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Display Wilco Embedded Controller SVN revision.
+		Output will a version string be similar to the example below:
+		5960a.06
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/version_model_number
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Display Wilco Embedded Controller model number.
+		Output will a version string be similar to the example below:
+		08;8
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/version_build_date
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Display Wilco Embedded Controller firmware build date.
+		Output will a MM/DD/YY string.
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
+
+		Input should be parseable by kstrtobool().
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 86d0457d85ea..84ad2772247c 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-wilco_ec-objs				:= core.o mailbox.o debugfs.o
+wilco_ec-objs				:= core.o mailbox.o debugfs.o sysfs.o \
+					   legacy.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 749fd6a36057..9b4a25e63b56 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -69,8 +69,17 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto destroy_mec;
 	}
 
+	/* Create sysfs attributes for userspace interaction */
+	ret = wilco_ec_sysfs_init(ec);
+	if (ret) {
+		dev_err(dev, "Failed to create sysfs attributes\n");
+		goto rm_debugfs;
+	}
+
 	return 0;
 
+rm_debugfs:
+	wilco_ec_debugfs_remove(ec);
 destroy_mec:
 	cros_ec_lpc_mec_destroy();
 	return ret;
@@ -80,6 +89,9 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	/* Remove sysfs attributes */
+	wilco_ec_sysfs_remove(ec);
+
 	/* remove debugfs attributes */
 	wilco_ec_debugfs_remove(ec);
 
diff --git a/drivers/platform/chrome/wilco_ec/legacy.c b/drivers/platform/chrome/wilco_ec/legacy.c
new file mode 100644
index 000000000000..f284088e70f4
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/legacy.c
@@ -0,0 +1,103 @@
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
+#define EC_COMMAND_EC_INFO		0x38
+#define EC_INFO_SIZE			9
+#define EC_COMMAND_STEALTH_MODE		0xfc
+
+#define VERSION_INDEX_LABEL		0
+#define VERSION_INDEX_SVN_REVISION	1
+#define VERSION_INDEX_MODEL_NUMBER	2
+#define VERSION_INDEX_BUILD_DATE	3
+
+static ssize_t get_info(struct device *dev, char *buf, u8 index)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	char result[EC_INFO_SIZE];
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.command = EC_COMMAND_EC_INFO,
+		.request_data = &index,
+		.request_size = sizeof(index),
+		.response_data = result,
+		.response_size = EC_INFO_SIZE,
+	};
+	int ret;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (ret != EC_INFO_SIZE)
+		return -EBADMSG;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", result);
+}
+
+ssize_t wilco_ec_version_label_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return get_info(dev, buf, VERSION_INDEX_LABEL);
+}
+
+ssize_t wilco_ec_version_svn_revision_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return get_info(dev, buf, VERSION_INDEX_SVN_REVISION);
+}
+
+ssize_t wilco_ec_version_model_number_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return get_info(dev, buf, VERSION_INDEX_MODEL_NUMBER);
+}
+
+ssize_t wilco_ec_version_build_date_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return get_info(dev, buf, VERSION_INDEX_BUILD_DATE);
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
index 000000000000..a7f51dec4ccb
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/legacy.h
@@ -0,0 +1,79 @@
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
+/**
+ * wilco_ec_version_label_show() - Display Wilco EC version label
+ * @dev: The device underlying the struct wilco_ec_device
+ * @attr: The attribute being read from
+ * @buf: Output buffer to fill with the result
+ *
+ * Output will a version string be similar to the example below:
+ * 95.00.06
+ */
+ssize_t wilco_ec_version_label_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf);
+
+/**
+ * wilco_ec_version_svn_revision_show() - Display Wilco EC SVN revision
+ * @dev: The device underlying the struct wilco_ec_device
+ * @attr: The attribute being read from
+ * @buf: Output buffer to fill with the result
+ *
+ * Output will a version string be similar to the example below:
+ * 5960a.06
+ */
+ssize_t wilco_ec_version_svn_revision_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf);
+
+/**
+ * wilco_ec_version_model_number_show() - Display Wilco EC model number
+ * @dev: The device underlying the struct wilco_ec_device
+ * @attr: The attribute being read from
+ * @buf: Output buffer to fill with the result
+ *
+ * Output will a version string be similar to the example below:
+ * 08;8
+ */
+ssize_t wilco_ec_version_model_number_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf);
+
+/**
+ * wilco_ec_version_build_date_show() - Display Wilco EC firmware build date
+ * @dev: The device underlying the struct wilco_ec_device
+ * @attr: The attribute being read from
+ * @buf: Output buffer to fill with the result
+ *
+ * Output will a MM/DD/YY string.
+ */
+ssize_t wilco_ec_version_build_date_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf);
+
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
index 000000000000..a885026e5d24
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -0,0 +1,79 @@
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
+/* Make top-level attributes, which will live inside GOOG000C:00/ */
+static struct device_attribute stealth_attr = WILCO_EC_ATTR_WO(stealth_mode);
+static struct device_attribute version_label_attr =
+					WILCO_EC_ATTR_RO(version_label);
+static struct device_attribute version_svn_revision_attr =
+					WILCO_EC_ATTR_RO(version_svn_revision);
+static struct device_attribute version_model_number_attr =
+					WILCO_EC_ATTR_RO(version_model_number);
+static struct device_attribute version_build_date_attr =
+					WILCO_EC_ATTR_RO(version_build_date);
+static struct attribute *wilco_ec_toplevel_attrs[] = {
+	&version_label_attr.attr,
+	&version_svn_revision_attr.attr,
+	&version_model_number_attr.attr,
+	&version_build_date_attr.attr,
+	&stealth_attr.attr,
+	NULL
+};
+static const struct attribute_group wilco_ec_toplevel_group = {
+	.attrs = wilco_ec_toplevel_attrs,
+};
+static const struct attribute_group *wilco_ec_toplevel_groups[] = {
+	&wilco_ec_toplevel_group,
+	NULL,
+};
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
index 3298eabe73bc..b1487a259a12 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -138,4 +138,18 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
 int wilco_ec_debugfs_init(struct wilco_ec_device *ec);
 void wilco_ec_debugfs_remove(struct wilco_ec_device *ec);
 
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
2.20.1.321.g9e740568ce-goog

