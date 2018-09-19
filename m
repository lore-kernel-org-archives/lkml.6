Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F72DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F302098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F302098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbeISPT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:19:57 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeISPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:19:57 -0400
Received: from [192.168.178.69] ([109.104.39.77]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MadC8-1fV8vb0fn8-00c5Re; Wed, 19 Sep 2018 11:42:25 +0200
Subject: Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-18-tiwai@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <4c5f9aed-8fbe-fe22-0c8d-097d8915805c@i2se.com>
Date:   Wed, 19 Sep 2018 11:42:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904155858.8001-18-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:ENXAX8mjaLIW7JKkKJ9egQpqw6c8C7IqMbYZ8PvN5KiXfEXV5ao
 a6+bu2G63u4u8lZkKOHiEmfIZybAcDrhWOogfoAM6fHJNM6BU9j6b9O2cgZQp+5Q/Of8yIA
 I++V3b14TOF9yoBsWQoZP/rK+9YWGBG792tTjorG1+5QJ+2+ZXQqYgTBhGPP5pn6dDPQSbp
 S5MIpA8sKeVvUTwqJL75w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w7MU+E6VnMA=:sdHU8Lz8xy9KTCMQFAx3Rp
 GBZTFZo2Ch59mFX6diIFcx23dUA2p+XS+Lwd+88b10XpgY+jwX+n5IIvWdJrXK/HvI/KlJjZA
 GzKJYjBUOlRkG64v8VntfB2Gk2CwRLpUJURjQ0tJmXgxZyfxtMWb3xAiUihGvnt6B7Y2vnYHd
 VO4bg/q4Qy7ZWe91B8JJ9nt7pwUrcN5ZYPIpYrRj7J0LXU7BLm22msRblujoijzVxqa5BskQD
 itANy3aBua585gN2salq90Icxb8pGDRaa3C50KPv/OnOjczu3qxswigykjHlB3oVWvwktGyWA
 7mtDuVEtxUrWeqb4eNZqVWDlFKbXtpb6oJ872Wdwfb1+O9A0Y6d0KPCVxDBhm0/QoMsGq9C7z
 5TNKFjSPGCKWvyNtMi+HfBUMgE2q0Tr0bHlpvvMGKBaF/wHxCI+5UdmocXKoE2e4AjqRihhPu
 +HRVNtjxErqV5M3MLWvR00niKBnDBzgKDTHm5vq30c0Azhq1xHVe2CnuTFDEf4RiYEtgxrJ8j
 oKrpdgACMQxv91IEAd6U50dhcnO3BD3EXbel6CelSa62Of65YbKNOhuvx2yb5itCoGL0WJSbf
 iHKvPM4hWTzicCSsh1eurGZ5kJ8pAZ7LulTtoWhHcurSQBis9M1zDd0FHNbYGe8c/RFhEFTBJ
 G3N+CdMF4oQ7Q4t2/0dGNH3EJc+eccq2bunNVzvlt9jLxYbAfg0r5k4rJ9QbVNVQtxHFztiFm
 Gn2z17zem1Ve6hbx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

Am 04.09.2018 um 17:58 schrieb Takashi Iwai:
> It seems that the resolution of vc04 callback is in 10 msec; i.e. the
> minimal period size is also 10 msec.
>
> This patch adds the corresponding hw constraint.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> index 9659c25b9f9d..6d89db6e14e4 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> @@ -145,6 +145,11 @@ static int snd_bcm2835_playback_open_generic(
>  				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>  				   16);
>  
> +	/* position update is in 10ms order */
> +	snd_pcm_hw_constraint_minmax(runtime,
> +				     SNDRV_PCM_HW_PARAM_PERIOD_TIME,
> +				     10 * 1000, UINT_MAX);
> +
>  	chip->alsa_stream[idx] = alsa_stream;
>  
>  	chip->opened |= (1 << idx);

in the Foundation Kernel (Downstream) there is a patch to interpolate
the audio delay. So my questions is, does your patch above makes the
following patch obsolete?

[PATCH] bcm2835: interpolate audio delay

It appears the GPU only sends us a message all 10ms to update
the playback progress. Other than this, the playback position
(what SNDRV_PCM_IOCTL_DELAY will return) is not updated at all.
Userspace will see jitter up to 10ms in the audio position.

Make this a bit nicer for userspace by interpolating the
position using the CPU clock.

I'm not sure if setting snd_pcm_runtime.delay is the right
approach for this. Or if there is maybe an already existing
mechanism for position interpolation in the ALSA core.

I only set SNDRV_PCM_INFO_BATCH because this appears to remove
at least one situation snd_pcm_runtime.delay is used, so I have
to worry less in which place I have to update this field, or
how it interacts with the rest of ALSA.

In the future, it might be nice to use VC_AUDIO_MSG_TYPE_LATENCY.
One problem is that it requires sending a videocore message, and
waiting for a reply, which could make the implementation much
harder due to locking and synchronization requirements.
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c       | 13 +++++++++++--
 .../staging/vc04_services/bcm2835-audio/bcm2835.h   |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 94654c0c7bba5..36165a60fb059 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -22,7 +22,7 @@
 /* hardware definition */
 static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-	SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BATCH),
 	.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
 	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 	.rate_min = 8000,
@@ -93,6 +93,8 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream)
 		alsa_stream->pos %= alsa_stream->buffer_size;
 	}
 
+	alsa_stream->interpolate_start = ktime_get_ns();
+
 	if (alsa_stream->substream) {
 		if (new_period)
 			snd_pcm_period_elapsed(alsa_stream->substream);
@@ -323,6 +325,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	alsa_stream->buffer_size = snd_pcm_lib_buffer_bytes(substream);
 	alsa_stream->period_size = snd_pcm_lib_period_bytes(substream);
 	alsa_stream->pos = 0;
+	alsa_stream->interpolate_start = ktime_get_ns();
 
 	audio_debug("buffer_size=%d, period_size=%d pos=%d frame_bits=%d\n",
 		alsa_stream->buffer_size, alsa_stream->period_size,
@@ -415,13 +418,19 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-
+	u64 now = ktime_get_ns();
 
 	audio_debug("pcm_pointer... (%d) hwptr=%d appl=%d pos=%d\n", 0,
 		frames_to_bytes(runtime, runtime->status->hw_ptr),
 		frames_to_bytes(runtime, runtime->control->appl_ptr),
 		alsa_stream->pos);
 
+	/* Give userspace better delay reporting by interpolating between GPU
+	 * notifications, assuming audio speed is close enough to the clock
+	 * used for ktime */
+	if (alsa_stream->interpolate_start && alsa_stream->interpolate_start < now)
+		runtime->delay = -(int)div_u64((now - alsa_stream->interpolate_start) * runtime->rate,  1000000000);
+
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
 		alsa_stream->pos);
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 379604d3554e8..e64862e1781be 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -137,6 +137,7 @@ struct bcm2835_alsa_stream {
 	unsigned int pos;
 	unsigned int buffer_size;
 	unsigned int period_size;
+	u64 interpolate_start;
 
 	atomic_t retrieved;
 	struct bcm2835_audio_instance *instance;

