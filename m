Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeEBL65 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:58:57 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:59048 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:58:55 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>, <ssantosh@kernel.org>,
        <faiz_abbas@ti.com>
Subject: [PATCH] ARM: dts: k2g-evm: Add DCAN dt nodes
Date: Wed, 2 May 2018 17:29:55 +0530
Message-ID: <20180502115955.31910-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keystone 2 galileo evm has support for dcan.
Add nodes and pinmuxes for dcan0 and dcan1.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 6a4657799b99..154fdd7a7022 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -114,6 +114,20 @@
 			K2G_CORE_IOPAD(0x11f0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)      /* uart2_txd.uart2_txd */
 		>;
 	};
+
+	dcan0_pins: pinmux_dcan0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x11fc) (BUFFER_CLASS_B | PULL_DISABLE  | MUX_MODE0)	/* dcan0tx.dcan0tx */
+			K2G_CORE_IOPAD(0x1200) (BUFFER_CLASS_B | PIN_PULLDOWN  | MUX_MODE0)	/* dcan0rx.dcan0rx */
+		>;
+	};
+
+	dcan1_pins: pinmux_dcan1_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1224) (BUFFER_CLASS_B | PULL_DISABLE  | MUX_MODE1)	/* qspicsn2.dcan1tx */
+			K2G_CORE_IOPAD(0x1228) (BUFFER_CLASS_B | PIN_PULLDOWN  | MUX_MODE1)	/* qspicsn3.dcan1rx */
+		>;
+	};
 };
 
 &uart0 {
@@ -268,3 +282,15 @@
 	pinctrl-0 = <&uart2_pins>;
 	status = "okay";
 };
+
+&dcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan0_pins>;
+	status = "okay";
+};
+
+&dcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dcan1_pins>;
+	status = "okay";
+};
-- 
2.17.0
