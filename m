Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeEBLxS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:53:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39117 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeEBLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:53:16 -0400
X-Google-Smtp-Source: AB8JxZrwzoq0+oQGXcoPqhOEYRH1ctvtn4cqNvH/bIygfb1GJ3fHpKdi7yirBU1BLcL5ZRWgFEcEjw==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: zynqmp: Add support for Avnet Ultra96 rev1 board
Date: Wed,  2 May 2018 13:53:14 +0200
Message-Id: <80d21c84d427cb6b4122efd3dea7f1c4ab4cf2be.1525261987.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avnet Ultra96 rev1 board is commercialized Xilinx zcu100 revC/D
internal board. The patch is reusing zcu100 revC files but changing
model description and compatible strings which are used for example by
libmraa.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I choose this option because there are houndreds of zcu100 boards
created and this will enable support both versions.

Record avnet prefix was sent by separate patch.
---
 arch/arm64/boot/dts/xilinx/Makefile           |  1 +
 .../boot/dts/xilinx/avnet-ultra96-rev1.dts    | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index d452f80e7601..60f5443f3ef4 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ZYNQMP) += avnet-ultra96-rev1.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
new file mode 100644
index 000000000000..88aa06fa78a8
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Avnet Ultra96 rev1
+ *
+ * (C) Copyright 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp-zcu100-revC.dts"
+
+/ {
+	model = "Avnet Ultra96 Rev1";
+	compatible = "avnet,ultra96-rev1", "avnet,ultra96",
+		     "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100",
+		     "xlnx,zynqmp";
+};
-- 
2.17.0
