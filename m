Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947628AbeCBTFb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:05:31 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42465 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428677AbeCBTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:04:51 -0500
X-Google-Smtp-Source: AG47ELt23VKtClpahIXLW5qvTBNnyUc26yhLEh2EAqrn0Glox2dRyPRLuLLcLkFpLeHPv50Fas1DZQ==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/8] arm64: zynqmp: Add support for Xilinx zc12XX boards
Date: Fri,  2 Mar 2018 20:04:33 +0100
Message-Id: <7a1bf88c742150f93cf5b3df4ffa5d6fe3a3f862.1520017397.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 3 boards requires minimal support to get Linux up and running.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt  |  9 ++++
 arch/arm64/boot/dts/xilinx/Makefile               |  3 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 54 +++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 42 ++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts | 42 ++++++++++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index c2bc75774010..aceccf2bf43b 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -19,6 +19,15 @@ Required root node properties:
 
 Additional compatible strings:
 
+- Xilinx internal board zc1232
+  "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232"
+
+- Xilinx internal board zc1254
+  "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254"
+
+- Xilinx internal board zc1275
+  "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
+
 - Xilinx 96boards compatible board zcu100
   "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
 
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index d15c9dc1d8f2..bdda451afaad 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
new file mode 100644
index 000000000000..0f7b4cf6078e
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZC1232
+ *
+ * (C) Copyright 2017 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP ZC1232 RevA";
+	compatible = "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232", "xlnx,zynqmp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+	/* SATA OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
new file mode 100644
index 000000000000..9092828f92ec
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZC1254
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP ZC1254 RevA";
+	compatible = "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254", "xlnx,zynqmp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
new file mode 100644
index 000000000000..4f404c580eec
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZC1275
+ *
+ * (C) Copyright 2017 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP ZC1275 RevA";
+	compatible = "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275", "xlnx,zynqmp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.9.1
