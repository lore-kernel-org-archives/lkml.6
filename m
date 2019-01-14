Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6933320873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfANPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:37:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfANPhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:37:04 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gj4IP-0002nG-EL; Mon, 14 Jan 2019 15:37:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: net: atp: fix various indentation issues
Date:   Mon, 14 Jan 2019 15:37:01 +0000
Message-Id: <20190114153701.18203-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are various lines that have indentation issues, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/realtek/atp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/atp.c b/drivers/net/ethernet/realtek/atp.c
index 7e011c1c1e6e..cfb67b746595 100644
--- a/drivers/net/ethernet/realtek/atp.c
+++ b/drivers/net/ethernet/realtek/atp.c
@@ -454,14 +454,14 @@ static void hardware_init(struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-    int i;
+	int i;
 
 	/* Turn off the printer multiplexer on the 8012. */
 	for (i = 0; i < 8; i++)
 		outb(mux_8012[i], ioaddr + PAR_DATA);
 	write_reg_high(ioaddr, CMR1, CMR1h_RESET);
 
-    for (i = 0; i < 6; i++)
+	for (i = 0; i < 6; i++)
 		write_reg_byte(ioaddr, PAR0 + i, dev->dev_addr[i]);
 
 	write_reg_high(ioaddr, CMR2, lp->addr_mode);
@@ -471,15 +471,15 @@ static void hardware_init(struct net_device *dev)
 			   (read_nibble(ioaddr, CMR2_h) >> 3) & 0x0f);
 	}
 
-    write_reg(ioaddr, CMR2, CMR2_IRQOUT);
-    write_reg_high(ioaddr, CMR1, CMR1h_RxENABLE | CMR1h_TxENABLE);
+	write_reg(ioaddr, CMR2, CMR2_IRQOUT);
+	write_reg_high(ioaddr, CMR1, CMR1h_RxENABLE | CMR1h_TxENABLE);
 
 	/* Enable the interrupt line from the serial port. */
 	outb(Ctrl_SelData + Ctrl_IRQEN, ioaddr + PAR_CONTROL);
 
 	/* Unmask the interesting interrupts. */
-    write_reg(ioaddr, IMR, ISR_RxOK | ISR_TxErr | ISR_TxOK);
-    write_reg_high(ioaddr, IMR, ISRh_RxErr);
+	write_reg(ioaddr, IMR, ISR_RxOK | ISR_TxErr | ISR_TxOK);
+	write_reg_high(ioaddr, IMR, ISRh_RxErr);
 
 	lp->tx_unit_busy = 0;
     lp->pac_cnt_in_tx_buf = 0;
@@ -610,10 +610,12 @@ static irqreturn_t atp_interrupt(int irq, void *dev_instance)
 	write_reg(ioaddr, CMR2, CMR2_NULL);
 	write_reg(ioaddr, IMR, 0);
 
-	if (net_debug > 5) printk(KERN_DEBUG "%s: In interrupt ", dev->name);
-    while (--boguscount > 0) {
+	if (net_debug > 5)
+		printk(KERN_DEBUG "%s: In interrupt ", dev->name);
+	while (--boguscount > 0) {
 		int status = read_nibble(ioaddr, ISR);
-		if (net_debug > 5) printk("loop status %02x..", status);
+		if (net_debug > 5)
+			printk("loop status %02x..", status);
 
 		if (status & (ISR_RxOK<<3)) {
 			handled = 1;
@@ -640,7 +642,8 @@ static irqreturn_t atp_interrupt(int irq, void *dev_instance)
 			} while (--boguscount > 0);
 		} else if (status & ((ISR_TxErr + ISR_TxOK)<<3)) {
 			handled = 1;
-			if (net_debug > 6)  printk("handling Tx done..");
+			if (net_debug > 6)
+				printk("handling Tx done..");
 			/* Clear the Tx interrupt.  We should check for too many failures
 			   and reinitialize the adapter. */
 			write_reg(ioaddr, ISR, ISR_TxErr + ISR_TxOK);
@@ -680,7 +683,7 @@ static irqreturn_t atp_interrupt(int irq, void *dev_instance)
 			break;
 		} else
 			break;
-    }
+	}
 
 	/* This following code fixes a rare (and very difficult to track down)
 	   problem where the adapter forgets its ethernet address. */
@@ -694,7 +697,7 @@ static irqreturn_t atp_interrupt(int irq, void *dev_instance)
 	}
 
 	/* Tell the adapter that it can go back to using the output line as IRQ. */
-    write_reg(ioaddr, CMR2, CMR2_IRQOUT);
+	write_reg(ioaddr, CMR2, CMR2_IRQOUT);
 	/* Enable the physical interrupt line, which is sure to be low until.. */
 	outb(Ctrl_SelData + Ctrl_IRQEN, ioaddr + PAR_CONTROL);
 	/* .. we enable the interrupt sources. */
-- 
2.19.1

