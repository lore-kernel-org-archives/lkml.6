Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3753C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4822177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeIkSeqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4822177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeHHTz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33234 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:58 -0400
Received: by mail-it0-f66.google.com with SMTP id d16-v6so143853itj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nUDl70fkOm2sHf6lHMDHJ2UbSE/ayyLokfVLuzgZvgA=;
        b=KeIkSeqZQpi6MtVNIKRpYfsv6qaq2ZdgTouwFeB/77RnU4rTzmzDip0UQst3Himdzc
         xO6w/vpKzevMNXoGVkMtGfANJhvKgh2htHFlBRXffkcNFkuiM+C7JDB1yYSh5ZReR3pV
         FpmWqQOm5/GAehs5ZKzG3BXz7MlEH1hBUMtocm6sil9iMIezW5zsq6xlQG9CTDpQKimp
         EZQUsdrqCfT18AQ44s3ic4PH3FpQ2vT4cKGoc7djYguXE160HdrNKcSrQKLK6gHjswrY
         KkoOOyongRXYRuoBc0Jzo6n68MDInMJ6dQQo5HbBaCS12PpvQittQ4KZc5uN7FyIQqYi
         S7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nUDl70fkOm2sHf6lHMDHJ2UbSE/ayyLokfVLuzgZvgA=;
        b=fMw6Z+5W1XY517OvvX+lAis2mj2KgmAYsxcNnuy8tl1DxMnAJcOQOJMhEpjlIhKFwJ
         aiZrEOfaFPo/H43InIO0kuqgq3H1y4l4ZQAoJfJUuhQx4E4dSQox5lxoHgI3vDE874V8
         QO7Nj1err9yvq+3XAXViBtge8jtR1e+RU9pmF/C66FYz1FGPWxoRcM/7hf0D86+N6eLB
         dqvwEEX7gcQUTDMX+wAZGZzG+y0HVF7h46ofbLDueppx6FALX1BFkuUE5m7q0RSh75LX
         2q01sz9gpz5BQaDcHhZy+o5O4DzjpF1wyKyvi9rJoEMpvGzang4q3xlsdl1NMsjif7Uy
         vE+w==
X-Gm-Message-State: AOUpUlGGipQ5I8ahoCqt5rOrxSx4DyyUUIMfvj6x0pCtI6f8Kn4IHzU6
        0UWhQVSC9sFZikxu+z8onwY=
X-Google-Smtp-Source: AA+uWPypCkZRtPnrFlBSOkmLepRFu0cW94mL+qKnldysPZ3aEM/qeaSsCDey1Ze7QzKb3M7D4uEung==
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr3369385jaj.131.1533749717020;
        Wed, 08 Aug 2018 10:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:16 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] ALSA: hda/ca0132 - Add bool variable to enable/disable pci region2 mmio
Date:   Wed,  8 Aug 2018 13:34:17 -0400
Message-Id: <1533749663-8200-7-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to choose whether or not to map the pci
region2, which is used for things such as GPIO on the Recon3D and Sound
Blaster Z.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2ee9549..b35b179 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -965,9 +965,11 @@ struct ca0132_spec {
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
 	/*
-	 * Sound Blaster Z PCI region 2 iomem, used for input and output
-	 * switching, and other unknown commands.
+	 * The Recon3D, Sound Blaster Z, Sound Blaster ZxR, and Sound Blaster
+	 * AE-5 all use PCI region 2 to toggle GPIO and other currently unknown
+	 * things.
 	 */
+	bool use_pci_mmio;
 	void __iomem *mem_base;
 
 	/*
@@ -7563,16 +7565,6 @@ static int patch_ca0132(struct hda_codec *codec)
 	else
 		spec->quirk = QUIRK_NONE;
 
-	/* Setup BAR Region 2 for Sound Blaster Z */
-	if (spec->quirk == QUIRK_SBZ) {
-		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
-		if (spec->mem_base == NULL) {
-			codec_warn(codec, "pci_iomap failed!");
-			codec_info(codec, "perhaps this is not an SBZ?");
-			spec->quirk = QUIRK_NONE;
-		}
-	}
-
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 
@@ -7591,19 +7583,33 @@ static int patch_ca0132(struct hda_codec *codec)
 		break;
 	}
 
-	/* Setup whether or not to use alt functions/controls */
+	/* Setup whether or not to use alt functions/controls/pci_mmio */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+		spec->use_alt_controls = true;
+		spec->use_alt_functions = true;
+		spec->use_pci_mmio = true;
+		break;
 	case QUIRK_R3DI:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
+		spec->use_pci_mmio = false;
 		break;
 	default:
 		spec->use_alt_controls = false;
 		spec->use_alt_functions = false;
+		spec->use_pci_mmio = false;
 		break;
 	}
 
+	if (spec->use_pci_mmio) {
+		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
+		if (spec->mem_base == NULL) {
+			codec_warn(codec, "pci_iomap failed! Setting quirk to QUIRK_NONE.");
+			spec->quirk = QUIRK_NONE;
+		}
+	}
+
 	spec->base_init_verbs = ca0132_base_init_verbs;
 	spec->base_exit_verbs = ca0132_base_exit_verbs;
 
-- 
2.7.4

