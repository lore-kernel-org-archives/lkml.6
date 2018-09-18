Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F7CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054BE214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IykZqY7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054BE214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeISAIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:38 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36090 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeISAIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so2688060qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/KZRAGchwILVh2/q01/nrap2dxcwviTHddPiYOg56E=;
        b=IykZqY7HzyS7swuh8NTGD9XxEchW9AEdUVkz9Pt7YaezlZ2rYw6FqxamdJbIr1sJ3L
         i22jCQD4dyje5n/weUMmPZ8c4jrWvIREmG4x3/3KgzEOVGEL4ANjybmKR7zemCQ38Pqj
         Vd3z7qCkT7MRCbrrzDLUqhgkjRvsMbSFv3Yoq37JS+YI+9oJcUTJXAUmv1v0xGFh6bzC
         xS99znRjifI7VpF69qI8dgaNz2YOVRhOiGbvYvqCO8EJXC7+t+tgzrQrTXm1Yj/AYAdV
         gJlhtVYqRydrwvc0iCwBdKNH0F52T6xYPBzrvzmdnJ/T2Sn83VWFRhKXXUJD1g/A54y0
         Kczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/KZRAGchwILVh2/q01/nrap2dxcwviTHddPiYOg56E=;
        b=NSB0wf22d2WAvmF1QoENAwwHsBz0gLVdwNDUhf2n/ISUBHgEaV8nkgMAG8LQ2Gkdy8
         eP5L1w0+xe13B3a+Tm6VJVMOn+rNK0MExxSZbLj8bV9Jduf8F2yUWtKy5etA8VawXZG4
         XnXdwccT6KBmDo9jwX6AJNEIsOGwcvrEVKPkvs24dGBiw/VrILKBGswdLLYUddPURy/s
         u4ipkV7FmffJIsvnxatmPm+BcT93QmvLJHWobfqD+ZpaDhtC1ECAi4jqLeL0G/CXrHC2
         9W6rD/ZYdvnxrm6YtLB1s/W+PfURJcsO82a6ezs+A0PdbLfG9YKJyc271GpiYSoogIRO
         LRHg==
X-Gm-Message-State: APzg51BjEdq/H6dR0rBw9Sn22VaU19QVJki+kCct8lZX+LSKXaZmOsAc
        hX+9MheaaXUsyAaxYrEUILA=
X-Google-Smtp-Source: ANB0VdahhMeDIC/mklZims5g+93/znSLZyzXYVLv5wcS25Www8OorhhF3sbPeZ3JlF2JBlWCm/YJSg==
X-Received: by 2002:ac8:4691:: with SMTP id g17-v6mr22430276qto.137.1537295685289;
        Tue, 18 Sep 2018 11:34:45 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:44 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] ALSA: hda/ca0132 - Merge post-dsp functions + cleanup
Date:   Tue, 18 Sep 2018 14:33:37 -0400
Message-Id: <1537295625-8082-10-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up some of the formatting of the post-dsp load setup
functions, and also merges some of the sub functions into individual
ones.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 171 +++++++++++++++++++------------------------
 1 file changed, 75 insertions(+), 96 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ea67b9c..66c1150 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6335,69 +6335,48 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 }
 
 /*
- * Recon3D r3d_setup_defaults sub functions.
+ * Creates a dummy stream to bind the output to. This seems to have to be done
+ * after changing the main outputs source and destination streams.
  */
-
-static void r3d_dsp_scp_startup(struct hda_codec *codec)
+static void ca0132_alt_create_dummy_stream(struct hda_codec *codec)
 {
-	unsigned int tmp;
-
-	tmp = 0x00000000;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-
-	tmp = 0x00000001;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-
-	tmp = 0x00000004;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
-	tmp = 0x00000005;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
-	tmp = 0x00000000;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
-}
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int stream_format;
 
-static void r3d_dsp_initial_mic_setup(struct hda_codec *codec)
-{
-	unsigned int tmp;
+	stream_format = snd_hdac_calc_stream_format(48000, 2,
+			SNDRV_PCM_FORMAT_S32_LE, 32, 0);
 
-	/* Mic 1 Setup */
-	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
-	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
-	/* This ConnPointID is unique to Recon3Di. Haven't seen it elsewhere */
-	chipio_set_conn_rate(codec, 0x0F, SR_96_000);
-	tmp = FLOAT_ONE;
-	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
+	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
+					0, stream_format);
 
-	/* Mic 2 Setup, even though it isn't connected on SBZ */
-	chipio_set_conn_rate(codec, MEM_CONNID_MICIN2, SR_96_000);
-	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2, SR_96_000);
-	chipio_set_conn_rate(codec, 0x0F, SR_96_000);
-	tmp = FLOAT_ZERO;
-	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
+	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
 }
 
 /*
- * Initialize Sound Blaster Z analog microphones.
+ * Initialize mic for non-chromebook ca0132 implementations.
  */
-static void sbz_init_analog_mics(struct hda_codec *codec)
+static void ca0132_alt_init_analog_mics(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
 
 	/* Mic 1 Setup */
 	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
 	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
-	tmp = FLOAT_THREE;
+	if (spec->quirk == QUIRK_R3DI) {
+		chipio_set_conn_rate(codec, 0x0F, SR_96_000);
+		tmp = FLOAT_ONE;
+	} else
+		tmp = FLOAT_THREE;
 	dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
-	/* Mic 2 Setup, even though it isn't connected on SBZ */
+	/* Mic 2 setup (not present on desktop cards) */
 	chipio_set_conn_rate(codec, MEM_CONNID_MICIN2, SR_96_000);
 	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2, SR_96_000);
+	if (spec->quirk == QUIRK_R3DI)
+		chipio_set_conn_rate(codec, 0x0F, SR_96_000);
 	tmp = FLOAT_ZERO;
 	dspio_set_uint_param(codec, 0x80, 0x01, tmp);
-
 }
 
 /*
@@ -6430,7 +6409,6 @@ static void sbz_connect_streams(struct hda_codec *codec)
 	codec_dbg(codec, "Connect Streams exited, mutex released.\n");
 
 	mutex_unlock(&spec->chipio_mutex);
-
 }
 
 /*
@@ -6477,35 +6455,49 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 }
 
 /*
- * Sound Blaster Z uses these after DSP is loaded. Weird SCP commands
- * without a 0x20 source like normal.
+ * Custom DSP SCP commands where the src value is 0x00 instead of 0x20. This is
+ * done after the DSP is loaded.
  */
-static void sbz_dsp_scp_startup(struct hda_codec *codec)
+static void ca0132_alt_dsp_scp_startup(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
 
-	tmp = 0x00000003;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
-	tmp = 0x00000000;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-
-	tmp = 0x00000001;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-
-	tmp = 0x00000004;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
-	tmp = 0x00000005;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
-	tmp = 0x00000000;
-	dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+	case QUIRK_AE5:
+		tmp = 0x00000003;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		tmp = 0x00000000;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+		tmp = 0x00000001;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+		tmp = 0x00000004;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		tmp = 0x00000005;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		tmp = 0x00000000;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		break;
+	case QUIRK_R3D:
+	case QUIRK_R3DI:
+		tmp = 0x00000000;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+		tmp = 0x00000001;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+		tmp = 0x00000004;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		tmp = 0x00000005;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		tmp = 0x00000000;
+		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+		break;
+	}
 }
 
-static void sbz_dsp_initial_mic_setup(struct hda_codec *codec)
+static void ca0132_alt_dsp_initial_mic_setup(struct hda_codec *codec)
 {
+	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
 
 	chipio_set_stream_control(codec, 0x03, 0);
@@ -6520,8 +6512,16 @@ static void sbz_dsp_initial_mic_setup(struct hda_codec *codec)
 	chipio_set_stream_control(codec, 0x03, 1);
 	chipio_set_stream_control(codec, 0x04, 1);
 
-	chipio_write(codec, 0x18b098, 0x0000000c);
-	chipio_write(codec, 0x18b09C, 0x0000000c);
+	switch (spec->quirk) {
+	case QUIRK_SBZ:
+		chipio_write(codec, 0x18b098, 0x0000000c);
+		chipio_write(codec, 0x18b09C, 0x0000000c);
+		break;
+	case QUIRK_AE5:
+		chipio_write(codec, 0x18b098, 0x0000000c);
+		chipio_write(codec, 0x18b09c, 0x0000004c);
+		break;
+	}
 }
 
 /*
@@ -6582,9 +6582,8 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	r3d_dsp_scp_startup(codec);
-
-	r3d_dsp_initial_mic_setup(codec);
+	ca0132_alt_dsp_scp_startup(codec);
+	ca0132_alt_init_analog_mics(codec);
 
 	/*remove DSP headroom*/
 	tmp = FLOAT_ZERO;
@@ -6620,19 +6619,16 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 static void sbz_setup_defaults(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int tmp, stream_format;
+	unsigned int tmp;
 	int num_fx;
 	int idx, i;
 
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	sbz_dsp_scp_startup(codec);
-
-	sbz_init_analog_mics(codec);
-
+	ca0132_alt_dsp_scp_startup(codec);
+	ca0132_alt_init_analog_mics(codec);
 	sbz_connect_streams(codec);
-
 	sbz_chipio_startup_data(codec);
 
 	chipio_set_stream_control(codec, 0x03, 1);
@@ -6658,8 +6654,7 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	/* Set speaker source? */
 	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
 
-	sbz_dsp_initial_mic_setup(codec);
-
+	ca0132_alt_dsp_initial_mic_setup(codec);
 
 	/* out, in effects + voicefx */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
@@ -6672,23 +6667,7 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 		}
 	}
 
-	/*
-	 * Have to make a stream to bind the sound output to, otherwise
-	 * you'll get dead audio. Before I did this, it would bind to an
-	 * audio input, and would never work
-	 */
-	stream_format = snd_hdac_calc_stream_format(48000, 2,
-			SNDRV_PCM_FORMAT_S32_LE, 32, 0);
-
-	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
-					0, stream_format);
-
-	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
-
-	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
-					0, stream_format);
-
-	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
+	ca0132_alt_create_dummy_stream(codec);
 }
 
 /*
@@ -6774,7 +6753,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	case QUIRK_AE5:
 		if (request_firmware(&fw_entry, DESKTOP_EFX_FILE,
 					codec->card->dev) != 0) {
-			codec_dbg(codec, "Desktop firmware not found. ");
+			codec_dbg(codec, "Desktop firmware not found.");
 			spec->alt_firmware_present = false;
 		} else {
 			codec_dbg(codec, "Desktop firmware selected.");
-- 
2.7.4

