Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557252082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="L+NO0Pkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557252082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeLEGuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:50:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37332 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:50:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so9598633plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdH+jOIcQ0xKXOzS7KvcdEvbJ9UFF8FSN28qLURlLsM=;
        b=L+NO0PkquL+vwtW0Jyz+4aUXBM+++vpRbAW97LkGhSnOkMn3kGCerjtTFkfk1pCbRi
         afOi/8f0OC+fQtlFF5Xv1LSwXGxnRi/EVUd09/AewPPk3TsROaXs0inH7fgEt3xG/xwC
         /DdhEM45ed7juShGUCrnnjh6njQ/ZVBtv/U3nzBUp3Tq16EIp9qPdgKKKCimwrPQlu4b
         8apH4IIfCM5BzLi3FYUfXincaHVcd2vcK/b4aWkXPdzPV5/EIxHckZ1KYIoefMO8jd+Z
         zRHDufv5cVDf+k6uuLgBq35DiIy5tk1m0RKYoKDVv+0fs13i+AxH82zFOTqNqHptQvic
         kSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdH+jOIcQ0xKXOzS7KvcdEvbJ9UFF8FSN28qLURlLsM=;
        b=DOWXhr2tZ2sNxSIPIMxMmkryCg6melQ9iHB1/QTVo78z6zvQUiVM2eF+wDXham9Cs2
         919D6/PCjIOXV0fbKnwnXAkzbDCp40Q3SxRVkEhRzx9WSpPYCMbTYfLnnfCuPOr+6EAi
         E3WIecIynAMSmCtaYvcypUJ7ub7QzUbvy6rO0+Ji0GrZ5v3K02TwrWY8aAK08u944SYF
         0Ua+fBiaWhXnY9fq7DCyGWbH0rIFrK3Xp2a2brImDaWJpuH4rrOLseF00h8tmavL27EE
         StKhwkv0Cn170Ql6bDQ4XT2bzsMbkxu7oEH9izxfiiK5y4Es8jFiT+t4Kr1IMrlYZKYJ
         GZVg==
X-Gm-Message-State: AA+aEWZ074LH2JOnslTzY+eDWWl7H2NgrW5Q5HseWDdW1sokfDh39sNl
        h8zo1p/WH59VxCfvypILeY7igg==
X-Google-Smtp-Source: AFSGD/VmXEUlkl5Ae3VeShdnHinPteKJ13HTTRlnPIyZdTd6i7YKMAG5xcLi9XC7fxdmMRb4xks4gw==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13mr23842785plm.49.1543992603477;
        Tue, 04 Dec 2018 22:50:03 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id c13sm36995220pfe.93.2018.12.04.22.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:50:03 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 3/4] ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4660G
Date:   Wed,  5 Dec 2018 14:48:55 +0800
Message-Id: <20181205064856.19380-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181205064856.19380-1-jian-hong@endlessm.com>
References: <20181205064856.19380-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

Acer AIO Veriton Z4660G with ALC286 codec has issue with the input
from external microphones connecting via 'Front Mic' jack. The fixup
ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE enables the jack sensing of
the headset and fix the audio input issue of external microphone.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5a7a297546db..98f0abaa3540 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6419,6 +6419,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),
-- 
2.11.0

