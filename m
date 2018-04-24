Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758090AbeDXNZE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:25:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53834 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933911AbeDXNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:18:58 -0400
X-Google-Smtp-Source: AIpwx4+AB5GRpKqAOaOPV5aWxa34iv1SwKlUYeFixvpbItvonSE8BYDe7G2XmyvwGLGWg/UTrx+Meg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guillaume Nault <g.nault@alphalink.fr>,
        James Chapman <jchapman@katalix.com>,
        Dominik Heidler <dheidler@suse.de>, netdev@vger.kernel.org
Subject: [PATCH] l2tp: fix l2tp_eth_dev_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:53 +0200
Message-Id: <20180424131855.5618-1-luc.vanoostenryck@gmail.com>
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
 net/l2tp/l2tp_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 5c366ecfa..e027f8b54 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -77,7 +77,7 @@ static void l2tp_eth_dev_uninit(struct net_device *dev)
 	 */
 }
 
-static int l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct l2tp_eth *priv = netdev_priv(dev);
 	struct l2tp_session *session = priv->session;
-- 
2.17.0
