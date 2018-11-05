Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A4FECDE4C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4E20882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GyUzBshY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE4E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeKEUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:04:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33030 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:04:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so6077946wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHG3pEhuEYUagxkiAojd6GLQqBQ8g60ZmVS+lON+9AU=;
        b=GyUzBshYb82xkM3Omfd4J4I5SRquHgD03DuZmnVgKBuuiDX5CctabTG1Bm3jPYZiE5
         +gCXPl3p7rYXw3FifcR8rQtRi4eNRxEYN1fQlOcg12TAAQM1vZa6Z8fkC+SFNzBUPC32
         Z7CDhZc9TGn6qyHKtWaeBDFMfavB/O25pi2uAWrHWqxNw81CEQ9xtS+uXVfA5E3rzepl
         PaVROxm1A5wFetOUqsXN0eHSkqSJSw34u0DZ09l5118RlmIo8orYv+JvpsmeyLHIG7CH
         Lo/i9cY6oElX4Vem0GPgsX1+P60RAT4Xw8YPRDbZO4YOZ1CTMJpZb9HkzXT1GrqoZn4x
         Y5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHG3pEhuEYUagxkiAojd6GLQqBQ8g60ZmVS+lON+9AU=;
        b=bbv3UDweybD5XQv0E4vW3zkurunrt/yn3VBG0Rbu0hRHCJqA+RZ5cxqUwNEqPGseRK
         82STdq7DpwYooNLkoZhi2mdAECet7sgXdE/LNh0a8ksMtmZGxPB2y0x68XvXZ/HXWmMv
         Bk/35VarGq6FDbaecTk61tXVNfDZ8mIkgTUjLbnjoJh+Jvz6K2brM+1haux1ZqFFkZcJ
         wQiTdh4A96e8rmVfkfHAvZiUgyVaHfZaV6YLebIR/2yhYkREAAj4mcmz9pBIZJDv2x7C
         eiKEf9CV2t2Xz3FEGTs5Ic9uIduLmxBOIZ5FnlmYDr1i8YbCGY0YMi2L8RDgUUyrqLy9
         4mtQ==
X-Gm-Message-State: AGRZ1gIhvG9ETpKfofreaM9KhtCXpl+iHJUCXtqmaPae8fcKD1/BJLuJ
        KKnjZ90FF658MY2z4EQBBPqfRMpXUeC6Xg==
X-Google-Smtp-Source: AJdET5c3vMDFdsazXfk30zZXypAXRytdXY124vuVqH0Id0zsC++l56yH44uyWgzw9A3qdzSACEJ26Q==
X-Received: by 2002:a1c:a757:: with SMTP id q84-v6mr4126035wme.61.1541414714743;
        Mon, 05 Nov 2018 02:45:14 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id p125-v6sm8033114wmp.2.2018.11.05.02.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:45:13 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/meson: Use optional canvas provider
Date:   Mon,  5 Nov 2018 11:45:08 +0100
Message-Id: <20181105104508.23090-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105104508.23090-1-mjourdan@baylibre.com>
References: <20181105104508.23090-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first step into converting the meson/drm driver to use
the canvas module.

If a canvas provider node is detected in DT, use it. Otherwise,
fall back to what is currently being done.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/gpu/drm/meson/Kconfig       |  1 +
 drivers/gpu/drm/meson/meson_crtc.c  | 14 ++++++---
 drivers/gpu/drm/meson/meson_drv.c   | 46 ++++++++++++++++++-----------
 drivers/gpu/drm/meson/meson_drv.h   |  4 +++
 drivers/gpu/drm/meson/meson_plane.c |  8 ++++-
 5 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index 3ce51d8dfe1c..c28b69f48555 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -7,6 +7,7 @@ config DRM_MESON
 	select DRM_GEM_CMA_HELPER
 	select VIDEOMODE_HELPERS
 	select REGMAP_MMIO
+	select MESON_CANVAS
 
 config DRM_MESON_DW_HDMI
 	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 05520202c967..b3bc0b0ee07f 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -193,10 +193,16 @@ void meson_crtc_irq(struct meson_drm *priv)
 		} else
 			meson_vpp_disable_interlace_vscaler_osd1(priv);
 
-		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
-			   priv->viu.osd1_addr, priv->viu.osd1_stride,
-			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
-			   MESON_CANVAS_BLKMODE_LINEAR);
+		if (priv->canvas)
+			meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
+				priv->viu.osd1_addr, priv->viu.osd1_stride,
+				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
+				MESON_CANVAS_BLKMODE_LINEAR, 0);
+		else
+			meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
+				priv->viu.osd1_addr, priv->viu.osd1_stride,
+				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
+				MESON_CANVAS_BLKMODE_LINEAR);
 
 		/* Enable OSD1 */
 		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index d3443125e661..b39c38c2350d 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -216,24 +216,33 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 		goto free_drm;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
-	if (!res) {
-		ret = -EINVAL;
-		goto free_drm;
-	}
-	/* Simply ioremap since it may be a shared register zone */
-	regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!regs) {
-		ret = -EADDRNOTAVAIL;
-		goto free_drm;
-	}
+	priv->canvas = meson_canvas_get(dev);
+	if (!IS_ERR(priv->canvas)) {
+		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
+		if (ret)
+			goto free_drm;
+	} else {
+		priv->canvas = NULL;
 
-	priv->dmc = devm_regmap_init_mmio(dev, regs,
-					  &meson_regmap_config);
-	if (IS_ERR(priv->dmc)) {
-		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
-		ret = PTR_ERR(priv->dmc);
-		goto free_drm;
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
+		if (!res) {
+			ret = -EINVAL;
+			goto free_drm;
+		}
+		/* Simply ioremap since it may be a shared register zone */
+		regs = devm_ioremap(dev, res->start, resource_size(res));
+		if (!regs) {
+			ret = -EADDRNOTAVAIL;
+			goto free_drm;
+		}
+
+		priv->dmc = devm_regmap_init_mmio(dev, regs,
+						  &meson_regmap_config);
+		if (IS_ERR(priv->dmc)) {
+			dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
+			ret = PTR_ERR(priv->dmc);
+			goto free_drm;
+		}
 	}
 
 	priv->vsync_irq = platform_get_irq(pdev, 0);
@@ -315,6 +324,9 @@ static void meson_drv_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct meson_drm *priv = drm->dev_private;
 
+	if (priv->canvas)
+		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
+
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_fbdev_cma_fini(priv->fbdev);
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 8450d6ac8c9b..728d0ca33732 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/soc/amlogic/meson-canvas.h>
 #include <drm/drmP.h>
 
 struct meson_drm {
@@ -31,6 +32,9 @@ struct meson_drm {
 	struct regmap *dmc;
 	int vsync_irq;
 
+	struct meson_canvas *canvas;
+	u8 canvas_id_osd1;
+
 	struct drm_device *drm;
 	struct drm_crtc *crtc;
 	struct drm_fbdev_cma *fbdev;
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 12c80dfcff59..51bec8e98a39 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -90,6 +90,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		.y2 = state->crtc_y + state->crtc_h,
 	};
 	unsigned long flags;
+	u8 canvas_id_osd1;
 
 	/*
 	 * Update Coordinates
@@ -104,8 +105,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 				   (0xFF << OSD_GLOBAL_ALPHA_SHIFT) |
 				   OSD_BLK0_ENABLE;
 
+	if (priv->canvas)
+		canvas_id_osd1 = priv->canvas_id_osd1;
+	else
+		canvas_id_osd1 = MESON_CANVAS_ID_OSD1;
+
 	/* Set up BLK0 to point to the right canvas */
-	priv->viu.osd1_blk0_cfg[0] = ((MESON_CANVAS_ID_OSD1 << OSD_CANVAS_SEL) |
+	priv->viu.osd1_blk0_cfg[0] = ((canvas_id_osd1 << OSD_CANVAS_SEL) |
 				      OSD_ENDIANNESS_LE);
 
 	/* On GXBB, Use the old non-HDR RGB2YUV converter */
-- 
2.19.1

