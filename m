Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9723CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8C32086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvlcDETU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8C32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeK0NzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:55:04 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45017 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0NzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:55:03 -0500
Received: by mail-vk1-f194.google.com with SMTP id h128so4706754vkg.11;
        Mon, 26 Nov 2018 18:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCEDsDAx5PMCLS87mnomliQo7+OlS9XDiZToeHzkvd8=;
        b=NvlcDETU+DWyHXNwBiLHi3OHhcsXabUgFEbnVGVUdeu9F4l/y5KKXbluiz78ycq2Nk
         gA5NklpaCC7QTzNgPA82r1UkEg4VFEDF1JIMKfMP+IBjFfmIg5ex/6NvY0S0H7Dddszr
         Gkx6e0zxbgcWnVDV42PhEApBpT0XXK/p71SSkSRf8kP6ud0UmD+a71S0+xEoeIdLoolC
         L6/XUntY9CRr2phmWQsXlWfaPz3f1OXB34cPPmoroBIQ1CHxXZyFojpPSFaQ+QRP5+Rz
         dE2pMBzW+rLNTycc3Aa6FCxo3XarEFgb51SxbyciYcqYTIqgKKDd6PklHs/+7/33Pofi
         Z2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCEDsDAx5PMCLS87mnomliQo7+OlS9XDiZToeHzkvd8=;
        b=PZBQaiT0nC7tsfm9sYctC8mxeM+hg3vVPLWkisFMfxpC1Ki5ZFAedmhcezIiilXqtq
         BB6pTJHd/W8cyJwRq1xpPYbQK/IKQOFUNwA1lxoI9szh5li2sL4TbwKrI1YuAa8o5gDQ
         Xant3A/jFpDAkOqWVKV6uXDKirEvHxaIA/PyWzguEGqaaTXI0JcvBX2WVgNXdTJiCFxu
         JGlE+i8wdPJN1vvqi171IqIEzpHJM/3yWSVCAu6VvZek66pPAKn36XN0SzHa+pa+OG7o
         U8l3Mjc7bDKincZvOKDJrD8UAX/rUr75tD3hNbSYNywZ4e1FzUettHMSn3CX2WvWl1Wn
         3l8A==
X-Gm-Message-State: AA+aEWYSdFjvqDXHU6NjxjuMq9met3LWapw0n/BGasmC9T/2491j+ceO
        kZpcVE4lwjgbTbNEellTgg==
X-Google-Smtp-Source: AFSGD/VdBLBPuLViUa96UjMCBUQVzuOBhgi91MUNiQWKVY2T53oUgUzPtotLpWAQQe/n6N9NDk8YoQ==
X-Received: by 2002:a1f:6184:: with SMTP id v126mr12308012vkb.69.1543287521706;
        Mon, 26 Nov 2018 18:58:41 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id j82sm1006934vsd.23.2018.11.26.18.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:58:41 -0800 (PST)
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
Subject: [PATCH v7 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Mon, 26 Nov 2018 21:57:49 -0500
Message-Id: <20181127025752.6459-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127025752.6459-1-ayman.bagabas@gmail.com>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
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
2.19.1

