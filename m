Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26011C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BEF21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 19:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sM1y8rhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLXTXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 14:23:41 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36455 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXTXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 14:23:40 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so16145621itj.1;
        Mon, 24 Dec 2018 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GvZQYngJWOhqnFbKOHjc9A1U0Jvf22KkxhhjLqRhtTk=;
        b=sM1y8rhEXDVXMFY/YtFQitwJ5uZ0XNTGG12E/dKJNJs57H0VeaE0tE+LEDa1QpaYv/
         NuzjK2obUgO3N5W//pP00s7opfPLHxl67JLdwyrsowNYpz1W6paAQmEW7SZn/GG5HyKU
         1H9uh2MxIUM6+sHVaLFY5SaRekOnccDKr+8J8hHs0Utjum8pwQWVb2uzlNi46qlHkK1r
         +r1cvq/JVpSZHR5viuB1wJH8DPcuxl/uVD8DFQDfjufM86m9F+PeAHW45PFKitlv8hD5
         h+bEBpOtmP58CUmSZO4+3BsK9e5Vi+KxBVtSB63uhltGl69fXIzZgHSoyfvqurUbGZ/N
         heQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GvZQYngJWOhqnFbKOHjc9A1U0Jvf22KkxhhjLqRhtTk=;
        b=hhtH118kDdrngmcv76d4pV8km5OcxWnE5A2/FcQmonZvKIHYZ6pMchFoP3/UXY+Xw5
         N7DQG2sBkYzEEXB9uCyzSBk6/7XJgdJTBzP8PzQyNulj3gO8OI2YDAlZ746l5GNot17C
         NffQwpL68og6W2Fcmd/4J2RlPzvK1wRt035neXtAuJPFYoi6dzTvlQUelLYexRXT0Z88
         UBn5NGCYszn37pRYdntG7uxPzQawMp+NhJIE+YrAyC8wJ9nwrKLqDx7MyoODkPwGJASR
         qv/Jc6A9MZ2JO47F956GLbaIdWrlN+JpHWZhOaNKnCaOmH67h+9jn9S9VQF5hP/XCIwK
         z33Q==
X-Gm-Message-State: AA+aEWbtCIxP58veSU6wBhf5hL/Ieinpm893WkzwXxznZMjMcMU/7yBu
        ASCU7yXOq3bgN+k6Fxdg0lPb6CDM
X-Google-Smtp-Source: AFSGD/WpDZK4OSpkUcwwe4ZQdFJpOiNjgudn+VdXNPE2z/ri98vv3QiZe1MF/csti/BcFkHvJTSVeA==
X-Received: by 2002:a24:54d0:: with SMTP id t199mr9631173ita.57.1545679419390;
        Mon, 24 Dec 2018 11:23:39 -0800 (PST)
Received: from ArchLaptop (h69-129-169-208.cntcnh.dsl.dynamic.tds.net. [69.129.169.208])
        by smtp.gmail.com with ESMTPSA id j129sm11007704itb.41.2018.12.24.11.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 11:23:38 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:23:36 -0500
From:   Aaron Hill <aa1ronham@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: thermal: int340x_thermal: Fix sysfs race
 condition
Message-ID: <20181224192336.GA6057@ArchLaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1:
* Use dev_info instead of printk
* Use dev_warn instead of BUG_ON

Previously, sysfs_create_group was called before all initialization had
fully run - specifically, before pci_set_drvdata was called. Since the
sysctl group is visible to userspace as soon as sysfs_create_group
returns, a small window of time existed during which a process could read
from an uninitialized/partially-initialized device.

This commit moves the creation of the sysctl group to after all
initialized is completed. This ensures that it's impossible for
userspace to read from a sysctl file before initialization has fully
completed.

To catch any future regressions, I've added a check to ensure
that proc_thermal_emum_mode is never PROC_THERMAL_NONE when a process
tries to read from a sysctl file. Previously, the aforementioned race
condition could result in the 'else' branch
running while PROC_THERMAL_NONE was set,
leading to a null pointer deference.

Signed-off-by: Aaron Hill <aa1ronham@gmail.com>
---
 .../processor_thermal_device.c                | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 284cf2c5a8fd..0a43dbf0131b 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -81,10 +81,15 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 					struct device_attribute *attr, \
 					char *buf) \
 { \
+	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
+		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
+		return 0; \
+	} \
+	\
 	struct pci_dev *pci_dev; \
 	struct platform_device *pdev; \
 	struct proc_thermal_device *proc_dev; \
-\
+	\
 	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
 		pdev = to_platform_device(dev); \
 		proc_dev = platform_get_drvdata(pdev); \
@@ -298,11 +303,6 @@ static int proc_thermal_add(struct device *dev,
 	*priv = proc_priv;
 
 	ret = proc_thermal_read_ppcc(proc_priv);
-	if (!ret) {
-		ret = sysfs_create_group(&dev->kobj,
-					 &power_limit_attribute_group);
-
-	}
 	if (ret)
 		return ret;
 
@@ -316,8 +316,7 @@ static int proc_thermal_add(struct device *dev,
 
 	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
 	if (IS_ERR(proc_priv->int340x_zone)) {
-		ret = PTR_ERR(proc_priv->int340x_zone);
-		goto remove_group;
+		return PTR_ERR(proc_priv->int340x_zone);
 	} else
 		ret = 0;
 
@@ -331,9 +330,6 @@ static int proc_thermal_add(struct device *dev,
 
 remove_zone:
 	int340x_thermal_zone_remove(proc_priv->int340x_zone);
-remove_group:
-	sysfs_remove_group(&proc_priv->dev->kobj,
-			   &power_limit_attribute_group);
 
 	return ret;
 }
@@ -364,7 +360,10 @@ static int int3401_add(struct platform_device *pdev)
 	platform_set_drvdata(pdev, proc_priv);
 	proc_thermal_emum_mode = PROC_THERMAL_PLATFORM_DEV;
 
-	return 0;
+	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PLATFORM_DEV\n");
+
+	return sysfs_create_group(&pdev->dev.kobj,
+					 &power_limit_attribute_group);
 }
 
 static int int3401_remove(struct platform_device *pdev)
@@ -441,7 +440,10 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 			dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
 	}
 
-	return 0;
+	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PCI\n");
+
+	return sysfs_create_group(&pdev->dev.kobj,
+					 &power_limit_attribute_group);
 }
 
 static void  proc_thermal_pci_remove(struct pci_dev *pdev)
-- 
2.20.1

