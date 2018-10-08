Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26259C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0272089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPGPSAUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0272089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJICzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:55:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41366 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJICze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:55:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so9680996qtl.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dHfnC+P5xZTqjSVmdAowJtFil8ME13aEEOK76Y/THA0=;
        b=nPGPSAUrBCB/ybkoTbtxAU1Rt1Q2QpaL7LCAv26WtROLZu4pxsg1jjZY/cgQ25EDfw
         zTU7vY30i4AzlxqUQClnogfx7h9mfVgZ19SXy+nkSrWDAONJw04OGTARvE3Kfp+fDWEc
         48cHi1AxsLmZ1BgHl41AVhhcJgpkrb2TE1IYGFhtN1Md27EOqwYaZLaD7JQZFjlNGnea
         Ge2pv4UShDEjnm0SAs0aKi/5eBwBGnDFjqQeqRw/DFUntSVQ4x48uToh/tE5Qf2DPhVK
         ecYXoJ4VoSWEjq9rn9uX46gyMYk9aIEwmXOqUkCC8jDylamqr1LjZpSh/uF2lhpCHi1g
         HG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dHfnC+P5xZTqjSVmdAowJtFil8ME13aEEOK76Y/THA0=;
        b=SLmj2luYxA127f8e1nIc2kKHvTNfl0ky8wOZs3Xn1lCMxYWsfe4y3exFcSraqj4U2I
         w3SpJWWodtXnxLZQIeH3ab7EFGkhxOpKK/UrWn0JT2P2MmIjLM3FejD3ujTEao0yQvBQ
         d3NMHc+2InTX9dN+hkLXdm+cJ27J72cx5pHKiLjouqTv3+Zj8Uhu6cTq5kZmhiUzK007
         VOBSxAcNSdmKWBTeTYVUoiq8GxxNb1T+2NefqQR19Z2QBz6UvtRfvZMc+qdhk76OcSVE
         hHzRhpvAk61C+udEwHNYyFlUDaNzhX5/fVYvJ4Ur11g4fUt45TNC7lYR35fAbpd9Uweh
         /8YQ==
X-Gm-Message-State: ABuFfogQb6Rla/6W23UpsrKRWn6oweT1NIme+EvBpf8C+2z4tSkDfwL1
        XE0n9Gef8Jozdffjyryo1iE=
X-Google-Smtp-Source: ACcGV62cGLAJfRAOnkdK9U98nch5pmf/dW4mqR4g9xbERObrMgHRw/qW/xfX8cQBTS9WK/gqOlq0tA==
X-Received: by 2002:a0c:cb87:: with SMTP id p7mr3411335qvk.63.1539027732742;
        Mon, 08 Oct 2018 12:42:12 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:f812:c27a:7560:4d6a])
        by smtp.googlemail.com with ESMTPSA id 76-v6sm13220644qkc.41.2018.10.08.12.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 12:42:12 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ALSA: hda/ca0132 - Add error checking in ca0132_build_controls()
Date:   Mon,  8 Oct 2018 15:39:59 -0400
Message-Id: <1539027601-20910-4-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error checking to functions creating controls inside of
ca0132_build_controls().

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 07d50d6..693b063 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6365,7 +6365,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 					    NULL, ca0132_alt_slave_pfxs,
 					    "Playback Switch",
 					    true, &spec->vmaster_mute.sw_kctl);
-
+		if (err < 0)
+			return err;
 	}
 
 	/* Add in and out effects controls.
@@ -6392,8 +6393,14 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 * prefix, and change PlayEnhancement and CrystalVoice to match.
 	 */
 	if (spec->use_alt_controls) {
-		ca0132_alt_add_svm_enum(codec);
-		add_ca0132_alt_eq_presets(codec);
+		err = ca0132_alt_add_svm_enum(codec);
+		if (err < 0)
+			return err;
+
+		err = add_ca0132_alt_eq_presets(codec);
+		if (err < 0)
+			return err;
+
 		err = add_fx_switch(codec, PLAY_ENHANCEMENT,
 					"Enable OutFX", 0);
 		if (err < 0)
@@ -6430,7 +6437,9 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
-	add_voicefx(codec);
+	err = add_voicefx(codec);
+	if (err < 0)
+		return err;
 
 	/*
 	 * If the codec uses alt_functions, you need the enumerated controls
@@ -6438,23 +6447,37 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 * setting control.
 	 */
 	if (spec->use_alt_functions) {
-		ca0132_alt_add_output_enum(codec);
-		ca0132_alt_add_mic_boost_enum(codec);
+		err = ca0132_alt_add_output_enum(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_mic_boost_enum(codec);
+		if (err < 0)
+			return err;
 		/*
 		 * ZxR only has microphone input, there is no front panel
 		 * header on the card, and aux-in is handled by the DBPro board.
 		 */
-		if (spec->quirk != QUIRK_ZXR)
-			ca0132_alt_add_input_enum(codec);
+		if (spec->quirk != QUIRK_ZXR) {
+			err = ca0132_alt_add_input_enum(codec);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	if (spec->quirk == QUIRK_AE5) {
-		ae5_add_headphone_gain_enum(codec);
-		ae5_add_sound_filter_enum(codec);
+		err = ae5_add_headphone_gain_enum(codec);
+		if (err < 0)
+			return err;
+		err = ae5_add_sound_filter_enum(codec);
+		if (err < 0)
+			return err;
 	}
 
-	if (spec->quirk == QUIRK_ZXR)
-		zxr_add_headphone_gain_switch(codec);
+	if (spec->quirk == QUIRK_ZXR) {
+		err = zxr_add_headphone_gain_switch(codec);
+		if (err < 0)
+			return err;
+	}
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
-- 
2.7.4

