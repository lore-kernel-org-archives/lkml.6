Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934351AbeDXNb3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:31:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55548 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeDXNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:45 -0400
X-Google-Smtp-Source: AIpwx4/SNycov1gzj+GOZLn29PmwZ4JBLGKqk/mDx13DoK3VpV3wGcLjMZyDHyB1cdT92cIiCt1Ecg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        netdev@vger.kernel.org
Subject: [PATCH] net: w5300: fix w5300_start_tx()'s return type
Date: Tue, 24 Apr 2018 15:17:40 +0200
Message-Id: <20180424131742.4611-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/wiznet/w5300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index 56ae57300..80fdbff67 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -365,7 +365,7 @@ static void w5300_tx_timeout(struct net_device *ndev)
 	netif_wake_queue(ndev);
 }
 
-static int w5300_start_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t w5300_start_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct w5300_priv *priv = netdev_priv(ndev);
 
-- 
2.17.0
