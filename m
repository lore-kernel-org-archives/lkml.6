Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D60C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D60C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLCVfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:35:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36342 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLCVci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so12357529oix.3;
        Mon, 03 Dec 2018 13:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dA8AGvBGRvCAkyd4n1eYxm6anA991HhNOhSBUn8M78I=;
        b=hhyy9UVNMOYuTHIXULYVyz2R8C7Wwnna/vM2g8acxpFgvnnnsN463UYcQYPYwH2per
         dN9hR0MZucgWbi4WDC+sIgczIJFw3qzujRquC3YajtqNXGsFElHOSsNsl9vvLfPul860
         WgzlzYLPPBIjh7+U9sWHV3yRJPz+AxILY3P+bYVYFLxCd/nIjhOfFMZRrvWSIoskl+O9
         A+Xn+sEHicvlFa3txY3Lqgi5BPl/eXhZ9PQDgoY9NxIQ+Z+yRWsLDPlQL9sASA7Kl/pG
         3GyRCt35vdSAIM/yMmLNSPAWdL+p2eXeJx8/FdejOA+bdw18iBpwL+c/eoJyMg2a7BnB
         qCgw==
X-Gm-Message-State: AA+aEWYsX68/d1eVgdWxeGBTKMND4LnltZOJnGsp9h1yNaHbjsCIN/s3
        cfJTrqLGL9EMpGyKgUtYvYy8Sws=
X-Google-Smtp-Source: AFSGD/UG0m2oZjAAxU9bkpVHVIEgRwOTW4AGda95iB0ms+QZC4pij4WLOTnmyLIvrZdJpXnjjXzS/g==
X-Received: by 2002:a54:4d81:: with SMTP id y1mr11227097oix.18.1543872756778;
        Mon, 03 Dec 2018 13:32:36 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:36 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 09/34] dt-bindings: arm: Convert primecell binding to json-schema
Date:   Mon,  3 Dec 2018 15:31:58 -0600
Message-Id: <20181203213223.16986-10-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ARM Primecell binding to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/primecell.txt     | 46 -------------------
 .../devicetree/bindings/arm/primecell.yaml    | 36 +++++++++++++++
 2 files changed, 36 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
 create mode 100644 Documentation/devicetree/bindings/arm/primecell.yaml

diff --git a/Documentation/devicetree/bindings/arm/primecell.txt b/Documentation/devicetree/bindings/arm/primecell.txt
deleted file mode 100644
index 0df6acacfaea..000000000000
--- a/Documentation/devicetree/bindings/arm/primecell.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* ARM Primecell Peripherals
-
-ARM, Ltd. Primecell peripherals have a standard id register that can be used to
-identify the peripheral type, vendor, and revision. This value can be used for
-driver matching.
-
-Required properties:
-
-- compatible : should be a specific name for the peripheral and
-               "arm,primecell".  The specific name will match the ARM
-               engineering name for the logic block in the form: "arm,pl???"
-
-Optional properties:
-
-- arm,primecell-periphid : Value to override the h/w value with
-- clocks : From common clock binding. First clock is phandle to clock for apb
-	pclk. Additional clocks are optional and specific to those peripherals.
-- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
-- dmas : From common DMA binding. If present, refers to one or more dma channels.
-- dma-names : From common DMA binding, needs to match the 'dmas' property.
-              Devices with exactly one receive and transmit channel shall name
-              these "rx" and "tx", respectively.
-- pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
-- pinctrl-names : Names corresponding to the numbered pinctrl states
-- interrupts : one or more interrupt specifiers
-- interrupt-names : names corresponding to the interrupts properties
-
-Example:
-
-serial@fff36000 {
-	compatible = "arm,pl011", "arm,primecell";
-	arm,primecell-periphid = <0x00341011>;
-
-	clocks = <&pclk>;
-	clock-names = "apb_pclk";
-
-	dmas = <&dma-controller 4>, <&dma-controller 5>;
-	dma-names = "rx", "tx";	
-
-	pinctrl-0 = <&uart0_default_mux>, <&uart0_default_mode>;
-	pinctrl-1 = <&uart0_sleep_mode>;
-	pinctrl-names = "default","sleep";
-
-	interrupts = <0 11 0x4>;
-};
-
diff --git a/Documentation/devicetree/bindings/arm/primecell.yaml b/Documentation/devicetree/bindings/arm/primecell.yaml
new file mode 100644
index 000000000000..5aae37f1c563
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/primecell.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/primecell.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Primecell Peripherals
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |+
+  ARM, Ltd. Primecell peripherals have a standard id register that can be used to
+  identify the peripheral type, vendor, and revision. This value can be used for
+  driver matching.
+
+properties:
+  compatible:
+    contains:
+      const: arm,primecell
+    description:
+      Should be a specific name for the peripheral followed by "arm,primecell".
+      The specific name will match the ARM engineering name for the logic block
+      in the form "arm,pl???"
+
+  arm,primecell-periphid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Value to override the h/w ID value
+  clocks:
+    minItems: 1
+    maxItems: 32
+  clock-names:
+    contains:
+      const: apb_pclk
+    additionalItems: true
+...
-- 
2.19.1

