Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966494AbeCAHW5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 02:22:57 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43838 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966417AbeCAHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 02:22:53 -0500
X-Google-Smtp-Source: AG47ELu2AFgUgf+cEyN75LLlPmpBSZLZ4BWPMrr3xOxoVCI03I//eanXDrIUkjOZt/xPiRXSuPGsWg==
From: Shawn Guo <shawn.guo@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pengcheng Li <lpc.li@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: add bindings doc for HiSilicon INNO USB2 PHY
Date: Thu,  1 Mar 2018 15:22:19 +0800
Message-Id: <1519888940-23235-2-git-send-email-shawn.guo@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519888940-23235-1-git-send-email-shawn.guo@linaro.org>
References: <1519888940-23235-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pengcheng Li <lpc.li@hisilicon.com>

It adds device tree bindings document for HiSilicon INNO USB2 PHY.

Signed-off-by: Pengcheng Li <lpc.li@hisilicon.com>
Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
new file mode 100644
index 000000000000..b563cf54ca7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
@@ -0,0 +1,52 @@
+HiSilicon INNO USB2 PHY
+
+Required properties:
+- compatible: Should be one of the following strings:
+	"hisilicon,inno-usb2-phy",
+	"hisilicon,hi3798cv200-usb2-phy".
+- reg: Should be the address space for PHY configuration register in peripheral
+  controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798cv200 SoC.
+- #phy-cells: Should be 1. The specifier is the index of the PHY port to
+  reference.
+- clocks: The phandle and clock specifier pair for reference clock utmi_refclk.
+- resets: The list of phandle and reset specifier pairs for each reset signal
+  in reset-names.
+- reset-names: Should contain "power_on", "utmi0" and "utmi1". The "utmi1"
+  should exist only if the device has two PHY port.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Note: the device node should be a child of peripheral controller that contains
+the PHY configuration register.
+
+Example:
+
+perictrl: peripheral-controller@8a20000 {
+	compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
+		     "simple-mfd";
+	reg = <0x8a20000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x0 0x8a20000 0x1000>;
+
+	usb2_phy1: phy@120 {
+		compatible = "hisilicon,hi3798cv200-usb2-phy";
+		reg = <0x120 0x4>;
+		#phy-cells = <1>;
+		clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+		resets = <&crg 0xbc 4>,
+			 <&crg 0xbc 8>,
+			 <&crg 0xbc 9>;
+		reset-names = "power_on", "utmi0", "utmi1";
+	};
+
+	usb2_phy2: phy@124 {
+		compatible = "hisilicon,hi3798cv200-usb2-phy";
+		reg = <0x124 0x4>;
+		#phy-cells = <1>;
+		clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
+		resets = <&crg 0xbc 6>,
+			 <&crg 0xbc 10>;
+		reset-names = "power_on", "utmi0";
+	};
+};
-- 
1.9.1
