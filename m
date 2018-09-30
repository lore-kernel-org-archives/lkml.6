Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8138C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7B720880
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkMtvnuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7B720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeI3JfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:15 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:35764 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeI3JfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:14 -0400
Received: by mail-qt1-f180.google.com with SMTP id z14-v6so10729516qtn.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dd7bKtioRklldvqESdgqIRuwzi9xeWLLoSY6BhHdesY=;
        b=ZkMtvnuQEsytoiuIKwKsNNYEY20MGpOUj52Pa1yf1Xrv8vWunHYwkjSzwiQubjATrf
         eYTj8iAvEBDr/bhcTb3DFe51hBoi+TetDmAexC02z9b5EHRhEcRfPRRE5e5XZR8cd6+j
         Rp7hD1A/6GLXiLPkPGqm4j7Y3sQicXaPKuJ3oATV2M+tcgjAPNfTDetEawfGrHjQVZUm
         XWMZeQMJsjyncIjksQwSzHiqN7vxDqpGHSv69oldKbo1OJ1iwa+8Vrd5Qca6xREuMD7G
         D8uEWq/3XiqpqoOzkwBeJEbU+2t0ByTV55fHO/+4j9IDspACqbHeLfl2W9D+e/8ZspEv
         wUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dd7bKtioRklldvqESdgqIRuwzi9xeWLLoSY6BhHdesY=;
        b=oWbvXJPAenzfZbNQ1wr1zExO1CikXQKiP18/PbafuNTBNq7NhK3KEEL04PMP0awLFG
         Yo6eytDzsfBQtgafvuWifdXO+gnTO8ZGUt4OOTulnFScWvVhACaoJSJF9mtJpjZw9pBp
         5QcQCR6KHxCNYB83i4h7H5KV8MKi0TtH47GcQkSHmbiEkIM85GFcbmRkxeQWq9RFC/X2
         MEJrNHcqDBR001zBSR/zFTApwD0+RBAaBSwu720zQOI7A10uqTxMCixY/+wY/f1LLZhs
         eXJPC6PJIbo9XnnNWjuCnZnJ61EA9M9NMYX3MHBCh/yC7oBrM77xuvc+evjHBeOyDOou
         qmqg==
X-Gm-Message-State: ABuFfoizAylVUQqpHBNxX2z8bV6IjeAU/O7TKTQxUcljZWI84r4aEVyZ
        ee1sRs9RejTcpbX+eTZjwqsnU+nR
X-Google-Smtp-Source: ACcGV60Gp/bGuaWvvND4yR5B5iB+qA5ya8dCQwb+RGeg5FWcx32vO9u3UaxoV7KE9E+EA1mHhSm1eg==
X-Received: by 2002:aed:2ce6:: with SMTP id g93-v6mr4252398qtd.288.1538276647484;
        Sat, 29 Sep 2018 20:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:07 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ALSA: hda/ca0132 - Fix surround sound with output effects
Date:   Sat, 29 Sep 2018 23:03:17 -0400
Message-Id: <1538276607-30234-3-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue where if surround sound was the selected
output and output effects were enabled, the sound wasn't sent to all
channels correctly.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index aebc592..5a3fb56 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4125,6 +4125,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 }
 
 static int ae5_headphone_gain_set(struct hda_codec *codec, long val);
+static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
 
 static void ae5_mmio_select_out(struct hda_codec *codec)
 {
@@ -4365,12 +4366,19 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		snd_hda_set_pin_ctl(codec, spec->out_pins[3],
 				    pin_ctl | PIN_OUT);
 
-		if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
-			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_ONE);
-		else
-			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_EIGHT);
+		dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_EIGHT);
 		break;
 	}
+	/*
+	 * Surround always sets it's scp command to req 0x04 to FLOAT_EIGHT.
+	 * With this set though, X_BASS cannot be enabled. So, if we have OutFX
+	 * enabled, we need to make sure X_BASS is off, otherwise everything
+	 * sounds all muffled. Running ca0132_effects_set with X_BASS as the
+	 * effect should sort this out.
+	 */
+	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+		ca0132_effects_set(codec, X_BASS,
+			spec->effects_switch[X_BASS - EFFECT_START_NID]);
 
 	/* run through the output dsp commands for the selected output. */
 	for (i = 0; i < alt_out_presets[spec->cur_out_type].commands; i++) {
@@ -4409,7 +4417,6 @@ static void ca0132_unsol_hp_delayed(struct work_struct *work)
 
 static void ca0132_set_dmic(struct hda_codec *codec, int enable);
 static int ca0132_mic_boost_set(struct hda_codec *codec, long val);
-static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
 static void resume_mic1(struct hda_codec *codec, unsigned int oldval);
 static int stop_mic1(struct hda_codec *codec);
 static int ca0132_cvoice_switch_set(struct hda_codec *codec);
@@ -4787,6 +4794,8 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		/* if PE if off, turn off out effects. */
 		if (!spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
 			val = 0;
+		if (spec->cur_out_type == SURROUND_OUT && nid == X_BASS)
+			val = 0;
 	}
 
 	/* for in effect, qualify with CrystalVoice */
-- 
2.7.4

