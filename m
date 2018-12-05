Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F22C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9252082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="gJAmelD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9252082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeLEGtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:49:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41673 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:49:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so8559389pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6BJcg3ek3gGRvR369ztMOJW5erTNjFk86k2+aWsWv+I=;
        b=gJAmelD3t96UETw2TBTkwlPLhNp0YBancKlyMxhHEIWP9OurDmSebjyPlnRtzZvZvu
         GqZ8Q44GOhtA7iEegn5Ng0KFkw08v6AIneF90wq6/7cjZ5K8sq4wXZQikSwUfzrJc6hV
         vZRb1ppD393yeAPbSy6XkVyP98jxVDQE4LgUzVsJojR23/zkDMENU//5sRHcKC3i+cCj
         agLv0dRhMFU9Q923bQUQZLb0oP8u0ZLVLOzTtqRBbEkOlaxpHX+uTQB5i4gJ19F3zG/0
         6aGliTFfD44BvgLXhJ+JkSKJ5CQdRd37ei9P7S5mzmBr92icd3XhcmnMe7vxWJBqDtr9
         yqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6BJcg3ek3gGRvR369ztMOJW5erTNjFk86k2+aWsWv+I=;
        b=W4M2E6x24W86dEGITmjm7pXHyvU0h1Xk4/ZvPDJ+ScpZoXDimaHFp5PeNfpLZW66Ee
         AVJZhpJi0O83JlgmbmBq/0AFVsYipIFFjwHlkZ1IvGhEXF4Ku371gFMhpbAR0P9HEGj7
         M6KoELHnF0V3Sir2Liq/ndyqlBlGeUflMOxQL+f5+TtVA0bNLFw+FvduAXYv5BCx6M90
         kucZpDqZBcCymFE8JYcKu09g3wCiYH6420zESK35gHtXOhiIwU5aO8zPZkLBjDqPwY1d
         u5nuMOYTCFZGZHzAgmuUqwcrkgUBHJd1WNlrjJVTHP/CaD/2OvK2EbE39JTtI+H7XHaf
         KTmA==
X-Gm-Message-State: AA+aEWZNJdh7GTsMD2YLcl33VqqSSyxoZ54uQFt0igAzno6rhIXXYfU8
        UBoX7FLlYVU9i5k4FLgszXrtjg==
X-Google-Smtp-Source: AFSGD/XPKyYI2g4pUx5FsRoLAXC9H3gzeQpLC67H68QQ10M28HEjyGpNenXJnw7nYVkswt/57FCgsw==
X-Received: by 2002:a63:7154:: with SMTP id b20mr19411854pgn.342.1543992588731;
        Tue, 04 Dec 2018 22:49:48 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id c13sm36995220pfe.93.2018.12.04.22.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:49:48 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880
Date:   Wed,  5 Dec 2018 14:48:53 +0800
Message-Id: <20181205064856.19380-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

Acer Aspire U27-880(AIO) with ALC286 codec can not detect headset mic
and internal mic not working either. It needs the similar quirk like
Sony laptops to fix headphone jack sensing and enables use of the
internal microphone.

Unfortunately jack sensing for the headset mic is still not working.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c0b289ba397f..f21d52eb2ed3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5516,6 +5516,7 @@ enum {
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
+	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6393,6 +6394,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_auto_mute_via_amp,
 	},
+	[ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7071,6 +7081,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x19, 0x04a11040},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0286, 0x1025, "Acer", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0288, 0x1028, "Dell", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
-- 
2.11.0

