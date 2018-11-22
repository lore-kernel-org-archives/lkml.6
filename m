Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B965620672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="auFUCrtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B965620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394956AbeKVWTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:19:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50472 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391015AbeKVWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:19:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBeJ3C075929;
        Thu, 22 Nov 2018 05:40:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886819;
        bh=+7/cMm9B5ZwcvkaBZi3/Dsf+EeZ6IItk2wxzfBZ9GO0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=auFUCrtNiJFuygz9/nuuq6oVApTCrT5o6tuHCFsemqDpc2t9buPLciBMeOMHHg3Ec
         qIkVWo/4vqdbW+PpUZTQrKj1+G7/Zr+BMkin/S70YmkFt9mxXm4EpPq+zHKLdlnAsm
         1FNXb1vqKOj9DOIJ/OwgmXPdAxzALvOw/Pmabvw0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBeJ1s077516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:40:19 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:40:19 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:40:19 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBeJG2012012;
        Thu, 22 Nov 2018 05:40:19 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDfE013203;
        Thu, 22 Nov 2018 05:40:15 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 15/17] ARM: dts: AM33xx: Add the PRU-ICSS DT nodes
Date:   Thu, 22 Nov 2018 13:39:11 +0200
Message-ID: <1542886753-17625-16-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add the DT nodes for the PRU-ICSS on AM33xx family of SoCs. The
AM33xx SoCs contain a single PRU-ICSS instance and is represented
by the pruss-soc-bus node and a child PRUSS node. PRU-ICSS is not
supported on AM3352 SoC though in the AM33xx family, so the nodes
are added in disabled state to the common am33xx dtsi file. They
should be enabled in only those derivative board files that use
a SoC containing PRU-ICSS.

The PRUSS subsystem node contains the entire address space and
the various interrupts generated towards the main MPU. The various
sub-modules of the PRU-ICSS are represented as individual child
nodes (so platform devices themselves) of the PRUSS subsystem node.
These include the two PRU cores and the interrupt controller. The
Industrial Ethernet Peripheral (IEP), the Real Time Media Independent
Interface controller (MII_RT), and the CFG sub-module are represented
as syscon nodes. All the Data RAMs are represented within a child
node of its own named 'memories' without any compatible.

The DT nodes use all standard properties. The regs property in
the PRU nodes define the addresses for the Instruction RAM, the
Debug and Control sub-modules for that PRU core. The firmware for
each PRU core is defined through a 'firmware-name' property.

The default names for the firmware images for each PRU core are
defined as follows (these can be adjusted either in derivative
board dts files or through sysfs at runtime if required):
     PRU-ICSS PRU0 Core: am335x-pru1_0-fw
     PRU-ICSS PRU1 Core: am335x-pru1_1-fw

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d3dd6a1..ce42cd9 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -924,6 +924,78 @@
 			};
 		};
 
+		pruss_soc_bus: pruss_soc_bus@4a326004 {
+			compatible = "ti,am3356-pruss-soc-bus";
+			reg = <0x4a326004 0x4>;
+			ti,hwmods = "pruss";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			pruss: pruss@4a300000 {
+				compatible = "ti,am3356-pruss";
+				reg = <0x4a300000 0x80000>;
+				interrupts = <20 21 22 23 24 25 26 27>;
+				interrupt-names = "host2", "host3", "host4",
+						  "host5", "host6", "host7",
+						  "host8", "host9";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				status = "disabled";
+
+				pruss_mem: memories@4a300000 {
+					reg = <0x4a300000 0x2000>,
+					      <0x4a302000 0x2000>,
+					      <0x4a310000 0x3000>;
+					reg-names = "dram0", "dram1",
+						    "shrdram2";
+				};
+
+				pruss_cfg: cfg@4a326000 {
+					compatible = "syscon";
+					reg = <0x4a326000 0x2000>;
+				};
+
+				pruss_iep: iep@4a32e000 {
+					compatible = "syscon";
+					reg = <0x4a32e000 0x31c>;
+				};
+
+				pruss_mii_rt: mii_rt@4a332000 {
+					compatible = "syscon";
+					reg = <0x4a332000 0x58>;
+				};
+
+				pruss_intc: intc@4a320000 {
+					compatible = "ti,am3356-pruss-intc";
+					reg = <0x4a320000 0x2000>;
+					reg-names = "intc";
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
+
+				pru0: pru@4a334000 {
+					compatible = "ti,am3356-pru";
+					reg = <0x4a334000 0x2000>,
+					      <0x4a322000 0x400>,
+					      <0x4a322400 0x100>;
+					reg-names = "iram", "control", "debug";
+					firmware-name = "am335x-pru0-fw";
+				};
+
+				pru1: pru@4a338000 {
+					compatible = "ti,am3356-pru";
+					reg = <0x4a338000 0x2000>,
+					      <0x4a324000 0x400>,
+					      <0x4a324400 0x100>;
+					reg-names = "iram", "control", "debug";
+					firmware-name = "am335x-pru1-fw";
+				};
+			};
+		};
+
 		elm: elm@48080000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48080000 0x2000>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

