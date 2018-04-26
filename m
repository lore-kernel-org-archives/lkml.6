Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756463AbeDZT7n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:59:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35266 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755857AbeDZT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:59:39 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, James Hogan <jhogan@kernel.org>
Subject: [PATCH net-next v2 3/7] dt-bindings: net: add DT bindings for Microsemi Ocelot Switch
Date: Thu, 26 Apr 2018 21:59:27 +0200
Message-Id: <20180426195931.5393-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: James Hogan <jhogan@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-ocelot.txt   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
new file mode 100644
index 000000000000..0a84711abece
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -0,0 +1,82 @@
+Microsemi Ocelot network Switch
+===============================
+
+The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
+VSC7514)
+
+Required properties:
+- compatible: Should be "mscc,vsc7514-switch"
+- reg: Must contain an (offset, length) pair of the register set for each
+  entry in reg-names.
+- reg-names: Must include the following entries:
+  - "sys"
+  - "rew"
+  - "qs"
+  - "hsio"
+  - "qsys"
+  - "ana"
+  - "portX" with X from 0 to the number of last port index available on that
+    switch
+- interrupts: Should contain the switch interrupts for frame extraction and
+  frame injection
+- interrupt-names: should contain the interrupt names: "xtr", "inj"
+- ethernet-ports: A container for child nodes representing switch ports.
+
+The ethernet-ports container has the following properties
+
+Required properties:
+
+- #address-cells: Must be 1
+- #size-cells: Must be 0
+
+Each port node must have the following mandatory properties:
+- reg: Describes the port address in the switch
+
+Port nodes may also contain the following optional standardised
+properties, described in binding documents:
+
+- phy-handle: Phandle to a PHY on an MDIO bus. See
+  Documentation/devicetree/bindings/net/ethernet.txt for details.
+
+Example:
+
+	switch@1010000 {
+		compatible = "mscc,vsc7514-switch";
+		reg = <0x1010000 0x10000>,
+		      <0x1030000 0x10000>,
+		      <0x1080000 0x100>,
+		      <0x10d0000 0x10000>,
+		      <0x11e0000 0x100>,
+		      <0x11f0000 0x100>,
+		      <0x1200000 0x100>,
+		      <0x1210000 0x100>,
+		      <0x1220000 0x100>,
+		      <0x1230000 0x100>,
+		      <0x1240000 0x100>,
+		      <0x1250000 0x100>,
+		      <0x1260000 0x100>,
+		      <0x1270000 0x100>,
+		      <0x1280000 0x100>,
+		      <0x1800000 0x80000>,
+		      <0x1880000 0x10000>;
+		reg-names = "sys", "rew", "qs", "hsio", "port0",
+			    "port1", "port2", "port3", "port4", "port5",
+			    "port6", "port7", "port8", "port9", "port10",
+			    "qsys", "ana";
+		interrupts = <21 22>;
+		interrupt-names = "xtr", "inj";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port0: port@0 {
+				reg = <0>;
+				phy-handle = <&phy0>;
+			};
+			port1: port@1 {
+				reg = <1>;
+				phy-handle = <&phy1>;
+			};
+		};
+	};
-- 
2.17.0
