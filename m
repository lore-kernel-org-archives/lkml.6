Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7BCC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DD220685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqA00olF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DD220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeI3Jff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39974 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbeI3Jfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so6183414qkd.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xM1oTxR3ZZfvuVZCugb33hHZhHsVgtyxYXxyPbAPsCQ=;
        b=gqA00olFSv0P/hM0drQurhksQuFiwOPjrEMYiArugnTMs6JCtGPBjEFe9UoWxQlaVF
         MS3QTHGzIVYifhplqEgsikVHx6FlkWxQv7Zr1KmqRqIR3+FVKqoLZCsvYFwu+QagfyIC
         5axfJ8NatmpSkmKRIJ86+CaHssSjn03x6sYBoOsevdikQOMCUFYpX/VbXW4EzaBWxn70
         EDmKMxJPseDFwgAn3fSHUOoSUwjyDplZh1fc8pajCSGAUVMjx3gkKFuMaq1NWjicmlGi
         JNn+b7TEPyeHbS/KTsQV9uzOxaSrsqQ/+bJ6coPzMwUI9YPY5WssVup5bEFPS0RQwJKC
         r3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xM1oTxR3ZZfvuVZCugb33hHZhHsVgtyxYXxyPbAPsCQ=;
        b=mj3mFrhwGLsZ26WnII7SimmuYhPIy8aQRiVl/Jp5Jb00YFVxBIVjCOtffdnUT4ZW+F
         VCLt8bZvDa9fL2enR/Sa5+3X8BEoLFld9agUqNr5MWHdYsGwKgf/7R2xUSXhWm8dH0QK
         parIaPXkqU2d6e7m9c1q3iKZV9smzL/Awm9qVDYWMvOKJ0M+sq5xZ0lIRs5xWw/vPCiw
         iWihYU87yjvm6VsSbVdDErFLULse+aMOIqS88g1+ia7eZ3FXWr6VcgpCbLsQiaQtRm/D
         s8PyxfnC8QSpCyo9X3Pi0OIMNGTxj6JT5CYzPcux/A/HdqCpGpqHGeZD3GCkNAi25H8l
         yENw==
X-Gm-Message-State: ABuFfogI9iAZDip5r/mRUifNWGejR2CAOKRBvPulxPVZwlCeIrNILXbe
        m4l0IwPLxSGXL2lHq7RV+TyYGJv/
X-Google-Smtp-Source: ACcGV60Mc8PYNZoRjIZ1n9A0tOavrqdrduOzYuPpguPrT73NdrPjY+XGDjmTSuscZjG5ag03HEKRsg==
X-Received: by 2002:a37:aa44:: with SMTP id t65-v6mr521492qke.121.1538276667013;
        Sat, 29 Sep 2018 20:04:27 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:26 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] ALSA: hda/ca0132 - Add ZxR exit commands
Date:   Sat, 29 Sep 2018 23:03:26 -0400
Message-Id: <1538276607-30234-12-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds exit operations for the Sound Blaster ZxR.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 90e6a96..b098504 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7869,6 +7869,36 @@ static void ae5_exit_chip(struct hda_codec *codec)
 	snd_hda_codec_write(codec, 0x01, 0, 0x724, 0x83);
 }
 
+static void zxr_exit_chip(struct hda_codec *codec)
+{
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+	chipio_set_stream_control(codec, 0x14, 0);
+	chipio_set_stream_control(codec, 0x0C, 0);
+
+	chipio_set_conn_rate(codec, 0x41, SR_192_000);
+	chipio_set_conn_rate(codec, 0x91, SR_192_000);
+
+	chipio_write(codec, 0x18a020, 0x00000083);
+
+	snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
+
+	ca0132_clear_unsolicited(codec);
+	sbz_set_pin_ctl_default(codec);
+	snd_hda_codec_write(codec, 0x0B, 0, AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+
+	ca0113_mmio_gpio_set(codec, 5, false);
+	ca0113_mmio_gpio_set(codec, 2, false);
+	ca0113_mmio_gpio_set(codec, 3, false);
+	ca0113_mmio_gpio_set(codec, 0, false);
+	ca0113_mmio_gpio_set(codec, 4, true);
+	ca0113_mmio_gpio_set(codec, 0, true);
+	ca0113_mmio_gpio_set(codec, 5, true);
+	ca0113_mmio_gpio_set(codec, 2, false);
+	ca0113_mmio_gpio_set(codec, 3, false);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -8333,6 +8363,9 @@ static void ca0132_free(struct hda_codec *codec)
 	case QUIRK_SBZ:
 		sbz_exit_chip(codec);
 		break;
+	case QUIRK_ZXR:
+		zxr_exit_chip(codec);
+		break;
 	case QUIRK_R3D:
 		r3d_exit_chip(codec);
 		break;
-- 
2.7.4

