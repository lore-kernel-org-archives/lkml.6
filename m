Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934399AbeDXNcf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:32:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33464 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbeDXNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:41 -0400
X-Google-Smtp-Source: AB8JxZpXlX5yUPQK2zvR4iTzjwHcwq5QqiK3x13C2erazr3PIiHiF4it756k69zRHyGzxk/AMe+HwQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        netdev@vger.kernel.org
Subject: [PATCH] net: w5100: fix w5100_start_tx()'s return type
Date: Tue, 24 Apr 2018 15:17:35 +0200
Message-Id: <20180424131738.4559-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/wiznet/w5100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 2bdfb3921..d8ba512f1 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -835,7 +835,7 @@ static void w5100_tx_work(struct work_struct *work)
 	w5100_tx_skb(priv->ndev, skb);
 }
 
-static int w5100_start_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t w5100_start_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
 
-- 
2.17.0
