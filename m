Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BCC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99821582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeKOQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:33:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48432 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbeKOQdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:33:15 -0500
X-UUID: 3d3b094ded6245f389e1f9536c75cbee-20181115
X-UUID: 3d3b094ded6245f389e1f9536c75cbee-20181115
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 924279693; Thu, 15 Nov 2018 14:26:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 15 Nov 2018 14:26:37 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 15 Nov 2018 14:26:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Guochun Mao <guochun.mao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/4] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ for capcity setting
Date:   Thu, 15 Nov 2018 14:26:25 +0800
Message-ID: <991d85ccb62ca8c68706a1b5df304bdd11a64bcd.1542262833.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
References: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B7E20A1046C92EEB04C5DA43630F305D98B6421D246BD0900D8A2EACD2CE1C7B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guochun Mao <guochun.mao@mediatek.com>

SNOR_HWCAPS_READ is a basic read mode for both flash and controller,
it should be supported, so add the capcity for mtk-quadspi.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
Tested-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index 2278677..c198fd2 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -433,7 +433,8 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
 			struct device_node *flash_node)
 {
 	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ_FAST |
+		.mask = SNOR_HWCAPS_READ |
+			SNOR_HWCAPS_READ_FAST |
 			SNOR_HWCAPS_READ_1_1_2 |
 			SNOR_HWCAPS_PP,
 	};
-- 
1.9.1

