Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA735C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B422086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJpwY6PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeLSVWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:22:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbeLSVWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:22:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so23896403qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLN1b87g6HxfZ8nfb0/5fJH5ekCkwBf+QMlkH48lFsU=;
        b=HJpwY6PNuNWZBD36XbR8Be22tnb2nhSCLADVTe9r42xnDAtUpRDGtKfTOIaDrCOeGP
         2CXIsT/YOk7usShKt2ATcmzw2NmOW/fdjor8HRoZ1GHCH/HK4+v8Mh6oRVXselLzC3hg
         YN4xLcJ2FrbYmIM++VbBix2cZgWsRFiznCvyXM66HvMnQtLQoVYy7cKYmeAiuTo6uB6J
         OHyAEx5HRBjW5FDXlkV8Agama6ZWnksA6+3lePvbJ9xssgpN9Lyq68imcJ+3n0xpw+Un
         Vyp1iAmNKpp8Bx5OkLHh5RgsY8TfRrzHfjD0EsDLKF4TEU3/cq8Dr1em3fAByw2hXPKZ
         WOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLN1b87g6HxfZ8nfb0/5fJH5ekCkwBf+QMlkH48lFsU=;
        b=Q9AJOv5x/3tfjSDh7/zTkGyoy1fxIOvNVc9RqplSeqDGHg9zYqtiCPSlR2uapuSafD
         DGUv6sKiSXTy4oUPD+5C3EwwLtpoYvO/7VJCmMFO1AW1v/Mya3Vow7dp6VJsh5y50gYi
         xdqQY5Is9FPfvKyl5z1NsYQd/0/0MmL+hcf7NDZ+keCCqs1tsFDSnwwSqnhq8JgRdgXu
         TbcEiahnbfpYEfjadsvlUXqpD1JqHMS1tnr/KNxDFOkg3dURLp2uBZzR4/apVDipddXi
         xnNI2FhdgiMg/yEylQQ1XQTRptu/Bn7F1MX3HIy1H6uq1sLePiQMhmVaO1iCFR9ttPAT
         9sdw==
X-Gm-Message-State: AA+aEWaNYOj1Jlvky/UfAF2nHIqKx9Id4A75z4KqzTw07UUPFJYzkRkc
        GJ7dz+PeDBbLfu2GrXo6xgw=
X-Google-Smtp-Source: AFSGD/UDD/ekgMSkc/uH70R1j/Cnu2cnrbP1xXPw9KmUmeYveUBE6+MiFtGzDUQDBy6cnima5DCu8A==
X-Received: by 2002:a0c:aa56:: with SMTP id e22mr23932831qvb.158.1545254571540;
        Wed, 19 Dec 2018 13:22:51 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 20sm3163188qtp.54.2018.12.19.13.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:22:51 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:22:46 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] drm: meson: Cleanup on drm_display_mode print str
Message-ID: <4f5cb772dd73777a345f3032e80552e35eff5bfd.1545254191.git.shayenneluzmoura@gmail.com>
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545254191.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in meson files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index d8c5cc34e22e..0b6c29cdd934 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -365,7 +365,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	unsigned int wr_clk =
 		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 
-	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
+	DRM_DEBUG_DRIVER("\"%s\"\n", mode->name);
 
 	/* Enable clocks */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
@@ -555,12 +555,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	int vic = drm_match_cea_mode(mode);
 	enum drm_mode_status status;
 
-	DRM_DEBUG_DRIVER("Modeline %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
-		mode->base.id, mode->name, mode->vrefresh, mode->clock,
-		mode->hdisplay, mode->hsync_start,
-		mode->hsync_end, mode->htotal,
-		mode->vdisplay, mode->vsync_start,
-		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
+	DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 
 	/* Check against non-VIC supported modes */
 	if (!vic) {
@@ -650,8 +645,7 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
 
-	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
-			 mode->base.id, mode->name, vic);
+	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
 	/* VENC + VENC-DVI Mode setup */
 	meson_venc_hdmi_mode_set(priv, vic, mode);
-- 
2.17.1

