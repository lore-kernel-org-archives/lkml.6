Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C931C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9687720652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9687720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeJWDhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:37:12 -0400
Received: from vie01a-dmta-pe07-2.mx.upcmail.net ([84.116.36.18]:26231 "EHLO
        vie01a-dmta-pe07-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728675AbeJWDhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:37:12 -0400
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
        by vie01a-dmta-pe07.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gEfhZ-0008J0-0i
        for linux-kernel@vger.kernel.org; Mon, 22 Oct 2018 21:17:21 +0200
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe12.mail.upcmail.net with ESMTP
        id EfhXgbVGYkosQEfhXgxGDN; Mon, 22 Oct 2018 21:17:20 +0200
X-Env-Mailfrom: mikebrady@eircom.net
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 37.228.204.209
X-CNFS-Analysis: v=2.3 cv=NNQEBHyg c=1 sm=1 tr=0
 a=/+iDkf0alGTUGXENEoGzTg==:117 a=/+iDkf0alGTUGXENEoGzTg==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=k7f7euTfAAAA:8 a=rj1QaQtciXKptpJ9f5IA:9
 a=oUWUQTMoM2F0x7kr:21 a=T7wL1U6q3Ylreetz:21 a=CjuIK1q_8ugA:10
Received: from ubuntu (unknown [77.75.241.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id 08DCB4E607;
        Mon, 22 Oct 2018 20:17:17 +0100 (IST)
Date:   Mon, 22 Oct 2018 20:17:08 +0100
From:   Mike Brady <mikebrady@eircom.net>
To:     eric@anholt.net, stefan.wahren@i2se.com, gregkh@linuxfoundation.org
Cc:     f.fainelli@gmail.com, tiwai@suse.de,
        nishka.dasgupta_ug18@ashoka.edu.in, julia.lawall@lip6.fr,
        mikebrady@eircom.net, k.marinushkin@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2] staging: bcm2835-audio: interpolate audio delay
Message-ID: <20181022191708.GA4659@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018105715.GA6660@ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfGWHcEgnY9/MsLzWJIuIQewDpIpciBKOouwGp1jOu/KXst+TtbTKxd6osEMtDq/xlPqDiUTB7otsccDAXJO9DmPeVBGkojgqeAuqa39gUu/XuVm/uXVH
 CA/fm0bikC/B8ko/vHlHeCKgorTMFfmCboe7lrEnt4GccJbK/gVLq4ynsPUf2xNVxthWqpMoGQxPas7nwGMn7PS0F6kSyL0hyamIhdsHaxFXUPjJzIRR6F86
 MhLvAN2vPm2DZ67/SEpPy6Q94UIDsD3ic8e95POTYCO9IulECwq53F6arICnjPBpLs4FzEflUKsRUW2le7tMO4ff6RH5HgUmK9CA6I4ks+m1MNbXHPwj0VWQ
 TymuhDarR9k3bYnbB5S6mAbrH9RLlsePWCJK2TJ/hXDRJ8kzpNN/1TPcmmtyffuMJVJjdcaqD5BCU1tHCIJBaDaTTfY89ElVakvyQ50hcMea8hk2XMHShXqV
 zR98vVciTCtLYAT4At7xXeA8gk9XkywjctIQSnA0cMz/emIh2HznzBDeoJzObbqqFhPEH6ru+J41eTMnX0wgKzo1nEC/kpgC9aBxRN8otnCRZZxgNNJvi1f7
 lvISY1HklTjs+3ZebCn2jH6MAf0qGAveZxzVm6olZdNI29nxVw+DmMFN5ONq50NBrnY/ZXUby4BhNS13gyuzpA5q
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
Changes in v2 -- remove inappropriate addition of SNDRV_PCM_INFO_BATCH flag

 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 20 +++++++++++++++++++
 .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index e66da11af5cf..9053b996cada 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -74,6 +74,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 	atomic_set(&alsa_stream->pos, pos);
 
 	alsa_stream->period_offset += bytes;
+	alsa_stream->interpolate_start = ktime_get();
 	if (alsa_stream->period_offset >= alsa_stream->period_size) {
 		alsa_stream->period_offset %= alsa_stream->period_size;
 		snd_pcm_period_elapsed(substream);
@@ -243,6 +244,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
 	atomic_set(&alsa_stream->pos, 0);
 	alsa_stream->period_offset = 0;
 	alsa_stream->draining = false;
+	alsa_stream->interpolate_start = ktime_get();
 
 	return 0;
 }
@@ -292,6 +294,24 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
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

