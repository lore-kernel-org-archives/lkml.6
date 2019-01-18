Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9112BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d6aha0jJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfARQcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43452 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfARQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so6828981pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOpV9kWgl6fPiQYwlaCx8OyWJJcNBqxFugJ0u7HKZAs=;
        b=d6aha0jJ8ELbRTp+llXNIiuOgx/q6L5FG6lvC/D4tyjiNRIyC/DYQEEJlv0XMhOJf2
         mcRKG/Oa0zpBpjGEPhFUsZw5O8O39W9EYSAdNh8VJ5ger/kZWtGyt5aZlb7HSHL50jwn
         wq7jos+FOXrCnm0dJlhkRbWAlKKtcRaxO0ZpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOpV9kWgl6fPiQYwlaCx8OyWJJcNBqxFugJ0u7HKZAs=;
        b=Tyf5OTUxJW0Y9OcKCBhz/Hd2NNIhPAtuW3bb+bCmh3Sv2SPptan4iKwdEOR2MGNCxY
         2jQGLsIrs+S2laCroF6ce2C08e1QwV6C78idlX+CAbiIqWbHSb9qlg7ee7IC73bY/EsD
         O0tfy2jUxgWoqBs0HigDblxhbP9UHcgq78YWjNesl8pqDHeXYIRlv7OmAB9DhpokcJK7
         ZWXJs2zx5qATHVkUi9SOWm0JxT6shxdVHFZSSzpv3NLiBIFM50L/4qFbZl38rcGgStU8
         682IyL5lCMasdfqI04w9u77nUTsk5+gWPmakJiFNfX2qP7H2U/oKTmYCqIcYWCMrZpnH
         CX/g==
X-Gm-Message-State: AJcUukegyRYwy55jIvKe9GGUnjggSQ1Yc+/bDgft4NxZIsM0mAsz7wyv
        YGEQzkJMx4nOVuGD1ab1EnhsMA==
X-Google-Smtp-Source: ALg8bN5jKvPhamjpZVQVftU4XuNjs6nwNuwo+D8gYMSFrsLbALAl9T7qkHH/4PpnkfpKusxk6djl2A==
X-Received: by 2002:a63:7e5b:: with SMTP id o27mr18246286pgn.214.1547829137456;
        Fri, 18 Jan 2019 08:32:17 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:32:16 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 2/6] media: sun6i: Add mod_rate quirk
Date:   Fri, 18 Jan 2019 22:01:54 +0530
Message-Id: <20190118163158.21418-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately default CSI_SCLK rate cannot work properly to
drive the connected sensor interface, particularly on few
Allwinner SoC's like A64.

So, add mod_rate quirk via driver data so-that the respective
SoC's which require to alter the default mod clock rate can assign
the operating clock rate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..a9aef630c3b4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -15,6 +15,7 @@
 #include <linux/ioctl.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -28,8 +29,13 @@
 
 #define MODULE_NAME	"sun6i-csi"
 
+struct sun6i_csi_variant {
+	unsigned long			mod_rate;
+};
+
 struct sun6i_csi_dev {
 	struct sun6i_csi		csi;
+	const struct sun6i_csi_variant	*variant;
 	struct device			*dev;
 
 	struct regmap			*regmap;
@@ -161,15 +167,20 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
 
 		clk_disable_unprepare(sdev->clk_ram);
+		if (sdev->variant->mod_rate)
+			clk_rate_exclusive_put(sdev->clk_mod);
 		clk_disable_unprepare(sdev->clk_mod);
 		reset_control_assert(sdev->rstc_bus);
 		return 0;
 	}
 
+	if (sdev->variant->mod_rate)
+		clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
+
 	ret = clk_prepare_enable(sdev->clk_mod);
 	if (ret) {
 		dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
-		return ret;
+		goto clk_mod_put;
 	}
 
 	ret = clk_prepare_enable(sdev->clk_ram);
@@ -192,6 +203,9 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 	clk_disable_unprepare(sdev->clk_ram);
 clk_mod_disable:
 	clk_disable_unprepare(sdev->clk_mod);
+clk_mod_put:
+	if (sdev->variant->mod_rate)
+		clk_rate_exclusive_put(sdev->clk_mod);
 	return ret;
 }
 
@@ -871,6 +885,7 @@ static int sun6i_csi_probe(struct platform_device *pdev)
 	sdev->dev = &pdev->dev;
 	/* The DMA bus has the memory mapped at 0 */
 	sdev->dev->dma_pfn_offset = PHYS_OFFSET >> PAGE_SHIFT;
+	sdev->variant = of_device_get_match_data(sdev->dev);
 
 	ret = sun6i_csi_resource_request(sdev, pdev);
 	if (ret)
@@ -891,10 +906,13 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun6i_csi_variant sun6i_a31_csi = {
+};
+
 static const struct of_device_id sun6i_csi_of_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-csi", },
-	{ .compatible = "allwinner,sun8i-h3-csi", },
-	{ .compatible = "allwinner,sun8i-v3s-csi", },
+	{ .compatible = "allwinner,sun6i-a31-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun8i-h3-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun8i-v3s-csi", .data = &sun6i_a31_csi, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3

