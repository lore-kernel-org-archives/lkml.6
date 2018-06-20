Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B1CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78664208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78664208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeFTIaA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:30:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52755 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754468AbeFTI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:48 -0400
X-UUID: f731c00423ed4851a60e210f1862f66b-20180620
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 33925274; Wed, 20 Jun 2018 16:19:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 20 Jun 2018 16:19:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 20 Jun 2018 16:19:42 +0800
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
Subject: [PATCH v7 08/29] drm/mediatek: add component DSI2
Date:   Wed, 20 Jun 2018 16:19:10 +0800
Message-ID: <1529482771-2153-9-git-send-email-stu.hsieh@mediatek.com>
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

This patch add the component DSI2

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index cc74b1a7278c..071f9f5aefea 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -227,6 +227,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
 	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
+	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
 	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
 	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
 	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
@@ -278,6 +279,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	    comp_id == DDP_COMPONENT_DPI0 ||
 	    comp_id == DDP_COMPONENT_DPI1 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
+	    comp_id == DDP_COMPONENT_DSI2 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
 		comp->regs = NULL;
 		comp->clk = NULL;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 54c99c169093..8d152b337f15 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -50,6 +50,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_DPI1,
 	DDP_COMPONENT_DSI0,
 	DDP_COMPONENT_DSI1,
+	DDP_COMPONENT_DSI2,
 	DDP_COMPONENT_GAMMA,
 	DDP_COMPONENT_OD0,
 	DDP_COMPONENT_OD1,
-- 
2.12.5

