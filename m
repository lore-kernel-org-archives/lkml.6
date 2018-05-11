Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeEKT1B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:27:01 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:48446 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeEKT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:26:59 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next PATCH 2/4] ARM: dts: keystone-k2g-evm: Enable netcp network driver
Date: Fri, 11 May 2018 15:29:10 -0400
Message-ID: <1526066952-5230-3-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings to enable netcp network driver on K2G GP EVM. This
consists of enabling bindings for nss qmss, pktdma, 2u ethss,
mdio, pinmux and netcp devices.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 154fdd7..f028a00 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -128,6 +128,30 @@
 			K2G_CORE_IOPAD(0x1228) (BUFFER_CLASS_B | PIN_PULLDOWN  | MUX_MODE1)	/* qspicsn3.dcan1rx */
 		>;
 	};
+
+	emac_pins: pinmux_emac_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x113C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD1.RGMII_RXD1 */
+			K2G_CORE_IOPAD(0x1138) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD2.RGMII_RXD2 */
+			K2G_CORE_IOPAD(0x1134) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD3.RGMII_RXD3 */
+			K2G_CORE_IOPAD(0x1140) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD0.RGMII_RXD0 */
+			K2G_CORE_IOPAD(0x1178) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD0.RGMII_TXD0 */
+			K2G_CORE_IOPAD(0x1174) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD1.RGMII_TXD1 */
+			K2G_CORE_IOPAD(0x1170) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD2.RGMII_TXD2 */
+			K2G_CORE_IOPAD(0x116C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD3.RGMII_TXD3 */
+			K2G_CORE_IOPAD(0x1154) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXCLK.RGMII_TXC */
+			K2G_CORE_IOPAD(0x117C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXEN.RGMII_TXCTL */
+			K2G_CORE_IOPAD(0x1120) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXCLK.RGMII_RXC */
+			K2G_CORE_IOPAD(0x1144) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXDV.RGMII_RXCTL */
+		>;
+	};
+
+	mdio_pins: pinmux_mdio_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x118C) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_CLK.MDIO_CLK */
+			K2G_CORE_IOPAD(0x1188) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_DATA.MDIO_DATA */
+		>;
+	};
 };
 
 &uart0 {
@@ -294,3 +318,32 @@
 	pinctrl-0 = <&dcan1_pins>;
 	status = "okay";
 };
+
+&qmss {
+	status = "okay";
+};
+
+&knav_dmas {
+	status = "okay";
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	status = "okay";
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&gbe0 {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&netcp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_pins>;
+	status = "okay";
+};
-- 
1.9.1
