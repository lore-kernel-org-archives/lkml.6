Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97246C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660E6222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajKonsCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395369AbfBNDlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:41:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38068 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389764AbfBNDlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:41:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2336775pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4DDZa9UNNDPoHClqayQDB3fdzoTjX8XIC8Ufn84AuJY=;
        b=ajKonsCVsozjnHRPiMt/M59coQrxnCYDUHQaMDgPEWs+cRf5gPDoZ8CuWLsTMnBCb4
         hG3/C1MCfYm8272yABsG724DmOO2xy/TwVvLeFDMyX95pO4mWHLX7q4UzpGqqcPmNgpJ
         ooWU48Glax6VF1U5kAQlQtDp2GwILHjZQU2rr7JzMhKAv/3u5rYhYlaD3r4TDgif3EfB
         l/pIj6dRUdVg8WxNHDQya8vdnnFSnEr5gkh+hHAMM5E5WZavdtRoP2XPWMUOMjXvJigv
         Fr0c5e7XbVjGE5/ZRzXMJssvwoWILQBDCvBVwGb52nOTikr594vH1lz6Moeqk2KgUwxi
         iEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4DDZa9UNNDPoHClqayQDB3fdzoTjX8XIC8Ufn84AuJY=;
        b=keyEj5/hQaEXqkSPegm3Yk50OCYrpq9XhUnOTV774GSYsKc8AQxEnvxyZRdH3jJB+s
         sx78mR3m5aRGsSsAspx+r3r+BBPiA7rLSKesaI9qu4vG/Der1jHOf2UJuV0HZ+TQYCa4
         WI9yCrxYjDp0KKsZWfQGytRJsOkfmr18WjogML2mXf43m1m5/5m2enDK0ap+b4yiUpY2
         rMHXfCbFBPMWk7wCbmLct3zOoGjSxUw3/ktV83zOSpKYssL7xKffV42mFqkN16+e9iBJ
         PuPxcXqTMVQjR4J40W3iA9wqm4hDN079ODeQqGG79gKQ1w9mH5pTZRF8+h0zV0DgRZvu
         kPtA==
X-Gm-Message-State: AHQUAuauoeMxJiTI6hmcoKlwMPYS2rRA2PcmjYxH8Nio5YWG/Y9w6iUL
        peGq5by7htVZWRpT/n25OgW8eQ==
X-Google-Smtp-Source: AHgI3IaqhQSokx2bseSqqLZiSesxhstkqFIL+7WHKNWUD+I+L4mLygRw6KnrH6dOAMfqkADM/IPHbA==
X-Received: by 2002:a63:eb02:: with SMTP id t2mr1701163pgh.57.1550115695089;
        Wed, 13 Feb 2019 19:41:35 -0800 (PST)
Received: from localhost.localdomain ([103.240.171.178])
        by smtp.gmail.com with ESMTPSA id l184sm1038583pfc.112.2019.02.13.19.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:41:34 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH 1/5] base: soc: Add serial_number attribute to soc
Date:   Thu, 14 Feb 2019 09:11:28 +0530
Message-Id: <f62c54a270864b450d2a4f884de6946551e7ff45.1550114271.git.vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550114271.git.vaishali.thakkar@linaro.org>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
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
 Documentation/ABI/testing/sysfs-devices-soc | 7 +++++++
 drivers/base/soc.c                          | 7 +++++++
 include/linux/sys_soc.h                     | 1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index 6d9cc253f2b2..919109697bf0 100644
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
+		serial number.
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

