Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31CDC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85720C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E85720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeKTTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:09:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32839 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbeKTTJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:09:34 -0500
X-UUID: a54d9fbaedaf493ea6a6b8681cbaa759-20181120
X-UUID: a54d9fbaedaf493ea6a6b8681cbaa759-20181120
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1084760431; Tue, 20 Nov 2018 16:41:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 16:41:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 16:41:19 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <ryder.lee@mediatek.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 2/2] spi: mediatek: add spi support for mt7629 IC
Date:   Tue, 20 Nov 2018 16:41:08 +0800
Message-ID: <1542703268-17285-3-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 68E0F87AC409F1EA6BA353B54B3689FD60755CC7D820C4B4603075DDA6B0E4C02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch add support for mt7629 IC.

Change-Id: Icb8ced408ebd1340fb0340592b91f24740d07e1e
Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9ee1fe9..0cce6f0 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -150,6 +150,9 @@ struct mtk_spi {
 	{ .compatible = "mediatek,mt7622-spi",
 		.data = (void *)&mt7622_compat,
 	},
+	{ .compatible = "mediatek,mt7629-spi",
+		.data = (void *)&mt7622_compat,
+	},
 	{ .compatible = "mediatek,mt8135-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
1.7.9.5

