Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D06FC64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058C820880
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+018iRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058C820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeI3JfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37350 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeI3JfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id c13-v6so6196421qkm.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOSSqMV0evAjI2Au0UFtSFRt6B1VEkJdbWogt0QyY+Q=;
        b=d+018iRsFGczDj9LawgcsfjhvBeVbwJWpjPk9UUzY3uPaS1FErxLxJg8MqXIqZIi44
         M5plxyMzKLHO11P3z6UJgIqK2VMxg9bR2LnsBR8/DvIMHGTVwX0kak7zGsMIkky+mvBf
         qH6RpjRzlqFxaGLTaC+Xhqb/iCg9yImtLchjrXsIM+c1j1/ezc4SdOG507ngMBYAUBiy
         nL6tBiOpLfuqo0mqnkrBCE0/1VLlLWQrbQZK1K4vLO1i5h8GWmkMjm89bSgXMPcKDTsd
         5WCYiDjRj5hSLSJmOkuvAKhTmF2pxy61NOomJO0f8HdhFD9A+qyJud1p7VPkTKHk6Sj0
         JMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KOSSqMV0evAjI2Au0UFtSFRt6B1VEkJdbWogt0QyY+Q=;
        b=dD5Yu/YIv6SOv51yE02M3esZFpuKj8LuP8L6XS70I9H8sHmmC5hXWLwqPxpbpTQtGE
         UvI6xYuuzomoh8Q0wiB7ATq51x9vksTc62/djzEtwCbNMblhD2dveTaaB5iwzBELjC3p
         ATOepkSxbqeMaOYQ1x0NP4t6VTs9XiMPnaSYFfSYpn4z6pHqrVbmNTChKP9RkfRI67zL
         viMVK+evUYJKHIWoMp98EnnuRHFT4/asVKP9XyTpdyW5U5N1ABwRqH60UJUzfccCGVtG
         8ykzYX96WULjCmh4jZx75gfMNOAo0LrGjgTwSsPvT++NxI4G7GFhZJJmfmLZiX4/2qkS
         ZQ0A==
X-Gm-Message-State: ABuFfohl8v6tRu91xT1Dz0aO2FVH1YcvZhEkelLRzcmnzEL/CgfzXUJL
        gQroRi/evamiIep0znRFPQr9nut5
X-Google-Smtp-Source: ACcGV635RrnLZREf+LDjVywU5bLidldBbdSWv6JMn0YH4mNHYL6v13pEq3FfGQIpYNHoaXaJ3F2g1Q==
X-Received: by 2002:a37:8e41:: with SMTP id q62-v6mr3916067qkd.76.1538276654230;
        Sat, 29 Sep 2018 20:04:14 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:13 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ALSA: hda/ca0132 - Add DBpro hda_codec_ops
Date:   Sat, 29 Sep 2018 23:03:20 -0400
Message-Id: <1538276607-30234-6-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds separate hda_codec_ops for the DBPro daughter board, as
it behaves more like a generic HDA codec than the other ca0132 cards,
despite having a ca0132 on board.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 100 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4d23eb9..a543b23 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6416,6 +6416,27 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
+static int dbpro_build_controls(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	int err = 0;
+
+	if (spec->dig_out) {
+		err = snd_hda_create_spdif_out_ctls(codec, spec->dig_out,
+				spec->dig_out);
+		if (err < 0)
+			return err;
+	}
+
+	if (spec->dig_in) {
+		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * PCM
  */
@@ -6519,6 +6540,40 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
+static int dbpro_build_pcms(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	struct hda_pcm *info;
+
+	info = snd_hda_codec_pcm_new(codec, "CA0132 Alt Analog");
+	if (!info)
+		return -ENOMEM;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE] = ca0132_pcm_analog_capture;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams = 1;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[0];
+
+
+	if (!spec->dig_out && !spec->dig_in)
+		return 0;
+
+	info = snd_hda_codec_pcm_new(codec, "CA0132 Digital");
+	if (!info)
+		return -ENOMEM;
+	info->pcm_type = HDA_PCM_TYPE_SPDIF;
+	if (spec->dig_out) {
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
+			ca0132_pcm_digital_playback;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->dig_out;
+	}
+	if (spec->dig_in) {
+		info->stream[SNDRV_PCM_STREAM_CAPTURE] =
+			ca0132_pcm_digital_capture;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in;
+	}
+
+	return 0;
+}
+
 static void init_output(struct hda_codec *codec, hda_nid_t pin, hda_nid_t dac)
 {
 	if (pin) {
@@ -7649,6 +7704,16 @@ static void sbz_gpio_shutdown_commands(struct hda_codec *codec, int dir,
 				AC_VERB_SET_GPIO_DATA, data);
 }
 
+static void zxr_dbpro_power_state_shutdown(struct hda_codec *codec)
+{
+	hda_nid_t pins[7] = {0x05, 0x0c, 0x09, 0x0e, 0x08, 0x11, 0x01};
+	unsigned int i;
+
+	for (i = 0; i < 7; i++)
+		snd_hda_codec_write(codec, pins[i], 0,
+				AC_VERB_SET_POWER_STATE, 0x03);
+}
+
 static void sbz_exit_chip(struct hda_codec *codec)
 {
 	chipio_set_stream_control(codec, 0x03, 0);
@@ -8147,6 +8212,21 @@ static int ca0132_init(struct hda_codec *codec)
 	return 0;
 }
 
+static int dbpro_init(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int i;
+
+	init_output(codec, cfg->dig_out_pins[0], spec->dig_out);
+	init_input(codec, cfg->dig_in_pin, spec->dig_in);
+
+	for (i = 0; i < spec->num_inputs; i++)
+		init_input(codec, spec->input_pins[i], spec->adcs[i]);
+
+	return 0;
+}
+
 static void ca0132_free(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -8178,6 +8258,16 @@ static void ca0132_free(struct hda_codec *codec)
 	kfree(codec->spec);
 }
 
+static void dbpro_free(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	zxr_dbpro_power_state_shutdown(codec);
+
+	kfree(spec->spec_init_verbs);
+	kfree(codec->spec);
+}
+
 static void ca0132_reboot_notify(struct hda_codec *codec)
 {
 	codec->patch_ops.free(codec);
@@ -8192,6 +8282,13 @@ static const struct hda_codec_ops ca0132_patch_ops = {
 	.reboot_notify = ca0132_reboot_notify,
 };
 
+static const struct hda_codec_ops dbpro_patch_ops = {
+	.build_controls = dbpro_build_controls,
+	.build_pcms = dbpro_build_pcms,
+	.init = dbpro_init,
+	.free = dbpro_free,
+};
+
 static void ca0132_config(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -8488,6 +8585,9 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Sound Blaster Z");
 		break;
+	case QUIRK_ZXR_DBPRO:
+		codec->patch_ops = dbpro_patch_ops;
+		break;
 	case QUIRK_R3D:
 		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Recon3D");
-- 
2.7.4

