Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12063C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C42082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="eRWv3+Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90C42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeLEHnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:43:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39079 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:43:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so9589635pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EBqVvozobDiK8rTN862YjwPLK1Ridu5isMm/vw4kerU=;
        b=eRWv3+QfhcOwyIKEqwVdHFJA8fA0aq2bMyyOSni5c9b7FkSaqd7CI2oXqDejgkRqiI
         o2KqA+jE2OGfpMyCS/5r6kym6BliZy3hCAjC0ZF0BgSttmBtpkxBDyxc+sI4qql3Alag
         1Kj+lS8wHqfXBNVQhTu5oj7MEyxVK4PrAetg5ZGaWZ+WgfLJEmcA4D+osAzWJCFZCVor
         yMbuvGINL7Muq7RhKKt/9I3prgsC1BOtaHMMhJp5J+/vw3qyP7hfTv6GbeZsc+582du7
         2SL7YVHCtcDR2jvhSVNPj2dOuS+N+Fak7BhZmzwLu9wJ+j+HgBilI776jvIFrDWEoR0j
         CbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EBqVvozobDiK8rTN862YjwPLK1Ridu5isMm/vw4kerU=;
        b=eTsusL/ql/AT8f2miNUuucmrNtu9h7HfmKJGd8dTGwZTVLtcR9ElvCOe1dVXgpJTvw
         e2K6CIHRTYxLUlx1f2Rxi145C4cX+Qgq9UlIWh0Wh1rjIxCP3TMqetjmYS8e6ufloKPU
         pIUhy6mqWKUFeRFcPDMcNKUFo3I8qpi2m4iOIYTBbRjuuUzCLA3gYgYh19P32uzhU8IQ
         PHXPl+yjzoVgJ229c+uJmHzzPxXORzcBJSaFu9PCREum5J9RemVTW4rv9MRXBAbTafWY
         CoC6DRnWmViGDsOtu3yPr6j23WQKjsGgQGZ/XALkYQXLjw4eBkKH6Jj+JwEuwyl2gspB
         8gaA==
X-Gm-Message-State: AA+aEWZtA4nADWc6JjbE1cW4Me55G6AbXO+7si9LjFfNk8oEFzQOOHpy
        xDnWUbfpqz78gHR0bOZL53Az2A==
X-Google-Smtp-Source: AFSGD/WdIECFKFO/HH8HqGKGc65LSQ2jFWzVZtMWlHsqhQzGcJxLkNlOEXFK62MgWiZP4a6gyA2wkA==
X-Received: by 2002:a63:1560:: with SMTP id 32mr19084145pgv.383.1543995801150;
        Tue, 04 Dec 2018 23:43:21 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id m76sm22473535pfi.102.2018.12.04.23.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 23:43:20 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN
Date:   Wed,  5 Dec 2018 15:42:10 +0800
Message-Id: <20181205074212.31104-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181205074212.31104-1-jian-hong@endlessm.com>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
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
 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb40624fb6d5..bbae06267054 100644
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
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
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

