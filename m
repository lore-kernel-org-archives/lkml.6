Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C210820882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V/w8ll1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C210820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeGIKT4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:19:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36763 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeGIKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:19:55 -0400
Received: by mail-qt0-f195.google.com with SMTP id f1-v6so14927801qti.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uRl31Yg0nZV+m4wDWq8yuor2sBkVQZYUU89idLCaUOM=;
        b=V/w8ll1lS5o+B4fGHmjGV4hRZWyg9NfYoLgVS/qpTL6RadNa1nlZvWod0YRvGERnEp
         bi0aFaH5FJH15inZ/e9TdnXggh3yKhGF2UP4zCujLRxozPZkEI6HEJN4MXKeeGElbJdP
         s50fLLKMeJgAOl4Tvoltyf/sDKbWovcVxGYS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uRl31Yg0nZV+m4wDWq8yuor2sBkVQZYUU89idLCaUOM=;
        b=MA5kESZLk5mzg01sDCC56H3OgKEBFNW+ehzCUFTq3ownRQHIciB8Dz9g8W+a75ph5q
         va5WqaGS35+6mP4Zp8C2N2QUziVaL79h7iDCYevL8zHIPByDRDXcCipiGEbGV4nVRD84
         Tyly2VHwsYj8zURqwJEy7xqGG8RA1pr+/vjTPzk3xMEPIdlndpiHApfVMEiC56oJk6Gb
         sUtJv7wOZ1s2TecpRjuhn5nYsguIiv8Jeo6S1YXhGmzGeqDrmqUZPRrYqkCPhtaC8/bK
         1ABhpgRBdtoU27U/L4MZQfv7EdnPMjmN3dzlW4rUUFB5PM8Z8HWvyFzyzNOJLbUxaU7n
         VxOA==
X-Gm-Message-State: APt69E1s/Z+TCCZRXcaZTKcHuZ3+Kaorc6WknxPDvbyyXepUNxjEShCI
        KJ+AF6L9+SLyd2JMUjV3UOhzzw==
X-Google-Smtp-Source: AAOMgpdGOA2+3BAv1umS2lNEOojbcszJT4s/AzMGNF+avUfyF4SKK0OtFfRsEBNiFVPbna+oWBIUHw==
X-Received: by 2002:a0c:9259:: with SMTP id 25-v6mr16969506qvz.239.1531131594478;
        Mon, 09 Jul 2018 03:19:54 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y49-v6sm12687507qty.91.2018.07.09.03.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 03:19:53 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH v2] watchdog: sp805: Add clock-frequency property
Date:   Mon,  9 Jul 2018 15:49:29 +0530
Message-Id: <1531131569-13727-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using ACPI node, binding clock devices are
not available as device tree, So clock-frequency
property given in _DSD object of ACPI device is
used to calculate Watchdog rate.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/watchdog/sp805_wdt.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9849db0..ad5ed64 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/resource.h>
 #include <linux/amba/bus.h>
@@ -22,6 +23,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -65,6 +67,7 @@ struct sp805_wdt {
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
+	u64				rate;
 	struct amba_device		*adev;
 	unsigned int			load_val;
 };
@@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	rate = wdt->rate;
 
 	/*
 	 * sp805 runs counter with given value twice, after the end of first
@@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
-	u64 load, rate;
-
-	rate = clk_get_rate(wdt->clk);
+	u64 load;
 
 	spin_lock(&wdt->lock);
 	load = readl_relaxed(wdt->base + WDTVALUE);
@@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 		load += wdt->load_val + 1;
 	spin_unlock(&wdt->lock);
 
-	return div_u64(load, rate);
+	return div_u64(load, wdt->rate);
 }
 
 static int
@@ -228,10 +229,27 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	wdt->clk = devm_clk_get(&adev->dev, NULL);
-	if (IS_ERR(wdt->clk)) {
+	if (adev->dev.of_node) {
+		wdt->clk = devm_clk_get(&adev->dev, NULL);
+		if (IS_ERR(wdt->clk)) {
+			ret = PTR_ERR(wdt->clk);
+			wdt->clk = NULL;
+		} else
+			wdt->rate = clk_get_rate(wdt->clk);
+	} else if (has_acpi_companion(&adev->dev)) {
+		/*
+		 * When Driver probe with ACPI device, clock devices
+		 * are not available, so watchdog rate get from
+		 * clock-frequency property given in _DSD object.
+		 */
+		device_property_read_u64(&adev->dev, "clock-frequency",
+				&wdt->rate);
+		if (!wdt->rate)
+			ret = -ENODEV;
+	}
+
+	if (ret) {
 		dev_warn(&adev->dev, "Clock not found\n");
-		ret = PTR_ERR(wdt->clk);
 		goto err;
 	}
 
-- 
2.7.4

