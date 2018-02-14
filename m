Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030388AbeBNNaA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:30:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030218AbeBNN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:29:25 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Update clock-output-names property documentation" to the asoc tree
In-Reply-To: <20180212161538.22669-2-s.nawrocki@samsung.com>
Message-Id: <E1elx7i-00072C-Rz@debutante>
Date: Wed, 14 Feb 2018 13:29:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Update clock-output-names property documentation

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

>From e2ce852a7464fe3caaf72f9f3da87d2bfcf3eb84 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Feb 2018 17:15:32 +0100
Subject: [PATCH] ASoC: samsung: i2s: Update clock-output-names property
 documentation

The clock-output-names property is marked as deprecated. While at it,
and few typos are fixed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/samsung-i2s.txt        | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index bf100cd0d0f7..c1f508f18ac8 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -7,7 +7,7 @@ Required SoC Specific Properties:
    - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
      secondary fifo, s/w reset control and internal mux for root clk src.
    - samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
-     playback, sterio channel capture, secondary fifo using internal
+     playback, stereo channel capture, secondary fifo using internal
      or external dma, s/w reset control, internal mux for root clk src
      and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
      is to allow transfer of multiple channel audio data on single data line.
@@ -25,7 +25,7 @@ Required SoC Specific Properties:
   These strings correspond 1:1 with the ordered pairs in dmas.
 - clocks: Handle to iis clock and RCLK source clk.
 - clock-names:
-  i2s0 uses some base clks from CMU and some are from audio subsystem internal
+  i2s0 uses some base clocks from CMU and some are from audio subsystem internal
   clock controller. The clock names for i2s0 should be "iis", "i2s_opclk0" and
   "i2s_opclk1" as shown in the example below.
   i2s1 and i2s2 uses clocks from CMU. The clock names for i2s1 and i2s2 should
@@ -36,9 +36,9 @@ Required SoC Specific Properties:
 - #clock-cells: should be 1, this property must be present if the I2S device
   is a clock provider in terms of the common clock bindings, described in
   ../clock/clock-bindings.txt.
-- clock-output-names: from the common clock bindings, names of the CDCLK
-  I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
-  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices recpectively.
+- clock-output-names (deprecated): from the common clock bindings, names of
+  the CDCLK I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
+  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices respectively.
 
 There are following clocks available at the I2S device nodes:
  CLK_I2S_CDCLK    - the CDCLK (CODECLKO) gate clock,
@@ -49,9 +49,10 @@ There are following clocks available at the I2S device nodes:
 
 Refer to the SoC datasheet for availability of the above clocks.
 The CLK_I2S_RCLK_PSR and CLK_I2S_RCLK_SRC clocks are usually only available
-in the IIS Multi Audio Interface (I2S0).
-Note: Old DTs may not have the #clock-cells, clock-output-names properties
-and then not use the I2S node as a clock supplier.
+in the IIS Multi Audio Interface.
+
+Note: Old DTs may not have the #clock-cells property and then not use the I2S
+node as a clock supplier.
 
 Optional SoC Specific Properties:
 
@@ -74,8 +75,7 @@ i2s0: i2s@3830000 {
 		<&clock_audss EXYNOS_I2S_BUS>,
 		<&clock_audss EXYNOS_SCLK_I2S>;
 	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-	#clock-cells;
-	clock-output-names = "i2s_cdclk0";
+	#clock-cells = <1>;
 	samsung,idma-addr = <0x03000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s0_bus>;
-- 
2.16.1
