Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeBSRLs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:48 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38874 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeBSRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:45 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/7] net: stmmac: rename dwmac4_tx_queue_routing() to match reality
Date: Mon, 19 Feb 2018 18:11:12 +0100
Message-Id: <20180219171116.15326-5-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at dwmac4_tx_queue_routing(), it is obvious that it
sets up rx queue routing.

Rename dwmac4_tx_queue_routing() to dwmac4_rx_queue_routing()
to better match reality.

Fixes: abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 63795ecafc8d..46b9ae20ff6c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -120,7 +120,7 @@ static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
 	writel(value, ioaddr + base_register);
 }
 
-static void dwmac4_tx_queue_routing(struct mac_device_info *hw,
+static void dwmac4_rx_queue_routing(struct mac_device_info *hw,
 				    u8 packet, u32 queue)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -713,7 +713,7 @@ static const struct stmmac_ops dwmac4_ops = {
 	.rx_queue_enable = dwmac4_rx_queue_enable,
 	.rx_queue_prio = dwmac4_rx_queue_priority,
 	.tx_queue_prio = dwmac4_tx_queue_priority,
-	.rx_queue_routing = dwmac4_tx_queue_routing,
+	.rx_queue_routing = dwmac4_rx_queue_routing,
 	.prog_mtl_rx_algorithms = dwmac4_prog_mtl_rx_algorithms,
 	.prog_mtl_tx_algorithms = dwmac4_prog_mtl_tx_algorithms,
 	.set_mtl_tx_queue_weight = dwmac4_set_mtl_tx_queue_weight,
@@ -744,7 +744,7 @@ static const struct stmmac_ops dwmac410_ops = {
 	.rx_queue_enable = dwmac4_rx_queue_enable,
 	.rx_queue_prio = dwmac4_rx_queue_priority,
 	.tx_queue_prio = dwmac4_tx_queue_priority,
-	.rx_queue_routing = dwmac4_tx_queue_routing,
+	.rx_queue_routing = dwmac4_rx_queue_routing,
 	.prog_mtl_rx_algorithms = dwmac4_prog_mtl_rx_algorithms,
 	.prog_mtl_tx_algorithms = dwmac4_prog_mtl_tx_algorithms,
 	.set_mtl_tx_queue_weight = dwmac4_set_mtl_tx_queue_weight,
-- 
2.14.2
