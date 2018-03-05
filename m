Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeCEOUR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:20:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58656 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932277AbeCEOUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:20:04 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 4/5] net: mvpp2: enable UDP/TCP checksum over IPv6
Date: Mon,  5 Mar 2018 15:16:53 +0100
Message-Id: <20180305141654.7789-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305141654.7789-1-antoine.tenart@bootlin.com>
References: <20180305141654.7789-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the NETIF_F_IPV6_CSUM to the driver's features to enable
UDP/TCP checksum over IPv6. No extra configuration of the engine is
needed on top of the IPv4 counterpart, which already is in the features
list (NETIF_F_IP_CSUM).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 9c378f803649..78dc07c826c5 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -8321,7 +8321,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		}
 	}
 
-	features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
+	features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+		   NETIF_F_TSO;
 	dev->features = features | NETIF_F_RXCSUM;
 	dev->hw_features |= features | NETIF_F_RXCSUM | NETIF_F_GRO |
 			    NETIF_F_HW_VLAN_CTAG_FILTER;
-- 
2.14.3
