Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736ECC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AF32083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AF32083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965919AbeFSHjT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:39:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36207 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965494AbeFSHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:35:05 -0400
X-UUID: b131be5b951a4e5f804f7d8f020b82b2-20180619
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1226143162; Tue, 19 Jun 2018 15:35:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 15:34:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 15:34:59 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v6 17/29] drm/mediatek: add connection from RDMA1 to DSI1
Date:   Tue, 19 Jun 2018 15:34:18 +0800
Message-ID: <1529393670-26862-18-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the connection from RDMA1 to DSI1

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 13e91903f493..90228cad051a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -28,6 +28,7 @@
 #define DISP_REG_CONFIG_DISP_UFOE_MOUT_EN	0x050
 #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
 #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
+#define DISP_REG_CONFIG_DSIO_SEL_IN		0x0a8
 #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
 #define DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN	0x0c4
 #define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
@@ -86,8 +87,10 @@
 #define RDMA0_SOUT_DSI3			0x5
 #define RDMA1_SOUT_DPI0			0x2
 #define RDMA1_SOUT_DPI1			0x3
+#define RDMA1_SOUT_DSI1			0x1
 #define DPI0_SEL_IN_RDMA1		0x1
 #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
+#define DSI1_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
 
 #define OVL_MOUT_EN_RDMA		0x1
@@ -170,6 +173,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
 		value = RDMA0_SOUT_DSI3;
+	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
+		value = RDMA1_SOUT_DSI1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DPI0;
@@ -198,6 +204,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
 		value = DPI1_SEL_IN_RDMA1;
+	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
+		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
+		value = DSI1_SEL_IN_RDMA1;
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
-- 
2.12.5

