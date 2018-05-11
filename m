Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqoh/VUQ/WJppF2xbCvZp5h6SE/PHoG7dmBVtJVPuuQhSlrO/t+nDXaYt5LPkxwu4AZnEbt
ARC-Seal: i=1; a=rsa-sha256; t=1526008875; cv=none;
        d=google.com; s=arc-20160816;
        b=IhOBjO8ES+AcDNev4uLFDSb/gQMccR1TdVLN3YHQPm3JJACcZG6L6n3OZs6hqtf850
         UxzMBu8x2y89DHaA/C7B1epE5eyeM/FuReBDdYsqA9aVb63hdugPTPREfR1JNXouv3HJ
         YY7G8YWSKvqw5O/b0+YJ5HeLsrt12j8tZyrmMCm9SYfYhBl0gST8cDM62KpONwEpdi7C
         wDJCuvWXVuD7hgzCedz2JdwGdxxscPfvsnP+twmLPEZ3oBPabyGCyNAgQeY5vQ/ttmlO
         gTeEGKKCHAMBh8CQsdTCamUkJ4S3XDnJrY8grU5doqavsW2BjA+cQSy3AK6rJRnSC+XQ
         /31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=x6zB+hrNwq/xcSQKODwW4pCYi7dHDZqJ1oiLTMgLYn8=;
        b=oUxe+7JtTMiTTcUaaBsJd99wja192BS7ZCKCX8rgDgb5a/i4LucRyupMf2WM3ChttM
         w1ILvi/4Tlt0PEQF2DPKLy2KbiG28mP01AX9ZCsnaUrKsjJbIZaXogoexWGyhhXiTqoK
         qHWSJZx4bJk5c9FWwtWmLH9EJbK5mssqrWMe301rVK17KbFnUqPSJwLuwzDrSOcTfExy
         wGtJ1NvnFIfKWKupEE9Zl8TWt5AahlgT5WdiVRYQdy+QlKUmRhgy8GMg1FL2i4shw0Ie
         AGm3bS6tkSrwmtGjmBp30t83goz3zFBEClc92g0XV5poFnqtHTR/2lHc2O/sahG4R+FJ
         5r8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=LvomPg+1;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=LvomPg+1;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>, , Kate Stewart <kstewart@linuxfoundation.org>, "moderated list:SOUND - SOC, LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: dma config parameters changes" to the asoc tree
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20180511032054.6106444007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:20:54 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600136283014755757?=
X-GMAIL-MSGID: =?utf-8?q?1600136283014755757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: amd: dma config parameters changes

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

>From 8769bb55fe1d9912c9cd9e008afb14e22a762103 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:44 +0530
Subject: [PATCH] ASoC: amd: dma config parameters changes

Added dma configuration parameters to rtd structure.
Moved dma configuration parameters initialization to
hw_params callback.
Removed hard coding in prepare and trigger callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 103 +++++++++++++++---------------------
 sound/soc/amd/acp.h         |   5 ++
 2 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 2b9a020e0b3e..fa451d0408b4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -321,19 +321,12 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
-	u16 ch1, ch2, destination, dma_dscr_idx;
 
 	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-		destination = TO_ACP_I2S_1;
-
 	} else {
 		pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		switch (asic_type) {
 		case CHIP_STONEY:
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
@@ -341,30 +334,19 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		default:
 			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
 		}
-		destination = FROM_ACP_I2S_1;
 	}
-
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       pte_offset);
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, pte_offset, ch1,
-				       sram_bank, dma_dscr_idx, asic_type);
-
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+				       rtd->direction, pte_offset,
+				       rtd->ch1, sram_bank,
+				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, sram_bank,
-				       destination, ch2, dma_dscr_idx,
-				       asic_type);
+				       rtd->destination, rtd->ch2,
+				       rtd->dma_dscr_idx_2, asic_type);
 }
 
 /* Start a given DMA channel transfer */
@@ -804,6 +786,21 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->destination = TO_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+	} else {
+		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
+		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+		rtd->destination = FROM_ACP_I2S_1;
+		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
@@ -898,21 +895,15 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 
 	if (!rtd)
 		return -EINVAL;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-				       PLAYBACK_START_DMA_DESCR_CH12,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-				       PLAYBACK_START_DMA_DESCR_CH13,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-	} else {
-		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-				       CAPTURE_START_DMA_DESCR_CH14,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-		config_acp_dma_channel(rtd->acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-				       CAPTURE_START_DMA_DESCR_CH15,
-				       NUM_DSCRS_PER_CHANNEL, 0);
-	}
+
+	config_acp_dma_channel(rtd->acp_mmio,
+			       rtd->ch1,
+			       rtd->dma_dscr_idx_1,
+			       NUM_DSCRS_PER_CHANNEL, 0);
+	config_acp_dma_channel(rtd->acp_mmio,
+			       rtd->ch2,
+			       rtd->dma_dscr_idx_2,
+			       NUM_DSCRS_PER_CHANNEL, 0);
 	return 0;
 }
 
@@ -939,10 +930,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      SYSRAM_TO_ACP_CH_NUM, false);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-						BIT(SYSRAM_TO_ACP_CH_NUM)) {
+				BIT(rtd->ch1)) {
 				if (!loops--) {
 					dev_err(component->dev,
 						"acp dma start timeout\n");
@@ -950,38 +940,31 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-
-			acp_dma_start(rtd->acp_mmio,
-				      ACP_TO_I2S_DMA_CH_NUM, true);
-
 		} else {
 			if (rtd->i2ssp_capturebytescount == 0)
 				rtd->i2ssp_capturebytescount = bytescount;
-			acp_dma_start(rtd->acp_mmio,
-				      I2S_TO_ACP_DMA_CH_NUM, true);
 		}
+		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/*
-		 * Need to stop only circular DMA channels :
-		 * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM. Non-circular
-		 * channels will stopped automatically after its transfer
-		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
+		/* For playback, non circular dma should be stopped first
+		 * i.e Sysram to acp dma transfer channel(rtd->ch1) should be
+		 * stopped before stopping cirular dma which is acp sram to i2s
+		 * fifo dma transfer channel(rtd->ch2). Where as in Capture
+		 * scenario, i2s fifo to acp sram dma channel(rtd->ch2) stopped
+		 * first before stopping acp sram to sysram which is circular
+		 * dma(rtd->ch1).
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   SYSRAM_TO_ACP_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_I2S_DMA_CH_NUM);
+			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
+			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			rtd->i2ssp_renderbytescount = 0;
 		} else {
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   I2S_TO_ACP_DMA_CH_NUM);
-			ret = acp_dma_stop(rtd->acp_mmio,
-					   ACP_TO_SYSRAM_CH_NUM);
+			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0e6089b4f8a0..5e25428e6bbe 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -85,6 +85,11 @@ struct audio_substream_data {
 	unsigned int order;
 	u16 num_of_pages;
 	u16 direction;
+	u16 ch1;
+	u16 ch2;
+	u16 destination;
+	u16 dma_dscr_idx_1;
+	u16 dma_dscr_idx_2;
 	uint64_t size;
 	u64 i2ssp_renderbytescount;
 	u64 i2ssp_capturebytescount;
-- 
2.17.0
