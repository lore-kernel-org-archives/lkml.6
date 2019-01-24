Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566A3C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2241521726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f0m7RZmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfAXT70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:59:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45290 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfAXT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:59:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so3358974plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cv7G+uVy+k+Tf6IPY0z7Yjji/++uyA4xCwVVFJCJxkM=;
        b=f0m7RZmyu24bHhy+RMBGhJS68qlkuPGVmNyOJ+TuYa1l8utHvIfQCUANzU1trU4H0J
         YUySIARQpI1o2XDCjOlsHDNc/rshvTFF+ioRKXwWDenXF7pOJQ3h8ohK7s+0C33gIMsC
         lVJMy7gV+a4YPVV+9K5g40DXtsvD59X1MvRao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cv7G+uVy+k+Tf6IPY0z7Yjji/++uyA4xCwVVFJCJxkM=;
        b=QWP/ThDpHSo78nkBL5dTyxYEc6Obkhu4fsXj+pxmft1h/b9IlGmmMOP0QSJdmZDhzl
         4gkjCypf5975fdhb8C3qIIhK6dEoxCrqYmEFtFO2x5ZDVCGAaPul9QBxsqxs0MDVmHgC
         VvfqK/5zWC7+ARwCjh83Mwt6Pd0VORvlPtj+us87fU4Y3Hq1qwKJPq5EIJsS55A4wEU0
         PKIFuNHXaJUPaqTpkQUPH4p4AjWAPbc2asWA89sgtpkJT04MbnH6Ez6wWXNXTaY3reiO
         /Eb/5RvecYSh3G0RgE1tS3poqnFz5D0LohrMzXE6Xb15gWZi/rPQL7GnrBJPZszWDhsU
         Glgg==
X-Gm-Message-State: AJcUukfcG9dIUJUfueGMFl9tTAiBPArIjZudrhaN5bRsnvSXkkJuC4p2
        z7jkhfZb7hfAwwNcGHgMUaEpog==
X-Google-Smtp-Source: ALg8bN7Z4NMxU57+VzhbK4DXHjRQikjqU8XbsmcimCifrDQZOCQOb/CcTQAx3F3utejo5+REng37Lg==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11mr7699262plp.121.1548359962542;
        Thu, 24 Jan 2019 11:59:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:59:21 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 01/22] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction delay
Date:   Fri, 25 Jan 2019 01:28:39 +0530
Message-Id: <20190124195900.22620-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop N1 instruction delay varies between burst and non-burst
video modes. for burst mode panels it is computed based on the
panel clock along with horizontal sync and porch timings and
the rest it is simply (50 - 1)

Reference code is available in BSP (from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
(panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
=> (((mode->htotal - mode->hdisplay) * 150) /
     ((mode->clock / 1000) * 8)) - 50;

So, this patch add loop N1 computation for burst mode, for non-burst
which is already available.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e3b34a345546..a5fcee750bee 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -354,6 +354,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
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
@@ -383,7 +401,7 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
-	u16 delay = 50 - 1;
+	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
-- 
2.18.0.321.gffc6fa0e3

