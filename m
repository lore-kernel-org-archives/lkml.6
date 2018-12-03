Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335ABC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0F620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0F620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeLCVf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:35:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37559 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLCVcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so12372964oia.4;
        Mon, 03 Dec 2018 13:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Th6PgAk+sHhcJGhBAXLbYoXMw1xn7ji2s1MXs2vABtU=;
        b=BLDvSr5WFAFpCzhtpM/bfGq5YSKhc8RmPKPFjg8LFwgtLC0kGVSbHKgGECyPi03Exk
         zTtJyLM0kxgPfBh908XDbRYuQd+3jnbi/J/Y6pLXrcmRJvmPekIlpQGDP96D4Mu1q4k2
         xMx4C/aJAvTEzVxt1vmc4OoMrwPvXr+M2sLs6KrAkIh7+BWaiWYIi/bQsEb8z7fYrzmV
         RcFdO5dlveRSr5hTy7Q6TYBCzoqwMx7RhswFQ5tu5NL7lZQeyuYQl6EB73uYRCeYRfIx
         0aJqRAWE45fDP5WTNnjS+KT4y1uccuOoDSvS75peUdJLFqo9UX4bp3kJr4CN8FVy9dT7
         UaKw==
X-Gm-Message-State: AA+aEWYzI4RpcekxrnSJrDKrcsDntEoIEUBSGFEIzxnsWUZtPQ0rp14G
        /vZJbtfMaZ0YevypXv/u6dbisGw=
X-Google-Smtp-Source: AFSGD/UGlypVoMrSIfA19hrK4+wAhTTks5jY5hUOtbo4S5fPBErPGeCODEKoJ1h7AI+3wL/N4+ZqjQ==
X-Received: by 2002:aca:5bc3:: with SMTP id p186mr10567400oib.130.1543872755621;
        Mon, 03 Dec 2018 13:32:35 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:34 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 08/34] dt-bindings: arm: Convert PMU binding to json-schema
Date:   Mon,  3 Dec 2018 15:31:57 -0600
Message-Id: <20181203213223.16986-9-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ARM PMU binding to DT schema format using json-schema.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
 .../devicetree/bindings/arm/pmu.yaml          | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
deleted file mode 100644
index 13611a8199bb..000000000000
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-* ARM Performance Monitor Units
-
-ARM cores often have a PMU for counting cpu and cache events like cache misses
-and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
-representation in the device tree should be done as under:-
-
-Required properties:
-
-- compatible : should be one of
-	"apm,potenza-pmu"
-	"arm,armv8-pmuv3"
-	"arm,cortex-a73-pmu"
-	"arm,cortex-a72-pmu"
-	"arm,cortex-a57-pmu"
-	"arm,cortex-a53-pmu"
-	"arm,cortex-a35-pmu"
-	"arm,cortex-a17-pmu"
-	"arm,cortex-a15-pmu"
-	"arm,cortex-a12-pmu"
-	"arm,cortex-a9-pmu"
-	"arm,cortex-a8-pmu"
-	"arm,cortex-a7-pmu"
-	"arm,cortex-a5-pmu"
-	"arm,arm11mpcore-pmu"
-	"arm,arm1176-pmu"
-	"arm,arm1136-pmu"
-	"brcm,vulcan-pmu"
-	"cavium,thunder-pmu"
-	"qcom,scorpion-pmu"
-	"qcom,scorpion-mp-pmu"
-	"qcom,krait-pmu"
-- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
-               interrupt (PPI) then 1 interrupt should be specified.
-
-Optional properties:
-
-- interrupt-affinity : When using SPIs, specifies a list of phandles to CPU
-                       nodes corresponding directly to the affinity of
-		       the SPIs listed in the interrupts property.
-
-                       When using a PPI, specifies a list of phandles to CPU
-		       nodes corresponding to the set of CPUs which have
-		       a PMU of this type signalling the PPI listed in the
-		       interrupts property, unless this is already specified
-		       by the PPI interrupt specifier itself (in which case
-		       the interrupt-affinity property shouldn't be present).
-
-                       This property should be present when there is more than
-		       a single SPI.
-
-
-- qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
-                     events.
-
-- secure-reg-access : Indicates that the ARMv7 Secure Debug Enable Register
-		      (SDER) is accessible. This will cause the driver to do
-		      any setup required that is only possible in ARMv7 secure
-		      state. If not present the ARMv7 SDER will not be touched,
-		      which means the PMU may fail to operate unless external
-		      code (bootloader or security monitor) has performed the
-		      appropriate initialisation. Note that this property is
-		      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
-		      in Non-secure state.
-
-Example:
-
-pmu {
-        compatible = "arm,cortex-a9-pmu";
-        interrupts = <100 101>;
-};
diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
new file mode 100644
index 000000000000..3ea4abfbf276
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Performance Monitor Units
+
+maintainers:
+  - Mark Rutland <mark.rutland@arm.com>
+  - Will Deacon <will.deacon@arm.com>
+
+description: |+
+  ARM cores often have a PMU for counting cpu and cache events like cache misses
+  and hits. The interface to the PMU is part of the ARM ARM. The ARM PMU
+  representation in the device tree should be done as under:-
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - apm,potenza-pmu
+              - arm,armv8-pmuv3
+              - arm,cortex-a73-pmu
+              - arm,cortex-a72-pmu
+              - arm,cortex-a57-pmu
+              - arm,cortex-a53-pmu
+              - arm,cortex-a35-pmu
+              - arm,cortex-a17-pmu
+              - arm,cortex-a15-pmu
+              - arm,cortex-a12-pmu
+              - arm,cortex-a9-pmu
+              - arm,cortex-a8-pmu
+              - arm,cortex-a7-pmu
+              - arm,cortex-a5-pmu
+              - arm,arm11mpcore-pmu
+              - arm,arm1176-pmu
+              - arm,arm1136-pmu
+              - brcm,vulcan-pmu
+              - cavium,thunder-pmu
+              - qcom,scorpion-pmu
+              - qcom,scorpion-mp-pmu
+              - qcom,krait-pmu
+      - items:
+          - const: arm,cortex-a7-pmu
+          - const: arm,cortex-a15-pmu
+
+  interrupts:
+    # Don't know how many CPUs, so no constraints to specify
+    description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
+
+  interrupt-affinity:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      When using SPIs, specifies a list of phandles to CPU
+      nodes corresponding directly to the affinity of
+      the SPIs listed in the interrupts property.
+
+      When using a PPI, specifies a list of phandles to CPU
+      nodes corresponding to the set of CPUs which have
+      a PMU of this type signalling the PPI listed in the
+      interrupts property, unless this is already specified
+      by the PPI interrupt specifier itself (in which case
+      the interrupt-affinity property shouldn't be present).
+
+      This property should be present when there is more than
+      a single SPI.
+
+  qcom,no-pc-write:
+    type: boolean
+    description:
+      Indicates that this PMU doesn't support the 0xc and 0xd events.
+
+  secure-reg-access:
+    type: boolean
+    description:
+      Indicates that the ARMv7 Secure Debug Enable Register
+      (SDER) is accessible. This will cause the driver to do
+      any setup required that is only possible in ARMv7 secure
+      state. If not present the ARMv7 SDER will not be touched,
+      which means the PMU may fail to operate unless external
+      code (bootloader or security monitor) has performed the
+      appropriate initialisation. Note that this property is
+      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
+      in Non-secure state.
+
+required:
+  - compatible
+
+...
-- 
2.19.1

