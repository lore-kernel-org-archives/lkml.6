Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D1FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9094721473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9094721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJRS54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:57:56 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:53633 "EHLO
        vie01a-dmta-pe08-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbeJRS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:57:56 -0400
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gD5zb-00088p-0N
        for linux-kernel@vger.kernel.org; Thu, 18 Oct 2018 12:57:27 +0200
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id D5zZg67FmkosQD5zZgtk2W; Thu, 18 Oct 2018 12:57:26 +0200
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=k7f7euTfAAAA:8 a=rj1QaQtciXKptpJ9f5IA:9
 a=tsLZIYwQTnFd6Zqp:21 a=uTyBaVoy6FBSJHVO:21 a=CjuIK1q_8ugA:10
Received: from ubuntu (apu.aillwee.com [192.168.50.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id B43254E607;
        Thu, 18 Oct 2018 11:57:24 +0100 (IST)
Date:   Thu, 18 Oct 2018 11:57:15 +0100
From:   Mike Brady <mikebrady@eircom.net>
To:     eric@anholt.net, stefan.wahren@i2se.com, gregkh@linuxfoundation.org
Cc:     f.fainelli@gmail.com, tiwai@suse.de,
        nishka.dasgupta_ug18@ashoka.edu.in, julia.lawall@lip6.fr,
        mikebrady@eircom.net, k.marinushkin@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-audio: interpolate audio delay
Message-ID: <20181018105715.GA6660@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfFPbtpHfqRe+r+/EJILl8WBnHKBt9JGnBXv0OLnDBc64jYCKIrfudhSvcI+LEU87Lq9QvX5fFxC4Pr9uiFTrtOHNd7QRlLH2iIsH1yNQ/mssFd91Uw+4
 vvuxugONH7DEPD1TZI12fRpTNPV9nsBJzvaEuxkG8E0psebmLKPP8qmJ/rf+nrUW2gpBNXSf6tbnzZOIKmrLWdbazJdBEP1cfAI5yD1r7l1u4FStMwB5lWji
 b2T3SztI6Bh185Iyb7Vzzw5iYc0hVEgbytxOrJJcBdNLGe2LNKdKaAA9Cmn/D/Y5fhLVZQ8rG2p/B73vlndVFp5xdPxZi/cmCetTtB4H1ykj7ZS/e7l/Lg1x
 pylMFmHdBWf1uKLg6IZjEB0jKUJ9Zd1tpF9tfT1S+Wiv/dlgqA5iAFVHWaGqfY5y5ZWqdye75tEJ7Jf8KGsXKbL0UMGUXEeNvKRaWM4SpDg5LLv2ZgNCbPDv
 sJW9KwQajV9RszgopkjbWGzMx9JaBNYbCV7M9zyWA9HCtev5GB/ril54KwB47btffZp9z0lrmEOMSRPLRFsTy+j9pqNngLxQEMXU2J03J8Qn4DDpZ3Da37BP
 wc50bz79rdG1NjsnuVwYphaj4233cB71mT+SUzAY34kn78Bd5guShAb6oMdj4XvPswE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 23 ++++++++++++++++++-
 .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e66da11af5cf..250adf82385a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -12,7 +12,8 @@
 static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
+		 SNDRV_PCM_INFO_BATCH | SNDRV_PCM_INFO_DRAIN_TRIGGER |
+		 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
 	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 	.rate_min = 8000,
@@ -74,6 +75,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 	atomic_set(&alsa_stream->pos, pos);
 
 	alsa_stream->period_offset += bytes;
+	alsa_stream->interpolate_start = ktime_get();
 	if (alsa_stream->period_offset >= alsa_stream->period_size) {
 		alsa_stream->period_offset %= alsa_stream->period_size;
 		snd_pcm_period_elapsed(substream);
@@ -243,6 +245,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	atomic_set(&alsa_stream->pos, 0);
 	alsa_stream->period_offset = 0;
 	alsa_stream->draining = false;
+	alsa_stream->interpolate_start = ktime_get();
 
 	return 0;
 }
@@ -292,6 +295,24 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
+	ktime_t now = ktime_get();
+
+	/* Give userspace better delay reporting by interpolating between GPU
+	 * notifications, assuming audio speed is close enough to the clock
+	 * used for ktime
+	 */
+
+	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
+	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
+		u64 interval =
+			(ktime_to_ns(ktime_sub(now,
+				alsa_stream->interpolate_start)));
+		u64 frames_output_in_interval =
+			div_u64((interval * runtime->rate), 1000000000);
+		snd_pcm_sframes_t frames_output_in_interval_sized =
+			-frames_output_in_interval;
+		runtime->delay = frames_output_in_interval_sized;
+	}
 
 	return snd_pcm_indirect_playback_pointer(substream,
 		&alsa_stream->pcm_indirect,
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index e13435d1c205..595ad584243f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -78,6 +78,7 @@ struct bcm2835_alsa_stream {
 	unsigned int period_offset;
 	unsigned int buffer_size;
 	unsigned int period_size;
+	ktime_t interpolate_start;
 
 	struct bcm2835_audio_instance *instance;
 	int idx;
-- 
2.17.1

