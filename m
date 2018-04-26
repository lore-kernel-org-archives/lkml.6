Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbeDZVNs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:13:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52734 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeDZVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:13:46 -0400
X-Google-Smtp-Source: AB8JxZrHSs5cPkfEcxAMlgHeScPFBpUEm5odkanjKY/G2WAy96C9R5la+mfxMx1SbDIcVq4ckLYW2A==
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
Subject: [PATCH 1/3] can: janz-ican3: fix ican3_xmit()'s return type
Date: Thu, 26 Apr 2018 23:13:36 +0200
Message-Id: <20180426211339.30821-2-luc.vanoostenryck@gmail.com>
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
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index adfdb66a4..02042cb09 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1684,7 +1684,7 @@ static int ican3_stop(struct net_device *ndev)
 	return 0;
 }
 
-static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ican3_dev *mod = netdev_priv(ndev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
-- 
2.17.0
