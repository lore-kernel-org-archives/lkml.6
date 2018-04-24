Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx4/bVQ7x/mK4MRlCE93q2Cayg2NohcwxtxZyjt5LJqFgQ8uQSIfXu+5EmpNfQIO5VJBYQ/a+
ARC-Seal: i=1; a=rsa-sha256; t=1524563277; cv=none;
        d=google.com; s=arc-20160816;
        b=WkzvBnxaJKFdNTWp8Ukr0Z54T8FSC55hR/WOE7vI/Ok0jN8mlOtsVWo6OHFF0b2GTQ
         /HKV/tTno9XrNxqionmI1GglK4ScS8AI5NaKvnQAXNuSNQTBMxYxtS4RGvmePsZYCshd
         ePKcGEzS6KHM0EHzMBjRP4bckPHneRudeqXDghbXMgcWsT37zzjplTmHlAYZ5IALutGG
         DJR4KDq+G1uCzI4UdRNOcivKUGGhw2zcdqkDpkgb3eUKVw/8Ilvhiz0NggFX0c175idM
         GiV41rSf+oIDt7N4Qr3bVSRCAGq8h+htlslQvS/zrv6L70ldcVTaY7eqyvy3CBH3uSjH
         RmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Htpyi96QGRH4gpXaiD7vCpyHPwzKJxwR7VO4WjlQ2lY=;
        b=bE9EUXlcr+ees9U+/5qeW9QRU2LiX0eoImoLjEYpEkR5AcG7xTjpSLlNJBaSoGN3gf
         Z8e+K/qDpufL9RIYIPYlcz3FcBygusmBasmcn1RFieArN8RftttdSC71fnv6d0K1z2f1
         Gh/sPXwcymFvT7nvgeUx1AvG1rNVekW1pYntd9z3HO2Pffbqg4gvYewOXctwHqSWwFUG
         Pe/tAPSCOvlzxz+G0Pp+tMZGGJXAr0YrvXCfNKyekUQQjvcD4TYZ3gNglGteQQW4htHV
         hpFz2qOUkfnNZuL/9J7lHLAPsZzFHjZQyVxHi9WX4B7FsamDGBFKENEYzUjI3M+sxs1O
         VAUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C58B217D2
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
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 resend 07/10] drm/mediatek: Add mfd support for mt8173
Date: Tue, 24 Apr 2018 11:47:04 +0200
Message-Id: <ae6e77bc3f5c29ce53e248162a42f4eb4e42a417.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620463122620503?=
X-GMAIL-MSGID: =?utf-8?q?1598620463122620503?=
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
