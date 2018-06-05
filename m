Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeFEQfw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:35:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43953 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeFEQfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:35:48 -0400
X-Google-Smtp-Source: ADUXVKKNH6+WV8RoaMl3hODMpZrkfc6nAFUGn89XtmiHp8pDi3Qeg0d2ebSnym+1itNL2JIyweL/8g==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: matthias.bgg@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board support
Date: Tue,  5 Jun 2018 22:04:42 +0530
Message-Id: <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree support for Mediatek X20 Development Board
based on MT6797 Deca core SoC. This board is one of the 96Boards
Consumer Edition platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index ac17f60f998c..5b7fd6ad96e4 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
new file mode 100644
index 000000000000..2c09ca95d9e2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for MediaTek X20 Development Board
+ *
+ * Copyright (C) 2018, Linaro Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "mt6797.dtsi"
+
+/ {
+	model = "Mediatek X20 Development Board";
+	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x1e605000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
2.17.0
