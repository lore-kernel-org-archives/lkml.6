Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933881AbeDXNR3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39714 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeDXNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:19 -0400
X-Google-Smtp-Source: AIpwx4+jgBYs5EgdjC1Pwe3W+OEFy0O7EUcC0Os+UyavK2AW5SjOFoHatPnInrkgj9qcx15xzLP3dw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Timur Tabi <timur@codeaurora.org>, netdev@vger.kernel.org
Subject: [PATCH] net: qcom/emac: fix emac_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:17:16 +0200
Message-Id: <20180424131716.4308-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/qualcomm/emac/emac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 13235baf4..ed64bafc2 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -123,7 +123,7 @@ static int emac_napi_rtx(struct napi_struct *napi, int budget)
 }
 
 /* Transmit the packet */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct emac_adapter *adpt = netdev_priv(netdev);
 
-- 
2.17.0
