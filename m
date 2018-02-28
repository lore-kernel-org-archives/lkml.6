Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeB1LGr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:06:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeB1LGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:06:42 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: add DT bindings documentation for ROHM BD28623 codec" to the asoc tree
In-Reply-To: <20180223011717.2799-2-suzuki.katsuhiro@socionext.com>
Message-Id: <E1eqzZ4-0005EU-E1@debutante>
Date: Wed, 28 Feb 2018 11:06:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: add DT bindings documentation for ROHM BD28623 codec

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

>From f5ca3ab9bc1b160966c1e5cc7bf831f7b8ec31e5 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 23 Feb 2018 10:17:16 +0900
Subject: [PATCH] ASoC: add DT bindings documentation for ROHM BD28623 codec

This patch adds DT bindings documentation for ROHM BD28623MUV
class D speaker amplifier.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/rohm,bd28623.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt

diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
new file mode 100644
index 000000000000..d84557c2686e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
@@ -0,0 +1,29 @@
+ROHM BD28623MUV Class D speaker amplifier for digital input
+
+This codec does not have any control buses such as I2C, it detect format and
+rate of I2S signal automatically. It has two signals that can be connected
+to GPIOs: reset and mute.
+
+Required properties:
+- compatible      : should be "rohm,bd28623"
+- #sound-dai-cells: should be 0.
+- VCCA-supply     : regulator phandle for the VCCA supply
+- VCCP1-supply    : regulator phandle for the VCCP1 supply
+- VCCP2-supply    : regulator phandle for the VCCP2 supply
+
+Optional properties:
+- reset-gpios     : GPIO specifier for the active low reset line
+- mute-gpios      : GPIO specifier for the active low mute line
+
+Example:
+
+	codec {
+		compatible = "rohm,bd28623";
+		#sound-dai-cells = <0>;
+
+		VCCA-supply = <&vcc_reg>;
+		VCCP1-supply = <&vcc_reg>;
+		VCCP2-supply = <&vcc_reg>;
+		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	};
-- 
2.16.1
