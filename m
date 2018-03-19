Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeCSBDr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:03:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbeCSBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:03:40 -0400
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add syscon property to binding document" to the asoc tree
In-Reply-To: <20180316070813.17969-2-suzuki.katsuhiro@socionext.com>
Message-Id: <20180319010333.39BE2440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add syscon property to binding document

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

>From 8bde8fd64d1b8f8bc1577e28ff412553597b6adb Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 16 Mar 2018 16:08:12 +0900
Subject: [PATCH] ASoC: uniphier: add syscon property to binding document

This patch adds syscon property for specifying soc-glue core into
DT binding documentation.

Currently, soc-glue core is used for changing the state of S/PDIF
signal output pin to signal output state or Hi-Z state. If you don't
need to use features on soc-glue described above you can ommit this
property.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/uniphier,aio.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/uniphier,aio.txt b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
index 65d71cf6ef0f..4ce68ed6f2f2 100644
--- a/Documentation/devicetree/bindings/sound/uniphier,aio.txt
+++ b/Documentation/devicetree/bindings/sound/uniphier,aio.txt
@@ -22,6 +22,12 @@ Required properties:
                     entry in reset-names.
 - #sound-dai-cells: should be 1.
 
+Optional properties:
+- socionext,syscon: a phandle, should contain soc-glue.
+                    The soc-glue is used for changing mode of S/PDIF signal pin
+                    to Output from Hi-Z. This property is optional if you use
+                    I2S signal pins only.
+
 Example:
 	audio {
 		compatible = "socionext,uniphier-ld20-aio";
@@ -34,4 +40,6 @@ Example:
 		reset-names = "aio";
 		resets = <&sys_rst 40>;
 		#sound-dai-cells = <1>;
+
+		socionext,syscon = <&sg>;
 	};
-- 
2.16.2
