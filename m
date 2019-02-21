Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C68C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B4214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="eoUiJ14j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfBUJAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:00:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfBUJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:00:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so7730758pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1m01mRNpO95l9CHGYZfqQXTdSHNR3Ewk9hyllOx6q8=;
        b=eoUiJ14jQe0ndg2YV/q7b0Fn5SXGxzALfyI0fqsn+XgTFgAcQRCBJMSQhcJrt0C+mQ
         n2qE48bfJqEWRSqe52Mv+Va1DqB5GmWyWHak08hmmRzPy5JqEyQOFiT2oGDESeqLxm3+
         SeABWzk11/AGN1JSTPmWhporgd9IHxXSg6lEm21kfbx64bARTdlhyOLROl5/C5d/PDao
         UIhX/PHR4ZLu1Fz58ts75n3wT5orvY1s48eA4pfoBo2hP1u5/z0cIFDECXmgE0+yM9jF
         +de9KBvJzYmWBC9DfpOkAOU6V6FLQ5cBu7dNH1/FNlxH2S80yJq2j8t24RcBZzWrzwSO
         xAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1m01mRNpO95l9CHGYZfqQXTdSHNR3Ewk9hyllOx6q8=;
        b=L4kQBzVSAzr4YPvgjVM3xtkCKLfYqdWp1Omx/sRYHnayGtkoCmNvCcs7FfOLbREQ+h
         0sqMM0A0lQ9NpiftyJzZDq0oHL7Ihw2qdrD7im59+fNu8KL9Mxzp36KQuvL4VaWJEUiZ
         CHU/PpScuY1U/cgdQ9qWt+gisgYrNTo+jWmsGQ664y3AQbdDsAgFvIWBo+W+d89Ipthi
         F230FFOh90b3yIi4a2nKbYtdNw6UaZkkbMlpAx38NSLnrUhqfEJBLdO+uUoglaiOf5kU
         O0VButmRQnsJCleYp3QR4WjphwMiJSzw6s2akIyKP3aZ/7x8wE6Gme8rXSpkk9MKDh1w
         kwUw==
X-Gm-Message-State: AHQUAubK76oER15ZJJqmL2oI6ZAQ+ahL9DWoXpNFapk3MfuKQ7Idew1u
        9prUx12d+iYyyXLxhB85JNAAzVLHnqw=
X-Google-Smtp-Source: AHgI3IaU7UgxxJjFvRtIcWFbRLS/KXuUjKb37qsqQgRe09WkRjgsYAtOv2+TUvtkoCFZP+u53A38xg==
X-Received: by 2002:a63:2147:: with SMTP id s7mr26727125pgm.361.1550739635056;
        Thu, 21 Feb 2019 01:00:35 -0800 (PST)
Received: from endless.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id e63sm40380991pfc.47.2019.02.21.01.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 01:00:34 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>,
        Ming Shuo Chiu <chiu@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS UX362FA with ALC294
Date:   Thu, 21 Feb 2019 17:00:18 +0800
Message-Id: <20190221090018.1428-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX362FA with ALC294 cannot detect the headset MIC and outputs
through the internal speaker and the headphone.  This issue can be fixed
by the quirk in the commit 4e0511067 ALSA: hda/realtek: Enable audio
jacks of ASUS UX533FD with ALC294.

Besides, ASUS UX362FA and UX533FD have the same audio initial pin config
values.  So, this patch replaces SND_PCI_QUIRK of UX533FD with a new
SND_HDA_PIN_QUIRK which benefits both UX362FA and UX533FD.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Ming Shuo Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1ffa36e987b4..6421864a8a0f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6771,7 +6771,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
-	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
@@ -7388,6 +7387,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
-- 
2.20.1

