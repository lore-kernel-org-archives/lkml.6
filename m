Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92488C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5804721A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5804721A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHFOHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:07:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53016 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731540AbeHFOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:07:16 -0400
X-UUID: c202b9cb6c6d44c1a4734f7997881aba-20180806
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 392066325; Mon, 06 Aug 2018 19:58:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 6 Aug 2018 19:58:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 6 Aug 2018 19:58:24 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 12/13] drm/mediatek: update some variable name from ovl to comp
Date:   Mon, 6 Aug 2018 19:58:19 +0800
Message-ID: <1533556700-26525-13-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch update some variable name from ovl to comp

Because RDMA would be first HW in ddp, the naming ovl
should be change to comp.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 26 +++++++++++++-------------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 1a8685fbbf57..e31722db3184 100644
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
index 60bcc8aba8e3..091adb2087eb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -23,7 +23,7 @@
 #define MTK_MIN_BPC	3
 
 void mtk_drm_crtc_commit(struct drm_crtc *crtc);
-void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *ovl);
+void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *comp);
 int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			const enum mtk_ddp_comp_id *path,
 			unsigned int path_len);
-- 
2.12.5.2.gbdf23ab

