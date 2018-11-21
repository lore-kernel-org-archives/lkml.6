Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8904F2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=neverware.com header.i=@neverware.com header.b="FBswLSFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8904F2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neverware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeKVAqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:46:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45984 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeKVAqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:46:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so3933066qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverware.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9OTy1FeoEUtT3/QfIgaCZpwOqhjk5V8Umqd0KxFijhQ=;
        b=FBswLSFiqXSjG144gvSf9VFOzTTwC+zyNjWSxc0zanxVrJL4ngvxTpakQnXjCfzS4w
         NZX9KtDmQWK9bE1Wy2Aahj6mfjMEvR2bYHaezvRHAWexC2eUHyrUfss7bqBpGgglf1d6
         RFTW3KnIxe7Ng6jW5lOraW1ZGvxRomTsGFzWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9OTy1FeoEUtT3/QfIgaCZpwOqhjk5V8Umqd0KxFijhQ=;
        b=RAMcdBmhWLkHBUwDZihBPjqjdsojXl6NwhGPyoC3/CzIfZxT6zpnHHtHDl1eo70A/x
         gte8HsD6kaX4p9bcKpGkS33vkYapXPJakSN9D7JiZrUHf0OA9CnVO2iX0OMFrNU3N9xB
         +VP91jTCcBw2jXGekZe4Zpg+oBgT0jcigPm9aNRQU180ErjU+tC3FeAa1HbF0eC7nP66
         Ndh1N5YZfYYDIaAsW5r0JCws2JiijgQXAGrOHWbTmt44Zi88WvfVdFfH+tTFuX/MgBLf
         FLmiFiqyIAla9f4CRfIk0QPJcpWqBVn9Ip+3eFOmMenGadh7MyzyZ2SNGRMUOtJRF68n
         E3iQ==
X-Gm-Message-State: AGRZ1gJHuutpNO1ykg2904RR46xnpPp4l/E5NC/C1gaaQnGfJ2sI2G9Z
        VIpKN2h2gOVd2xZuhT9QHsdNUw==
X-Google-Smtp-Source: AFSGD/U3lQHDwP/fsIsfOFu0G+ifEPrsYg4vjN09iFmLsxziViYv5AZl1AdxmmCW17LhQCd+XxCIRw==
X-Received: by 2002:aed:2fc4:: with SMTP id m62mr5776596qtd.8.1542809530725;
        Wed, 21 Nov 2018 06:12:10 -0800 (PST)
Received: from Puget-178128.seaworld.local (rrcs-208-105-51-90.nyc.biz.rr.com. [208.105.51.90])
        by smtp.googlemail.com with ESMTPSA id u18sm10269648qtj.84.2018.11.21.06.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 06:12:10 -0800 (PST)
From:   Girija Kumar Kasinadhuni <gkumar@neverware.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Girija Kumar Kasinadhuni <gkumar@neverware.com>
Subject: [PATCH] ALSA: hda/realtek - Add disable auto-mute quirk for HP Spectre x360 laptop
Date:   Wed, 21 Nov 2018 09:11:31 -0500
Message-Id: <1542809492-54931-1-git-send-email-gkumar@neverware.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device makes a loud buzzing sound when a headphone is inserted while
playing audio at full volume through the speaker.

Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fa61674..eeff2ff 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5495,6 +5495,7 @@ enum {
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
+	ALC295_FIXUP_HP_DISABLE_AUTOMUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6362,6 +6363,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC295_FIXUP_HP_DISABLE_AUTOMUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6486,6 +6491,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre X360 ", ALC295_FIXUP_HP_DISABLE_AUTOMUTE),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.7.4

