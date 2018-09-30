Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50737C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140BE20882
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6rBptCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140BE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeI3Jfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44013 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbeI3Jfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id v18-v6so6168001qka.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lERNvumT98Bur5b4QVUwEDMXhuGofhPHyhmkm5ocxbo=;
        b=I6rBptCBt4uMnEzA372f6fa5Hsj2d1VE9mTkGSoyOVKG2zsSOcHpdv18Gs6qspecki
         Ir0a4Ei6ouFRZ4eoySonxZ1et0snKgCssXOWjH7Lywk4c8BjODB9ZAeVNggk1qKexOOq
         f90GLP9WN8o3DWqai3lUiylSTBa73xBHjnVexC06mIgM/SThZM8KUf58KWTct/vt+zuM
         nV8glMdx/6KgEjf5RgEnwjzs2KdbmiIz/eP2bQJXkhSgeFWtt3d9IebUXI5dDBntFud2
         nc3qVFaQledO55aOrqVHf9fDVxoY8fjwGXaOafradLOu7jxp6sJXhn7Yj/h28QG67Hgk
         tLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lERNvumT98Bur5b4QVUwEDMXhuGofhPHyhmkm5ocxbo=;
        b=DbkN20Iiji8fIG/6S3kNnj6wJ2+nbt9E58Qh6hHICAipKpuSK6odPA0h+V+e2lI846
         riJma2Q8Fuu/gk8KTQYZdERmIJMLedCYkLiR652jMg2K0CeyEtMQ6y3o/31PkOs8U6dF
         9t5g1cN2J3f568r74eTjIrv67yYpI+1CPTqi583nzESNkdxPpA555Wp7/XmQ4SAzZl6v
         B6g33ruWJ2CPR+NPtpZh/74+nOjoj7kx4CqyjZz/2QMBu7lwmxzvpuXrQUIbdecpgeD+
         LHE1f+xWiwnWqMKVfNPwbbSIZ40xLOhpVfOJ0fzIhd7zGztiMoKViLUE5KCrZZsTdatQ
         JWtg==
X-Gm-Message-State: ABuFfojhchvpXPgq7zER8m0FB55jMyn9kff5V3fBvrWxXwvN/ZhEhaD5
        kccsOhW64WRQUl486RuZzbA=
X-Google-Smtp-Source: ACcGV60Bth4Ht6/qWVKd9w9Lu9xJ7LglTEhJT+d0d0u4cJnPqHh2oAyk6ZDB0N5ByB/IcZc5lPC4NQ==
X-Received: by 2002:a37:f8c:: with SMTP id 12-v6mr3972916qkp.224.1538276662775;
        Sat, 29 Sep 2018 20:04:22 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:22 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ALSA: hda/ca0132 - Remove input select enum for ZxR
Date:   Sat, 29 Sep 2018 23:03:24 -0400
Message-Id: <1538276607-30234-10-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the input select control for the ZxR, as it only has
one input option, rear microphone.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bc8745f..f0781e4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6402,8 +6402,13 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	if (spec->use_alt_functions) {
 		ca0132_alt_add_output_enum(codec);
-		ca0132_alt_add_input_enum(codec);
 		ca0132_alt_add_mic_boost_enum(codec);
+		/*
+		 * ZxR only has microphone input, there is no front panel
+		 * header on the card, and aux-in is handled by the DBPro board.
+		 */
+		if (spec->quirk != QUIRK_ZXR)
+			ca0132_alt_add_input_enum(codec);
 	}
 
 	if (spec->quirk == QUIRK_AE5) {
@@ -7665,6 +7670,14 @@ static void ca0132_init_chip(struct hda_codec *codec)
 	spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID] = 1;
 	spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] = 0;
 
+	/*
+	 * The ZxR doesn't have a front panel header, and it's line-in is on
+	 * the daughter board. So, there is no input enum control, and we need
+	 * to make sure that spec->in_enum_val is set properly.
+	 */
+	if (spec->quirk == QUIRK_ZXR)
+		spec->in_enum_val = REAR_MIC;
+
 #ifdef ENABLE_TUNING_CONTROLS
 	ca0132_init_tuning_defaults(codec);
 #endif
-- 
2.7.4

