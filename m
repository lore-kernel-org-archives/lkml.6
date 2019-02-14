Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC3C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D5222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PDVQJJ9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437170AbfBNTc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:32:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39723 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405962AbfBNTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:32:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3663563pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMYAwY4ous29UnB5Oi5EE6ejKMZVZfyoGoBh/UV0aBA=;
        b=PDVQJJ9lTnIR2obHuE8IXjqrGZaBG4bTXc/s/YlPuONeKs6obUjPfE3bRIwDtftPqD
         inGbuX4SqIuL8+GS/1HAjQXeoL/eab3hVu0vZLyAUhlbBq1IQw085V5pIU3jbu7XuOfs
         h+sl/CMRnyVdT/rU7BlJF2VWfHkpyldB7LjBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMYAwY4ous29UnB5Oi5EE6ejKMZVZfyoGoBh/UV0aBA=;
        b=CduqCI42tNTrupwOCxmcUUxWq1GI9ssOAdjzh/YXBB3z69VialVl0BLKIyfJUNY8aQ
         Z7BumNfCRR4w6IDWNfBB/ho7jfD2u/ztkc3d1iEPT5xnOELlcIGrwfmmlpdqttky1fg/
         ZgjR2KW7WRsj032K4P08Xm91DJbtmGzJJHxqpJjL8lAWcsooheCEGaqqleEF40M6zDzf
         w8Obrx9yUHLVC9n//uS3q4Bw1TD4D64KCWBrFHlORhpynnJ9tdRTxCIGj9+hPSVQVM6V
         lrIf1Dnx8kIHw0OUS2QZExzXOAU93bLRRlOQ2/lWGs6D5V24U1HXBybfPK4WeG0dHxtA
         p6pg==
X-Gm-Message-State: AHQUAuaXPCf1RthuMvxvi1rfN44tUMCd6MwLXRuvNvda4TLMd4OjDbAZ
        8VWvAaQqMLT3vWOcX2gaw4qNvQ==
X-Google-Smtp-Source: AHgI3IYrryFfvBkMudqDb5MR15tKo+bXCkdnvLwU/O93NmFvAdhsZeXXx/m3+32FEnW/CaLE3ptqxg==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr5804993plh.99.1550172774582;
        Thu, 14 Feb 2019 11:32:54 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:32:53 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 01/10] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction delay
Date:   Fri, 15 Feb 2019 01:02:28 +0530
Message-Id: <20190214193236.7504-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop N1 instruction delay varies between burst and non-burst video modes.

1) for burst mode panels it is computed based on the panel pixel clock
   along with horizontal sync and porch timings.
2) for non-burst mode panels, it is same as existing (50 - 1)

Reference code is available in BSP (from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
(panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
=> (((mode->htotal - mode->hdisplay) * 150) /
     ((mode->clock / 1000) * 8)) - 50;

This patch add loop N1 computation for burst mode by simplifying
existing code to support all possible modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 3a28d70dbdc1..8184fbcfd9fd 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	u32 hsync_porch, dclk;
+	u16 delay;
+
+	hsync_porch = (mode->htotal - mode->hdisplay);
+	dclk = (mode->clock / 1000);
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		delay = ((hsync_porch * 150) / (dclk * 8)) - 50;
+	else
+		delay = 50 - 1;
+
+	return delay;
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -401,7 +419,7 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
-	u16 delay = 50 - 1;
+	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
-- 
2.18.0.321.gffc6fa0e3

