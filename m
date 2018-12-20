Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6867C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20AE217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiwEhiP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbeLTM1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:27:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46336 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeLTM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:27:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so1496518qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wb00zi3GtM+UDUK6MWkzSBSj/kmc+caJeQJNkmOWNiw=;
        b=MiwEhiP5t2BgTk77tQlrUyHv+HwkLA6GVdOF8LNNv7PUocg0OIq+bt3urH64OFBL2x
         r7KgJQj9XlU/PvSe0+SOp3kGIQGpNp75FhzyQZiz5Blzm82W6PXVkIG+kCl9gcb0PrcE
         xAWOC3mMTt5WgpjbxSXX6kZzRd5j8wDO2mA41uKtjT5LRtUSg1q3L1OTxStJPJXVQQKO
         mSNyMJyKN10IaRNQrJ/FGyvcfSOBmAVUPQyOISPEVdV05h8gw1XR7o+0OupYyibUKDov
         u9MO8JdW/4492mudRW6bd/am1LyNUxI6nuE+uZEUOnlPn8Guv3xCnwAFCIb8TzdUzmMJ
         flxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wb00zi3GtM+UDUK6MWkzSBSj/kmc+caJeQJNkmOWNiw=;
        b=uLKMQ5HbFJIlxS4DGyH5c0ZQnbOxZYD+yVuFGMlRa7fhLaIfa8o+tpXIzoPRmLAW9R
         genZu7yJrkeH0ng4pF+LCi5mPred0zj8Wk/HW04pApg/LPlPZtTcNdpMUvsx1W2qsiEp
         VtLo/gRpug6py8JtqFw0UgSimnm3I5lbMDxV2SINrUp8inYwPSAYC6Bvc65/uMQjnXgN
         GXggOfxcjitIy6VM2jlPMCr04YUebyXxPEpIZcPsUFQ9UyPcXFdfSf745KRe9T9nzQaY
         01eM62GAk6HaB2PFBNScetGVw8EX/S15DPWPWuJlfXTqE5wPlGj4sEFdUnK4LNzELNn/
         PG7Q==
X-Gm-Message-State: AA+aEWZLUZCd6jovNYNM/6EGgFkRa8sQ/PTBOkNkezIWgmbKs/ZTpeMF
        Fs5/8wtFJP9xGy9eJQO7/Qw=
X-Google-Smtp-Source: AFSGD/U3CHqpm25jpOHFtgL0uCn70+l1YOMS35VUcusM4zlqgrnvN2vxOKP6OoReiBxQDLry+COyIQ==
X-Received: by 2002:ac8:1414:: with SMTP id k20mr25778896qtj.298.1545308821892;
        Thu, 20 Dec 2018 04:27:01 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q17sm4061434qtc.19.2018.12.20.04.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:27:01 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:26:55 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] drm: meson: Cleanup on drm_display_mode print str
Message-ID: <7017942bbbb3e0e6c1e2bd854ea5a5f461784ac4.1545308167.git.shayenneluzmoura@gmail.com>
References: <cover.1545308167.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545308167.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in meson files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

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

