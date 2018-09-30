Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2CC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6C320895
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH219aeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6C320895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeI3JfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45557 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeI3JfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so10640593qtr.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ygDGT5UvTr04JPBsf5mnCIyqbEEqQvtjnAoxWuByV4o=;
        b=TH219aeWKsj8q7ibOHg52xT2JTvMA/4ODm8S1Fxnlc79SQF9xC3YkItCdWawAGNPO/
         N85mqVFnGYhzvqDhpccCQg07QyuojQbUvHTCgEtVVVv9qSebO2wKdX1qP8DkGMMgDjov
         upL0V57ACSq6Agr3JX8JSdQpR0nbHTIOTKsJ65MHLdALYtp7btNgxMFZZG1IZzfUm39C
         Y5NihZ143eo1k1kaVziZTZP74ok/jvhwmBQJ/1BXYSxdGDUYhCk/SeJLaJPk41u5x34g
         4JJ0l7ls9aZZPLo2Vry2xp59Ub28KsvWSqCWJ0Merau3sQNXUGvn+g3CDQeRq/3Pd2Lp
         FfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ygDGT5UvTr04JPBsf5mnCIyqbEEqQvtjnAoxWuByV4o=;
        b=fEsBaKd4yc36vXcY884/5wH+CxuBnLVD+9cZaaqsJBaEVph+85PXffDUDUR6z9TdDd
         VqaetQrxcW4FNwreNxlSepx+WRQTUwac9YWWwe67DIV9HEuJHlduCB/OvFPn5jTbasks
         O1rMVaydjh3XUPRyplaP2WySzGjs8OyNLRCEcE6FcUkGvath/i5hWGHmz1+a0FW/fR68
         Yd5DwMDA+5E62J0dKpJEmnasaTkKhUfwGnnERJJvp/eNcXjwySDB3FrOL4OXZI2dD6aY
         Kh3WaeXRJKtoeifVGEIw5w8yjvXkYf2lCtbIGhLPSNQlX28PpgjH1shcWWCuj+/tgLWK
         3Kog==
X-Gm-Message-State: ABuFfohqpjFJGxAA03NDq5y1ez2KyKFXe5i5wbjIbL3KmBTz6A82g5+h
        kOO74mj+FtjptQKE47IlnhQ=
X-Google-Smtp-Source: ACcGV61dAkmGIsQxBF7drfVxqXmQMiQf99EiDldlFNAW49JNGQObAYG0Ifgph1Q2S8rhMaY2BlvGJg==
X-Received: by 2002:ac8:6119:: with SMTP id a25-v6mr258934qtm.130.1538276656369;
        Sat, 29 Sep 2018 20:04:16 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:16 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] ALSA: hda/ca0132 - Add ZxR init commands
Date:   Sat, 29 Sep 2018 23:03:21 -0400
Message-Id: <1538276607-30234-7-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds init commands for the main Sound Blaster ZxR card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a543b23..6e48c3d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7953,7 +7953,10 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 	else
 		writel(0x00000000, spec->mem_base + 0x40C);
 
-	writel(0x00880680, spec->mem_base + 0x01C);
+	if (spec->quirk == QUIRK_ZXR)
+		writel(0x00880640, spec->mem_base + 0x01C);
+	else
+		writel(0x00880680, spec->mem_base + 0x01C);
 
 	if (spec->quirk == QUIRK_AE5)
 		writel(0x00000080, spec->mem_base + 0xC0C);
@@ -8091,6 +8094,10 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
 		break;
+	case QUIRK_ZXR:
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		break;
 	}
 }
 
@@ -8585,6 +8592,10 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Sound Blaster Z");
 		break;
+	case QUIRK_ZXR:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Sound Blaster ZxR");
+		break;
 	case QUIRK_ZXR_DBPRO:
 		codec->patch_ops = dbpro_patch_ops;
 		break;
@@ -8610,6 +8621,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	case QUIRK_SBZ:
 	case QUIRK_R3D:
 	case QUIRK_AE5:
+	case QUIRK_ZXR:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
 		spec->use_pci_mmio = true;
-- 
2.7.4

