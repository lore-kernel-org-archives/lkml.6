Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD8C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF0620880
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzCw7hyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF0620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeI3JfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:19 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39952 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeI3JfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:19 -0400
Received: by mail-qk1-f170.google.com with SMTP id c126-v6so6183250qkd.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+LKv/IPCswbgjqQe/FK0psVKCsxJUCsCF28463EHbw=;
        b=YzCw7hyRgzV4/MoHUWX8d30oxshqSG/JFyys2PdsPLrHR5Asx7qcexWWyFiF6NvCQW
         dCLh0UwguoXT2j8ndcnwZ0kNzvoNOJjCRcGXD2J68iueNvlKQIP6nk5TjANbM/IXyq0c
         WSD5p7NF00hbn3VrLdWTXoxKccHJd2rQEHfsia9+ktBVDXNtHLnQegscuifxB/aBVe+h
         jLtVk13ZaQvoCJcwxA/Ok9gOwsg04WUABS8MrnTiJhbpH/Gc3LFdg68DknBSB8Kg9zCu
         CfogaLZJgLyQIfZEhtOn3gRN+ICiA/xGb6XV2bT5LYn663NTHeWqgWzxDVe9WoMOJIGl
         Q3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+LKv/IPCswbgjqQe/FK0psVKCsxJUCsCF28463EHbw=;
        b=sJkch5kv8q6Fb+MK/aGpNCQwSIPZjbbwWeFt14T39CQm2X5MdTZnVl2HitjvCMlE1I
         wLCBQPQWY/CqMJxzPX5GHaSAoVHFsWijTWoMwo2p6Vbnd2uzKhrV5mzcECDOpANlR1VM
         oQM9GK2/TPBETL9WL8SVQQ6qQY12RJaJItobBiXAsf5j6NRuurHJGdEP9wSWrGerkIO0
         jRrieftiGKVwz1gVAtXmq94p4wxBxpgkn6ILpmaQ5xLW3WbFIcZ5tsHXSaRXk3a0lzv+
         oF5Rl0eZhZzxaLaw6geoCQmVTOuqMykBB2TOh1D0Dyr6M3QsTFdomMyaZwPnMTOsX8jE
         NC4w==
X-Gm-Message-State: ABuFfoik/KEaDttLNFtOKZi7bqjCP6GTr+cKWGfMKDjrMIkvR9OHY8R/
        nQ+uUXdT7D9GORjhT02rQ4OfzJnK
X-Google-Smtp-Source: ACcGV60+ZBMaiBp9NTn/g65HrmorUIs8VT1JBk+BkXFDmi57WmuYeOPp1PXLeCXh+G0JGbZl09okWw==
X-Received: by 2002:a37:ab12:: with SMTP id u18-v6mr3391778qke.305.1538276652054;
        Sat, 29 Sep 2018 20:04:12 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:11 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] ALSA: hda/ca0132 - Add ZxR pincfg
Date:   Sat, 29 Sep 2018 23:03:19 -0400
Message-Id: <1538276607-30234-5-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a pincfg for the ZxR, and defines which pins are used
for both.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 08dd85d..4d23eb9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1107,6 +1107,21 @@ static const struct hda_pintbl sbz_pincfgs[] = {
 	{}
 };
 
+/* Sound Blaster ZxR pin configs taken from Windows Driver */
+static const struct hda_pintbl zxr_pincfgs[] = {
+	{ 0x0b, 0x01047110 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x414510f0 }, /* SPDIF Out 1 - Disabled*/
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x41c520f0 }, /* SPDIF In - Disabled*/
+	{ 0x0f, 0x0122711f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01017111 }, /* Port D -- Center/LFE */
+	{ 0x11, 0x01017114 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x01a271f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
 /* Recon3D pin configs taken from Windows Driver */
 static const struct hda_pintbl r3d_pincfgs[] = {
 	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
@@ -8202,6 +8217,10 @@ static void ca0132_config(struct hda_codec *codec)
 		codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
 		break;
+	case QUIRK_ZXR:
+		codec_dbg(codec, "%s: QUIRK_ZXR applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, zxr_pincfgs);
+		break;
 	case QUIRK_R3D:
 		codec_dbg(codec, "%s: QUIRK_R3D applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, r3d_pincfgs);
@@ -8261,6 +8280,37 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->multiout.dig_out_nid = spec->dig_out;
 		spec->dig_in = 0x09;
 		break;
+	case QUIRK_ZXR:
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x0F; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Center/LFE */
+		spec->out_pins[3] = 0x11; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x7; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x8; /* Not connected, no front mic */
+		spec->adcs[2] = 0xa; /* what u hear */
+
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+		break;
+	case QUIRK_ZXR_DBPRO:
+		spec->adcs[0] = 0x8; /* ZxR DBPro Aux In */
+
+		spec->num_inputs = 1;
+		spec->input_pins[0] = 0x11; /* RCA Line-in */
+
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+
+		spec->dig_in = 0x09;
+		break;
 	case QUIRK_AE5:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
-- 
2.7.4

