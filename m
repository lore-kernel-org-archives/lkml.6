Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeBGKX0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:23:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:20976 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753675AbeBGKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:22:59 -0500
X-UUID: 4d6d380a69b24900b75664282e1dd341-20180207
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>,
        <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 3/4] soc: mediatek: avoid hardcoded value with bus_prot_mask
Date: Wed, 7 Feb 2018 18:22:49 +0800
Message-ID: <c101f416099f14521c4440058858007f5ff0a6c4.1517998367.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

use a meaningful definition for bus_prot_mask instead of just hardcoded
for it.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c     | 5 +++--
 include/linux/soc/mediatek/infracfg.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 435ce5e..5346f33 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -518,7 +518,8 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
-		.bus_prot_mask = 0x0104,
+		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
+				 MT2701_TOP_AXI_PROT_EN_CONN_S,
 		.clk_id = {CLK_NONE},
 		.active_wakeup = true,
 	},
@@ -528,7 +529,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.clk_id = {CLK_MM},
-		.bus_prot_mask = 0x0002,
+		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
 		.active_wakeup = true,
 	},
 	[MT2701_POWER_DOMAIN_MFG] = {
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index b0a507d..fd25f01 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -21,6 +21,10 @@
 #define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
 #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
 
+#define MT2701_TOP_AXI_PROT_EN_MM_M0		BIT(1)
+#define MT2701_TOP_AXI_PROT_EN_CONN_M		BIT(2)
+#define MT2701_TOP_AXI_PROT_EN_CONN_S		BIT(8)
+
 #define MT7622_TOP_AXI_PROT_EN_ETHSYS		(BIT(3) | BIT(17))
 #define MT7622_TOP_AXI_PROT_EN_HIF0		(BIT(24) | BIT(25))
 #define MT7622_TOP_AXI_PROT_EN_HIF1		(BIT(26) | BIT(27) | \
-- 
2.7.4
