Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE01FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EC72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EC72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965649AbeFSHfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:35:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965361AbeFSHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:35:00 -0400
X-UUID: 7ca6e5a932f543ec85aed34fa1430df1-20180619
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 591359162; Tue, 19 Jun 2018 15:34:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 15:34:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 15:34:52 +0800
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
Subject: [PATCH v6 09/29] drm/mediatek: add component DSI3
Date:   Tue, 19 Jun 2018 15:34:10 +0800
Message-ID: <1529393670-26862-10-git-send-email-stu.hsieh@mediatek.com>
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

This patch add the component DSI3

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 071f9f5aefea..17b681686471 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -228,6 +228,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
 	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
 	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
+	[DDP_COMPONENT_DSI3]	= { MTK_DSI,		3, NULL },
 	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
 	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
 	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
@@ -280,6 +281,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	    comp_id == DDP_COMPONENT_DPI1 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
 	    comp_id == DDP_COMPONENT_DSI2 ||
+	    comp_id == DDP_COMPONENT_DSI3 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
 		comp->regs = NULL;
 		comp->clk = NULL;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 8d152b337f15..7413ffeb3c9d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -51,6 +51,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_DSI0,
 	DDP_COMPONENT_DSI1,
 	DDP_COMPONENT_DSI2,
+	DDP_COMPONENT_DSI3,
 	DDP_COMPONENT_GAMMA,
 	DDP_COMPONENT_OD0,
 	DDP_COMPONENT_OD1,
-- 
2.12.5

