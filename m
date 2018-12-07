Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA76C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D6720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="QniBzZD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D6720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLGJSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:18:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45603 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:18:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so1645557pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8RG9DGsLTky/JZ1in/dz32c6uI7zGn2e292wRTOfLck=;
        b=QniBzZD27SoXdO3YyqD8EzdpoNuFYSuhO97zOyE0Cl10I5yYmmFx5BiiFL9+zyZFfu
         c+9dUFVcm9fADa9urt4hnWJRk+WUh1M6M1pYnlPKgRFFWg+G47rVea9vf7cVeQWGsEzS
         oPdVtpbknQQKBcLx6hyxY8/w5MBgfzrEaGdxKNb/xLU8ap0pBWH4gSNaRAie+16uZq56
         xZJzs6lnWcLXqUb1yvyYra/proyyIjwn4uMldT2mazp2/gEIKNmHFMYffwPvnzANAIgT
         exRa5OsNITKvzxKuJC2KYg5NJ1TxiRtRUChQSYLJ0T6+3apa9e5/Fc/jiUVBqMEeE7vZ
         dq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RG9DGsLTky/JZ1in/dz32c6uI7zGn2e292wRTOfLck=;
        b=tPYxjRhpf2ZecZroZjFXr3P0fqjYxGdaNeoUYWvHNVxVugik1uM52dfR3DbiSMSh3x
         C8E0lfTEzFBh/tF6KGO+fICxx0ynhB6RKSxrjvld1hwnUvlA25mcS3Exb2qFlre926Ee
         2pmbdU8G3wkAYVOkjHEVBeQFPF3CYjmeNsRong1lb0EEsMBUXMEjIAsY3MXcFZIwq+Zj
         Zp3qTH95YsvaFO8IXrZy1WmceUp7m2LZrhIehT4zEo0uZWrDoDYKYTOleJJgXlqIyd9D
         WmDR/x4YFv1JmGCgWobjL8W3vHjeKdKKIlpX3MD1vnauQGyWNg6UfpUqDRqHmx0Fk/e/
         UOZA==
X-Gm-Message-State: AA+aEWYiIrXUh1d37csnE6yJF/apLE1Z4tlzrXmTDN5FVz7CS9j9ia6p
        3PhMrRAamXlDvdfkFKnV1ffuBA==
X-Google-Smtp-Source: AFSGD/UmBrB2aa59/zdnjj7QxNAAbSzgm/gXzaYbIwYPVypkwh3r6kLP5SxT7izevcfOdqa732UgKA==
X-Received: by 2002:a62:99dd:: with SMTP id t90mr1441926pfk.179.1544174321359;
        Fri, 07 Dec 2018 01:18:41 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id y1sm3480927pfe.9.2018.12.07.01.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 01:18:40 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com, josh@wtmec.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v3 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN
Date:   Fri,  7 Dec 2018 17:17:11 +0800
Message-Id: <20181207091713.7483-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207091713.7483-1-jian-hong@endlessm.com>
References: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
 <20181207091713.7483-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

The known ALC256_FIXUP_ASUS_MIC fixup can fix the headphone jack
sensing and enable use of the internal microphone on this laptop
X542UN. However, it's ALC294 so create a new fixup named
ALC294_FIXUP_ASUS_MIC to avoid confusion.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
v2:
- .chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC

 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb40624fb6d5..d32e50b1ed60 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5517,6 +5517,7 @@ enum {
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+	ALC294_FIXUP_ASUS_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6403,6 +6404,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x13, 0x90a60160 }, /* use as internal mic */
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7152,6 +7163,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_MIC,
+		{0x14, 0x90170110},
+		{0x1b, 0x90a70130},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
-- 
2.11.0

