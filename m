Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5203C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2AE214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7h2WK0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2AE214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbeISAIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33623 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeISAIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:41 -0400
Received: by mail-qt0-f196.google.com with SMTP id r37-v6so2702202qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFicO5AqZMpddpFIiw4TuNuvFUsAeCl8GWqQiMgt0p4=;
        b=l7h2WK0WRIrGj1/nML6y/e54BnUyeTg5Di9jKNLr7bW45D0BrH9H6WBrd81/rObAtB
         jlBABv1Cdgbcoqb54XjUeGQCUg2WqCzZiQTfbFwhM83x5z8JYyFENfHX+M0cnS8J2uUV
         xD6Iss1T9cuH8WlgxxKlUE6LEorV25C0OCnJwLJgS3qZT2o7ZlthWkV6b67myUdeUkCH
         D2IIObf6hgSjvX/kPkX/KtSJegaNVzHdZ7qdjWqFrta5QuDomhdXaz1qhYN2Wl9EG0OQ
         ukAnxDn9B8dlBrBWhD0ijaN5qvdDBfsUUiqAufr1hAof9UUTgy8nmYVoFs8YnbAnPjgg
         9LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFicO5AqZMpddpFIiw4TuNuvFUsAeCl8GWqQiMgt0p4=;
        b=FT+IM7lm6jDN0Ips+RTLLvG4PUiTuck6u7lVFDAMcXvgqDAD0XiU13mIPmyCWTyin2
         G3E23TCykxA+9ZQHF1Nv2O69tQsqCesgUOUFvFIScVZRikFE2m6fludkfdNYyRHWCFvs
         w/jmWT6nDqOrkAg5xOK8XEg52zTZS3j+XoB+hIoZwT6u3c6nNL9IkdXXBGUsfUigRgC5
         z2T0X4bItedzvhF62nrxshIEjBfAv7ZkDMKz9/xx4MpGUXfGAC3FTiuHOJwKm8DQoXkC
         HivYObOs1++5f41ivJux3GtVJnp2KcEOVLL1jvNwbugYXOfyZ3g2Lp1CT8lbZj9zMguT
         YQNA==
X-Gm-Message-State: APzg51AV5dNn3fZjPR+EAdTQJbQCyG+kFcLOG+3pogr5bxvDdr9xvREP
        7krYkwYd4b5HbLl0VYQqZQn73X3C
X-Google-Smtp-Source: ANB0Vdb8ycePQ/CWGnV5jDhR6bejx9qhyzQgjX53xlPaHm01Y2iw3zbPBar4Lt4Y5nctUeqKwUZN+g==
X-Received: by 2002:ac8:38ca:: with SMTP id g10-v6mr22580964qtc.288.1537295689575;
        Tue, 18 Sep 2018 11:34:49 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:49 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] ALSA: hda/ca0132 - Clean up ca0132_alt_out_select
Date:   Tue, 18 Sep 2018 14:33:39 -0400
Message-Id: <1537295625-8082-12-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up ca0132_alt_out_select by moving the card specific
output commands into a separate function. As more cards are added, the
function ca0132_alt_out_select is going to get more bloated with these,
so moving into a separate function tries to keep that from happening.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 121 +++++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 51 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a625e9d..4de94d7 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4026,6 +4026,73 @@ static int ca0132_select_out(struct hda_codec *codec)
 }
 
 /*
+ * These are the commands needed to setup output on each of the different card
+ * types.
+ */
+static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+
+	switch (spec->cur_out_type) {
+	case SPEAKER_OUT:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0113_mmio_gpio_set(codec, 7, false);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x18);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
+			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			ca0113_mmio_gpio_set(codec, 1, true);
+			break;
+		}
+		break;
+	case HEADPHONE_OUT:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0113_mmio_gpio_set(codec, 7, true);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, false);
+			chipio_set_control_param(codec, 0x0D, 0x12);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
+			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			ca0113_mmio_gpio_set(codec, 0x1, false);
+			break;
+		}
+		break;
+	case SURROUND_OUT:
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+			ca0113_mmio_gpio_set(codec, 7, false);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x18);
+			break;
+		case QUIRK_R3DI:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
+			break;
+		case QUIRK_R3D:
+			ca0113_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			break;
+		}
+		break;
+	}
+}
+
+/*
  * This function behaves similarly to the ca0132_select_out funciton above,
  * except with a few differences. It adds the ability to select the current
  * output with an enumerated control "output source" if the auto detect
@@ -4075,26 +4142,11 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 	if (err < 0)
 		goto exit;
 
+	ca0132_alt_select_out_quirk_handler(codec);
+
 	switch (spec->cur_out_type) {
 	case SPEAKER_OUT:
 		codec_dbg(codec, "%s speaker\n", __func__);
-		/*speaker out config*/
-		switch (spec->quirk) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, false);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
-			break;
-		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			break;
-		}
 
 		/* disable headphone node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
@@ -4118,23 +4170,6 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		break;
 	case HEADPHONE_OUT:
 		codec_dbg(codec, "%s hp\n", __func__);
-		/* Headphone out config*/
-		switch (spec->quirk) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, true);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, false);
-			chipio_set_control_param(codec, 0x0D, 0x12);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x21);
-			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
-			break;
-		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x21);
-			ca0113_mmio_gpio_set(codec, 0x1, false);
-			break;
-		}
 
 		snd_hda_codec_write(codec, spec->out_pins[0], 0,
 			AC_VERB_SET_EAPD_BTLENABLE, 0x00);
@@ -4164,23 +4199,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		break;
 	case SURROUND_OUT:
 		codec_dbg(codec, "%s surround\n", __func__);
-		/* Surround out config*/
-		switch (spec->quirk) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, false);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
-			break;
-		case QUIRK_R3D:
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x24);
-			break;
-		}
+
 		/* enable line out node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
 				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-- 
2.7.4

