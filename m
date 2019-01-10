Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E03BC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67AC213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158752;
	bh=MY2n0LCGJ3loLRt6T3jo4Gbf1lnb+ExTLfrzfHEU7Jk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rcVb6k+yMkqQs/qma0rpohMS1rHdHpbEN4Ko9XSKkE2XrqmxBdEiJ0P+rLoGaCKfo
	 x9ppgLJrlojiQlwWIzRkgyaJ/5dbB+NOQne6OKzkocGeCM+v45F2M/F4asf+jkZ4mS
	 iz1jh7Ibk07a48td/6wp16f98O+4J0Gog1oqj43s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfAJWTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:19:11 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45905 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfAJWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id y1so10604700oie.12;
        Thu, 10 Jan 2019 14:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6rEDZHQfkLDLG2fw3CpEJQVRilD3bhc2OAgpl+nmGs=;
        b=tIXmHRH+uCFxsL1J32iBvACy9Ctw0Xan6sf2hM2ZXLN39JWRgJ77VS33Nu4wrwxtRw
         iflTT0spsfW+pZmh0GdOxVWy8R+N2pa0GZzdVnMvToDtRFjLqDYnB5xRuFOO1OKqHlUI
         aBMCD0AzWPfZxY5jGF+b5yV4TDhCvYL0n9UfN33BJMtxTIiQSrAV849AXQlcEEZ1T3z5
         wKqOiZ1/VSJLGseCe7x40NIRkZhRDym9J6Q4QpVqHcU9GWxSfJzC9GBHuNcKW8feutpf
         CAiMXDCP7fmsyoH7Q9FfH1Cjc8lAKU6i2vyjK7MbI49rQvb31WvTL7OJyAikdgFPUsDQ
         YMAQ==
X-Gm-Message-State: AJcUuke7B5lxw877RGN5WBjvbKQn5sWyMkqjhboToOztgjOTUj8xPPPv
        rOpBcL1E83Q5pOKskE/sEInPxWY=
X-Google-Smtp-Source: ALg8bN5FLTgSeNmAv1dmrNv9rFeWe5nuxvRzuDOq8YZTKTSzlr4KDwadRoWx0do1Ra3GEV9kYEequA==
X-Received: by 2002:a54:450f:: with SMTP id l15mr8007899oil.351.1547158748346;
        Thu, 10 Jan 2019 14:19:08 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c19sm36776707otl.16.2019.01.10.14.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:19:05 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] dt-bindings: interrupt-controller: Convert ARM GIC to json-schema
Date:   Thu, 10 Jan 2019 16:18:59 -0600
Message-Id: <20190110221903.3990-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ARM GIC binding document to DT schema format using
json-schema.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/arm,gic.txt | 171 --------------
 .../interrupt-controller/arm,gic.yaml         | 223 ++++++++++++++++++
 2 files changed, 223 insertions(+), 171 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
deleted file mode 100644
index 2f3244648646..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
+++ /dev/null
@@ -1,171 +0,0 @@
-* ARM Generic Interrupt Controller
-
-ARM SMP cores are often associated with a GIC, providing per processor
-interrupts (PPI), shared processor interrupts (SPI) and software
-generated interrupts (SGI).
-
-Primary GIC is attached directly to the CPU and typically has PPIs and SGIs.
-Secondary GICs are cascaded into the upward interrupt controller and do not
-have PPIs or SGIs.
-
-Main node required properties:
-
-- compatible : should be one of:
-	"arm,arm1176jzf-devchip-gic"
-	"arm,arm11mp-gic"
-	"arm,cortex-a15-gic"
-	"arm,cortex-a7-gic"
-	"arm,cortex-a9-gic"
-	"arm,eb11mp-gic"
-	"arm,gic-400"
-	"arm,pl390"
-	"arm,tc11mp-gic"
-	"brcm,brahma-b15-gic"
-	"nvidia,tegra210-agic"
-	"qcom,msm-8660-qgic"
-	"qcom,msm-qgic2"
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source.  The type shall be a <u32> and the value shall be 3.
-
-  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-  interrupts.
-
-  The 2nd cell contains the interrupt number for the interrupt type.
-  SPI interrupts are in the range [0-987].  PPI interrupts are in the
-  range [0-15].
-
-  The 3rd cell is the flags, encoded as follows:
-	bits[3:0] trigger type and level flags.
-		1 = low-to-high edge triggered
-		2 = high-to-low edge triggered (invalid for SPIs)
-		4 = active high level-sensitive
-		8 = active low level-sensitive (invalid for SPIs).
-	bits[15:8] PPI interrupt cpu mask.  Each bit corresponds to each of
-	the 8 possible cpus attached to the GIC.  A bit set to '1' indicated
-	the interrupt is wired to that CPU.  Only valid for PPI interrupts.
-	Also note that the configurability of PPI interrupts is IMPLEMENTATION
-	DEFINED and as such not guaranteed to be present (most SoC available
-	in 2014 seem to ignore the setting of this flag and use the hardware
-	default value).
-
-- reg : Specifies base physical address(s) and size of the GIC registers. The
-  first region is the GIC distributor register base and size. The 2nd region is
-  the GIC cpu interface register base and size.
-
-Optional
-- interrupts	: Interrupt source of the parent interrupt controller on
-  secondary GICs, or VGIC maintenance interrupt on primary GIC (see
-  below).
-
-- cpu-offset	: per-cpu offset within the distributor and cpu interface
-  regions, used when the GIC doesn't have banked registers. The offset is
-  cpu-offset * cpu-nr.
-
-- clocks        : List of phandle and clock-specific pairs, one for each entry
-  in clock-names.
-- clock-names   : List of names for the GIC clock input(s). Valid clock names
-  depend on the GIC variant:
-	"ic_clk" (for "arm,arm11mp-gic")
-	"PERIPHCLKEN" (for "arm,cortex-a15-gic")
-	"PERIPHCLK", "PERIPHCLKEN" (for "arm,cortex-a9-gic")
-	"clk" (for "arm,gic-400" and "nvidia,tegra210")
-	"gclk" (for "arm,pl390")
-
-- power-domains : A phandle and PM domain specifier as defined by bindings of
-		  the power controller specified by phandle, used when the GIC
-		  is part of a Power or Clock Domain.
-
-
-Example:
-
-	intc: interrupt-controller@fff11000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <1>;
-		interrupt-controller;
-		reg = <0xfff11000 0x1000>,
-		      <0xfff10100 0x100>;
-	};
-
-
-* GIC virtualization extensions (VGIC)
-
-For ARM cores that support the virtualization extensions, additional
-properties must be described (they only exist if the GIC is the
-primary interrupt controller).
-
-Required properties:
-
-- reg : Additional regions specifying the base physical address and
-  size of the VGIC registers. The first additional region is the GIC
-  virtual interface control register base and size. The 2nd additional
-  region is the GIC virtual cpu interface register base and size.
-
-- interrupts : VGIC maintenance interrupt.
-
-Example:
-
-	interrupt-controller@2c001000 {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x2c001000 0x1000>,
-		      <0x2c002000 0x2000>,
-		      <0x2c004000 0x2000>,
-		      <0x2c006000 0x2000>;
-		interrupts = <1 9 0xf04>;
-	};
-
-
-* GICv2m extension for MSI/MSI-x support (Optional)
-
-Certain revisions of GIC-400 supports MSI/MSI-x via V2M register frame(s).
-This is enabled by specifying v2m sub-node(s).
-
-Required properties:
-
-- compatible	    : The value here should contain "arm,gic-v2m-frame".
-
-- msi-controller    : Identifies the node as an MSI controller.
-
-- reg		    : GICv2m MSI interface register base and size
-
-Optional properties:
-
-- arm,msi-base-spi  : When the MSI_TYPER register contains an incorrect
-  		      value, this property should contain the SPI base of
-		      the MSI frame, overriding the HW value.
-
-- arm,msi-num-spis  : When the MSI_TYPER register contains an incorrect
-  		      value, this property should contain the number of
-		      SPIs assigned to the frame, overriding the HW value.
-
-Example:
-
-	interrupt-controller@e1101000 {
-		compatible = "arm,gic-400";
-		#interrupt-cells = <3>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		interrupt-controller;
-		interrupts = <1 8 0xf04>;
-		ranges = <0 0 0 0xe1100000 0 0x100000>;
-		reg = <0x0 0xe1110000 0 0x01000>,
-		      <0x0 0xe112f000 0 0x02000>,
-		      <0x0 0xe1140000 0 0x10000>,
-		      <0x0 0xe1160000 0 0x10000>;
-		v2m0: v2m@8000 {
-			compatible = "arm,gic-v2m-frame";
-			msi-controller;
-			reg = <0x0 0x80000 0 0x1000>;
-		};
-
-		....
-
-		v2mN: v2m@9000 {
-			compatible = "arm,gic-v2m-frame";
-			msi-controller;
-			reg = <0x0 0x90000 0 0x1000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
new file mode 100644
index 000000000000..758fbd7128e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
@@ -0,0 +1,223 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/arm,gic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Generic Interrupt Controller v1 and v2
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+
+description: |+
+  ARM SMP cores are often associated with a GIC, providing per processor
+  interrupts (PPI), shared processor interrupts (SPI) and software
+  generated interrupts (SGI).
+
+  Primary GIC is attached directly to the CPU and typically has PPIs and SGIs.
+  Secondary GICs are cascaded into the upward interrupt controller and do not
+  have PPIs or SGIs.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - arm,arm11mp-gic
+              - arm,cortex-a15-gic
+              - arm,cortex-a7-gic
+              - arm,cortex-a5-gic
+              - arm,cortex-a9-gic
+              - arm,eb11mp-gic
+              - arm,gic-400
+              - arm,pl390
+              - arm,tc11mp-gic
+              - nvidia,tegra210-agic
+              - qcom,msm-8660-qgic
+              - qcom,msm-qgic2
+
+      - items:
+          - const: arm,arm1176jzf-devchip-gic
+          - const: arm,arm11mp-gic
+
+      - items:
+          - const: brcm,brahma-b15-gic
+          - const: arm,cortex-a15-gic
+
+  interrupt-controller: true
+
+  "#address-cells":
+    enum: [ 0, 1 ]
+  "#size-cells":
+    const: 1
+
+  "#interrupt-cells":
+    const: 3
+    description: |
+      The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
+      interrupts.
+
+      The 2nd cell contains the interrupt number for the interrupt type.
+      SPI interrupts are in the range [0-987].  PPI interrupts are in the
+      range [0-15].
+
+      The 3rd cell is the flags, encoded as follows:
+        bits[3:0] trigger type and level flags.
+          1 = low-to-high edge triggered
+          2 = high-to-low edge triggered (invalid for SPIs)
+          4 = active high level-sensitive
+          8 = active low level-sensitive (invalid for SPIs).
+        bits[15:8] PPI interrupt cpu mask.  Each bit corresponds to each of
+        the 8 possible cpus attached to the GIC.  A bit set to '1' indicated
+        the interrupt is wired to that CPU.  Only valid for PPI interrupts.
+        Also note that the configurability of PPI interrupts is IMPLEMENTATION
+        DEFINED and as such not guaranteed to be present (most SoC available
+        in 2014 seem to ignore the setting of this flag and use the hardware
+        default value).
+
+  reg:
+    description: |
+      Specifies base physical address(s) and size of the GIC registers. The
+      first region is the GIC distributor register base and size. The 2nd region
+      is the GIC cpu interface register base and size.
+
+      For GICv2 with virtualization extensions, additional regions are
+      required for specifying the base physical address and size of the VGIC
+      registers. The first additional region is the GIC virtual interface
+      control register base and size. The 2nd additional region is the GIC
+      virtual cpu interface register base and size.
+    minItems: 2
+    maxItems: 4
+
+  interrupts:
+    description: Interrupt source of the parent interrupt controller on
+      secondary GICs, or VGIC maintenance interrupt on primary GIC (see
+      below).
+    maxItems: 1
+
+  cpu-offset:
+    description: per-cpu offset within the distributor and cpu interface
+      regions, used when the GIC doesn't have banked registers. The offset
+      is cpu-offset * cpu-nr.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    description: List of names for the GIC clock input(s). Valid clock names
+      depend on the GIC variant.
+    oneOf:
+      - const: ic_clk # for "arm,arm11mp-gic"
+      - const: PERIPHCLKEN # for "arm,cortex-a15-gic"
+      - items: # for "arm,cortex-a9-gic"
+          - const: PERIPHCLK
+          - const: PERIPHCLKEN
+      - const: clk # for "arm,gic-400" and "nvidia,tegra210"
+      - const: gclk #for "arm,pl390"
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^v2m@[0-9a-f]+$":
+    description: |
+      * GICv2m extension for MSI/MSI-x support (Optional)
+
+      Certain revisions of GIC-400 supports MSI/MSI-x via V2M register frame(s).
+      This is enabled by specifying v2m sub-node(s).
+
+    properties:
+      compatible:
+        const: arm,gic-v2m-frame
+
+      msi-controller: true
+
+      reg:
+        maxItems: 1
+        description: GICv2m MSI interface register base and size
+
+      arm,msi-base-spi:
+        description: When the MSI_TYPER register contains an incorrect value,
+          this property should contain the SPI base of the MSI frame, overriding
+          the HW value.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      arm,msi-num-spis:
+        description: When the MSI_TYPER register contains an incorrect value,
+          this property should contain the number of SPIs assigned to the
+          frame, overriding the HW value.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - compatible
+      - msi-controller
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    // GICv1
+    intc: interrupt-controller@fff11000 {
+      compatible = "arm,cortex-a9-gic";
+      #interrupt-cells = <3>;
+      #address-cells = <1>;
+      interrupt-controller;
+      reg = <0xfff11000 0x1000>,
+            <0xfff10100 0x100>;
+    };
+
+  - |
+    // GICv2
+    interrupt-controller@2c001000 {
+      compatible = "arm,cortex-a15-gic";
+      #interrupt-cells = <3>;
+      interrupt-controller;
+      reg = <0x2c001000 0x1000>,
+            <0x2c002000 0x2000>,
+            <0x2c004000 0x2000>,
+            <0x2c006000 0x2000>;
+      interrupts = <1 9 0xf04>;
+    };
+
+  - |
+    // GICv2m extension for MSI/MSI-x support
+    interrupt-controller@e1101000 {
+      compatible = "arm,gic-400";
+      #interrupt-cells = <3>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+      interrupt-controller;
+      interrupts = <1 8 0xf04>;
+      ranges = <0 0 0 0xe1100000 0 0x100000>;
+      reg = <0x0 0xe1110000 0 0x01000>,
+            <0x0 0xe112f000 0 0x02000>,
+            <0x0 0xe1140000 0 0x10000>,
+            <0x0 0xe1160000 0 0x10000>;
+
+      v2m0: v2m@8000 {
+        compatible = "arm,gic-v2m-frame";
+        msi-controller;
+        reg = <0x0 0x80000 0 0x1000>;
+      };
+
+      //...
+
+      v2mN: v2m@9000 {
+        compatible = "arm,gic-v2m-frame";
+        msi-controller;
+        reg = <0x0 0x90000 0 0x1000>;
+      };
+    };
+...
-- 
2.19.1

