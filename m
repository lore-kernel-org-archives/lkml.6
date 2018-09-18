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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855B1ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44144214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDGT+Njq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44144214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeISAIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37096 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbeISAIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id n6-v6so2686951qtl.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWKZg1xgNMWPuWsY7NHV8trP0IBkfp34sPol3/qoslg=;
        b=bDGT+Njqzu1mME0baZp/QPgQbSxvLieN7z/5HqxDjSTDozjN4iAGjaObiScYyC1CHh
         4aTeojZkyRvDloG3wTxWF8Pklu3Cl/JC0Evw2WUGy6sv2+0Pe92cMwn8kC0pDXOAO8B1
         hpn2KHPbdz2HJslmWw74LSM4tEhkEs5iyeHq4jVKV3iGcOl7fbTv78/AFIa4lGjTlP3K
         4QEH6Z9Oe5cSk/nlqdYxA7+0RsC4vdmLEEMgw+1/Vm/IzuIq/bn2gD7sNAlWlDq8xU0U
         WgOq6R8lPmImucRjo93p5yZ8xmPFRkH57cmxdEdSo+X59MTT26wV5Zvz8CgFzgQenjit
         w3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWKZg1xgNMWPuWsY7NHV8trP0IBkfp34sPol3/qoslg=;
        b=E+NfUF1F+3DM68Lw2M9vAJjuBu3/TuxG47kfgH7Z9i3p4vzePbOyn89fay8ZvxO33O
         yRbDlpmk6LudOt4fOfIpVa2SQwaShwtEdy9KQZGhbkl+ahEN4+ebMhtBOhZ3d5sL1SzT
         SWg84J7S1k84N24aEZ0XqZQrffj+7aw1VuIVndNRf4rz1vOvyBIoazJD6ML9H3sebs6u
         J2IME1M9tAMuY9ZSQ4+EPjRrI7Zw7tgi7Uw9OeDxj1zMZKeFJ9ChYTkYCCnclQUjVe3H
         au3exImL3gVZ1RwrktaQlj0zSv2YpXBUzKUkKPqqfZZN9O1SrNyKqm06wuunoz/vJ9fE
         DIKQ==
X-Gm-Message-State: APzg51CsLfEhbPx1BtISHD5ufSeGiz8znlvAav7lfLNmkZA9EN18qr/X
        7v6kL3imB/5KazMm8aKVPQw=
X-Google-Smtp-Source: ANB0VdZPdDcjqTmGFYnzz8/1cJk5vth3zHf3s/W7M0gyUeMNev6LGglRvKd+xQ4Pg008/SHKsYCQqw==
X-Received: by 2002:a0c:acf3:: with SMTP id n48-v6mr22411103qvc.227.1537295693855;
        Tue, 18 Sep 2018 11:34:53 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:53 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] ALSA: hda/ca0132 - Add input selection commands for AE-5
Date:   Tue, 18 Sep 2018 14:33:41 -0400
Message-Id: <1537295625-8082-14-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the input selection commands for the Sound BlasterX
AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 364c3fe..ff80832 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4523,6 +4523,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			tmp = FLOAT_ONE;
 			break;
+		case QUIRK_AE5:
+			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			tmp = FLOAT_THREE;
+			break;
 		default:
 			tmp = FLOAT_ONE;
 			break;
@@ -4537,10 +4541,15 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 
 		chipio_set_stream_control(codec, 0x03, 1);
 		chipio_set_stream_control(codec, 0x04, 1);
-
-		if (spec->quirk == QUIRK_SBZ) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x0000000C);
+			break;
+		case QUIRK_AE5:
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x0000004C);
+			break;
 		}
 		ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
 		break;
@@ -4554,6 +4563,9 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		case QUIRK_R3DI:
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			break;
+		case QUIRK_AE5:
+			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			break;
 		}
 
 		chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
@@ -4564,11 +4576,13 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		tmp = FLOAT_ZERO;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
-		if (spec->quirk == QUIRK_SBZ) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+		case QUIRK_AE5:
 			chipio_write(codec, 0x18B098, 0x00000000);
 			chipio_write(codec, 0x18B09C, 0x00000000);
+			break;
 		}
-
 		chipio_set_stream_control(codec, 0x03, 1);
 		chipio_set_stream_control(codec, 0x04, 1);
 		break;
@@ -4584,6 +4598,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			r3di_gpio_mic_set(codec, R3DI_FRONT_MIC);
 			tmp = FLOAT_ONE;
 			break;
+		case QUIRK_AE5:
+			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x3f);
+			tmp = FLOAT_THREE;
+			break;
 		default:
 			tmp = FLOAT_ONE;
 			break;
@@ -4599,9 +4617,15 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		chipio_set_stream_control(codec, 0x03, 1);
 		chipio_set_stream_control(codec, 0x04, 1);
 
-		if (spec->quirk == QUIRK_SBZ) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
 			chipio_write(codec, 0x18B098, 0x0000000C);
 			chipio_write(codec, 0x18B09C, 0x000000CC);
+			break;
+		case QUIRK_AE5:
+			chipio_write(codec, 0x18B098, 0x0000000C);
+			chipio_write(codec, 0x18B09C, 0x0000004C);
+			break;
 		}
 		ca0132_alt_mic_boost_set(codec, spec->mic_boost_enum_val);
 		break;
@@ -4610,7 +4634,6 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 
 	snd_hda_power_down_pm(codec);
 	return 0;
-
 }
 
 /*
-- 
2.7.4

