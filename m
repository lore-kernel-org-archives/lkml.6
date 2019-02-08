Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2BC2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBHMcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:32:25 -0500
Received: from mx.socionext.com ([202.248.49.38]:27866 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfBHMcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:32:25 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:32:23 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 26F8560062;
        Fri,  8 Feb 2019 21:32:23 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:32:23 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id E6D174036D;
        Fri,  8 Feb 2019 21:32:22 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id CDC701202F1;
        Fri,  8 Feb 2019 21:32:22 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 11/15] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V pinctrl description
Date:   Fri,  8 Feb 2019 21:33:07 +0900
Message-Id: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Milbeaut M10V pinctrl.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../pinctrl/socionext,milbeaut-pinctrl.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
new file mode 100644
index 0000000..6b54191
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
@@ -0,0 +1,35 @@
+Milbeaut SoCs pin controller
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
+- reg: offset and length of the register set.
+- reg-names: should be "pinctrl", "exiu".
+- gpio-controller: marks the device node as a gpio controller.
+- gpio-cells: should be 2.
+- interrupt-controller: marks the device node as a interrupt controller.
+- interrupt-cells: should be 2.
+- clocks: phandle to the input clock.
+- interrupts: three interrupts specifer.
+- interrupt-names: corresponds "interrupts" factor.
+
+Example:
+	pinctrl: pinctrl@1d022000 {
+		compatible = "socionext,milbeaut-m10v-pinctrl";
+		reg = <0x1d022000 0x1000>,
+			<0x1c26f000 0x1000>;
+		reg-names = "pinctrl", "exiu";
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&clk 2>;
+		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
+				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
+				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
+				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
+		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
+				"pin-52", "pin-53", "pin-54", "pin-55",
+				"pin-56", "pin-57", "pin-58", "pin-59",
+				"pin-60", "pin-61", "pin-62", "pin-63";
+	}
-- 
1.9.1

