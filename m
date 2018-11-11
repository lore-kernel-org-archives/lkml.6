Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4EF20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4EF20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeKLEL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:11:29 -0500
Received: from vie01a-dmta-pe05-3.mx.upcmail.net ([84.116.36.13]:35402 "EHLO
        vie01a-dmta-pe05-3.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbeKLEL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:11:28 -0500
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gLuN8-0004vH-2o
        for linux-kernel@vger.kernel.org; Sun, 11 Nov 2018 19:22:10 +0100
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id LuN5gWNeqkosQLuN5gnPMr; Sun, 11 Nov 2018 19:22:09 +0100
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=kj9zAlcOel0A:10 a=JHtHm7312UAA:10 a=k7f7euTfAAAA:8 a=O-B1ySCzywwl9q4l6loA:9
 a=QKJdMfhqbLr4Ox4J:21 a=1tjaKtNXVkv_eDIz:21 a=CjuIK1q_8ugA:10
Received: from ubuntu (apu.aillwee.com [192.168.50.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 4E6044E607;
        Sun, 11 Nov 2018 18:22:07 +0000 (GMT)
Date:   Sun, 11 Nov 2018 18:21:29 +0000
From:   Mike Brady <mikebrady@eircom.net>
To:     tiwai@suse.de
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM: staging: bcm2835-audio: interpolate audio delay
Message-ID: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfNrTGoADCM+iByPVmvyB4tP+HEztuV0yaSNOdO3UGqojETNfD8p0Y8rnLa/4reogmcuX43zHh8U6zNWEijR+tVxjazmPJXtX6xDcqRqhK+2KliXfkbeg
 0dT58X32Q+YlRdKr1DGVnfOlnBVmIEH9EN9kaEhZx4kQLaIlpwNR3a6xisDlVHdR91AFeSH1goXeV9A05YMV9cZ4RtmTt7eetgFDs9buIsbiL21nYYSRLDyP
 MC9RZrr6IXJz1FVsNHeaYNuz4X34MQRi8EtqOtx7hm4LWvmfr5pfLwLpNbDs96VBR1P22BUckWM48B+oakJxvrU2MF9R54lmM+rLFyRrDPrWDhB9IszdCmRf
 LNpcSgtP+kivR7n+2d0YMiGxHMWmhznSvxB3VP6tYqIiBUXFMc8BhAFosEtaxOaLhrJoGtrlR2Uh1r4kWKo9CGd+8LGzs8oqDw+1bsBCceLzi6t0nqRbASiX
 xk5wvZFbigVgflC7kpBwV5IzvbSe5gQPv3N/ITE08YSI3PRGgmy6GiVGruJmEVaZQC6jK+KxsCSM9fmODHkPQm9o4SdwcoadjscEAsz3saacT6HalFKQMsz5
 RhEf8qv+R+GGQW0nn3pv9U3GYamL5Jl4OOEXonW649bVrbRkCAuY+kUh2BbCqS9i6Z0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20181111182129.5m6dld8OkM9964XbFhrUWxPcaOAxQ4nus-CMWh5fD04@z>

When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
in the audio position, aka "delay" -- the number of frames that must
be output before a new frame would be played.
Make this a bit nicer for userspace by interpolating the position
using the CPU clock.
The overhead is small -- an extra ktime_get() every time a GPU message
is sent -- and another call and a few calculations whenever the delay
is sought from userland.
At 48,000 frames per second, i.e. approximately 20 microseconds per
frame, it would take a clock inaccuracy of
20 microseconds in 10 milliseconds -- 2,000 parts per million --
to result in an inaccurate estimate, whereas
crystal- or resonator-based clocks typically have an
inaccuracy of 10s to 100s of parts per million.

Signed-off-by: Mike Brady <mikebrady@eircom.net>
---
Changes is v2:
- Add module parameter "enable_delay_interpolation"
- Modify update_audio_tstamp() to include interpolation.
---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 51 ++++++++++++++++++-
 .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
 sound/core/pcm_lib.c                          | 35 ++++++++++---
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e66da11af5cf..7ca148e8094f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -1,18 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
+#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-
 #include <sound/asoundef.h>
 
 #include "bcm2835.h"
 
+static bool enable_delay_interpolation = true;
+
+module_param(enable_delay_interpolation, bool, 0664);
+MODULE_PARM_DESC(enable_delay_interpolation,
+"Better delay reporting by interpolating between GPU notifications");
+
 /* hardware definition */
 static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
+		 SNDRV_PCM_INFO_BATCH | SNDRV_PCM_INFO_DRAIN_TRIGGER |
+		 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
 	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 	.rate_min = 8000,
@@ -53,8 +61,11 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 			   unsigned int bytes)
 {
 	struct snd_pcm_substream *substream = alsa_stream->substream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int pos;
 
+	runtime->delay = 0;
+
 	if (!alsa_stream->period_size)
 		return;
 
@@ -74,6 +85,18 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 	atomic_set(&alsa_stream->pos, pos);
 
 	alsa_stream->period_offset += bytes;
+
+	/* Set interpolation_start_time to zero
+	 * whenever enable_delay_interpolation is false,
+	 * because enable_delay_interpolation could become
+	 * true at any time, and a non-zero interpolation_start_time
+	 * would then be taken as a legitimate starting time.
+	 */
+	if (enable_delay_interpolation)
+		alsa_stream->interpolation_start_time = ktime_get_ns();
+	else
+		alsa_stream->interpolation_start_time = 0;
+
 	if (alsa_stream->period_offset >= alsa_stream->period_size) {
 		alsa_stream->period_offset %= alsa_stream->period_size;
 		snd_pcm_period_elapsed(substream);
@@ -243,6 +266,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	atomic_set(&alsa_stream->pos, 0);
 	alsa_stream->period_offset = 0;
 	alsa_stream->draining = false;
+	alsa_stream->interpolation_start_time = 0;
 
 	return 0;
 }
@@ -293,6 +317,29 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
 
+	if (enable_delay_interpolation) {
+		/* Give userspace better delay reporting by
+		 * interpolating between GPU notifications.
+		 * But only if interpolation_start_time is not zero
+		 * and is before now.
+		 */
+
+		u64 now = ktime_get_ns();
+
+		if ((alsa_stream->interpolation_start_time) &&
+		    (alsa_stream->interpolation_start_time < now)) {
+			u64 interval = now -
+			  alsa_stream->interpolation_start_time;
+			u64 frames_output_in_interval =
+			  div_u64((interval * runtime->rate), 1000000000);
+			snd_pcm_sframes_t
+			  frames_output_in_interval_sized =
+			  frames_output_in_interval;
+			// the interpolation will always be zero or negative
+			runtime->delay = -frames_output_in_interval_sized;
+		}
+	}
+
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
 		atomic_read(&alsa_stream->pos));
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index e13435d1c205..39c582fc129d 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -78,6 +78,7 @@ struct bcm2835_alsa_stream {
 	unsigned int period_offset;
 	unsigned int buffer_size;
 	unsigned int period_size;
+	u64 interpolation_start_time;
 
 	struct bcm2835_audio_instance *instance;
 	int idx;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 4e6110d778bd..574df7d7a1fa 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -229,19 +229,38 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 		(runtime->audio_tstamp_report.actual_type ==
 			SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
 
-		/*
-		 * provide audio timestamp derived from pointer position
-		 * add delay only if requested
-		 */
+		// provide audio timestamp derived from pointer position
 
 		audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;
 
-		if (runtime->audio_tstamp_config.report_delay) {
+		/*
+		 * If the runtime->delay is greater than zero, it's a
+		 * genuine delay, e.g. a delay due to a hardware fifo.
+		 *
+		 * But if the runtime->delay is less than zero, it's an
+		 * interpolated estimate of the number of frames output
+		 * since the hardware pointer was last updated.
+		 *
+		 * It would be calculated in the pointer callback.
+		 * For example, for the bcm_2835 driver, it is calculated in
+		 * snd_bcm2835_pcm_pointer().
+		 */
+
+		if (runtime->delay < 0) {
+			// The delay is an interpolated estimate...
 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-				audio_frames -=  runtime->delay;
-			else
-				audio_frames +=  runtime->delay;
+				audio_frames += runtime->delay;
+		} else {
+			// The delay is a real delay. Add it if requested.
+			if (runtime->audio_tstamp_config.report_delay) {
+				if (substream->stream ==
+				    SNDRV_PCM_STREAM_PLAYBACK)
+					audio_frames -=  runtime->delay;
+				else
+					audio_frames +=  runtime->delay;
+			}
 		}
+
 		audio_nsecs = div_u64(audio_frames * 1000000000LL,
 				runtime->rate);
 		*audio_tstamp = ns_to_timespec(audio_nsecs);
-- 
2.17.1

