Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDD7C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECE72086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECE72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeKSLWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:22:52 -0500
Received: from mx.socionext.com ([202.248.49.38]:40713 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbeKSLWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:22:51 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Nov 2018 10:00:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 96EFC180111;
        Mon, 19 Nov 2018 10:00:55 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 19 Nov 2018 10:00:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 0BB8840387;
        Mon, 19 Nov 2018 10:00:55 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id DFBBE120455;
        Mon, 19 Nov 2018 10:00:54 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 10/14] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V pinctrl description
Date:   Mon, 19 Nov 2018 10:02:12 +0900
Message-Id: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Milbeaut M10V pinctrl.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../pinctrl/socionext,milbeaut-pinctrl.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
new file mode 100644
index 0000000..7469189
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
@@ -0,0 +1,33 @@
+Milbeaut SoCs pin controller
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
+- reg: offset and length of the register set.
+- reg-names: should be "pinctrl", "exiu".
+- gpio-cells; should be 2.
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
+		clocks = <&dummy_clk>;
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

