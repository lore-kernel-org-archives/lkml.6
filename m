Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E91C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3804B22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG0wxIJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3804B22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbeKOB34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:29:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40253 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbeKOB3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:29:55 -0500
Received: by mail-yw1-f65.google.com with SMTP id l66-v6so7397372ywl.7;
        Wed, 14 Nov 2018 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bcr7lyndkj+LTlWwjyiGVd6urWg2+++qn3+nHR4jm/o=;
        b=tG0wxIJMvPEo2bvS16K9zvKL8HOr6pT+8TU7g/AqnLRYuXkygHqwAJQiiCgHzHkMkh
         67xodh4NRpov8zl4NDuR8UOCvd2SYXAATP29MMaR6ZNVoKkbm8TtrmuVl78TqPzgKTFa
         Yb5DUk7GGUzPZWRsn/9V6Vmx99fyoCXNw2Q8jFIpxwPkNNwYqelkVkzTGsqIaUVRcVXE
         r4olVRWvILkBeWpJkK/QhxrJAYJRdrd2/Bhwo5727tIpem/6KFrvrQG6TnVCYw+up/Db
         TqrJYkG0t/unKHpDHWbUwaKorGWT7ZjGI+RooDFzXJ06vTV6UiWq7oIsU8XbmG1fxJ2+
         skuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bcr7lyndkj+LTlWwjyiGVd6urWg2+++qn3+nHR4jm/o=;
        b=nGIi6EI1SlOXE1ZyLxmHAvVOA8MJ/63w2Da16qR29n1w+2Om+5kuoQoL+vCWSwMMJB
         kOqpUbRgOAJ46U5Sxwn3LkKbaGSLuCx5jtuZiJ/b0mFEZF2GzmQ2WDtThjhZxdzAokV3
         ZHXjZbIGWBr6UDRAhrDC7mGNIwDSj8leTjYeImzAV+h2ZahyJV68lXJc04I0rjNIsAPY
         FB0S94zoVVkxc3Wa4eqUIiQ5InJrHs69isiOJdUCfl7id0SjOrHiJVXSzluAiKQ0Mf5l
         dgew1pOrfSymQuXhjjTpgKia/yMkg82nuNpofCbOlBKy0nibhRU4oXVQauQoTxIm1EKz
         +nTA==
X-Gm-Message-State: AGRZ1gLE+1xThLMYtx2adA4NW1hH23UkC63IfrKWYMMHox6gaKG7uJUK
        bZSkR1oUMjH8KIJDk+EoKQ==
X-Google-Smtp-Source: AJdET5csFpBdSjGiiC+Mod4QaakCFQ+hD+rTDNJnPgVHfKpqnpvINwQyGFT8/YLBU1BNZvc2G+2Qug==
X-Received: by 2002:a81:7bc1:: with SMTP id w184-v6mr1950574ywc.345.1542209174079;
        Wed, 14 Nov 2018 07:26:14 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id b196-v6sm11573815ywh.108.2018.11.14.07.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 07:26:13 -0800 (PST)
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
Subject: [PATCH v6 2/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Wed, 14 Nov 2018 10:25:57 -0500
Message-Id: <20181114152602.7842-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114152602.7842-1-ayman.bagabas@gmail.com>
References: <20181114152602.7842-1-ayman.bagabas@gmail.com>
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
index fa61674a5605..135c0826859b 100644
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
@@ -5764,6 +5765,22 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -6594,6 +6611,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
-- 
2.17.2

