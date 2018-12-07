Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A019C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UM191/4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE4120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLGJSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:18:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36416 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:18:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so1666695pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KxPItma6iMq5b3ggI3ekPmiexyI65emc/TDmZwDFCZ4=;
        b=UM191/4+gK6D7CZdVa8mvHF1VSs+ECz5+aDJ1P0niaf+uB2QrWUV0evw/utj0FqjHq
         L/9VjPP1VNZNhN+XHH0JB11LxrxS2NVemS/uE8ybx7LdGr0sywUqhEk6sLMu449/b9IX
         vDXL0T1BwJ1LDvonEXrexZYOwXHQQHbivxfVRFZmdQZYBuTc2msTBppOthQQEg4PqEU5
         Vpsvyhc5mBjBLQEWKuZ5+vYUCz+GpuZJRAv2L/F9GzG6OGKi3P9YhTi3gk9q8HsEFfsz
         JUdjAUYWwDxE7kHh/nUNagZOqxYWVjZrp04ZJRTAf3Po1XU3XVXUJwbixb6vMeueb2FE
         43dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KxPItma6iMq5b3ggI3ekPmiexyI65emc/TDmZwDFCZ4=;
        b=WPj9qZ6gyqwzs3khSJcH3FrmmZQp/e9uoISBi/fuBodbK6zt4ormdmVzE/A0ii0ohJ
         S/vMBfE3LNlXysPzSGZSfW3AbqtUyV3p6N4NmtnANjtv/jP0CzWfNHcQjXUTRc6a2lJW
         fjgY9lefLucGn94ui+vznw5O3+PS6U/Q0TMxDf47s7fLm5KX3mRTIa/y3X2Vq1UQa+iM
         b4x30nyVXi4rYyFJeJp1n6Odte3Ik1DSo3bo3ecENnROnhOceubkM4xWJUQHTByexF7s
         SdcQLRQSjAKCH5vfOvgd6yMiaLY9O2Mz3sIEb27BCXE7MyAo0gdqkBumW9i2rD8k2bJS
         DvAQ==
X-Gm-Message-State: AA+aEWb4xzEAaZ6maTbV4w04U3IKt7CqcXoCOPj+Xfdioe/F8+TqbZrZ
        w0LstGwjOb1GEwpe1HoOBW+Apw==
X-Google-Smtp-Source: AFSGD/VwNQ+RpC8U2mbfnTTgNxblrALmYwcFQMIaAeu537DEwpiPc0oVUe0UHVhZkS7myCZfXpWigQ==
X-Received: by 2002:a63:5a57:: with SMTP id k23mr1250327pgm.5.1544174324396;
        Fri, 07 Dec 2018 01:18:44 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id y1sm3480927pfe.9.2018.12.07.01.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 01:18:44 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com, josh@wtmec.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v3 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
Date:   Fri,  7 Dec 2018 17:17:12 +0800
Message-Id: <20181207091713.7483-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207091713.7483-1-jian-hong@endlessm.com>
References: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
 <20181207091713.7483-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX533FD with ALC294 cannot detect the headset MIC and outputs
through the internal speaker and the headphone until
ALC294_FIXUP_ASUS_SPK and ALC294_FIXUP_ASUS_HEADSET_MIC quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
- Modify the HDA verbs for UX333FA support
- Make a new ALC294_FIXUP_ASUS_HEADSET_MIC quirk for ALC294 chain
- .chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC

v3:
- Modify the HDA verbs from Realtek's suggestion
- Modify the quirk's entry name

 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d32e50b1ed60..aa7aabd6e09a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5518,6 +5518,8 @@ enum {
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 	ALC294_FIXUP_ASUS_MIC,
+	ALC294_FIXUP_ASUS_HEADSET_MIC,
+	ALC294_FIXUP_ASUS_SPK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6414,6 +6416,26 @@ static const struct hda_fixup alc269_fixups[] = {
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
+	[ALC294_FIXUP_ASUS_SPK] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set EAPD high */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x8800 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6556,6 +6578,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
2.11.0

