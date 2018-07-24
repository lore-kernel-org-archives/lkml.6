Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED20205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED20205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbeGXJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63609 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388601AbeGXJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:45 -0400
X-UUID: 39c764c3bf514d23910a4843d256f517-20180724
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 128850982; Tue, 24 Jul 2018 16:17:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 16:17:22 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 13/15] drm/mediatek: Update some variable name from ovl to comp
Date:   Tue, 24 Jul 2018 16:17:13 +0800
Message-ID: <1532420235-22268-14-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch Update some variable name from ovl to comp

Because RDMA would be first HW in ddp, the naming ovl
should be change to comp.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 26 +++++++++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 8ad90c62caa6..2509ed3e0278 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -172,9 +172,9 @@ static void mtk_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 static int mtk_drm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 
-	mtk_ddp_comp_enable_vblank(ovl, &mtk_crtc->base);
+	mtk_ddp_comp_enable_vblank(comp, &mtk_crtc->base);
 
 	return 0;
 }
@@ -182,9 +182,9 @@ static int mtk_drm_crtc_enable_vblank(struct drm_crtc *crtc)
 static void mtk_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 
-	mtk_ddp_comp_disable_vblank(ovl);
+	mtk_ddp_comp_disable_vblank(comp);
 }
 
 static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
@@ -335,7 +335,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
-	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	unsigned int i;
 
 	/*
@@ -344,7 +344,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 	 * queue update module registers on vblank.
 	 */
 	if (state->pending_config) {
-		mtk_ddp_comp_config(ovl, state->pending_width,
+		mtk_ddp_comp_config(comp, state->pending_width,
 				    state->pending_height,
 				    state->pending_vrefresh, 0);
 
@@ -359,7 +359,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 			plane_state = to_mtk_plane_state(plane->state);
 
 			if (plane_state->pending.config) {
-				mtk_ddp_comp_layer_config(ovl, i, plane_state);
+				mtk_ddp_comp_layer_config(comp, i, plane_state);
 				plane_state->pending.config = false;
 			}
 		}
@@ -371,12 +371,12 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_crtc_state *old_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	int ret;
 
 	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
 
-	ret = mtk_smi_larb_get(ovl->larb_dev);
+	ret = mtk_smi_larb_get(comp->larb_dev);
 	if (ret) {
 		DRM_ERROR("Failed to get larb: %d\n", ret);
 		return;
@@ -384,7 +384,7 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
 	if (ret) {
-		mtk_smi_larb_put(ovl->larb_dev);
+		mtk_smi_larb_put(comp->larb_dev);
 		return;
 	}
 
@@ -396,7 +396,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_crtc_state *old_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_ddp_comp *ovl = mtk_crtc->ddp_comp[0];
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	int i;
 
 	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
@@ -419,7 +419,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	drm_crtc_vblank_off(crtc);
 	mtk_crtc_ddp_hw_fini(mtk_crtc);
-	mtk_smi_larb_put(ovl->larb_dev);
+	mtk_smi_larb_put(comp->larb_dev);
 
 	mtk_crtc->enabled = false;
 }
@@ -517,7 +517,7 @@ static int mtk_drm_crtc_init(struct drm_device *drm,
 	return ret;
 }
 
-void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl)
+void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *comp)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	struct mtk_drm_private *priv = crtc->dev->dev_private;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
index b44fefadf14a..0de77f60c806 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -26,7 +26,7 @@
 #define MTK_MIN_BPC	3
 
 void mtk_drm_crtc_commit(struct drm_crtc *crtc);
-void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl);
+void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *comp);
 int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			const enum mtk_ddp_comp_id *path,
 			unsigned int path_len);
-- 
2.12.5

