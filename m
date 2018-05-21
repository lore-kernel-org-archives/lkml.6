Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpP8qOevQSNNq93hYhQO55HkUtWOq0GhOWY6TXTF4aYkp9P1mCkon7t7VDW7mVrFRdkRg1d
ARC-Seal: i=1; a=rsa-sha256; t=1526917731; cv=none;
        d=google.com; s=arc-20160816;
        b=pxpiHnCmQiaWEqpWQX9IZzpGIyZ2sQ5BbAWLES2db0+As0eOSL+JzyBNJur4EHNrIv
         zEj06SbUzDuBwHX9hJ6roN7FHslvrxwctq7DjuCvz7F3t+/yJNjceH3AHA6BA2O5KEsi
         FblKLe/Xnm5yMwZ3/2cYzPXv5tpzupOJtN+waYU1wLx8eW+D7s6cuwBkcu+3d61BUU6W
         NVffYvpC+yHxFmTpqG0/RyICAVr4EFL0xcH+0oavoLCnhBBvOnwWw7PElH7e1RBUelB+
         QibJj6LV4qqK45q8gXh029CHVgVe0KVqhxv1jm2K0PtnKJkNLlfNWUBV1P6RHLz2AITu
         1Sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BN8UXT55mh65V0r2HU92YZp9lRlq5gNHEgdOmC4xrO4=;
        b=C149aZXeSYOJyGYvnSEC+701TVoxaAJVaMiwrD7S2Fa0TLGwCBitiwj8GDRaB4zx0f
         geB7gRCOXM3YlF8y4wsqBMfW726Gl8epOU37vbMDGWmCT1x844Iem7B+OBb9R7OK02Op
         XaMfgOEQOjOfJo4WwjH4rRvvV3Flzj+hZrK6G9g3b7+DLj4pUzhG5/6hv++WesTTsbzC
         5LZgUA0ZYxu1PjU0EyskFKm8K2uRnEcGJfDU0/rnzSyvoDcqTMP2HMqg8KZ/fbsMjhqF
         b1K7z+xHmn2ibEg5asYYZ/bziYPKFfAlaEptoma77wMU2fVJLA+w5roWtzl9iDPISOmS
         KWnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Z9ICNyRf;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Z9ICNyRf;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Mukunda@sirena.org.uk, Vijendar <Vijendar.Mukunda@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, , "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: pte offset related dma driver changes" to the asoc tree
In-Reply-To: <1525207810-1305-4-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <E1fKn3I-0007MB-1v@debutante>
Date: Mon, 21 May 2018 16:48:48 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089286679491699?=
X-GMAIL-MSGID: =?utf-8?q?1601089286679491699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: amd: pte offset related dma driver changes

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

>From e188c525b9e193bc5aec97c824bc0cd1a9cb6aeb Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:47 +0530
Subject: [PATCH] ASoC: amd: pte offset related dma driver changes

Added pte offset variable in audio_substream_data structure.
Added Stoney related PTE offset macros in acp header file.
Modified hw_params callback to assign the pte offset value
based on asic_type.
PTE Offset macros used to calculate no of PTE entries
need to be programmed when memory allocated for audio buffer.
Depending upon allocated audio buffer size, PTE offset values
will change.
Compared to CZ, Stoney has SRAM memory limitation i.e 48k
It is required to define separate PTE Offset macros for
Stoney.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
 sound/soc/amd/acp.h         |  5 +++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e6d59f47ed00..a3a7470a54db 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 pte_offset, sram_bank;
+	u32 sram_bank;
 
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-	} else {
-		pte_offset = ACP_CAPTURE_PTE_OFFSET;
+	else {
 		switch (asic_type) {
 		case CHIP_STONEY:
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
@@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		}
 	}
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
-		       pte_offset);
+		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, pte_offset,
+				       rtd->direction, rtd->pte_offset,
 				       rtd->ch1, sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
@@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+		}
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		rtd->destination = TO_ACP_I2S_1;
@@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
 		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+		}
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 82470bc710f0..2f48d1d25243 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -10,6 +10,10 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
 
@@ -90,6 +94,7 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u32 pte_offset;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-- 
2.17.0
