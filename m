Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F07C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5575C2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="1nAvj1ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5575C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeLEGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:50:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34157 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:50:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so9598995plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h36DWbVr+KbedTyBVMCzYV3kIRaBGWxCfvgWMbeB+3Y=;
        b=1nAvj1eeCborZOa8NqUigBRobvld7J2+IiYOWxoJ/8i5EyjQc5sK2OMY4mb0AF4k4E
         HrjRcgVIZA56UMZt2zpOzoob1gy9EHF8pwPxQFu1aMvjcMvT2gj8/WwyyERYOSipZ9eX
         grcUgR0oN12vUzgdDqblRQ7dDf3pyYctdDfLNcw22ApV6QPOlc9Vz1mbFmqIv34CMNKe
         77Y+td95ky4Aid+VV+jTWwPKTvOLDw1P2jORZS5xan64nIZidFNeIxGO5my2Ocr6k0mJ
         h7cTYhTcbB0zJVtzfMcUI7LEt0CVcuFbryj3pfTK7ILBDudbmnXA0RbTe3T7qmsmvsBq
         sOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h36DWbVr+KbedTyBVMCzYV3kIRaBGWxCfvgWMbeB+3Y=;
        b=sv1efArGm/TTHBK8qFYg6r5T3PcUyQZfx1itZnO0XoZm474Aje5WMG7jwkjQtqnUbO
         8Roxy3hG0kLfePokou1nLDBtcq+15RCz3ksFOVhLkM+IVz76KbeusU7507uN4nYhMfuX
         E6lOX2SH3GkL/L8836H9E+cFJ485JBWvy8Yc/vsjDpgpcOxUSv5zM3UBhR6lup7zCyiI
         Fv8MuQFxpmxFnEEpSbasbKjF0+B0+LrZKcLOv3Ancd5rjOB5Zg4++s1xTsQ49nctnOAU
         2om62pvl0cdTeKj5amzsaFWq0jhcLLkTB8YJDAXCHyJVr6aRIad32lKe0fIbOKL/H/yd
         qPEA==
X-Gm-Message-State: AA+aEWY6Hq6SrNTnAMhPgjJ8ZawEZtxc8gS5gLQr/SOJYz6aMQyfQeAB
        G1Kf90l0ELpGRO03Z1EJ4UMI/g==
X-Google-Smtp-Source: AFSGD/UEW97V9xoItSxkXHwnPZj5FHlToMOu3HQKTr4myl4cEThXgcdAs+F5M1/Mb+pbn+DfdG7xvw==
X-Received: by 2002:a17:902:bc43:: with SMTP id t3mr21529197plz.124.1543992600377;
        Tue, 04 Dec 2018 22:50:00 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id c13sm36995220pfe.93.2018.12.04.22.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:50:00 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/4] ALSA: hda/realtek - Add support for Acer Aspire C24-860 headset mic
Date:   Wed,  5 Dec 2018 14:48:54 +0800
Message-Id: <20181205064856.19380-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181205064856.19380-1-jian-hong@endlessm.com>
References: <20181205064856.19380-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

The Acer AIO Aspire C24-860 with ALC286 can't detect the headset
microphone. Just like another Acer AIO U27-880, it needs a different
pin value for 0x18 and the headset fixup to make headset mic work.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f21d52eb2ed3..5a7a297546db 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6417,6 +6417,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0762, "Acer Aspire E1-472", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
+	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.11.0

