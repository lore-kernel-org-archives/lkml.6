Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeDXNmA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:42:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51146 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933763AbeDXNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:59 -0400
X-Google-Smtp-Source: AIpwx49KwAVxX8u3JGP4ynbYWl9miqyqHZlPBL+16HR6J7kE9eoWUsNRggijHThQvCK7MHXT608oKQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>, netdev@vger.kernel.org
Subject: [PATCH] net: mvpp2: fix mvpp2_tx()'s return type
Date: Tue, 24 Apr 2018 15:16:53 +0200
Message-Id: <20180424131656.4054-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 54a038943..355910345 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6926,7 +6926,7 @@ static int mvpp2_tx_tso(struct sk_buff *skb, struct net_device *dev,
 }
 
 /* Main tx processing */
-static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2_tx_queue *txq, *aggr_txq;
-- 
2.17.0
