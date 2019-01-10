Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE2FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BB4208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158763;
	bh=M3X6C+NA9yt7XTdMs/zWrDwUxhuf81j+9kc9i/LSqNA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oWvYYdi1xTG8776V156FRHZWLkda3jz3QwGvOYvx1IHmwbz3PHMFdoJMcs16yqWsX
	 7zgY0+pRzZOKGH0gFXT+io0E86hvzAE2yCoCh3hUpjuqd7aWLKfoNNJvOY2vMIoUQw
	 QVnM3Y4eW5EhvcaKm82kjLUIRMLtMVqwBl2LjRUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfAJWTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:19:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40005 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfAJWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:19:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so11409322oth.7;
        Thu, 10 Jan 2019 14:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/noQUYeDpkKBReyP//Pz9IqsmXwtUQbgCHYAoh8XSQc=;
        b=DVIE9ywacScBr6YsJjycfkGUx9o4DrBXxPDlZAz1YXlOqcMNL64S8A48LWvrXKtF4n
         v6BHdkX6A1BU4a5ykq0BcpoZy0Tmjf8QKrrbATtvFvOdP/nDhrO2CceRqVz3ouLlil67
         Rx+9K9eN+9YMVUBvYDzKxX8FNm7mwR5kJ+8tSL9JUz0FsR9uRzTu5Ma0t+3ULL7/QzVm
         NMrP24FSNkETLc9k+bwESO/7MSjaf5ghznz7mGssw0fYrKT46xGWQT6MhTGfFR3aTNGS
         9nYpiHbugVb80TZl6htuSqz1l8EMBZ24qdnzVpu8rdTZm42U5i2qjUFLuKKb07piG7GK
         KClg==
X-Gm-Message-State: AJcUukft3GSXFcbyB7T347hsdFvTjq2DgKlYpSsViejlQae8peZqQGhD
        bntmMz/CS2Kl72Jgx3bVDXTZMsM=
X-Google-Smtp-Source: ALg8bN6dPVZI9Z1PWaUMzngwGbOnpPkE3vG9CiFNtFj/5dUxv1YECTY2rsO2ePMbrasqM8ExNVK7Bw==
X-Received: by 2002:a9d:6f0b:: with SMTP id n11mr7492544otq.363.1547158754762;
        Thu, 10 Jan 2019 14:19:14 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c19sm36776707otl.16.2019.01.10.14.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:19:13 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: dt-bindings: Convert fixed-regulator to json-schema
Date:   Thu, 10 Jan 2019 16:19:03 -0600
Message-Id: <20190110221903.3990-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fixed-regulator binding to DT schema format using
json-schema.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/fixed-regulator.txt    | 35 ----------
 .../bindings/regulator/fixed-regulator.yaml   | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
deleted file mode 100644
index 0c2a6c8a1536..000000000000
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Fixed Voltage regulators
-
-Required properties:
-- compatible: Must be "regulator-fixed";
-- regulator-name: Defined in regulator.txt as optional, but required here.
-
-Optional properties:
-- gpio: gpio to use for enable control
-- startup-delay-us: startup time in microseconds
-- enable-active-high: Polarity of GPIO is Active high
-If this property is missing, the default assumed is Active low.
-- gpio-open-drain: GPIO is open drain type.
-  If this property is missing then default assumption is false.
--vin-supply: Input supply name.
-
-Any property defined as part of the core regulator
-binding, defined in regulator.txt, can also be used.
-However a fixed voltage regulator is expected to have the
-regulator-min-microvolt and regulator-max-microvolt
-to be the same.
-
-Example:
-
-	abc: fixedregulator@0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-supply";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio1 16 0>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-		regulator-boot-on;
-		gpio-open-drain;
-		vin-supply = <&parent_reg>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
new file mode 100644
index 000000000000..a7607b0baab7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fixed Voltage regulators
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+description:
+  Any property defined as part of the core regulator binding, defined in
+  regulator.txt, can also be used. However a fixed voltage regulator is
+  expected to have the regulator-min-microvolt and regulator-max-microvolt
+  to be the same.
+
+properties:
+  compatible:
+    const: regulator-fixed
+
+  regulator-name: true
+
+  gpio:
+    description: gpio to use for enable control
+    maxItems: 1
+
+  startup-delay-us:
+    description: startup time in microseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  enable-active-high:
+    description:
+      Polarity of GPIO is Active high. If this property is missing,
+      the default assumed is Active low.
+    type: boolean
+
+  gpio-open-drain:
+    description:
+      GPIO is open drain type. If this property is missing then default
+      assumption is false.
+    type: boolean
+
+  vin-supply:
+    description: Input supply phandle.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - regulator-name
+
+examples:
+  - |
+    abc: fixedregulator@0 {
+      compatible = "regulator-fixed";
+      regulator-name = "fixed-supply";
+      regulator-min-microvolt = <1800000>;
+      regulator-max-microvolt = <1800000>;
+      gpio = <&gpio1 16 0>;
+      startup-delay-us = <70000>;
+      enable-active-high;
+      regulator-boot-on;
+      gpio-open-drain;
+      vin-supply = <&parent_reg>;
+    };
+...
-- 
2.19.1

