Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EAC208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EAC208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeFTI34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:29:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64736 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754480AbeFTI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:48 -0400
X-UUID: e0f66d07bfe643909e59f08b248b3814-20180620
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1360931560; Wed, 20 Jun 2018 16:19:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 20 Jun 2018 16:19:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 20 Jun 2018 16:19:43 +0800
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
Subject: [PATCH v7 13/29] drm/mediatek: add connection from RDMA0 to DPI0
Date:   Wed, 20 Jun 2018 16:19:15 +0800
Message-ID: <1529482771-2153-14-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the connection from RDMA0 to DPI0

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 977df8facb79..3a3f37f523f2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -29,6 +29,7 @@
 #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
 #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
 #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
+#define DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN	0x0c4
 #define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
@@ -80,6 +81,7 @@
 #define COLOR0_SEL_IN_OVL0		0x1
 #define OVL1_MOUT_EN_COLOR1		0x1
 #define GAMMA_MOUT_EN_RDMA1		0x1
+#define RDMA0_SOUT_DPI0			0x2
 #define RDMA1_SOUT_DPI0			0x2
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
@@ -155,6 +157,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD1_MOUT_EN_RDMA1;
+	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
+		value = RDMA0_SOUT_DPI0;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DPI0;
-- 
2.12.5

