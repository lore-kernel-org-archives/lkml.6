Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D8B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGEHK7PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBUQYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:24:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43130 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBUQYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:24:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so2416003pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvnoAwQGH8etogCUYhRrGiQaID48sL8JQws8t+HfGzc=;
        b=jGEHK7PFla1CoPyN0b8i2CJRpufefgn50DRIdvwRAN0Jd0uA78SbHiRwvcjVn6fS71
         sgq1punYBKXOsZEKncBsUfLks/Aazj/5jLsAuUhB+VP88l7B1wwUHED0ES33JBUVG+mT
         Uz2xr1HBn+/mSbDIvH72SFGvx10gibTQs0KaXJngMXAK+9IS3YAKoUFT9pCl2aiDsRwL
         LSLJLwj30LpqCne4YxDGWoPnELyNX271dA64ket0F2dK/G4VslTfRmYAbQycL7hx3HgK
         7jxowx8GcbDBbS+8M43gGLuMVPxF2d/RQW+j4ht5dDj7RWgY7h2mUE3OFBsEDvRiANqq
         PSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvnoAwQGH8etogCUYhRrGiQaID48sL8JQws8t+HfGzc=;
        b=TOR+/HJVzL2QFQp5IA0nkW17HcFqtqTQzEJvctlqLWmfsKEXwitICxvizTNMQWeLFI
         vEe/clzBDlWLs5ouSZVKqQbwvtPiCNUq0q2efDkHJNY27GaJbvARUeGIPE1jzqk3rmLg
         oPHz9oCB7k+gcgQYz+2esUJOqi2CN4e2K6q88kCxYz0a69zR46LrnTU3ACkoxMs1IV9b
         5bPWnkDLSWqCQqd97y7NOhm7DxCDtNjuFvxOQYnGwZuIu+gnU7Ek+qACYRviDPDkJ1FY
         sZcevkP2brAVZtHA5pUdhT5Yoz03TpE+QuNVllTC3Y7N50nYqHL1uZcyqFoJ3cOZt8Lu
         iNMw==
X-Gm-Message-State: AHQUAubvPMmcnVH1U4RFtAwCwnzqussWbcCY/G558u4Yo0igCMBqOQ9v
        MZVZ71LGvlufdlt//4ZcrUZPoQ==
X-Google-Smtp-Source: AHgI3IYzZ276eHlxhpZAEAvQAmyBw2DNh/fkKrIrwvoOHcfANKQPKfr7tBsyyiOa7YVmU93iqss13g==
X-Received: by 2002:a65:6684:: with SMTP id b4mr35485119pgw.55.1550766272737;
        Thu, 21 Feb 2019 08:24:32 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id 20sm21382910pfs.182.2019.02.21.08.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:24:32 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v3 1/5] base: soc: Add serial_number attribute to soc
Date:   Thu, 21 Feb 2019 21:54:15 +0530
Message-Id: <20190221162419.32384-2-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
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
Changes since v2:
	- None
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

