Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeDXNtG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:49:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50923 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933668AbeDXNQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:21 -0400
X-Google-Smtp-Source: AIpwx48dveVE7U0Nfo8GpKZfGc9ndoN/uNZwCQVksKhVH3wmKft5aFuJ6/BNa6kbsJ5sq2P7kuuCdw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org
Subject: [PATCH] amd-xgbe: fix xgbe_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:18 +0200
Message-Id: <20180424131618.3455-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 7c204f05b..9dc263dda 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1962,7 +1962,7 @@ static int xgbe_close(struct net_device *netdev)
 	return 0;
 }
 
-static int xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t xgbe_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-- 
2.17.0
