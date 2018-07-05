Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2EB24108
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KTJ9peRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2EB24108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeGEDXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 23:23:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39898 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbeGEDXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 23:23:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so5265906eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 20:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1zGeJmpHvN4U00B3Qq0ng4BrDyeUhUnaBHoYOE9z8FM=;
        b=KTJ9peRKNE57X+kX9l07GC7vKkGOrlGzqY/nZk7jbhZ0idVO6Oggq4KYymc0Kmujlr
         jeLbpueC0upqBozH1b1X1s+YqaN+UU09411sHW1ILpEmcJ4aMAY/ekmCAkl+RFFw5pXF
         hF2nYKbaUZx8Di2V1ME8gIlXgsC7Fj0U4vy0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1zGeJmpHvN4U00B3Qq0ng4BrDyeUhUnaBHoYOE9z8FM=;
        b=jvMisrHSd69Wcc8xSSb8utS4e6pcWHvM/Ef3IlEKuI5zxM0giTTxRgAFWeIxrIcHyn
         WIh3CkcMqozVb5AFnjXr1xNNfdEpFhWV9tcJ9lXSDx1orivmNI2aW3USKUM46JGI2GN8
         TWvNrbMlZCsqrKwskIxnl2eYqpTzOZGzML3xJIVf6+WVdQFSbomheLzQ0jICvjCfWr8d
         MeGdnBqDqBP7GkFFdoXWG5J5wO1c2GmfEru4gZapss+9pYnjhZh3IRjwaTDqVyNeRXJo
         B7AlPqXWNAOXyYVA0iOm4DB0luUS0RpFgAEL8blVVxE3Tsvs0ZrQk8wJ1lPD58KQsRJ+
         CaBA==
X-Gm-Message-State: APt69E1/D10IPAMivOiJ3X3VS3s/UdAR71vlWshWYG0aRthIJP1bI3lN
        V/utjGTGanlqrLdpacxziI6b/A==
X-Google-Smtp-Source: AAOMgpe6tu7yHYzdxs+zbDHCLBLbo7/iQTobKDyXZBBOlqqPiRFJHrI1gOEdrEcWlb8QaaWQlWLA6A==
X-Received: by 2002:a50:cb4c:: with SMTP id h12-v6mr4912467edi.158.1530760994032;
        Wed, 04 Jul 2018 20:23:14 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z4-v6sm2501828edi.90.2018.07.04.20.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 20:23:13 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] watchdog: sp805: Add clock-frequency property
Date:   Thu,  5 Jul 2018 08:52:48 +0530
Message-Id: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9849db0..d830dbc 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -65,6 +66,7 @@ struct sp805_wdt {
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
+	u64				rate;
 	struct amba_device		*adev;
 	unsigned int			load_val;
 };
@@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	if (wdt->rate)
+		rate = wdt->rate;
+	else
+		rate = clk_get_rate(wdt->clk);
 
 	/*
 	 * sp805 runs counter with given value twice, after the end of first
@@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	if (wdt->rate)
+		rate = wdt->rate;
+	else
+		rate = clk_get_rate(wdt->clk);
 
 	spin_lock(&wdt->lock);
 	load = readl_relaxed(wdt->base + WDTVALUE);
@@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 
 	wdt->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-		dev_warn(&adev->dev, "Clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		goto err;
+		dev_warn(&adev->dev, "Clock device not found\n");
+		wdt->clk = NULL;
+		/*
+		 * When Driver probe with ACPI device, clock devices
+		 * are not available, so watchdog rate get from
+		 * clock-frequency property given in _DSD object.
+		 */
+		device_property_read_u64(&adev->dev, "clock-frequency",
+					 &wdt->rate);
+		if (!wdt->rate) {
+			ret = -ENODEV;
+			goto err;
+		}
 	}
 
+
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;
-- 
2.7.4

