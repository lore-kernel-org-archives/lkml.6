Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OPRLnIHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF2BF605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbeFFGHz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:07:55 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:27633 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeFFGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:07:51 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>,
        <mark.rutland@arm.com>
Subject: [PATCH v3 5/6] ARM: dts: Add generic interconnect target module node for MCAN
Date: Wed, 6 Jun 2018 11:38:25 +0530
Message-ID: <20180606060826.14671-6-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606060826.14671-1-faiz_abbas@ti.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti-sysc driver provides support for manipulating the idle modes
and interconnect level resets.

Add the generic interconnect target module node for MCAN to support
the same.

CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index bfc82636999c..5157cc431574 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -11,6 +11,24 @@
 / {
 	compatible = "ti,dra762", "ti,dra7";
 
+	ocp {
+		target-module@42c01900 {
+			compatible = "ti,sysc-dra7-mcan", "ti,sysc";
+			ranges = <0x0 0x42c00000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x42c01900 0x4>,
+			      <0x42c01904 0x4>,
+			      <0x42c01908 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET |
+					 SYSC_DRA7_MCAN_ENAWAKEUP)>;
+			ti,syss-mask = <1>;
+			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
+			clock-names = "fck";
+		};
+	};
+
 };
 
 /* MCAN interrupts are hard-wired to irqs 67, 68 */
-- 
2.17.0
