Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeDZUCE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:02:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35242 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755830AbeDZT7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:59:38 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH net-next v2 1/7] dt-bindings: net: add DT bindings for Microsemi MIIM
Date: Thu, 26 Apr 2018 21:59:25 +0200
Message-Id: <20180426195931.5393-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for the Microsemi MII Management Controller found on Microsemi
SoCs

Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/net/mscc-miim.txt     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-miim.txt b/Documentation/devicetree/bindings/net/mscc-miim.txt
new file mode 100644
index 000000000000..7104679cf59d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-miim.txt
@@ -0,0 +1,26 @@
+Microsemi MII Management Controller (MIIM) / MDIO
+=================================================
+
+Properties:
+- compatible: must be "mscc,ocelot-miim"
+- reg: The base address of the MDIO bus controller register bank. Optionally, a
+  second register bank can be defined if there is an associated reset register
+  for internal PHYs
+- #address-cells: Must be <1>.
+- #size-cells: Must be <0>.  MDIO addresses have no size component.
+- interrupts: interrupt specifier (refer to the interrupt binding)
+
+Typically an MDIO bus might have several children.
+
+Example:
+	mdio@107009c {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "mscc,ocelot-miim";
+		reg = <0x107009c 0x36>, <0x10700f0 0x8>;
+		interrupts = <14>;
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
-- 
2.17.0
