Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeERMfS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:35:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44629 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbeERMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:35:13 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH] net: mvpp2: typo and cosmetic fixes
Date: Fri, 18 May 2018 14:34:51 +0200
Message-Id: <20180518123451.31365-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch on the Marvell PPv2 driver is only cosmetic. Two typos are
removed as well as other cosmetic fixes, such as extra new lines or tabs
vs spaces.

Suggested-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index f8ed983bc767..7f54bb0334f1 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -1757,7 +1757,6 @@ static void mvpp2_prs_tcam_ai_update(struct mvpp2_prs_entry *pe,
 	int i, ai_idx = MVPP2_PRS_TCAM_AI_BYTE;
 
 	for (i = 0; i < MVPP2_PRS_AI_BITS; i++) {
-
 		if (!(enable & BIT(i)))
 			continue;
 
@@ -1841,7 +1840,6 @@ static void mvpp2_prs_sram_ai_update(struct mvpp2_prs_entry *pe,
 	int ai_off = MVPP2_PRS_SRAM_AI_OFFS;
 
 	for (i = 0; i < MVPP2_PRS_SRAM_AI_CTRL_BITS; i++) {
-
 		if (!(mask & BIT(i)))
 			continue;
 
@@ -4937,7 +4935,7 @@ static void mvpp22_gop_mask_irq(struct mvpp2_port *port)
 	if (port->gop_id == 0) {
 		val = readl(port->base + MVPP22_XLG_EXT_INT_MASK);
 		val &= ~(MVPP22_XLG_EXT_INT_MASK_XLG |
-		         MVPP22_XLG_EXT_INT_MASK_GIG);
+			 MVPP22_XLG_EXT_INT_MASK_GIG);
 		writel(val, port->base + MVPP22_XLG_EXT_INT_MASK);
 	}
 
@@ -5471,7 +5469,6 @@ static void mvpp2_aggr_txq_pend_desc_add(struct mvpp2_port *port, int pending)
 			   MVPP2_AGGR_TXQ_UPDATE_REG, pending);
 }
 
-
 /* Check if there are enough free descriptors in aggregated txq.
  * If not, update the number of occupied descriptors and repeat the check.
  *
@@ -5551,7 +5548,7 @@ static int mvpp2_txq_reserved_desc_num_proc(struct mvpp2 *priv,
 
 	txq_pcpu->reserved_num += mvpp2_txq_alloc_reserved_desc(priv, txq, req);
 
-	/* OK, the descriptor cound has been updated: check again. */
+	/* OK, the descriptor could have been updated: check again. */
 	if (txq_pcpu->reserved_num < num)
 		return -ENOMEM;
 	return 0;
@@ -6033,7 +6030,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 	/* Calculate base address in prefetch buffer. We reserve 16 descriptors
 	 * for each existing TXQ.
 	 * TCONTS for PON port must be continuous from 0 to MVPP2_MAX_TCONT
-	 * GBE ports assumed to be continious from 0 to MVPP2_MAX_PORTS
+	 * GBE ports assumed to be continuous from 0 to MVPP2_MAX_PORTS
 	 */
 	desc_per_txq = 16;
 	desc = (port->id * MVPP2_MAX_TXQ * desc_per_txq) +
@@ -6603,8 +6600,7 @@ static int mvpp2_tx_frag_process(struct mvpp2_port *port, struct sk_buff *skb,
 		mvpp2_txdesc_size_set(port, tx_desc, frag->size);
 
 		buf_dma_addr = dma_map_single(port->dev->dev.parent, addr,
-					       frag->size,
-					       DMA_TO_DEVICE);
+					      frag->size, DMA_TO_DEVICE);
 		if (dma_mapping_error(port->dev->dev.parent, buf_dma_addr)) {
 			mvpp2_txq_desc_put(txq);
 			goto cleanup;
-- 
2.17.0
