Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A48C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2798213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2798213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJDFQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:16:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:58241 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeJDFQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:16:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="88962352"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by orsmga003.jf.intel.com with ESMTP; 03 Oct 2018 15:25:56 -0700
From:   thor.thayer@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        aisheng.dong@nxp.com, sboyd@kernel.org
Cc:     vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3 1/2] arm64: dts: stratix10: Add Stratix10 SMMU support
Date:   Wed,  3 Oct 2018 17:28:12 -0500
Message-Id: <1538605693-22073-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add SMMU support to the Stratix10 Device Tree which
includes adding the SMMU node and adding IOMMU stream
ids to the SMMU peripherals.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 42c411dd35b9..aa870a768996 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -137,6 +137,7 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
 			clock-names = "stmmaceth";
+			iommus = <&smmu 1>;
 			status = "disabled";
 		};
 
@@ -150,6 +151,7 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
 			clock-names = "stmmaceth";
+			iommus = <&smmu 2>;
 			status = "disabled";
 		};
 
@@ -163,6 +165,7 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
 			clock-names = "stmmaceth";
+			iommus = <&smmu 3>;
 			status = "disabled";
 		};
 
@@ -273,6 +276,7 @@
 			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
 				 <&clkmgr STRATIX10_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
+			iommus = <&smmu 5>;
 			status = "disabled";
 		};
 
@@ -307,6 +311,28 @@
 			altr,modrst-offset = <0x20>;
 		};
 
+		smmu: iommu@fa000000 {
+			compatible = "arm,mmu-500", "arm,smmu-v2";
+			reg = <0xfa000000 0x40000>;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 128 4>,	/* Global Secure Fault */
+				<0 129 4>, /* Global Non-secure Fault */
+				/* Non-secure Context Interrupts (32) */
+				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
+				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
+				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
+				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
+				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
+				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
+				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
+				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
+			stream-match-mask = <0x7ff0>;
+			status = "disabled";
+		};
+
 		spi0: spi@ffda4000 {
 			compatible = "snps,dw-apb-ssi";
 			#address-cells = <1>;
@@ -416,6 +442,7 @@
 			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			iommus = <&smmu 6>;
 			status = "disabled";
 		};
 
@@ -428,6 +455,7 @@
 			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			iommus = <&smmu 7>;
 			status = "disabled";
 		};
 
-- 
2.7.4

