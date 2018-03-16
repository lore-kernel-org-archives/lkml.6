Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeCPKfs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:35:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753501AbeCPKfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:35:46 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 08/10] arm64: dts: marvell: 7040-db: set the 10G interface management to in-band
Date: Fri, 16 Mar 2018 11:33:49 +0100
Message-Id: <20180316103351.16616-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets the 10G interface (cp0_eth0) management to in-band. This
is needed for the PPv2 driver to handle such ports, with its conversion
to phylink.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 3ae05eee2c9a..f27af07db381 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -267,6 +267,7 @@
 	status = "okay";
 	/* Network PHY */
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy2 0>;
 };
-- 
2.14.3
