Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37A420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37A420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965952AbeFSHk3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:40:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S937345AbeFSHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:34:56 -0400
X-UUID: e94c4803f8be4cf4a76965aaa30a7879-20180619
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1962385877; Tue, 19 Jun 2018 15:34:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 15:34:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 15:34:49 +0800
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
Subject: [PATCH v6 04/29] drm/mediatek: add ddp component OD1
Date:   Tue, 19 Jun 2018 15:34:05 +0800
Message-ID: <1529393670-26862-5-git-send-email-stu.hsieh@mediatek.com>
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

This patch add the component OD1 and
rename the OD to OD0

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 3 ++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 7217665f4b5d..58e44349e315 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -114,7 +114,7 @@ static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
 	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
 	[DDP_COMPONENT_GAMMA] = MT8173_MUTEX_MOD_DISP_GAMMA,
-	[DDP_COMPONENT_OD] = MT8173_MUTEX_MOD_DISP_OD,
+	[DDP_COMPONENT_OD0] = MT8173_MUTEX_MOD_DISP_OD,
 	[DDP_COMPONENT_OVL0] = MT8173_MUTEX_MOD_DISP_OVL0,
 	[DDP_COMPONENT_OVL1] = MT8173_MUTEX_MOD_DISP_OVL1,
 	[DDP_COMPONENT_PWM0] = MT8173_MUTEX_MOD_DISP_PWM0,
@@ -139,7 +139,7 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
 		value = OVL_MOUT_EN_RDMA;
-	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
+	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD_MOUT_EN_RDMA0;
 	} else if (cur == DDP_COMPONENT_UFOE && next == DDP_COMPONENT_DSI0) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 0919039805aa..87acf6be87f6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -227,7 +227,8 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
 	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
 	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
-	[DDP_COMPONENT_OD]	= { MTK_DISP_OD,	0, &ddp_od },
+	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
+	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
 	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
 	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index eee3c0cc2632..9b19fc4423f1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -50,7 +50,8 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_DSI0,
 	DDP_COMPONENT_DSI1,
 	DDP_COMPONENT_GAMMA,
-	DDP_COMPONENT_OD,
+	DDP_COMPONENT_OD0,
+	DDP_COMPONENT_OD1,
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_PWM0,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a415260f3d5f..08d5d0b47bfe 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -150,7 +150,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL0,
-	DDP_COMPONENT_OD,
+	DDP_COMPONENT_OD0,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_UFOE,
 	DDP_COMPONENT_DSI0,
-- 
2.12.5

