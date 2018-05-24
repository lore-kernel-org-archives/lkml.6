Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966047AbeEXJex (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:34:53 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:64379 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965664AbeEXJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:34:49 -0400
X-IronPort-AV: E=Sophos;i="5.49,436,1520866800";
   d="scan'208";a="281940893"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/5] ARM: dts: Renesas RZN1D-DB Board base file
Date: Thu, 24 May 2018 10:28:42 +0100
Message-Id: <1527154169-32380-5-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
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
index f4753b0..6157897 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -814,6 +814,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
+	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-evb.dtb \
diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
new file mode 100644
index 0000000..292af58
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
+			"renesas,r9a06g032";
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
