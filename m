Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeCEHDn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:03:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53030 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933055AbeCEHDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:03:37 -0500
X-UUID: a9089132f93147bc81af95f6f409196d-20180305
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ulf.hansson@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: add support for MT7622 SoC
Date: Mon, 5 Mar 2018 15:03:20 +0800
Message-ID: <83a3ee9471cc7312b9cc43bcf692939e90af34ba.1520232933.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6cb1d6d4ee40a61f7b33aed1711753342590d0dd.1520232933.git.sean.wang@mediatek.com>
References: <6cb1d6d4ee40a61f7b33aed1711753342590d0dd.1520232933.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Just applying the existing logic and adding its own characteristics into
the space pointed by an extra entry of struct of_device_id to have support
of MT7622 SoC.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Jumin Li <jumin.li@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6457a7d..cb274e8 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -438,11 +438,23 @@ static const struct mtk_mmc_compatible mt2712_compat = {
 	.enhance_rx = true,
 };
 
+static const struct mtk_mmc_compatible mt7622_compat = {
+	.clk_div_bits = 12,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
+	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);
-- 
2.7.4
