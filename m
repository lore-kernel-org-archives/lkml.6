Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913B2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473CC2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473CC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeKAPE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:04:26 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8784 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727573AbeKAPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:04:25 -0400
X-UUID: db122461963b44099a6c29d044e28b65-20181101
X-UUID: db122461963b44099a6c29d044e28b65-20181101
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1894429694; Thu, 01 Nov 2018 14:02:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 1 Nov 2018 14:02:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 1 Nov 2018 14:02:48 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 2/2] spi: mediatek: add spi support for mt8183 IC
Date:   Thu, 1 Nov 2018 14:02:19 +0800
Message-ID: <1541052139-8845-3-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
References: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch add support for mt8183 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0c2867d..9ee1fe9 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -120,6 +120,12 @@ struct mtk_spi {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible mt8183_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -150,6 +156,9 @@ struct mtk_spi {
 	{ .compatible = "mediatek,mt8173-spi",
 		.data = (void *)&mt8173_compat,
 	},
+	{ .compatible = "mediatek,mt8183-spi",
+		.data = (void *)&mt8183_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
-- 
1.7.9.5

