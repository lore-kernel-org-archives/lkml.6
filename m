Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeDXNlY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:41:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35916 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeDXNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:03 -0400
X-Google-Smtp-Source: AIpwx4/N3KnW5lZITySZeMUzTjTaV3hJqZ2BdZKLPnLkeX8VqTFVShYqm/OjdozU3w71L6glgtI1Yg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Allen Pais <allen.lkml@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH] net: pxa168: fix pxa168_eth_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:58 +0200
Message-Id: <20180424131700.4104-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/marvell/pxa168_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 3a9730612..d8745b503 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1260,7 +1260,7 @@ static int pxa168_rx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static int pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pxa168_eth_private *pep = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
-- 
2.17.0
