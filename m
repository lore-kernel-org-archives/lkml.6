Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeDTREf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:04:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753530AbeDTREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:04:32 -0400
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5668: fix incorrect 'and' operator" to the asoc tree
In-Reply-To: <20180419143431.13173-1-colin.king@canonical.com>
Message-Id: <E1f9ZSM-0004Ws-HJ@debutante>
Date: Fri, 20 Apr 2018 18:04:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5668: fix incorrect 'and' operator

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

>From 4bb3f73a2da740e38f2e418bd0c468826046687a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 19 Apr 2018 15:34:31 +0100
Subject: [PATCH] ASoC: rt5668: fix incorrect 'and' operator

Currently logical and is being used instead of bitwise and. Fix this.

Detected by CoverityScan, CID#1468008 ("Logical vs bitwise operator")

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5668.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 52a343f96eb2..3c19d03f2446 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -1194,7 +1194,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	int ref, val, reg, idx = -EINVAL;
 	static const int div[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 
-	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &&
+	val = snd_soc_component_read32(component, RT5668_GPIO_CTRL_1) &
 		RT5668_GP4_PIN_MASK;
 	if (w->shift == RT5668_PWR_ADC_S1F_BIT &&
 		val == RT5668_GP4_PIN_ADCDAT2)
-- 
2.17.0
