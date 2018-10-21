Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D9ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410B2054F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB1fundd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6410B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJVCIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:08:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34720 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJVCIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:08:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6-v6so24026529qkg.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yGZUxRyDOohVXHLFoxIMihl1wsggJl9dF83gCda2JAQ=;
        b=tB1funddzUH1MSmzAIRh7QsZcq62A178ILriagglKdyx6s6hVBvSFd9RJxE/11ks7T
         QAakppKncsWRj7++4ZsCjq8LLoo7ofkL5p46Xhe6y1XGsjp+84rpG7qfPTPv+DonanqY
         zqvYfO8iFQW92hZ9rjKhEEpDI7WDAn+nCyF+YGYMrdc5DhhxI5y1q/ulcofCQkMneFCH
         VnjjE1+Kic4IKnY7IdWQB3o7vtvPF3M9na6xbqad7MsuZXbIx+fiJ5xxsaxelEoE+MVF
         lr7vlItiDJPVbgcEPo/Xe2+PhmprNy4svZnXHxeh+mFFcXIjxDqpR9aX/aSyYZLsgra7
         ONmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yGZUxRyDOohVXHLFoxIMihl1wsggJl9dF83gCda2JAQ=;
        b=pqk3xPLOGup6EmgOKpy36+EJq/fhUWLxZcqO9ockSHqWerbNH1jhKGk9qgHXab7+4z
         hhPfv0SBUMyX5/n7kZZ8LFGXGNB3M2u++S914+7s9XoydXPixLJ94wPlUHXRXcdPtGjW
         5pwPQGMGP+meBLwvznBQzj9/2z7f0V5IuWhVBTDIh0oX78vQQXwnxiMcTUukdygPMJqC
         7ZS+ey/GU4uPX0egQd3d809DAAON6Phq0bOudLXsVw42XT44sKHo99G778b69o2vEJgN
         f1gkmGL7+7g5Ngo2Mekanmeyrm78M2bC8zRussCa2aa1fjZZN9uS3JEH2RPwc8xpKU4g
         beWg==
X-Gm-Message-State: ABuFfoga8i8PZNFiizCJhqNxOtuY4FF+W8GVFyMTTJPioyvem1kBcUtK
        sDF2evUBH37viORWKSWq90I=
X-Google-Smtp-Source: ACcGV62D6t1OwVIsSuD9jRnvk4xl6ETUPfsm1zLPmhS4trJfBONLRna0RVOeDV7ldweB2gb/Q3LmQg==
X-Received: by 2002:a37:914:: with SMTP id 20-v6mr24846683qkj.135.1540144411691;
        Sun, 21 Oct 2018 10:53:31 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:5072:43ab:600a:f114])
        by smtp.googlemail.com with ESMTPSA id u71-v6sm6875730qku.46.2018.10.21.10.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Oct 2018 10:53:30 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132 - Actually fix microphone issue
Date:   Sun, 21 Oct 2018 13:53:03 -0400
Message-Id: <1540144385-27454-1-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the microphone issue for all cards. The previous fix
worked on the ZxR, but not on the AE-5 or Z. This patch has been tested
to work for all cards.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 73 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 1a13cea..f0ef52e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6983,37 +6983,44 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 static void ca0132_alt_dsp_scp_startup(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int tmp;
+	unsigned int tmp, i;
 
-	switch (spec->quirk) {
-	case QUIRK_SBZ:
-	case QUIRK_AE5:
-		tmp = 0x00000003;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-		tmp = 0x00000001;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-		tmp = 0x00000004;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000005;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		break;
-	case QUIRK_R3D:
-	case QUIRK_R3DI:
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-		tmp = 0x00000001;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-		tmp = 0x00000004;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000005;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		break;
+	/*
+	 * Gotta run these twice, or else mic works inconsistently. Not clear
+	 * why this is, but multiple tests have confirmed it.
+	 */
+	for (i = 0; i < 2; i++) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+		case QUIRK_AE5:
+			tmp = 0x00000003;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+			tmp = 0x00000001;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+			tmp = 0x00000004;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000005;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			break;
+		case QUIRK_R3D:
+		case QUIRK_R3DI:
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+			tmp = 0x00000001;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+			tmp = 0x00000004;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000005;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			break;
+		}
+		msleep(100);
 	}
 }
 
@@ -7246,8 +7253,6 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
-	msleep(100);
-
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7292,8 +7297,6 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
-	msleep(100);
-
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7351,8 +7354,6 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
-	msleep(100);
-
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-- 
2.7.4

