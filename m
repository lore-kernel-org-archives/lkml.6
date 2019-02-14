Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822AEC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476D8222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ug/rn53s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439842AbfBNTdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42773 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439821AbfBNTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3549606pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDmxxzjCCLiFJpoIHfbvmHM+WtyBWfZzHa7paSm6QGI=;
        b=Ug/rn53seStgQKetu4l86Pn/tP9IzrtjSHXmCu80yJ1G1X6MyRj2q1Z97To2fADWUb
         UMU6Ys1oMlbxj29Ym154Q5OFolUXgLX/bDGyMWfZyy+TnugXqjjo3m0znsESaDeJAl3F
         SD4751gvEryqZ6Ld7JGzgHZmV6xBRjnwPCOzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDmxxzjCCLiFJpoIHfbvmHM+WtyBWfZzHa7paSm6QGI=;
        b=W7fMl3cTW2dA2LlyfX6fTikLXLs1TQN70t7Tmy0pG7ErPRu/pGhdTZjkwR3OlHOuE8
         0IIQd+msRNGgbGUdKBA0wwCbk9dDaAv9Fay7CJFTetUGxf0i+7GIL+p2Y1iNrNccwbIp
         tzXADQ8gKvYHJtgML0yzeNe3LY7qm7Hf/RuoXrOcxv5IrqVqe/BZfeFdAzQFUYT8zKWN
         5W6FzGgimJRmmVFWF7odz+K0nuIXKLGswov9DGen90sUBYEJegL2IaK6/+uHTBFTRAaK
         sMLxC3ny3I45GaiSGdfH0/4A7vEDwQw19+JrBpNO+Uc5baHbG000INLyNnOdDPazPcmK
         telg==
X-Gm-Message-State: AHQUAubWvADCDj+b/I077qO/Zn86uQ5iVkdRxUspvfkm7b5QCr69niFa
        xFL/A5rGpDPtGnqDzroBgis3wA==
X-Google-Smtp-Source: AHgI3IY4y1me3baq2nOd8mvboYHGJlofzAkb/9sc4TzbmT1NCoVHXusfBNijz/AatZ4iaxqzKpXmEA==
X-Received: by 2002:a63:1105:: with SMTP id g5mr5356652pgl.322.1550172798908;
        Thu, 14 Feb 2019 11:33:18 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:18 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 08/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
Date:   Fri, 15 Feb 2019 01:02:35 +0530
Message-Id: <20190214193236.7504-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burst mode in DSI would require separate setup initialization
with respect to conventional video mode.

Allwinner DSI controller would need below sequence to setup the
burst mode.
1) configure the burst drq.
2) configure the burst line.
3) finally enable mode.

- To configure burst drq, controller would require to compute the
  edge0, edge1 and fill into burst mode register.

- To configure burst line, controller would require to compute the
  line, sync values and fill into burst line register.

- Enable burst mode, would require to enable burst mode bit in DSI
  control register.

Since there is no direct documentation for these computations
the edge and line formulas are taken from BSP code (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

line_num = panel->lcd_ht*dsi_pixel_bits[panel->lcd_dsi_format]/
	  (8*panel->lcd_dsi_lane);
edge1 = sync_point+(panel->lcd_x+panel->lcd_hbp+20)*
	dsi_pixel_bits[panel->lcd_dsi_format] /(8*panel->lcd_dsi_lane);
edge1 = (edge1>line_num)?line_num:edge1;
edge0 = edge1+(panel->lcd_x+40)*tcon_div/8;
edge0 = (edge0>line_num)?(edge0-line_num):1;

Note: edge0 computation would require tcon0 divider and it's value is
always 4 in Allwinner BSP. This patch find out the divider value at
runtime by reading tcon clocks.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 70 ++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 62b4c822bf18..63b83b47cf0d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -356,6 +356,41 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u32 sun6i_dsi_get_edge1(struct sun6i_dsi *dsi,
+			       struct drm_display_mode *mode, u32 sync_point)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	u32 hact_sync_bp;
+
+	/* Horizontal timings duration excluding front porch */
+	hact_sync_bp = (mode->hdisplay + mode->htotal - mode->hsync_start);
+
+	return (sync_point + ((hact_sync_bp + 20) * bpp / (8 * device->lanes)));
+}
+
+static u32 sun6i_dsi_get_edge0(struct sun6i_dsi *dsi,
+			       struct drm_display_mode *mode, u32 edge1)
+{
+	struct sun4i_tcon *tcon = dsi->tcon;
+	unsigned long dclk_rate, dclk_parent_rate, tcon0_div;
+
+	dclk_rate = clk_get_rate(tcon->dclk);
+	dclk_parent_rate = clk_get_rate(clk_get_parent(tcon->dclk));
+	tcon0_div = dclk_parent_rate / dclk_rate;
+
+	return (edge1 + (mode->hdisplay + 40) * tcon0_div / 8);
+}
+
+static u32 sun6i_dsi_get_line_num(struct sun6i_dsi *dsi,
+				  struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+
+	return (mode->htotal * bpp / (8 * device->lanes));
+}
+
 static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
 			      struct drm_display_mode *mode)
 {
@@ -422,8 +457,32 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
-		     sun6i_dsi_get_drq(dsi, mode));
+	struct mipi_dsi_device *device = dsi->device;
+	u32 sync_point = 40;
+	u32 line_num = sun6i_dsi_get_line_num(dsi, mode);
+	u32 edge1 = sun6i_dsi_get_edge1(dsi, mode, sync_point);
+	u32 edge0 = sun6i_dsi_get_edge0(dsi, mode, edge1);
+	u32 val;
+
+	if (edge1 > line_num)
+		edge1 = line_num;
+
+	if (edge0 > line_num)
+		edge0 -= line_num;
+	else
+		edge0 = 1;
+
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
+		     SUN6I_DSI_BURST_DRQ_EDGE1(edge1) |
+		     SUN6I_DSI_BURST_DRQ_EDGE0(edge0));
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
+		     SUN6I_DSI_BURST_LINE_NUM(line_num) |
+		     SUN6I_DSI_BURST_LINE_SYNC_POINT(sync_point));
+
+	/* enable burst mode */
+	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
@@ -708,7 +767,12 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 		     SUN6I_DSI_BASIC_CTL1_VIDEO_PRECISION |
 		     SUN6I_DSI_BASIC_CTL1_VIDEO_MODE);
 
-	sun6i_dsi_setup_burst(dsi, mode);
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     sun6i_dsi_get_drq(dsi, mode));
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		sun6i_dsi_setup_burst(dsi, mode);
+
 	sun6i_dsi_setup_inst_loop(dsi, mode);
 	sun6i_dsi_setup_format(dsi, mode);
 	sun6i_dsi_setup_timings(dsi, mode);
-- 
2.18.0.321.gffc6fa0e3

