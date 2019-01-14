Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1EDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59792205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547503794;
	bh=0Yd1dD+XYuPx9BAwzytp+BXTBJrukhgjut1Gtu1o2tY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=c1kF1J5rKg9353M1Qb878JEpNhbSebqr5XgonLVoINfc2aD/EIGLS7VOI4BJWZwus
	 Q/Z2b6UVRj+f42WrBJm8S5E5B4eAY4l+cfLdFdJUzJmBDqXJd3IVTpT3/J5MsS0zdi
	 jVreKHfBzVzfJF0hUMRTw2PACL3blTg2j2W+dBWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfANWJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:09:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfANWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ekeJ7zXyXJF8BSvdHlsiSiGTEct/kEuHyMjLtNo9N14=; b=LtnXQsjoBdzW
        W+TmvoA+8MnexYqbmeise3ZLs1nYKQc8xAjIV7rRpuweGgLHvvc8FqoCiZQC44fA2uTaAt0fdDHxQ
        bMA5TZ+Qb8PelvkN+CcYB+eijz5syHLmGoW75e4dobMRN8ALckAnQYku9cDYt/WnhCtStNP3yO6U8
        DPUUQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjAQY-0008Gg-IB; Mon, 14 Jan 2019 22:09:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 28A081127AD0; Mon, 14 Jan 2019 22:09:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: dt-bindings: Convert fixed-regulator to json-schema" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114220950.28A081127AD0@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 22:09:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: dt-bindings: Convert fixed-regulator to json-schema

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 053979d2395bdf0e77f6591655e1f491611a6d89 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Jan 2019 16:19:03 -0600
Subject: [PATCH] regulator: dt-bindings: Convert fixed-regulator to
 json-schema

Convert the fixed-regulator binding to DT schema format using
json-schema.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

