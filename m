Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF264C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F32621871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFzEOu45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeLRNih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:37 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:33335 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLRNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:36 -0500
Received: by mail-qt1-f181.google.com with SMTP id l11so18186198qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kZ876vEU/Oii4iRqu5x0JYnZNEW+hbH0bFximUvVlIY=;
        b=RFzEOu45Zq8si/LvXbxqng03UoceixrjF0Lz29M2a99JosWLLX7a2qXVAmn0LnU2aN
         C+AvNmIs7K/YLO/ybv3ETzHQepTuKYlv29aDYBDjP/vUmGZoEVUDgACbz6HTiR9GQKqL
         RmC6otXMx1KLEtBVQasdNkHuY9DYytIObdRyEkbs75gkuT/gi2V0SXGNVEZjEgXM23U9
         bjUI2DTBStoHk2Vbf1Rr4145Bz9P80H3fk4/ec/7u+3SfieZBaEVub6dcUc6espi9PoO
         9jjk+7GOS3ok1XxWdaXv0NHuT+yC5FLBaSV7kNQU18lcQfdOP1MLwMRb6j3D6pSiXuxw
         gNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kZ876vEU/Oii4iRqu5x0JYnZNEW+hbH0bFximUvVlIY=;
        b=Gsjc7b6CeOIGwQEYdjUWHHweOKWdujkHUAmLUPnAA5xwFSHKstxwXDLvcdspAAtxLH
         OuuYxKy08p9SwZh6CdBW1GC6CUf6PcjKOoNkEQHNzssjLsZDpgy+WWpN2sirCAI6Vdox
         FKhbVGWD2JOZPFIjhL72jWYH3ZzSnBEcDuXEpZsa6sYW+jArDMxOBuicm0WCoILMewMh
         PiSeUR6KGl3LDqOabhR6qjfevNuHvfHD1cvvUTGCEcWvUoXoBkPOrEYmI7pExQAN1lKZ
         j8wCpmbMGzUIOnG2eddaOdLK41kV0lEFfUWvYwWgQdwu/oAMjQNAGWYuLk6bXhqgXzfj
         wLjw==
X-Gm-Message-State: AA+aEWYIuZQSSSpSsIbUObmhLqDPJFItNowSkSrRQRRbjtmlWs/w4h93
        T3sAzf0N9EYjZ78HT/ew4s0=
X-Google-Smtp-Source: AFSGD/VQyWX62NaHIQyXGT3M2vLe4oIB7DhJj05CpG5YfJ4maz2/llJBAUKj4B/wZGnLue3uZdBkyg==
X-Received: by 2002:ac8:1c50:: with SMTP id j16mr17996803qtk.320.1545140314875;
        Tue, 18 Dec 2018 05:38:34 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f201sm7535392qke.0.2018.12.18.05.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:34 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:30 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] drm: meson: Delete base.id prints
Message-ID: <20181218133830.tlm4ndyrefwvvdyt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes base.id prints from drm_display_mode                         
objects in meson files. It removes dependency from drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index d8c5cc34e22e..b203560f666d 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -365,7 +365,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	unsigned int wr_clk =
 		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 
-	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
+	DRM_DEBUG_DRIVER("\"%s\"\n", mode->name);
 
 	/* Enable clocks */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
@@ -555,8 +555,8 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	int vic = drm_match_cea_mode(mode);
 	enum drm_mode_status status;
 
-	DRM_DEBUG_DRIVER("Modeline %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
-		mode->base.id, mode->name, mode->vrefresh, mode->clock,
+	DRM_DEBUG_DRIVER("Modeline \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
+		mode->name, mode->vrefresh, mode->clock,
 		mode->hdisplay, mode->hsync_start,
 		mode->hsync_end, mode->htotal,
 		mode->vdisplay, mode->vsync_start,
@@ -650,8 +650,7 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
 
-	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
-			 mode->base.id, mode->name, vic);
+	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
 	/* VENC + VENC-DVI Mode setup */
 	meson_venc_hdmi_mode_set(priv, vic, mode);
-- 
2.17.1

