Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1659C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3B222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G6kR7dmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405975AbfBNTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36556 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439844AbfBNTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so3599312pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19y3NFakPeHXY1zH8KnDf83WNrHHUKHDkZ84jCJtIp4=;
        b=G6kR7dmHa4ZyWHpN3fO0+0fN7GZ6QTCxKC2gsrRJZ4n7Rpa3N98OGiZMpah9yIffl2
         KxaQJZdscp+9MXf3VA2OC7nVh7fC7mpuJGLNrD3jJ70b29DsO3NxhqcsGsGqXXAzNQLq
         I2eI0p1717HVSVxkb6F803/d/HsF5Fv4QZ8FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19y3NFakPeHXY1zH8KnDf83WNrHHUKHDkZ84jCJtIp4=;
        b=A4pdlhKDvaFByL80kjDEmm0BqCvoB38awe9KTZN8hLdvA7MyHJZqbrR/1Cfk9p9Dic
         5SEpVGuhsxybv1SkpyGcffP09Dqg8VSJJ9fM4aear3Mgr5nnJaLaWSO03KZYcXDt9IqM
         5MlkpDIb6pM7fBQbFbBMWKR6RwR7bKDBqqtj82qGzKiTiH2tpMRXWB7rprTdL6pvyY+d
         WMqKOdmTycrLNeU18O7ClMJmrunXHpJfQn8SxKL2R9BPpqjQQTWm8ey9zkW5E1VdFwmz
         JyZmV5yyS4rYLZgnmfhEVL2iZOVuuTdkUiMonnmQNpB36LVqM3+/U9MHrdIhp7/PFg9C
         DWuw==
X-Gm-Message-State: AHQUAuZ02N0PQr2IwOqrvheioKt4ro1TRXKKbNmW2s3bL+18Lu2glueS
        FV63mMW3ESi4O28JuUnj92sT4A==
X-Google-Smtp-Source: AHgI3IaiQm+AOueGS0W7QlK2nb6SV5QrYhhCcGjVaQOI8XBvu5vulXxgbm/qCrHac+tB3G2fAiUu3A==
X-Received: by 2002:a63:8b43:: with SMTP id j64mr1458946pge.332.1550172802340;
        Thu, 14 Feb 2019 11:33:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:21 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 09/10] drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
Date:   Fri, 15 Feb 2019 01:02:36 +0530
Message-Id: <20190214193236.7504-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The burst mode panels with 4-lane would require to enable trail bits
in DSI basic control register.

So, enable 2byte trail and trail_env for 4-lane burst mode devices.

Allwinner A64 BSP should also relie on same setup for enabling trail
bit in DSI controller.

Reference code avialable in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 63b83b47cf0d..ec9424b6da9e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -34,6 +34,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -482,6 +484,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	/* enable burst mode */
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3

