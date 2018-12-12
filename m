Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D88C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5699C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucUTrpuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5699C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeLLXIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:08:23 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43130 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeLLXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:08:19 -0500
Received: by mail-vk1-f193.google.com with SMTP id o130so23297vke.10;
        Wed, 12 Dec 2018 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Zw3kOFemWDxC/7BV+srvfphJjFAaQEfzpMblzx5la8=;
        b=ucUTrpuTVHAcuUcuuXOp2fr1tAGL0DO6wBKH6tk4xo9Pn6AMPA0I/vIejnUexHWzBQ
         UaDWwVCyfFmCNaTTonrUQ3aOYeUCSKClZaneRVGdO9R4Ss1Le2Y2D6dHtXDD/io0+6rG
         2LSlfPtNQxhKXZiSMzOE057d85Vj4Z4bfpCA+Zr3FZGidykvuRfZWqNWmVfl3WvXi/DH
         rW9c15PGVCN3a87mY9dOzeAuomsqU4CxHtbmWCTDc9HJQ9G3Qd8ktMbF+H/BlTDLZs/8
         R9EWSOPq/nbyG7P4hMWX+m6NpvAyYQN2OCRKbIj3jYL9TX1/PzvwxgmGKm6Rc9kpx87Z
         BC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Zw3kOFemWDxC/7BV+srvfphJjFAaQEfzpMblzx5la8=;
        b=ixULEsjOVtpO6NgBYEHyquD8Vq5tprAKvj7aE5yY8vV3wuZVNFA96pyubKZha9zHYi
         010aIgiNBf6JuTRG8gKvbuR1mTWq0Bc4/vFDqcPcxrLZDsF2TJQf/2pOTCUnifP77mtJ
         rHHxC3W85rvkyFMBXuGEH+dgryeoq3dRlmh58flYiEU1oxa8qqOw7CHpquxN4gmhqnT8
         4ZifQtIMP1SGhqpfVZz9tK5svPGydbBizvHv8JLFBwWA4QiN92wIbb12G9RMSpfQUdur
         ODgREpBi04OtcjDtoH+BLrZk6Ba2oHX5LmlSD72Be13UthDNcESzzBaP26NlcEs9S9xM
         cF8g==
X-Gm-Message-State: AA+aEWaX2euFGCRPdTwD6QwhupP9DgObKp+ku9kySV8B6FPvRShJZ9Yw
        PKgmHyVsRnCRfKq3/sQCHA==
X-Google-Smtp-Source: AFSGD/VldJ8jbZDIzX2/L4EIcunpw+HldriwirXDsQAVBEaONPbtFfo7+HGlrzIiubMSIL6pY/eUJQ==
X-Received: by 2002:a1f:5e47:: with SMTP id s68mr9520812vkb.64.1544656097491;
        Wed, 12 Dec 2018 15:08:17 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id f68sm36630uaf.9.2018.12.12.15.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:08:17 -0800 (PST)
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
Subject: [PATCH v11 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Wed, 12 Dec 2018 18:07:59 -0500
Message-Id: <20181212230802.21140-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212230802.21140-1-ayman.bagabas@gmail.com>
References: <20181212230802.21140-1-ayman.bagabas@gmail.com>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 77ee471a67e5..9766fd249bdf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5777,6 +5777,8 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x21, 0x04211020},
 			{ }
 		},
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

