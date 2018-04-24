Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934494AbeDXNnt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:43:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56265 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933710AbeDXNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:38 -0400
X-Google-Smtp-Source: AIpwx4+/taPkKrXy4d6elPpQU3dXqVbsgWvdPSXxZ4zTzpbm+uh/ZNd/zN2+mdVkmvWfPQxh2gTBwQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>, netdev@vger.kernel.org
Subject: [PATCH] net: macb: fix macb_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:34 +0200
Message-Id: <20180424131635.3658-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b4c926810..daadda57a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1657,7 +1657,7 @@ static inline int macb_clear_csum(struct sk_buff *skb)
 	return 0;
 }
 
-static int macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	u16 queue_index = skb_get_queue_mapping(skb);
 	struct macb *bp = netdev_priv(dev);
@@ -3553,7 +3553,7 @@ static int at91ether_close(struct net_device *dev)
 }
 
 /* Transmit packet */
-static int at91ether_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct macb *lp = netdev_priv(dev);
 
-- 
2.17.0
