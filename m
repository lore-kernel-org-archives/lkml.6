Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA6DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E2B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVZii6E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E2B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeISAIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35683 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeISAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:32 -0400
Received: by mail-qt0-f195.google.com with SMTP id j7-v6so2687991qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VRzcOCBbGpJvii/gv6EbZ/f8iwmFpXfMdLgs2Rgd0BY=;
        b=qVZii6E1iXzLs0TeUfFpaEuu6i2iS+NcC1PXKigneuvbIc52CGXyOliVotuBg3eNYx
         pSeXkafqArswpmL3UwstpjQLF0oHbLAlkivbt12HcjDsQDbzZ6DqqTeIbT0mWFQG0x/Z
         I+mYLXHFfILZm444cCRlFgJKJT5Elg8ezh4zKRgLXnrOZFa96ghnQtE1z5b52cxlSkT2
         M7XPlzVXIxoSri/bfjINTkTfwvBVzcxdJuaRDOZauaIjvUScY4m7IqvaaL8PucmPaqCZ
         F0Do/NN4TakzhILZpRhj1gfSdf10/o9Oi7SBny3BfJ+myjk7M9O3OmhPFew57jd5D8Po
         YAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VRzcOCBbGpJvii/gv6EbZ/f8iwmFpXfMdLgs2Rgd0BY=;
        b=m5yLFPk4HvR61rbJPGrLRz4V/WM0Za8fOpD42nlWoHaJgVLYzua+jtfutLt0yV3NYc
         3dLzWrBOQEZ0AV4dZUmKXF2dNdl9cSJdDule1EryYLFXKSitt+pAlVeZCV7gY8VpEqGq
         +yFsVXe3s/lBvkz4lQ8mtSf/vEj6JD0GLV2pVAE4DThomN9sSWkjtNWhaMplBx2HaLOs
         Rg6gxq7RolUAqqBf2UmRW1PaEoEa5QVyY9wPC8ExlvtIX537ocPTXwaf5ZzvAbzrMxhA
         c1fiHpOXgXmiStWD7eO4rEElPpRsQ82IVQ0gJeN3BdkrPlHqux+ZyB0Mlz+Gbwj7Yjop
         3SAQ==
X-Gm-Message-State: APzg51B6eRsfHBrqt7PWlqJghrPFb1f00kpGanpmCdM8gOXiGcEqhwsY
        6p6ub0e6PN/l6OeA9m2yF9A=
X-Google-Smtp-Source: ANB0VdaE0rYmBY/XuhynCFyi1UAm0Jxds2aXvYoovoCnbCMtZ4nb1Blou7OcpzZPFsAnvmrStyQp+w==
X-Received: by 2002:ac8:4649:: with SMTP id f9-v6mr22444450qto.34.1537295680767;
        Tue, 18 Sep 2018 11:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:40 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] ALSA: hda/ca0132 - Add AE-5 regular init setup
Date:   Tue, 18 Sep 2018 14:33:35 -0400
Message-Id: <1537295625-8082-8-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AE-5 specific stuff to the ca0132_alt_init function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4b95dc0..163d2ac 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3215,6 +3215,7 @@ static void ca0132_gpio_init(struct hda_codec *codec)
 
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
+	case QUIRK_AE5:
 		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
 		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
 		snd_hda_codec_write(codec, 0x01, 0, 0x790, 0x23);
@@ -7432,6 +7433,17 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		break;
+	case QUIRK_AE5:
+		ca0132_gpio_init(codec);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x49);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_PLL_PMU_WRITE, 0x88);
+		chipio_write(codec, 0x18b030, 0x00000020);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
+		break;
 	}
 }
 
-- 
2.7.4

