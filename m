Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966284AbeBPMQW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:16:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965852AbeBPMQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:16:21 -0500
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh@kernel.org, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, fabio.estevam@nxp.com,
        andy.shevchenko@gmail.com, linux-imx@nxp.com, cosmin.samoila@nxp.com,
        daniel.baluta@nxp.com, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak5558: Add bindings for AK5558 ADC" to the asoc tree
In-Reply-To: <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
Message-Id: <E1emew7-0006lX-7w@debutante>
Date: Fri, 16 Feb 2018 12:16:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak5558: Add bindings for AK5558 ADC

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

>From af0424e44c180d66c2ddfb0a99c52382de8f69f8 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 13 Feb 2018 16:29:34 +0200
Subject: [PATCH] ASoC: ak5558: Add bindings for AK5558 ADC

Document the bindings for AK5558 ADC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 000000000000..7d67ca6ced80
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,22 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- reset-gpios: A GPIO specifier for the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: adc@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.16.1
