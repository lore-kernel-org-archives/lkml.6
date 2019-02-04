Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F23DC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161A32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gPv36YFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfBDPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:55:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37316 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfBDPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:55:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14FsFBf070399;
        Mon, 4 Feb 2019 09:54:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549295655;
        bh=6FrKqDbSMoNVkUUaesse/Kx/d9p17JD+XnpCc17GwSU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gPv36YFfM5oWwpjnSmMNmQYTBSYt5NnoLnH/w7WdB7gdqPPT4JK/F29DXdoKQLVmz
         pAnPwdPVv3Ge6cRTgc9nv65D8tARRO7+ITnaHEME5EvAlOLWSQ/5YIrB/WWZaRUQgv
         /BPUqsiBquMAULTdYA50xbhq4uzGoItolKErDqpo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14FsFnF019128
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:54:15 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:54:14 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:54:14 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14Fs1mO012077;
        Mon, 4 Feb 2019 09:54:11 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/4] ARM: dts: dra7: add PRU-ICSS modules
Date:   Mon, 4 Feb 2019 17:53:56 +0200
Message-ID: <1549295637-24890-4-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add the DT nodes for the PRU-ICSS1 and PRU-ICSS2 processor subsystems
that are present on AM57xx family of SoCs. Each PRU-ICSS instance is
represented by a pruss-soc-bus node and a child PRUSS subsystem node.
The two PRU-ICSSs are identical to each other. They are not supported
on DRA7xx SoCs in general, so the nodes are added in disabled state
to the common dra7 DTS file. They should be enabled only in the AM57xx
related board files.

The PRU-ICSSs on AM57xx are very similar to the PRUSS in AM33xx and
AM437x except for variations in the RAM sizes and the number of
interrupts coming into the MPU INTC. The interrupt events into the
PRU-ICSS also requires programming of the corresponding crossbars
properly.

The default names for the firmware images for each PRU core are
defined as follows (these can be adjusted either in derivative
board dts files or through sysfs at runtime if required):
PRU-ICSS1 PRU0 Core: am57xx-pru1_0-fw
PRU-ICSS1 PRU1 Core: am57xx-pru1_1-fw
PRU-ICSS2 PRU0 Core: am57xx-pru2_0-fw
PRU-ICSS2 PRU1 Core: am57xx-pru2_1-fw

Two PRU system events "vring" and "kick" have been added to each
PRU node in each of the PRU-ICSS1 and PRU-ICSS2 remote processor
subsystems to enable the virtio/rpmsg communication between MPU
and that PRU core.

The PRU system events is the preferred approach over using OMAP
mailboxes, as it eliminates an external peripheral access from
the PRU-side, and keeps the interrupt generation internal to the
PRUSS. The difference from MPU would be minimal in using one
versus the other.

Mailboxes can still be used if desired. Either approach would
require that an appropriate firmware image is loaded/booted on
the PRU.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 194 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 2bc9add..2458e7a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -167,6 +167,200 @@
 		l4_per3: interconnect@48800000 {
 		};
 
+		pru_icss1: target-module@4b200000 {
+			compatible = "ti,sysc-pruss", "ti,sysc";
+			reg = <0x4b226000 0x4>,
+			      <0x4b226004 0x4>;
+			reg-names = "rev", "sysc";
+			ti,no-reset-on-init;
+			/* Domains (P, C): coreaon_pwrdm, l4per2_clkdm */
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_PRUSS1_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x4b200000 0x20000000>;
+
+			pruss1: pruss@4b200000 {
+				compatible = "ti,am5728-pruss";
+				reg = <0x0000 0x2000>,
+				      <0x2000 0x2000>,
+				      <0x10000 0x8000>;
+				reg-names = "dram0", "dram1",
+					    "shrdram2";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pruss1_cfg: cfg@26000 {
+					compatible = "syscon";
+					reg = <0x26000 0x2000>;
+				};
+
+				pruss1_iep: iep@2e000 {
+					compatible = "syscon";
+					reg = <0x2e000 0x31c>;
+				};
+
+				pruss1_mii_rt: mii_rt@32000 {
+					compatible = "syscon";
+					reg = <0x32000 0x58>;
+				};
+
+				pruss1_intc: intc@20000 {
+					compatible = "ti,am5728-pruss-intc";
+					reg = <0x20000 0x2000>;
+					reg-names = "intc";
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "host2", "host3", "host4",
+							  "host5", "host6", "host7",
+							  "host8", "host9";
+				};
+
+				pru1_0: pru@34000 {
+					compatible = "ti,am5728-pru";
+					reg = <0x34000 0x3000>,
+					      <0x22000 0x400>,
+					      <0x22400 0x100>;
+					reg-names = "iram", "control", "debug";
+					gpcfg = <&pruss1_cfg 0x8>;
+					firmware-name = "am57xx-pru1_0-fw";
+					interrupt-parent = <&pruss1_intc>;
+					interrupts = <16>, <17>;
+					interrupt-names = "vring", "kick";
+				};
+
+				pru1_1: pru@38000 {
+					compatible = "ti,am5728-pru";
+					reg = <0x38000 0x3000>,
+					      <0x24000 0x400>,
+					      <0x24400 0x100>;
+					reg-names = "iram", "control", "debug";
+					gpcfg = <&pruss1_cfg 0xc>;
+					firmware-name = "am57xx-pru1_1-fw";
+					interrupt-parent = <&pruss1_intc>;
+					interrupts = <18>, <19>;
+					interrupt-names = "vring", "kick";
+				};
+
+				pruss1_mdio: mdio@32400 {
+					compatible = "ti,davinci_mdio";
+					reg = <0x32400 0x90>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&dpll_gmac_h13x2_ck>;
+					clock-names = "fck";
+					bus_freq = <1000000>;
+					status = "disabled";
+				};
+			};
+		};
+
+		pru_icss2: target_module@4b280000 {
+			compatible = "ti,sysc-pruss", "ti,sysc";
+			reg = <0x4b2a6000 0x4>,
+			      <0x4b2a6004 0x4>;
+			reg-names = "rev", "sysc";
+			ti,no-reset-on-init;
+			/* Domains (P, C): coreaon_pwrdm, l4per2_clkdm */
+			clocks = <&l4per2_clkctrl DRA7_L4PER2_PRUSS2_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x4b280000 0x20000000>;
+
+			pruss2: pruss@4b280000 {
+				compatible = "ti,am5728-pruss";
+				reg = <0 0x2000>,
+				      <0x2000 0x2000>,
+				      <0x10000 0x8000>;
+				reg-names = "dram0", "dram1",
+					    "shrdram2";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pruss2_cfg: cfg@26000 {
+					compatible = "syscon";
+					reg = <0x26000 0x2000>;
+				};
+
+				pruss2_iep: iep@2e000 {
+					compatible = "syscon";
+					reg = <0x2e000 0x31c>;
+				};
+
+				pruss2_mii_rt: mii_rt@32000 {
+					compatible = "syscon";
+					reg = <0x32000 0x58>;
+				};
+
+				pruss2_intc: intc@20000 {
+					compatible = "ti,am5728-pruss-intc";
+					reg = <0x20000 0x2000>;
+					reg-names = "intc";
+					interrupt-controller;
+					#interrupt-cells = <1>;
+					interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-names = "host2", "host3", "host4",
+							  "host5", "host6", "host7",
+							  "host8", "host9";
+				};
+
+				pru2_0: pru@34000 {
+					compatible = "ti,am5728-pru";
+					reg = <0x34000 0x3000>,
+					      <0x22000 0x400>,
+					      <0x22400 0x100>;
+					reg-names = "iram", "control", "debug";
+					gpcfg = <&pruss2_cfg 0x8>;
+					firmware-name = "am57xx-pru2_0-fw";
+					interrupt-parent = <&pruss2_intc>;
+					interrupts = <16>, <17>;
+					interrupt-names = "vring", "kick";
+				};
+
+				pru2_1: pru@38000 {
+					compatible = "ti,am5728-pru";
+					reg = <0x38000 0x3000>,
+					      <0x24000 0x400>,
+					      <0x24400 0x100>;
+					reg-names = "iram", "control", "debug";
+					gpcfg = <&pruss2_cfg 0xc>;
+					firmware-name = "am57xx-pru2_1-fw";
+					interrupt-parent = <&pruss2_intc>;
+					interrupts = <18>, <19>;
+					interrupt-names = "vring", "kick";
+				};
+
+				pruss2_mdio: mdio@32400 {
+					compatible = "ti,davinci_mdio";
+					reg = <0x32400 0x90>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					clocks = <&dpll_gmac_h13x2_ck>;
+					clock-names = "fck";
+					bus_freq = <1000000>;
+					status = "disabled";
+				};
+			};
+		};
+
 		axi@0 {
 			compatible = "simple-bus";
 			#size-cells = <1>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

