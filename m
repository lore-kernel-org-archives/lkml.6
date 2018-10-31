Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F7FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258FF2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t168Unfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258FF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeKAETw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:19:52 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35326 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAETv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:19:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id w135-v6so4730867ywd.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OEigaJ1V34vm8vKs8+NtLV2yPLQb0ZC9a/U8CiPe97M=;
        b=t168UnfcL9KgAjXhQQh90eKjjHCt8CnDVhgrDPP9phsolBAnHoCyz8iDOzloitAx5P
         epM13ov7i0EMmbCCBtemdwtd25tSDK6irMZetrrvan6aJAteN0lE00UENu5DeoTEeBxn
         Fj1prcTKoYCEI3qNKsKZT5y5YRxcnVB6haSO6eStkut4i2mRzhIVdstWfKflISlLR2+S
         gEuMGXyz9bAeQh8nKwR1Iquo+WHo9+J8v3RMgA70UWV//IiG8yimUeT7WL6CsJAyteFG
         665weGjtOJuxopm4AuNuIxftu2yhijg7Q+DLf6H70jmPNnc73KwRmKvHK84q41iv3ZMB
         JUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OEigaJ1V34vm8vKs8+NtLV2yPLQb0ZC9a/U8CiPe97M=;
        b=kBny0Wh4ueAL8RQB4fXFMySSUvj8Ae+fZHCzWZwQf1bln7bfLam8Zj+vw2aUzCW3w5
         Ji4XSosFbCqVYqUw/+kdLoXKPZ9PukO3eRT4LEpY7dTvv0aPFFrPL6djwKWVd3KKYQC4
         WlteBzBgjVEl5uv2T8icG83U7ozHbHAPwJcVpLJGeoGmuFPB764lkaYhwxb0/gbeo7ys
         rVjScfxml3R424PD0Mzk9P3ra9ELST1IeEi+4WutABM+CtaXxWF0RRlCbF/GMw1LIv1g
         umzzOEMyy3Ik/4NQ9h5WSsrTiiTAm4rDGWyw/Yhhj5/TG5hgCs7d10Q3g230vhVBTWQ5
         Y3JQ==
X-Gm-Message-State: AGRZ1gKgI0Jd+orvzPTdzJ1qgO+n3I/f3t3+5DoZSdJxaC/cBHD2MWMV
        ajKxcy57pYzc1cB3GSOr/Q==
X-Google-Smtp-Source: AJdET5dOeu7yuc284Wk4I+NPodyVktLnLBkp0VfXPnXwm7uv+PaNAR/FYIWlwB9q7j+1vSx9ITYdvA==
X-Received: by 2002:a0d:f585:: with SMTP id e127-v6mr4398869ywf.170.1541013626837;
        Wed, 31 Oct 2018 12:20:26 -0700 (PDT)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id x10-v6sm7705640ywi.70.2018.10.31.12.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 12:20:26 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH 2/3] ALSA:hda: fix front speakers on Huawei MBXP.
Date:   Wed, 31 Oct 2018 15:20:12 -0400
Message-Id: <20181031192013.7701-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the front speakers on Huawei Matebook X Pro laptops.
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

