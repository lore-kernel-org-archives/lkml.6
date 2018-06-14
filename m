Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31F78C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5589208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5589208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964849AbeFNLCh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:02:37 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:45587 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754945AbeFNLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:02:35 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:34 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 154F17A753;
        Thu, 14 Jun 2018 20:02:34 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282525616"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii1.idc.renesas.com with ESMTP; 14 Jun 2018 20:02:30 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
Date:   Thu, 14 Jun 2018 11:56:31 +0100
Message-Id: <1528973829-25493-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas R9A06G032 SYSCTRL node description.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/clock/renesas,r9a06g032-sysctrl.txt   | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
new file mode 100644
index 0000000..f6cb5e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
@@ -0,0 +1,44 @@
+* Renesas R9A06G032 SYSCTRL
+
+Required Properties:
+
+  - compatible: Must be:
+    - "renesas,r9a06g032-sysctrl"
+  - reg: Base address and length of the SYSCTRL IO block.
+  - #clock-cells: Must be 1
+  - clocks: References to the parent clocks:
+	- external 40mhz crystal.
+	- external (optional) 32.768khz
+	- external (optional) jtag input
+	- external (optional) RGMII_REFCLK
+  - clock-names: Must be:
+        clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+
+Examples
+--------
+
+  - SYSCTRL node:
+
+	sysctrl: system-controller@4000c000 {
+		compatible = "renesas,r9a06g032-sysctrl";
+		reg = <0x4000c000 0x1000>;
+		status = "okay";
+		#clock-cells = <1>;
+
+		clocks = <&ext_mclk>, <&ext_rtc_clk>,
+				<&ext_jtag_clk>, <&ext_rgmii_ref>;
+		clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+	};
+
+  - Other nodes can use the clocks provided by SYSCTRL as in:
+
+	#include <dt-bindings/clock/r9a06g032-sysctrl.h>
+	uart0: serial@40060000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x40060000 0x400>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clocks = <&sysctrl R9A06G032_CLK_UART0>;
+		clock-names = "baudclk";
+	};
-- 
2.7.4

