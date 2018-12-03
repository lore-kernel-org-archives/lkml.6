Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5011C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A8D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A8D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLCVcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:32:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34660 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLCVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so13159199otk.1;
        Mon, 03 Dec 2018 13:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBdzh5igNzDqLEgQ/x0qGKygetPrx2TSisacJ9NbwDM=;
        b=tDACOdXw1VUucMhSjiiZT/3fxRzBJFb07JXGxyaSTvTMNLUnS/8kn64IvG5AS9FLIV
         aWUHX/Q9vx6OreKum9WDSxviZKtGll80KcNcilY2yno0NPeaW4Tf4QSEwFOOBPThfz+B
         R/mLamvlK7JmI9WiuW8Is/e+pOEKa2/2PN8OEr107jkUj5mMSSue9vNqv8b8H8lq13I8
         NYhSx2wAfIAfyXWaQ0cVKINWm8c/eAQbcaAhjdjDvSPOBWEiAzgdZpwbsVJZ4dn1Tmze
         NscB41RQNd+NkIB0LB/qCM23N6p8GsmPy21juTnznakfg1W6f91cUk/ynCYAR3zQVBp9
         CZww==
X-Gm-Message-State: AA+aEWaXwihjyNh1brjJnCVywLt7SyZvCzT09ZlCSqLIJQSq4nG8Jemc
        r3fhByQ6pIFIoe3ME9T8vHbSn+Y=
X-Google-Smtp-Source: AFSGD/U+mmGiUexsRNmU93TnmIq902d8xMVaezYT4k9mXkl7aBDX7UB2cG5lIAucILKUmxLOaJFYyA==
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr11773089otb.165.1543872753053;
        Mon, 03 Dec 2018 13:32:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:32 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 06/34] dt-bindings: timer: Convert ARM timer bindings to json-schema
Date:   Mon,  3 Dec 2018 15:31:55 -0600
Message-Id: <20181203213223.16986-7-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ARM timers to DT schema format using json-schema.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/arm,arch_timer.txt         | 112 ----------------
 .../bindings/timer/arm,arch_timer.yaml        | 103 +++++++++++++++
 .../bindings/timer/arm,arch_timer_mmio.yaml   | 120 ++++++++++++++++++
 .../bindings/timer/arm,global_timer.txt       |  27 ----
 .../bindings/timer/arm,global_timer.yaml      |  46 +++++++
 5 files changed, 269 insertions(+), 139 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.txt b/Documentation/devicetree/bindings/timer/arm,arch_timer.txt
deleted file mode 100644
index 68301b77e854..000000000000
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-* ARM architected timer
-
-ARM cores may have a per-core architected timer, which provides per-cpu timers,
-or a memory mapped architected timer, which provides up to 8 frames with a
-physical and optional virtual timer per frame.
-
-The per-core architected timer is attached to a GIC to deliver its
-per-processor interrupts via PPIs. The memory mapped timer is attached to a GIC
-to deliver its interrupts via SPIs.
-
-** CP15 Timer node properties:
-
-- compatible : Should at least contain one of
-	"arm,armv7-timer"
-	"arm,armv8-timer"
-
-- interrupts : Interrupt list for secure, non-secure, virtual and
-  hypervisor timers, in that order.
-
-- clock-frequency : The frequency of the main counter, in Hz. Should be present
-  only where necessary to work around broken firmware which does not configure
-  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
-  strongly discouraged; fix your firmware unless absolutely impossible.
-
-- always-on : a boolean property. If present, the timer is powered through an
-  always-on power domain, therefore it never loses context.
-
-- fsl,erratum-a008585 : A boolean property. Indicates the presence of
-  QorIQ erratum A-008585, which says that reading the counter is
-  unreliable unless the same value is returned by back-to-back reads.
-  This also affects writes to the tval register, due to the implicit
-  counter read.
-
-- hisilicon,erratum-161010101 : A boolean property. Indicates the
-  presence of Hisilicon erratum 161010101, which says that reading the
-  counters is unreliable in some cases, and reads may return a value 32
-  beyond the correct value. This also affects writes to the tval
-  registers, due to the implicit counter read.
-
-** Optional properties:
-
-- arm,cpu-registers-not-fw-configured : Firmware does not initialize
-  any of the generic timer CPU registers, which contain their
-  architecturally-defined reset values. Only supported for 32-bit
-  systems which follow the ARMv7 architected reset values.
-
-- arm,no-tick-in-suspend : The main counter does not tick when the system is in
-  low-power system suspend on some SoCs. This behavior does not match the
-  Architecture Reference Manual's specification that the system counter "must
-  be implemented in an always-on power domain."
-
-
-Example:
-
-	timer {
-		compatible = "arm,cortex-a15-timer",
-			     "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
-		clock-frequency = <100000000>;
-	};
-
-** Memory mapped timer node properties:
-
-- compatible : Should at least contain "arm,armv7-timer-mem".
-
-- clock-frequency : The frequency of the main counter, in Hz. Should be present
-  only when firmware has not configured the MMIO CNTFRQ registers.
-
-- reg : The control frame base address.
-
-Note that #address-cells, #size-cells, and ranges shall be present to ensure
-the CPU can address a frame's registers.
-
-A timer node has up to 8 frame sub-nodes, each with the following properties:
-
-- frame-number: 0 to 7.
-
-- interrupts : Interrupt list for physical and virtual timers in that order.
-  The virtual timer interrupt is optional.
-
-- reg : The first and second view base addresses in that order. The second view
-  base address is optional.
-
-- status : "disabled" indicates the frame is not available for use. Optional.
-
-Example:
-
-	timer@f0000000 {
-		compatible = "arm,armv7-timer-mem";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		reg = <0xf0000000 0x1000>;
-		clock-frequency = <50000000>;
-
-		frame@f0001000 {
-			frame-number = <0>
-			interrupts = <0 13 0x8>,
-				     <0 14 0x8>;
-			reg = <0xf0001000 0x1000>,
-			      <0xf0002000 0x1000>;
-		};
-
-		frame@f0003000 {
-			frame-number = <1>
-			interrupts = <0 15 0x8>;
-			reg = <0xf0003000 0x1000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
new file mode 100644
index 000000000000..6deead07728e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM architected timer
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+  - Mark Rutland <mark.rutland@arm.com>
+description: |+
+  ARM cores may have a per-core architected timer, which provides per-cpu timers,
+  or a memory mapped architected timer, which provides up to 8 frames with a
+  physical and optional virtual timer per frame.
+
+  The per-core architected timer is attached to a GIC to deliver its
+  per-processor interrupts via PPIs. The memory mapped timer is attached to a GIC
+  to deliver its interrupts via SPIs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - arm,cortex-a15-timer
+          - enum:
+              - arm,armv7-timer
+      - items:
+          - enum:
+            - arm,armv7-timer
+      - items:
+          - enum:
+            - arm,armv8-timer
+
+  interrupts:
+    items:
+      - description: secure timer irq
+      - description: non-secure timer irq
+      - description: virtual timer irq
+      - description: hypervisor timer irq
+
+  clock-frequency:
+    description: The frequency of the main counter, in Hz. Should be present
+      only where necessary to work around broken firmware which does not configure
+      CNTFRQ on all CPUs to a uniform correct value. Use of this property is
+      strongly discouraged; fix your firmware unless absolutely impossible.
+
+  always-on:
+    type: boolean
+    description: If present, the timer is powered through an always-on power
+      domain, therefore it never loses context.
+
+  fsl,erratum-a008585:
+    type: boolean
+    description: Indicates the presence of QorIQ erratum A-008585, which says
+      that reading the counter is unreliable unless the same value is returned
+      by back-to-back reads. This also affects writes to the tval register, due
+      to the implicit counter read.
+
+  hisilicon,erratum-161010101:
+    type: boolean
+    description: Indicates the presence of Hisilicon erratum 161010101, which
+      says that reading the counters is unreliable in some cases, and reads may
+      return a value 32 beyond the correct value. This also affects writes to
+      the tval registers, due to the implicit counter read.
+
+  arm,cpu-registers-not-fw-configured:
+    type: boolean
+    description: Firmware does not initialize any of the generic timer CPU
+      registers, which contain their architecturally-defined reset values. Only
+      supported for 32-bit systems which follow the ARMv7 architected reset
+      values.
+
+  arm,no-tick-in-suspend:
+    type: boolean
+    description: The main counter does not tick when the system is in
+      low-power system suspend on some SoCs. This behavior does not match the
+      Architecture Reference Manual's specification that the system counter "must
+      be implemented in an always-on power domain."
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - interrupts-extended
+
+examples:
+  - |
+    timer {
+      compatible = "arm,cortex-a15-timer",
+             "arm,armv7-timer";
+      interrupts = <1 13 0xf08>,
+             <1 14 0xf08>,
+             <1 11 0xf08>,
+             <1 10 0xf08>;
+      clock-frequency = <100000000>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
new file mode 100644
index 000000000000..c4ab59550fc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/arm,arch_timer_mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM memory mapped architected timer
+
+maintainers:
+  - Marc Zyngier <marc.zyngier@arm.com>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |+
+  ARM cores may have a memory mapped architected timer, which provides up to 8
+  frames with a physical and optional virtual timer per frame.
+
+  The memory mapped timer is attached to a GIC to deliver its interrupts via SPIs.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - arm,armv7-timer-mem
+
+  reg:
+    maxItems: 1
+    description: The control frame base address
+
+  '#address-cells':
+    enum: [1, 2]
+
+  '#size-cells':
+    const: 1
+
+  clock-frequency:
+    description: The frequency of the main counter, in Hz. Should be present
+      only where necessary to work around broken firmware which does not configure
+      CNTFRQ on all CPUs to a uniform correct value. Use of this property is
+      strongly discouraged; fix your firmware unless absolutely impossible.
+
+  always-on:
+    type: boolean
+    description: If present, the timer is powered through an always-on power
+      domain, therefore it never loses context.
+
+  arm,cpu-registers-not-fw-configured:
+    type: boolean
+    description: Firmware does not initialize any of the generic timer CPU
+      registers, which contain their architecturally-defined reset values. Only
+      supported for 32-bit systems which follow the ARMv7 architected reset
+      values.
+
+  arm,no-tick-in-suspend:
+    type: boolean
+    description: The main counter does not tick when the system is in
+      low-power system suspend on some SoCs. This behavior does not match the
+      Architecture Reference Manual's specification that the system counter "must
+      be implemented in an always-on power domain."
+
+patternProperties:
+  '^frame@[0-9a-z]*$':
+    description: A timer node has up to 8 frame sub-nodes, each with the following properties.
+    properties:
+      frame-number:
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 7
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+        items:
+          - description: physical timer irq
+          - description: virtual timer irq
+
+      reg :
+        minItems: 1
+        maxItems: 2
+        items:
+          - description: 1st view base address
+          - description: 2nd optional view base address
+
+    required:
+      - frame-number
+      - interrupts
+      - reg
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    timer@f0000000 {
+      compatible = "arm,armv7-timer-mem";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      reg = <0xf0000000 0x1000>;
+      clock-frequency = <50000000>;
+
+      frame@f0001000 {
+        frame-number = <0>;
+        interrupts = <0 13 0x8>,
+               <0 14 0x8>;
+        reg = <0xf0001000 0x1000>,
+              <0xf0002000 0x1000>;
+      };
+
+      frame@f0003000 {
+        frame-number = <1>;
+        interrupts = <0 15 0x8>;
+        reg = <0xf0003000 0x1000>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/arm,global_timer.txt b/Documentation/devicetree/bindings/timer/arm,global_timer.txt
deleted file mode 100644
index bdae3a818793..000000000000
--- a/Documentation/devicetree/bindings/timer/arm,global_timer.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-
-* ARM Global Timer
-	Cortex-A9 are often associated with a per-core Global timer.
-
-** Timer node required properties:
-
-- compatible : should contain
-	     * "arm,cortex-a5-global-timer" for Cortex-A5 global timers.
-	     * "arm,cortex-a9-global-timer" for Cortex-A9 global
-	         timers or any compatible implementation. Note: driver
-	         supports versions r2p0 and above.
-
-- interrupts : One interrupt to each core
-
-- reg : Specify the base address and the size of the GT timer
-	register window.
-
-- clocks : Should be phandle to a clock.
-
-Example:
-
-	timer@2c000600 {
-		compatible = "arm,cortex-a9-global-timer";
-		reg = <0x2c000600 0x20>;
-		interrupts = <1 13 0xf01>;
-		clocks = <&arm_periph_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/arm,global_timer.yaml b/Documentation/devicetree/bindings/timer/arm,global_timer.yaml
new file mode 100644
index 000000000000..21c24a8e28fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,global_timer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/arm,global_timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Global Timer
+
+maintainers:
+  - Stuart Menefy <stuart.menefy@st.com>
+
+description:
+  Cortex-A9 are often associated with a per-core Global timer.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,cortex-a5-global-timer
+          - arm,cortex-a9-global-timer
+
+    description: driver supports versions r2p0 and above.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    timer@2c000600 {
+      compatible = "arm,cortex-a9-global-timer";
+      reg = <0x2c000600 0x20>;
+      interrupts = <1 13 0xf01>;
+      clocks = <&arm_periph_clk>;
+    };
+...
-- 
2.19.1

