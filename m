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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889CFC43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437B520685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzs62VD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437B520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeI3Jfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35216 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeI3Jfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id a189-v6so6200111qkb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooWq8HmoB2NCxuuY0ff0FyUanAkVpS+sjiPWCnK/x0U=;
        b=Nzs62VD5XbrWJwibpBhajD83AtZ48cVdyyM0cLa6HnFtnTEd65toPY+jvKMH9HGHoF
         lkkRy/u8kQ6SOvC3fJi17Y5vMVS7Y4H/en43l+UYuCpbtKZtFu3SiDSTCWxaVfLLdjvP
         WCAmliXeqAaxN8y2/n6NnNJcGNTs89eN2DNvX+DNgwwOn4YRWgnospq9lQH093sBinvv
         SlzHhK88xcMSSR7r1RVeJufwK/nMNR82DOe+kAwya60N1N9c6T7UQRTx4OFsVCI2Jr6X
         rdD8Om42VLUVNgInRzDhdgpzsqzzIrpGqQaaodE97CqFuekje681FB9dvDiKkS6S9N4F
         eVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ooWq8HmoB2NCxuuY0ff0FyUanAkVpS+sjiPWCnK/x0U=;
        b=jvgDSo8Vb3FtxiAvFnQPC974agNBLTBLvp61OVawQVcGoN8tyYWxIesgJ6LKvsw/zO
         3cLB9RJpX4fKkBh3GvzCPupmUFyyOC4qwrTL3GPBQGA2iPngUufXZHquMXmml9VSosyt
         PtrC1lecXZRyFt2ofoDpgPnXSfwsEDyYzxsR4jUZHREcggvQGTtwQkSssLpL2XsHHRoD
         YJLNekJQ9rKptUs68uv+CzARSXB/4YHHqAuA13/XVP4Sv6uV2GpPfJkRNmIUqmLyQA/q
         Yza6PRFzoxnfGq2UsglYB3npvz3KH1BAHxEC1emoCDOvuzm075T3uS0AWCuPE1ySjrBP
         bx4Q==
X-Gm-Message-State: ABuFfohso+3tnw9M+1C9LuiijVsMS1WCRcitTki8s7iCODR3q+CH3Qdp
        UPHo6rkSY4Uw63oOfm49gKQ=
X-Google-Smtp-Source: ACcGV62OmFWC1h0kC/1VPfJ4opDxUH5+rAhXL4fjJ+wcmujTQXXo3p7uSQIQbtkwqI9b352zp+kJng==
X-Received: by 2002:ae9:e00c:: with SMTP id m12-v6mr3847249qkk.303.1538276664892;
        Sat, 29 Sep 2018 20:04:24 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:24 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
Date:   Sat, 29 Sep 2018 23:03:25 -0400
Message-Id: <1538276607-30234-11-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a control for 600 ohm gain on the Sound Blaster ZxR.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index f0781e4..90e6a96 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -154,7 +154,8 @@ enum {
 	SMART_VOLUME_ENUM,
 	MIC_BOOST_ENUM,
 	AE5_HEADPHONE_GAIN_ENUM,
-	AE5_SOUND_FILTER_ENUM
+	AE5_SOUND_FILTER_ENUM,
+	ZXR_HEADPHONE_GAIN
 #define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
 };
 
@@ -1031,7 +1032,8 @@ struct ca0132_spec {
 	/* AE-5 Control values */
 	unsigned char ae5_headphone_gain_val;
 	unsigned char ae5_filter_val;
-
+	/* ZxR Control Values */
+	unsigned char zxr_gain_set;
 
 	struct hda_codec *codec;
 	struct delayed_work unsol_hp_work;
@@ -4142,6 +4144,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 }
 
 static int ae5_headphone_gain_set(struct hda_codec *codec, long val);
+static int zxr_headphone_gain_set(struct hda_codec *codec, long val);
 static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
 
 static void ae5_mmio_select_out(struct hda_codec *codec)
@@ -4178,6 +4181,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 2, true);
 			ca0113_mmio_gpio_set(codec, 3, true);
 			ca0113_mmio_gpio_set(codec, 5, false);
+			zxr_headphone_gain_set(codec, 0);
 			chipio_set_control_param(codec, 0x0d, 0x24);
 			break;
 		case QUIRK_R3DI:
@@ -4211,6 +4215,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 2, false);
 			ca0113_mmio_gpio_set(codec, 3, false);
 			ca0113_mmio_gpio_set(codec, 5, true);
+			zxr_headphone_gain_set(codec, spec->zxr_gain_set);
 			chipio_set_control_param(codec, 0x0d, 0x21);
 			break;
 		case QUIRK_R3DI:
@@ -4245,6 +4250,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 2, true);
 			ca0113_mmio_gpio_set(codec, 3, true);
 			ca0113_mmio_gpio_set(codec, 5, false);
+			zxr_headphone_gain_set(codec, 0);
 			chipio_set_control_param(codec, 0x0d, 0x24);
 			break;
 		case QUIRK_R3DI:
@@ -5019,6 +5025,17 @@ static int ae5_headphone_gain_set(struct hda_codec *codec, long val)
 	return 0;
 }
 
+/*
+ * gpio pin 1 is a relay that switches on/off, apparently setting the headphone
+ * amplifier to handle a 600 ohm load.
+ */
+static int zxr_headphone_gain_set(struct hda_codec *codec, long val)
+{
+	ca0113_mmio_gpio_set(codec, 1, val);
+
+	return 0;
+}
+
 static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
@@ -5777,6 +5794,16 @@ static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
 		goto exit;
 	}
 
+	if (nid == ZXR_HEADPHONE_GAIN) {
+		spec->zxr_gain_set = *valp;
+		if (spec->cur_out_type == HEADPHONE_OUT)
+			changed = zxr_headphone_gain_set(codec, *valp);
+		else
+			changed = 0;
+
+		goto exit;
+	}
+
 exit:
 	snd_hda_power_down(codec);
 	return changed;
@@ -6185,6 +6212,16 @@ static int ae5_add_sound_filter_enum(struct hda_codec *codec)
 				snd_ctl_new1(&knew, codec));
 }
 
+static int zxr_add_headphone_gain_switch(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		CA0132_CODEC_MUTE_MONO("ZxR: 600 Ohm Gain",
+				    ZXR_HEADPHONE_GAIN, 1, HDA_OUTPUT);
+
+	return snd_hda_ctl_add(codec, ZXR_HEADPHONE_GAIN,
+				snd_ctl_new1(&knew, codec));
+}
+
 /*
  * Need to create slave controls for the alternate codecs that have surround
  * capabilities.
@@ -6415,6 +6452,9 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		ae5_add_headphone_gain_enum(codec);
 		ae5_add_sound_filter_enum(codec);
 	}
+
+	if (spec->quirk == QUIRK_ZXR)
+		zxr_add_headphone_gain_switch(codec);
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
-- 
2.7.4

