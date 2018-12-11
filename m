Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE59C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0357720672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFlQU+21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0357720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeLKGCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:02:23 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37701 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLKGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:02:20 -0500
Received: by mail-vs1-f66.google.com with SMTP id h18so8197950vsj.4;
        Mon, 10 Dec 2018 22:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTG+yUpS50wEf4PINJxF2Rp+/PS2UIUyXw6PMWpmEPE=;
        b=GFlQU+21+12U+hNFtBY0n7NtgsMFHrBazKIj0NWz50pzD1g7/hBaQw73pSTV+RJrHK
         BoeNq2GVcU52j/dLYQRtK/DkVD4KRX+4jKXlQiF++wc2psfRq2f6FwLeqZlUb/BLa2Ne
         7ZWY7P9OEqlDh2yg8ogT8jkhkv6sWwoAWoLAO74qHdbLNt6gvuLuNw2IiwmuD44CI892
         0iSN9xZs8G4DygP9HLpx0ZJcWkry9wChbT3OmAlVz5YFCWWHY0n26ODTmWHMq924Q6+r
         RyTdoU3sIC/s/mi7ouzahXrdKnxraeiZYsbdeTBJ1A+hukO0UayqCHKjGkQe7Nfjalu1
         KNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTG+yUpS50wEf4PINJxF2Rp+/PS2UIUyXw6PMWpmEPE=;
        b=ZDQmdAzLPXb+b4VDQPw5+FgILkUjaYgrWiSsUT81METBbVPAHRMZqEpCUTWIXeB+Cp
         cm1GMKyRkwVAntm/LQIwWNs74chpFXlPqCdZKsdjqz0FuDwVZAF6d8FlctxBMolkaN77
         LObEysq6LUgQFSivBmcqc1xX5BeUtZ/CwgBV22Sb49iBxeQjvnTY7s879yIVNDWypiDW
         ronHchiFz4g8vxEighZ20Ompg9ECyD7QRBgSundy7LCX9C0dHnLp7rkyXbfFkipFQAQG
         IMCzLbea6NQnV8GYm2072bhYbuEGNDwjGTDdZIpfXdd1WeDP/DEKYR/bXCuqpq40NZIE
         ep/Q==
X-Gm-Message-State: AA+aEWZRv5uuJyhYrv79U0mDkUUH1yr5HL/fu7z9GgZCjcvJ1iAWmYB3
        fDGG5Q05iea+RYgWLiUlpJa9D+Q9Ig==
X-Google-Smtp-Source: AFSGD/VEwgxfbM4IMTx6qFEWfDVciT57ZLh+TkN3gySZBQLvhuUyGz6vzJUZy70Q/XwTH29dIH2g4A==
X-Received: by 2002:a67:2388:: with SMTP id j8mr6824870vsj.126.1544508138649;
        Mon, 10 Dec 2018 22:02:18 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id a137sm5700765vsd.24.2018.12.10.22.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 22:02:18 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v10 1/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Tue, 11 Dec 2018 01:01:20 -0500
Message-Id: <20181211060125.28671-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211060125.28671-1-ayman.bagabas@gmail.com>
References: <20181211060125.28671-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves bug 200501 'Only 2 of 4 speakers playing sound.'
https://bugzilla.kernel.org/show_bug.cgi?id=200501
It enables the front speakers on Huawei Matebook X Pro laptops.
These laptops come with Dolby Atmos sound system and these pins
configuration enables the front speakers.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 993d34c141c2..1326f32f4574 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5490,6 +5490,7 @@ enum {
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
+	ALC256_FIXUP_HUAWEI_MBXP_PINS,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -5761,6 +5762,22 @@ static const struct hda_fixup alc269_fixups[] = {
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
+			{ }
+		}
+	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_x101_headset_mic,
@@ -6591,6 +6608,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
-- 
2.19.2

