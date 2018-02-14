Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030304AbeBNN3O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:29:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35118 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030221AbeBNN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:29:10 -0500
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, jcsing.lee@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung,tm2-audio DT binding documentation update" to the asoc tree
In-Reply-To: <20180205154403.13520-9-s.nawrocki@samsung.com>
Message-Id: <E1elx7U-0006r6-Ss@debutante>
Date: Wed, 14 Feb 2018 13:29:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung,tm2-audio DT binding documentation update

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

>From 3a3ac1ea898399f14748a358dd33262c97a9a86b Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Mon, 12 Feb 2018 17:15:36 +0100
Subject: [PATCH] ASoC: samsung,tm2-audio DT binding documentation update

This patch documents additional entries of the audio-codec and
i2s-controller properties required for the HDMI audio support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/samsung,tm2-audio.txt        | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
index 94442e5673b3..f5ccc12ddc00 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
@@ -4,9 +4,13 @@ Required properties:
 
  - compatible		 : "samsung,tm2-audio"
  - model		 : the user-visible name of this sound complex
- - audio-codec		 : the phandle of the wm5110 audio codec node,
-			   as described in ../mfd/arizona.txt
- - i2s-controller	 : the phandle of the I2S controller
+ - audio-codec		 : the first entry should be phandle of the wm5110 audio
+			   codec node, as described in ../mfd/arizona.txt;
+			   the second entry should be phandle of the HDMI
+			   transmitter node
+ - i2s-controller	 : the list of phandle and argument tuples pointing to
+			   I2S controllers, the first entry should be I2S0 and
+			   the second one I2S1
  - audio-amplifier	 : the phandle of the MAX98504 amplifier
  - samsung,audio-routing : a list of the connections between audio components;
 			   each entry is a pair of strings, the first being the
@@ -22,8 +26,8 @@ Example:
 
 sound {
 	compatible = "samsung,tm2-audio";
-	audio-codec = <&wm5110>;
-	i2s-controller = <&i2s0>;
+	audio-codec = <&wm5110>, <&hdmi>;
+	i2s-controller = <&i2s0 0>, <&i2s1 0>;
 	audio-amplifier = <&max98504>;
 	mic-bias-gpios = <&gpr3 2 0>;
 	model = "wm5110";
-- 
2.16.1
