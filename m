Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbeDXNRh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39987 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbeDXNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:24 -0400
X-Google-Smtp-Source: AIpwx4+7hWtcs7LHFz+XhvL90ARrN93Hk7qqcI9QSettbuYK8Ae9LRSkmKfW92oW47JjRn5VOJFfQA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] net: sh-eth: fix sh_eth_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:17:18 +0200
Message-Id: <20180424131720.4357-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/renesas/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index b6b90a631..0875a169f 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2454,7 +2454,7 @@ static void sh_eth_tx_timeout(struct net_device *ndev)
 }
 
 /* Packet transmit function */
-static int sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct sh_eth_txdesc *txdesc;
-- 
2.17.0
