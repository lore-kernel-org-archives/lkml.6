Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415B8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E882E2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqeIL7OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E882E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeKQFir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:38:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56117 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeKQFir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:38:47 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so27251715itg.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cl+4hI8AT/4WzbNU4JdkprR2WMupktfIGm4x6sL9WIg=;
        b=VqeIL7OBiymwxlSnG5TFoTSLJd88Ud0R94F9SAP9H5C37vn6X5N6c78ohXHLzLU6TB
         f1mNMKWLGpFFOyV0F3GGqKX3P7BlFdfgolO2wukFkUqtrVpQCc4EKPuiJ0y87NDpeVBA
         Su8wKHJz5ORcyqiC07k262D1AgTspbLTXPFT5k5dXehLBVF4DMC5bRjpE+TK5TPmRjm6
         Z6kSRn+FjCk84l1jCH0iboqkK4LJtfLq1lAy8PDFMPfR3zwk+zhuBZnr5KrUstZWBouW
         YXX1FdcBGK0J7RWTZWUjIUfy7X0p2NLiYOulquHuX3ijSKudwiRkY3oF1697lbMQlh/D
         ZTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cl+4hI8AT/4WzbNU4JdkprR2WMupktfIGm4x6sL9WIg=;
        b=FqHj8GemxPmSICISzYStxVg2fGbTjO4PGobCQx1KR6f4RFRhHIMjMoqNtrpjuKhyJJ
         2m/sOrjyWRzvCAjopjXgUzqzPVxG1as7iZUiccsYEYzs40J5Meao4+DQg6S7LKMY5Jvr
         h9TInaqs5yY6NDrV4Z7hliABzu3cQXfCeU9MPiI1aErwS2WynP0i4KGtUVrcOr7ZSrUY
         zjIkx3tVHeJmldkZJSvMeM6pknPW/Qt4yLGUOqeI+PlVobdn7K+NLSy4EwJ19EJ7ZiEn
         0e7fs9cXhzTnFiysfLI8gZ/MMJaaGOKGhOH2ybRCgqz9I5BcX0KZMEmk73HovF0Wyv7H
         2N8g==
X-Gm-Message-State: AGRZ1gKnOfdjnVTMiPM85ZBTLMB57MBqKMLIy81iX+Tz5nDawozlGeZH
        UEWjcEp9jBsoj/GaDiolpgo=
X-Google-Smtp-Source: AJdET5eW0I5CLXTHMoiMKsMMo9WeZ9TGTjS8x6O2Ag8nLzUf708g+TkUYIMEcVQ4/UTOMtOVeyC1Nw==
X-Received: by 2002:a02:ba01:: with SMTP id z1mr11276190jan.100.1542396306961;
        Fri, 16 Nov 2018 11:25:06 -0800 (PST)
Received: from localhost.localdomain ([2605:a000:1316:611a:feaa:14ff:fe2b:c4fa])
        by smtp.gmail.com with ESMTPSA id b66-v6sm11047288itd.35.2018.11.16.11.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 11:25:06 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/ca0132 - Add new ZxR quirk
Date:   Fri, 16 Nov 2018 14:24:55 -0500
Message-Id: <20181116192517.5128-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.18.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new PCI subsys ID for the ZxR, as found and tested by
other users. Without a way to know if any Z's use it as well, it keeps
the quirk of QUIRK_SBZ and goes through the HDA subsys test function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9c0b94ba786e..4c21bd24bcbd 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1189,6 +1189,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1102, 0x0033, "Sound Blaster ZxR", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
-- 
2.18.1

