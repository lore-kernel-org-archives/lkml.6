Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA532C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D62084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6D62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeJGQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:40 -0400
Received: from mailoutvs24.siol.net ([185.57.226.215]:39778 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728142AbeJGQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 58FB1520C54;
        Sun,  7 Oct 2018 11:39:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B0ETJ-bNSMwM; Sun,  7 Oct 2018 11:39:43 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 25780520C42;
        Sun,  7 Oct 2018 11:39:43 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 88076520C4D;
        Sun,  7 Oct 2018 11:39:40 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 10/29] drm/sun4i: Rename DE2 registers related macros
Date:   Sun,  7 Oct 2018 11:38:46 +0200
Message-Id: <20181007093905.11253-11-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to introduce DE3 support, change prefix from "SUN8I_" to
"DE2_". Current prefix suggest that it's valid only for one family,
whereas in reality, DE2 unit is used also on sun50i family.
Additionally, it will be easier to distinguish DE3 specific macros by
using "DE3_" prefix.

No functional change in this commit.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c       |   6 +-
 drivers/gpu/drm/sun4i/sun8i_csc.h       |   6 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 100 ++++++++--------
 drivers/gpu/drm/sun4i/sun8i_mixer.h     | 146 ++++++++++++------------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  |  62 +++++-----
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h  |  30 ++---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c |  38 +++---
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |  38 +++---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  |  62 +++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |  20 ++--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c |  67 ++++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h |  58 +++++-----
 12 files changed, 316 insertions(+), 317 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index b14925b40ccf..755b60bae408 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -57,7 +57,7 @@ static void sun8i_csc_set_coefficients(struct regmap *m=
ap, u32 base,
 		/* For some reason, 0x200 must be added to constant parts */
 		if (((i + 1) & 3) =3D=3D 0)
 			data +=3D 0x200;
-		regmap_write(map, SUN8I_CSC_COEFF(base, i), data);
+		regmap_write(map, DE2_CSC_COEFF(base, i), data);
 	}
 }
=20
@@ -66,11 +66,11 @@ static void sun8i_csc_enable(struct regmap *map, u32 =
base, bool enable)
 	u32 val;
=20
 	if (enable)
-		val =3D SUN8I_CSC_CTRL_EN;
+		val =3D DE2_CSC_CTRL_EN;
 	else
 		val =3D 0;
=20
-	regmap_update_bits(map, SUN8I_CSC_CTRL(base), SUN8I_CSC_CTRL_EN, val);
+	regmap_update_bits(map, DE2_CSC_CTRL(base), DE2_CSC_CTRL_EN, val);
 }
=20
 void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int laye=
r,
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/su=
n8i_csc.h
index 880e8fbb0855..08ae38761280 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -18,10 +18,10 @@ struct sun8i_mixer;
 #define CCSC10_OFFSET 0xA0000
 #define CCSC11_OFFSET 0xF0000
=20
-#define SUN8I_CSC_CTRL(base)		(base + 0x0)
-#define SUN8I_CSC_COEFF(base, i)	(base + 0x10 + 4 * i)
+#define DE2_CSC_CTRL(base)	(base + 0x0)
+#define DE2_CSC_COEFF(base, i)	(base + 0x10 + 4 * i)
=20
-#define SUN8I_CSC_CTRL_EN		BIT(0)
+#define DE2_CSC_CTRL_EN		BIT(0)
=20
 enum sun8i_csc_mode {
 	SUN8I_CSC_MODE_OFF,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 6129c350f7bd..71c0f6dc8a49 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -34,217 +34,217 @@
 static const struct de2_fmt_info de2_formats[] =3D {
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_ARGB8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_ABGR8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGBA8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_BGRA8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_XRGB8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_XRGB8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_XRGB8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_XBGR8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_XBGR8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_XBGR8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBX8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBX8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGBX8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRX8888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRX8888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_BGRX8888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGB888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGB888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGR888,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGR888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_BGR888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGB565,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB565,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGB565,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGR565,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGR565,
+		.de2_fmt =3D DE2_MIXER_FBFMT_BGR565,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB4444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB4444,
+		.de2_fmt =3D DE2_MIXER_FBFMT_ARGB4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR4444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
+		.de2_fmt =3D DE2_MIXER_FBFMT_ABGR4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA4444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGBA4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA4444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
+		.de2_fmt =3D DE2_MIXER_FBFMT_BGRA4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB1555,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
+		.de2_fmt =3D DE2_MIXER_FBFMT_ARGB1555,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR1555,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
+		.de2_fmt =3D DE2_MIXER_FBFMT_ABGR1555,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA5551,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGBA5551,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA5551,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
+		.de2_fmt =3D DE2_MIXER_FBFMT_BGRA5551,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_UYVY,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_UYVY,
+		.de2_fmt =3D DE2_MIXER_FBFMT_UYVY,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_VYUY,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_VYUY,
+		.de2_fmt =3D DE2_MIXER_FBFMT_VYUY,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUYV,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUYV,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUYV,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVYU,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YVYU,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YVYU,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV16,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV16,
+		.de2_fmt =3D DE2_MIXER_FBFMT_NV16,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV61,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV61,
+		.de2_fmt =3D DE2_MIXER_FBFMT_NV61,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV12,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV12,
+		.de2_fmt =3D DE2_MIXER_FBFMT_NV12,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV21,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV21,
+		.de2_fmt =3D DE2_MIXER_FBFMT_NV21,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGB888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV422,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUV422,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV420,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV420,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUV420,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV411,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV411,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUV411,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
+		.de2_fmt =3D DE2_MIXER_FBFMT_RGB888,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU422,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUV422,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU420,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV420,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUV420,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU411,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV411,
+		.de2_fmt =3D DE2_MIXER_FBFMT_YUV411,
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
@@ -265,8 +265,8 @@ static void sun8i_mixer_commit(struct sunxi_engine *e=
ngine)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
=20
-	regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_DBUFF,
-		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
+	regmap_write(engine->regs, DE2_MIXER_GLOBAL_DBUFF,
+		     DE2_MIXER_GLOBAL_DBUFF_ENABLE);
 }
=20
 static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
@@ -464,30 +464,30 @@ static int sun8i_mixer_bind(struct device *dev, str=
uct device *master,
 		regmap_write(mixer->engine.regs, i, 0);
=20
 	/* Enable the mixer */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
-		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
+	regmap_write(mixer->engine.regs, DE2_MIXER_GLOBAL_CTL,
+		     DE2_MIXER_GLOBAL_CTL_RT_EN);
=20
 	/* Set background color to black */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR(base),
-		     SUN8I_MIXER_BLEND_COLOR_BLACK);
+	regmap_write(mixer->engine.regs, DE2_MIXER_BLEND_BKCOLOR(base),
+		     DE2_MIXER_BLEND_COLOR_BLACK);
=20
 	/*
 	 * Set fill color of bottom plane to black. Generally not needed
 	 * except when VI plane is at bottom (zpos =3D 0) and enabled.
 	 */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
-		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, 0)=
,
-		     SUN8I_MIXER_BLEND_COLOR_BLACK);
+	regmap_write(mixer->engine.regs, DE2_MIXER_BLEND_PIPE_CTL(base),
+		     DE2_MIXER_BLEND_PIPE_CTL_FC_EN(0));
+	regmap_write(mixer->engine.regs, DE2_MIXER_BLEND_ATTR_FCOLOR(base, 0),
+		     DE2_MIXER_BLEND_COLOR_BLACK);
=20
 	plane_cnt =3D mixer->cfg->vi_num + mixer->cfg->ui_num;
 	for (i =3D 0; i < plane_cnt; i++)
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_MODE(base, i),
-			     SUN8I_MIXER_BLEND_MODE_DEF);
+			     DE2_MIXER_BLEND_MODE(base, i),
+			     DE2_MIXER_BLEND_MODE_DEF);
=20
-	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base)=
,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
+	regmap_update_bits(mixer->engine.regs, DE2_MIXER_BLEND_PIPE_CTL(base),
+			   DE2_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
=20
 	return 0;
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 025550a1f539..208e8219d2be 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -17,98 +17,98 @@
 #include "sun8i_csc.h"
 #include "sunxi_engine.h"
=20
-#define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
-#define SUN8I_MIXER_COORD(x, y)			((y) << 16 | (x))
+#define DE2_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
+#define DE2_MIXER_COORD(x, y)			((y) << 16 | (x))
=20
-#define SUN8I_MIXER_GLOBAL_CTL			0x0
-#define SUN8I_MIXER_GLOBAL_STATUS		0x4
-#define SUN8I_MIXER_GLOBAL_DBUFF		0x8
-#define SUN8I_MIXER_GLOBAL_SIZE			0xc
+#define DE2_MIXER_GLOBAL_CTL			0x0
+#define DE2_MIXER_GLOBAL_STATUS			0x4
+#define DE2_MIXER_GLOBAL_DBUFF			0x8
+#define DE2_MIXER_GLOBAL_SIZE			0xc
=20
-#define SUN8I_MIXER_GLOBAL_CTL_RT_EN		BIT(0)
+#define DE2_MIXER_GLOBAL_CTL_RT_EN		BIT(0)
=20
-#define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
+#define DE2_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
=20
 #define DE2_BLD_BASE				0x1000
 #define DE2_CH_BASE				0x2000
 #define DE2_CH_SIZE				0x1000
=20
-#define SUN8I_MIXER_BLEND_PIPE_CTL(base)	((base) + 0)
-#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x)	((base) + 0x4 + 0x10 * (x=
))
-#define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x)	((base) + 0x8 + 0x10 * (x=
))
-#define SUN8I_MIXER_BLEND_ATTR_COORD(base, x)	((base) + 0xc + 0x10 * (x)=
)
-#define SUN8I_MIXER_BLEND_ROUTE(base)		((base) + 0x80)
-#define SUN8I_MIXER_BLEND_PREMULTIPLY(base)	((base) + 0x84)
-#define SUN8I_MIXER_BLEND_BKCOLOR(base)		((base) + 0x88)
-#define SUN8I_MIXER_BLEND_OUTSIZE(base)		((base) + 0x8c)
-#define SUN8I_MIXER_BLEND_MODE(base, x)		((base) + 0x90 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_CK_CTL(base)		((base) + 0xb0)
-#define SUN8I_MIXER_BLEND_CK_CFG(base)		((base) + 0xb4)
-#define SUN8I_MIXER_BLEND_CK_MAX(base, x)	((base) + 0xc0 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_CK_MIN(base, x)	((base) + 0xe0 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_OUTCTL(base)		((base) + 0xfc)
-
-#define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK	GENMASK(12, 8)
-#define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
-#define SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(pipe)	BIT(pipe)
+#define DE2_MIXER_BLEND_PIPE_CTL(base)		((base) + 0)
+#define DE2_MIXER_BLEND_ATTR_FCOLOR(base, x)	((base) + 0x4 + 0x10 * (x))
+#define DE2_MIXER_BLEND_ATTR_INSIZE(base, x)	((base) + 0x8 + 0x10 * (x))
+#define DE2_MIXER_BLEND_ATTR_COORD(base, x)	((base) + 0xc + 0x10 * (x))
+#define DE2_MIXER_BLEND_ROUTE(base)		((base) + 0x80)
+#define DE2_MIXER_BLEND_PREMULTIPLY(base)	((base) + 0x84)
+#define DE2_MIXER_BLEND_BKCOLOR(base)		((base) + 0x88)
+#define DE2_MIXER_BLEND_OUTSIZE(base)		((base) + 0x8c)
+#define DE2_MIXER_BLEND_MODE(base, x)		((base) + 0x90 + 0x04 * (x))
+#define DE2_MIXER_BLEND_CK_CTL(base)		((base) + 0xb0)
+#define DE2_MIXER_BLEND_CK_CFG(base)		((base) + 0xb4)
+#define DE2_MIXER_BLEND_CK_MAX(base, x)		((base) + 0xc0 + 0x04 * (x))
+#define DE2_MIXER_BLEND_CK_MIN(base, x)		((base) + 0xe0 + 0x04 * (x))
+#define DE2_MIXER_BLEND_OUTCTL(base)		((base) + 0xfc)
+
+#define DE2_MIXER_BLEND_PIPE_CTL_EN_MSK		GENMASK(12, 8)
+#define DE2_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
+#define DE2_MIXER_BLEND_PIPE_CTL_FC_EN(pipe)	BIT(pipe)
 /* colors are always in AARRGGBB format */
-#define SUN8I_MIXER_BLEND_COLOR_BLACK		0xff000000
+#define DE2_MIXER_BLEND_COLOR_BLACK		0xff000000
 /* The following numbers are some still unknown magic numbers */
-#define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
-
-#define SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(n)	(0xf << ((n) << 2))
-#define SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(n)	((n) << 2)
-
-#define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
-
-#define SUN8I_MIXER_FBFMT_ARGB8888	0
-#define SUN8I_MIXER_FBFMT_ABGR8888	1
-#define SUN8I_MIXER_FBFMT_RGBA8888	2
-#define SUN8I_MIXER_FBFMT_BGRA8888	3
-#define SUN8I_MIXER_FBFMT_XRGB8888	4
-#define SUN8I_MIXER_FBFMT_XBGR8888	5
-#define SUN8I_MIXER_FBFMT_RGBX8888	6
-#define SUN8I_MIXER_FBFMT_BGRX8888	7
-#define SUN8I_MIXER_FBFMT_RGB888	8
-#define SUN8I_MIXER_FBFMT_BGR888	9
-#define SUN8I_MIXER_FBFMT_RGB565	10
-#define SUN8I_MIXER_FBFMT_BGR565	11
-#define SUN8I_MIXER_FBFMT_ARGB4444	12
-#define SUN8I_MIXER_FBFMT_ABGR4444	13
-#define SUN8I_MIXER_FBFMT_RGBA4444	14
-#define SUN8I_MIXER_FBFMT_BGRA4444	15
-#define SUN8I_MIXER_FBFMT_ARGB1555	16
-#define SUN8I_MIXER_FBFMT_ABGR1555	17
-#define SUN8I_MIXER_FBFMT_RGBA5551	18
-#define SUN8I_MIXER_FBFMT_BGRA5551	19
-
-#define SUN8I_MIXER_FBFMT_YUYV		0
-#define SUN8I_MIXER_FBFMT_UYVY		1
-#define SUN8I_MIXER_FBFMT_YVYU		2
-#define SUN8I_MIXER_FBFMT_VYUY		3
-#define SUN8I_MIXER_FBFMT_NV16		4
-#define SUN8I_MIXER_FBFMT_NV61		5
-#define SUN8I_MIXER_FBFMT_YUV422	6
+#define DE2_MIXER_BLEND_MODE_DEF		0x03010301
+
+#define DE2_MIXER_BLEND_ROUTE_PIPE_MSK(n)	(0xf << ((n) << 2))
+#define DE2_MIXER_BLEND_ROUTE_PIPE_SHIFT(n)	((n) << 2)
+
+#define DE2_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
+
+#define DE2_MIXER_FBFMT_ARGB8888	0
+#define DE2_MIXER_FBFMT_ABGR8888	1
+#define DE2_MIXER_FBFMT_RGBA8888	2
+#define DE2_MIXER_FBFMT_BGRA8888	3
+#define DE2_MIXER_FBFMT_XRGB8888	4
+#define DE2_MIXER_FBFMT_XBGR8888	5
+#define DE2_MIXER_FBFMT_RGBX8888	6
+#define DE2_MIXER_FBFMT_BGRX8888	7
+#define DE2_MIXER_FBFMT_RGB888		8
+#define DE2_MIXER_FBFMT_BGR888		9
+#define DE2_MIXER_FBFMT_RGB565		10
+#define DE2_MIXER_FBFMT_BGR565		11
+#define DE2_MIXER_FBFMT_ARGB4444	12
+#define DE2_MIXER_FBFMT_ABGR4444	13
+#define DE2_MIXER_FBFMT_RGBA4444	14
+#define DE2_MIXER_FBFMT_BGRA4444	15
+#define DE2_MIXER_FBFMT_ARGB1555	16
+#define DE2_MIXER_FBFMT_ABGR1555	17
+#define DE2_MIXER_FBFMT_RGBA5551	18
+#define DE2_MIXER_FBFMT_BGRA5551	19
+
+#define DE2_MIXER_FBFMT_YUYV		0
+#define DE2_MIXER_FBFMT_UYVY		1
+#define DE2_MIXER_FBFMT_YVYU		2
+#define DE2_MIXER_FBFMT_VYUY		3
+#define DE2_MIXER_FBFMT_NV16		4
+#define DE2_MIXER_FBFMT_NV61		5
+#define DE2_MIXER_FBFMT_YUV422		6
 /* format 7 doesn't exist */
-#define SUN8I_MIXER_FBFMT_NV12		8
-#define SUN8I_MIXER_FBFMT_NV21		9
-#define SUN8I_MIXER_FBFMT_YUV420	10
+#define DE2_MIXER_FBFMT_NV12		8
+#define DE2_MIXER_FBFMT_NV21		9
+#define DE2_MIXER_FBFMT_YUV420		10
 /* format 11 doesn't exist */
 /* format 12 is semi-planar YUV411 UVUV */
 /* format 13 is semi-planar YUV411 VUVU */
-#define SUN8I_MIXER_FBFMT_YUV411	14
+#define DE2_MIXER_FBFMT_YUV411		14
=20
 /*
  * These sub-engines are still unknown now, the EN registers are here on=
ly to
  * be used to disable these sub-engines.
  */
-#define SUN8I_MIXER_FCE_EN			0xa0000
-#define SUN8I_MIXER_BWS_EN			0xa2000
-#define SUN8I_MIXER_LTI_EN			0xa4000
-#define SUN8I_MIXER_PEAK_EN			0xa6000
-#define SUN8I_MIXER_ASE_EN			0xa8000
-#define SUN8I_MIXER_FCC_EN			0xaa000
-#define SUN8I_MIXER_DCSC_EN			0xb0000
+#define DE2_MIXER_FCE_EN			0xa0000
+#define DE2_MIXER_BWS_EN			0xa2000
+#define DE2_MIXER_LTI_EN			0xa4000
+#define DE2_MIXER_PEAK_EN			0xa6000
+#define DE2_MIXER_ASE_EN			0xa8000
+#define DE2_MIXER_FCC_EN			0xaa000
+#define DE2_MIXER_DCSC_EN			0xb0000
=20
 struct de2_fmt_info {
 	u32			drm_fmt;
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
index e3fc8fa920fb..e4a3109d373c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -39,38 +39,38 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer =
*mixer, int channel,
 			 enable ? "En" : "Dis", channel, overlay);
=20
 	if (enable)
-		val =3D SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
+		val =3D DE2_MIXER_CHAN_UI_LAYER_ATTR_EN;
 	else
 		val =3D 0;
=20
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
+			   DE2_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
+			   DE2_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
=20
 	if (!enable || zpos !=3D old_zpos) {
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
+				   DE2_MIXER_BLEND_PIPE_CTL(bld_base),
+				   DE2_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
 				   0);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
+				   DE2_MIXER_BLEND_ROUTE(bld_base),
+				   DE2_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
 				   0);
 	}
=20
 	if (enable) {
-		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
+		val =3D DE2_MIXER_BLEND_PIPE_CTL_EN(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
+				   DE2_MIXER_BLEND_PIPE_CTL(bld_base),
 				   val, val);
=20
-		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
+		val =3D channel << DE2_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
+				   DE2_MIXER_BLEND_ROUTE(bld_base),
+				   DE2_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
 				   val);
 	}
 }
@@ -99,8 +99,8 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mix=
er *mixer, int channel,
 	hphase =3D state->src.x1 & 0xffff;
 	vphase =3D state->src.y1 & 0xffff;
=20
-	insize =3D SUN8I_MIXER_SIZE(src_w, src_h);
-	outsize =3D SUN8I_MIXER_SIZE(dst_w, dst_h);
+	insize =3D DE2_MIXER_SIZE(src_w, src_h);
+	outsize =3D DE2_MIXER_SIZE(dst_w, dst_h);
=20
 	if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY) {
 		bool interlaced =3D false;
@@ -109,23 +109,23 @@ static int sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
 				 dst_w, dst_h);
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_GLOBAL_SIZE,
+			     DE2_MIXER_GLOBAL_SIZE,
 			     outsize);
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
+			     DE2_MIXER_BLEND_OUTSIZE(bld_base), outsize);
=20
 		if (state->crtc)
 			interlaced =3D state->crtc->state->adjusted_mode.flags
 				& DRM_MODE_FLAG_INTERLACE;
=20
 		if (interlaced)
-			val =3D SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+			val =3D DE2_MIXER_BLEND_OUTCTL_INTERLACED;
 		else
 			val =3D 0;
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
-				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+				   DE2_MIXER_BLEND_OUTCTL(bld_base),
+				   DE2_MIXER_BLEND_OUTCTL_INTERLACED,
 				   val);
=20
 		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
@@ -137,10 +137,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 state->src.x1 >> 16, state->src.y1 >> 16);
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch_base, overlay),
+		     DE2_MIXER_CHAN_UI_LAYER_SIZE(ch_base, overlay),
 		     insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch_base),
+		     DE2_MIXER_CHAN_UI_OVL_SIZE(ch_base),
 		     insize);
=20
 	if (insize !=3D outsize || hphase || vphase) {
@@ -164,10 +164,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
-		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
+		     DE2_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
+		     DE2_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
+		     DE2_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
=20
 	return 0;
@@ -188,10 +188,10 @@ static int sun8i_ui_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 		return -EINVAL;
 	}
=20
-	val =3D fmt_info->de2_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSE=
T;
+	val =3D fmt_info->de2_fmt << DE2_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
+			   DE2_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
+			   DE2_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
=20
 	return 0;
 }
@@ -224,13 +224,13 @@ static int sun8i_ui_layer_update_buffer(struct sun8=
i_mixer *mixer, int channel,
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch_base, overlay),
+		     DE2_MIXER_CHAN_UI_LAYER_PITCH(ch_base, overlay),
 		     fb->pitches[0]);
=20
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
=20
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, overlay),
+		     DE2_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, overlay),
 		     lower_32_bits(paddr));
=20
 	return 0;
@@ -255,8 +255,8 @@ static int sun8i_ui_layer_atomic_check(struct drm_pla=
ne *plane,
 	max_scale =3D DRM_PLANE_HELPER_NO_SCALING;
=20
 	if (layer->mixer->cfg->scaler_mask & BIT(layer->channel)) {
-		min_scale =3D SUN8I_UI_SCALER_SCALE_MIN;
-		max_scale =3D SUN8I_UI_SCALER_SCALE_MAX;
+		min_scale =3D DE2_UI_SCALER_SCALE_MIN;
+		max_scale =3D DE2_UI_SCALER_SCALE_MAX;
 	}
=20
 	return drm_atomic_helper_check_plane_state(state, crtc_state,
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.h
index f4389cf0ba20..df9e648a5de6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -18,32 +18,32 @@
=20
 #include <drm/drm_plane.h>
=20
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_ATTR(base, layer) \
 			((base) + 0x20 * (layer) + 0x0)
-#define SUN8I_MIXER_CHAN_UI_LAYER_SIZE(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_SIZE(base, layer) \
 			((base) + 0x20 * (layer) + 0x4)
-#define SUN8I_MIXER_CHAN_UI_LAYER_COORD(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_COORD(base, layer) \
 			((base) + 0x20 * (layer) + 0x8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_PITCH(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_PITCH(base, layer) \
 			((base) + 0x20 * (layer) + 0xc)
-#define SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_TOP_LADDR(base, layer) \
 			((base) + 0x20 * (layer) + 0x10)
-#define SUN8I_MIXER_CHAN_UI_LAYER_BOT_LADDR(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_BOT_LADDR(base, layer) \
 			((base) + 0x20 * (layer) + 0x14)
-#define SUN8I_MIXER_CHAN_UI_LAYER_FCOLOR(base, layer) \
+#define DE2_MIXER_CHAN_UI_LAYER_FCOLOR(base, layer) \
 			((base) + 0x20 * (layer) + 0x18)
-#define SUN8I_MIXER_CHAN_UI_TOP_HADDR(base) \
+#define DE2_MIXER_CHAN_UI_TOP_HADDR(base) \
 			((base) + 0x80)
-#define SUN8I_MIXER_CHAN_UI_BOT_HADDR(base) \
+#define DE2_MIXER_CHAN_UI_BOT_HADDR(base) \
 			((base) + 0x84)
-#define SUN8I_MIXER_CHAN_UI_OVL_SIZE(base) \
+#define DE2_MIXER_CHAN_UI_OVL_SIZE(base) \
 			((base) + 0x88)
=20
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
+#define DE2_MIXER_CHAN_UI_LAYER_ATTR_EN			BIT(0)
+#define DE2_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
+#define DE2_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK		GENMASK(12, 8)
+#define DE2_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
+#define DE2_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK		GENMASK(31, 24)
=20
 struct sun8i_mixer;
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_ui_scaler.c
index 698401ecb53d..59dfe2deae8f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -101,7 +101,7 @@ static int sun8i_ui_scaler_coef_index(unsigned int st=
ep)
 {
 	unsigned int scale, int_part, float_part;
=20
-	scale =3D step >> (SUN8I_UI_SCALER_SCALE_FRAC - 3);
+	scale =3D step >> (DE2_UI_SCALER_SCALE_FRAC - 3);
 	int_part =3D scale >> 3;
 	float_part =3D scale & 0x7;
=20
@@ -131,12 +131,12 @@ void sun8i_ui_scaler_enable(struct sun8i_mixer *mix=
er, int layer, bool enable)
 	base =3D sun8i_ui_scaler_base(mixer, layer);
=20
 	if (enable)
-		val =3D SUN8I_SCALER_GSU_CTRL_EN |
-		      SUN8I_SCALER_GSU_CTRL_COEFF_RDY;
+		val =3D DE2_SCALER_GSU_CTRL_EN |
+		      DE2_SCALER_GSU_CTRL_COEFF_RDY;
 	else
 		val =3D 0;
=20
-	regmap_write(mixer->engine.regs, SUN8I_SCALER_GSU_CTRL(base), val);
+	regmap_write(mixer->engine.regs, DE2_SCALER_GSU_CTRL(base), val);
 }
=20
 void sun8i_ui_scaler_setup(struct sun8i_mixer *mixer, int layer,
@@ -152,30 +152,30 @@ void sun8i_ui_scaler_setup(struct sun8i_mixer *mixe=
r, int layer,
=20
 	base =3D sun8i_ui_scaler_base(mixer, layer);
=20
-	hphase <<=3D SUN8I_UI_SCALER_PHASE_FRAC - 16;
-	vphase <<=3D SUN8I_UI_SCALER_PHASE_FRAC - 16;
-	hscale <<=3D SUN8I_UI_SCALER_SCALE_FRAC - 16;
-	vscale <<=3D SUN8I_UI_SCALER_SCALE_FRAC - 16;
+	hphase <<=3D DE2_UI_SCALER_PHASE_FRAC - 16;
+	vphase <<=3D DE2_UI_SCALER_PHASE_FRAC - 16;
+	hscale <<=3D DE2_UI_SCALER_SCALE_FRAC - 16;
+	vscale <<=3D DE2_UI_SCALER_SCALE_FRAC - 16;
=20
-	insize =3D SUN8I_UI_SCALER_SIZE(src_w, src_h);
-	outsize =3D SUN8I_UI_SCALER_SIZE(dst_w, dst_h);
+	insize =3D DE2_UI_SCALER_SIZE(src_w, src_h);
+	outsize =3D DE2_UI_SCALER_SIZE(dst_w, dst_h);
=20
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_OUTSIZE(base), outsize);
+		     DE2_SCALER_GSU_OUTSIZE(base), outsize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_INSIZE(base), insize);
+		     DE2_SCALER_GSU_INSIZE(base), insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_HSTEP(base), hscale);
+		     DE2_SCALER_GSU_HSTEP(base), hscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_VSTEP(base), vscale);
+		     DE2_SCALER_GSU_VSTEP(base), vscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_HPHASE(base), hphase);
+		     DE2_SCALER_GSU_HPHASE(base), hphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_VPHASE(base), vphase);
+		     DE2_SCALER_GSU_VPHASE(base), vphase);
 	offset =3D sun8i_ui_scaler_coef_index(hscale) *
-			SUN8I_UI_SCALER_COEFF_COUNT;
-	for (i =3D 0; i < SUN8I_UI_SCALER_COEFF_COUNT; i++)
+			DE2_UI_SCALER_COEFF_COUNT;
+	for (i =3D 0; i < DE2_UI_SCALER_COEFF_COUNT; i++)
 		regmap_write(mixer->engine.regs,
-			     SUN8I_SCALER_GSU_HCOEFF(base, i),
+			     DE2_SCALER_GSU_HCOEFF(base, i),
 			     lan2coefftab16[offset + i]);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_ui_scaler.h
index 6b4bc1ff3e2c..8db18053e6ee 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
@@ -14,25 +14,25 @@
 #define DE2_UI_SCALER_UNIT_SIZE 0x10000
=20
 /* this two macros assumes 16 fractional bits which is standard in DRM *=
/
-#define SUN8I_UI_SCALER_SCALE_MIN		1
-#define SUN8I_UI_SCALER_SCALE_MAX		((1UL << 20) - 1)
-
-#define SUN8I_UI_SCALER_SCALE_FRAC		20
-#define SUN8I_UI_SCALER_PHASE_FRAC		20
-#define SUN8I_UI_SCALER_COEFF_COUNT		16
-#define SUN8I_UI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
-
-#define SUN8I_SCALER_GSU_CTRL(base)		((base) + 0x0)
-#define SUN8I_SCALER_GSU_OUTSIZE(base)		((base) + 0x40)
-#define SUN8I_SCALER_GSU_INSIZE(base)		((base) + 0x80)
-#define SUN8I_SCALER_GSU_HSTEP(base)		((base) + 0x88)
-#define SUN8I_SCALER_GSU_VSTEP(base)		((base) + 0x8c)
-#define SUN8I_SCALER_GSU_HPHASE(base)		((base) + 0x90)
-#define SUN8I_SCALER_GSU_VPHASE(base)		((base) + 0x98)
-#define SUN8I_SCALER_GSU_HCOEFF(base, index)	((base) + 0x200 + 0x4 * (in=
dex))
-
-#define SUN8I_SCALER_GSU_CTRL_EN		BIT(0)
-#define SUN8I_SCALER_GSU_CTRL_COEFF_RDY		BIT(4)
+#define DE2_UI_SCALER_SCALE_MIN			1
+#define DE2_UI_SCALER_SCALE_MAX			((1UL << 20) - 1)
+
+#define DE2_UI_SCALER_SCALE_FRAC		20
+#define DE2_UI_SCALER_PHASE_FRAC		20
+#define DE2_UI_SCALER_COEFF_COUNT		16
+#define DE2_UI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
+
+#define DE2_SCALER_GSU_CTRL(base)		((base) + 0x0)
+#define DE2_SCALER_GSU_OUTSIZE(base)		((base) + 0x40)
+#define DE2_SCALER_GSU_INSIZE(base)		((base) + 0x80)
+#define DE2_SCALER_GSU_HSTEP(base)		((base) + 0x88)
+#define DE2_SCALER_GSU_VSTEP(base)		((base) + 0x8c)
+#define DE2_SCALER_GSU_HPHASE(base)		((base) + 0x90)
+#define DE2_SCALER_GSU_VPHASE(base)		((base) + 0x98)
+#define DE2_SCALER_GSU_HCOEFF(base, index)	((base) + 0x200 + 0x4 * (inde=
x))
+
+#define DE2_SCALER_GSU_CTRL_EN			BIT(0)
+#define DE2_SCALER_GSU_CTRL_COEFF_RDY		BIT(4)
=20
 void sun8i_ui_scaler_enable(struct sun8i_mixer *mixer, int layer, bool e=
nable);
 void sun8i_ui_scaler_setup(struct sun8i_mixer *mixer, int layer,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 79811eae3735..8ea07f34ad5b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -33,38 +33,38 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer =
*mixer, int channel,
 			 enable ? "En" : "Dis", channel, overlay);
=20
 	if (enable)
-		val =3D SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN;
+		val =3D DE2_MIXER_CHAN_VI_LAYER_ATTR_EN;
 	else
 		val =3D 0;
=20
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
+			   DE2_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
+			   DE2_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
=20
 	if (!enable || zpos !=3D old_zpos) {
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
+				   DE2_MIXER_BLEND_PIPE_CTL(bld_base),
+				   DE2_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
 				   0);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
+				   DE2_MIXER_BLEND_ROUTE(bld_base),
+				   DE2_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
 				   0);
 	}
=20
 	if (enable) {
-		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
+		val =3D DE2_MIXER_BLEND_PIPE_CTL_EN(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
+				   DE2_MIXER_BLEND_PIPE_CTL(bld_base),
 				   val, val);
=20
-		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
+		val =3D channel << DE2_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
+				   DE2_MIXER_BLEND_ROUTE(bld_base),
+				   DE2_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
 				   val);
 	}
 }
@@ -114,8 +114,8 @@ static int sun8i_vi_layer_update_coord(struct sun8i_m=
ixer *mixer, int channel,
 		vphase +=3D remainder << 16;
 	}
=20
-	insize =3D SUN8I_MIXER_SIZE(src_w, src_h);
-	outsize =3D SUN8I_MIXER_SIZE(dst_w, dst_h);
+	insize =3D DE2_MIXER_SIZE(src_w, src_h);
+	outsize =3D DE2_MIXER_SIZE(dst_w, dst_h);
=20
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
@@ -123,10 +123,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 (state->src.y1 >> 16) & ~(format->vsub - 1));
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch_base, overlay),
+		     DE2_MIXER_CHAN_VI_LAYER_SIZE(ch_base, overlay),
 		     insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(ch_base),
+		     DE2_MIXER_CHAN_VI_OVL_SIZE(ch_base),
 		     insize);
=20
 	/*
@@ -157,10 +157,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
-		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
+		     DE2_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
+		     DE2_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
+		     DE2_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
=20
 	return 0;
@@ -181,10 +181,10 @@ static int sun8i_vi_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 		return -EINVAL;
 	}
=20
-	val =3D fmt_info->de2_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSE=
T;
+	val =3D fmt_info->de2_fmt << DE2_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
+			   DE2_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
+			   DE2_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
=20
 	if (fmt_info->csc !=3D SUN8I_CSC_MODE_OFF) {
 		sun8i_csc_set_ccsc_coefficients(mixer, channel, fmt_info->csc);
@@ -194,13 +194,13 @@ static int sun8i_vi_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 	}
=20
 	if (fmt_info->rgb)
-		val =3D SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
+		val =3D DE2_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
 	else
 		val =3D 0;
=20
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
+			   DE2_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
+			   DE2_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
=20
 	return 0;
 }
@@ -248,16 +248,16 @@ static int sun8i_vi_layer_update_buffer(struct sun8=
i_mixer *mixer, int channel,
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
 				 i + 1, fb->pitches[i]);
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch_base,
-							     overlay, i),
+			     DE2_MIXER_CHAN_VI_LAYER_PITCH(ch_base,
+							   overlay, i),
 			     fb->pitches[i]);
=20
 		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
 				 i + 1, &paddr);
=20
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch_base,
-								 overlay, i),
+			     DE2_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch_base,
+							       overlay, i),
 			     lower_32_bits(paddr));
 	}
=20
@@ -283,8 +283,8 @@ static int sun8i_vi_layer_atomic_check(struct drm_pla=
ne *plane,
 	max_scale =3D DRM_PLANE_HELPER_NO_SCALING;
=20
 	if (layer->mixer->cfg->scaler_mask & BIT(layer->channel)) {
-		min_scale =3D SUN8I_VI_SCALER_SCALE_MIN;
-		max_scale =3D SUN8I_VI_SCALER_SCALE_MAX;
+		min_scale =3D DE2_VI_SCALER_SCALE_MIN;
+		max_scale =3D DE2_VI_SCALER_SCALE_MAX;
 	}
=20
 	return drm_atomic_helper_check_plane_state(state, crtc_state,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.h
index 46f0237c17bb..dfda659e309c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -12,24 +12,24 @@
=20
 #include <drm/drm_plane.h>
=20
-#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR(base, layer) \
+#define DE2_MIXER_CHAN_VI_LAYER_ATTR(base, layer) \
 		((base) + 0x30 * (layer) + 0x0)
-#define SUN8I_MIXER_CHAN_VI_LAYER_SIZE(base, layer) \
+#define DE2_MIXER_CHAN_VI_LAYER_SIZE(base, layer) \
 		((base) + 0x30 * (layer) + 0x4)
-#define SUN8I_MIXER_CHAN_VI_LAYER_COORD(base, layer) \
+#define DE2_MIXER_CHAN_VI_LAYER_COORD(base, layer) \
 		((base) + 0x30 * (layer) + 0x8)
-#define SUN8I_MIXER_CHAN_VI_LAYER_PITCH(base, layer, plane) \
+#define DE2_MIXER_CHAN_VI_LAYER_PITCH(base, layer, plane) \
 		((base) + 0x30 * (layer) + 0xc + 4 * (plane))
-#define SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(base, layer, plane) \
+#define DE2_MIXER_CHAN_VI_LAYER_TOP_LADDR(base, layer, plane) \
 		((base) + 0x30 * (layer) + 0x18 + 4 * (plane))
-#define SUN8I_MIXER_CHAN_VI_OVL_SIZE(base) \
+#define DE2_MIXER_CHAN_VI_OVL_SIZE(base) \
 		((base) + 0xe8)
=20
-#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
+#define DE2_MIXER_CHAN_VI_LAYER_ATTR_EN			BIT(0)
 /* RGB mode should be set for RGB formats and cleared for YCbCr */
-#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
-#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
-#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+#define DE2_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
+#define DE2_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
+#define DE2_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK		GENMASK(12, 8)
=20
 struct sun8i_mixer;
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.c
index 9f6834c143d7..b69ebca221c3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -842,7 +842,7 @@ static int sun8i_vi_scaler_coef_index(unsigned int st=
ep)
 {
 	unsigned int scale, int_part, float_part;
=20
-	scale =3D step >> (SUN8I_VI_SCALER_SCALE_FRAC - 3);
+	scale =3D step >> (DE2_VI_SCALER_SCALE_FRAC - 3);
 	int_part =3D scale >> 3;
 	float_part =3D scale & 0x7;
=20
@@ -880,24 +880,24 @@ static void sun8i_vi_scaler_set_coeff(struct regmap=
 *map, u32 base,
 	}
=20
 	offset =3D sun8i_vi_scaler_coef_index(hstep) *
-			SUN8I_VI_SCALER_COEFF_COUNT;
-	for (i =3D 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++) {
-		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF0(base, i),
+			DE2_VI_SCALER_COEFF_COUNT;
+	for (i =3D 0; i < DE2_VI_SCALER_COEFF_COUNT; i++) {
+		regmap_write(map, DE2_SCALER_VSU_YHCOEFF0(base, i),
 			     lan3coefftab32_left[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF1(base, i),
+		regmap_write(map, DE2_SCALER_VSU_YHCOEFF1(base, i),
 			     lan3coefftab32_right[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF0(base, i),
+		regmap_write(map, DE2_SCALER_VSU_CHCOEFF0(base, i),
 			     ch_left[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF1(base, i),
+		regmap_write(map, DE2_SCALER_VSU_CHCOEFF1(base, i),
 			     ch_right[offset + i]);
 	}
=20
 	offset =3D sun8i_vi_scaler_coef_index(hstep) *
-			SUN8I_VI_SCALER_COEFF_COUNT;
-	for (i =3D 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++) {
-		regmap_write(map, SUN8I_SCALER_VSU_YVCOEFF(base, i),
+			DE2_VI_SCALER_COEFF_COUNT;
+	for (i =3D 0; i < DE2_VI_SCALER_COEFF_COUNT; i++) {
+		regmap_write(map, DE2_SCALER_VSU_YVCOEFF(base, i),
 			     lan2coefftab32[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_CVCOEFF(base, i),
+		regmap_write(map, DE2_SCALER_VSU_CVCOEFF(base, i),
 			     cy[offset + i]);
 	}
 }
@@ -909,13 +909,12 @@ void sun8i_vi_scaler_enable(struct sun8i_mixer *mix=
er, int layer, bool enable)
 	base =3D sun8i_vi_scaler_base(mixer, layer);
=20
 	if (enable)
-		val =3D SUN8I_SCALER_VSU_CTRL_EN |
-		      SUN8I_SCALER_VSU_CTRL_COEFF_RDY;
+		val =3D DE2_SCALER_VSU_CTRL_EN | DE2_SCALER_VSU_CTRL_COEFF_RDY;
 	else
 		val =3D 0;
=20
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CTRL(base), val);
+		     DE2_SCALER_VSU_CTRL(base), val);
 }
=20
 void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
@@ -929,13 +928,13 @@ void sun8i_vi_scaler_setup(struct sun8i_mixer *mixe=
r, int layer,
=20
 	base =3D sun8i_vi_scaler_base(mixer, layer);
=20
-	hphase <<=3D SUN8I_VI_SCALER_PHASE_FRAC - 16;
-	vphase <<=3D SUN8I_VI_SCALER_PHASE_FRAC - 16;
-	hscale <<=3D SUN8I_VI_SCALER_SCALE_FRAC - 16;
-	vscale <<=3D SUN8I_VI_SCALER_SCALE_FRAC - 16;
+	hphase <<=3D DE2_VI_SCALER_PHASE_FRAC - 16;
+	vphase <<=3D DE2_VI_SCALER_PHASE_FRAC - 16;
+	hscale <<=3D DE2_VI_SCALER_SCALE_FRAC - 16;
+	vscale <<=3D DE2_VI_SCALER_SCALE_FRAC - 16;
=20
-	insize =3D SUN8I_VI_SCALER_SIZE(src_w, src_h);
-	outsize =3D SUN8I_VI_SCALER_SIZE(dst_w, dst_h);
+	insize =3D DE2_VI_SCALER_SIZE(src_w, src_h);
+	outsize =3D DE2_VI_SCALER_SIZE(dst_w, dst_h);
=20
 	/*
 	 * This is chroma V/H phase calculation as it appears in
@@ -945,38 +944,38 @@ void sun8i_vi_scaler_setup(struct sun8i_mixer *mixe=
r, int layer,
 	if (format->hsub =3D=3D 2 && format->vsub =3D=3D 2) {
 		chphase =3D hphase >> 1;
 		cvphase =3D (vphase >> 1) -
-			(1UL << (SUN8I_VI_SCALER_SCALE_FRAC - 2));
+			(1UL << (DE2_VI_SCALER_SCALE_FRAC - 2));
 	} else {
 		chphase =3D hphase;
 		cvphase =3D vphase;
 	}
=20
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_OUTSIZE(base), outsize);
+		     DE2_SCALER_VSU_OUTSIZE(base), outsize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YINSIZE(base), insize);
+		     DE2_SCALER_VSU_YINSIZE(base), insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YHSTEP(base), hscale);
+		     DE2_SCALER_VSU_YHSTEP(base), hscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YVSTEP(base), vscale);
+		     DE2_SCALER_VSU_YVSTEP(base), vscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YHPHASE(base), hphase);
+		     DE2_SCALER_VSU_YHPHASE(base), hphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YVPHASE(base), vphase);
+		     DE2_SCALER_VSU_YVPHASE(base), vphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CINSIZE(base),
-		     SUN8I_VI_SCALER_SIZE(src_w / format->hsub,
-					  src_h / format->vsub));
+		     DE2_SCALER_VSU_CINSIZE(base),
+		     DE2_VI_SCALER_SIZE(src_w / format->hsub,
+					src_h / format->vsub));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CHSTEP(base),
+		     DE2_SCALER_VSU_CHSTEP(base),
 		     hscale / format->hsub);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CVSTEP(base),
+		     DE2_SCALER_VSU_CVSTEP(base),
 		     vscale / format->vsub);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CHPHASE(base), chphase);
+		     DE2_SCALER_VSU_CHPHASE(base), chphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CVPHASE(base), cvphase);
+		     DE2_SCALER_VSU_CVPHASE(base), cvphase);
 	sun8i_vi_scaler_set_coeff(mixer->engine.regs, base,
 				  hscale, vscale, format);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.h
index f3de87122f07..b3168cae59b8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -16,35 +16,35 @@
 #define DE2_VI_SCALER_UNIT_SIZE 0x20000
=20
 /* this two macros assumes 16 fractional bits which is standard in DRM *=
/
-#define SUN8I_VI_SCALER_SCALE_MIN		1
-#define SUN8I_VI_SCALER_SCALE_MAX		((1UL << 20) - 1)
-
-#define SUN8I_VI_SCALER_SCALE_FRAC		20
-#define SUN8I_VI_SCALER_PHASE_FRAC		20
-#define SUN8I_VI_SCALER_COEFF_COUNT		32
-#define SUN8I_VI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
-
-#define SUN8I_SCALER_VSU_CTRL(base)		((base) + 0x0)
-#define SUN8I_SCALER_VSU_OUTSIZE(base)		((base) + 0x40)
-#define SUN8I_SCALER_VSU_YINSIZE(base)		((base) + 0x80)
-#define SUN8I_SCALER_VSU_YHSTEP(base)		((base) + 0x88)
-#define SUN8I_SCALER_VSU_YVSTEP(base)		((base) + 0x8c)
-#define SUN8I_SCALER_VSU_YHPHASE(base)		((base) + 0x90)
-#define SUN8I_SCALER_VSU_YVPHASE(base)		((base) + 0x98)
-#define SUN8I_SCALER_VSU_CINSIZE(base)		((base) + 0xc0)
-#define SUN8I_SCALER_VSU_CHSTEP(base)		((base) + 0xc8)
-#define SUN8I_SCALER_VSU_CVSTEP(base)		((base) + 0xcc)
-#define SUN8I_SCALER_VSU_CHPHASE(base)		((base) + 0xd0)
-#define SUN8I_SCALER_VSU_CVPHASE(base)		((base) + 0xd8)
-#define SUN8I_SCALER_VSU_YHCOEFF0(base, i)	((base) + 0x200 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_YHCOEFF1(base, i)	((base) + 0x300 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_YVCOEFF(base, i)	((base) + 0x400 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_CHCOEFF0(base, i)	((base) + 0x600 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_CHCOEFF1(base, i)	((base) + 0x700 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_CVCOEFF(base, i)	((base) + 0x800 + 0x4 * (i))
-
-#define SUN8I_SCALER_VSU_CTRL_EN		BIT(0)
-#define SUN8I_SCALER_VSU_CTRL_COEFF_RDY		BIT(4)
+#define DE2_VI_SCALER_SCALE_MIN			1
+#define DE2_VI_SCALER_SCALE_MAX			((1UL << 20) - 1)
+
+#define DE2_VI_SCALER_SCALE_FRAC		20
+#define DE2_VI_SCALER_PHASE_FRAC		20
+#define DE2_VI_SCALER_COEFF_COUNT		32
+#define DE2_VI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
+
+#define DE2_SCALER_VSU_CTRL(base)		((base) + 0x0)
+#define DE2_SCALER_VSU_OUTSIZE(base)		((base) + 0x40)
+#define DE2_SCALER_VSU_YINSIZE(base)		((base) + 0x80)
+#define DE2_SCALER_VSU_YHSTEP(base)		((base) + 0x88)
+#define DE2_SCALER_VSU_YVSTEP(base)		((base) + 0x8c)
+#define DE2_SCALER_VSU_YHPHASE(base)		((base) + 0x90)
+#define DE2_SCALER_VSU_YVPHASE(base)		((base) + 0x98)
+#define DE2_SCALER_VSU_CINSIZE(base)		((base) + 0xc0)
+#define DE2_SCALER_VSU_CHSTEP(base)		((base) + 0xc8)
+#define DE2_SCALER_VSU_CVSTEP(base)		((base) + 0xcc)
+#define DE2_SCALER_VSU_CHPHASE(base)		((base) + 0xd0)
+#define DE2_SCALER_VSU_CVPHASE(base)		((base) + 0xd8)
+#define DE2_SCALER_VSU_YHCOEFF0(base, i)	((base) + 0x200 + 0x4 * (i))
+#define DE2_SCALER_VSU_YHCOEFF1(base, i)	((base) + 0x300 + 0x4 * (i))
+#define DE2_SCALER_VSU_YVCOEFF(base, i)		((base) + 0x400 + 0x4 * (i))
+#define DE2_SCALER_VSU_CHCOEFF0(base, i)	((base) + 0x600 + 0x4 * (i))
+#define DE2_SCALER_VSU_CHCOEFF1(base, i)	((base) + 0x700 + 0x4 * (i))
+#define DE2_SCALER_VSU_CVCOEFF(base, i)		((base) + 0x800 + 0x4 * (i))
+
+#define DE2_SCALER_VSU_CTRL_EN			BIT(0)
+#define DE2_SCALER_VSU_CTRL_COEFF_RDY		BIT(4)
=20
 void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool e=
nable);
 void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
--=20
2.19.0


