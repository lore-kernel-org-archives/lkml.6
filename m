Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65109C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175BD208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158593;
	bh=zek3YA2mWMMNlxVeqnFQjhDgd4q3ZS8AIxRRWeBMQBs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hLWsmPK8Vg2FFC3GwA8LeML9VgnBPatuquWq4by3nQjePhGDnBXagJ4ZmUbviBZgh
	 TYBw/0dyaykmjSwnJjNBKEU5GtVQXTZvtma41ayfY5c2mgVWt0OL5Gh0n4quxHpHYn
	 UjAZ+6y71kl2ZRpPbf2Taz8MwIAC/FMNpmzY+c4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfAJWQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:16:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41893 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfAJWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:16:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so10611302oii.8;
        Thu, 10 Jan 2019 14:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUzrvJeCP/Uefe73lE9qVhQ6gchhxLspPlMJYTQFUYk=;
        b=ZY4sCAqdk4Q+0K4ByN2jhHMISLsAys+Mf/JAQqQeyqz06c4xq016FDlR4uVK9e3QY2
         uLXW36T2Sb2IWG3/DVIuwJhvMfNXwnf7+FK6gubpXRvD6Il+2ogZBv7BIxejrkgqHG8B
         2Wu+qiouRN3lxUMUhU45D39cifFliAvCglzPcwRbcDdOhAggxpYLRWpotIX4dzq7ukAv
         8aKGwM7Yhg2v8bWrdyV5BdJZaaLjdHG3kMBf/qW6gNAme1cZBYHf5bSIORjhGJDbz5O7
         5Fv6XhwyBkr9O5PGCFt6J4K+CHdEuf8FUv3ErzvmLpcG1Sos2f3/ykyLQwSXdkrC9KDO
         bfeA==
X-Gm-Message-State: AJcUukcc/u2gTLxG6ugZJfbbb65azAg/bn/OF61DBd+juC5lDXZVMFIm
        sPDxdUikoce3/4b8+guM5Qks3Ow=
X-Google-Smtp-Source: ALg8bN7Xt7+BBCXLQ2orGqHjFrpjaVVQ7W9X+OKjQzs5ZaQrufVTwKAKhO2gToMUMlM1qoKu06KtxQ==
X-Received: by 2002:aca:a86:: with SMTP id k6mr7957399oiy.334.1547158589407;
        Thu, 10 Jan 2019 14:16:29 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id v3sm69035242oib.57.2019.01.10.14.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:16:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] dt-bindings: arm: Convert PMU binding to json-schema
Date:   Thu, 10 Jan 2019 16:16:28 -0600
Message-Id: <20190110221628.25021-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
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
v3:
- Don't allow arm,cortex-a15-pmu to be a fallback for arm,cortex-a7-pmu
- Update MAINTAINERS

Will, you can take this.

 Documentation/devicetree/bindings/arm/pmu.txt | 70 ---------------
 .../devicetree/bindings/arm/pmu.yaml          | 87 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 88 insertions(+), 71 deletions(-)
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
index 000000000000..52ae094ce330
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -0,0 +1,87 @@
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
+    items:
+      - enum:
+          - apm,potenza-pmu
+          - arm,armv8-pmuv3
+          - arm,cortex-a73-pmu
+          - arm,cortex-a72-pmu
+          - arm,cortex-a57-pmu
+          - arm,cortex-a53-pmu
+          - arm,cortex-a35-pmu
+          - arm,cortex-a17-pmu
+          - arm,cortex-a15-pmu
+          - arm,cortex-a12-pmu
+          - arm,cortex-a9-pmu
+          - arm,cortex-a8-pmu
+          - arm,cortex-a7-pmu
+          - arm,cortex-a5-pmu
+          - arm,arm11mpcore-pmu
+          - arm,arm1176-pmu
+          - arm,arm1136-pmu
+          - brcm,vulcan-pmu
+          - cavium,thunder-pmu
+          - qcom,scorpion-pmu
+          - qcom,scorpion-mp-pmu
+          - qcom,krait-pmu
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 39fcdbf38969..3f15010e5883 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1159,7 +1159,7 @@ F:	arch/arm*/include/asm/hw_breakpoint.h
 F:	arch/arm*/include/asm/perf_event.h
 F:	drivers/perf/*
 F:	include/linux/perf/arm_pmu.h
-F:	Documentation/devicetree/bindings/arm/pmu.txt
+F:	Documentation/devicetree/bindings/arm/pmu.yaml
 F:	Documentation/devicetree/bindings/perf/
 
 ARM PORT
-- 
2.19.1

