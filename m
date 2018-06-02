Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeFBA4l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 20:56:41 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33684 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeFBA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 20:56:30 -0400
X-Google-Smtp-Source: ADUXVKLvoszPURDG/myPQHxqqMqf4V7NZVW3BsQALclDegAeGNOJ9upHo6+YO7xY5hDXTEVwi54u8w==
From: Ray Jui <ray.jui@broadcom.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 3/3] arm64: dts: Update Stingray clock DT nodes
Date: Fri,  1 Jun 2018 17:56:08 -0700
Message-Id: <1527900968-12017-4-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527900968-12017-1-git-send-email-ray.jui@broadcom.com>
References: <1527900968-12017-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Update clock output names in the Stingray clock DT nodes so they match
the binding document and the latest ASIC datasheet. Also add entries
for LCPLL2

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
index 3a4d452..10a106a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
@@ -52,12 +52,24 @@
 			reg = <0x0001d104 0x32>,
 			      <0x0001c854 0x4>;
 			clocks = <&osc>;
-			clock-output-names = "genpll0", "clk_125", "clk_scr",
+			clock-output-names = "genpll0", "clk_125m", "clk_scr",
 					     "clk_250", "clk_pcie_axi",
 					     "clk_paxc_axi_x2",
 					     "clk_paxc_axi";
 		};
 
+		genpll2: genpll2@1d1ac {
+			#clock-cells = <1>;
+			compatible = "brcm,sr-genpll2";
+			reg = <0x0001d1ac 0x32>,
+			      <0x0001c854 0x4>;
+			clocks = <&osc>;
+			clock-output-names = "genpll2", "clk_nic",
+					     "clk_ts_500_ref", "clk_125_nitro",
+					     "clk_chimp", "clk_nic_flash",
+					     "clk_fs";
+		};
+
 		genpll3: genpll3@1d1e0 {
 			#clock-cells = <1>;
 			compatible = "brcm,sr-genpll3";
@@ -75,8 +87,8 @@
 			      <0x0001c854 0x4>;
 			clocks = <&osc>;
 			clock-output-names = "genpll4", "clk_ccn",
-					     "clk_tpiu_pll", "noc_clk",
-					     "pll_chclk_fs4",
+					     "clk_tpiu_pll", "clk_noc",
+					     "clk_chclk_fs4",
 					     "clk_bridge_fscpu";
 		};
 
@@ -86,8 +98,8 @@
 			reg = <0x0001d248 0x32>,
 			      <0x0001c870 0x4>;
 			clocks = <&osc>;
-			clock-output-names = "genpll5", "fs4_hf_clk",
-					     "crypto_ae_clk", "raid_ae_clk";
+			clock-output-names = "genpll5", "clk_fs4_hf",
+					     "clk_crypto_ae", "clk_raid_ae";
 		};
 
 		lcpll0: lcpll0@1d0c4 {
@@ -107,9 +119,9 @@
 			reg = <0x0001d138 0x3c>,
 			      <0x0001c870 0x4>;
 			clocks = <&osc>;
-			clock-output-names = "lcpll1", "clk_wanpn",
+			clock-output-names = "lcpll1", "clk_wan",
 					     "clk_usb_ref",
-					     "timesync_evt_clk";
+					     "clk_crmu_ts";
 		};
 
 		hsls_clk: hsls_clk {
-- 
2.1.4
