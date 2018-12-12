Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F584C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8CC20672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM5r4FIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8CC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeLLXIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:08:17 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46055 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbeLLXIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:08:12 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so33949uam.12;
        Wed, 12 Dec 2018 15:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNCYqL/hoAR7H28Iw4fgzL1YPORaFMzZpsZOD9Bkcfg=;
        b=kM5r4FIkw6lK1WHkNrEBjzIgu79BwnVhyliEqrHrFmj53ftPy3z8/DZfzZIOji4V3L
         KBlziA4oeiXpalMSJD/Sp266uVdZ9AiztBbXuFaIucREmYdQ8tgpnHBh1ElrFwWLydQ0
         gMhOmeYmJn2FxIjstA1tqVyAmWjQCmyo5swMCwKygjnMBEUFotZNKENz+MWZ98xbvP1s
         wRNIWhu5np0bYEX8xbf7yePD5Tj+1vEdrIfdCCH/jPLb/uZTWGNiYwjtWsEIlOEPCGnB
         sK9xn3uCBAGXZQz9eWZKPI8xe+7CWg8FgQZSabz5pY3A2LQnIytwt7dRePnz6/VZfzXO
         6LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNCYqL/hoAR7H28Iw4fgzL1YPORaFMzZpsZOD9Bkcfg=;
        b=TQKbqUY2bX5rcxhCLGCcbUYXS9Y27ZAH6JI2QMn3LB4feXTFvUwPgjhiY+mFi1EkGj
         zuqpwD86ICeemNDdr6JIfT0zEVLnt1e+Y0idM9o/C6IxWZ+MlvKVYrVgzQa6p53aQKuS
         bK2M2k01/6RrZR+Ooq7JPVgVqifB8FCjCBRf4j02Jhm2iDzpc7Dvlxe4LLc4pJAkZEVB
         BFHX8kZkt9YsSwrjMDDNHz/FRwExjGLZQdychM36pNQ1ho3JTNdB1pxOoBeliOIqEvyz
         V+I+Z05OgjdKHaFEHkhNboYE6/VQiong+6htK6XJ4EpPdxoftBWL3QE27Dr7b7bLxEoD
         JQgg==
X-Gm-Message-State: AA+aEWY+h+TPrDPJFZcIQYrJkjVgE6tppiumOw9fKhwHHda/rJYYfTnn
        hoRCGqYvRyGR8dHyZBDWCg==
X-Google-Smtp-Source: AFSGD/VNeTwGBSF7v0msejtyDC54s7iykPkvRVXHlcrbZHtpWDXYpO5P3eCF6EIbH65nwxe5VfyvOA==
X-Received: by 2002:ab0:3259:: with SMTP id r25mr9928215uan.108.1544656090393;
        Wed, 12 Dec 2018 15:08:10 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id f68sm36630uaf.9.2018.12.12.15.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:08:09 -0800 (PST)
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
Subject: [PATCH v11 1/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Wed, 12 Dec 2018 18:07:57 -0500
Message-Id: <20181212230802.21140-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212230802.21140-1-ayman.bagabas@gmail.com>
References: <20181212230802.21140-1-ayman.bagabas@gmail.com>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 993d34c141c2..77ee471a67e5 100644
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
+		},
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

