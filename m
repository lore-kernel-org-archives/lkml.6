Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDPSq0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:46:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39668 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDPSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:46:25 -0400
From: Mark Brown <broonie@kernel.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        linux-kernel@vger.kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: topology: Modify clock gating parameter parsing to switch" to the asoc tree
In-Reply-To: <20180416175644.30081-1-k.marinushkin@gmail.com>
Message-Id: <E1f898s-0006OU-DU@debutante>
Date: Mon, 16 Apr 2018 19:46:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: topology: Modify clock gating parameter parsing to switch

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

>From fbeabd09236664f34ea3e4a9f7dcf5a0cdb7fc47 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Date: Mon, 16 Apr 2018 19:56:44 +0200
Subject: [PATCH] ASoC: topology: Modify clock gating parameter parsing to
 switch

This improves the coding style of this piece of code.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index aab31144f683..ec2ef7629dbb 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2007,11 +2007,19 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
 		/* clock gating */
-		if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
+		switch (hw_config->clock_gated) {
+		case SND_SOC_TPLG_DAI_CLK_GATE_GATED:
 			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
-		else if (hw_config->clock_gated ==
-			 SND_SOC_TPLG_DAI_CLK_GATE_CONT)
+			break;
+
+		case SND_SOC_TPLG_DAI_CLK_GATE_CONT:
 			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
+			break;
+
+		default:
+			/* ignore the value */
+			break;
+		}
 
 		/* clock signal polarity */
 		invert_bclk = hw_config->invert_bclk;
-- 
2.17.0
