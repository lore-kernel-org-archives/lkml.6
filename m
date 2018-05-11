Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZr19okhaOEYOGc05I7A6pU9MAy6dqBtqaVKS324eA0qFIi9DtOSG0hvyAVVQopubhD9DD1y
ARC-Seal: i=1; a=rsa-sha256; t=1526008810; cv=none;
        d=google.com; s=arc-20160816;
        b=HBCy1kNFP6Nc28CzV9KYgNpppWtlLNXtYwwnS8s+DH1mXxKcBZkgQIYCD1zKqDon8b
         Vds2I/3oWbFpoBLmHyGssnFYFoniPyrlEyCdzbG9vBAlV70RHGSQxoZNhn8QgW9eNJHR
         v38FD+puaQAZs4t6OSgxgFCLMBIr0m+L1mu0fuuGqL9GTi0FuDVD+Nx23FILt7Zn3PKA
         QPNIMxPCWjB4tUCifgKEN11+jN4adxXDy/5t9xudL/abldLto2sf54XB/ktQYYL5uPMm
         cpFGrdfRUc70Sg27T/EkMS/HeFRwSxhnmqmAt4VsAu7+1jN1K/jp8Gqe+8UZVdVuOrTK
         XtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=2nTsvkF80Z/v2bO1u+wtL2WBf+1ONkqByOQ7uHlo4TE=;
        b=XBOG0qq4vk+YKB/PWlynW2fabKkaoJkDtoZdowxgPpDugK0/rkIZr5Uop2zOlI/l1z
         /KTWj9sq8nCxdfi9xiRNJwFaW7NOLfHe+DN1F8+AthuM1/M4hHJqJ0rOWAJmbQrkry30
         a9+Kg3RGDSpmslp2rq/x+kdk2pumigZd6Bk1i6EbDAeDHR9NEMAH4GZRzwWlZz30MIix
         N3paCp5qTkqzfAxgn+bGs/TVD3HYPnzzkootSKl664ie8u5Z23qgj1sq+Bumn50axjoF
         7wEjGXxQnmL50Bi3PAAwC5ArxwEkgheM9sJfpzX8UirpdQbJ7GEFtWs+PGPSnbx8x0YM
         pvVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Qp8SgAWV;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Qp8SgAWV;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>, , "moderated list:SOUND - SOC, LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: removed separate byte count variables for playback and capture" to the asoc tree
In-Reply-To: <1525207810-1305-3-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20180511031949.8371744007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:19:49 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600136214378141453?=
X-GMAIL-MSGID: =?utf-8?q?1600136214378141453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: amd: removed separate byte count variables for playback and capture

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

>From 9af8937e5589693f888e855b052dde5c45fb4a1f Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:46 +0530
Subject: [PATCH] ASoC: amd: removed separate byte count variables for playback
 and capture

Removed separate byte count variables for playback and capture.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
 sound/soc/amd/acp.h         |  3 +--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3dc3de1040a4..e6d59f47ed00 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (bytescount > rtd->i2ssp_renderbytescount)
-			bytescount = bytescount - rtd->i2ssp_renderbytescount;
-	} else {
-		if (bytescount > rtd->i2ssp_capturebytescount)
-			bytescount = bytescount - rtd->i2ssp_capturebytescount;
-	}
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
@@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		bytescount = acp_get_byte_count(rtd);
+		if (rtd->bytescount == 0)
+			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (rtd->i2ssp_renderbytescount == 0)
-				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 				BIT(rtd->ch1)) {
@@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				}
 				cpu_relax();
 			}
-		} else {
-			if (rtd->i2ssp_capturebytescount == 0)
-				rtd->i2ssp_capturebytescount = bytescount;
 		}
 		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
@@ -955,12 +947,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
 			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			rtd->i2ssp_capturebytescount = 0;
 		}
+		rtd->bytescount = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3b076c6a0ae2..82470bc710f0 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -93,8 +93,7 @@ struct audio_substream_data {
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-	u64 i2ssp_renderbytescount;
-	u64 i2ssp_capturebytescount;
+	u64 bytescount;
 	void __iomem *acp_mmio;
 };
 
-- 
2.17.0
