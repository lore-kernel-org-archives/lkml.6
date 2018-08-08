Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E40C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8C2177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFJeCEpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF8C2177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeHHT4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:56:04 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55115 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHT4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:56:03 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so4526070itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtC4GBydT04u36AqS4VceQqa70g3rfD8EOUgbrd9p8s=;
        b=bFJeCEpaVLdwLisFLNnSasrVeroB+ZdhJpJBLwdmeUvp/ea36wVrYsXxji7mzYcjGp
         BMJfrxEjtLMhmtlsrzwQT4GSyCdHTdczF0JETZyRGP5kT2tAgAns+8+G0/X1f++iP2Z7
         X3sUfPojhQ01IIqAr4lH0856qkvQ2EEAh9Wg/4MqdFGNyShW17S4DcIuqQ9hzK3kpYWV
         eux7QIQOh/43q6yNpbgD0phE1kf5gDDiRFnLDos/ToCIbiuPVwN9UK6mVUc6lteO6j5Z
         WOFsaUNYpHVeveXBaznHQm8RS9jwk268Se/AwG2I8Lm9lBpSxjOJySHVs20/FsEY6m4P
         VumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtC4GBydT04u36AqS4VceQqa70g3rfD8EOUgbrd9p8s=;
        b=kfVx0scwzMFmxuSCp1HE0FzlvfXETUdVNdA7bySycTcmcaLBRhXcqpdbAbF1G+LLgB
         U4/b+GjU/8Vw6K8icysSk4be0HL9VbeE9+tun5ObxJq04pQVwybD+PegSFokaAV5vHgN
         4ehwK9IiQ7hd716A5cVNPgNbxEb/5wzfWlzRpBH/zhHHvevJFgmbyccIHNw336+nu0QS
         RKvvIMabxPzuu3aGBbk8hxKi3SLGNAwezR5JG/svXJku3JKGuIMK4rqiJsT5UdAzOhLa
         HhUkHMAo3Rn/86Wiav0IK+1RlyAdtOHb/G6fctZi2o4EsDFjkLbqZOIFsl5Jkjtxa7x2
         PHTQ==
X-Gm-Message-State: AOUpUlHqkLiSc4EHrzA8zbTjAmtnvsKgvPXY9JYT9041m7cmHZ9Peg0i
        ycI5sfjlNbCLOmfAUUjUaD0=
X-Google-Smtp-Source: AA+uWPy2AwipyjTnhOmU+R8yk1TNejpt+u8JdNw2XVxPOYE74XssLoMf5F050TShkGuqslomEHk1Kg==
X-Received: by 2002:a02:35a:: with SMTP id y87-v6mr3394161jad.2.1533749721219;
        Wed, 08 Aug 2018 10:35:21 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:20 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] ALSA: hda/ca0132 - Add DSP setup defaults for Recon3D
Date:   Wed,  8 Aug 2018 13:34:19 -0400
Message-Id: <1533749663-8200-9-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Recon3D can use many of the same functions as the Recon3Di, so many
of the r3di prefix function remain the same, but change their names to
the more generic r3d prefix. This patch does this, and adds quirk checks
for things specific to the Recon3Di.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index cb84648..0257fb9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6224,10 +6224,10 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 }
 
 /*
- * Recon3Di r3di_setup_defaults sub functions.
+ * Recon3D r3d_setup_defaults sub functions.
  */
 
-static void r3di_dsp_scp_startup(struct hda_codec *codec)
+static void r3d_dsp_scp_startup(struct hda_codec *codec)
 {
 	unsigned int tmp;
 
@@ -6248,7 +6248,7 @@ static void r3di_dsp_scp_startup(struct hda_codec *codec)
 
 }
 
-static void r3di_dsp_initial_mic_setup(struct hda_codec *codec)
+static void r3d_dsp_initial_mic_setup(struct hda_codec *codec)
 {
 	unsigned int tmp;
 
@@ -6458,10 +6458,10 @@ static void ca0132_setup_defaults(struct hda_codec *codec)
 }
 
 /*
- * Setup default parameters for Recon3Di DSP.
+ * Setup default parameters for Recon3D/Recon3Di DSP.
  */
 
-static void r3di_setup_defaults(struct hda_codec *codec)
+static void r3d_setup_defaults(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
@@ -6471,9 +6471,9 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	r3di_dsp_scp_startup(codec);
+	r3d_dsp_scp_startup(codec);
 
-	r3di_dsp_initial_mic_setup(codec);
+	r3d_dsp_initial_mic_setup(codec);
 
 	/*remove DSP headroom*/
 	tmp = FLOAT_ZERO;
@@ -6487,7 +6487,8 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 	/* Set speaker source? */
 	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
 
-	r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
+	if (spec->quirk == QUIRK_R3DI)
+		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
 
 	/* Setup effect defaults */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
@@ -6499,7 +6500,6 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 					ca0132_effects[idx].def_vals[i]);
 		}
 	}
-
 }
 
 /*
@@ -7298,7 +7298,8 @@ static int ca0132_init(struct hda_codec *codec)
 
 	switch (spec->quirk) {
 	case QUIRK_R3DI:
-		r3di_setup_defaults(codec);
+	case QUIRK_R3D:
+		r3d_setup_defaults(codec);
 		break;
 	case QUIRK_SBZ:
 		sbz_setup_defaults(codec);
-- 
2.7.4

