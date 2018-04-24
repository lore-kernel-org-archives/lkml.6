Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeDXLrc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:47:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43368 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeDXLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:47:20 -0400
X-Google-Smtp-Source: AB8JxZq6zyaJNuZSkLp5kqg2RY8L0GKwre8NtcwY2b7vtB+IHnEYxI1b8AtY0n6ly6M9H/wdaBb/6Q==
From: Neil Armstrong <narmstrong@baylibre.com>
To: maxime.ripard@bootlin.com, wens@csie.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: allwinner: Add dts file for Libre Computer Board ALL-H3-CC H5 ver.
Date: Tue, 24 Apr 2018 13:47:14 +0200
Message-Id: <1524570434-17814-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
References: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
Pi B+ form factor single board computer based on the Allwinner H2+, H3,
or H5 SoCs with the same PCB.
The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
and connectors are in the exact same position as on the Raspberry Pi B+.

This patch enables the H5 variant using the H3 board definition moved to
a common dtsi in an earlier patch. The dts sinmply include the common dtsi
and declares the correct compatible and model of the H5 variant.

Suggested-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/Makefile                     |  1 +
 .../boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 8bebe7d..7e07c07 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
new file mode 100644
index 0000000..95e113c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+#include "sun50i-h5.dtsi"
+#include <arm/sunxi-libretech-all-h3-cc.dtsi>
+
+/ {
+	model = "Libre Computer Board ALL-H3-CC H5";
+	compatible = "libretech,all-h3-cc-h5", "allwinner,sun50i-h5";
+};
-- 
2.7.4
