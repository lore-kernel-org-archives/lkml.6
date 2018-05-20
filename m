Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeETRCh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:02:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25249 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752566AbeETRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:21 -0400
X-UUID: 1c9363b3fa654863b4251a4e1a30454a-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 4/7] pinctrl: mediatek: use generic EINT register maps for each SoC
Date: Mon, 21 May 2018 01:01:50 +0800
Message-ID: <39738efefe94e3a4fb7668a27dd73ae49695dc3b.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

So far, EINT on each SoC all used exactly identical register map and thus
it's better that we apply generic register map already supported in EINT
library and stop copy-n-pasting the same data block and filling into its
platform data.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 20 --------------------
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 20 --------------------
 drivers/pinctrl/mediatek/pinctrl-mt8127.c     | 20 --------------------
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     | 20 --------------------
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 20 --------------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  6 +++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  2 +-
 7 files changed, 6 insertions(+), 102 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index e0963c6..db22250 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -538,26 +538,6 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 		.ap_num    = 169,
 		.db_cnt    = 16,
 	},
-	.eint_regs = {
-		.stat      = 0x000,
-		.ack       = 0x040,
-		.mask      = 0x080,
-		.mask_set  = 0x0c0,
-		.mask_clr  = 0x100,
-		.sens      = 0x140,
-		.sens_set  = 0x180,
-		.sens_clr  = 0x1c0,
-		.soft      = 0x200,
-		.soft_set  = 0x240,
-		.soft_clr  = 0x280,
-		.pol       = 0x300,
-		.pol_set   = 0x340,
-		.pol_clr   = 0x380,
-		.dom_en    = 0x400,
-		.dbnc_ctrl = 0x500,
-		.dbnc_set  = 0x600,
-		.dbnc_clr  = 0x700,
-	},
 };
 
 static int mt2701_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index 02aff28..6e2acef 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -583,26 +583,6 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 		.ap_num    = 229,
 		.db_cnt    = 40,
 	},
-	.eint_regs = {
-		.stat      = 0x000,
-		.ack       = 0x040,
-		.mask      = 0x080,
-		.mask_set  = 0x0c0,
-		.mask_clr  = 0x100,
-		.sens      = 0x140,
-		.sens_set  = 0x180,
-		.sens_clr  = 0x1c0,
-		.soft      = 0x200,
-		.soft_set  = 0x240,
-		.soft_clr  = 0x280,
-		.pol       = 0x300,
-		.pol_set   = 0x340,
-		.pol_clr   = 0x380,
-		.dom_en    = 0x400,
-		.dbnc_ctrl = 0x500,
-		.dbnc_set  = 0x600,
-		.dbnc_clr  = 0x700,
-	},
 };
 
 static int mt2712_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index 71f6258..949a235 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -307,26 +307,6 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 		.ap_num    = 143,
 		.db_cnt    = 16,
 	},
-	.eint_regs = {
-		.stat      = 0x000,
-		.ack       = 0x040,
-		.mask      = 0x080,
-		.mask_set  = 0x0c0,
-		.mask_clr  = 0x100,
-		.sens      = 0x140,
-		.sens_set  = 0x180,
-		.sens_clr  = 0x1c0,
-		.soft      = 0x200,
-		.soft_set  = 0x240,
-		.soft_clr  = 0x280,
-		.pol       = 0x300,
-		.pol_set   = 0x340,
-		.pol_clr   = 0x380,
-		.dom_en    = 0x400,
-		.dbnc_ctrl = 0x500,
-		.dbnc_set  = 0x600,
-		.dbnc_clr  = 0x700,
-	},
 };
 
 static int mt8127_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index fdfa357..974a1f43 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -320,26 +320,6 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 		.ap_num    = 192,
 		.db_cnt    = 16,
 	},
-	.eint_regs = {
-		.stat      = 0x000,
-		.ack       = 0x040,
-		.mask      = 0x080,
-		.mask_set  = 0x0c0,
-		.mask_clr  = 0x100,
-		.sens      = 0x140,
-		.sens_set  = 0x180,
-		.sens_clr  = 0x1c0,
-		.soft      = 0x200,
-		.soft_set  = 0x240,
-		.soft_clr  = 0x280,
-		.pol       = 0x300,
-		.pol_set   = 0x340,
-		.pol_clr   = 0x380,
-		.dom_en    = 0x400,
-		.dbnc_ctrl = 0x500,
-		.dbnc_set  = 0x600,
-		.dbnc_clr  = 0x700,
-	},
 };
 
 static int mt8135_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index 1466c95..a836cee3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -347,26 +347,6 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 		.ap_num    = 224,
 		.db_cnt    = 16,
 	},
-	.eint_regs = {
-		.stat      = 0x000,
-		.ack       = 0x040,
-		.mask      = 0x080,
-		.mask_set  = 0x0c0,
-		.mask_clr  = 0x100,
-		.sens      = 0x140,
-		.sens_set  = 0x180,
-		.sens_clr  = 0x1c0,
-		.soft      = 0x200,
-		.soft_set  = 0x240,
-		.soft_clr  = 0x280,
-		.pol       = 0x300,
-		.pol_set   = 0x340,
-		.pol_clr   = 0x380,
-		.dom_en    = 0x400,
-		.dbnc_ctrl = 0x500,
-		.dbnc_set  = 0x600,
-		.dbnc_clr  = 0x700,
-	},
 };
 
 static int mt8173_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 11e0d0f..b379969 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1014,7 +1014,11 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 		return -EINVAL;
 
 	pctl->eint->dev = &pdev->dev;
-	pctl->eint->regs = &pctl->devdata->eint_regs;
+	/*
+	 * If pctl->eint->regs == NULL, it would fall back into using a generic
+	 * register map in mtk_eint_do_init calls.
+	 */
+	pctl->eint->regs = pctl->devdata->eint_regs;
 	pctl->eint->hw = &pctl->devdata->eint_hw;
 	pctl->eint->pctl = pctl;
 	pctl->eint->gpio_xlate = &mtk_eint_xt;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 346e3db..bf13eb0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -261,7 +261,7 @@ struct mtk_pinctrl_devdata {
 	unsigned char  port_mask;
 	unsigned char  port_align;
 	struct mtk_eint_hw eint_hw;
-	struct mtk_eint_regs eint_regs;
+	struct mtk_eint_regs *eint_regs;
 };
 
 struct mtk_pinctrl {
-- 
2.7.4
