Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDSHZM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:25:12 -0400
Received: from mx.socionext.com ([202.248.49.38]:32897 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeDSHZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:25:08 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net-next v2 2/3] dt-bindings: net: ave: add syscon-phy-mode property to configure phy-mode setting
Date: Thu, 19 Apr 2018 16:24:54 +0900
Message-Id: <1524122695-19597-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "socionext,syscon-phy-mode" property to specify system controller that
configures the settings about phy-mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
index 85e0c49..fc8f017 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
@@ -13,7 +13,8 @@ Required properties:
  - reg: Address where registers are mapped and size of region.
  - interrupts: Should contain the MAC interrupt.
  - phy-mode: See ethernet.txt in the same directory. Allow to choose
-	"rgmii", "rmii", or "mii" according to the PHY.
+	"rgmii", "rmii", "mii", or "internal" according to the PHY.
+	The acceptable mode is SoC-dependent.
  - phy-handle: Should point to the external phy device.
 	See ethernet.txt file in the same directory.
  - clocks: A phandle to the clock for the MAC.
@@ -27,6 +28,8 @@ Required properties:
  - reset-names: Should contain
 	- "ether", "gio" for Pro4 SoC
 	- "ether" for others
+ - socionext,syscon-phy-mode: A phandle to syscon with one argument
+	that configures phy mode. The argument is the ID of MAC instance.
 
 Optional properties:
  - local-mac-address: See ethernet.txt in the same directory.
@@ -47,6 +50,7 @@ Example:
 		clocks = <&sys_clk 6>;
 		reset-names = "ether";
 		resets = <&sys_rst 6>;
+		socionext,syscon-phy-mode = <&soc_glue 0>;
 		local-mac-address = [00 00 00 00 00 00];
 
 		mdio {
-- 
2.7.4
