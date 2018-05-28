Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeE1Gi5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:38:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48455 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753565AbeE1Gin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:38:43 -0400
X-UUID: 5b7a9168cf044cbead6bd633a6385a60-20180528
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v4 7/9] drm/mediatek: add connection from OD1 to RDMA1
Date: Mon, 28 May 2018 14:38:25 +0800
Message-ID: <1527489507-24453-8-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the connection from OD1 to RDMA1 for ext path.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 58e44349e315..8bfc0debd2c2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -75,6 +75,7 @@
 
 #define OVL0_MOUT_EN_COLOR0		0x1
 #define OD_MOUT_EN_RDMA0		0x1
+#define OD1_MOUT_EN_RDMA1		BIT(16)
 #define UFOE_MOUT_EN_DSI0		0x1
 #define COLOR0_SEL_IN_OVL0		0x1
 #define OVL1_MOUT_EN_COLOR1		0x1
@@ -151,6 +152,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_GAMMA && next == DDP_COMPONENT_RDMA1) {
 		*addr = DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
 		value = GAMMA_MOUT_EN_RDMA1;
+	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
+		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
+		value = OD1_MOUT_EN_RDMA1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
 		value = RDMA1_MOUT_DPI0;
-- 
2.12.5
