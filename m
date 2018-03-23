Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeCWUOb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:14:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34921 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeCWULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:11:37 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for Microsemi Ocelot Switch
Date: Fri, 23 Mar 2018 21:11:13 +0100
Message-Id: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
new file mode 100644
index 000000000000..ee092a85b5a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -0,0 +1,62 @@
+Microsemi Ocelot network Switch
+===============================
+
+The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
+VSC7514)
+
+Required properties:
+- compatible: Should be "mscc,ocelot-switch"
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
+
+Example:
+
+	switch@1010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "mscc,ocelot-switch";
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
+		port0: port@0 {
+			reg = <0>;
+			phy-handle = <&phy0>;
+		};
+		port1: port@1 {
+			reg = <1>;
+			phy-handle = <&phy1>;
+		};
+	};
-- 
2.16.2
