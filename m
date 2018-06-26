Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7D826885
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PH9GK4vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7D826885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeFZKHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:07:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33568 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbeFZKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:07:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so16626846wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gXwdwBGOEp/0dBxkXbIsDOu7pqdDx0E8ZexUdDLZGqA=;
        b=PH9GK4vxdm1jycc++v+5d24EIlQENDN3UeoqeBSkfFWYFpieg1VALb4wdmGHZUEMN0
         G9/ADi0QZ7kACN2p1E88nltffyDWr7BhBgoxYp7zt//j31xKxal6JqDf3v9T0ZU2iRbR
         zomk+6UFzMFw/OmoNaLWe/h/9dJq/BmvZo/vjH6Fqb978i5vfaljFtW2Kjob2aWg4Qbs
         o7P2G48Wo5wDVG0dsfqHxf88hdMalb/qQGLltASDmMq3foKx+mdc3hgVNLMuY9z8zAZf
         jVSuqDzPlweg6i2OwV/ArmfPMgg1pTP6wJy/mQ48/h7riroT+cNwckf/VjcHtDk3Vbfs
         x4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gXwdwBGOEp/0dBxkXbIsDOu7pqdDx0E8ZexUdDLZGqA=;
        b=iJlIb9/ChzlG/8oZS0WbtY3B2GQ9o1/qCqqPii32aSuW5EcfbP+5vMDREtGpKdpfHE
         me1fKxVHn5XeB/1K1+Nt2DurgbULO9SEFEuu+ZAZzoZ6QF2VY5rEcoSe6qLKSm9dms7v
         gPK7Lf8pj26P6EIxJRgONxeunDssvOEuvV0ePTiCKigI/Lx07bf/Q7U2d6T38EY3En6r
         9JCVdEC34lZ1VZP+sxzC/mf9hwDtk0hwbZaofHu29PvciZhoLO/1sxPodyZNVryO9tuP
         QBAUoXoMwJNYCBKwTKyWajK4KdIYIXHYFY6d5//1lQoX4qaa0OmmXcBUysNkBmQT4WtH
         OVcA==
X-Gm-Message-State: APt69E2n794jtm0BQ61BJ1qVVXzIi2ClGKTYHfp2yOZnCdydl0WIwH3r
        9ifavrlh5Gq9lLAqksE7BmN+Sw==
X-Google-Smtp-Source: AAOMgpfgNcXfsTMOxQQHx7qD5ex2rnMwdCXir39BRKpuP1EV36R3HBAs2CIs/XYXZtAeV5pUhoOUwQ==
X-Received: by 2002:adf:8286:: with SMTP id 6-v6mr872102wrc.175.1530007657139;
        Tue, 26 Jun 2018 03:07:37 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f133-v6sm1560232wme.42.2018.06.26.03.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 03:07:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dpcm: improve runtime update predictability
Date:   Tue, 26 Jun 2018 12:07:25 +0200
Message-Id: <20180626100725.6016-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is, dpcm_runtime_update() performs the old path and new path
update of a frontend before going on to the next frontend DAI.
Depending the order of the FEs within the rtd list, the result of
the update might be different.

For example:
 * Frontend A connected to backend C, with a 48kHz playback
 * Frontend B connected to backend D, with a 44.1kHz playback
 * FE A appears before FE B in the rtd list of the card.

If we reparent BE C to FE B (disconnecting BE D):
* old path update of FE A will run first, and BE C will get hw_free()
  and shutdown()
* new path update of FE B will run after and BE C, which is stopped,
  so it will be configured at 44.1kHz, as expected

If we reparent BE D to FE A (disconnecting BE C):
* new path update of FE A will run first but since BE D is still running
  at 44.1kHz, it won't be reconfigured (no call to startup() or
  hw_params())
* old path update of FE B runs after, nothing happens
* In this case, we end up with a BE playing at 44.1kHz a stream which is
  supposed to be played at 48Khz (too slow)

To improve this situation, this patch performs all the FE old paths update
before going on to update the new paths. With this, the result should
no longer depend on the order of the FE within the card rtd list.

Please note that there might be a small performance penalty since
dpcm_process_paths() is called twice per stream direction.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Changes since v1 [0]:
 * Add missing static as reported by kbuild robot.

[0]: https://lkml.kernel.org/r/20180625082923.25636-1-jbrunet@baylibre.com

 sound/soc/soc-pcm.c | 165 +++++++++++++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5e7ae47a9658..4eda18cfe895 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2543,106 +2543,113 @@ static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
 	return ret;
 }
 
-/* Called by DAPM mixer/mux changes to update audio routing between PCMs and
- * any DAI links.
- */
-int soc_dpcm_runtime_update(struct snd_soc_card *card)
+static int soc_dpcm_fe_runtime_update(struct snd_soc_pcm_runtime *fe, int new)
 {
-	struct snd_soc_pcm_runtime *fe;
-	int old, new, paths;
+	struct snd_soc_dapm_widget_list *list;
+	int count, paths;
 
-	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
-	list_for_each_entry(fe, &card->rtd_list, list) {
-		struct snd_soc_dapm_widget_list *list;
+	if (!fe->dai_link->dynamic)
+		return 0;
 
-		/* make sure link is FE */
-		if (!fe->dai_link->dynamic)
-			continue;
+	/* only check active links */
+	if (!fe->cpu_dai->active)
+		return 0;
 
-		/* only check active links */
-		if (!fe->cpu_dai->active)
-			continue;
+	/* DAPM sync will call this to update DSP paths */
+	dev_dbg(fe->dev, "ASoC: DPCM %s runtime update for FE %s\n",
+		new ? "new" : "old", fe->dai_link->name);
 
-		/* DAPM sync will call this to update DSP paths */
-		dev_dbg(fe->dev, "ASoC: DPCM runtime update for FE %s\n",
-			fe->dai_link->name);
+	/* skip if FE doesn't have playback capability */
+	if (!fe->cpu_dai->driver->playback.channels_min ||
+	    !fe->codec_dai->driver->playback.channels_min)
+		goto capture;
 
-		/* skip if FE doesn't have playback capability */
-		if (!fe->cpu_dai->driver->playback.channels_min
-		    || !fe->codec_dai->driver->playback.channels_min)
-			goto capture;
-
-		/* skip if FE isn't currently playing */
-		if (!fe->cpu_dai->playback_active
-		    || !fe->codec_dai->playback_active)
-			goto capture;
-
-		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
-		if (paths < 0) {
-			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
-					fe->dai_link->name,  "playback");
-			mutex_unlock(&card->mutex);
-			return paths;
-		}
+	/* skip if FE isn't currently playing */
+	if (!fe->cpu_dai->playback_active || !fe->codec_dai->playback_active)
+		goto capture;
 
-		/* update any new playback paths */
-		new = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, 1);
-		if (new) {
-			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
-		}
+	paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
+	if (paths < 0) {
+		dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
+			 fe->dai_link->name,  "playback");
+		return paths;
+	}
 
-		/* update any old playback paths */
-		old = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, 0);
-		if (old) {
+	/* update any playback paths */
+	count = dpcm_process_paths(fe, SNDRV_PCM_STREAM_PLAYBACK, &list, new);
+	if (count) {
+		if (new)
+			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
+		else
 			dpcm_run_old_update(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
-		}
 
-		dpcm_path_put(&list);
+		dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_PLAYBACK);
+		dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
+	}
+
+	dpcm_path_put(&list);
+
 capture:
-		/* skip if FE doesn't have capture capability */
-		if (!fe->cpu_dai->driver->capture.channels_min
-		    || !fe->codec_dai->driver->capture.channels_min)
-			continue;
+	/* skip if FE doesn't have capture capability */
+	if (!fe->cpu_dai->driver->capture.channels_min ||
+	    !fe->codec_dai->driver->capture.channels_min)
+		return 0;
 
-		/* skip if FE isn't currently capturing */
-		if (!fe->cpu_dai->capture_active
-		    || !fe->codec_dai->capture_active)
-			continue;
+	/* skip if FE isn't currently capturing */
+	if (!fe->cpu_dai->capture_active || !fe->codec_dai->capture_active)
+		return 0;
 
-		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
-		if (paths < 0) {
-			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
-					fe->dai_link->name,  "capture");
-			mutex_unlock(&card->mutex);
-			return paths;
-		}
+	paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
+	if (paths < 0) {
+		dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
+			 fe->dai_link->name,  "capture");
+		return paths;
+	}
 
-		/* update any new capture paths */
-		new = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, 1);
-		if (new) {
+	/* update any old capture paths */
+	count = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, new);
+	if (count) {
+		if (new)
 			dpcm_run_new_update(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
-		}
-
-		/* update any old capture paths */
-		old = dpcm_process_paths(fe, SNDRV_PCM_STREAM_CAPTURE, &list, 0);
-		if (old) {
+		else
 			dpcm_run_old_update(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
-			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
-		}
 
-		dpcm_path_put(&list);
+		dpcm_clear_pending_state(fe, SNDRV_PCM_STREAM_CAPTURE);
+		dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_CAPTURE);
 	}
 
-	mutex_unlock(&card->mutex);
+	dpcm_path_put(&list);
+
 	return 0;
 }
+
+/* Called by DAPM mixer/mux changes to update audio routing between PCMs and
+ * any DAI links.
+ */
+int soc_dpcm_runtime_update(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *fe;
+	int ret = 0;
+
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	/* shutdown all old paths first */
+	list_for_each_entry(fe, &card->rtd_list, list) {
+		ret = soc_dpcm_fe_runtime_update(fe, 0);
+		if (ret)
+			goto out;
+	}
+
+	/* bring new paths up */
+	list_for_each_entry(fe, &card->rtd_list, list) {
+		ret = soc_dpcm_fe_runtime_update(fe, 1);
+		if (ret)
+			goto out;
+	}
+
+out:
+	mutex_unlock(&card->mutex);
+	return ret;
+}
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 {
 	struct snd_soc_dpcm *dpcm;
-- 
2.14.4

