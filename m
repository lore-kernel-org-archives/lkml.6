Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973520882
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8973520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeGJBO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:14:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:55907 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754572AbeGJBOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:14:25 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Jul 2018 10:14:24 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1B94D60034;
        Tue, 10 Jul 2018 10:14:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 10 Jul 2018 10:14:24 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4C85D1A11BB;
        Tue, 10 Jul 2018 10:14:23 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/2] dt-bindings: reset: uniphier: add USB3 core reset support
Date:   Tue, 10 Jul 2018 10:14:16 +0900
Message-Id: <1531185257-16444-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for reset control of USB3 core implemented in UniPhier SoCs.
The reset control belongs to USB3 glue layer.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/reset/uniphier-reset.txt   | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
index 93efed6..101743d 100644
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -118,3 +118,59 @@ Example:
 
 		other nodes ...
 	};
+
+
+USB3 core reset
+---------------
+
+USB3 core reset belongs to USB3 glue layer. Before using the core reset,
+it is necessary to control the clocks and resets to enable this layer.
+These clocks and resets should be described in each property.
+
+Required properties:
+- compatible: Should be
+    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC
+- #reset-cells: Should be 1.
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
+Example:
+
+	usb-glue@65b00000 {
+		compatible = "socionext,uniphier-ld20-dwc3-glue",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x65b00000 0x400>;
+
+		usb_rst: reset@0 {
+			compatible = "socionext,uniphier-ld20-usb3-reset";
+			reg = <0x0 0x4>;
+			#reset-cells = <1>;
+			clock-names = "link";
+			clocks = <&sys_clk 14>;
+			reset-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		regulator {
+			...
+		};
+
+		phy {
+			...
+		};
+		...
+	};
-- 
2.7.4

