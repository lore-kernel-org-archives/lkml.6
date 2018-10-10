Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921E421479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq2Zq6l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921E421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJJLxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:53:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40710 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:53:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so1877595pgm.7;
        Tue, 09 Oct 2018 21:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eWhd1Tb5PRU/lQ2NdschJnLbQwERZJCIHgKdwYaw3Tk=;
        b=kq2Zq6l9ofQilON/WuHr4oaiKb5NJ7T2fOJbLXs6aABsH8T45yafLMNJHsgyJZAhZo
         bDi94Nkx8YOW8ogX2HEyGV3ZzziRrgg8+x4UK0c8vzkwLTL+bYEXHlOHL4rgU90YoXhD
         bmFSTTrV7y1+wIE8vUbTSxT1uvVD/L0xykJJDkZPnTPlZYoYiUt9tGGg4aCjEQYKOkXh
         qZ9qMlI0hUHcG9Plsj995T4E0U3d4ugCKbiU8tJMIlPkHM8LDa21v32Z6xthYowN02V5
         HIzUMq4J+ZWU+FYX9Ptq9EX6b6SmuQyb8sP24fodM1sbFVrrZtbOQCzpco+mAWB4Bf5v
         sqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eWhd1Tb5PRU/lQ2NdschJnLbQwERZJCIHgKdwYaw3Tk=;
        b=TqwFj6y4y8L5XBQxCLPh/LJqRXhxZjMbtCPmYMPBko0MdY1jLBvujE7z/jpnUj3r5V
         8cNOfzKi7wP1yR37j3z+GQrdNn9rohEJhqHowL7/USIjEjxlYLR62u/vgSxvkWNohAAH
         m0m6Wo9vv7hNigdEPsagKDJ/YWHy5vyNVWD92uc68XOuc9mMAChbOPURWWzzIzjT5LPe
         sExsby5mO5PD1kFuWX7xFl5z8HNmP4oQVDJKO8H+sz6gPufIiylEYcZ+tAIDlUgh4Isp
         oK/qY6/KeSTn9L+MX5Z/prr/FPAnWFxvX4ElNVnlH9KmDtWs+IPIkEsqFkKDouKKVa27
         y1CQ==
X-Gm-Message-State: ABuFfohbnI7mC6Ydg86s4gNCo7YrT5nvII7U6EGe6i+W8i56A0wWNsbl
        DcTqY5KlIvPd6UlRcxh3f+o=
X-Google-Smtp-Source: ACcGV61AdqVL+jSbkmjArpFHAKUCmzMVq3gKaIO6dvY/Bn+9T/l7YDz0PV6tYJK1DjAn4EtBDhhORw==
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr27919661pgb.411.1539145998418;
        Tue, 09 Oct 2018 21:33:18 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n63-v6sm21171025pfn.9.2018.10.09.21.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 21:33:17 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (core) Add hwmon_mode structure and mode sysfs node
Date:   Tue,  9 Oct 2018 21:33:09 -0700
Message-Id: <20181010043310.30873-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010043310.30873-1-nicoleotsuka@gmail.com>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few hwmon sensors support different operating modes,
for example, one-shot and continuous modes. So it's probably not
a bad idea to abstract a mode sysfs node as a common feature in
the hwmon core.

Right beside the hwmon device name, this patch adds a new sysfs
attribute named "mode" and "available_modes" for user to check
and configure the operating mode. For hwmon device drivers that
implemented the _with_info API, the change also adds an optional
hwmon_mode structure in hwmon_chip_info structure so that those
drivers can pass mode related information.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/hwmon/sysfs-interface | 15 +++++
 drivers/hwmon/hwmon.c               | 87 ++++++++++++++++++++++++++---
 include/linux/hwmon.h               | 24 ++++++++
 3 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 2b9e1005d88b..48d6ca6b9bd4 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -92,6 +92,21 @@ name		The chip name.
 		I2C devices get this attribute created automatically.
 		RO
 
+available_modes The available operating modes of the chip.
+		This should be short, lowercase string, not containing
+		whitespace, or the wildcard character '*'.
+		This attribute shows all the available of the operating modes,
+		for example, "power-down" "one-shot" and "continuous".
+		RO
+
+mode		The current operating mode of the chip.
+		This should be short, lowercase string, not containing
+		whitespace, or the wildcard character '*'.
+		This attribute shows the current operating mode of the chip.
+		Writing a valid string from the list of available_modes will
+		configure the chip to the corresponding operating mode.
+		RW
+
 update_interval	The interval at which the chip will update readings.
 		Unit: millisecond
 		RW
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..5a33b616284b 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -72,25 +72,88 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(name);
 
+static ssize_t available_modes_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct hwmon_device *hwdev = to_hwmon_device(dev);
+	const struct hwmon_chip_info *chip = hwdev->chip;
+	const struct hwmon_mode *mode = chip->mode;
+	int i;
+
+	for (i = 0; i < mode->list_size; i++)
+		snprintf(buf, PAGE_SIZE, "%s%s ", buf, mode->names[i]);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", buf);
+}
+static DEVICE_ATTR_RO(available_modes);
+
+static ssize_t mode_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct hwmon_device *hwdev = to_hwmon_device(dev);
+	const struct hwmon_chip_info *chip = hwdev->chip;
+	const struct hwmon_mode *mode = chip->mode;
+	unsigned int index;
+	int ret;
+
+	ret = mode->get_index(dev, &index);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", mode->names[index]);
+}
+
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct hwmon_device *hwdev = to_hwmon_device(dev);
+	const struct hwmon_chip_info *chip = hwdev->chip;
+	const struct hwmon_mode *mode = chip->mode;
+	const char **names = mode->names;
+	unsigned int index;
+	int ret;
+
+	/* Get the corresponding mode index */
+	for (index = 0; index < mode->list_size; index++) {
+		if (!strncmp(buf, names[index], strlen(names[index])))
+			break;
+	}
+
+	if (index >= mode->list_size)
+		return -EINVAL;
+
+	ret = mode->set_index(dev, index);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(mode);
+
 static struct attribute *hwmon_dev_attrs[] = {
-	&dev_attr_name.attr,
+	&dev_attr_name.attr,		/* index = 0 */
+	&dev_attr_available_modes.attr,	/* index = 1 */
+	&dev_attr_mode.attr,		/* index = 2 */
 	NULL
 };
 
-static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
-					 struct attribute *attr, int n)
+static umode_t hwmon_dev_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
+	struct hwmon_device *hwdev = to_hwmon_device(dev);
 
-	if (to_hwmon_device(dev)->name == NULL)
-		return 0;
+	if (n == 0 && hwdev->name)
+		return attr->mode;
+	else if (n <= 2 && hwdev->chip->mode)
+		return attr->mode;
 
-	return attr->mode;
+	return 0;
 }
 
 static const struct attribute_group hwmon_dev_attr_group = {
 	.attrs		= hwmon_dev_attrs,
-	.is_visible	= hwmon_dev_name_is_visible,
+	.is_visible	= hwmon_dev_is_visible,
 };
 
 static const struct attribute_group *hwmon_dev_attr_groups[] = {
@@ -591,6 +654,16 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 		struct attribute **attrs;
 		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
 
+		/* Validate optional hwmon_mode */
+		if (chip->mode) {
+			/* Check mandatory properties */
+			if (!chip->mode->names || !chip->mode->list_size ||
+			    !chip->mode->get_index || !chip->mode->set_index) {
+				err = -EINVAL;
+				goto free_hwmon;
+			}
+		}
+
 		if (groups)
 			for (i = 0; groups[i]; i++)
 				ngroups++;
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 99e0c1b0b5fb..06c1940ca98b 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -365,14 +365,38 @@ struct hwmon_channel_info {
 	const u32 *config;
 };
 
+/**
+ * Chip operating mode information
+ * @names:	A list of available operating mode names.
+ * @list_size:	The total number of available operating mode names.
+ * @get_index:	Callback to get current operating mode index. Mandatory.
+ *		Parameters are:
+ *		@dev:	Pointer to hardware monitoring device
+ *		@index:	Pointer to returned mode index
+ *		The function returns 0 on success or a negative error number.
+ * @set_index:	Callback to set operating mode using the index. Mandatory.
+ *		Parameters are:
+ *		@dev:	Pointer to hardware monitoring device
+ *		@index:	Mode index in the mode list
+ *		The function returns 0 on success or a negative error number.
+ */
+struct hwmon_mode {
+	const char **names;
+	unsigned int list_size;
+	int (*get_index)(struct device *dev, unsigned int *index);
+	int (*set_index)(struct device *dev, unsigned int index);
+};
+
 /**
  * Chip configuration
  * @ops:	Pointer to hwmon operations.
  * @info:	Null-terminated list of channel information.
+ * @mode:	Pointer to hwmon operating mode (optional).
  */
 struct hwmon_chip_info {
 	const struct hwmon_ops *ops;
 	const struct hwmon_channel_info **info;
+	const struct hwmon_mode *mode;
 };
 
 /* hwmon_device_register() is deprecated */
-- 
2.17.1

