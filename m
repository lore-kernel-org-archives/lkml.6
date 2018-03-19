Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754916AbeCSBD0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:03:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49138 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754230AbeCSBDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:03:23 -0400
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: Mark unused Odroid compatibles as deprecated" to the asoc tree
In-Reply-To: <20180318153512.8343-1-krzk@kernel.org>
Message-Id: <20180319010315.ECCA1440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 01:03:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: Mark unused Odroid compatibles as deprecated

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

>From 3b84574d95c020f01410ff2ca0a38dd8fd7b644b Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 18 Mar 2018 16:35:12 +0100
Subject: [PATCH] ASoC: samsung: Mark unused Odroid compatibles as deprecated

Compatible for XU4 audio is not being used.  Instead the board uses the
same compatible as XU3.  The devices are now just compatible so they
should use the same value.  Mark "hardkernel,odroid-xu4-audio" as being
deprecated so in this future could be removed to limit useless
properties.

Additionally add older compatibles appearing in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/samsung,odroid.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
index f35a2694eb04..e9da2200e173 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
@@ -3,7 +3,9 @@ Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
 Required properties:
 
  - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
-		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board
+		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
+		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
+		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
  - model - the user-visible name of this sound complex
  - clocks - should contain entries matching clock names in the clock-names
     property
-- 
2.16.2
