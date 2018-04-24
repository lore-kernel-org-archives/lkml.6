Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934408AbeDXNoM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:44:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51013 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933683AbeDXNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:36 -0400
X-Google-Smtp-Source: AB8JxZrRpFlg8rvb7Q2flhPjWxoS/3BL9tEzmFcO8oREA4GFgcdmRQzkxqnDpYl5xgmvnUe6ixabDw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: [PATCH] net: nb8800: fix nb8800_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:30 +0200
Message-Id: <20180424131632.3607-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/aurora/nb8800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index e94159507..e4331168f 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -396,7 +396,7 @@ static void nb8800_tx_dma_start_irq(struct net_device *dev)
 	spin_unlock(&priv->tx_lock);
 }
 
-static int nb8800_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t nb8800_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct nb8800_priv *priv = netdev_priv(dev);
 	struct nb8800_tx_desc *txd;
-- 
2.17.0
