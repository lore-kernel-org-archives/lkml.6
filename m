Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933859AbeDXNRY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:17:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55445 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933817AbeDXNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:17:17 -0400
X-Google-Smtp-Source: AIpwx493r1HyvyXxzG+wTZz99cyzrJBFEbk8tvTXL6b94qC8MmScbFJs1P5pYvrMIy9Hqvg+rtffdw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH] net: pch_gbe: fix pch_gbe_xmit_frame()'s return type
Date: Tue, 24 Apr 2018 15:17:12 +0200
Message-Id: <20180424131714.4257-1-luc.vanoostenryck@gmail.com>
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
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 7cd494611..40f7f9309 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2121,7 +2121,7 @@ static int pch_gbe_stop(struct net_device *netdev)
  *	- NETDEV_TX_OK:   Normal end
  *	- NETDEV_TX_BUSY: Error end
  */
-static int pch_gbe_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t pch_gbe_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	struct pch_gbe_tx_ring *tx_ring = adapter->tx_ring;
-- 
2.17.0
