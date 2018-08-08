Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFEBC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7F9216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulglh9x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7F9216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeHHT4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:56:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38125 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbeHHT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:56:09 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so4667915itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t4g79dX1W6I0kmo5k8HEqYfF+ajMC99xYZTKmbnIJqQ=;
        b=Ulglh9x0h4irUEi5R9kRgyoNtvrbf+sZC9MlLY8jgvnz5kiYethHCJBoWUSoT8r5V+
         4T0Z1XBAauhnFzDzhuKmAUeIb5Ypf+xmFXM/DtxWEa7I4y2lalKKMrL2HPC01MhJs17b
         ovYV8KGxCGn0MT3PW3ci0jvwVRqWW28ZUDwc3sgfItPkd4mZM8Qcz186ZYnI8aNTFsF9
         LFvfqh0bdNuwU605sMrFXhmaXkTRdUm64qKADXeOatnhlNYuIJqMDcObaYwJ9uo7WMri
         R20PK8xbQbGVfmb/awRWz52IW6Li/7HPvGWalSQHRKQt7Tfe2oGFsHp5ByiYmrW4wc3z
         /YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t4g79dX1W6I0kmo5k8HEqYfF+ajMC99xYZTKmbnIJqQ=;
        b=J49Ke2nGqJ12e85VFCSHppAdB/8Y0vQ4306bMklHHDG7Bx7MNQoWvmqqKxduYiG3M3
         TvPMDrxLUzqCSGNtcYTFXqpZSMLQO5ZjIL4CSWRc3u2x7IhnvDlKbluqS7tRT9WDib2V
         11Jism6fY+Kq/fXzN1jWDay71KrRl83Wj7Gt8F521bXVQAj942yRAppNOZPrMGPJZRbT
         34b4pYn/m5fhJeQp51R83bOAwKI7+r9IQ/DIFyYx4oMhiohooDTYOdWribYJj+UI2d1A
         iozqYlp/TT+ucL0s+weXUywtimP3alGQf11zdPD3BRl5hscH0Z/GQ3bm8Nz1ny024FRm
         12XA==
X-Gm-Message-State: AOUpUlHnz11elnG7ENC1NuS8ykduVBKDnIDZhmxDuOC7h9YSC7zLloRc
        W9FiFi9T70NOU0hWMnfqQcQ=
X-Google-Smtp-Source: AA+uWPxV7Qh0hdKgvF9Vz8LscxRQB4gCnmSbMPtZx4ZOgkzE0GWIwnibVxboHnysgqbSsBVYKz0DVg==
X-Received: by 2002:a24:2911:: with SMTP id p17-v6mr7792itp.134.1533749727310;
        Wed, 08 Aug 2018 10:35:27 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:26 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] ALSA: hda/ca0132 - Add exit commands for Recon3D
Date:   Wed,  8 Aug 2018 13:34:22 -0400
Message-Id: <1533749663-8200-12-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds exit functions for the Recon3D, and cleans up the
current exit function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6f288d7..61ab735 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6969,7 +6969,7 @@ static void sbz_set_pin_ctl_default(struct hda_codec *codec)
 				AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00);
 }
 
-static void sbz_clear_unsolicited(struct hda_codec *codec)
+static void ca0132_clear_unsolicited(struct hda_codec *codec)
 {
 	hda_nid_t pins[7] = {0x0B, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13};
 	unsigned int i;
@@ -7022,21 +7022,22 @@ static void sbz_exit_chip(struct hda_codec *codec)
 
 	chipio_set_control_param(codec, 0x0D, 0x24);
 
-	sbz_clear_unsolicited(codec);
+	ca0132_clear_unsolicited(codec);
 	sbz_set_pin_ctl_default(codec);
 
 	snd_hda_codec_write(codec, 0x0B, 0,
 		AC_VERB_SET_EAPD_BTLENABLE, 0x00);
 
-	if (dspload_is_loaded(codec))
-		dsp_reset(codec);
-
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-		VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0x00);
-
 	sbz_region2_exit(codec);
 }
 
+static void r3d_exit_chip(struct hda_codec *codec)
+{
+	ca0132_clear_unsolicited(codec);
+	snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x5b);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -7382,16 +7383,17 @@ static void ca0132_free(struct hda_codec *codec)
 	case QUIRK_SBZ:
 		sbz_exit_chip(codec);
 		break;
+	case QUIRK_R3D:
+		r3d_exit_chip(codec);
+		break;
 	case QUIRK_R3DI:
 		r3di_gpio_shutdown(codec);
-		snd_hda_sequence_write(codec, spec->base_exit_verbs);
-		ca0132_exit_chip(codec);
-		break;
-	default:
-		snd_hda_sequence_write(codec, spec->base_exit_verbs);
-		ca0132_exit_chip(codec);
 		break;
 	}
+
+	snd_hda_sequence_write(codec, spec->base_exit_verbs);
+	ca0132_exit_chip(codec);
+
 	snd_hda_power_down(codec);
 	if (spec->mem_base)
 		iounmap(spec->mem_base);
-- 
2.7.4

