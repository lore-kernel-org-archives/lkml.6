Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeEPLBy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:01:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33986 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752081AbeEPLBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:01:52 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <peppe.cavallaro@st.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexandre.torgue@st.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: stmmac: Remove useless test before clk_disable_unprepare
Date: Wed, 16 May 2018 18:59:19 +0800
Message-ID: <20180516105919.25436-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() already checks that the clock pointer is valid.
No need to test it before calling it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 13133b3..f08625a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1104,30 +1104,20 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	} else {
 		if (bsp_priv->clk_enabled) {
 			if (phy_iface == PHY_INTERFACE_MODE_RMII) {
-				if (!IS_ERR(bsp_priv->mac_clk_rx))
-					clk_disable_unprepare(
-						bsp_priv->mac_clk_rx);
+				clk_disable_unprepare(bsp_priv->mac_clk_rx);
 
-				if (!IS_ERR(bsp_priv->clk_mac_ref))
-					clk_disable_unprepare(
-						bsp_priv->clk_mac_ref);
+				clk_disable_unprepare(bsp_priv->clk_mac_ref);
 
-				if (!IS_ERR(bsp_priv->clk_mac_refout))
-					clk_disable_unprepare(
-						bsp_priv->clk_mac_refout);
+				clk_disable_unprepare(bsp_priv->clk_mac_refout);
 			}
 
-			if (!IS_ERR(bsp_priv->clk_phy))
-				clk_disable_unprepare(bsp_priv->clk_phy);
+			clk_disable_unprepare(bsp_priv->clk_phy);
 
-			if (!IS_ERR(bsp_priv->aclk_mac))
-				clk_disable_unprepare(bsp_priv->aclk_mac);
+			clk_disable_unprepare(bsp_priv->aclk_mac);
 
-			if (!IS_ERR(bsp_priv->pclk_mac))
-				clk_disable_unprepare(bsp_priv->pclk_mac);
+			clk_disable_unprepare(bsp_priv->pclk_mac);
 
-			if (!IS_ERR(bsp_priv->mac_clk_tx))
-				clk_disable_unprepare(bsp_priv->mac_clk_tx);
+			clk_disable_unprepare(bsp_priv->mac_clk_tx);
 			/**
 			 * if (!IS_ERR(bsp_priv->clk_mac))
 			 *	clk_disable_unprepare(bsp_priv->clk_mac);
-- 
2.7.0
