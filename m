Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51488C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E139F21781
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uH2Bdh4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E139F21781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeHHT4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:56:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55944 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHT4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:56:01 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so4519849itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9f7zTXJ4QOfKKLYJKw9ZAtieZE64pO6HLEMANKX2gQ=;
        b=uH2Bdh4Uwj6gWufdrc6wGmt2Y+1GrmkGaULqpEKIXczcB/JiqNHh4kaYIb5Q43gX0e
         VV1eeWyMtNlzjG41ulj8VGM8u3E+HyjVHplPzyTLsbMPNK7q2WVI6tefB67m3lIkG3YE
         DHVQkauK/qlksPowkxMRZPUYsbo4B8MbHfJXPuIxwzjpNxNBTbK+JVyTi+Gsg8qm/Kug
         zExowXcaQmm11bwrZtl2FrPpOKmPRl6qa3F+EaNVsKk+w7jYDGhx0Cv5ddJbRVlLVtFs
         qGKwoRP35UnLLm9JM4DxbA2AuJlZslvFeKfB0Saer/GQmY5jPfFVrLFo+Aiygy/JKmHI
         lnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9f7zTXJ4QOfKKLYJKw9ZAtieZE64pO6HLEMANKX2gQ=;
        b=BgMEfiPB3c0PBAkj3OjiOXR/cM8viPmkTwaOxVkxxEK0BrQDi2fSUOlnoG8LFNc+h9
         G4rYDNSRigyB2xgMgZfp7O+cj5W7R33d6iRIo7SWAjMQeRL3xMsOBHovTUDGHtuTKsZL
         DliHQWEgD4p/ti0cqSIeCMCFm57jFMX2Bpqlx3Nru/BkvD8CpWJjRhdVTnUhW/rrocd1
         DizUEMFVokftHUMkiGlr627XJfm2rnk2DohRboZlw8YsNorVNy2KHCbcwPdOtLCe4+fS
         uRUUad0cl5uGP0mcz3YOWMIYUddQbQI5Wm6k/yzklTJO192LeyHGirA/vcW7otc0pt4i
         /uPg==
X-Gm-Message-State: AOUpUlHShD9di6Xb9RbeM6OEqpHfKv+dfR50kpnw7ngM+gIzNR3NN8I/
        Ay8IiPKaOYw5xohG62IDEU4=
X-Google-Smtp-Source: AA+uWPxiqQDPQegGDPCR1XSrcGLLvIZa3OZjhKCC23sawQTCLe/FwjOVCWmldKb4FdyS7LAM0VfGow==
X-Received: by 2002:a02:b4a4:: with SMTP id k33-v6mr3203331jaj.53.1533749719063;
        Wed, 08 Aug 2018 10:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:18 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ALSA: hda/ca0132 - Add Recon3D startup functions and setup
Date:   Wed,  8 Aug 2018 13:34:18 -0400
Message-Id: <1533749663-8200-8-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds functions for Recon3D startup, and sets values for
things such as use_pci_mmio. It also renames some functions and tables
from the sbz prefix into ca0132, as the Recon3D uses them as well.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 49 ++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b35b179..cb84648 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -897,7 +897,7 @@ struct ca0132_spec {
 	const struct hda_verb *base_init_verbs;
 	const struct hda_verb *base_exit_verbs;
 	const struct hda_verb *chip_init_verbs;
-	const struct hda_verb *sbz_init_verbs;
+	const struct hda_verb *desktop_init_verbs;
 	struct hda_verb *spec_init_verbs;
 	struct auto_pin_cfg autocfg;
 
@@ -6840,8 +6840,8 @@ static struct hda_verb ca0132_init_verbs0[] = {
 	{}
 };
 
-/* Extra init verbs for SBZ */
-static struct hda_verb sbz_init_verbs[] = {
+/* Extra init verbs for desktop cards. */
+static struct hda_verb ca0132_init_verbs1[] = {
 	{0x15, 0x70D, 0x20},
 	{0x15, 0x70E, 0x19},
 	{0x15, 0x707, 0x00},
@@ -7136,9 +7136,27 @@ static void sbz_pre_dsp_setup(struct hda_codec *codec)
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
 }
 
-/*
- * Extra commands that don't really fit anywhere else.
- */
+static void r3d_pre_dsp_setup(struct hda_codec *codec)
+{
+
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
+	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
+
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
+
+	snd_hda_codec_write(codec, 0x11, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
+}
+
 static void r3di_pre_dsp_setup(struct hda_codec *codec)
 {
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
@@ -7163,13 +7181,12 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
 }
 
-
 /*
  * These are sent before the DSP is downloaded. Not sure
  * what they do, or if they're necessary. Could possibly
  * be removed. Figure they're better to leave in.
  */
-static void sbz_region2_startup(struct hda_codec *codec)
+static void ca0132_mmio_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 
@@ -7209,7 +7226,7 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		ca0132_gpio_init(codec);
 		sbz_pre_dsp_setup(codec);
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
-		snd_hda_sequence_write(codec, spec->sbz_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		break;
 	case QUIRK_R3DI:
 		codec_dbg(codec, "R3DI alt_init");
@@ -7220,6 +7237,11 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x6FF, 0xC4);
 		break;
+	case QUIRK_R3D:
+		r3d_pre_dsp_setup(codec);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		break;
 	}
 }
 
@@ -7256,8 +7278,8 @@ static int ca0132_init(struct hda_codec *codec)
 		spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->curr_chip_addx = INVALID_CHIP_ADDRESS;
 
-	if (spec->quirk == QUIRK_SBZ)
-		sbz_region2_startup(codec);
+	if (spec->use_pci_mmio)
+		ca0132_mmio_init(codec);
 
 	snd_hda_power_up_pm(codec);
 
@@ -7508,8 +7530,8 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	spec->chip_init_verbs = ca0132_init_verbs0;
-	if (spec->quirk == QUIRK_SBZ)
-		spec->sbz_init_verbs = sbz_init_verbs;
+	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D)
+		spec->desktop_init_verbs = ca0132_init_verbs1;
 	spec->spec_init_verbs = kcalloc(NUM_SPEC_VERBS,
 					sizeof(struct hda_verb),
 					GFP_KERNEL);
@@ -7586,6 +7608,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	/* Setup whether or not to use alt functions/controls/pci_mmio */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+	case QUIRK_R3D:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
 		spec->use_pci_mmio = true;
-- 
2.7.4

