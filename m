Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeBTPf7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:35:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:6051 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752402AbeBTPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:35:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="202450127"
From: Graham Moore <graham.moore@linux.intel.com>
To: Graham Moore <graham.moore@linux.intel.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: stratix10: Add PL330 DMAC to Stratix10 dts
Date: Tue, 20 Feb 2018 09:38:47 -0600
Message-Id: <1519141127-22038-1-git-send-email-graham.moore@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Stratix10 SoCFPGA uses the PL330 DMAC.  This patch adds the PL330
DMAC to the Stratix10 device tree.

Signed-off-by: Graham Moore <graham.moore@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index aa4080d..0666c0f 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -711,6 +711,25 @@
 			reg = <0xffe00000 0x100000>;
 		};
 
+		pdma: pdma@ffda0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xffda0000 0x1000>;
+			interrupts = <0 81 4>,
+				     <0 82 4>,
+				     <0 83 4>,
+				     <0 84 4>,
+				     <0 85 4>,
+				     <0 86 4>,
+				     <0 87 4>,
+				     <0 88 4>,
+				     <0 89 4>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&l4_main_clk>;
+			clock-names = "apb_pclk";
+		};
+
 		rst: rstmgr@ffd11000 {
 			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
-- 
2.7.4
