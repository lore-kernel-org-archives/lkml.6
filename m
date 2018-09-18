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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0924C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C5C214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6rgVVaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C5C214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeISAIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42711 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeISAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so2665522qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hCsd8MVwJZTZCXJCJMFwhVwM5c+CFCxp1Ie32qh7wDk=;
        b=r6rgVVaaAbWkHKGCqELP2jPuxLjASg02XTbv/P7mKJIMFjjikg37Xjcq0+47XOXtEK
         BuanSONFdFkhpj+IuEg01Ifb228ydPH7IWkeGyDnP4kqHALrlMySgKfad6qjUK23/hY7
         zesNHPyp9bo1GhxxP0tGhat5HbmRRTgASRGKrQxW5E9NtOGqYOX4oIrMXtK1glFSj5lZ
         HuuR+HCjcm40qOz9Df6JSaZQudfI9lDT34FHmTc4itTLft9O4SzAvAR9PZ+MmoKoAN+a
         aBzlPDVlkFEAgss0HCIZlDIRuwJqKoQ+743pL2FaHn8CzmLdLB/wvtS0VZu5nVbljmeN
         xZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hCsd8MVwJZTZCXJCJMFwhVwM5c+CFCxp1Ie32qh7wDk=;
        b=S/dhg1zguIAccx2ppjheMVShOuB2i/AO1Gq2j54/bOUEl8a5zYy8/5dZvMVsn2U4Ss
         3Pna10ZrxERviEWJtvZxNOOWVTLXsGX+PDvihCSkhwEkHYZA0F1q4eVldFqJfhM9eYAF
         LldZ+EimHqOavsiq+j2OWvPmivjUOnZp28FGZlwcEPv3pqXAZ18QILfel4N7DLLLZIYB
         hhOJQSXrDJqK0ZUJv+7mVynus173v5T/CaAitanSneQlBRMghEGFjKrLCkyPdzAKtOvd
         djT3Mwl0d2mxg9FIAvEMNsB/h+xS4jq0jW7JBu6h+vw4JXfJuliwkp+/K55O6JwW5ZsT
         JGjA==
X-Gm-Message-State: APzg51AmeyKvHGeb6VCDMQ/eKlgii3hD25z97Xce7bKbWcGkGL4f0fa1
        byFgO7w0bjkoVQ8pYB3p3GE=
X-Google-Smtp-Source: ANB0VdYKU3Www1aNrEgqvgYxtVbzjbvccIvmnht8OWUq0cn+745s6wdNj8vZcCBzwht/18xYRZDCbw==
X-Received: by 2002:ac8:3169:: with SMTP id h38-v6mr22938928qtb.125.1537295672303;
        Tue, 18 Sep 2018 11:34:32 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:31 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] ALSA: hda/ca0132 - Add pincfg for AE-5
Date:   Tue, 18 Sep 2018 14:33:31 -0400
Message-Id: <1537295625-8082-4-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pincfg for the Sound BlasterX AE-5, and cleans up
the function it's assigned in.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 73 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 81bbec1..5f53c71 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1056,6 +1056,21 @@ static const struct hda_pintbl r3d_pincfgs[] = {
 	{}
 };
 
+/* Sound Blaster AE-5 pin configs taken from Windows Driver */
+static const struct hda_pintbl ae5_pincfgs[] = {
+	{ 0x0b, 0x01017010 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x01c510f0 }, /* SPDIF In */
+	{ 0x0f, 0x01017114 }, /* Port A -- Rear L/R. */
+	{ 0x10, 0x01017012 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01a170ff }, /* Port B -- LineMicIn2 / Rear Headphone */
+	{ 0x12, 0x01a170f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
 /* Recon3D integrated pin configs taken from Windows Driver */
 static const struct hda_pintbl r3di_pincfgs[] = {
 	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
@@ -7435,9 +7450,29 @@ static void ca0132_config(struct hda_codec *codec)
 
 	switch (spec->quirk) {
 	case QUIRK_ALIENWARE:
-		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
+		codec_dbg(codec, "%s: QUIRK_ALIENWARE applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, alienware_pincfgs);
+		break;
+	case QUIRK_SBZ:
+		codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+		break;
+	case QUIRK_R3D:
+		codec_dbg(codec, "%s: QUIRK_R3D applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, r3d_pincfgs);
+		break;
+	case QUIRK_R3DI:
+		codec_dbg(codec, "%s: QUIRK_R3DI applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+		break;
+	case QUIRK_AE5:
+		codec_dbg(codec, "%s: QUIRK_AE5 applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+		break;
+	}
 
+	switch (spec->quirk) {
+	case QUIRK_ALIENWARE:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0b; /* speaker out */
 		spec->out_pins[1] = 0x0f;
@@ -7457,15 +7492,6 @@ static void ca0132_config(struct hda_codec *codec)
 		break;
 	case QUIRK_SBZ:
 	case QUIRK_R3D:
-		if (spec->quirk == QUIRK_SBZ) {
-			codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
-			snd_hda_apply_pincfgs(codec, sbz_pincfgs);
-		}
-		if (spec->quirk == QUIRK_R3D) {
-			codec_dbg(codec, "%s: QUIRK_R3D applied.\n", __func__);
-			snd_hda_apply_pincfgs(codec, r3d_pincfgs);
-		}
-
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
 		spec->out_pins[1] = 0x0F; /* Rear headphone out */
@@ -7490,10 +7516,31 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->multiout.dig_out_nid = spec->dig_out;
 		spec->dig_in = 0x09;
 		break;
-	case QUIRK_R3DI:
-		codec_dbg(codec, "%s: QUIRK_R3DI applied.\n", __func__);
-		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+	case QUIRK_AE5:
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x11; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Front Headphone / Center/LFE*/
+		spec->out_pins[3] = 0x0F; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x7; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x8; /* Front Mic, but only if no DSP */
+		spec->adcs[2] = 0xa; /* what u hear */
 
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+
+		/* SPDIF I/O */
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+		break;
+	case QUIRK_R3DI:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
 		spec->out_pins[1] = 0x0F; /* Rear headphone out */
-- 
2.7.4

