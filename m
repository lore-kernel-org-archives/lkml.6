Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496BC21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V+GKYnGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439749AbfBNT0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439734AbfBNT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so3571011pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5N07oU2k2LE7t0QlvtqZwD41GQ0JhcM9+FfY0qN6oOk=;
        b=V+GKYnGRmRLbvW/9tmZOQnqrqzQVvOyAc9i+ybY4q6VXxG4RFFoK8DqK2T+BsWuglr
         fzRDTS2pzI3jNAYMc68T7vBJC4gSHKsp4sLqVf7YsrB/efnhLsJj1LbwKuj5iZUKyMAQ
         vnvc9xkb66E+nMMT2llLXX0UGrq8rxSx9+1NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5N07oU2k2LE7t0QlvtqZwD41GQ0JhcM9+FfY0qN6oOk=;
        b=Rjh6RMHu8JaSrJXmN49Uvl8kFxL1iz1G3i24U37DFD7tbNmHQB3O6KphfegS0xjHop
         Z5Ui+h1ENofIHxiQWEsPd/CGkK68VCGoDBZx6rzUBJHXSkApADJGoSYL59suFc8lE9gA
         u1B4HV0kPeehA40nnHCh8s9HjM/uOESzzk+kQ0nb1VFho/IHcv0KP0LBboye2v8xgFja
         /51HRhd7si/Gtw2jEsY4MS4t9TtSR3dNSZA4vuz0TWdgwLlKKCWoNJlUYKKm/6lwXGkZ
         jkSASgl34DI05RoNaeDScdHr0NlonYuxgRjjrbEvHxH6ky5P4UuHn9fiXOOmVSfqpwFM
         R/PQ==
X-Gm-Message-State: AHQUAub6fYqlND28ljBWCLxDY/UjIv2gXiZ6hmQp3A5ejVAIYRpjrvBU
        0MA8cMZ8v76qwVNDJM942j0Y9g==
X-Google-Smtp-Source: AHgI3IYa3jkq2zGmzYMgdNauEe0uYUJbfzKwzALB7vINehRpWgxtagKi09HgO0hbmCn1Lw5pM+LpXA==
X-Received: by 2002:a62:168e:: with SMTP id 136mr5787813pfw.116.1550172389962;
        Thu, 14 Feb 2019 11:26:29 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:29 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 7/8] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
Date:   Fri, 15 Feb 2019 00:55:43 +0530
Message-Id: <20190214192544.7314-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vertical video start delay is computed by excluding vertical porch
value from total vertical timings, but the current driver excluding
vertical porch along with vertical sync values from total vertical
timings resulting wrong start delay.

This patch trying to update the video start delay by subtracting
vertical porch from vertical total, on the other hand it added 1
extra start_delay line for TCON based on the Allwinner BSP reference.

BSP code form BPI-M64-bsp is computing video start delay as
(from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
=> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
=> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
   - panel->lcd_y - (panel->lcd_vbp)
=> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
  			     - panel->lcd_y - panel->lcd_vbp
=> timmings->ver_front_porch

So, update the start delay computation accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a08dfdcbe9e8..31cf9c58e98d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -358,7 +358,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
+	u32 vfp, start_delay;
+
+	/* vertical front porch */
+	vfp = mode->vsync_start - mode->vdisplay;
+
+	/* start_delay = vertical total - vertical front porch */
+	start_delay = mode->vtotal - vfp;
+
+	/* add extra 1 delay line for TCON, as per Allwinner BSP */
+	start_delay = 1;
+
+	if (start_delay > mode->vtotal)
+		start_delay -= mode->vtotal;
+
+	if (!start_delay)
+		start_delay = 1;
+
+	return start_delay;
 }
 
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

