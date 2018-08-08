Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B62C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051E4216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOAQseuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051E4216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeHHT4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:56:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43977 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbeHHT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:56:07 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so2475043ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MDxi8G5QCQGcY68C2MmKrPRk4/p+/VvPDub72AlCxg=;
        b=sOAQseuMc/Q3zCxtmdkZGNuCCocmpzguidqf7RgNmmZvDrASFYbq+gYBQ0QQz1XMUB
         j6XIcU1PfXIgHO5cA1CrIOvE+I8oEjucXsbokjkl6k9fBaTWOGkVM4J7zHFTGT1C574L
         yZV6BKBAg5UbgeBPRwBvj9p1FE5MakkliELTtXpn27fj9lKtbtWIojGG7Bnqg1eRes0o
         5B7Z4nrOTvOgnKTbxvV9qkKfVBM4bQ65/ijurE4EXG/l6l9T4PiquZ8n6JqCQGQYSMHE
         JAUbr4P2WpHaL8NHUGVyCTkfyB2YNMv6881jqx7aNmzAEXPtQNeWP4cnLmmJ8Ii0WusM
         dSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MDxi8G5QCQGcY68C2MmKrPRk4/p+/VvPDub72AlCxg=;
        b=TBL5xZ/Yep/4FZAp/QxOLC5WrW5Dz/k9ExX6Yv15I6tANekqonHdSiwA0qFrCmt6Tb
         GAXyq/S5HXl2/qV2lFHvtP/t3vFlFrBKH6NEX3thZmdm7DTBwZd+wIOUAkPFGPkheMSl
         BPORhrz3QF6MhMKVZH5i45F6kfVs1ZG1Q4x69qzOXNTva8okz5VXlHbmGbKY/dOgv3zA
         uCtrc4Iw3vg7JkT9q4wt+VxESzgPtSaJvjlkHDOo78Uwsogtlz928qcf5r5T9v72m6Hj
         3q9UPKnw3cO6C75CdQ8U5TK1mWDrqy7Wci3ord/MwjYhnELaqXp4Ucs7Yl1Q1F4j362v
         kDxQ==
X-Gm-Message-State: AOUpUlH4U/y56kXyWDWsoVDM+K9N0gSYWCR2o0jTfqLt4eVajAj3H0RM
        luBOywUAQNGrGxBgVUOLkkU=
X-Google-Smtp-Source: AA+uWPwYZ0XsU7SlydsLzZWJCirUGvzsKdx8FSE1QnqJC8JX9Kg1uSlWpmc7ZW2Z+Ehbknvmdj39SA==
X-Received: by 2002:a6b:410f:: with SMTP id n15-v6mr3065419ioa.3.1533749725286;
        Wed, 08 Aug 2018 10:35:25 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:24 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] ALSA: hda/ca0132 - Change mixer controls for Recon3D
Date:   Wed,  8 Aug 2018 13:34:21 -0400
Message-Id: <1533749663-8200-11-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds changes to setup the Recon3D's mixer controls.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 18b97df..6f288d7 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5781,11 +5781,11 @@ static const struct snd_kcontrol_new ca0132_mixer[] = {
 };
 
 /*
- * SBZ specific control mixer. Removes auto-detect for mic, and adds surround
- * controls. Also sets both the Front Playback and Capture Volume controls to
- * alt so they set the DSP's decibel level.
+ * Desktop specific control mixer. Removes auto-detect for mic, and adds
+ * surround controls. Also sets both the Front Playback and Capture Volume
+ * controls to alt so they set the DSP's decibel level.
  */
-static const struct snd_kcontrol_new sbz_mixer[] = {
+static const struct snd_kcontrol_new desktop_mixer[] = {
 	CA0132_ALT_CODEC_VOL("Front Playback Volume", 0x02, HDA_OUTPUT),
 	CA0132_CODEC_MUTE("Front Playback Switch", VNID_SPK, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x04, 0, HDA_OUTPUT),
@@ -5856,8 +5856,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	for (i = 0; i < num_fx; i++) {
-		/* SBZ breaks if Echo Cancellation is used */
-		if (spec->quirk == QUIRK_SBZ) {
+		/* SBZ and R3D break if Echo Cancellation is used. */
+		if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D) {
 			if (i == (ECHO_CANCELLATION - IN_EFFECT_START_NID +
 						OUT_EFFECTS_COUNT))
 				continue;
@@ -7609,9 +7609,13 @@ static int patch_ca0132(struct hda_codec *codec)
 	/* Set which mixers each quirk uses. */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
-		spec->mixers[0] = sbz_mixer;
+		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Sound Blaster Z");
 		break;
+	case QUIRK_R3D:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Recon3D");
+		break;
 	case QUIRK_R3DI:
 		spec->mixers[0] = r3di_mixer;
 		snd_hda_codec_set_name(codec, "Recon3Di");
-- 
2.7.4

