Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933820AbeDXNRH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39607 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeDXNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:54 -0400
X-Google-Smtp-Source: AB8JxZoNB8UBvwjGxt62/bFUgphrIyDWcPI3p7/YXpqewF8se8dZ45r86dHkVXZxJvuoFqrkelJZNg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        netdev@vger.kernel.org
Subject: [PATCH] net: mvneta: fix mvneta_tx()'s return type
Date: Tue, 24 Apr 2018 15:16:51 +0200
Message-Id: <20180424131651.4004-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 17a904cc6..436219e1a 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2322,7 +2322,7 @@ static int mvneta_tx_frag_process(struct mvneta_port *pp, struct sk_buff *skb,
 }
 
 /* Main tx processing */
-static int mvneta_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mvneta_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
 	u16 txq_id = skb_get_queue_mapping(skb);
-- 
2.17.0
