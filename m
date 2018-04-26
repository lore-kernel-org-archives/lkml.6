Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbeDZVNx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:13:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37616 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756187AbeDZVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:13:49 -0400
X-Google-Smtp-Source: AB8JxZrEIeef+hxuBmeZ+uO/ogVt8g3ACRqvWyX+H6M1Nwm4r3n9LxOTw19IE616/xi59OKDFSDBow==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Michal Simek <michal.simek@xilinx.com>,
        linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
Date: Thu, 26 Apr 2018 23:13:38 +0200
Message-Id: <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07c2..a19648606 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
  *
  * Return: 0 on success and failure value on error
  */
-static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-- 
2.17.0
