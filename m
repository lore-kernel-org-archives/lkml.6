Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D4EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF372150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLn7NZsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF372150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbeISAIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33142 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbeISAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id z78-v6so1597952qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LAJ1+m6iXn9Tu00DLjpa/EIqj56gPl3McIYIj62bCQ0=;
        b=PLn7NZsMnIPd5CxdPY06uEjePeOzujr1W/u4B2ynGI+8+2KWdvtdJ4/Rm0HJfNOaCK
         bwh8jiYBjwYGTGpnlxTcTLVWvrxkrzMotMKvWqStG6UQkdi7xpj1Eo/uAERQT5DcC/QW
         BSZk/uhrbvyhSzQjE5J8+qabEZBUbhJ0DETh21hfhgKnqdWZ+bETiQoWBS8cMZ8hjp3k
         hLPkCxOZi/5BLAK4zZCYmtGZ81rjbAx+JazUC9XUCgxW69n/3qaVuN05HSbqlKgtgEPM
         Y4LC4+LcW6aTuOaoBXlPZIBuLji7jpzEfmEwgnHjl6p55Qop8DzCeDqzRpUiLoEIzo9G
         ZYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LAJ1+m6iXn9Tu00DLjpa/EIqj56gPl3McIYIj62bCQ0=;
        b=jJuMc3vM83APMjF5ila9aB8ZGeiiKCz5lQyohmSCpRZbKBgIwpZYfh0zogx8Be3iPY
         xG5EwgJrSrcwTeRaLaOvbxtECvdO4LqHyZcXcSHLf8416uT7j8QXolGvgZuzdcM10suV
         BVbHl70ZS8rov8W3tkWB9cFzqovHUGgJxyppMzABfh6o49xYfxP8MD19OEkL08orufTA
         JKAOZZNb3Enta9a6G2zDs0awuCeAnvP44hIYTizXQqKYGkiK74YkUnVczfFQt2Ee9FTY
         bVB4dc6cAtz+ZzJ4R9ytSzWxaoZxtQF0wEuYQ/oMj0Mh/8G97Gi0tfg36Wk7unRr631A
         H0rw==
X-Gm-Message-State: APzg51AgqJnxncLZtbD38OLa8saS2ZXmYtFmbi82u8bRgR+taxWGXhTa
        7AJBvJuXYJ1Kl2ACcU3pp18feCai
X-Google-Smtp-Source: ANB0Vda8jhtW/pdXOm7WABtxq7uaTQpaed/rsFkOws52jbpuA8tK2fmu5X3W8xHu9fj93UVXv/8eSQ==
X-Received: by 2002:a37:79c5:: with SMTP id u188-v6mr21565326qkc.82.1537295696035;
        Tue, 18 Sep 2018 11:34:56 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:55 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] ALSA: hda/ca0132 - Add AE-5 specific controls
Date:   Tue, 18 Sep 2018 14:33:42 -0400
Message-Id: <1537295625-8082-15-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds controls for the AE-5's headphone gain setting, and the
DAC's interpolation filter setting.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 239 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ff80832..7048cc0 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -152,7 +152,9 @@ enum {
 	XBASS_XOVER,
 	EQ_PRESET_ENUM,
 	SMART_VOLUME_ENUM,
-	MIC_BOOST_ENUM
+	MIC_BOOST_ENUM,
+	AE5_HEADPHONE_GAIN_ENUM,
+	AE5_SOUND_FILTER_ENUM
 #define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
 };
 
@@ -689,6 +691,42 @@ static const struct ae5_ca0113_output_set ae5_ca0113_output_presets[] = {
 	}
 };
 
+/* ae5 ca0113 command sequences to set headphone gain levels. */
+#define AE5_HEADPHONE_GAIN_PRESET_MAX_COMMANDS 4
+struct ae5_headphone_gain_set {
+	char *name;
+	unsigned int vals[AE5_HEADPHONE_GAIN_PRESET_MAX_COMMANDS];
+};
+
+static const struct ae5_headphone_gain_set ae5_headphone_gain_presets[] = {
+	{ .name = "Low (16-31",
+	  .vals = { 0xff, 0x2c, 0xf5, 0x32 }
+	},
+	{ .name = "Medium (32-149",
+	  .vals = { 0x38, 0xa8, 0x3e, 0x4c }
+	},
+	{ .name = "High (150-600",
+	  .vals = { 0xff, 0xff, 0xff, 0x7f }
+	}
+};
+
+struct ae5_filter_set {
+	char *name;
+	unsigned int val;
+};
+
+static const struct ae5_filter_set ae5_filter_presets[] = {
+	{ .name = "Slow Roll Off",
+	  .val = 0xa0
+	},
+	{ .name = "Minimum Phase",
+	  .val = 0xc0
+	},
+	{ .name = "Fast Roll Off",
+	  .val = 0x80
+	}
+};
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
@@ -990,6 +1028,9 @@ struct ca0132_spec {
 	long eq_preset_val;
 	unsigned int tlv[4];
 	struct hda_vmaster_mute_hook vmaster_mute;
+	/* AE-5 Control values */
+	unsigned char ae5_headphone_gain_val;
+	unsigned char ae5_filter_val;
 
 
 	struct hda_codec *codec;
@@ -3225,6 +3266,41 @@ static void ca0113_mmio_command_set(struct hda_codec *codec, unsigned int group,
 }
 
 /*
+ * This second type of command is used for setting the sound filter type.
+ */
+static void ca0113_mmio_command_set_type2(struct hda_codec *codec,
+		unsigned int group, unsigned int target, unsigned int value)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int write_val;
+
+	writel(0x0000007e, spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+	writel(0x0000005a, spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+
+	writel(0x00800003, spec->mem_base + 0x20c);
+	writel(group, spec->mem_base + 0x804);
+
+	writel(0x00800005, spec->mem_base + 0x20c);
+	write_val = (target & 0xff);
+	write_val |= (value << 8);
+
+
+	writel(write_val, spec->mem_base + 0x204);
+	msleep(20);
+	readl(spec->mem_base + 0x860);
+	readl(spec->mem_base + 0x854);
+	readl(spec->mem_base + 0x840);
+
+	writel(0x00800004, spec->mem_base + 0x20c);
+	writel(0x00000000, spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+}
+
+/*
  * Setup GPIO for the other variants of Core3D.
  */
 
@@ -4048,6 +4124,8 @@ static int ca0132_select_out(struct hda_codec *codec)
 	return err < 0 ? err : 0;
 }
 
+static int ae5_headphone_gain_set(struct hda_codec *codec, long val);
+
 static void ae5_mmio_select_out(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -4088,6 +4166,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			break;
 		case QUIRK_AE5:
 			ae5_mmio_select_out(codec);
+			ae5_headphone_gain_set(codec, 2);
 			tmp = FLOAT_ZERO;
 			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
 			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
@@ -4114,6 +4193,8 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			break;
 		case QUIRK_AE5:
 			ae5_mmio_select_out(codec);
+			ae5_headphone_gain_set(codec,
+					spec->ae5_headphone_gain_val);
 			tmp = FLOAT_ONE;
 			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
 			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
@@ -4140,6 +4221,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			break;
 		case QUIRK_AE5:
 			ae5_mmio_select_out(codec);
+			ae5_headphone_gain_set(codec, 2);
 			tmp = FLOAT_ZERO;
 			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
 			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
@@ -4876,6 +4958,16 @@ static int ca0132_alt_mic_boost_set(struct hda_codec *codec, long val)
 	return ret;
 }
 
+static int ae5_headphone_gain_set(struct hda_codec *codec, long val)
+{
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		ca0113_mmio_command_set(codec, 0x48, 0x11 + i,
+				ae5_headphone_gain_presets[val].vals[i]);
+	return 0;
+}
+
 static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -5140,6 +5232,112 @@ static int ca0132_alt_mic_boost_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+/*
+ * Sound BlasterX AE-5 Headphone Gain Controls.
+ */
+#define AE5_HEADPHONE_GAIN_MAX 3
+static int ae5_headphone_gain_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	char *sfx = " Ohms)";
+	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = AE5_HEADPHONE_GAIN_MAX;
+	if (uinfo->value.enumerated.item >= AE5_HEADPHONE_GAIN_MAX)
+		uinfo->value.enumerated.item = AE5_HEADPHONE_GAIN_MAX - 1;
+	sprintf(namestr, "%s %s",
+		ae5_headphone_gain_presets[uinfo->value.enumerated.item].name,
+		sfx);
+	strcpy(uinfo->value.enumerated.name, namestr);
+	return 0;
+}
+
+static int ae5_headphone_gain_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->ae5_headphone_gain_val;
+	return 0;
+}
+
+static int ae5_headphone_gain_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = AE5_HEADPHONE_GAIN_MAX;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ae5_headphone_gain: boost=%d\n",
+		    sel);
+
+	spec->ae5_headphone_gain_val = sel;
+
+	if (spec->out_enum_val == HEADPHONE_OUT)
+		ae5_headphone_gain_set(codec, spec->ae5_headphone_gain_val);
+
+	return 1;
+}
+
+/*
+ * Sound BlasterX AE-5 sound filter enumerated control.
+ */
+#define AE5_SOUND_FILTER_MAX 3
+
+static int ae5_sound_filter_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = AE5_SOUND_FILTER_MAX;
+	if (uinfo->value.enumerated.item >= AE5_SOUND_FILTER_MAX)
+		uinfo->value.enumerated.item = AE5_SOUND_FILTER_MAX - 1;
+	sprintf(namestr, "%s",
+			ae5_filter_presets[uinfo->value.enumerated.item].name);
+	strcpy(uinfo->value.enumerated.name, namestr);
+	return 0;
+}
+
+static int ae5_sound_filter_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->ae5_filter_val;
+	return 0;
+}
+
+static int ae5_sound_filter_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = AE5_SOUND_FILTER_MAX;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ae5_sound_filter: %s\n",
+			ae5_filter_presets[sel].name);
+
+	spec->ae5_filter_val = sel;
+
+	ca0113_mmio_command_set_type2(codec, 0x48, 0x07,
+			ae5_filter_presets[sel].val);
+
+	return 1;
+}
 
 /*
  * Input Select Control for alternative ca0132 codecs. This exists because
@@ -5903,6 +6101,40 @@ static int ca0132_alt_add_mic_boost_enum(struct hda_codec *codec)
 }
 
 /*
+ * Add headphone gain enumerated control for the AE-5. This switches between
+ * three modes, low, medium, and high. When non-headphone outputs are selected,
+ * it is automatically set to high. This is the same behavior as Windows.
+ */
+static int ae5_add_headphone_gain_enum(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO("AE-5: Headphone Gain",
+				    AE5_HEADPHONE_GAIN_ENUM, 1, 0, HDA_INPUT);
+	knew.info = ae5_headphone_gain_info;
+	knew.get = ae5_headphone_gain_get;
+	knew.put = ae5_headphone_gain_put;
+	return snd_hda_ctl_add(codec, AE5_HEADPHONE_GAIN_ENUM,
+				snd_ctl_new1(&knew, codec));
+}
+
+/*
+ * Add sound filter enumerated control for the AE-5. This adds three different
+ * settings: Slow Roll Off, Minimum Phase, and Fast Roll Off. From what I've
+ * read into it, it changes the DAC's interpolation filter.
+ */
+static int ae5_add_sound_filter_enum(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO("AE-5: Sound Filter",
+				    AE5_SOUND_FILTER_ENUM, 1, 0, HDA_INPUT);
+	knew.info = ae5_sound_filter_info;
+	knew.get = ae5_sound_filter_get;
+	knew.put = ae5_sound_filter_put;
+	return snd_hda_ctl_add(codec, AE5_SOUND_FILTER_ENUM,
+				snd_ctl_new1(&knew, codec));
+}
+
+/*
  * Need to create slave controls for the alternate codecs that have surround
  * capabilities.
  */
@@ -6122,6 +6354,11 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		ca0132_alt_add_input_enum(codec);
 		ca0132_alt_add_mic_boost_enum(codec);
 	}
+
+	if (spec->quirk == QUIRK_AE5) {
+		ae5_add_headphone_gain_enum(codec);
+		ae5_add_sound_filter_enum(codec);
+	}
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
-- 
2.7.4

