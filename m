Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9D2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgn+Gf/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBVUFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41974 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so1576508pfn.8;
        Fri, 22 Feb 2019 12:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jZh7Eh81/e07UmRKgT1xJc4FS8H4ImGRVqTmq6uKzk=;
        b=hgn+Gf/nl9fDjssR8tGoiOaC4PUxAz8tXTdDgN639EP49iqmftVbx8ZNG9C8Yc1mxf
         gt3j64OkzJHqJp6W3pOhL/MxyfGz/qWEu7nLTUFmpWY6fhSbzr2KUJ66WZmb2OpTjs6K
         9RB7EsFw12wlWc2+1A3RGZlTM33Se3UQdNeHvV74U31bMnXb8pxRxy3/aFX60l+e+3XK
         +mR+EMlsCnx9xQNl1w3R8HSXz9ZaPbtdXGy0GAEJy07VwClA7xJkMgXIa1qvqiEMaOeM
         rbc/fE1zqneLZCqCd/3HBmgdZ/Qg2h32mqnsb3/k7xpTG1g+e+qbK7rAmqIQaaAP78LO
         mCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jZh7Eh81/e07UmRKgT1xJc4FS8H4ImGRVqTmq6uKzk=;
        b=Nnlht/3IGVMkYcycH1t4h3zHrhp5gorPSu2h/IRHucgYedRMQw+3lkaB2j4jy5mbPB
         biR+KcY2liboXhLKVozB1U8pERlyeDTeggeYAY3uyyD+A0nMMDxxS48gt/wBgo8QAXl3
         6u/8BPw6nlpn0G7E9evWqbjDnD6rO7UQOPr/GphMbrpFpMhOYurMJPYghYxVoyQsbfQv
         rss6JplGUhe6N6XtivXoExzTPJe1Ealf+Ln/X6mLgeUUYaOGA54q5jaRJB86i80NUIeP
         CZmgdJl6HeOLPOfF9Hvilb/bnFvLPWOW1G5wTp7r7Jgc4lZIDrPDqUVJr3Jjm8hcyq22
         mUUw==
X-Gm-Message-State: AHQUAuY29Q8x2Bcbu2Xxz76ErCtcH6BRWvDyg+OaaTpUMZw50ZyFwmqa
        6wQrVv4YkZXSIMtU5DNYNJhZrKTh
X-Google-Smtp-Source: AHgI3IbvbGFp4j2lfi2wEBjPMdDXYJVxANMjypDtDzEDakxSaxSRMaZ3FtW8GZ+umhznhq4knL3o+A==
X-Received: by 2002:a63:c042:: with SMTP id z2mr5596534pgi.307.1550865921911;
        Fri, 22 Feb 2019 12:05:21 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:21 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Fri, 22 Feb 2019 12:04:56 -0800
Message-Id: <20190222200508.26325-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
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

