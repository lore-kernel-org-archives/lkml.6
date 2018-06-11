Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4Fx5HjbsHVv7JQAAmS7hNA
	; Mon, 11 Jun 2018 03:28:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C8A35607E7; Mon, 11 Jun 2018 03:28:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 584AE606DD;
	Mon, 11 Jun 2018 03:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 584AE606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeFKD2r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:28:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31939 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932484AbeFKD1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:27:16 -0400
X-UUID: 10d2199b28a448c7a19a21efe09eb93b-20180611
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 388682100; Mon, 11 Jun 2018 11:27:12 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 11 Jun 2018 11:27:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 11 Jun 2018 11:27:11 +0800
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
Subject: [PATCH 26/28] drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init
Date: Mon, 11 Jun 2018 11:26:18 +0800
Message-ID: <1528687580-549-27-git-send-email-stu.hsieh@mediatek.com>
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

This patch add components DPI1/DSI1/DSI2/DSI3 in comp_init.
Because the some parameter for these components initialized
in their driver.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 22f4c72fa785..ff974d82a4a6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -278,7 +278,11 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	if (comp_id == DDP_COMPONENT_BLS ||
 	    comp_id == DDP_COMPONENT_DPI0 ||
+	    comp_id == DDP_COMPONENT_DPI1 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
+	    comp_id == DDP_COMPONENT_DSI1 ||
+	    comp_id == DDP_COMPONENT_DSI2 ||
+	    comp_id == DDP_COMPONENT_DSI3 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
 		comp->regs = NULL;
 		comp->clk = NULL;
-- 
2.12.5
