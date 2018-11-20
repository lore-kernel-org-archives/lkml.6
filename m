Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F772C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9620989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IEoEdT6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD9620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeKUC6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:58:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUC6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8TmtE4W1CCscXeIl0gL6j08b4lj39NAy0Jt7Z6UIluw=; b=IEoEdT6sx3++
        H3I8XO9Vc/VK9tL4EOjG/pBQM1z0KFKK+j8NovA6HIbJC1YbG2vpcGW1ReoIA2hVc4j1hrk0vFAY4
        +9isvwnCAN0IQiOiVjRgE8EdW1ofwIDuSkgLZ6TmpmLVk+vs6zlAnNLqQ2m0QFEwktUFpgfDbcksU
        Od/Rk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8sm-0001mP-9P; Tue, 20 Nov 2018 16:28:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F26EB1124DC2; Tue, 20 Nov 2018 16:28:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Add initial binding documentation" to the regulator tree
In-Reply-To: 
Message-Id: <20181120162811.F26EB1124DC2@debutante.sirena.org.uk>
Date:   Tue, 20 Nov 2018 16:28:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Add initial binding documentation

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

From 9e6d9c9b737326d880e52ebe5a845f4afde378ea Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 20 Nov 2018 14:16:28 +0000
Subject: [PATCH] regulator: lochnagar: Add initial binding documentation

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/cirrus,lochnagar.txt   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
new file mode 100644
index 000000000000..91974e6ee251
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
@@ -0,0 +1,82 @@
+Cirrus Logic Lochnagar Audio Development Board
+
+Lochnagar is an evaluation and development board for Cirrus Logic
+Smart CODEC and Amp devices. It allows the connection of most Cirrus
+Logic devices on mini-cards, as well as allowing connection of
+various application processor systems to provide a full evaluation
+platform.  Audio system topology, clocking and power can all be
+controlled through the Lochnagar, allowing the device under test
+to be used in a variety of possible use cases.
+
+This binding document describes the binding for the regulator portion
+of the driver.
+
+Also see these documents for generic binding information:
+  [1] Regulator: ../regulator/regulator.txt
+
+This binding must be part of the Lochnagar MFD binding:
+  [2] ../mfd/cirrus,lochnagar.txt
+
+Optional sub-nodes:
+
+  - VDDCORE : Initialisation data for the VDDCORE regulator, which
+    supplies the CODECs digital core if it has no build regulator for that
+    purpose.
+      Required Properties:
+      - compatible : One of the following strings:
+                     "cirrus,lochnagar2-vddcore"
+      - SYSVDD-supply: Primary power supply for the Lochnagar.
+
+  - MICVDD : Initialisation data for the MICVDD regulator, which
+    supplies the CODECs MICVDD.
+      Required Properties:
+      - compatible : One of the following strings:
+                     "cirrus,lochnagar2-micvdd"
+      - SYSVDD-supply: Primary power supply for the Lochnagar.
+
+  - MIC1VDD, MIC2VDD : Initialisation data for the MICxVDD supplies.
+      Required Properties:
+      - compatible : One of the following strings:
+                     "cirrus,lochnagar2-mic1vdd", "cirrus,lochnagar2-mic2vdd"
+      Optional Properties:
+      - cirrus,micbias-input : A property selecting which of the CODEC
+        minicard micbias outputs should be used, valid values are 1 - 4.
+      - MICBIAS1-supply, MICBIAS2-supply: Regulator supplies for the
+        MICxVDD outputs, supplying the digital microphones, normally
+        supplied from the attached CODEC.
+
+  - VDD1V8 : Recommended fixed regulator for the VDD1V8 regulator, which supplies the
+    CODECs analog and 1.8V digital supplies.
+      Required Properties:
+      - compatible : Should be set to "regulator-fixed"
+      - regulator-min-microvolt : Should be set to 1.8V
+      - regulator-max-microvolt : Should be set to 1.8V
+      - regulator-boot-on
+      - regulator-always-on
+      - vin-supply : Should be set to same supply as SYSVDD
+
+Example:
+
+lochnagar {
+	lochnagar-micvdd: MICVDD {
+		compatible = "cirrus,lochnagar2-micvdd";
+
+		SYSVDD-supply = <&wallvdd>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	lochnagar-vdd1v8: VDD1V8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDD1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+
+		vin-supply = <&wallvdd>;
+	};
+};
+
-- 
2.19.0.rc2

