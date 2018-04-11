Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDKI6D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:58:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751983AbeDKIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:54:15 -0400
X-UUID: 6fe4200660d3468c9923d3007197565e-20180411
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 10/12] arm: dts: mt7623: add MT7623A SoC level DTS
Date: Wed, 11 Apr 2018 16:54:03 +0800
Message-ID: <ff65685a9f121faf7fc03f0af3c6a5cd71b89081.1523434758.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add a common file for MT7623A SoC level DTS, indicating MT7623A only
has a specific definition for power domain. That causes we need to change
related consumers devices such as audio, ethernet, crypto, NAND, and USB
controller to grasp its own power domain it should belong to.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623a.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623a.dtsi

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
new file mode 100644
index 0000000..0735a1fb8
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include <dt-bindings/power/mt7623a-power.h>
+#include "mt7623.dtsi"
+
+&afe {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
+};
+
+&crypto {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
+};
+
+&eth {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
+};
+
+&nandc {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
+};
+
+&pcie {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
+};
+
+&scpsys {
+	compatible = "mediatek,mt7623a-scpsys";
+	clocks = <&topckgen CLK_TOP_ETHIF_SEL>;
+	clock-names = "ethif";
+};
+
+&usb1 {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
+};
+
+&usb2 {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
+};
-- 
2.7.4
