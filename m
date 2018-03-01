Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163131AbeCAX3f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:29:35 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52460 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162965AbeCAX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:29:29 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <78dbc6973833cd7fd25108882153e4b2df72763f.1519813462.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519813462.git.fthain@telegraphics.com.au>
References: <cover.1519813462.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 1/4] net/mac89x0: Remove redundant code
Date: Thu,  1 Mar 2018 18:29:28 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/cirrus/mac89x0.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 977d4c2c759d..4fe0ae93ab36 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -115,14 +115,9 @@ struct net_local {
 	int rx_mode;
 	int curr_rx_cfg;
         int send_underrun;      /* keep track of how many underruns in a row we get */
-	struct sk_buff *skb;
 };
 
 /* Index to functions, as function prototypes. */
-
-#if 0
-extern void reset_chip(struct net_device *dev);
-#endif
 static int net_open(struct net_device *dev);
 static int net_send_packet(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t net_interrupt(int irq, void *dev_id);
@@ -132,10 +127,6 @@ static int net_close(struct net_device *dev);
 static struct net_device_stats *net_get_stats(struct net_device *dev);
 static int set_mac_address(struct net_device *dev, void *addr);
 
-
-/* Example routines you must write ;->. */
-#define tx_done(dev) 1
-
 /* For reading/writing registers ISA-style */
 static inline int
 readreg_io(struct net_device *dev, int portno)
@@ -297,24 +288,6 @@ struct net_device * __init mac89x0_probe(int unit)
 	return ERR_PTR(err);
 }
 
-#if 0
-/* This is useful for something, but I don't know what yet. */
-void __init reset_chip(struct net_device *dev)
-{
-	int reset_start_time;
-
-	writereg(dev, PP_SelfCTL, readreg(dev, PP_SelfCTL) | POWER_ON_RESET);
-
-	/* wait 30 ms */
-	msleep_interruptible(30);
-
-	/* Wait until the chip is reset */
-	reset_start_time = jiffies;
-	while( (readreg(dev, PP_SelfST) & INIT_DONE) == 0 && jiffies - reset_start_time < 2)
-		;
-}
-#endif
-
 /* Open/initialize the board.  This is called (in the current kernel)
    sometime after booting when the 'ifconfig' program is run.
 
@@ -416,11 +389,6 @@ static irqreturn_t net_interrupt(int irq, void *dev_id)
 	struct net_local *lp;
 	int ioaddr, status;
 
-	if (dev == NULL) {
-		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
-		return IRQ_NONE;
-	}
-
 	ioaddr = dev->base_addr;
 	lp = netdev_priv(dev);
 
-- 
2.16.1
