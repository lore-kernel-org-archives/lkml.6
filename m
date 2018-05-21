Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeEUPwD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:52:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbeEUPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:48:29 -0400
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Fix clocks in CZ DA7219 machine driver" to the asoc tree
In-Reply-To: <1524741374-13523-9-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <E1fKn2x-0007HJ-0U@debutante>
Date: Mon, 21 May 2018 16:48:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Fix clocks in CZ DA7219 machine driver

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

>From 6e554074955b453e8c8d671ec523d273703f2a59 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 8 May 2018 10:17:51 +0530
Subject: [PATCH] ASoC: AMD: Fix clocks in CZ DA7219 machine driver

System clock on the platform is 25Mhz and not 24Mhz.

PLL_OUT for da7219 codec to use DA7219_PLL_FREQ_OUT_98304
as it is for 48KHz SR.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 6495eedc3d4c..fa5ad5b468a2 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -39,8 +39,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 24000000
-#define MCLK_RATE 24576000
+#define CZ_PLAT_CLK 25000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
@@ -63,7 +62,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
-				  CZ_PLAT_CLK, MCLK_RATE);
+				  CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 		return ret;
-- 
2.17.0
