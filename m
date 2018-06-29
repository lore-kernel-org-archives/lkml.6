Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD33DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7AD27BD6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7AD27BD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935137AbeF2IWX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:22:23 -0400
Received: from mx.socionext.com ([202.248.49.38]:42666 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935049AbeF2IWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:22:19 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Jun 2018 17:22:18 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 292AE60034;
        Fri, 29 Jun 2018 17:22:18 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Jun 2018 17:22:18 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 9859F1A120B;
        Fri, 29 Jun 2018 17:22:17 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: regulator: add DT bindings for UniPhier regulator
Date:   Fri, 29 Jun 2018 17:22:12 +0900
Message-Id: <1530260533-19415-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530260533-19415-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530260533-19415-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for regulators implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/regulator/uniphier-regulator.txt      | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
new file mode 100644
index 0000000..cbc0f6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
@@ -0,0 +1,54 @@
+Socionext UniPhier Regulator Controller
+
+This describes the devicetree bindings for regulator controller implemented
+on Socionext UniPhier SoCs.
+
+USB3 Controller
+---------------
+
+Required properties:
+- compatible: Should be
+    "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+
+See Documentation/devicetree/bindings/regulator/regulator.txt
+for more details about the regulator properties.
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
+		usb_vbus0: regulators@100 {
+			compatible = "socionext,uniphier-ld20-usb3-regulator";
+			reg = <0x100 0x10>;
+			clock-names = "link";
+			clocks = <&sys_clk 14>;
+			reset-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		phy {
+			...
+			phy-supply = <&usb_vbus0>;
+		};
+
+		other nodes ...
+	};
-- 
2.7.4

