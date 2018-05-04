Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEDOBI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:01:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60475 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbeEDOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH net-next v2 13/13] arm64: dts: marvell: 8040-db: describe the 10G SFP cages
Date: Fri,  4 May 2018 15:56:43 +0200
Message-Id: <20180504135643.23466-14-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the SFP cages description for the 10G interfaces in the
Marvell Armada 8080 DB board.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 5689fb23bbab..0a9aeac71614 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -70,6 +70,14 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&cp1_reg_usb3_0_vbus>;
 	};
+
+	sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+	};
+
+	sfp_eth1: sfp-eth1 {
+		compatible = "sff,sfp";
+	};
 };
 
 &i2c0 {
@@ -177,6 +185,8 @@
 &cp0_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	sfp = <&sfp_eth0>;
 };
 
 &cp0_eth2 {
@@ -303,6 +313,8 @@
 &cp1_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	sfp = <&sfp_eth1>;
 };
 
 &cp1_eth1 {
-- 
2.17.0
