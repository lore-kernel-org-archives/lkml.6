Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TmE+AsjsHVvzMAAAmS7hNA
	; Mon, 11 Jun 2018 03:31:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8D82260791; Mon, 11 Jun 2018 03:31:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18354606DD;
	Mon, 11 Jun 2018 03:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18354606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeFKD05 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:26:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3273 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753966AbeFKD0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:26:53 -0400
X-UUID: 52e54f3c6a014fbc880091cf150398dd-20180611
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 652760436; Mon, 11 Jun 2018 11:26:49 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 11 Jun 2018 11:26:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 11 Jun 2018 11:26:47 +0800
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH 06/28] drm/mediatek: add ddp component PWM2
Date: Mon, 11 Jun 2018 11:25:58 +0800
Message-ID: <1528687580-549-7-git-send-email-stu.hsieh@mediatek.com>
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

This patch add component PWM2

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index a5c7ac2d162d..86e8c9e5df41 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -233,6 +233,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
 	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
 	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
+	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
 	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, NULL },
 	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, NULL },
 	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, NULL },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 9b19fc4423f1..e00c2e798abd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -56,6 +56,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_PWM0,
 	DDP_COMPONENT_PWM1,
+	DDP_COMPONENT_PWM2,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_RDMA2,
-- 
2.12.5
