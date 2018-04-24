Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934422AbeDXNks (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:40:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52182 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933576AbeDXNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:12 -0400
X-Google-Smtp-Source: AIpwx4/QDp1OqieTQFYvRAL+EiQSA6V1sz/F814D54IziDKEbEWImTv8NAGzE7sXWltsk8JoDHNM2Q==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <simon.horman@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        =?UTF-8?q?Pablo=20Casc=C3=B3n?= <pablo.cascon@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: [PATCH] net: nfp: fix nfp_net_tx()'s return type
Date: Tue, 24 Apr 2018 15:17:07 +0200
Message-Id: <20180424131710.4206-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 1eb6549f2..4e6aaf678 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -794,7 +794,7 @@ static int nfp_net_prep_port_id(struct sk_buff *skb)
  *
  * Return: NETDEV_TX_OK on success.
  */
-static int nfp_net_tx(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t nfp_net_tx(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	const struct skb_frag_struct *frag;
-- 
2.17.0
