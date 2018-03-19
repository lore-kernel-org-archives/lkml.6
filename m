Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755058AbeCSBl1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:41:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCSBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:41:12 -0400
From: Mark Brown <broonie@kernel.org>
To: Matt Porter <mporter@konsulko.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: add tda7419 audio processor binding" to the asoc tree
In-Reply-To: <20180318172238.9795-2-mporter@konsulko.com>
Message-Id: <20180319014101.ADC1344007A@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:41:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: add tda7419 audio processor binding

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 050a0e1f539448474250f441332c0a7d9714d3b5 Mon Sep 17 00:00:00 2001
From: Matt Porter <mporter@konsulko.com>
Date: Sun, 18 Mar 2018 13:22:37 -0400
Subject: [PATCH] ASoC: add tda7419 audio processor binding

DeviceTree binding for the tda7419 audio processor.

Signed-off-by: Matt Porter <mporter@konsulko.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tda7419.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt

diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
new file mode 100644
index 000000000000..6b85ec38dd56
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda7419.txt
@@ -0,0 +1,38 @@
+TDA7419 audio processor
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "st,tda7419"
+- reg : the I2C address of the device.
+- vdd-supply : a regulator spec for the common power supply (8-10V)
+
+Optional properties:
+
+- st,mute-gpios : a GPIO spec for the MUTE pin.
+
+Pins on the device (for linking into audio routes):
+
+  * SE3L
+  * SE3R
+  * SE2L
+  * SE2R
+  * SE1L
+  * SE1R
+  * DIFFL
+  * DIFFR
+  * MIX
+  * OUTLF
+  * OUTRF
+  * OUTLR
+  * OUTRR
+  * OUTSW
+
+Example:
+
+ap: tda7419@44 {
+	compatible = "st,tda7419";
+	reg = <0x44>;
+	vdd-supply = <&vdd_9v0_reg>;
+};
-- 
2.16.2
