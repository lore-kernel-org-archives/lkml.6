Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZoRjfVrYxADfvMpJVim8dTnN+2WZ3KhbBaxVj8vJEbxS35cdO27eqOVuuEp6MZLxCO1NT0i
ARC-Seal: i=1; a=rsa-sha256; t=1524821093; cv=none;
        d=google.com; s=arc-20160816;
        b=k65OqF3s4hY+OzsIuaFEjwgV9Wjq+rwqSa2b87MgS+WCNR2tfsjpNc1u1DXg70oUdQ
         T7goktAOnehkhtXIA9+VsiU9Ivh8dHQDIt6q35Ia8Dwl1gE0cr78WparB0stL1pp7f2T
         s1SdipYRZaS3qtguoPI9p4o7y2DJtuaZYBNFzSrpbQzzGk/kO9j62CHApREeThQm4ew+
         EsivYsYsdIlMRPgnz0RlvtXWp650HL4LVnM6Y+sFdFwkddDnyGoMbSu4P5KlZFueTK7E
         T5lmkR1B/Vy9YCSzy8GoKWpFNuTptpIOOsJKAeW8oEG2+jtszlCOEjd0/ezfaqMFk0u+
         K/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Htpyi96QGRH4gpXaiD7vCpyHPwzKJxwR7VO4WjlQ2lY=;
        b=xFE4YVVt01PO0PSHMx4nlcVggpOImvG2Oy8sB8MgyHImld/HfRDk7inWxI89bKYznH
         xi/Hl4rdwdckqZ/TFgWGUtBz0zPpM5tn34ZQGVfywA5Qbdi0bpF7PI6IhrShojybM3iB
         lbn5ZGET1tIy1aN6kh0PdFMbzcdoIF8dtaPNt8GU44DWttPVOoqW+jKXQFgm4CjBVGG1
         xP2iu+fEqg2/iLyD7hz1apbvlvRV6VYZ2/rNImatn+9EqAingSZ3V9O59Adq6LS83fpN
         eh+JonF04Ey73DBye9QAimHO06PHxUV6MQEkuqIvkAdGQAS+1sbVBh+imsb9n/erezPS
         oXog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2AB21879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v3 07/10] drm/mediatek: Add mfd support for mt8173
Date: Fri, 27 Apr 2018 11:23:59 +0200
Message-Id: <caba94bee1fefa6eb507c6c91c25ed085f996b9a.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890803293111294?=
X-GMAIL-MSGID: =?utf-8?q?1598890803293111294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

Use the MFD device for SoC mt8173. Probing via devicetree
is no longer needed for any SoC, so delete it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 88ee35907744..3cc433ebfa8f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -399,20 +399,12 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
-	/* Check if called from mfd */
-	if (!dev->of_node) {
-		mmsys_node = pdev->dev.parent->of_node;
-		private->data = (struct mtk_mmsys_driver_data *)
-				platform_get_device_id(pdev)->driver_data;
-		private->config_regs =
-			syscon_node_to_regmap(mmsys_node);
-		parent_node = mmsys_node->parent;
-	} else {
-		private->config_regs = syscon_node_to_regmap(dev->of_node);
-		if (IS_ERR(private->config_regs))
-			return PTR_ERR(private->config_regs);
-		parent_node = dev->of_node->parent;
-	}
+	mmsys_node = pdev->dev.parent->of_node;
+	private->data = (struct mtk_mmsys_driver_data *)
+			platform_get_device_id(pdev)->driver_data;
+	private->config_regs =
+		syscon_node_to_regmap(mmsys_node);
+	parent_node = mmsys_node->parent;
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(parent_node, node) {
@@ -555,14 +547,9 @@ static int mtk_drm_sys_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 			 mtk_drm_sys_resume);
 
-static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-mmsys",
-	  .data = &mt8173_mmsys_driver_data},
-	{ }
-};
-
 static const struct platform_device_id mtk_drm_ids[] = {
 	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
+	{ "drm-mt8173-mm", (kernel_ulong_t)&mt8173_mmsys_driver_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
@@ -572,7 +559,6 @@ static struct platform_driver mtk_drm_platform_driver = {
 	.remove	= mtk_drm_remove,
 	.driver	= {
 		.name	= "mediatek-drm",
-		.of_match_table = mtk_drm_of_ids,
 		.pm     = &mtk_drm_pm_ops,
 	},
 	.id_table = mtk_drm_ids,
-- 
2.16.3
