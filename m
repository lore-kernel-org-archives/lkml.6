Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE3C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019F92081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKnvLS6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019F92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeKBNRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 09:17:31 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34092 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeKBNRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 09:17:30 -0400
Received: by mail-vk1-f194.google.com with SMTP id y14so156400vkd.1;
        Thu, 01 Nov 2018 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Ziut4ebdY6pgpbsJWeBt1ROGCKxjpKn2B/jm2lTBiG0=;
        b=YKnvLS6XLxuNYfYzJH8i/eLzkYMHyrrmrwXdGwhxi2PjZdPQjiPuZA2VsK3GHf8zq2
         N8MaB4D4ImOSt6WuUejLwEIuNTsGq1tPOld8lAXYghC0Lfnz3PN6AYeFbCqMoPYq3E2X
         AFH4y1sGitf00LuSKc4OAwbr8+YrV8Ml9txXQTdp4MmAGGsVrDa3d2TLNixrWmmGpOB/
         MuRzlzCrT8ycFuK6VBrNAX90rlrDD5Te74sWh0s0InAjHZyI5ckgFEROAPD7cqvKe/6D
         GwISC4N47NBqa4S1ZZn5tYRAmh8tbDhXf5OQNUbEMGqLZlzXd3EveCBUh6TY6xKpH6lQ
         QMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Ziut4ebdY6pgpbsJWeBt1ROGCKxjpKn2B/jm2lTBiG0=;
        b=K2pz91Y57CIn/Hww80fe7u9B3UZU/WogWUadvVzo4Dt3ZNeflVrs3AGeXhjvEiT4zs
         TeM49OJQQb2T30i9qfnuqD3sP068JdwLDCceBi0gUKffsPrVKdJbeyv9UlMGufEDOtUe
         NDXelz/hHf7iodervIqgXSlWNf2y8m2+xf2z9wcxCokh1Z9rgCgHrNXSi+P1yPElBmMZ
         irQngJlp4GzCd/MJX6fjxyS1E94JwYibdPFJ6MTu/D+2iUgEPccXnvp1q2nTV06tZGrk
         HOblwRBlqA9UgyWYhixGuxclAzCfjFsc4yCItmyMPd+sibSZreAjENtJP9ZrD9Bk1G0+
         tZDA==
X-Gm-Message-State: AGRZ1gLAYq4xfxvdyQaUzKY5V4Z9ZdDTQJJtanHOakJ1c214WeMDpEsv
        xVGuwuV5Bu6hL6EeC7ZbXw==
X-Google-Smtp-Source: AJdET5etaneLpnF9O4pYTO5fiKNvubzdlFvF0r71/GXEzcpvywKo0E1Vftgdjl6RwS+0llJTO1LYlw==
X-Received: by 2002:a1f:ae88:: with SMTP id x130-v6mr4353901vke.91.1541131906077;
        Thu, 01 Nov 2018 21:11:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id a2sm1661150uaa.15.2018.11.01.21.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 21:11:45 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Fri,  2 Nov 2018 00:11:14 -0400
Message-Id: <20181102041120.7603-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181102041120.7603-1-ayman.bagabas@gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves bug 200501 'Only 2 of 4 speakers playing sound.'
https://bugzilla.kernel.org/show_bug.cgi?id=200501
It enables the front speakers on Huawei Matebook X Pro laptops.
These laptops come with Dolby Atmos sound system and these pins
configuration enables the front speakers.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3ac7ba9b342d..4f7a39c7883c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5493,6 +5493,7 @@ enum {
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
+	ALC256_FIXUP_HUAWEI_MBXP_PINS,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -6347,6 +6348,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x12, 0x90a60130},
+			{0x13, 0x40000000},
+			{0x14, 0x90170110},
+			{0x18, 0x411111f0},
+			{0x19, 0x04a11040},
+			{0x1a, 0x411111f0},
+			{0x1b, 0x90170112},
+			{0x1d, 0x40759a05},
+			{0x1e, 0x411111f0},
+			{0x21, 0x04211020},
+			{ },
+		},
+	},
 	[ALC295_FIXUP_HP_X360] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_hp_top_speakers,
@@ -6592,6 +6609,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
-- 
2.17.2

