Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F045C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4312082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="jrXN55PB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4312082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeLEHne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:43:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40482 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:43:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so9585455pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T7zPdAgVX6NRDcQ+8jrRQikWxTheeKHpLyGIqsBRtP0=;
        b=jrXN55PBlIimDTxZ5ZB0IFPyaCjN+TfwfwEJziq06I9p9Wp+djjQzIGgEoOeDfqpmM
         pQ3cnbSN2bLPOUXipnx4XTSOC+DnziQLhmHVEY1EVeQ0pH39DJOtZApdP/us9VEc0QAv
         f1kgIY8nz3pRyksUPV9cFx6v81Voeqc/F6Xz/pkYPv6JdW4WaWcAoPtehrEaIFFTsko+
         eRopTZ5csg83Diz0gXoY2rLHdxYlgfKc3IN5DsjIHq7a8EMN36cNHYZO6opeRVboWb+/
         TNgEnSIwJwVydD1U24ZX5kIw0l1o/scWlUcyE6LK+phagao72QGPiJJ3hxQ+j50hcm8G
         XCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T7zPdAgVX6NRDcQ+8jrRQikWxTheeKHpLyGIqsBRtP0=;
        b=j/ommhlFglMlNbn3bagm1E9t/kmPKdA3HyqqhTfjtXvaBAK5mVf8M3AENKQKaqyLkC
         wl2RI67tCABTFUseNnccqDLK2A79VhO6McBPTWa9WmuMq4o1H3gZ8l0LIb2ebxLu++cI
         KycUsbb0nAFRhkrUbp0hxbUOi0Sd9GAqExSRVK7DFRyrxNCksUVtNOhMkyi0pl3xmY37
         kA4RPi/DW5sDIib1Bw5pOLAOk1yM5nX5WYmUGcVNXrJR3wm6YmcwN0T3d/NSMpYMip0H
         b1X7jNUVD1WD5HnG5ZgJEvXcJJoyjBXxwDm/qm0U1b1AcX9smN3xR0YJpiJedcG8pZ50
         PMZQ==
X-Gm-Message-State: AA+aEWb1wZoP0+ap9D3IhkQW98TpNGbRN66D3Hn9MmJigFum7Q6qLcO1
        WaRLw+1M5/5jEB2dT0GeEr4Muw==
X-Google-Smtp-Source: AFSGD/VSU9fc2XL/lzkmt56ghb2OJm8Gkw2/6BO4BRqwEF68h4hZv6rJWLJQSg182rLY2wfgSTfJgA==
X-Received: by 2002:a63:e302:: with SMTP id f2mr19864608pgh.320.1543995810770;
        Tue, 04 Dec 2018 23:43:30 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id m76sm22473535pfi.102.2018.12.04.23.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 23:43:30 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
Date:   Wed,  5 Dec 2018 15:42:11 +0800
Message-Id: <20181205074212.31104-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181205074212.31104-1-jian-hong@endlessm.com>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX533FD with ALC294 cannot detect the headset MIC and output
through the internal speaker and the headphone until
ALC294_FIXUP_ASUS_SPK_NOISE quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bbae06267054..5c25c8c3f703 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5518,6 +5518,7 @@ enum {
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 	ALC294_FIXUP_ASUS_MIC,
+	ALC294_FIXUP_ASUS_SPK_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6414,6 +6415,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC294_FIXUP_ASUS_SPK_NOISE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set EAPD high */
+			{0x20, AC_VERB_SET_COEF_INDEX, 0x10},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x14},
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_ASUS_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6556,6 +6568,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", ALC294_FIXUP_ASUS_SPK_NOISE),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
2.11.0

