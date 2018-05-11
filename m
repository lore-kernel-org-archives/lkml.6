Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqpkapZ63YDdjbfdGy3C1h/ermngvFZhfbzwa+q6WGQ4q9dg/YxHDIt5uWqe/nvYX7g54+7
ARC-Seal: i=1; a=rsa-sha256; t=1526008831; cv=none;
        d=google.com; s=arc-20160816;
        b=oFO5GCvkoDSJK1sgKRgNYv6Sy6H1y30ESIZcBI9xw9siUMcaSgRgfdIntgOeGOGzsc
         r7j4OdQW0841X6Xj5KcckiO4eDadVaidbBj1PEQ05KcVECyjhvywkyLPcF/C+LU+x/yJ
         ghT7TGaCL6+PLOxRJsaN+cX12g3y1UfEpeBPRGAXfrmLwSDOEMnOb95ZBBviAkZ0hWcC
         TwjO1lnIt7VwRTJ2/xFQAyc43vBIkr6DpjNEL4u6VBK6Vfa+SzbjYNiGg4d289IkNjnZ
         qzcqp1kxPjki+iELtvWqzKlA6mk+rXe/Pfp6J8EfcvAoWbjPya6oVsgMtNCXnmS2kFrf
         Pv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=qw2NmvcxNaqxuyuooKEUlhAXtUY/x0eDaqTum7BXjqE=;
        b=ymcg9wBmgwtMB8YQtFoF6x6QHxNzt9ENWHCj+bwErOCbDXCOOn1+CvL99yAuWgQu7C
         Dgd4ujjctM1VcEowjlw1hfeCVY891IT9IfaS4ewFT4kpwgO8Zo734G/hSIB1LRJfqaF0
         bd2bWPr7Q1EJyyd/cjqXcmH2qHfUhpSscBDKfB7NLFimZEQ7drNnvqoPugxh6WJqenU4
         PML26FO+urWuNO8/Qt6y+aNzDlwny5FXqPbB8ElPxdc/Sxo4VF+ChzFlWE7v5PpFmyh0
         CTA49h7vHhaf3by/PV2Y3o9Y+aSmU14KX+7XppcGS2c2pPgS4MyIdwnHSg1jOAQSc1lr
         p8dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=LnrZsHrK;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=LnrZsHrK;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>, , Kate Stewart <kstewart@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC, AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: added byte count register offset variables to rtd" to the asoc tree
In-Reply-To: <1525207810-1305-2-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20180511032022.289FC44007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:20:22 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600136236356965631?=
X-GMAIL-MSGID: =?utf-8?q?1600136236356965631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: amd: added byte count register offset variables to rtd

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

>From 7f0048478470046c9efc956c6100b70836ac9f97 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:45 +0530
Subject: [PATCH] ASoC: amd: added byte count register offset variables to rtd

Added byte count register offset variables to audio_substream_data
structure. Modified dma pointer callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++---------------------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index fa451d0408b4..3dc3de1040a4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -793,12 +793,18 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+		rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+		rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 	}
 
 	size = params_buffer_bytes(params);
@@ -834,26 +840,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
+static u64 acp_get_byte_count(struct audio_substream_data *rtd)
 {
-	union acp_dma_count playback_dma_count;
-	union acp_dma_count capture_dma_count;
-	u64 bytescount = 0;
+	union acp_dma_count byte_count;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
-					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
-		playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
-					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
-		bytescount = playback_dma_count.bytescount;
-	} else {
-		capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
-		capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
-		bytescount = capture_dma_count.bytescount;
-	}
-	return bytescount;
+	byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_high_reg_offset);
+	byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
+					      rtd->byte_cnt_low_reg_offset);
+	return byte_count.bytescount;
 }
 
 static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
@@ -869,7 +864,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
+	bytescount = acp_get_byte_count(rtd);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (bytescount > rtd->i2ssp_renderbytescount)
@@ -925,8 +920,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		bytescount = acp_get_byte_count(rtd->acp_mmio,
-						substream->stream);
+		bytescount = acp_get_byte_count(rtd);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 5e25428e6bbe..3b076c6a0ae2 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -90,6 +90,8 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u32 byte_cnt_high_reg_offset;
+	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
 	u64 i2ssp_renderbytescount;
 	u64 i2ssp_capturebytescount;
-- 
2.17.0
