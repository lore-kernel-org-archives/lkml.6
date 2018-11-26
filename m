Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B70C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A032082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9bB7pb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A032082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeK0KnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:43:11 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36988 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeK0KnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:43:10 -0500
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so8296692yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCEDsDAx5PMCLS87mnomliQo7+OlS9XDiZToeHzkvd8=;
        b=U9bB7pb9U2g7AZVlzhY/vLk3dAT1oPpm8Vji1JK0AmNuSkB8awWfd1vjLT90lWxh86
         d1vaP1tvnRSNSI62SY6b2YAtquS566tF8iGtq/uQrbR65/bNdmLYLfwKs0UYfvXwAy5l
         sB4XjKPTgOZ4e+ZGGblQw7PXnr/MbYKEyoWqw0IF9dy+lxcnh27IJztZI6aPCA7k2D5Z
         GOJXE0AZKGFB78uocls3ll6M+DdsS4wNZzejq0zBGx+AtJ7DSJ8lUFb5+/Lbyrjgj16z
         DDETwHswHFQCWY8yZ4aPIveZtKDaqPuMFnteax3vIJ/m3L15NpD6o25wjM75MKk+Fr66
         Tblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCEDsDAx5PMCLS87mnomliQo7+OlS9XDiZToeHzkvd8=;
        b=krJv4R4rlIw++xdGNvRQIHBo2vBEoQT2Xc3K1GsHa3BOTppXDVNmkSKhgbZoFI05p2
         HlkTgDod3YYs1eRMBHlihtWdmjDtOEq4Y/3Qf3JVcKMVDl+FR29d5T+aGvd5HCGBCyjk
         t5kV1eDe2VgiP5UpolJil1c/gnirdYmiSNDlUCvfRIxXOY01/EwsVQjbeHbAvok8HQht
         BsMLZozaGz6i+IKD0d+6so42XslTHUiqLkZk8xmbERi8p2Wi8RMoDJO6DbM8omlKC4s2
         2bHJ9a4EjARAXOiOL/h7Eg0KpinVdU1pbXLs17z0vKIZFdYnTWpgB0nWUD+pfga4q6ns
         Meqw==
X-Gm-Message-State: AA+aEWYtQwsndbXnXu50VheSThKQhAJ1UmHLrQB4wzkHCBNN9PCpIxc5
        DTuzxc6T0G9Sz8VzYrQ3/A==
X-Google-Smtp-Source: AFSGD/WdpQH1YQaE82OR5u246lVxilT+0GX+WUA1lrIX5TNmdxYLr6E8Yo810sSHreDkPofvp4WQqw==
X-Received: by 2002:a25:25cc:: with SMTP id l195-v6mr21512128ybl.73.1543276039169;
        Mon, 26 Nov 2018 15:47:19 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.205.67])
        by smtp.gmail.com with ESMTPSA id n16sm1359390ywn.31.2018.11.26.15.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 15:47:18 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v7 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Mon, 26 Nov 2018 18:46:24 -0500
Message-Id: <20181126234624.31264-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126234624.31264-1-ayman.bagabas@gmail.com>
References: <20181126234624.31264-1-ayman.bagabas@gmail.com>
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

