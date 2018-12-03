Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BAFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B6F208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgWiIlyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B6F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLCSx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:53:56 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41544 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLCSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:53:56 -0500
Received: by mail-yw1-f67.google.com with SMTP id f65so5838393ywc.8;
        Mon, 03 Dec 2018 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTG+yUpS50wEf4PINJxF2Rp+/PS2UIUyXw6PMWpmEPE=;
        b=kgWiIlybU/HZ01INNApxv9wUgAYzgfexL4fXh5ZeA1Fr+uA/WK2lFo8ZI2Qsqb461U
         iChv7SrBM6QOBW1rQy1V5ibPLNjbXYmORrYgpK4ntOJRu7EEvM7l0gV9KE/VNbq7kNMT
         hBmm8FhDyk4bACjlN7GgFP5IaU0c8p6R8qUQUo/E0w6RUnNMhE3lZ/vmMwmhgxUI8RLa
         Oolz7z5tVpVqlPb+JMFsDVCCDj3D7x5IGbFj3rVogggB5VWMfXSM0zIZjRnTiVFOBJyZ
         GJoBevVVuTYqgO/21tP1chKJUBuM0/xu0NYvygd1E7sZ5RKR0cY0wsR4+zIm1/icrXNx
         PU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTG+yUpS50wEf4PINJxF2Rp+/PS2UIUyXw6PMWpmEPE=;
        b=FEgawWbhb24AXSRWAY9INEhJuYY7YRSMpivAYf1hXDkq0SkhE9JsED3/qo1K2uoI0G
         Gcb7/ENLRVhUN3X0Z8rrtSw4koITOQ5BXvUdl8lFCuw+QSCd5VhGdY5hURUYn2I29N2y
         VJm7JzFMHlH1nLE4/paq+sYs8o1mO12NPlTHbVG7Oi2YYbEV35ezZLwE+JRfFErY3dbJ
         HAZk1Ff4AojOGAfnkYCHrDZL8Ks8WECob2+bK5sYx+I7wHW7nVPCEI1KSDVTRP5t140l
         F3cT4ek/zy/uNUFkkJaXjVgfj62nqXKX6xSXhCRIVML5pSt3S8qSu82MMG193Hg658on
         LW5A==
X-Gm-Message-State: AA+aEWZuELJC7BevilvcB7PkzS7wINHWc14pqLoyjKmq1qMD89cfUqc2
        okuPitmdAHkG53saiZhvvQ==
X-Google-Smtp-Source: AFSGD/WlYR1WhyNsjl4DvoOP05VpS2eZY1L/Mzj7T1zjY59qCgPpgQ51Jq5ZvSS1PMbnLodJztS8wg==
X-Received: by 2002:a81:2548:: with SMTP id l69mr16980599ywl.397.1543863233425;
        Mon, 03 Dec 2018 10:53:53 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id u132sm4842769ywc.11.2018.12.03.10.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:53:52 -0800 (PST)
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
Subject: [PATCH v9 1/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Mon,  3 Dec 2018 13:53:38 -0500
Message-Id: <20181203185344.3521-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203185344.3521-1-ayman.bagabas@gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
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

