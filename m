Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7103CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F07A21781
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIzYO/Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F07A21781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeHHTzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:51 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:44964 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:50 -0400
Received: by mail-io0-f169.google.com with SMTP id q19-v6so2463314ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pbarrIxl+ZHEuNSDhcUA9yZa8fTgAZf/kdXk0HHvmZs=;
        b=KIzYO/LvFM6NEzIGtKVUGIbHcZ/5JULL8c2TZPLM8XoGFiI8rIGBmC2HYTabVXoozE
         3meme+k/HmgABuK3EDW98m9yfkmo0mp4AMMk/1Bob4gjELdUCbj3g2+etGXE7xvVgJxq
         LMItTDp5C9DtcGlHDNQh6XPiZ2i8FTPsAA2rO22V6xyDwo3hrx4l0MBHSpLLOqwfzla9
         qs9hncm/ezhiU9JyXW44C887w2yY0YdbqEI6JaaFkvEBS48UyeSjUMElbYpaGJidmwtR
         G9GfiFmohEEBI1GE9pCbsUwozz2swaZX9Bv7agj/cjbdDy6G/36ZX1fx7NvmkCWelP3Y
         0dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pbarrIxl+ZHEuNSDhcUA9yZa8fTgAZf/kdXk0HHvmZs=;
        b=ZgDvAeQOb6biAvB7G9NSluKRDcS8S7mdrcNBygggYT8cjKcHuTPws8ltDMTLh018Or
         LlLLFT3/eCXCvlfwDI/Gw9amUefyaWKon65uJlualyD+50dXEsGEobtzTU/sIFEE2Awf
         GIUkz/8Zu3B6aKAU9M5zd6LTH6ajopllhnDqZAzQGLPo0UEJuqzgOVzjCsK/lo3T4Au9
         0A1TNDbDy/NNu4qz3/3B8G2X8TPQO70SPVzrnGsqpUPJjX4V+1TmM5iHug3GrKwDMLT2
         Z0ZS6jaBo6IdhWm2w9Vx3v2qTyhese0rFWUdR0ivqvZ8Qlq5TWsWrM4TaOj64tDJn2Q1
         KqVw==
X-Gm-Message-State: AOUpUlFc6RZNZtgA+dB2k5dIHvmuPa9JcqBIUW27gsuxFv0q0poGfrze
        gjOduhvK606WTByFMtwaXAk=
X-Google-Smtp-Source: AA+uWPw8rNQgfAvNXDkU6v1CbqiUcyYU/IwhTLqI6L2SpdpvbQmEl1vqkgP8bXoUM23gRFvxtcHETg==
X-Received: by 2002:a6b:6407:: with SMTP id t7-v6mr3307908iog.111.1533749708856;
        Wed, 08 Aug 2018 10:35:08 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:08 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ALSA: hda/ca0132 - Clean up ca0132_init function.
Date:   Wed,  8 Aug 2018 13:34:13 -0400
Message-Id: <1533749663-8200-3-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up ca0132_init by removing unnecessary commands and
ordering things better.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9a92a64..b3c2cae 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7250,14 +7250,12 @@ static int ca0132_init(struct hda_codec *codec)
 
 	ca0132_refresh_widget_caps(codec);
 
-	if (spec->quirk == QUIRK_SBZ)
-		ca0132_mmio_gpio_set(codec, 7, true);
-
 	switch (spec->quirk) {
 	case QUIRK_R3DI:
 		r3di_setup_defaults(codec);
 		break;
 	case QUIRK_SBZ:
+		sbz_setup_defaults(codec);
 		break;
 	default:
 		ca0132_setup_defaults(codec);
@@ -7288,20 +7286,12 @@ static int ca0132_init(struct hda_codec *codec)
 		ca0132_gpio_setup(codec);
 
 	snd_hda_sequence_write(codec, spec->spec_init_verbs);
-	switch (spec->quirk) {
-	case QUIRK_SBZ:
-		sbz_setup_defaults(codec);
-		ca0132_alt_select_out(codec);
-		ca0132_alt_select_in(codec);
-		break;
-	case QUIRK_R3DI:
+	if (spec->use_alt_functions) {
 		ca0132_alt_select_out(codec);
 		ca0132_alt_select_in(codec);
-		break;
-	default:
+	} else {
 		ca0132_select_out(codec);
 		ca0132_select_mic(codec);
-		break;
 	}
 
 	snd_hda_jack_report_sync(codec);
-- 
2.7.4

