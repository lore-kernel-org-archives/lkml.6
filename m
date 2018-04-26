Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756284AbeDZOTO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:19:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754727AbeDZOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:19:13 -0400
From: Mark Brown <broonie@kernel.org>
To: Mukunda@sirena.org.uk, Vijendar <Vijendar.Mukunda@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: rename audio_substream_data variable" to the asoc tree
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <E1fBhjm-0003zD-9F@debutante>
Date: Thu, 26 Apr 2018 15:19:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: rename audio_substream_data variable

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

>From 8349b7f53da03a46c08cb6c33833df68837b61e0 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Thu, 26 Apr 2018 16:45:47 +0530
Subject: [PATCH] ASoC: amd: rename audio_substream_data variable

In order to make audio_substream_data structure variable
consistent throughout the code, changed the name from
audio_config to rtd wherever applicable.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5ffe2efc6363..9c026c4d26d4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -317,13 +317,13 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			   struct audio_substream_data *audio_config,
+			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
 	u16 ch1, ch2, destination, dma_dscr_idx;
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
 		ch1 = SYSRAM_TO_ACP_CH_NUM;
 		ch2 = ACP_TO_I2S_DMA_CH_NUM;
@@ -344,25 +344,25 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		destination = FROM_ACP_I2S_1;
 	}
 
-	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
+	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       pte_offset);
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 	else
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
-	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset, ch1,
+	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, pte_offset, ch1,
 				       sram_bank, dma_dscr_idx, asic_type);
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
 	else
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
-	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, sram_bank,
+	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, sram_bank,
 				       destination, ch2, dma_dscr_idx,
 				       asic_type);
 }
-- 
2.17.0
