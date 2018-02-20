Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBTPOF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:14:05 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43125 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeBTPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:14:03 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
Date: Tue, 20 Feb 2018 16:12:11 +0100
Message-Id: <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for R-Car Salvator-X M3-N (R8A77965) board.

Based on original work from:
Takeshi Kihara <takeshi.kihara.df@renesas.com>
Magnus Damm <damm+renesas@opensource.se>

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

---
v1 -> v2:
- split from patch v1 [05/15]
- Remove "aliases" and "chosen" as they are defined already
- Fix license header
---
 arch/arm64/boot/dts/renesas/Makefile                |  1 +
 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 2186d01..3680ecd 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -7,5 +7,6 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
+dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
new file mode 100644
index 0000000..75d890d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Salvator-X board with R-Car M3-N
+ *
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ */
+
+/dts-v1/;
+#include "r8a77965.dtsi"
+#include "salvator-x.dtsi"
+
+/ {
+	model = "Renesas Salvator-X board based on r8a77965";
+	compatible = "renesas,salvator-x", "renesas,r8a77965";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
-- 
2.7.4
