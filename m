Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07E72245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHmb+hUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07E72245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeKMKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:40:39 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39671 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:40:39 -0500
Received: by mail-it1-f193.google.com with SMTP id m15so15980207itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=lsN7K09eBcolXWrjoWMNHjo6S/lfsBRLf77sWuTNzl4=;
        b=YHmb+hUm/0HdH7GK0I5LzrW3y78+n+OMgsJDKbiDJ/R4k1G+uEya7qpUx9eoaJwpku
         hRgn4Zau8liOQIGH/4Xlc7fFCaXDGWXCiNyIOOucfzdAR7jSBcUVWg9oBh8YbTxQHN38
         xnv+YrCHNTK/5iSLNM/U0dLPPEdzSyALe/Z+u8UJBkFwx0IR4QN7XWz/3klWdgJ2cRnr
         7iUbB0uFU/oVVftAB9ytjN6B88vlsSnHbDF2qNFH9wMn+MjcPTXGq1PWRNO7rv/wu71y
         CZgna/oP7cUZu1K2cfpphtnK/2i0ChqRKifyoL74gsU3ABaGFAfKD7j/0j8axcLfKXXN
         lPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=lsN7K09eBcolXWrjoWMNHjo6S/lfsBRLf77sWuTNzl4=;
        b=hFoEGIMZ22xo0cocxSMaLmX0F2BbR6zOR1+uybkqibSff0Ewqw8vC4JzPZ295OENSn
         LHAhejMIt70hyY1ooFJn0HdjD7TUzptpZKb4h32eOF8DFQMGs6g752g9OQ6WK5WMi6qX
         L/7TNR4mYJF1sg/gMDCUq1mRxma3OkT+S2hc49YajkVJsX9uJVofX7BYyc0gTSITflJ5
         qQVpT/DyD+wrFiGOrlPZtie3wBqpDBi0aAQiKvUo0WHAgqPkzRPCH9+fQrQQyurUy+uu
         e4KZe/thrnOD38t2Rw91vREteFfCH9tDY/EIwxAl4PZimqDSCkE5lDONJPjy5/juVwRf
         Hj8w==
X-Gm-Message-State: AGRZ1gKg3mQUe38pWRDv3+r+p0qv4SJomnlWgZm8072/pYDfu77clfhV
        PcyGQ5Wq/YkubgcwNp+oljbDe5MudqWJyA==
X-Google-Smtp-Source: AJdET5dwfDKJ8grxoEbHpvo9vc2WIOtDvIdRrVocz+1ueXsCzOpQ9R8n+VeXPMTZfJA9f+fGJ7rj2w==
X-Received: by 2002:a24:1d8e:: with SMTP id 136-v6mr1704664itj.62.1542069901991;
        Mon, 12 Nov 2018 16:45:01 -0800 (PST)
Received: from wireless134-172.wireless.wmich.edu ([35.46.107.84])
        by smtp.gmail.com with ESMTPSA id b196-v6sm6542998itc.11.2018.11.12.16.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:45:01 -0800 (PST)
Message-ID: <46bb5564b6bd6cad78c01b4d8026c7c72a870b15.camel@gmail.com>
Subject: [PATCH v2] staging: vc04_services: bcm2835-audio: Fixed warnings,
 checks
From:   Arnold Chand <arnold.chand@gmail.com>
To:     "eric@anholt.net" <eric@anholt.net>
Cc:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Nov 2018 19:45:00 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected warnings and checks provided by scripts/checkpatch.pl which
includes: alignment of parenthesis, lines over 80 characters and mutex
definition without comment.

Signed-off-by: Arnold Chand <arnold.chand@gmail.com>
---
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 18 +++---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 25 ++++----
 .../bcm2835-audio/bcm2835-vchiq.c             | 59 ++++++++++---------
 .../vc04_services/bcm2835-audio/bcm2835.h     |  4 +-
 4 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index a6ec72a5f0be..04df4e7a1d24 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -68,7 +68,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int val, *valp;
@@ -101,7 +101,8 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Volume",
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 		.private_value = PCM_PLAYBACK_VOLUME,
 		.info = snd_bcm2835_ctl_info,
 		.get = snd_bcm2835_ctl_get,
@@ -129,7 +130,7 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
 };
 
 static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+					  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -137,7 +138,7 @@ static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int i;
@@ -153,7 +154,7 @@ static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int val = 0;
@@ -162,7 +163,8 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
 	mutex_lock(&chip->audio_mutex);
 
 	for (i = 0; i < 4; i++)
-		val |= (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);
+		val |= (unsigned int)ucontrol->value.iec958.status[i] <<
+		       (i * 8);
 
 	change = val != chip->spdif_status;
 	chip->spdif_status = val;
@@ -172,7 +174,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+				       struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -180,7 +182,7 @@ static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+				      struct snd_ctl_elem_value *ucontrol)
 {
 	/*
 	 * bcm2835 supports only consumer mode and sets all other format flags
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e66da11af5cf..68766e57f6e2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -81,17 +81,17 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 }
 
 /* open callback */
-static int snd_bcm2835_playback_open_generic(
-	struct snd_pcm_substream *substream, int spdif)
+static int snd_bcm2835_playback_open_generic(struct snd_pcm_substream *substrm,
+					     int spdif)
 {
-	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct bcm2835_chip *chip = snd_pcm_substream_chip(substrm);
+	struct snd_pcm_runtime *runtime = substrm->runtime;
 	struct bcm2835_alsa_stream *alsa_stream;
 	int idx;
 	int err;
 
 	mutex_lock(&chip->audio_mutex);
-	idx = substream->number;
+	idx = substrm->number;
 
 	if (spdif && chip->opened) {
 		err = -EBUSY;
@@ -116,7 +116,7 @@ static int snd_bcm2835_playback_open_generic(
 
 	/* Initialise alsa_stream */
 	alsa_stream->chip = chip;
-	alsa_stream->substream = substream;
+	alsa_stream->substream = substrm;
 	alsa_stream->idx = idx;
 
 	err = bcm2835_audio_open(alsa_stream);
@@ -197,7 +197,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 
 /* hw_params callback */
 static int snd_bcm2835_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+				     struct snd_pcm_hw_params *params)
 {
 	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 }
@@ -232,7 +232,8 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	memset(&alsa_stream->pcm_indirect, 0, sizeof(alsa_stream->pcm_indirect));
+	memset(&alsa_stream->pcm_indirect, 0,
+	       sizeof(alsa_stream->pcm_indirect));
 
 	alsa_stream->pcm_indirect.hw_buffer_size =
 		alsa_stream->pcm_indirect.sw_buffer_size =
@@ -248,11 +249,11 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 }
 
 static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
-	struct snd_pcm_indirect *rec, size_t bytes)
+				     struct snd_pcm_indirect *rec, size_t bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
+	void *src = (void *)(substream->runtime->dma_area + rec->sw_data);
 
 	bcm2835_audio_write(alsa_stream, bytes, src);
 }
@@ -349,7 +350,9 @@ int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
 			&snd_bcm2835_playback_ops);
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-		chip->card->dev, 128 * 1024, 128 * 1024);
+					      chip->card->dev,
+					      128 * 1024,
+					      128 * 1024);
 
 	if (spdif)
 		chip->pcm_spdif = pcm;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 781754f36da7..5e3a30831ed7 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -11,7 +11,7 @@ struct bcm2835_audio_instance {
 	struct device *dev;
 	VCHI_SERVICE_HANDLE_T vchi_handle;
 	struct completion msg_avail_comp;
-	struct mutex vchi_mutex;
+	struct mutex vchi_mutex; /* generic mutex for VCHIQ driver */
 	struct bcm2835_alsa_stream *alsa_stream;
 	int result;
 	unsigned int max_packet;
@@ -34,35 +34,35 @@ static void bcm2835_audio_unlock(struct bcm2835_audio_instance *instance)
 	mutex_unlock(&instance->vchi_mutex);
 }
 
-static int bcm2835_audio_send_msg_locked(struct bcm2835_audio_instance *instance,
+static int bcm2835_audio_send_msg_locked(struct bcm2835_audio_instance *inst,
 					 struct vc_audio_msg *m, bool wait)
 {
 	int status;
 
 	if (wait) {
-		instance->result = -1;
-		init_completion(&instance->msg_avail_comp);
+		inst->result = -1;
+		init_completion(&inst->msg_avail_comp);
 	}
 
-	status = vchi_queue_kernel_message(instance->vchi_handle,
+	status = vchi_queue_kernel_message(inst->vchi_handle,
 					   m, sizeof(*m));
 	if (status) {
-		dev_err(instance->dev,
+		dev_err(inst->dev,
 			"vchi message queue failed: %d, msg=%d\n",
 			status, m->type);
 		return -EIO;
 	}
 
 	if (wait) {
-		if (!wait_for_completion_timeout(&instance->msg_avail_comp,
+		if (!wait_for_completion_timeout(&inst->msg_avail_comp,
 						 msecs_to_jiffies(10 * 1000))) {
-			dev_err(instance->dev,
+			dev_err(inst->dev,
 				"vchi message timeout, msg=%d\n", m->type);
 			return -ETIMEDOUT;
-		} else if (instance->result) {
-			dev_err(instance->dev,
+		} else if (inst->result) {
+			dev_err(inst->dev,
 				"vchi message response error:%d, msg=%d\n",
-				instance->result, m->type);
+				inst->result, m->type);
 			return -EIO;
 		}
 	}
@@ -128,7 +128,8 @@ vc_vchi_audio_init(VCHI_INSTANCE_T vchi_instance,
 		   struct bcm2835_audio_instance *instance)
 {
 	SERVICE_CREATION_T params = {
-		.version		= VCHI_VERSION_EX(VC_AUDIOSERV_VER, VC_AUDIOSERV_MIN_VER),
+		.version		= VCHI_VERSION_EX(VC_AUDIOSERV_VER,
+							  VC_AUDIOSERV_MIN_VER),
 		.service_id		= VC_AUDIO_SERVER_NAME,
 		.callback		= audio_vchi_callback,
 		.callback_param		= instance,
@@ -324,51 +325,51 @@ int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream)
 int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			unsigned int size, void *src)
 {
-	struct bcm2835_audio_instance *instance = alsa_stream->instance;
+	struct bcm2835_audio_instance *inst = alsa_stream->instance;
 	struct vc_audio_msg m = {
 		.type = VC_AUDIO_MSG_TYPE_WRITE,
 		.u.write.count = size,
-		.u.write.max_packet = instance->max_packet,
+		.u.write.max_packet = inst->max_packet,
 		.u.write.cookie1 = BCM2835_AUDIO_WRITE_COOKIE1,
 		.u.write.cookie2 = BCM2835_AUDIO_WRITE_COOKIE2,
 	};
 	unsigned int count;
-	int err, status;
+	int err, sts; /* error and status code */
 
 	if (!size)
 		return 0;
 
-	bcm2835_audio_lock(instance);
-	err = bcm2835_audio_send_msg_locked(instance, &m, false);
+	bcm2835_audio_lock(inst);
+	err = bcm2835_audio_send_msg_locked(inst, &m, false);
 	if (err < 0)
 		goto unlock;
 
 	count = size;
-	if (!instance->max_packet) {
+	if (!inst->max_packet) {
 		/* Send the message to the videocore */
-		status = vchi_bulk_queue_transmit(instance->vchi_handle,
-						  src, count,
-						  VCHI_FLAGS_BLOCK_UNTIL_DATA_READ,
-						  NULL);
+		sts = vchi_bulk_queue_transmit(inst->vchi_handle, src,
+					       count,
+					       VCHI_FLAGS_BLOCK_UNTIL_DATA_READ,
+					       NULL);
 	} else {
 		while (count > 0) {
-			int bytes = min(instance->max_packet, count);
+			int bytes = min(inst->max_packet, count);
 
-			status = vchi_queue_kernel_message(instance->vchi_handle,
-							   src, bytes);
+			sts = vchi_queue_kernel_message(inst->vchi_handle,
+							src, bytes);
 			src += bytes;
 			count -= bytes;
 		}
 	}
 
-	if (status) {
-		dev_err(instance->dev,
+	if (sts) {
+		dev_err(inst->dev,
 			"failed on %d bytes transfer (status=%d)\n",
-			size, status);
+			size, sts);
 		err = -EIO;
 	}
 
  unlock:
-	bcm2835_audio_unlock(instance);
+	bcm2835_audio_unlock(inst);
 	return err;
 }
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 34a0125ce646..e71e73c6273c 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -61,7 +61,7 @@ struct bcm2835_chip {
 
 	unsigned int opened;
 	unsigned int spdif_status;
-	struct mutex audio_mutex;
+	struct mutex audio_mutex; /* generic mutex for VCHIQ audio driver */
 
 	struct bcm2835_vchi_ctx *vchi_ctx;
 };
@@ -107,6 +107,6 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			void *src);
 void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 			   unsigned int size);
-unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream);
+unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *stream);
 
 #endif /* __SOUND_ARM_BCM2835_H */
-- 
2.19.1


