Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9248C04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715D420C09
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715D420C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeHVHNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:13:37 -0400
Received: from mx.socionext.com ([202.248.49.38]:43990 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVHNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:13:37 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Aug 2018 12:50:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B6246180237;
        Wed, 22 Aug 2018 12:50:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Aug 2018 12:50:35 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 1F30F1A0E6F;
        Wed, 22 Aug 2018 12:50:35 +0900 (JST)
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
Subject: [PATCH v3 3/4] dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
Date:   Wed, 22 Aug 2018 12:50:33 +0900
Message-Id: <1534909834-16754-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534909834-16754-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534909834-16754-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for PHY interface built into USB2 controller
implemented on Socionext UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
new file mode 100644
index 0000000..b43b282
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
@@ -0,0 +1,45 @@
+Socionext UniPhier USB2 PHY
+
+This describes the devicetree bindings for PHY interface built into
+USB2 controller implemented on Socionext UniPhier SoCs.
+
+Pro4 SoC has both USB2 and USB3 host controllers, however, this USB3
+controller doesn't include its own High-Speed PHY. This needs to specify
+USB2 PHY instead of USB3 HS-PHY.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-pro4-usb2-phy" - for Pro4 SoC
+    "socionext,uniphier-ld11-usb2-phy" - for LD11 SoC
+
+Sub-nodes:
+Each PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+- #phy-cells: Should be 0.
+- reg: The number of the PHY.
+
+Sub-nodes optional properties:
+- vbus-supply: A phandle to the regulator for USB VBUS.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+	soc-glue@5f800000 {
+		...
+		usb-phy {
+			compatible = "socionext,uniphier-ld11-usb2-phy";
+			usb_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			...
+		};
+	};
+
+	usb@5a800100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		...
+		phy-names = "usb";
+		phys = <&usb_phy0>;
+	};
-- 
2.7.4

