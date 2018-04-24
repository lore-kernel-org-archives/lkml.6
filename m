Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934517AbeDXNo5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:44:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34691 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933613AbeDXNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:31 -0400
X-Google-Smtp-Source: AIpwx49tbtZDflTwFjsY3hddUVEGU678CFSv5GFvWudXQNFxYG5H3BtYrIkQmuXYapdAlHVyjQIUtA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Romain Perier <romain.perier@collabora.com>, netdev@vger.kernel.org
Subject: [PATCH] net: arc_emac: fix arc_emac_tx()'s return type
Date: Tue, 24 Apr 2018 15:16:25 +0200
Message-Id: <20180424131628.3556-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/arc/emac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/arc/emac_main.c b/drivers/net/ethernet/arc/emac_main.c
index bd277b0dc..87f395eea 100644
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -676,7 +676,7 @@ static struct net_device_stats *arc_emac_stats(struct net_device *ndev)
  *
  * This function is invoked from upper layers to initiate transmission.
  */
-static int arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
 	unsigned int len, *txbd_curr = &priv->txbd_curr;
-- 
2.17.0
