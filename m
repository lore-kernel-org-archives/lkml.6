Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F7220862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqIdm/Oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F7220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeICQ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:57:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33352 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeICQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:57:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id r1-v6so6618756wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ogv5YdS6W/UFJSIhs4qRj3z0rnaTTJQcbCdApFNTa/o=;
        b=hqIdm/Oz2hmmr6IGiyXh1CRSMjrqN2GrF8lLhle/6ceSHdxaBKv7MIfd6j5La8DF2S
         1bbeiOv7qp1yqj158cusdJhhDW4sukiz/icZHa4wGC3dzi4Rkb09/614UBsclHRc6D9h
         JjHhVclSg9oTgaZ5j0+9iIGKSu0bJ7O00+APU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ogv5YdS6W/UFJSIhs4qRj3z0rnaTTJQcbCdApFNTa/o=;
        b=P5tAiWljDjvDm/Q4X65a/T9AOeq1eSMYe7SaqMha8HJQFX40FkHL9tUtYQbZpJrSjq
         nL3ejKEVI7FTNXbNgbYlv1Blb8rOcV64o22QaurkQo+UXXiVKSpgLGWk8i7gSRfgonli
         50ksf1/YNNIbbAH1dAavoBlU2zkOqJLfYBmp59BrG5T0Yj67R7npLa+vAuI7SDLig3zk
         FJIYcPtZKwqXaSxm0kPOeWqgw8p1wFwv+ze8x2qz7t6iz+ugS4n5atAfRt0Q4vRS3Fxx
         30OiFfg47X0tKFiN7+mnEjreD11Mf+TC6AF0MFDMYpmsInapMCFP5GrqG5kl/+x3FNJd
         x2Ag==
X-Gm-Message-State: APzg51B2qjsCBWDCsjRkiEVynhQAufPgOxV2+rENnaXArh/LOBu0JZVW
        MPiOG9ashPsu0Z7d0Zxh8aNwgA==
X-Google-Smtp-Source: ANB0Vdbh+e3bJpdvgTtu4CoY/CqfAsgsN0fTL6x1Go3WTRUK2ckR0veWAPpvqnskMZzJhWzbwChk1w==
X-Received: by 2002:a1c:98cc:: with SMTP id a195-v6mr4998693wme.64.1535978255249;
        Mon, 03 Sep 2018 05:37:35 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id j44-v6sm27481099wre.40.2018.09.03.05.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 05:37:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] ASoC: qdsp6: q6asm-dai: Add support to compress offload
Date:   Mon,  3 Sep 2018 13:34:55 +0100
Message-Id: <20180903123455.9290-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MP3 playback support in q6asm dais, adding other codec
support should be pretty trivial.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig           |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c | 418 ++++++++++++++++++++++++++++++-
 2 files changed, 418 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e48..ebf991bb546c 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -66,6 +66,7 @@ config SND_SOC_QDSP6_ASM
 	tristate
 
 config SND_SOC_QDSP6_ASM_DAI
+	select SND_SOC_COMPRESS
 	tristate
 
 config SND_SOC_QDSP6
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9db9a2944ef2..2ab67877f3ed 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -11,6 +11,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <linux/spinlock.h>
+#include <sound/compress_driver.h>
 #include <asm/dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
@@ -31,6 +33,16 @@
 #define CAPTURE_MIN_PERIOD_SIZE     320
 #define SID_MASK_DEFAULT	0xF
 
+/* Default values used if user space does not set */
+#define COMPR_PLAYBACK_MIN_FRAGMENT_SIZE (8 * 1024)
+#define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
+#define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
+#define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
+#define Q6ASM_DAI_TX_RX	0
+#define Q6ASM_DAI_TX	1
+#define Q6ASM_DAI_RX	2
+
+
 enum stream_state {
 	Q6ASM_STREAM_IDLE = 0,
 	Q6ASM_STREAM_STOPPED,
@@ -39,11 +51,25 @@ enum stream_state {
 
 struct q6asm_dai_rtd {
 	struct snd_pcm_substream *substream;
+	struct snd_compr_stream *cstream;
+	struct snd_compr_params codec_param;
+	struct snd_dma_buffer dma_buffer;
+
 	phys_addr_t phys;
+	void    *buffer; /* virtual address */
+	spinlock_t lock;
+	int xrun;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
 	unsigned int pcm_irq_pos;       /* IRQ position */
 	unsigned int periods;
+
+	unsigned int byte_offset;
+	unsigned int bytes_sent;
+	unsigned int bytes_received;
+	unsigned int copy_pointer;
+	unsigned int copied_total;
+
 	uint16_t bits_per_sample;
 	uint16_t source; /* Encoding source bit mask */
 	struct audio_client *audio_client;
@@ -461,6 +487,359 @@ static struct snd_pcm_ops q6asm_dai_ops = {
 	.mmap		= q6asm_dai_mmap,
 };
 
+static void compress_event_handler(uint32_t opcode, uint32_t token,
+				   uint32_t *payload, void *priv)
+{
+	struct q6asm_dai_rtd *prtd = priv;
+	struct snd_compr_stream *substream = prtd->cstream;
+	unsigned long flags;
+	uint64_t avail;
+
+	switch (opcode) {
+	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+		avail = prtd->bytes_received - prtd->bytes_sent;
+		if (!prtd->bytes_sent) {
+			if (avail < substream->runtime->fragment_size) {
+				prtd->xrun = 1;
+			} else {
+				q6asm_write_async(prtd->audio_client,
+						  prtd->pcm_count,
+						  0, 0, NO_TIMESTAMP);
+				prtd->bytes_sent += prtd->pcm_count;
+			}
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
+		prtd->state = Q6ASM_STREAM_STOPPED;
+		break;
+	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+		prtd->byte_offset += prtd->pcm_count;
+		prtd->copied_total += prtd->pcm_count;
+
+		if (prtd->byte_offset >= prtd->pcm_size)
+			prtd->byte_offset -= prtd->pcm_size;
+
+		snd_compr_fragment_elapsed(substream);
+		if (prtd->state != Q6ASM_STREAM_RUNNING) {
+			spin_unlock_irqrestore(&prtd->lock, flags);
+			break;
+		}
+
+		avail = prtd->bytes_received - prtd->bytes_sent;
+		if (avail < substream->runtime->fragment_size) {
+			prtd->xrun = 1;
+		} else {
+			q6asm_write_async(prtd->audio_client,
+					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			prtd->bytes_sent += prtd->pcm_count;
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+
+		break;
+	default:
+		break;
+	}
+}
+
+
+static int q6asm_dai_compr_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = c->dev;
+	struct q6asm_dai_rtd *prtd;
+	int stream_id;
+
+	stream_id = cpu_dai->driver->id;
+	pdata = snd_soc_component_get_drvdata(c);
+	if (!pdata) {
+		dev_err(dev, "Drv data not found ..\n");
+		return -EINVAL;
+	}
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	prtd->cstream = stream;
+	prtd->audio_client = q6asm_audio_client_alloc(dev,
+					(q6asm_cb)compress_event_handler,
+					prtd, stream_id, LEGACY_PCM_MODE);
+	if (!prtd->audio_client) {
+		dev_err(dev, "Could not allocate memory\n");
+		kfree(prtd);
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&prtd->lock);
+	runtime->private_data = prtd;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_free(struct snd_compr_stream *stream)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+
+	if (prtd->audio_client) {
+		if (prtd->state)
+			q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+
+		q6asm_unmap_memory_regions(stream->direction,
+					   prtd->audio_client);
+		q6asm_audio_client_free(prtd->audio_client);
+		prtd->audio_client = NULL;
+	}
+	q6routing_stream_close(rtd->dai_link->id, stream->direction);
+	kfree(prtd);
+
+	return 0;
+}
+
+static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
+				      struct snd_compr_params *params)
+{
+
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int dir = stream->direction;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = c->dev;
+	int ret;
+
+	memcpy(&prtd->codec_param, params, sizeof(*params));
+
+	pdata = snd_soc_component_get_drvdata(c);
+	if (!pdata)
+		return -EINVAL;
+
+	if (!prtd || !prtd->audio_client) {
+		dev_err(dev, "private data null or audio client freed\n");
+		return -EINVAL;
+	}
+
+	runtime->fragments = prtd->codec_param.buffer.fragments;
+	runtime->fragment_size = prtd->codec_param.buffer.fragment_size;
+	prtd->periods = runtime->fragments;
+	prtd->pcm_count = runtime->fragment_size;
+	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
+
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, prtd->pcm_size,
+				  &prtd->dma_buffer);
+	if (ret) {
+		dev_err(dev, "Cannot allocate buffer(s)\n");
+		return ret;
+	}
+
+	if (pdata->sid < 0)
+		prtd->phys = prtd->dma_buffer.addr;
+	else
+		prtd->phys = prtd->dma_buffer.addr | (pdata->sid << 32);
+
+	prtd->buffer = prtd->dma_buffer.area;
+	prtd->copy_pointer = 0;
+
+	prtd->bits_per_sample = 16;
+	if (dir == SND_COMPRESS_PLAYBACK) {
+		ret = q6asm_open_write(prtd->audio_client, params->codec.id,
+					prtd->bits_per_sample);
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "q6asm_open_write failed\n");
+		q6asm_audio_client_free(prtd->audio_client);
+		prtd->audio_client = NULL;
+		return -ENOMEM;
+	}
+
+	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
+	ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
+			      prtd->session_id, dir);
+	if (ret) {
+		dev_err(dev, "Stream reg failed ret:%d\n", ret);
+		return ret;
+	}
+
+	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
+				       (prtd->pcm_size / prtd->periods),
+				       prtd->periods);
+
+	if (ret < 0) {
+		dev_err(dev, "Buffer Mapping failed ret:%d\n", ret);
+		return -ENOMEM;
+	}
+
+	prtd->state = Q6ASM_STREAM_RUNNING;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_trigger(struct snd_compr_stream *stream, int cmd)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		prtd->state = Q6ASM_STREAM_STOPPED;
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_EOS);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_PAUSE);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int q6asm_dai_compr_pointer(struct snd_compr_stream *stream,
+		struct snd_compr_tstamp *tstamp)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+
+	tstamp->byte_offset = prtd->byte_offset;
+	tstamp->copied_total = prtd->copied_total;
+
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return 0;
+}
+
+static int q6asm_dai_compr_copy(struct snd_compr_stream *stream,
+				char __user *buf, size_t count)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	uint64_t avail = 0;
+	unsigned long flags;
+	size_t copy;
+	void *dstn;
+
+	dstn = prtd->buffer + prtd->copy_pointer;
+	if (count < prtd->pcm_size - prtd->copy_pointer) {
+		if (copy_from_user(dstn, buf, count))
+			return -EFAULT;
+
+		prtd->copy_pointer += count;
+	} else {
+		copy = prtd->pcm_size - prtd->copy_pointer;
+		if (copy_from_user(dstn, buf, copy))
+			return -EFAULT;
+
+		if (copy_from_user(prtd->buffer, buf + copy, count - copy))
+			return -EFAULT;
+		prtd->copy_pointer = count - copy;
+	}
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	prtd->bytes_received += count;
+
+	if (prtd->state == Q6ASM_STREAM_RUNNING && prtd->xrun) {
+		avail = prtd->bytes_received - prtd->copied_total;
+		if (avail >= runtime->fragment_size) {
+			prtd->xrun = 0;
+			q6asm_write_async(prtd->audio_client,
+				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			prtd->bytes_sent += prtd->pcm_count;
+		}
+	}
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return count;
+}
+
+static int q6asm_dai_compr_mmap(struct snd_compr_stream *stream,
+		struct vm_area_struct *vma)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = c->dev;
+
+	return dma_mmap_coherent(dev, vma,
+			prtd->dma_buffer.area, prtd->dma_buffer.addr,
+			prtd->dma_buffer.bytes);
+}
+
+static int q6asm_dai_compr_get_caps(struct snd_compr_stream *stream,
+				    struct snd_compr_caps *caps)
+{
+	caps->direction = SND_COMPRESS_PLAYBACK;
+	caps->min_fragment_size = COMPR_PLAYBACK_MIN_FRAGMENT_SIZE;
+	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
+	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
+	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	caps->num_codecs = 1;
+	caps->codecs[0] = SND_AUDIOCODEC_MP3;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_get_codec_caps(struct snd_compr_stream *stream,
+					  struct snd_compr_codec_caps *codec)
+{
+	switch (codec->codec) {
+	case SND_AUDIOCODEC_MP3:
+		codec->num_descriptors = 2;
+		codec->descriptor[0].max_ch = 2;
+		memcpy(codec->descriptor[0].sample_rates,
+		       supported_sample_rates,
+		       sizeof(supported_sample_rates));
+		codec->descriptor[0].num_sample_rates =
+			sizeof(supported_sample_rates)/sizeof(unsigned int);
+		codec->descriptor[0].bit_rate[0] = 320; /* 320kbps */
+		codec->descriptor[0].bit_rate[1] = 128;
+		codec->descriptor[0].num_bitrates = 2;
+		codec->descriptor[0].profiles = 0;
+		codec->descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO;
+		codec->descriptor[0].formats = 0;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_compr_ops q6asm_dai_compr_ops = {
+	.open		= q6asm_dai_compr_open,
+	.free		= q6asm_dai_compr_free,
+	.set_params	= q6asm_dai_compr_set_params,
+	.pointer	= q6asm_dai_compr_pointer,
+	.trigger	= q6asm_dai_compr_trigger,
+	.get_caps	= q6asm_dai_compr_get_caps,
+	.get_codec_caps	= q6asm_dai_compr_get_codec_caps,
+	.mmap		= q6asm_dai_compr_mmap,
+	.copy		= q6asm_dai_compr_copy,
+};
+
 static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm_substream *psubstream, *csubstream;
@@ -548,7 +927,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.ops		= &q6asm_dai_ops,
 	.pcm_new	= q6asm_dai_pcm_new,
 	.pcm_free	= q6asm_dai_pcm_free,
-
+	.compr_ops	= &q6asm_dai_compr_ops,
 };
 
 static struct snd_soc_dai_driver q6asm_fe_dais[] = {
@@ -562,6 +941,41 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 	Q6ASM_FEDAI_DRIVER(8),
 };
 
+static int of_q6asm_parse_dai_data(struct device *dev,
+				    struct q6asm_dai_data *pdata)
+{
+	static struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream empty_stream;
+	struct device_node *node;
+	int ret, id, dir;
+
+	memset(&empty_stream, 0, sizeof(empty_stream));
+
+	for_each_child_of_node(dev->of_node, node) {
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret || id > MAX_SESSIONS || id < 0) {
+			dev_err(dev, "valid dai id not found:%d\n", ret);
+			continue;
+		}
+
+		dai_drv = &q6asm_fe_dais[id];
+
+		ret = of_property_read_u32(node, "direction", &dir);
+		if (ret)
+			continue;
+
+		if (dir == Q6ASM_DAI_RX)
+			dai_drv->capture = empty_stream;
+		else if (dir == Q6ASM_DAI_TX)
+			dai_drv->playback = empty_stream;
+
+		if (of_property_read_bool(node, "is-compress-dai"))
+			dai_drv->compress_new = snd_soc_new_compress;
+	}
+
+	return 0;
+}
+
 static int q6asm_dai_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -582,6 +996,8 @@ static int q6asm_dai_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, pdata);
 
+	of_q6asm_parse_dai_data(dev, pdata);
+
 	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
 					q6asm_fe_dais,
 					ARRAY_SIZE(q6asm_fe_dais));
-- 
2.18.0

