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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8382DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433BB214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmVGcxVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433BB214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeISAIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38350 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeISAIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id g197-v6so1583928qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jG5q+w+jia4LVZmLh/Y3sw0OtNBQnHl7yEt82spNsXE=;
        b=pmVGcxVfo1cm6b1HYZFu6hw8WsP+wz/7+dZv60J7m2yPCEVBMVgx+ku/EdITOovL0O
         Y0y28IBoLYCnXjADmMKJyNyDH8J+0Yi9CfC7FnuPtf28XHGXywnGNRCtwMCV838EZ69x
         kANbWgP08JgeEpmaDzQbxHCZqB2fZab4DIXBkccAubO8YfnfgIvQpPvVd+oPQGX4S0UM
         zjbukxRHTIAahVl5Rvt6rWCW1M7+e4pFhUNYx/RpzUcYOXfQ/qRKDK7g6Qz+LIwdeOwE
         vaHous1wrCxmnsxqhS9OTUS+FBdISb9V0IDdNFcsBJmv3oez+DkqO0dD0XFupzZzTNsB
         WCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jG5q+w+jia4LVZmLh/Y3sw0OtNBQnHl7yEt82spNsXE=;
        b=damxQqZEVM6azaywGugrH1tiim5cne9EAyBWJUJguAc5DuRyHeJ0EvFbZ523UoQwOI
         wvel10vtlCAMcdR8aD5Rjzptpmqm81g78QfcRPYnja9gVim3qIueVfgJ2fnedlaQ8kyZ
         nRnnOs4lvdwWvTv94H1mwn3MtWcp/woUvLAOtrr+6TwYr+ppbnPT/DRsLRO3Q5TDVKbc
         lr7Tr4HPfbr9G217yA0nxJDyNWfmsp2P0RDCmByICCqv6x8F8qX40Wpzl22Ijtapac4i
         B0+QOtzgxsXpqdgH9Obi/VCrUvoTB02wGMgBYGjptO3MrbwaxM8b9//sASlhZpx+q8uu
         GR9g==
X-Gm-Message-State: APzg51DyrIqaFKM1pv5bqslL/D+yoyfYZO5+wqfsxz1nK33R7oWoxiOx
        jW8DDeS7T0saH2UpAbxdG48=
X-Google-Smtp-Source: ANB0VdbXIRlQT+6iLJXY2V1aDV9tOx8Q5Lmjmwi4G0sYrl+/5tSGNbUf2zGi/vgwU1VxtWykls5G2w==
X-Received: by 2002:a37:a0c2:: with SMTP id j185-v6mr21756418qke.67.1537295667794;
        Tue, 18 Sep 2018 11:34:27 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:27 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] ALSA: hda/ca0132 - Define new verbs and control params
Date:   Tue, 18 Sep 2018 14:33:29 -0400
Message-Id: <1537295625-8082-2-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines some new verbs found from reverse engineering of the
onboard 8051 CPU, and a control param found there as well. This clears
up usage of these verbs in other parts of the driver, and removes their
usage where they're now known to be unnecessary.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0166a3d..cd93c86 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -685,6 +685,9 @@ enum hda_cmd_vendor_io {
 	VENDOR_CHIPIO_DATA_LOW               = 0x300,
 	VENDOR_CHIPIO_DATA_HIGH              = 0x400,
 
+	VENDOR_CHIPIO_8051_WRITE_DIRECT      = 0x500,
+	VENDOR_CHIPIO_8051_READ_DIRECT       = 0xD00,
+
 	VENDOR_CHIPIO_GET_PARAMETER          = 0xF00,
 	VENDOR_CHIPIO_STATUS                 = 0xF01,
 	VENDOR_CHIPIO_HIC_POST_READ          = 0x702,
@@ -692,6 +695,9 @@ enum hda_cmd_vendor_io {
 
 	VENDOR_CHIPIO_8051_DATA_WRITE        = 0x707,
 	VENDOR_CHIPIO_8051_DATA_READ         = 0xF07,
+	VENDOR_CHIPIO_8051_PMEM_READ         = 0xF08,
+	VENDOR_CHIPIO_8051_IRAM_WRITE        = 0x709,
+	VENDOR_CHIPIO_8051_IRAM_READ         = 0xF09,
 
 	VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE   = 0x70A,
 	VENDOR_CHIPIO_CT_EXTENSIONS_GET      = 0xF0A,
@@ -798,6 +804,12 @@ enum control_param_id {
 	 * impedance is selected*/
 	CONTROL_PARAM_PORTD_160OHM_GAIN        = 10,
 
+	/*
+	 * This control param name was found in the 8051 memory, and makes
+	 * sense given the fact the AE-5 uses it and has the ASI flag set.
+	 */
+	CONTROL_PARAM_ASI                      = 23,
+
 	/* Stream Control */
 
 	/* Select stream with the given ID */
@@ -7140,11 +7152,6 @@ static void sbz_pre_dsp_setup(struct hda_codec *codec)
 	writel(0x00820680, spec->mem_base + 0x01C);
 	writel(0x00820680, spec->mem_base + 0x01C);
 
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
-
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
 	snd_hda_codec_write(codec, 0x11, 0,
@@ -7153,12 +7160,6 @@ static void sbz_pre_dsp_setup(struct hda_codec *codec)
 
 static void r3d_pre_dsp_setup(struct hda_codec *codec)
 {
-
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfc);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfd);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xfe);
-	snd_hda_codec_write(codec, 0x15, 0, 0xd00, 0xff);
-
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-- 
2.7.4

