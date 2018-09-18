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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63971ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E00A214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNzPCOu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E00A214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeISAI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:27 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42720 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbeISAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:26 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so2665665qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rDZVJePVfJo2ljZeIe9wGOUwq18IZmhUECBVkgFtXkg=;
        b=KNzPCOu/k3c/MuFz39CMyBYWW8Lqy8dbOsolfGMVJxRnEVSMreL2zzqZ/pGx3eyynH
         av0e/a2af2LgiNJ8SbymVhXFg4AabnJSSM/qaJMGs29XbtZkXBI44cBDOnPJhViNBNxl
         LQxP1fG8Q5WTzhbehFH01HPdwbwpRNgx61TbeGH117y6MOwZI7Sezd7K3UOENzd2N+J8
         Q5M+7yJdhW/0SjC7xBNDz07a4TLspFbfCMzdMIAMR0MTHvOGAR6MtMvVgdgyCnyadvcU
         sj7LPaMt0kvZ8zNN9lEJXOupR9gdfFIxdEkWaUaUBN7kW6DdGeJPjVEIN0jwrXQj4jqY
         TlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rDZVJePVfJo2ljZeIe9wGOUwq18IZmhUECBVkgFtXkg=;
        b=Fvznj891RuErynZrN2C9IxvzA1FzHxc3m3+ImKll+unNXoXfrCqO9wdIOhcxgg/Kdz
         Z2CMjtqGN3qYTBepIFD/g+QI95sOfVup+3hgDpaHiwlIVFydtu7aZAToDVWmaxFQiySa
         0gWptmmoeEDS+BM2dtRmEB/HFw3Vjmpg14vSVyOeA4b+PqIYI8eeP3SKP2I+DrpotY7t
         v1v1vECRt3AabvG8aYQqCek4qGBsxLCC2uhGlxdTkeTryObMcuiVdkEfli3NMgFIGd0a
         zwz3X0yFmYSya7rsiVoLqsy2wvB8FyA9fCrHwkNs7lwf+qgTIMgwYN6suAjmN85LtE/G
         ej1g==
X-Gm-Message-State: APzg51BwZtk74s1CK3TtVJeOFMwLJkBEc14X/HHDr6VwgbNIu/PMfyPa
        K4KyFf9vuWjTWBSkjFAqsMM=
X-Google-Smtp-Source: ANB0VdZafyh65YbHmCFzHjANqECdL2sXU6kNpCamkJdLb1VgEJljiFRIyFQorAc4dVDH0sZw+G7row==
X-Received: by 2002:a0c:becb:: with SMTP id f11-v6mr22609181qvj.217.1537295674387;
        Tue, 18 Sep 2018 11:34:34 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:34 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] ALSA: hda/ca0132 - Set AE-5 bools and select mixer
Date:   Tue, 18 Sep 2018 14:33:32 -0400
Message-Id: <1537295625-8082-5-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets the bool values for the AE-5, as well as selects the
mixer it will use.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5f53c71..7c870c4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7597,7 +7597,11 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	spec->chip_init_verbs = ca0132_init_verbs0;
-	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D)
+	/*
+	 * Since desktop cards use pci_mmio, this can be used to determine
+	 * whether or not to use these verbs instead of a separate bool.
+	 */
+	if (spec->use_pci_mmio)
 		spec->desktop_init_verbs = ca0132_init_verbs1;
 	spec->spec_init_verbs = kcalloc(NUM_SPEC_VERBS,
 					sizeof(struct hda_verb),
@@ -7671,6 +7675,10 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mixers[0] = r3di_mixer;
 		snd_hda_codec_set_name(codec, "Recon3Di");
 		break;
+	case QUIRK_AE5:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Sound BlasterX AE-5");
+		break;
 	default:
 		spec->mixers[0] = ca0132_mixer;
 		break;
@@ -7680,6 +7688,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
 	case QUIRK_R3D:
+	case QUIRK_AE5:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
 		spec->use_pci_mmio = true;
-- 
2.7.4

