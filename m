Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032543AbeBNQ2f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:28:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032444AbeBNQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:28:32 -0500
From: Mark Brown <broonie@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: dt: regulator-name is required property" to the regulator tree
In-Reply-To: <1518532988-10990-1-git-send-email-harald@ccbib.org>
Message-Id: <E1elzv3-0005l2-MP@debutante>
Date: Wed, 14 Feb 2018 16:28:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: dt: regulator-name is required property

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

>From 4b75291621830acad2c66a1d21d7840a7ca169d3 Mon Sep 17 00:00:00 2001
From: Harald Geyer <harald@ccbib.org>
Date: Tue, 13 Feb 2018 14:43:08 +0000
Subject: [PATCH] regulator: dt: regulator-name is required property

These two drivers fail to probe if no name is provided. For details see:
https://www.spinics.net/lists/kernel/msg2457515.html

Signed-off-by: Harald Geyer <harald@ccbib.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/fixed-regulator.txt | 1 +
 Documentation/devicetree/bindings/regulator/gpio-regulator.txt  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
index 4fae41d54798..0c2a6c8a1536 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -2,6 +2,7 @@ Fixed Voltage regulators
 
 Required properties:
 - compatible: Must be "regulator-fixed";
+- regulator-name: Defined in regulator.txt as optional, but required here.
 
 Optional properties:
 - gpio: gpio to use for enable control
diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index dd1ed789728e..1f496159e2bb 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -2,6 +2,8 @@ GPIO controlled regulators
 
 Required properties:
 - compatible		: Must be "regulator-gpio".
+- regulator-name	: Defined in regulator.txt as optional, but required
+			  here.
 - states		: Selection of available voltages and GPIO configs.
                           if there are no states, then use a fixed regulator
 
-- 
2.16.1
