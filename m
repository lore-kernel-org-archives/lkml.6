Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cIYFEmQ3GVvSYgAAmS7hNA
	; Thu, 07 Jun 2018 13:47:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2FE696089E; Thu,  7 Jun 2018 13:47:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BIRhsghq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 96992601B4;
	Thu,  7 Jun 2018 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96992601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeFGNrN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:47:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40746 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeFGNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:47:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so4953288pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p6WRACkNnLRaA9eFoxZmmzDsYSOhuAQJc38TqBrd6Rg=;
        b=BIRhsghqBWWQhMbEQnohKaPNm53CrkGqXn+TpRMO76Vg8H+h8PrR5chpNnlVee7Dp/
         aUExuyqNVouSKe/AZE8+aXXtIItZ4lPOCJZyCeDeQ1ZZ703XJoR8ACr73KxutlJ9oBll
         Fs7s9h12+8LrNanrG3B0w3DtiJ5aWkwJg1RHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p6WRACkNnLRaA9eFoxZmmzDsYSOhuAQJc38TqBrd6Rg=;
        b=mZP8S/sOFT8h9b2McbHSza02wlZE1OVAYzRwZnj9tpKR+JJgua9a1g/0dvpMBEPVZU
         VqUkDfyoaoZrvbSrwVOLXK5qdvniNU9K6/A0t9SBE6ueKCW7F+VJlmAdrjOUGe01N7XB
         ZWV6W9a1PUake0SLvWcM18A6/jZ02a97+VBP08Y8AXBsCxU8uG+pb6UrDsyrNMxZhoxJ
         96RzHujRiSxXIdE+ZFQGNslcLoX2X4CxMUN6R4xdnJi7YjqGsOy7KBk2vzgh0A1AWNnb
         S6yG/ygLo+GLXoyP9Nrwzk3gssCN4TGESfmBI/qbcb5fijS38p23WqLFPro0oUuglbO7
         iLRg==
X-Gm-Message-State: APt69E2u/9Q7JkFaAJFu2vC7p5ucGRFvfd9ZXbNT7zmFsAUYYrO9mppM
        rIKV2RhURRGOwYPHq2oB79EKwQ==
X-Google-Smtp-Source: ADUXVKJ2AV/32nIA6BmcGY7F8DmF6eM9SG4A280U0yaOkp5wr78/3fpBvrtnsBRYQVkf668RSsfjxg==
X-Received: by 2002:a62:1e02:: with SMTP id e2-v6mr1892464pfe.212.1528379230095;
        Thu, 07 Jun 2018 06:47:10 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id f11-v6sm12721381pgq.18.2018.06.07.06.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:47:09 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Davide Bonfanti <davide.bonfanti@bticino.it>
Cc: Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/4] drm/panel: simple: Add support for Rocktech RK070ER9427 LCD panel
Date: Thu,  7 Jun 2018 19:16:48 +0530
Message-Id: <20180607134648.2902-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Rocktech Display Ltd. RK070ER9427
800(RGB)x480 TFT LCD panel, which can be supported by the
simple panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
- collect Rob r-w-b tag

 .../display/panel/rocktech,rk070er9427.txt         | 25 ++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
new file mode 100644
index 000000000000..eb1fb9f8d1f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
@@ -0,0 +1,25 @@
+Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Required properties:
+- compatible: should be "rocktech,rk070er9427"
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for LCD panel input.
+
+Example:
+	panel {
+		compatible = "rocktech,rk070er9427";
+		backlight = <&backlight_lcd>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..a6c633fd0559 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -745,6 +745,36 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct display_timing rocktech_rk070er9427_timing = {
+	.pixelclock = { 26400000, 33300000, 46800000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 210, 354 },
+	.hback_porch = { 46, 46, 46 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 22, 147 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 1, 1 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc rocktech_rk070er9427 = {
+	.timings = &rocktech_rk070er9427_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.delay = {
+		.prepare = 41,
+		.enable = 50,
+		.unprepare = 41,
+		.disable = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
 	{
 		.clock = 71900,
@@ -2226,6 +2256,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "qiaodian,qd43003c0-40",
 		.data = &qd43003c0_40,
+	}, {
+		.compatible = "rocktech,rk070er9427",
+		.data = &rocktech_rk070er9427,
 	}, {
 		.compatible = "samsung,lsn122dl01-c01",
 		.data = &samsung_lsn122dl01_c01,
-- 
2.14.3
