Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D0E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkSSTWqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D0E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeK0Ny4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:54:56 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37117 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0Ny4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:54:56 -0500
Received: by mail-ua1-f65.google.com with SMTP id u19so7099940uae.4;
        Mon, 26 Nov 2018 18:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfqBTBoEAkmJTQ/OlmKq0JCyyuRpaP8tN2LFSpUqt6M=;
        b=qkSSTWqVjfFCENPjuepGa/tCL2UHu4PLc1vqlaY3Gc+Bj9yckOUSp8ERmiDTY5tys4
         xT0x2FgxwuZiuj4CwQ/1r66GBDLnkawWaHTZjOZibDBfXxLSuR0pGh8El5fyW678jURc
         MTOenOyPQgTFhWrsc93cyCOrIqMVINqX+xXM3bOQAKZf6kMhC8FKyKc/HKuXqTyGMSgb
         i8ZS4G0tge9lOo57hKmLR6ii4jJSt4EboBelhXCLK5N4/4HrEnCs7ngsr4qxb7HCqCIW
         TQQnLOEO1LQUvpAwXIwE9Ncb2G7ko4zMYaEW23CZ5NYQPkAFz3V6TIB2TdPI5jKE67Zl
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfqBTBoEAkmJTQ/OlmKq0JCyyuRpaP8tN2LFSpUqt6M=;
        b=O0RwMd55+m03AHRu34OcH+j7c/uTHQTIqvUJLcV8NEOSk0X8jXHya00zaq3E5g/CPw
         B3xrmZJ5Uhaecc3e5BEJA90hcBYJ9B6woEi8jsl6R1ZIx7RayDC0NTKVZDVj9sRK0NSn
         8Yfuh7JgIxWO8lDY7im9aMaOGfQAOOszBFWKzQ5kK/itO3SUNCW+8recgbkz1eihoBi1
         sd/0xT2TWZEiMr4tVg/X/FkDFAvLznwBW/tsHTawp1UtrajqLUM4V4VVDqdaOa6ED4xT
         61NVeHVBGORVK9zOtkLj/sgPZQuugFDVCFl9JJeYVL7oxwW+M+iKxOVe/vEn86MwddUC
         xAdw==
X-Gm-Message-State: AA+aEWZEGhn1BarWCI+KoZ1uFmZZ4bW2KzKeZGjTSnaNljATM5f9nxBZ
        UBato/lcvoUHtObX4FM1ZcIaxw4qFw==
X-Google-Smtp-Source: AFSGD/U2UvUCoaFR5kYEf3UyRF/M/sl3BVgC9K/nYK1GgAA7ztMXLg+HEHZ3dCcuD2l8ieSUUSxfpw==
X-Received: by 2002:a9f:30cb:: with SMTP id k11mr11808641uab.105.1543287513888;
        Mon, 26 Nov 2018 18:58:33 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id j82sm1006934vsd.23.2018.11.26.18.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:58:33 -0800 (PST)
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
Subject: [PATCH v7 1/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Mon, 26 Nov 2018 21:57:47 -0500
Message-Id: <20181127025752.6459-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127025752.6459-1-ayman.bagabas@gmail.com>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
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

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
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
2.19.1

