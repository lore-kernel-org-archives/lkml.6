Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C43DC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383E320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiddD2ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383E320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937069AbeFSBq1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:46:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38068 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeFSBqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:46:25 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so8380058pgf.5;
        Mon, 18 Jun 2018 18:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=geNfsEUGDsaxdlwGM4b1h31JAgA/mrXS/EMPQ8aEkRw=;
        b=fiddD2maIZND01ynZEyBjuph40rEMUp8idv5in/3bsXuPHBWn7saSxb10ynxIhEYBv
         ZsZwoNA45oF7aqAqS1HpsewNncNAfphmkiS26BMs5afe0D5qPG+OAnueQ78EHLp0I3oD
         zG3Xpa3AlqPosWrHD9rrM7+GjZFw4CxufpmSDV/KMs5XewaH6OVi4hJgU5DBE61wVqXu
         XHT6Jgin7oz10BBtc2mVuswtA1ELi1z6Gp4zod+2OrfIdrftWAHjzMF/c5IwqLpOM8aD
         TbrAg0mzIHt57bbpInXLAGVf/F4eRMcRb5BGhrLCHKuuRxx3n1quik2Cu8xqs2h4xep3
         RKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=geNfsEUGDsaxdlwGM4b1h31JAgA/mrXS/EMPQ8aEkRw=;
        b=tbpKK6whkoahNfbeAnLLpPz6nwKiiyWOccGDi7qwcBM7DjwavrfCcI/044Hhs4EaIU
         XbbnbRJFD8Fr7Q/cAQotjk0ctIXaC5QSqDS30pbXup1iHsic4m37Wv/nPd0BehOLjVHy
         6xQrmMZ/MSfEYRgyFg+AHE7a/VSwoADHYcxgrTgCD5xR7bnKUJmBoidFkUsL38hoIFJh
         9ZoF1YJszoml8CMmHYafExLYUZWWMCL8wVyj7t416BjgshNzamH00lVzlGr6IlbA1Hv1
         0PI3gUkTiHO2BRb5hnYkk8qkX0qE7gIGxzcUcGXE92OJOpm5n42aq544B12GpXxlLdqz
         tLZQ==
X-Gm-Message-State: APt69E0G0hggPJPJtNt8KRzgarzKxPV7hUfvPhVZLbU2Qo1Ai96YJjO9
        9EbFsiTijM1guAm5VIRiDHo=
X-Google-Smtp-Source: ADUXVKJiiFH0Ephk8H8YCkxbkhfeP7SoRFo4bGXvHThcaDvsxdAwRH45hBcqU4egexa+HbN9VT6UFQ==
X-Received: by 2002:a62:6b06:: with SMTP id g6-v6mr15718144pfc.96.1529372784499;
        Mon, 18 Jun 2018 18:46:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:1600:17a6:2407:f707:f7f9])
        by smtp.gmail.com with ESMTPSA id s27-v6sm33966155pfk.184.2018.06.18.18.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 18:46:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] of/platform: add initcall_debug logs for device creates
Date:   Mon, 18 Jun 2018 18:46:08 -0700
Message-Id: <20180619014608.92061-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add initcall_debug logs for the amount of time taken by each OF platform
bus device create call.  For example:

   of platform device create /reserved-memory/ramoops@a3800000 took
   3255 usecs

initcall_debug already reports the total of all such device creates
as a single entry for function of_platform_default_populate_init (or
similar, depending on the board).  The new logs help identify which of
the potentially hundreds of device inits take significant amounts of
time.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/of/platform.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

Note it's likely only a few devices take significant lengths of time to
init, whereas there may be hundreds of uninteresting cases also logged.
Adding a threshold for reporting might be desirable, although for boot
time sleuthing it's probably fine to generate a ton of output and narrow
down the points of interest with tools.

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6925d993e1f0..eeb4c595f43c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -14,6 +14,7 @@
 #include <linux/amba/bus.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -159,6 +160,19 @@ struct platform_device *of_device_alloc(struct device_node *np,
 }
 EXPORT_SYMBOL(of_device_alloc);
 
+static void of_platform_log_inittime(struct device_node *node,
+				     ktime_t starttime)
+{
+	ktime_t delta, endtime;
+	unsigned long long duration;
+
+	endtime = ktime_get();
+	delta = ktime_sub(endtime, starttime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	pr_debug("of platform device create %s took %lld usecs\n",
+		 node->full_name, duration);
+}
+
 /**
  * of_platform_device_create_pdata - Alloc, initialize and register an of_device
  * @np: pointer to node to create device for
@@ -176,6 +190,8 @@ static struct platform_device *of_platform_device_create_pdata(
 					struct device *parent)
 {
 	struct platform_device *dev;
+	ktime_t starttime = 0;
+	int ret;
 
 	if (!of_device_is_available(np) ||
 	    of_node_test_and_set_flag(np, OF_POPULATED))
@@ -187,9 +203,14 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
+	if (initcall_debug)
+		starttime = ktime_get();
 	of_msi_configure(&dev->dev, dev->dev.of_node);
+	ret = of_device_add(dev);
+	if (initcall_debug)
+		of_platform_log_inittime(np, starttime);
 
-	if (of_device_add(dev) != 0) {
+	if (ret != 0) {
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -352,6 +373,7 @@ static int of_platform_bus_create(struct device_node *bus,
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
+	ktime_t starttime = 0;
 	int rc = 0;
 
 	/* Make sure it has a compatible property */
@@ -384,7 +406,11 @@ static int of_platform_bus_create(struct device_node *bus,
 		 * Don't return an error here to keep compatibility with older
 		 * device tree files.
 		 */
+		if (initcall_debug)
+			starttime = ktime_get();
 		of_amba_device_create(bus, bus_id, platform_data, parent);
+		if (initcall_debug)
+			of_platform_log_inittime(bus, starttime);
 		return 0;
 	}
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

