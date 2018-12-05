Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BFF2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="XpbRT8Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BFF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeLEGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:50:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37337 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeLEGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:50:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so9598703plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NICxO42MTuk11nZouZy7EA5/58Wtx/LRj/N1ucvXv8M=;
        b=XpbRT8OgvxavPUz734vfsrZWQl4Njl029lCeaUUpdQPQMH+7/J2AvGTrl8l5Za/yZU
         V1lU4itFjcpJ/2X72WVH82IrZu3tJe9hv6DxfS49JdZ47/jwPcqkh15fsrfhFLMTD+d8
         MZ0yq4LPXRxc4vIypREBB2OPPT4a6xFhUOhT5W+cxLoPf6jcsEOvrtrc6nzYTHzh8/B3
         URav3+LT8zkSuDCFF6zF94vMRRwhFCw0L0ep9DebJMWyOh/9v+U0VffGDqOtJmu5G2qY
         j7ak99zPOKmaaD4nUZWUhuxpJzDL9gNf4EwrbCKfNZeAQtm4m7nIdUDzI8wdBm0SNoFS
         JMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NICxO42MTuk11nZouZy7EA5/58Wtx/LRj/N1ucvXv8M=;
        b=OdX8ExRMUnQuQiLLwusZV5UzuWP0iVT4pdfdn8RePIv8W2NXSFYSeigKbcRY2IV9KQ
         wTMupruET6hX3gCiF4QRYxhd30hgCm47opyG24jOh+4YK/WjLyRLBq1cqZHLrhycBfB+
         oIIIti9erwaT2MFN4WM1kwWFzKZUcv8wu8Kui4Ttt8MLtRQ1ZsTSXXoQZavB6rDN3T8o
         HQSpchY5hE4kkq+mpKcADdjxoi62HCfsFC1htP2b9daB/WDdyGoQnQj1zCxYzOXXjsQ5
         3PrL1B1k8V4cM8HxNeGqKDRx58Dhux011KtYnSCoxproFo3BFitQxs7drJ0uX74QRe3N
         l3NA==
X-Gm-Message-State: AA+aEWad9WS51UDAtLN59E0FbSWDumOSWQzxONvbvHeWTEW1ZpHcb3rb
        mPp2OH9MgF0J0f6lJwZheIb7+g==
X-Google-Smtp-Source: AFSGD/UCaK3Pv9WIHM1Vp2RKrfJKjJY823IifWd3CsP1Cx/RYoIu1Toj+J+MriVPhdmNyznt3AfjXA==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr23406737plb.158.1543992606608;
        Tue, 04 Dec 2018 22:50:06 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id c13sm36995220pfe.93.2018.12.04.22.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:50:06 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 4/4] ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G
Date:   Wed,  5 Dec 2018 14:48:56 +0800
Message-Id: <20181205064856.19380-4-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181205064856.19380-1-jian-hong@endlessm.com>
References: <20181205064856.19380-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

Acer AIO Veriton Z4860G/Z6860G with the same ALC286 codec has issues
with the input from external microphone. The issue can be fixed by
the fixup ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE for Veriton Z4660G.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 98f0abaa3540..bb40624fb6d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6419,6 +6419,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.11.0

