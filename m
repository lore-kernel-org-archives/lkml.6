Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC40C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FDA20C08
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FDA20C08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeHVHNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:13:35 -0400
Received: from mx.socionext.com ([202.248.49.38]:43974 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeHVHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:13:35 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Aug 2018 12:50:35 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 12C136062A;
        Wed, 22 Aug 2018 12:50:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Aug 2018 12:50:34 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 999441A0E6F;
        Wed, 22 Aug 2018 12:50:34 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/4] dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
Date:   Wed, 22 Aug 2018 12:50:31 +0900
Message-Id: <1534909834-16754-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534909834-16754-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534909834-16754-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for PHY interface built into USB3 controller
implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/phy/uniphier-usb3-hsphy.txt           | 69 ++++++++++++++++++++++
 .../bindings/phy/uniphier-usb3-ssphy.txt           | 57 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt

diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
new file mode 100644
index 0000000..e8d8086
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
@@ -0,0 +1,69 @@
+Socionext UniPhier USB3 High-Speed (HS) PHY
+
+This describes the devicetree bindings for PHY interfaces built into
+USB3 controller implemented on Socionext UniPhier SoCs.
+Although the controller includes High-Speed PHY and Super-Speed PHY,
+this describes about High-Speed PHY.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-pro4-usb3-hsphy" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-hsphy" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-hsphy" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-hsphy" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- #phy-cells: Should be 0.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names: Should contain the following:
+    "gio", "link" - for Pro4 SoC
+    "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
+    "phy", "link" - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names: Should contain the following:
+    "gio", "link" - for Pro4 SoC
+    "phy", "link" - for others
+
+Optional properties:
+- vbus-supply: A phandle to the regulator for USB VBUS.
+- nvmem-cells: Phandles to nvmem cell that contains the trimming data.
+	Available only for HS-PHY implemented on LD20 and PXs3, and
+	if unspecified, default value is used.
+- nvmem-cell-names: Should be the following names, which correspond to
+	each nvmem-cells.
+	All of the 3 parameters associated with the following names are
+	required for each port, if any one is omitted, the trimming data
+	of the port will not be set at all.
+    "rterm", "sel_t", "hs_i" - Each cell name for phy parameters
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+
+	usb-glue@65b00000 {
+		compatible = "socionext,uniphier-ld20-dwc3-glue",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x65b00000 0x400>;
+
+		usb_vbus0: regulator {
+			...
+		};
+
+		usb_hsphy0: hs-phy@200 {
+			compatible = "socionext,uniphier-ld20-usb3-hsphy";
+			reg = <0x200 0x10>;
+			#phy-cells = <0>;
+			clock-names = "link", "phy";
+			clocks = <&sys_clk 14>, <&sys_clk 16>;
+			reset-names = "link", "phy";
+			resets = <&sys_rst 14>, <&sys_rst 16>;
+			vbus-supply = <&usb_vbus0>;
+			nvmem-cell-names = "rterm", "sel_t", "hs_i";
+			nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
+				      <&usb_hs_i0>;
+		};
+		...
+	};
diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
new file mode 100644
index 0000000..490b815
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
@@ -0,0 +1,57 @@
+Socionext UniPhier USB3 Super-Speed (SS) PHY
+
+This describes the devicetree bindings for PHY interfaces built into
+USB3 controller implemented on Socionext UniPhier SoCs.
+Although the controller includes High-Speed PHY and Super-Speed PHY,
+this describes about Super-Speed PHY.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-pro4-usb3-ssphy" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-ssphy" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-ssphy" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-ssphy" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- #phy-cells: Should be 0.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names:
+    "gio", "link" - for Pro4 SoC
+    "phy", "phy-ext", "link" - for PXs3 SoC, "phy-ext" is optional.
+    "phy", "link" - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names:
+    "gio", "link" - for Pro4 SoC
+    "phy", "link" - for others
+
+Optional properties:
+- vbus-supply: A phandle to the regulator for USB VBUS.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+
+	usb-glue@65b00000 {
+		compatible = "socionext,uniphier-ld20-dwc3-glue",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x65b00000 0x400>;
+
+		usb_vbus0: regulator {
+			...
+		};
+
+		usb_ssphy0: ss-phy@300 {
+			compatible = "socionext,uniphier-ld20-usb3-ssphy";
+			reg = <0x300 0x10>;
+			#phy-cells = <0>;
+			clock-names = "link", "phy";
+			clocks = <&sys_clk 14>, <&sys_clk 16>;
+			reset-names = "link", "phy";
+			resets = <&sys_rst 14>, <&sys_rst 16>;
+			vbus-supply = <&usb_vbus0>;
+		};
+		...
+	};
-- 
2.7.4

