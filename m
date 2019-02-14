Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647F721B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dbkFqMfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439759AbfBNT0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38202 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439725AbfBNT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3581781pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l45/w0iXjOS/5kE7BbpDMgm34gyLbKfVsq3DBo0xqe0=;
        b=dbkFqMfikgxyGeQmRCQmyLfUMr1v9qGRB/1u1KREh4PmaL3FKvldPTGzwqHsTAZriR
         qTNMVBshoZFnhTqq62vjZdUezp6D3LV4DXsQxSoXWlE7w1p5/nz8K9dHVjUI0uewmm/3
         Tx6ZYGS+edH/xG+wyuR+MLY2LA5OsTE2FbXxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l45/w0iXjOS/5kE7BbpDMgm34gyLbKfVsq3DBo0xqe0=;
        b=R/t38+EZl6GF6+MiQgpVhPBsU5aHXMuhGrtokrvgtK1qAEaEQar4XbeP0PfnoiIzcg
         3eFdmiVWkn1MifAVvAH2vKRQZK8uwoNaOXbiwLbxVqyI/Qk5ZseDahGeH2JfihW7UF0O
         qrSnXGEI5Z+alHLTA+F0Ka1YHDLE3gCChPBGH39iINE4m8KT2YIm81ffONcwiTzcaTBF
         d/ADeIW7P+DRoIUSpMF7vWrBOTi+QVFpKpWI4NEMvIX6kxv1Cr8N7e729dEX7Noez98R
         y4lHqzSWiLlAtpOLfkCZfhqWI8V3VMXz2+psyJT+L/jQDHbvV7e5igRoo/3zBwzK3gNC
         pJxA==
X-Gm-Message-State: AHQUAuZnyYrV7L/n9RiZXuzE8JfBj1FzLGazxe2s9b8h7UYvHTs/gLup
        Izo9kYh6c2M4tpszgNL5kLrJsg==
X-Google-Smtp-Source: AHgI3Ia7Twnq5r7dgW0TFcIF1mUc1g5B8v31Ffn2m2aFBQM1Cv15c3uxxsag0SXtBDHRvwgLsyoMtA==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr5742054pfi.31.1550172386534;
        Thu, 14 Feb 2019 11:26:26 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:25 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 6/8] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
Date:   Fri, 15 Feb 2019 00:55:42 +0530
Message-Id: <20190214192544.7314-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other dsi setup timings, or hblk for that matter vblk would
also require compute the timings based payload equation along with
packet overhead.

But, on the other hand vblk computation is also depends on device
lane number.
- for 4 lane devices, it is computed based on vtotal, packet overhead
  along with hblk value.
- for others devices, it is simply 0

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 29 +++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a64e6ec00f22..a08dfdcbe9e8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -446,6 +446,27 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
 }
 
+static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode, u16 hblk)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	int tmp;
+
+	if (device->lanes != 4)
+		return 0;
+
+	/*
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define VBLK_PACKET_OVERHEAD	6
+	tmp = (mode->htotal * Bpp) * mode->vtotal -
+	      (hblk + VBLK_PACKET_OVERHEAD);
+
+	return (device->lanes - tmp % device->lanes);
+}
+
 static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 				    struct drm_display_mode *mode)
 {
@@ -493,13 +514,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
 		   Bpp - HBLK_PACKET_OVERHEAD);
 
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
-- 
2.18.0.321.gffc6fa0e3

