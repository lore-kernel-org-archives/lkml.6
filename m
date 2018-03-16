Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeCPKfx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:35:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35077 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753400AbeCPKfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:35:50 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 10/10] arm64: dts: marvell: mcbin: enable the fourth network interface
Date: Fri, 16 Mar 2018 11:33:51 +0100
Message-Id: <20180316103351.16616-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the fourth network interface on the Marvell
Macchiatobin. It is configured in the 2500Base-X PHY mode.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 626e9d0462c3..1ce31bfe6197 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -66,6 +66,7 @@
 		ethernet0 = &cp0_eth0;
 		ethernet1 = &cp1_eth0;
 		ethernet2 = &cp1_eth1;
+		ethernet3 = &cp1_eth2;
 	};
 
 	/* Regulator labels correspond with schematics */
@@ -285,6 +286,16 @@
 	phys = <&cp1_comphy0 1>;
 };
 
+&cp1_eth2 {
+	/* CPS Lane 5 */
+	status = "okay";
+	/* Network PHY */
+	phy-mode = "2500base-x";
+	managed = "in-band-status";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy5 2>;
+};
+
 &cp1_pinctrl {
 	cp1_spi1_pins: spi1-pins {
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
-- 
2.14.3
