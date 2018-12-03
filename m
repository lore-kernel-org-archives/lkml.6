Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589E9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DD0214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXsAypMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DD0214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeLCSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:54:06 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37783 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeLCSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:54:03 -0500
Received: by mail-yb1-f194.google.com with SMTP id w129-v6so4162913ybe.4;
        Mon, 03 Dec 2018 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGPxibAY8ZyyYRmZa+UWB/0XnyEXDhHmRXiLVIHOJb4=;
        b=aXsAypMTrfRfIPjvz5IwAzeNhaJcGmod2SyKelpq/KwuLKSJX6f9JyY2LqjhYhfDtg
         psTEHFXh0ZklSZBX3MMQBWUdASShFuklUo2jjPPi61AM9IJhr0262Nsrs7c92nqpqwCJ
         5O7jVj7y9M4lbu7bkZfAZYP40Z3U4aeDTY/wW13PQIcirhmGVLHAASu1EAGPhRwThUoo
         Hxs6CzQ1CGOC88FxC3dU08CE2qtmMGOfZiqRoBw3VJDLYOrfZnJYx8iuRiFslz9aEMXr
         wi3ryodXtwL313uOSOycJi4JnekuE2ZPLDuRlnKUgLdNLRGv6acC7dTPFWpeBJKMa/I4
         oADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGPxibAY8ZyyYRmZa+UWB/0XnyEXDhHmRXiLVIHOJb4=;
        b=kVPFpD8fya/ith92FcPlQDVG/B/htWCqKlUTVyUZQmdlWrHbJ2mfEFBP+h8d98SUgA
         Apq9dDgG8gqlkPZs2NP3Di0QcCvkTYrqM62Fr7RMjmH3Nuvh1G2uCHqCB2N3XqPElUwr
         snmieIbl2/GOf2wEGRgMEwbtbrNks3tbzBx/WO/tz6JlN+beSUC/KH4d4OmZq6goRgP7
         f5sf9DsW0EN7P/Uj5LYidUOge+mvqhXbXZ0saUzLVo8fCij7R5k/7v+BwuI9nh6UPumB
         pd38uMx6KDFXwtyDjqGkkY4OTcDXo7JvFScZadM/yutjSzECVCtyrfRl/SQ7G4QqUld6
         NnZA==
X-Gm-Message-State: AA+aEWavR1geHktdiWExm+toq2RSo/v2WtPFDJimQ7//ra1WMy1w6qHk
        /1LFlloL3GEd3+z+5foHtA==
X-Google-Smtp-Source: AFSGD/UFhf5h+2WMSg80WKrmrTIjtbpxqWN2IjXfANBrewHBoSu4VDD9hyx62q4baS+mUhTTXIGxpg==
X-Received: by 2002:a25:a309:: with SMTP id d9-v6mr16384226ybi.27.1543863240472;
        Mon, 03 Dec 2018 10:54:00 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id u132sm4842769ywc.11.2018.12.03.10.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:54:00 -0800 (PST)
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
Subject: [PATCH v9 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Mon,  3 Dec 2018 13:53:40 -0500
Message-Id: <20181203185344.3521-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203185344.3521-1-ayman.bagabas@gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the micmute key. This patch
enables the use of micmute LED for these devices:
1. Matebook X (19e5:3200), (19e5:3201)
2. Matebook X Pro (19e5:3204)

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1326f32f4574..9766fd249bdf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5776,7 +5776,9 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x1e, 0x411111f0},
 			{0x21, 0x04211020},
 			{ }
-		}
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_MIC_MUTE_LED
 	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6608,6 +6610,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
+	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
-- 
2.19.2

