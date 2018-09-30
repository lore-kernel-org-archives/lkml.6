Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20689C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E5020685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND+QQwZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E5020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeI3Jf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35388 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeI3Jf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id z14-v6so10729751qtn.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CwUJ6imS0yjjkjF+6d8w5gTjRrXXyKR9x/vgKC0p8GQ=;
        b=ND+QQwZvrErMag09AjBomWdDYTisxvDWaMjPi2k2Hx380CcEYHGXVz0JTEWD24thrj
         roKQtRx1d37aWGjY3hl1kuYo2ovOEDDrBihEXBdy4bPYdst2H0SDidLXpZAjsjSNaS/2
         rmfQTQy8RnjcaYsRaVJ+hPl4H81mLZr8ZQZeyLVrc/oUFjo3xF+uynyG2nxc+XnGR0bP
         w4ZFu0++cXi9PB+J0lKtc5YD3XkzGlp5ZGBm+Guz6xvVW4WcYk0/czmFuXfKbqqMVTOx
         fvnvK5c70vqiBKl0l9Nr3Lmnr4yjc0NM7IN/SAOVJVuMKD8PEeM4fejo1b8FDuT9DyOI
         szHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CwUJ6imS0yjjkjF+6d8w5gTjRrXXyKR9x/vgKC0p8GQ=;
        b=g3bbscnYNX8OeiAgDJ0BeanSWDJgb9sKZaPJWr8lWQj6qRHVDNX+L3TFLsMzfCMxmt
         MRsINRji4YIX0pzQkKr9vADyN8RQnmR+Cr7uLae+eZ2Xz3HbrOfK1t4GAdKM3uVsegGP
         w6DVOXiRVPWrYLoHRceJ/eErln9UGo3yAcw373+EJpJ6FEbfhbvSipp2UmU7HaAMh86f
         D9/HBwLj7aS3ZRURtyeRLp5cLecneBOc3D3KNMpldQp+giejD7OADbPZ0rWGQI07AMVl
         Oi/QXSQYhWpX4lYdVIvMLldyARcNFxKd6aBWIqkmY6GV2QV/UozRI+LLUFubHPLVgMsB
         Phfw==
X-Gm-Message-State: ABuFfoiXi+801/17utOxiS9AzeH60mUXJ55iIvDtwIpGfx5Hc56TXKsI
        9mP6cUKX0gSJkkZs/6su2Ds=
X-Google-Smtp-Source: ACcGV60voJMlERUj+OaHvR+QpKVs0R6Ge2za84E8Q5r/R1xTGNoecBXnJV4kiGCXRRMAf4ulhJY0sQ==
X-Received: by 2002:ad4:5052:: with SMTP id m18-v6mr3123972qvq.164.1538276660594;
        Sat, 29 Sep 2018 20:04:20 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:20 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] ALSA: hda/ca0132 - Add ZxR input/output select commands
Date:   Sat, 29 Sep 2018 23:03:23 -0400
Message-Id: <1538276607-30234-9-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds commands for selecting input and output on the Sound
Blaster ZxR. The ZxR has no front panel header, and has line-in on the
separate daughter board, so it only does rear-mic.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 729766a..bc8745f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4174,6 +4174,12 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
+		case QUIRK_ZXR:
+			ca0113_mmio_gpio_set(codec, 2, true);
+			ca0113_mmio_gpio_set(codec, 3, true);
+			ca0113_mmio_gpio_set(codec, 5, false);
+			chipio_set_control_param(codec, 0x0d, 0x24);
+			break;
 		case QUIRK_R3DI:
 			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
@@ -4201,6 +4207,12 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 1, false);
 			chipio_set_control_param(codec, 0x0d, 0x12);
 			break;
+		case QUIRK_ZXR:
+			ca0113_mmio_gpio_set(codec, 2, false);
+			ca0113_mmio_gpio_set(codec, 3, false);
+			ca0113_mmio_gpio_set(codec, 5, true);
+			chipio_set_control_param(codec, 0x0d, 0x21);
+			break;
 		case QUIRK_R3DI:
 			chipio_set_control_param(codec, 0x0d, 0x21);
 			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
@@ -4229,6 +4241,12 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
+		case QUIRK_ZXR:
+			ca0113_mmio_gpio_set(codec, 2, true);
+			ca0113_mmio_gpio_set(codec, 3, true);
+			ca0113_mmio_gpio_set(codec, 5, false);
+			chipio_set_control_param(codec, 0x0d, 0x24);
+			break;
 		case QUIRK_R3DI:
 			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
@@ -4625,6 +4643,9 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 0, false);
 			tmp = FLOAT_THREE;
 			break;
+		case QUIRK_ZXR:
+			tmp = FLOAT_THREE;
+			break;
 		case QUIRK_R3DI:
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			tmp = FLOAT_ONE;
@@ -4652,6 +4673,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x0000000C);
 			break;
+		case QUIRK_ZXR:
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x000000CC);
+			break;
 		case QUIRK_AE5:
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x0000004C);
-- 
2.7.4

