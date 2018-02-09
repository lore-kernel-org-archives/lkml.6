Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeBIQXn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:23:43 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49959 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeBIQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:23:06 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: stmmac: rename GMAC_INT_DEFAULT_MASK for dwmac4
Date: Fri,  9 Feb 2018 17:22:46 +0100
Message-Id: <20180209162247.3724-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180209162247.3724-1-niklas.cassel@axis.com>
References: <20180209162247.3724-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GMAC_INT_DEFAULT_MASK is written to the interrupt enable register.
In previous versions of the IP (e.g. dwmac1000), this register was
instead an interrupt mask register.
To improve clarity and reflect reality, rename GMAC_INT_DEFAULT_MASK
to GMAC_INT_DEFAULT_ENABLE.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 789dad8a07b5..7761a26ec9c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -98,7 +98,7 @@
 #define	GMAC_PCS_IRQ_DEFAULT	(GMAC_INT_RGSMIIS | GMAC_INT_PCS_LINK |	\
 				 GMAC_INT_PCS_ANE)
 
-#define	GMAC_INT_DEFAULT_MASK	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN)
+#define	GMAC_INT_DEFAULT_ENABLE	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN)
 
 enum dwmac4_irq_status {
 	time_stamp_irq = 0x00001000,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 1e0a7668b752..6badc63d8e6d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -61,8 +61,8 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 	writel(value, ioaddr + GMAC_CONFIG);
 
-	/* Mask GMAC interrupts */
-	value = GMAC_INT_DEFAULT_MASK;
+	/* Enable GMAC interrupts */
+	value = GMAC_INT_DEFAULT_ENABLE;
 	if (hw->pmt)
 		value |= GMAC_INT_PMT_EN;
 	if (hw->pcs)
-- 
2.14.2
