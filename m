Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61DFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AFB208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YBEGkGit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AFB208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeGJIo4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:44:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45229 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeGJIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:44:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so17641973qti.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+GIAKQDQFSFQztEFMaVeioL3lzy9BxfSG2/K3Fqo07E=;
        b=YBEGkGitM+tKnduN/qc3hKn+WfJnPZM3oOYcvwV8fqm0GRbbGFaFgf2pWpUU+m7+oD
         Lrcd7qf8VP62kNRoEvb+3C35rn3+k87m4SnAYuZdq7028GkuI4gXaG7bANqkQTk4jZE0
         PhIUom0Cop5oiO8jYP+CabtfnanSibFrXthhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+GIAKQDQFSFQztEFMaVeioL3lzy9BxfSG2/K3Fqo07E=;
        b=D49ViDKCRx3MOCFxu+XOfR0fhZ0619/vVI3bm+h2KV97Wns6WOsrUBjEvy6vbygiZJ
         fLUAm+JA8YV9po5Rjfw1s51TbUJBJ0CdRbNRDp8LBgfnxVrpB6oJ5HFtpt/ovQLLVUVK
         THwi1psCbw89caFiqDynWuNaON1Q2CZAgJsC0YMGmzOs/qgIpMVOVEm+y/S6Qk5+LwpF
         AYUl314GgxrqektDj+X5SeHMVBooOdWBgRQByWByag8vuDMqPKuj8sFxUBftCtQLPQsu
         subKA+uEAbZR1tA186h9Tkuff2sPicpjtdN/mr70qtK3gQHs2Bgncd+rVG/Qu2GeoDbi
         sQfw==
X-Gm-Message-State: APt69E0Bp5ZHTVE+EsfhXeH4yh+IWs6Ummmcr/3XAyE1Emz6jWRhJLuZ
        uu0xCW0U7nx2S/SrvapIMfaVhw==
X-Google-Smtp-Source: AAOMgpdE3ZcwsxOcHQzPGJ6Z2niyEyVyAj8TAzlquev3JFnnwHOuYCW87dFuPpNyEasW8EBDB/1x3g==
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr20436334qvb.26.1531212293826;
        Tue, 10 Jul 2018 01:44:53 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j20-v6sm13893422qtc.71.2018.07.10.01.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 01:44:52 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Date:   Tue, 10 Jul 2018 14:14:39 +0530
Message-Id: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9849db0..a896b1c 100644
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
@@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	wdt->clk = devm_clk_get(&adev->dev, NULL);
-	if (IS_ERR(wdt->clk)) {
-		dev_warn(&adev->dev, "Clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		goto err;
+	if (adev->dev.of_node) {
+		wdt->clk = devm_clk_get(&adev->dev, NULL);
+		if (IS_ERR(wdt->clk)) {
+			dev_err(&adev->dev, "Clock not found\n");
+			return PTR_ERR(wdt->clk);
+		}
+		wdt->rate = clk_get_rate(wdt->clk);
+	} else if (has_acpi_companion(&adev->dev)) {
+		/*
+		 * When Driver probe with ACPI device, clock devices
+		 * are not available, so watchdog rate get from
+		 * clock-frequency property given in _DSD object.
+		 */
+		device_property_read_u64(&adev->dev, "clock-frequency",
+					 &wdt->rate);
+		if (!wdt->rate) {
+			dev_err(&adev->dev, "no clock-frequency property\n");
+			return -ENODEV;
+		}
 	}
 
 	wdt->adev = adev;
-- 
2.7.4

