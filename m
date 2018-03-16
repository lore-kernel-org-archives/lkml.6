Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeCPC5Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:57:16 -0400
Received: from vern.gendns.com ([206.190.152.46]:55455 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933064AbeCPCxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:53:51 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v8 17/42] dt-bindings: clock: Add bindings for DA8XX CFGCHIP clocks
Date: Thu, 15 Mar 2018 21:52:33 -0500
Message-Id: <1521168778-27236-18-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new binding for the clocks present in the CFGCHIP syscon
registers in TI DA8XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v8 changes:
- none

v7 changes:
- none

v6 changes:
- combine "dt-bindings: clock: Add bindings for DA8XX CFGCHIP gate clocks",
  "dt-bindings: clock: Add binding for TI DA8XX CFGCHIP mux clocks" and
  "dt-bindings: clock: Add bindings for TI DA8XX USB PHY clocks" into a single
  file containing all CFGCHIP clocks bindings
- added compatible = "ti,da830-div4p5ena"
- added compatible = "ti,da850-async1-clksrc"
- renamed other compatible strings
- changed and added some clk-names strings
- USB PHY clocks are combined into a single node with #clock-cells = <1>

 .../bindings/clock/ti/davinci/da8xx-cfgchip.txt    | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt

diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt b/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt
new file mode 100644
index 0000000..1e03dce
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip.txt
@@ -0,0 +1,93 @@
+Binding for TI DA8XX/OMAP-L13X/AM17XX/AM18XX CFGCHIP clocks
+
+TI DA8XX/OMAP-L13X/AM17XX/AM18XX SoCs contain a general purpose set of
+registers call CFGCHIPn. Some of these registers function as clock
+gates. This document describes the bindings for those clocks.
+
+All of the clock nodes described below must be child nodes of a CFGCHIP node
+(compatible = "ti,da830-cfgchip").
+
+USB PHY clocks
+--------------
+Required properties:
+- compatible: shall be "ti,da830-usb-phy-clocks".
+- #clock-cells: from common clock binding; shall be set to 1.
+- clocks: phandles to the parent clocks corresponding to clock-names
+- clock-names: shall be "fck", "usb_refclkin", "auxclk"
+
+This node provides two clocks. The clock at index 0 is the USB 2.0 PHY 48MHz
+clock and the clock at index 1 is the USB 1.1 PHY 48MHz clock.
+
+eHRPWM Time Base Clock (TBCLK)
+------------------------------
+Required properties:
+- compatible: shall be "ti,da830-tbclksync".
+- #clock-cells: from common clock binding; shall be set to 0.
+- clocks: phandle to the parent clock
+- clock-names: shall be "fck"
+
+PLL DIV4.5 divider
+------------------
+Required properties:
+- compatible: shall be "ti,da830-div4p5ena".
+- #clock-cells: from common clock binding; shall be set to 0.
+- clocks: phandle to the parent clock
+- clock-names: shall be "pll0_pllout"
+
+EMIFA clock source (ASYNC1)
+---------------------------
+Required properties:
+- compatible: shall be "ti,da850-async1-clksrc".
+- #clock-cells: from common clock binding; shall be set to 0.
+- clocks: phandles to the parent clocks corresponding to clock-names
+- clock-names: shall be "pll0_sysclk3", "div4.5"
+
+ASYNC3 clock source
+-------------------
+Required properties:
+- compatible: shall be "ti,da850-async3-clksrc".
+- #clock-cells: from common clock binding; shall be set to 0.
+- clocks: phandles to the parent clocks corresponding to clock-names
+- clock-names: shall be "pll0_sysclk2", "pll1_sysclk2"
+
+Examples:
+
+	cfgchip: syscon@1417c {
+		compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
+		reg = <0x1417c 0x14>;
+
+		usb_phy_clk: usb-phy-clocks {
+			compatible = "ti,da830-usb-phy-clocks";
+			#clock-cells = <1>;
+			clocks = <&psc1 1>, <&usb_refclkin>, <&pll0_auxclk>;
+			clock-names = "fck", "usb_refclkin", "auxclk";
+		};
+		ehrpwm_tbclk: ehrpwm_tbclk {
+			compatible = "ti,da830-tbclksync";
+			#clock-cells = <0>;
+			clocks = <&psc1 17>;
+			clock-names = "fck";
+		};
+		div4p5_clk: div4.5 {
+			compatible = "ti,da830-div4p5ena";
+			#clock-cells = <0>;
+			clocks = <&pll0_pllout>;
+			clock-names = "pll0_pllout";
+		};
+		async1_clk: async1 {
+			compatible = "ti,da850-async1-clksrc";
+			#clock-cells = <0>;
+			clocks = <&pll0_sysclk 3>, <&div4p5_clk>;
+			clock-names = "pll0_sysclk3", "div4.5";
+		};
+		async3_clk: async3 {
+			compatible = "ti,da850-async3-clksrc";
+			#clock-cells = <0>;
+			clocks = <&pll0_sysclk 2>, <&pll1_sysclk 2>;
+			clock-names = "pll0_sysclk2", "pll1_sysclk2";
+		};
+	};
+
+Also see:
+- Documentation/devicetree/bindings/clock/clock-bindings.txt
+
-- 
2.7.4
