Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933701AbeDXNQc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:16:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54350 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933683AbeDXNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:26 -0400
X-Google-Smtp-Source: AIpwx4/slrUkHo7l5afTASVChzzjlCynn3S9YkpCYjYDdwj9ZB6hLm06X8cytg4x0hY1IXorH9nLHg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH] net: aquantia: fix aq_ndev_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:20 +0200
Message-Id: <20180424131623.3505-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/aquantia/atlantic/aq_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index ba5fe8c41..79b0a4d41 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -73,7 +73,7 @@ static int aq_ndev_close(struct net_device *ndev)
 	return err;
 }
 
-static int aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct aq_nic_s *aq_nic = netdev_priv(ndev);
 
-- 
2.17.0
