Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43D2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86BF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODqSkT5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86BF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeK0Km7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:42:59 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39310 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeK0Km6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:42:58 -0500
Received: by mail-yw1-f67.google.com with SMTP id j6so2092225ywj.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfqBTBoEAkmJTQ/OlmKq0JCyyuRpaP8tN2LFSpUqt6M=;
        b=ODqSkT5OybffUvFnCf1oxJqC1CWDdJrIKddJ8bjaa2HuIw3pN0D19U4E76//WmmwnZ
         mDRAn56EC9UsiYnpc1S4FossI/y/P2vxW/FXGoFJwPMcjhKdxoLbl7uwANZtNT88B9ar
         aCDZI7moAqnCkdlkB6Iu3FD1n5BMjTCtEGgmngmUvp2kk2TGhkHABwpw/A9y78U1fIEI
         bWAtOZyz2q0dpINGuIZnT3/54S8JFCTGI41fL/9PM4qJ7+6u9RbTf6d6afKgbqc9IZIL
         ILv4ij9L9KgD8y3dkh3gof3BmxIMzvmQOu5KwjxbOFl3Ru7vxCeB3o5QzJymoZzYk4B/
         hEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfqBTBoEAkmJTQ/OlmKq0JCyyuRpaP8tN2LFSpUqt6M=;
        b=amQF7uuDt21hKQJzUBOHCEWmTs0JYG3s64vCQ39CAE91Q0JSL7lv61r3edhzlQfMIM
         GedGmXrjrxMgwBWV6mkngMaiZKkHoaBwtX9rzuIgYO2e3+nnS6jP6bKkpnACnX+LA3OI
         ZDp0x+smczKBVe55z8YtklHUBd2v1IspD0STLS22sDAxNKYlzGk1asogyZPDjgAoGKC5
         LYYOX0I0AvFRDJxWUBcdA2ye9l3leTUm2289wfYF14gG4VU20j1lpvHT+iSMtY43voKL
         9xzKUkMq85q7ysBoRnVwbgpYwXdrCpaBzmsxKcsf27RQ7JSfAZEceW1HpIjrS+qPrmzx
         qa6Q==
X-Gm-Message-State: AA+aEWbD63uq0D5kCXt5MHoKnggx6c7VN2Xx/j6KEGtIe53sRWiPKLx7
        mmfiZt9NJROxfEPlt0nIVQ==
X-Google-Smtp-Source: AFSGD/VF6aaJtSKmo602k6YDMH0vPvcLhxojD0PoXqcFsZABgM05Zp37ZY+VtMqdJxQ0Xd30RiPoQw==
X-Received: by 2002:a81:5153:: with SMTP id f80mr26301814ywb.90.1543276027370;
        Mon, 26 Nov 2018 15:47:07 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.205.67])
        by smtp.gmail.com with ESMTPSA id n16sm1359390ywn.31.2018.11.26.15.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 15:47:07 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v7 1/3] ALSA: hda: fix front speakers on Huawei MBXP.
Date:   Mon, 26 Nov 2018 18:46:22 -0500
Message-Id: <20181126234624.31264-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126234624.31264-1-ayman.bagabas@gmail.com>
References: <20181126234624.31264-1-ayman.bagabas@gmail.com>
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

