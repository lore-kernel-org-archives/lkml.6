Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934936AbeBLMyp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:54:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934969AbeBLMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:54:38 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add DT bindings documentation for UniPhier AIO" to the asoc tree
In-Reply-To: <20171122114321.29196-4-suzuki.katsuhiro@socionext.com>
Message-Id: <E1elDcw-0007Dv-68@debutante>
Date: Mon, 12 Feb 2018 12:54:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add DT bindings documentation for UniPhier AIO

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

>From 28fb53de064b24eed55540ddeccab517e4babca3 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 19 Jan 2018 18:25:28 +0900
Subject: [PATCH] ASoC: uniphier: add DT bindings documentation for UniPhier
 AIO

This patch adds DT binding documentation for UniPhier
AIO audio subsystem.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/uniphier,aio.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt

diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
new file mode 100644
index 000000000000..73f6c27ae4f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
@@ -0,0 +1,36 @@
+Socionext UniPhier SoC audio driver
+
+The Socionext UniPhier audio subsystem consists of I2S and S/PDIF blocks in
+the same register space.
+
+Required properties:
+- compatible      : should be one of the following:
+		    "socionext,uniphier-ld11-aio"
+		    "socionext,uniphier-ld20-aio"
+- reg             : offset and length of the register set for the device.
+- interrupts      : should contain I2S or S/PDIF interrupt.
+- pinctrl-names   : should be "default".
+- pinctrl-0       : defined I2S signal pins for an external codec chip.
+- clock-names     : should include following entries:
+                    "aio"
+- clocks          : a list of phandle, should contain an entry for each
+                    entry in clock-names.
+- reset-names     : should include following entries:
+                    "aio"
+- resets          : a list of phandle, should contain an entry for each
+                    entry in reset-names.
+- #sound-dai-cells: should be 1.
+
+Example:
+	audio {
+		compatible = "socionext,uniphier-ld20-aio";
+		reg = <0x56000000 0x80000>;
+		interrupts = <0 144 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_aout>;
+		clock-names = "aio";
+		clocks = <&sys_clk 40>;
+		reset-names = "aio";
+		resets = <&sys_rst 40>;
+		#sound-dai-cells = <1>;
+	};
-- 
2.16.1
