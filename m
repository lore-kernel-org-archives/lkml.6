Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4C720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPHepq86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfBTE6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:58:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39888 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfBTE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:58:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so11228512pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1pBHjk3updZIvXBgasb0eUsMOw684uPryESYhpgXWVg=;
        b=WPHepq86NLZctZfA8K7H+3xY6wWkQSQm+Nc1GYEetQqkjVaJycNmhVBgfm5MLpPMpl
         p9Q4yiDZCotJg8JtIhJ/mvKf/rAogN72vfY+44FCX4JnIy91y4JZbE/IqEdEJBbpddiN
         b0xDS3hEJFkQqh9wmuAn9+Qh0sqGve9JHmQnfxoFXCnXdzw4nlp6GtjX5FjcudiVmmzz
         Fj58Kbkb9ASzxNovZfvEkjMfMUryfzT5rjZ8m08Do3srEL7modXZcg6UTiLPUDdYv8GQ
         VOm0ELpy21tZQO4CBZ+at6CMrUhcBP73OTVMacDgWWRLs1AKGVx30De+OI5urjc/UcOn
         BsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1pBHjk3updZIvXBgasb0eUsMOw684uPryESYhpgXWVg=;
        b=Ff0ZPtunBBURRgyRrVMyWyP+EMnj4I8WWbmO3HIEebz7Ph5LTd9wZya7AigM205kEg
         36ldoZImLp0eh4xPlSJ+fJNcR4R+mb+6ibbjiUO0RLtvVksuQuM7Z64hbcOwj8h+5ZeL
         o/PwJnPe7BShnOp32gBv93LF7tY3VDS+jWoysyLI2VUeAisGHcmb1chRBie6sfxShin4
         WlUzcnQv1h/OK8QQCId0DeT9LdNEFLziGTT+rr+rhPy7cQeLRBoHjVAjbSHzg5Q0c+w2
         cCk5ucQa6buhG+WAufN5N5Vmc98B2Pk8ltHCnB78paMyQnF84F+FvQq4MEJrWILIOuKx
         9SCg==
X-Gm-Message-State: AHQUAuaY479uObnAxZiv8Qis+izy3TheWxCHTo9fuJxpOwDY5K7w/GOr
        33uMIsT3MEk73wSxcX2pUU2f8g==
X-Google-Smtp-Source: AHgI3IbI5gEO9kzCv8N5tYquCfdqp9V91iu/woL9FlmD3zf5j18xmDDpJIMO9i3yRyKM1Q0Uc763Eg==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr26814868pgh.163.1550638701826;
        Tue, 19 Feb 2019 20:58:21 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id b70sm22464879pfm.6.2019.02.19.20.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:58:21 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v2 1/5] base: soc: Add serial_number attribute to soc
Date:   Wed, 20 Feb 2019 10:28:13 +0530
Message-Id: <20190220045813.6756-1-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add new attribute named "serial_number" as a standard interface for
user space to acquire the serial number of the device.

For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
attribute, but this provides a human readable standardized name for this
property.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Changes since v1:
	- Make comment more clear for the case when serial
	  number is not available
---
 Documentation/ABI/testing/sysfs-devices-soc | 7 +++++++
 drivers/base/soc.c                          | 7 +++++++
 include/linux/sys_soc.h                     | 1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index 6d9cc253f2b2..ba3a3fac0ee1 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -26,6 +26,13 @@ Description:
 		Read-only attribute common to all SoCs. Contains SoC family name
 		(e.g. DB8500).
 
+What:		/sys/devices/socX/serial_number
+Date:		January 2019
+contact:	Bjorn Andersson <bjorn.andersson@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. Contains the SoC's
+		serial number, if available.
+
 What:		/sys/devices/socX/soc_id
 Date:		January 2012
 contact:	Lee Jones <lee.jones@linaro.org>
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 10b280f30217..b0933b9fe67f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -33,6 +33,7 @@ static struct bus_type soc_bus_type = {
 
 static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(serial_number, S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
 
@@ -57,6 +58,9 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
 	if ((attr == &dev_attr_revision.attr)
 	    && (soc_dev->attr->revision != NULL))
 		return attr->mode;
+	if ((attr == &dev_attr_serial_number.attr)
+	    && (soc_dev->attr->serial_number != NULL))
+		return attr->mode;
 	if ((attr == &dev_attr_soc_id.attr)
 	    && (soc_dev->attr->soc_id != NULL))
 		return attr->mode;
@@ -77,6 +81,8 @@ static ssize_t soc_info_get(struct device *dev,
 		return sprintf(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
 		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+	if (attr == &dev_attr_serial_number)
+		return sprintf(buf, "%s\n", soc_dev->attr->serial_number);
 	if (attr == &dev_attr_soc_id)
 		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
 
@@ -87,6 +93,7 @@ static ssize_t soc_info_get(struct device *dev,
 static struct attribute *soc_attr[] = {
 	&dev_attr_machine.attr,
 	&dev_attr_family.attr,
+	&dev_attr_serial_number.attr,
 	&dev_attr_soc_id.attr,
 	&dev_attr_revision.attr,
 	NULL,
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index bed223b70217..2a13bc033bd6 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -12,6 +12,7 @@ struct soc_device_attribute {
 	const char *machine;
 	const char *family;
 	const char *revision;
+	const char *serial_number;
 	const char *soc_id;
 	const void *data;
 };
-- 
2.17.1

