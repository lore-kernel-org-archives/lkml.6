Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeEDOBK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:01:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60470 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbeEDOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:17 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 12/13] arm64: dts: marvell: 7040-db: describe the 10G SFP cage
Date: Fri,  4 May 2018 15:56:42 +0200
Message-Id: <20180504135643.23466-13-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SFP cage description for the 10G interface in the
Marvell Armada 7040 DB board.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index d6bec058a30a..10a429dcaab7 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -55,6 +55,10 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp0_reg_usb3_1_vbus>;
 	};
+
+	sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+	};
 };
 
 &i2c0 {
@@ -240,8 +244,10 @@
 	status = "okay";
 	/* Network PHY */
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp_eth0>;
 };
 
 &cp0_eth1 {
-- 
2.17.0
