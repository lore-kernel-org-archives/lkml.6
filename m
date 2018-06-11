Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qhLQHv/rHVuxIwAAmS7hNA
	; Mon, 11 Jun 2018 03:28:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3DA8F607E7; Mon, 11 Jun 2018 03:28:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8846460792;
	Mon, 11 Jun 2018 03:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8846460792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeFKD2D (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:28:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37847 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932494AbeFKD1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:27:17 -0400
X-UUID: fa454d305bc94c41aa2b22be4506b2e3-20180611
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 416502438; Mon, 11 Jun 2018 11:27:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 11 Jun 2018 11:27:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 11 Jun 2018 11:27:13 +0800
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, "Stu Hsieh" <stu.hsieh@mediatek.com>
Subject: [PATCH 28/28] drm/mediatek: Add support for mediatek SOC MT2712
Date: Mon, 11 Jun 2018 11:26:20 +0800
Message-ID: <1528687580-549-29-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for the Mediatek MT2712 DISP subsystem.
There are two OVL engine and three disp output in MT2712.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 39 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 28dd8531a7de..c3fa5591bfc8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -65,6 +65,24 @@
 #define MT8173_MUTEX_MOD_DISP_PWM1		24
 #define MT8173_MUTEX_MOD_DISP_OD		25
 
+#define MT2712_MUTEX_MOD_DISP_PWM2		10
+#define MT2712_MUTEX_MOD_DISP_OVL0		11
+#define MT2712_MUTEX_MOD_DISP_OVL1		12
+#define MT2712_MUTEX_MOD_DISP_RDMA0		13
+#define MT2712_MUTEX_MOD_DISP_RDMA1		14
+#define MT2712_MUTEX_MOD_DISP_RDMA2		15
+#define MT2712_MUTEX_MOD_DISP_WDMA0		16
+#define MT2712_MUTEX_MOD_DISP_WDMA1		17
+#define MT2712_MUTEX_MOD_DISP_COLOR0		18
+#define MT2712_MUTEX_MOD_DISP_COLOR1		19
+#define MT2712_MUTEX_MOD_DISP_AAL0		20
+#define MT2712_MUTEX_MOD_DISP_UFOE		22
+#define MT2712_MUTEX_MOD_DISP_PWM0		23
+#define MT2712_MUTEX_MOD_DISP_PWM1		24
+#define MT2712_MUTEX_MOD_DISP_OD0		25
+#define MT2712_MUTEX_MOD2_DISP_AAL1		33
+#define MT2712_MUTEX_MOD2_DISP_OD1		34
+
 #define MT2701_MUTEX_MOD_DISP_OVL		3
 #define MT2701_MUTEX_MOD_DISP_WDMA		6
 #define MT2701_MUTEX_MOD_DISP_COLOR		7
@@ -138,6 +156,26 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
 };
 
+static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT2712_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
+	[DDP_COMPONENT_COLOR0] = MT2712_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_COLOR1] = MT2712_MUTEX_MOD_DISP_COLOR1,
+	[DDP_COMPONENT_OD0] = MT2712_MUTEX_MOD_DISP_OD0,
+	[DDP_COMPONENT_OD1] = MT2712_MUTEX_MOD2_DISP_OD1,
+	[DDP_COMPONENT_OVL0] = MT2712_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL1] = MT2712_MUTEX_MOD_DISP_OVL1,
+	[DDP_COMPONENT_PWM0] = MT2712_MUTEX_MOD_DISP_PWM0,
+	[DDP_COMPONENT_PWM1] = MT2712_MUTEX_MOD_DISP_PWM1,
+	[DDP_COMPONENT_PWM2] = MT2712_MUTEX_MOD_DISP_PWM2,
+	[DDP_COMPONENT_RDMA0] = MT2712_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT2712_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_RDMA2] = MT2712_MUTEX_MOD_DISP_RDMA2,
+	[DDP_COMPONENT_UFOE] = MT2712_MUTEX_MOD_DISP_UFOE,
+	[DDP_COMPONENT_WDMA0] = MT2712_MUTEX_MOD_DISP_WDMA0,
+	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
+};
+
 static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
@@ -533,6 +571,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 
 static const struct of_device_id ddp_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
+	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
 	{},
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 3d279a299383..3a866e1d6af4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -146,6 +146,32 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_OD0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_DPI0,
+	DDP_COMPONENT_PWM0,
+};
+
+static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
+	DDP_COMPONENT_OVL1,
+	DDP_COMPONENT_COLOR1,
+	DDP_COMPONENT_AAL1,
+	DDP_COMPONENT_OD1,
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DPI1,
+	DDP_COMPONENT_PWM1,
+};
+
+static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
+	DDP_COMPONENT_RDMA2,
+	DDP_COMPONENT_DSI3,
+	DDP_COMPONENT_PWM2,
+};
+
 static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
@@ -173,6 +199,15 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.shadow_register = true,
 };
 
+static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
+	.main_path = mt2712_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
+	.ext_path = mt2712_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
+	.third_path = mt2712_mtk_ddp_third,
+	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
+};
+
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_path = mt8173_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
@@ -379,6 +414,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
 	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
@@ -557,6 +593,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 static const struct of_device_id mtk_drm_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmsys",
 	  .data = &mt2701_mmsys_driver_data},
+	{ .compatible = "mediatek,mt2712-mmsys",
+	  .data = &mt2712_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
-- 
2.12.5
