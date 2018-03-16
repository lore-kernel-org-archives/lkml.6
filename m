Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeCPKkf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:40:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34985 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753448AbeCPKfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:35:40 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface to use in-band negotiation
Date: Fri, 16 Mar 2018 11:33:43 +0100
Message-Id: <20180316103351.16616-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY mode 10GKR can use in-band negotiation. This patches allows this
mode to be used with MLO_AN_INBAND in phylink.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/phylink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 51a011a349fe..7224b005f0dd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -768,7 +768,8 @@ int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
 	/* Fixed links and 802.3z are handled without needing a PHY */
 	if (pl->link_an_mode == MLO_AN_FIXED ||
 	    (pl->link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	     (phy_interface_mode_is_8023z(pl->link_interface) ||
+	      pl->link_interface == PHY_INTERFACE_MODE_10GKR)))
 		return 0;
 
 	phy_node = of_parse_phandle(dn, "phy-handle", 0);
-- 
2.14.3
