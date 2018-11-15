Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5862145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gluegarage.com header.i=@gluegarage.com header.b="nmwpi/hN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gw/6GvoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5862145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gluegarage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbeKPI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:27:05 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37225 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbeKPI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:27:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5528623160;
        Thu, 15 Nov 2018 17:17:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Nov 2018 17:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gluegarage.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=mesmtp; bh=UssMcyhLMr
        6//YK+EB26j2teh4LGWOmFqH20G2+gzdA=; b=nmwpi/hNvw61BYn1Whanwh0tJk
        8dlYNKPLt+ngGhY6qx6Kh/P9mdbYG1JQAGwxci/wB2JmRi8TyuREE1ZrC8/VKAer
        zoyLrfxyrLX9cbm9UY7YY685qBHOx3YVmue3aZBBasIFqKena2msIGDfzwz26j9h
        714UcJeuYACpqPVzM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UssMcyhLMr6//YK+EB26j2teh4LGWOmFqH20G2+gzdA=; b=Gw/6GvoJ
        XxyFRhSACLjNuyVo18ycHPY+woYLFsyfKZi1DRaQOpBKLDOBufN+Rnz3Nm+0bFpF
        iqDcM24NCcMxlWZnmuuE3ZLvtmWiuKwPE/CZCiP5sRtr8tnTD1kyAD+i/ZC1SynU
        hy3NVbjsusKuFv8OtD36D7SZuhcLRg/poNiBZIkOopV7px9HrIyD9Jj+pn/BKEK6
        je+x8mggThUsMhodJ+8VIWsqQH1dgFo1ucni86TL7SUpkXocAAacSBsA1jUsmYHJ
        wOR4RYiMCiPbVLq9lDse2w6PpJp+lMCw2g/T0rikHiM6JXsmj7tZwab4DG+NugHN
        nMFG544iwu3SzQ==
X-ME-Sender: <xms:cvDtW_LCI6dykRn5707G5pAPP6UofOuje-6P7AhwyhKCVbPTVROUZw>
X-ME-Proxy: <xmx:cvDtW9OGIpufVOYtsJ2GrR9vuxVd0OrZYIP0-j8bsSPg_jHvASk7mA>
    <xmx:cvDtW25XPGxfwSKLfuybMZ0fyhsFA44ZU1EGNtXqUtIbE_dz_voXqw>
    <xmx:c_DtWxVglftr-Di3-axcom39tklFZGs9fVj5D65_F3J6Pz5V5ZAcTA>
    <xmx:c_DtWw3__kCMTbbsmuXneouzL6bNidr57LQlPBT-A7lW6MWoa9Ujrw>
    <xmx:c_DtWwM7E0a27R9-b723smlm2IKjB1fy5mzshebyGqYlzr5paC9etg>
    <xmx:c_DtW1vK4at6ZklY_0fSRgQHjzzrsXVD6Bl-otMqf7KdLmdo14I5HQ>
Received: from zaca_x230.localdomain (unknown [109.205.143.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id B693CE49AD;
        Thu, 15 Nov 2018 17:17:18 -0500 (EST)
From:   Fernando Ramos <greenfoo@gluegarage.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH 3/9] drm: replace "drm_dev_unref" function with "drm_dev_put"
Date:   Thu, 15 Nov 2018 23:16:23 +0100
Message-Id: <20181115221634.22715-4-greenfoo@gluegarage.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch unifies the naming of DRM functions for reference counting as
requested on Documentation/gpu/todo.rst

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 drivers/gpu/drm/arc/arcpgu_drv.c             | 4 ++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 4 ++--
 drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_drv.c        | 2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 4 ++--
 drivers/gpu/drm/tve200/tve200_drv.c          | 4 ++--
 drivers/gpu/drm/zte/zx_drm_drv.c             | 4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index f067de4e1e82..dcb06d4e9135 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -216,7 +216,7 @@ static int arcpgu_probe(struct platform_device *pdev)
 	arcpgu_unload(drm);
 
 err_unref:
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return ret;
 }
@@ -227,7 +227,7 @@ static int arcpgu_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(drm);
 	arcpgu_unload(drm);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 843cac222e60..f8da51a63e2f 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -775,7 +775,7 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
 	atmel_hlcdc_dc_unload(ddev);
 
 err_unref:
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return ret;
 }
@@ -786,7 +786,7 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(ddev);
 	atmel_hlcdc_dc_unload(ddev);
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 83c1f46670bf..52802e6049e0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -550,7 +550,7 @@ static int etnaviv_bind(struct device *dev)
 out_bind:
 	kfree(priv);
 out_unref:
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return ret;
 }
@@ -567,7 +567,7 @@ static void etnaviv_unbind(struct device *dev)
 	drm->dev_private = NULL;
 	kfree(priv);
 
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 }
 
 static const struct component_master_ops etnaviv_master_ops = {
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 2393e6d16ffd..88ba003979e6 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -417,7 +417,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 err_unload:
 	mxsfb_unload(drm);
 err_free:
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return ret;
 }
@@ -428,7 +428,7 @@ static int mxsfb_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(drm);
 	mxsfb_unload(drm);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 084f58df4a8c..c7fe2433ab9e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -454,7 +454,7 @@ static int rcar_du_remove(struct platform_device *pdev)
 	drm_kms_helper_poll_fini(ddev);
 	drm_mode_config_cleanup(ddev);
 
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index 6ececad6f845..8554102a6ead 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -194,7 +194,7 @@ static int shmob_drm_remove(struct platform_device *pdev)
 	drm_kms_helper_poll_fini(ddev);
 	drm_mode_config_cleanup(ddev);
 	drm_irq_uninstall(ddev);
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return 0;
 }
@@ -290,7 +290,7 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	drm_kms_helper_poll_fini(ddev);
 	drm_mode_config_cleanup(ddev);
 err_free_drm_dev:
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 72efcecb44f7..28e2d03c0ccf 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -249,7 +249,7 @@ static int tve200_probe(struct platform_device *pdev)
 clk_disable:
 	clk_disable_unprepare(priv->pclk);
 dev_unref:
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 	return ret;
 }
 
@@ -263,7 +263,7 @@ static int tve200_remove(struct platform_device *pdev)
 		drm_panel_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 	clk_disable_unprepare(priv->pclk);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
index 11ef17c2d1c1..5b6f1eda52e0 100644
--- a/drivers/gpu/drm/zte/zx_drm_drv.c
+++ b/drivers/gpu/drm/zte/zx_drm_drv.c
@@ -114,7 +114,7 @@ static int zx_drm_bind(struct device *dev)
 	component_unbind_all(dev, drm);
 out_unregister:
 	dev_set_drvdata(dev, NULL);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 	return ret;
 }
 
@@ -127,7 +127,7 @@ static void zx_drm_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	component_unbind_all(dev, drm);
 	dev_set_drvdata(dev, NULL);
-	drm_dev_unref(drm);
+	drm_dev_put(drm);
 }
 
 static const struct component_master_ops zx_drm_master_ops = {
-- 
2.19.1

