Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeCGFEV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 00:04:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:46483 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeCGFEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 00:04:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,434,1515484800";
   d="scan'208";a="36571570"
From: Haiyue Wang <haiyue.wang@linux.intel.com>
To: joel@jms.id.au, andrew@aj.id.au, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS node
Date: Wed,  7 Mar 2018 13:04:50 +0800
Message-Id: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPMI KCS device part of the LPC interface and is used for
communication with the host processor.

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 8eac57c..f443169 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -267,8 +267,40 @@
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				lpc_bmc: lpc-bmc@0 {
-					compatible = "aspeed,ast2500-lpc-bmc";
+					compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
 					reg = <0x0 0x80>;
+					reg-io-width = <4>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0x0 0x0 0x80>;
+
+					kcs1: kcs1@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <1>;
+						kcs_addr = <0x0>;
+						status = "disabled";
+					};
+
+					kcs2: kcs2@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <2>;
+						kcs_addr = <0x0>;
+						status = "disabled";
+					};
+
+					kcs3: kcs3@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <3>;
+						kcs_addr = <0x0>;
+						status = "disabled";
+					};
 				};
 
 				lpc_host: lpc-host@80 {
@@ -294,6 +326,15 @@
 						status = "disabled";
 					};
 
+					kcs4: kcs4@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0xa0>;
+						interrupts = <8>;
+						kcs_chan = <4>;
+						kcs_addr = <0x0>;
+						status = "disabled";
+					};
+
 					lhc: lhc@20 {
 						compatible = "aspeed,ast2500-lhc";
 						reg = <0x20 0x24 0x48 0x8>;
-- 
2.7.4
