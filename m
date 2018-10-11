Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C5C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97250204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97250204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeJLDS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:18:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43852 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeJLDS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:18:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so4067464ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZsmufaOpmBPZOI7C/+BodD+XrTlE700Bvf4cZtv2sT0=;
        b=N8NId5xEiHMzJfmxxIhkAApnbE9ge/q8vHd6wNHkU33Agy/uPGiJuuWfszvJq15XXu
         nA74EBIjfT/+fSHJ1jPFH78r0O412T+KwN8R03wucjMoptbEVupNBFPYHP83ZSuQRU7s
         IZ889mYf7FsN/66HRpn7bJCC1/xDZrHOeHCcGNv83YeXFMpyJ39w0JPp3OMtmPuUQw1w
         AXtY++WFRpyMgtgv1AZhq5vinrGf6u47RD/EJp/SzQR7vobh0MrM2l/k/WeDPpCZX2Yl
         HMwKx2ry5Vb+slaUhKGZaz8u+FNl57lO7GHFXDuqTeECgeafs123jSKbMerxbh+zgIjN
         a0Qg==
X-Gm-Message-State: ABuFfog+AaBj+cNs6GHgC61weYhBBJQcBkGPSAarEKc/4PW283ISeZji
        M0iUp2t463T91zPaGle503MWDA==
X-Google-Smtp-Source: ACcGV63YqCImuQi+D6QCaHpR0ofEmOnhdzbY8DtGfl8Ctc2LveT8aFPktImGDlKUoTfvuJAd+bL1Kg==
X-Received: by 2002:a0d:cb4b:: with SMTP id n72-v6mr1762400ywd.487.1539287413766;
        Thu, 11 Oct 2018 12:50:13 -0700 (PDT)
Received: from laptop.jcline.org ([2605:a601:a204:3c01:fba2:e6bd:524b:e61c])
        by smtp.gmail.com with ESMTPSA id f63-v6sm11130081ywc.21.2018.10.11.12.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 12:50:12 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexander Ploumistos <alex.ploumistos@gmail.com>,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)
Date:   Thu, 11 Oct 2018 15:49:17 -0400
Message-Id: <20181011194917.17484-1-jcline@redhat.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo G50-30, like other G50 models, has a Conexant codec that
requires a quirk for its inverted stereo dmic.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1249364
Reported-by: Alexander Ploumistos <alex.ploumistos@gmail.com>
Tested-by: Alexander Ploumistos <alex.ploumistos@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5592557fe50e..950e02e71766 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -943,6 +943,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
+	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
-- 
2.19.1

