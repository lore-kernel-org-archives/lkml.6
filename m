Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9652C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C38208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158757;
	bh=CAzLPxWWN32EN54YWvB/QODbYp8C3fF61Q287fPyn5o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BWaZ5nrK92XJlenWWzHN2AX63Ju79uQgA5NoVt6EtmgLJSLOmq4Q0lxne4LJ1jUeG
	 jWKWzEgwnVUvWvo5/uftAWxqSZuVCRCVs6Uz5uNDnGQjORcmv7R5IFgGZjJAu+esa4
	 45BcHTfvxOecTSGYtLfuVR4jDhZHZ2z5TWyyAZHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfAJWTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:19:13 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbfAJWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so10616834oii.8;
        Thu, 10 Jan 2019 14:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D2g1z6WkrgY1sfIsb0oE2RgWHS34TzlPPoCv0Wj4PO8=;
        b=UrejgYIYWw9JTDliz+VoDsd/MFZAle796KpXcp6f1eYaVwJCPVnDOtQzmUHrfBYT8y
         k17ZpQXetj3XS0KiESl3UD5ts5Qc04fu5Y6k5JjOaAuz7JRCDHNVMh8BriNmrWunmoPs
         Dze04BACvoShehYnErNlH7UBehF/PTV05l5SorPuGZQiLncFICqyASdae61GGzRti4fS
         FKqE/afHT0MRo2xBWpbGan0VboDSqc3Rs3xMSK94K7eFq5nA1YaItPE9txU8ET21nz8N
         j6U5IsS8/dJJKDPeCQqJn2VEIRt/0kwpm54j64Ppw11Ze3ld8uOyxalnVqYdrgn++esH
         zzeQ==
X-Gm-Message-State: AJcUukd+9P1yvlinAqOmXY0ST9SdleI3DbVNBizEvVBJNfv1uZi/FeOh
        WM+CnVh2FHDiseIWM6QexjGv8AI=
X-Google-Smtp-Source: ALg8bN6T2P/lEk/TbSwzHixo0xdYFSMCbLMaYTve8np2DjP0OcDDpXvMUGVTtj5k8hnqGW+OMDtH9w==
X-Received: by 2002:aca:3011:: with SMTP id w17mr7963552oiw.342.1547158749921;
        Thu, 10 Jan 2019 14:19:09 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c19sm36776707otl.16.2019.01.10.14.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:19:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] dt-bindings: interrupt-controller: Convert ARM GICv3 to json-schema
Date:   Thu, 10 Jan 2019 16:19:00 -0600
Message-Id: <20190110221903.3990-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ARM GICv3 binding document to DT schema format using
json-schema.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/arm,gic-v3.txt       | 175 -----------
 .../interrupt-controller/arm,gic-v3.yaml      | 279 ++++++++++++++++++
 2 files changed, 279 insertions(+), 175 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
deleted file mode 100644
index b83bb8249074..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ /dev/null
@@ -1,175 +0,0 @@
-* ARM Generic Interrupt Controller, version 3
-
-AArch64 SMP cores are often associated with a GICv3, providing Private
-Peripheral Interrupts (PPI), Shared Peripheral Interrupts (SPI),
-Software Generated Interrupts (SGI), and Locality-specific Peripheral
-Interrupts (LPI).
-
-Main node required properties:
-
-- compatible : should at least contain  "arm,gic-v3" or either
-		"qcom,msm8996-gic-v3", "arm,gic-v3" for msm8996 SoCs
-		to address SoC specific bugs/quirks
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. Must be a single cell with a value of at least 3.
-  If the system requires describing PPI affinity, then the value must
-  be at least 4.
-
-  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-  interrupts. Other values are reserved for future use.
-
-  The 2nd cell contains the interrupt number for the interrupt type.
-  SPI interrupts are in the range [0-987]. PPI interrupts are in the
-  range [0-15].
-
-  The 3rd cell is the flags, encoded as follows:
-	bits[3:0] trigger type and level flags.
-		1 = edge triggered
-		4 = level triggered
-
-  The 4th cell is a phandle to a node describing a set of CPUs this
-  interrupt is affine to. The interrupt must be a PPI, and the node
-  pointed must be a subnode of the "ppi-partitions" subnode. For
-  interrupt types other than PPI or PPIs that are not partitionned,
-  this cell must be zero. See the "ppi-partitions" node description
-  below.
-
-  Cells 5 and beyond are reserved for future use and must have a value
-  of 0 if present.
-
-- reg : Specifies base physical address(s) and size of the GIC
-  registers, in the following order:
-  - GIC Distributor interface (GICD)
-  - GIC Redistributors (GICR), one range per redistributor region
-  - GIC CPU interface (GICC)
-  - GIC Hypervisor interface (GICH)
-  - GIC Virtual CPU interface (GICV)
-
-  GICC, GICH and GICV are optional.
-
-- interrupts : Interrupt source of the VGIC maintenance interrupt.
-
-Optional
-
-- redistributor-stride : If using padding pages, specifies the stride
-  of consecutive redistributors. Must be a multiple of 64kB.
-
-- #redistributor-regions: The number of independent contiguous regions
-  occupied by the redistributors. Required if more than one such
-  region is present.
-
-- msi-controller: Boolean property. Identifies the node as an MSI
-  controller. Only present if the Message Based Interrupt
-  functionnality is being exposed by the HW, and the mbi-ranges
-  property present.
-
-- mbi-ranges: A list of pairs <intid span>, where "intid" is the first
-  SPI of a range that can be used an MBI, and "span" the size of that
-  range. Multiple ranges can be provided. Requires "msi-controller" to
-  be set.
-
-- mbi-alias: Address property. Base address of an alias of the GICD
-  region containing only the {SET,CLR}SPI registers to be used if
-  isolation is required, and if supported by the HW.
-
-Sub-nodes:
-
-PPI affinity can be expressed as a single "ppi-partitions" node,
-containing a set of sub-nodes, each with the following property:
-- affinity: Should be a list of phandles to CPU nodes (as described in
-Documentation/devicetree/bindings/arm/cpus.txt).
-
-GICv3 has one or more Interrupt Translation Services (ITS) that are
-used to route Message Signalled Interrupts (MSI) to the CPUs.
-
-These nodes must have the following properties:
-- compatible : Should at least contain  "arm,gic-v3-its".
-- msi-controller : Boolean property. Identifies the node as an MSI controller
-- #msi-cells: Must be <1>. The single msi-cell is the DeviceID of the device
-  which will generate the MSI.
-- reg: Specifies the base physical address and size of the ITS
-  registers.
-
-Optional:
-- socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
-  address and size of the pre-ITS window.
-
-The main GIC node must contain the appropriate #address-cells,
-#size-cells and ranges properties for the reg property of all ITS
-nodes.
-
-Examples:
-
-	gic: interrupt-controller@2cf00000 {
-		compatible = "arm,gic-v3";
-		#interrupt-cells = <3>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		interrupt-controller;
-		reg = <0x0 0x2f000000 0 0x10000>,	// GICD
-		      <0x0 0x2f100000 0 0x200000>,	// GICR
-		      <0x0 0x2c000000 0 0x2000>,	// GICC
-		      <0x0 0x2c010000 0 0x2000>,	// GICH
-		      <0x0 0x2c020000 0 0x2000>;	// GICV
-		interrupts = <1 9 4>;
-
-		msi-controller;
-		mbi-ranges = <256 128>;
-
-		gic-its@2c200000 {
-			compatible = "arm,gic-v3-its";
-			msi-controller;
-			#msi-cells = <1>;
-			reg = <0x0 0x2c200000 0 0x20000>;
-		};
-	};
-
-	gic: interrupt-controller@2c010000 {
-		compatible = "arm,gic-v3";
-		#interrupt-cells = <4>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		interrupt-controller;
-		redistributor-stride = <0x0 0x40000>;	// 256kB stride
-		#redistributor-regions = <2>;
-		reg = <0x0 0x2c010000 0 0x10000>,	// GICD
-		      <0x0 0x2d000000 0 0x800000>,	// GICR 1: CPUs 0-31
-		      <0x0 0x2e000000 0 0x800000>;	// GICR 2: CPUs 32-63
-		      <0x0 0x2c040000 0 0x2000>,	// GICC
-		      <0x0 0x2c060000 0 0x2000>,	// GICH
-		      <0x0 0x2c080000 0 0x2000>;	// GICV
-		interrupts = <1 9 4>;
-
-		gic-its@2c200000 {
-			compatible = "arm,gic-v3-its";
-			msi-controller;
-			#msi-cells = <1>;
-			reg = <0x0 0x2c200000 0 0x20000>;
-		};
-
-		gic-its@2c400000 {
-			compatible = "arm,gic-v3-its";
-			msi-controller;
-			#msi-cells = <1>;
-			reg = <0x0 0x2c400000 0 0x20000>;
-		};
-
-		ppi-partitions {
-			part0: interrupt-partition-0 {
-				affinity = <&cpu0 &cpu2>;
-			};
-
-			part1: interrupt-partition-1 {
-				affinity = <&cpu1 &cpu3>;
-			};
-		};
-	};
-
-
-	device@0 {
-		reg = <0 0 0 4>;
-		interrupts = <1 1 4 &part0>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
new file mode 100644
index 000000000000..c34df35a25fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -0,0 +1,279 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Generic Interrupt Controller, version 3
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+
+description: |
+  AArch64 SMP cores are often associated with a GICv3, providing Private
+  Peripheral Interrupts (PPI), Shared Peripheral Interrupts (SPI),
+  Software Generated Interrupts (SGI), and Locality-specific Peripheral
+  Interrupts (LPI).
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,msm8996-gic-v3
+          - const: arm,gic-v3
+      - const: arm,gic-v3
+
+  interrupt-controller: true
+
+  "#address-cells":
+    enum: [ 0, 1, 2 ]
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  "#interrupt-cells":
+    description: |
+      Specifies the number of cells needed to encode an interrupt source.
+      Must be a single cell with a value of at least 3.
+      If the system requires describing PPI affinity, then the value must
+      be at least 4.
+
+      The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
+      interrupts. Other values are reserved for future use.
+
+      The 2nd cell contains the interrupt number for the interrupt type.
+      SPI interrupts are in the range [0-987]. PPI interrupts are in the
+      range [0-15].
+
+      The 3rd cell is the flags, encoded as follows:
+      bits[3:0] trigger type and level flags.
+        1 = edge triggered
+        4 = level triggered
+
+      The 4th cell is a phandle to a node describing a set of CPUs this
+      interrupt is affine to. The interrupt must be a PPI, and the node
+      pointed must be a subnode of the "ppi-partitions" subnode. For
+      interrupt types other than PPI or PPIs that are not partitionned,
+      this cell must be zero. See the "ppi-partitions" node description
+      below.
+
+      Cells 5 and beyond are reserved for future use and must have a value
+      of 0 if present.
+    enum: [ 3, 4 ]
+
+  reg:
+    description: |
+      Specifies base physical address(s) and size of the GIC
+      registers, in the following order:
+      - GIC Distributor interface (GICD)
+      - GIC Redistributors (GICR), one range per redistributor region
+      - GIC CPU interface (GICC)
+      - GIC Hypervisor interface (GICH)
+      - GIC Virtual CPU interface (GICV)
+
+      GICC, GICH and GICV are optional.
+    minItems: 2
+    maxItems: 4096   # Should be enough?
+
+  interrupts:
+    description:
+      Interrupt source of the VGIC maintenance interrupt.
+    maxItems: 1
+
+  redistributor-stride:
+    description:
+      If using padding pages, specifies the stride of consecutive
+      redistributors. Must be a multiple of 64kB.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint64
+      - multipleOf: 0x10000
+        exclusiveMinimum: 0
+
+  "#redistributor-regions":
+    description:
+      The number of independent contiguous regions occupied by the
+      redistributors. Required if more than one such region is present.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maximum: 4096   # Should be enough?
+
+  msi-controller:
+    description:
+      Only present if the Message Based Interrupt functionnality is
+      being exposed by the HW, and the mbi-ranges property present.
+
+  mbi-ranges:
+    description:
+      A list of pairs <intid span>, where "intid" is the first SPI of a range
+      that can be used an MBI, and "span" the size of that range. Multiple
+      ranges can be provided.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-matrix
+      - items:
+          minItems: 2
+          maxItems: 2
+
+  mbi-alias:
+    description:
+      Address property. Base address of an alias of the GICD region containing
+      only the {SET,CLR}SPI registers to be used if isolation is required,
+      and if supported by the HW.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - items:
+          minItems: 1
+          maxItems: 2
+
+  ppi-partitions:
+    type: object
+    description:
+      PPI affinity can be expressed as a single "ppi-partitions" node,
+      containing a set of sub-nodes.
+    patternProperties:
+      "^interrupt-partition-[0-9]+$":
+        properties:
+          affinity:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              Should be a list of phandles to CPU nodes (as described in
+              Documentation/devicetree/bindings/arm/cpus.yaml).
+
+        required:
+          - affinity
+
+dependencies:
+  mbi-ranges: [ msi-controller ]
+  msi-controller: [ mbi-ranges ]
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+patternProperties:
+  "^gic-its@": false
+  "^interrupt-controller@[0-9a-f]+$": false
+  # msi-controller is preferred, but allow other names
+  "^(msi-controller|gic-its|interrupt-controller)@[0-9a-f]+$":
+    type: object
+    description:
+      GICv3 has one or more Interrupt Translation Services (ITS) that are
+      used to route Message Signalled Interrupts (MSI) to the CPUs.
+    properties:
+      compatible:
+        const: arm,gic-v3-its
+
+      msi-controller: true
+
+      "#msi-cells":
+        description:
+          The single msi-cell is the DeviceID of the device which will generate
+          the MSI.
+        const: 1
+
+      reg:
+        description:
+          Specifies the base physical address and size of the ITS registers.
+        maxItems: 1
+
+      socionext,synquacer-pre-its:
+        description:
+          (u32, u32) tuple describing the untranslated
+          address and size of the pre-ITS window.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+          - items:
+              minItems: 2
+              maxItems: 2
+
+    required:
+      - compatible
+      - msi-controller
+      - "#msi-cells"
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    gic: interrupt-controller@2cf00000 {
+      compatible = "arm,gic-v3";
+      #interrupt-cells = <3>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      interrupt-controller;
+      reg = <0x2f000000 0x10000>,  // GICD
+            <0x2f100000 0x200000>,  // GICR
+            <0x2c000000 0x2000>,  // GICC
+            <0x2c010000 0x2000>,  // GICH
+            <0x2c020000 0x2000>;  // GICV
+      interrupts = <1 9 4>;
+
+      msi-controller;
+      mbi-ranges = <256 128>;
+
+      msi-controller@2c200000 {
+        compatible = "arm,gic-v3-its";
+        msi-controller;
+        #msi-cells = <1>;
+        reg = <0x2c200000 0x20000>;
+      };
+    };
+
+    interrupt-controller@2c010000 {
+      compatible = "arm,gic-v3";
+      #interrupt-cells = <4>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      interrupt-controller;
+      redistributor-stride = <0x0 0x40000>;  // 256kB stride
+      #redistributor-regions = <2>;
+      reg = <0x2c010000 0x10000>,  // GICD
+            <0x2d000000 0x800000>,  // GICR 1: CPUs 0-31
+            <0x2e000000 0x800000>,  // GICR 2: CPUs 32-63
+            <0x2c040000 0x2000>,  // GICC
+            <0x2c060000 0x2000>,  // GICH
+            <0x2c080000 0x2000>;  // GICV
+      interrupts = <1 9 4>;
+
+      msi-controller@2c200000 {
+        compatible = "arm,gic-v3-its";
+        msi-controller;
+        #msi-cells = <1>;
+        reg = <0x2c200000 0x20000>;
+      };
+
+      msi-controller@2c400000 {
+        compatible = "arm,gic-v3-its";
+        msi-controller;
+        #msi-cells = <1>;
+        reg = <0x2c400000 0x20000>;
+      };
+
+      ppi-partitions {
+        part0: interrupt-partition-0 {
+          affinity = <&cpu0 &cpu2>;
+        };
+
+        part1: interrupt-partition-1 {
+          affinity = <&cpu1 &cpu3>;
+        };
+      };
+    };
+
+
+    device@0 {
+      reg = <0 4>;
+      interrupts = <1 1 4 &part0>;
+    };
+
+...
-- 
2.19.1

