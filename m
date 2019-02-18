Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B47C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3B421773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ3JLKKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfBRTMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35068 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfBRTMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so9189356plo.2;
        Mon, 18 Feb 2019 11:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jZh7Eh81/e07UmRKgT1xJc4FS8H4ImGRVqTmq6uKzk=;
        b=JQ3JLKKqWyr8hXhCeUGkvjACL3IQdMR7VkHHF/5F4yX15Cx0urt+VwyGTfN1vqFFF0
         QLUtm0ggtWFRS1n5mxI+mJXvJouGBl2OlHDTg87ChKmN6ZQzTAv7XjU98DQnj6unKGLN
         KrC3Ga2vCeLiiSON08Q6wmSBRN0aN5eJBhrjl8LRMJrDS5K+OExog9SdGcbFvdLrpFvk
         UoWm1Xo6NdrKXmNOKPEhnoJvb6Il8RCMX8vFWSmQKNzHXYyoMxzWMnGP3Wr9EBE7262m
         EBkderS7PPszXf5sGVcYHTi/nhNTT4YQ3ANcZTNUhjX/WfvSlQzCv5d1jbCy0tyjfbwv
         j+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jZh7Eh81/e07UmRKgT1xJc4FS8H4ImGRVqTmq6uKzk=;
        b=PZLlQm3/nDBFdHXMx+YqRxap6YK12cY3HSEEkTS1/3fQnet+XGm7gyif3ZIKfQ6lZ0
         n7HztqH5ZJuvPc6Nvn2KScOaZtJx7/OPe88jgzl8P0HIH1frw8WBtpjYXgFfy/MvfPpH
         kLjWj0b/0HYmQjcT+D0fL4lk6p0UHrMmVH0YH9P/BpAGLUpdKN4ggg/W5xWD+SxkG80Q
         lVDx/KJRh9zj9gV2+/RCR4aC9BxROtMiHADDIeDiC/lAzkBefuBKYHIcCyUpwSqb2dq0
         aBy4ZDMCIMHeQosLaD+9Ud1w9X+zp50uTls3rKoi9K4xJu8DCTVx8V9sqocxflpx7gAK
         +qTQ==
X-Gm-Message-State: AHQUAuZhLADaFL6Qa1YXaifL8IJk3G6CTg7ESFGiahBZ7z+LDuQspgU+
        pD2uartezac4+mhqw46aCKzL1wkl
X-Google-Smtp-Source: AHgI3IZtdiHdx8Vk/h4zlKA/xK90Z4QCQJtP4a7NCt4ShbWi8AO802NzVFQ5meCHg23WJFRux0floA==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr26312280plv.43.1550517121660;
        Mon, 18 Feb 2019 11:12:01 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:00 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Mon, 18 Feb 2019 11:11:30 -0800
Message-Id: <20190218191141.3729-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/thermal_hwmon.c | 28 ++++++++++++++++++++++++++++
 drivers/thermal/thermal_hwmon.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 40c69a533b24..4e79524182e1 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -244,3 +244,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	kfree(hwmon);
 }
 EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
+
+static void devm_thermal_hwmon_release(struct device *dev, void *res)
+{
+	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
+}
+
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = thermal_add_hwmon_sysfs(tz);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = tz;
+	devres_add(&tz->device, ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index a160b9d62dd0..1a9d65f6a6a8 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -17,6 +17,7 @@
 
 #ifdef CONFIG_THERMAL_HWMON
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
 #else
 static inline int
@@ -25,6 +26,12 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	return 0;
 }
 
+static inline int
+devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
 static inline void
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
-- 
2.20.1

