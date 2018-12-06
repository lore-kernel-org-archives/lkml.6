Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5366C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F5920850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="HDiXWWW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F5920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLFIrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:47:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35812 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeLFIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:47:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so11473516plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S6UUzWoHrFyUGJvbU54VOfz25vN9tf2hSw8UHUxvJXI=;
        b=HDiXWWW/VmEZier9CtzOqD+Ex5saTTeEvnHAKzaTxO/N5alVQ5QLp8Vd7iCy9eGVmA
         n6tZm/HU0uBqPHvh4vbElNkiaqzUAaAbz0DcOHgY/VD2us8CaD0wDpD3lNENBoMDiWGJ
         HwTKeNcP6r8C7sur4GJhMA9Kphl4s/N27sSjKlVOze0bq3osHbgUf5du1ooSAWQaJoE9
         +mrUGa2FDhO9+mMbRetoThuevfvphPgC6HZq5qFLp5XEg2l6B22DbL2RlAx4PAmH1A/6
         YKeXcnmyucmS/BnVZDA4udzPXRMP7A4/9ZHpRr72b/7vNHrjwrmCoabRK2te3IFKMZ9E
         2qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S6UUzWoHrFyUGJvbU54VOfz25vN9tf2hSw8UHUxvJXI=;
        b=Wfmgs/kCx+thPPdiG3WUa7dc/nf61Vk/rFAzdY1gwKR57eDCHZVrmG2K7UzBp1E25z
         sQZ8VmFnHvZ1ooLLxeKKdAhQFjZBEpBVseHqQtgjdQFuUnAALE0RvKWhJoBIX8+oNIRP
         h8NhERXbu/1lmSv34bBpv29IX+n5y4onctILhHQJXzrxHWqY2hvrO1LS/GN3rGns2Pj4
         5xE3AsBgoEBBxIdfq4dNCZfe3k1BkkBQmKELOVGSIp3ppe/Ln6FWKx5wIiSdK8lvXJxT
         vTsDTSBSIhXgQ7URzJePDG2dY5hPd1kUNpFk+mv7RM4NOfvMcocsJ9xjUXknfaJYKJx+
         GO0g==
X-Gm-Message-State: AA+aEWYvYRmQTG2Ibf2XOMGJTqG3Bj042KBMbwkMRZuLghDRUrWF44/D
        ycAMxYzdPC17XcCswPTkN/9Fjw==
X-Google-Smtp-Source: AFSGD/VgtRNC6Uf1dmug7UY8H7PIxBOC/oenntAi1xUSpI6h8S1KQV0L4Og57SqRax3de/KJCOJdUQ==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr26196838plp.19.1544086055035;
        Thu, 06 Dec 2018 00:47:35 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id u70sm40484836pfa.176.2018.12.06.00.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 00:47:34 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
Date:   Thu,  6 Dec 2018 16:45:53 +0800
Message-Id: <20181206084554.4728-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181206084554.4728-1-jian-hong@endlessm.com>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com>
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
v2:
- Modify the HDA verbs for UX333FA support
- Make a new ALC294_FIXUP_ASUS_HEADSET_MIC quirk for ALC294 chain
- .chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC

 sound/pci/hda/patch_realtek.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d32e50b1ed60..1525bcdf96e8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5518,6 +5518,8 @@ enum {
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 	ALC294_FIXUP_ASUS_MIC,
+	ALC294_FIXUP_ASUS_HEADSET_MIC,
+	ALC294_FIXUP_ASUS_SPK_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6414,6 +6416,28 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1113c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
+	[ALC294_FIXUP_ASUS_SPK_NOISE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set EAPD high */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
+			{ 0x20, 0x4c4, 0x20 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, 0x488, 0x00 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6556,6 +6580,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", ALC294_FIXUP_ASUS_SPK_NOISE),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
2.11.0

