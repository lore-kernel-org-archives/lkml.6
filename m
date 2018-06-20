Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72319C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359B820836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359B820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbeFTJbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:31:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61670 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754506AbeFTI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:52 -0400
X-UUID: 9a756c98e1454861af66730f29bd42b9-20180620
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2061432871; Wed, 20 Jun 2018 16:19:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 20 Jun 2018 16:19:43 +0800
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
Subject: [PATCH v7 12/29] drm/mediatek: Update the definition of connection from RDMA1 to DPI0
Date:   Wed, 20 Jun 2018 16:19:14 +0800
Message-ID: <1529482771-2153-13-git-send-email-stu.hsieh@mediatek.com>
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

This patch update the definition of connection from RDMA1 to DPI0.
Change the term MOUT to SOUT.

Because our HW datasheet use the term SOUT to match its function for RDMA.
For consistency, changing the name from MOUT to SOUT is better.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8bfc0debd2c2..977df8facb79 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -29,7 +29,7 @@
 #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
 #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
 #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
-#define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
+#define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
 #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
@@ -80,7 +80,7 @@
 #define COLOR0_SEL_IN_OVL0		0x1
 #define OVL1_MOUT_EN_COLOR1		0x1
 #define GAMMA_MOUT_EN_RDMA1		0x1
-#define RDMA1_MOUT_DPI0			0x2
+#define RDMA1_SOUT_DPI0			0x2
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
 
@@ -156,8 +156,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD1_MOUT_EN_RDMA1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
-		value = RDMA1_MOUT_DPI0;
+		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
+		value = RDMA1_SOUT_DPI0;
 	} else {
 		value = 0;
 	}
-- 
2.12.5

