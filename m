Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MnOjIDTsHVuAJgAAmS7hNA
	; Mon, 11 Jun 2018 03:27:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7851760792; Mon, 11 Jun 2018 03:27:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 06234606DD;
	Mon, 11 Jun 2018 03:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06234606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeFKD1U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:27:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12577 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753970AbeFKD1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:27:18 -0400
X-UUID: 23e52402d38840a68ff9e856883666df-20180611
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 900419655; Mon, 11 Jun 2018 11:27:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 11 Jun 2018 11:27:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 11 Jun 2018 11:27:08 +0800
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
Subject: [PATCH 23/28] drm/mediatek: add DPI1 support for mutex
Date: Mon, 11 Jun 2018 11:26:15 +0800
Message-ID: <1528687580-549-24-git-send-email-stu.hsieh@mediatek.com>
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

This patch add the DPI1 support for mutex

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 5a8569fa6505..5916fc11693a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -76,6 +76,7 @@
 #define MUTEX_SOF_DSI0			1
 #define MUTEX_SOF_DSI1			2
 #define MUTEX_SOF_DPI0			3
+#define MUTEX_SOF_DPI1			4
 
 #define OVL0_MOUT_EN_COLOR0		0x1
 #define OD_MOUT_EN_RDMA0		0x1
@@ -385,6 +386,9 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DPI0:
 		reg = MUTEX_SOF_DPI0;
 		break;
+	case DDP_COMPONENT_DPI1:
+		reg = MUTEX_SOF_DPI1;
+		break;
 	default:
 		if (ddp->mutex_mod[id] < 32) {
 			offset = DISP_REG_MUTEX_MOD(mutex->id);
@@ -417,6 +421,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DSI0:
 	case DDP_COMPONENT_DSI1:
 	case DDP_COMPONENT_DPI0:
+	case DDP_COMPONENT_DPI1:
 		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
 			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
 		break;
-- 
2.12.5
