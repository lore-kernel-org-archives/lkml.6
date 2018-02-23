Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeBWKSw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:18:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751625AbeBWKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:57 -0500
X-UUID: 07add77d47af4b9bb7375f2038cc24ff-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 17/19] arm: dts: mt7623: add MT7623N reference board with eMMC
Date: Fri, 23 Feb 2018 18:16:37 +0800
Message-ID: <45572848513719fd4099c0f3564b06743b1be27b.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add MT7623N reference board with eMMC. On the board, there is additional
external PHY which is ICPlus IP1001 transceiver available by port 5 on the
MDIO bus connectted with GMAC2.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38..5af6fce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1122,6 +1122,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
+	mt7623n-rfb-emmc.dtb \
 	mt7623n-rfb-nand.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt8127-moose.dtb \
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
new file mode 100644
index 0000000..0db75bc
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include "mt7623n-rfb.dtsi"
+
+/ {
+	model = "MediaTek MT7623N with eMMC reference board";
+	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
+
+	chosen {
+		bootargs = "console=ttyS2,115200n8 earlyprintk";
+	};
+};
+
+&eth {
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+};
+
+&mdio {
+	phy5: ethernet-phy@5 {
+		reg = <5>;
+		phy-mode = "rgmii-rxid";
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
-- 
2.7.4
