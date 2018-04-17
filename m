Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDQLKQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:10:16 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:50801 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751230AbeDQLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:10:13 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="278455905"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 5/6] ARM: dts: Renesas RZN1D-DB Board base file
Date: Tue, 17 Apr 2018 12:04:20 +0100
Message-Id: <1523963101-56725-6-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a base device tree file for the RZN1-DB board, with only the
basic support allowing the system to boot to a prompt. Only one UART is
used, with only a single CPU running.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 052aaf0..a53a677 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -809,6 +809,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
+	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-evb.dtb \
diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
new file mode 100644
index 0000000..5fc2c40
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZN1D-DB Board
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+/dts-v1/;
+
+#include "r9a06g032.dtsi"
+
+/ {
+	model = "RZN1D-DB Board";
+	compatible = "renesas,rzn1d400-db",
+			"renesas,r9a06g032", "renesas,rzn1";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.7.4
