Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A97C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902022177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTSCU2xH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902022177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeHHTzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:55 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55933 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:54 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so4519429itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OxVgMN4bqRzcPwyZ+UiYhFD7JkverwVUhACnIzinPk=;
        b=WTSCU2xHdP7IqnQpzFTNZcGD3W4XSGQxFZadDXUjd/GUQKclJp6sCmOLF5J3PRIaYK
         s/Ckr6A3GjUjry66XarSyPSn+gADVq5z9asjXOv8I3R7dpFw1q87CQVVteuEXSLuaj4F
         uxJNlIUrqcAI6T1MFFx+xzZmzmpwFfOc7opftgfw6Wt76cG+g1rfcKrQ7tsuHVTdajdy
         erBBcDpFbxTgWO7DFeB9qYHwL2RT9HMLbjTy+Wivsx9owxXFj6EGPjNcaQx/eEdVniW+
         4y+II1atRpVFdWXHT5rY9hZ3NwUQG4Fzc5JMmPh+zOMm8+FtbewiVfVURvTJucTDwmBz
         jAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OxVgMN4bqRzcPwyZ+UiYhFD7JkverwVUhACnIzinPk=;
        b=K36MavvvjKuy3dE65oMQ2J50NAk8RaibEE88WryEbnPbHDk5tbBqUnzLTEtvcVLVxy
         o6EXFboJ+xXG6E5jc07ttP7eWgB1IJfSwJLkUorr526m9A8naxDEUMCs22Ixe0OCFb/i
         Y6jrHCRLZvtNXBjWqUwW6cYiY+Rhfcsxl0Wa4a4dFLoJSqWbuLaXAybrgSmLGNiqaHUz
         xOYKpbjxNF5dNei7QbEQGO+j/maxT07AV4O/Ea9VAfd4taps3aQQ3Tcg86mo0chjph8a
         VeM38B+q0ZQVJAH5GhhBUEP/lR1T9tl9TCgDSvUMuix36MHK3M+9L7IB4PWUyKgthFt8
         63DA==
X-Gm-Message-State: AOUpUlGxn9EA2z+aFWQLNha7qMHb1Fweypqb2Z5W5EVy1rNEia31UqRS
        XXQa6b9FoboC10+/g9jrI48=
X-Google-Smtp-Source: AA+uWPxAAPL0H9ERz7typv4sW6xgycu/E8G+juHMrQQHRazQknCqrznFMVsuwIoI0bpFL63zQH5/6w==
X-Received: by 2002:a24:7414:: with SMTP id o20-v6mr11596itc.116.1533749712898;
        Wed, 08 Aug 2018 10:35:12 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:12 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] ALSA: hda/ca0132 - Add quirk ID and enum for Recon3D
Date:   Wed,  8 Aug 2018 13:34:15 -0400
Message-Id: <1533749663-8200-5-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the PCI subsys ID for the Recon3D that has been tested,
and adds the QUIRK_R3D enumeration.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index e2e1d29..bec31b2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -994,6 +994,7 @@ enum {
 	QUIRK_ALIENWARE_M17XR4,
 	QUIRK_SBZ,
 	QUIRK_R3DI,
+	QUIRK_R3D,
 };
 
 static const struct hda_pintbl alienware_pincfgs[] = {
@@ -1050,6 +1051,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	{}
 };
 
-- 
2.7.4

