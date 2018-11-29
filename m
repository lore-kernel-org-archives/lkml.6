Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50121C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09F920673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XT6UNw3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09F920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeK3KQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43698 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeK3KQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543532960; x=1575068960;
  h=from:to:subject:date:message-id:in-reply-to:references;
  bh=i7g213jXuExf9WQ9ppjwE4Ycti2qAbTHczLIWdNAD5A=;
  b=XT6UNw3P/7Gthw9vLl/XwyKOhRC0dR93fenTtXpsJ1kBEhzAV7shDRcN
   DqSRh4fvsPZsbQ3dknSlr2whA1qSwAL246t8N++AqnMSCWU/wpRFC7e1d
   UAQfx0uqvimJp71fNf5Ir3+YEDPfIAcS6ka6SI88wF8MTJOi6bTYaHG+R
   rT8wUpEEmRjEl7Lm/M3BnKOxvROQ9qzVivCFfWg40lSsHqMIMG9aTddDg
   0Qvw9L9zXmtWL6kRexj1NrRhC4Q4VdhWvUAyq29hFnYTnFW+UC1vx3njc
   ViKVoCiG8Pz0iP0NyDUtQn9ipbQvdKvqMccH4z3Dt4iNHhAZLBTkQMD+V
   g==;
X-IronPort-AV: E=Sophos;i="5.56,296,1539619200"; 
   d="scan'208";a="97183855"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 07:09:18 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Nov 2018 14:52:14 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 15:09:19 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [RFT PATCH 2/4] dt-binding: cpu-topology: Move cpu-map to a common binding.
Date:   Thu, 29 Nov 2018 15:09:15 -0800
Message-Id: <1543532957-22661-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543532957-22661-1-git-send-email-atish.patra@wdc.com>
References: <1543532957-22661-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu-map binding can be used to described cpu topology for both
RISC-V & ARM. It makes more sense to move the binding to document
to a common place.

The relevant discussion can be found here.
https://lkml.org/lkml/2018/11/6/19

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
 1 file changed, 67 insertions(+), 14 deletions(-)
 rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
similarity index 86%
rename from Documentation/devicetree/bindings/arm/topology.txt
rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
index 66848355..1de6fbce 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
@@ -1,12 +1,12 @@
 ===========================================
-ARM topology binding description
+CPU topology binding description
 ===========================================
 
 ===========================================
 1 - Introduction
 ===========================================
 
-In an ARM system, the hierarchy of CPUs is defined through three entities that
+In a SMP system, the hierarchy of CPUs is defined through three entities that
 are used to describe the layout of physical CPUs in the system:
 
 - socket
@@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
 - core
 - thread
 
-The cpu nodes (bindings defined in [1]) represent the devices that
-correspond to physical CPUs and are to be mapped to the hierarchy levels.
-
 The bottom hierarchy level sits at core or thread level depending on whether
 symmetric multi-threading (SMT) is supported or not.
 
@@ -25,33 +22,37 @@ threads existing in the system and map to the hierarchy level "thread" above.
 In systems where SMT is not supported "cpu" nodes represent all cores present
 in the system and map to the hierarchy level "core" above.
 
-ARM topology bindings allow one to associate cpu nodes with hierarchical groups
+CPU topology bindings allow one to associate cpu nodes with hierarchical groups
 corresponding to the system hierarchy; syntactically they are defined as device
 tree nodes.
 
-The remainder of this document provides the topology bindings for ARM, based
-on the Devicetree Specification, available from:
+Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
+used for any other architecture as well.
 
-https://www.devicetree.org/specifications/
+The remainder of this document provides the topology bindings for ARM/RISC-V, based
+on the Devicetree Specification, available at [4].
+
+The cpu nodes (bindings defined in [1] for ARM or [2] for RISC-V) represent the devices that
+correspond to physical CPUs and are to be mapped to the hierarchy levels.
 
 If not stated otherwise, whenever a reference to a cpu node phandle is made its
 value must point to a cpu node compliant with the cpu node bindings as
-documented in [1].
+documented in [1] or [3] for respective ISA.
 A topology description containing phandles to cpu nodes that are not compliant
-with bindings standardized in [1] is therefore considered invalid.
+with bindings standardized in [1] or [3] is therefore considered invalid.
 
 ===========================================
 2 - cpu-map node
 ===========================================
 
-The ARM CPU topology is defined within the cpu-map node, which is a direct
+The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
 child of the cpus node and provides a container where the actual topology
 nodes are listed.
 
 - cpu-map node
 
-	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
-			  ARM uniprocessor systems do not require a topology
+	Usage: Optional - On SMP systems provide CPUs topology to the OS.
+			  Uniprocessor systems do not require a topology
 			  description and therefore should not define a
 			  cpu-map node.
 
@@ -494,8 +495,60 @@ cpus {
 	};
 };
 
+Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
+
+cpus {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "sifive,fu540g", "sifive,fu500";
+	model = "sifive,hifive-unleashed-a00";
+
+	...
+
+	cpu-map {
+		cluster0 {
+			core0 {
+				cpu = <&L12>;
+		 	};
+			core1 {
+				cpu = <&L15>;
+			};
+			core2 {
+				cpu0 = <&L18>;
+			};
+			core3 {
+				cpu0 = <&L21>;
+			};
+		};
+ 	};
+
+	L12: cpu@1 {
+		device_type = "cpu";
+		compatible = "sifive,rocket0", "riscv";
+		reg = <0x1>;
+	}
+
+	L15: cpu@2 {
+		device_type = "cpu";
+		compatible = "sifive,rocket0", "riscv";
+		reg = <0x2>;
+	}
+	L18: cpu@3 {
+		device_type = "cpu";
+		compatible = "sifive,rocket0", "riscv";
+		reg = <0x3>;
+	}
+	L21: cpu@4 {
+		device_type = "cpu";
+		compatible = "sifive,rocket0", "riscv";
+		reg = <0x4>;
+	}
+};
 ===============================================================================
 [1] ARM Linux kernel documentation
     Documentation/devicetree/bindings/arm/cpus.txt
 [2] Devicetree NUMA binding description
     Documentation/devicetree/bindings/numa.txt
+[3] RISC-V Linux kernel documentation
+    Documentation/devicetree/bindings/riscv/cpus.txt
+[4] https://www.devicetree.org/specifications/
-- 
2.7.4

