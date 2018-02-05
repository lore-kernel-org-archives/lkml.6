Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeBEPUu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:20:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeBEPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:20:43 -0500
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Cc: olivier moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        olivier.moysan@st.com, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: add of dependency for stm32 drivers" to the asoc tree
In-Reply-To: <1517827785-6275-1-git-send-email-olivier.moysan@st.com>
Message-Id: <E1eiiYs-0007FQ-II@debutante>
Date: Mon, 05 Feb 2018 15:20:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: add of dependency for stm32 drivers

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

>From 748bce8e6c7ebae2d89314a42e0c4b65232a0ce9 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 5 Feb 2018 11:49:45 +0100
Subject: [PATCH] ASoC: stm32: add of dependency for stm32 drivers

Add of dependency for STM32 ASoC drivers.
DFSDM of dependency is already inherited
from STM32_DFSDM_ADC dependency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 3ad881fc40a1..48f9ddd94016 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -2,7 +2,7 @@ menu "STMicroelectronics STM32 SOC audio support"
 
 config SND_SOC_STM32_SAI
 	tristate "STM32 SAI interface (Serial Audio Interface) support"
-	depends on ARCH_STM32 || COMPILE_TEST
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -11,7 +11,7 @@ config SND_SOC_STM32_SAI
 
 config SND_SOC_STM32_I2S
 	tristate "STM32 I2S interface (SPI/I2S block) support"
-	depends on ARCH_STM32 || COMPILE_TEST
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
@@ -20,7 +20,7 @@ config SND_SOC_STM32_I2S
 
 config SND_SOC_STM32_SPDIFRX
 	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
-	depends on ARCH_STM32 || COMPILE_TEST
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
2.15.1
