Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45082082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hf1hOuZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBDOX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:23:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42790 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfBDOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:23:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14EMxu3023115;
        Mon, 4 Feb 2019 08:22:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290179;
        bh=IDKOkzngvCNd5neZHySPALtiWyrf9Lcw0FeR6NFiinU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Hf1hOuZUgU/8fmU0B6HJxUthZuH+Lm5FNtpt+Mofy7+au0IG0OIE/m5bPVs9nLmCn
         dHzFhnREIzMyWsqVUMaf6HBhAK54+2Gwzd8TSCXKmYJl64G2hIhVc0iaMWmnHJ3S+N
         2ESaMC7KbgeP+WWeom8zVGd0C56AIKRXCyRU9gj0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14EMxu8009717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:22:59 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:22:58 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:22:58 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKZ012232;
        Mon, 4 Feb 2019 08:22:55 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date:   Mon, 4 Feb 2019 16:22:34 +0200
Message-ID: <1549290167-876-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

This patch adds the bindings for the Programmable Real-Time Unit
and Industrial Communication Subsystem (PRU-ICSS) present on various
SoCs such as AM33xx, AM437x, AM57xx, Keystone 66AK2G SoC, etc. It is
present on the Davinci based OMAPL138 SoCs and K3 architecture
based AM65x SoCs as well (not covered for now).

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.txt        | 212 +++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
new file mode 100644
index 0000000..5ac76fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
@@ -0,0 +1,212 @@
+PRU-ICSS on TI SoCs
+===================
+
+The Programmable Real-Time Unit and Industrial Communication Subsystem
+(PRU-ICSS) is present on various TI SoCs such as AM335x, AM437x, Keystone
+66AK2G, etc. A PRUSS consists of dual 32-bit RISC cores (Programmable
+Real-Time Units, or PRUs) with program memory and data memory.
+
+The programmable nature of the PRUs provide flexibility to implement
+custom peripheral interfaces, fast real-time responses, or specialized
+data handling. The common peripheral modules include the following,
+
+  - Enhanced GPIO with async capture and serial support
+  - an Ethernet MII_RT module with two MII ports
+  - an MDIO port to control external Ethernet PHYs
+  - an Industrial Ethernet Peripheral (IEP) to manage/generate Industrial
+    Ethernet functions
+  - an Enhanced Capture Module (eCAP)
+  - a 16550-compatible UART to support PROFIBUS
+  - Interrupt controller with 64 input events and 10 Host interrupts.
+
+A shared Data RAM, if present, can be accessed by both the PRU cores. The
+Interrupt Controller (INTC) and a CFG module are common to both the PRU
+cores.
+
+Various sub-modules within a PRU-ICSS subsystem are represented as individual
+nodes.
+
+PRUSS Node
+=============
+
+This node represents the entire ICSS instance and the various modules are
+contained as children. The PRUSS driver is responsible for managing the
+common resources i.e. DRAM0, DRAM1, SHARED_RAM and CFG space.
+
+Required Properties:
+--------------------
+- compatible     : should be one of,
+                       "ti,am3356-pruss" for AM335x family of SoCs
+                       "ti,am4376-pruss" for AM437x family of SoCs
+                       "ti,am5728-pruss" for AM57xx family of SoCs
+                       "ti,k2g-pruss" for 66AK2G family of SoCs
+- reg            : base address and size for each of the Data RAMs as
+                   mentioned in reg-names, and in the same order as the
+                   reg-names
+- reg-names      : should contain a string(s) from among the following names,
+                   each representing a specific Data RAM region. Some PRU-ICSS
+		   instances on certain SoCs might not have Shared DRAM.
+                       "dram0" for Data RAM0,
+                       "dram1" for Data RAM1,
+                       "shrdram2" for Shared Data RAM,
+- #address-cells : should be 1
+- #size-cells    : should be 1
+- ranges         : no specific range translations required, child nodes have the
+                   same address view as the parent, so should be mentioned without
+                   any value for the property
+
+Optional Properties:
+--------------------
+- no-shared-ram	: Should be present if the instance doesn't have Shared RAM.
+		  e.g. AM4376 ICSS0 instance doesn't have Shared RAM.
+
+The PRUSS node will have one or more of the folowing child nodes.
+
+PRU CORES
+=========
+ICSS typically has 2 PRU cores. These should be represented as remoteproc devices.
+
+INTC node
+=========
+ICSS has one INTC interrupt controller module. This should be represented as
+a standard interrupt-controller node.
+
+CFG, IEP, MII_RT
+================
+The individual sub-modules CFG, IEP and MII_RT are represented as a syscon
+node each with specific node names as below:
+                  "cfg" for CFG sub-module,
+                  "iep" for IEP sub-module,
+                  "mii_rt" for MII-RT sub-module,
+
+See Documentation/devicetree/bindings/mfd/syscon.txt for details.
+
+MDIO
+====
+Each PRUSS has an MDIO module that can be used to control external PHYs. The
+MDIO module used within the PRU-ICSS is an instance of the MDIO Controller
+used in TI Davinci SoCs. Please refer to the corresponding binding document,
+Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
+
+Application/User Nodes
+=======================
+A PRU application/user node typically uses one or more PRU device nodes to
+implement a PRU application/functionality. Each application/client node would
+need a reference to at least a PRU node, and optionally pass some configuration
+parameters.
+
+Required Properties:
+--------------------
+- prus                 : phandles to the PRU nodes used
+
+Optional Properties:
+--------------------
+- firmware-name        : firmwares for the PRU cores, the default firmware
+                         for the core from the PRU node will be used if not
+                         provided. The firmware names should correspond to
+                         the PRU cores listed in the 'prus' property
+- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
+                         register for a PRU. This selects the internal muxing
+                         scheme for the PRU instance. If not provided, the
+                         default out-of-reset value (0) for the PRU core is
+                         used. Values should correspond to the PRU cores listed
+                         in the 'prus' property
+- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
+                         with each entry consisting of 4 cell-values. First one
+                         is an index towards the "prus" property to identify the
+                         PRU core for the interrupt map, second is the PRU
+                         System Event id, third is the PRU interrupt channel id
+                         and fourth is the PRU host interrupt id. If provided,
+                         this map will supercede any other configuration
+                         provided through firmware
+
+Example:
+========
+1.	/* AM33xx PRU-ICSS */
+
+	pruss: pruss@0 {
+		compatible = "ti,am3356-pruss";
+		reg = <0x0 0x2000>,
+		      <0x2000 0x2000>,
+		      <0x10000 0x3000>;
+		reg-names = "dram0", "dram1",
+			    "shrdram2";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pruss_cfg: cfg@26000 {
+			compatible = "syscon";
+			reg = <0x26000 0x2000>;
+		};
+
+		pruss_iep: iep@2e000 {
+			compatible = "syscon";
+			reg = <0x2e000 0x31c>;
+		};
+
+		pruss_mii_rt: mii_rt@32000 {
+			compatible = "syscon";
+			reg = <0x32000 0x58>;
+		};
+
+		pruss_intc: intc@20000 {
+			compatible = "ti,am3356-pruss-intc";
+			reg = <0x20000 0x2000>;
+			reg-names = "intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <20 21 22 23 24 25 26 27>;
+			interrupt-names = "host2", "host3", "host4",
+					  "host5", "host6", "host7",
+					  "host8", "host9";
+		};
+
+		pru0: pru@34000 {
+			compatible = "ti,am3356-pru";
+			reg = <0x34000 0x2000>,
+			      <0x22000 0x400>,
+			      <0x22400 0x100>;
+			reg-names = "iram", "control", "debug";
+			gpcfg = <&pruss_cfg 0x8>;
+			firmware-name = "am335x-pru0-fw";
+			interrupt-parent = <&pruss_intc>;
+			interrupts = <16>, <17>;
+			interrupt-names = "vring", "kick";
+		};
+
+		pru1: pru@38000 {
+			compatible = "ti,am3356-pru";
+			reg = <0x38000 0x2000>,
+			      <0x24000 0x400>,
+			      <0x24400 0x100>;
+			reg-names = "iram", "control", "debug";
+			gpcfg = <&pruss_cfg 0xc>;
+			firmware-name = "am335x-pru1-fw";
+			interrupt-parent = <&pruss_intc>;
+			interrupts = <18>, <19>;
+			interrupt-names = "vring", "kick";
+		};
+
+		pruss_mdio: mdio@32400 {
+			compatible = "ti,davinci_mdio";
+			reg = <0x32400 0x90>;
+			clocks = <&dpll_core_m4_ck>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+2:	/* PRU application node example */
+	app_node: app_node {
+		prus = <&pru0>, <&pru1>;
+		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
+		ti,pruss-gp-mux-sel = <2>, <1>;
+		/* setup interrupts for prus:
+		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
+		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
+		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
+	}
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

