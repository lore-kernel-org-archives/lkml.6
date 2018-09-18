Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5754AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091BB214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXCehBzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091BB214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeISAIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35750 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeISAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id f62-v6so1596172qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fnh61QSs19OMZaNiNlbID78VSnhY7DmchwlBvhjmqjQ=;
        b=jXCehBzKtzZEk4j4hBsbkbmVLZ6s/PdvDPqofGjlHWHjaykX3IMocbacV3V2PNrsiT
         q/Y2pLXUQaJE29SFLOiAjy89SApf2iQJ0Y5TENiidOJh1m6QiIpqt5swjlSgo7lX9GWz
         ZPoWFGEof7OlQASRBdrvXIc1UGUa4e64jadYe8JVZiAzBSFROEIEg7hAaSCyNIcYWMSZ
         vqT/wRLQqnyXkeHiltwa6VPVAg+26y155+/QLHclWaoCPjqFenHIZgAYpe5VR1IAt1Gr
         7/k/wL6Q2U7lxc3K12UyYO1PDAXGcZYq8tgQ5kGpFHDMcHq9Dhb4oo6VdYetBiw9H48+
         1/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fnh61QSs19OMZaNiNlbID78VSnhY7DmchwlBvhjmqjQ=;
        b=bF7k6GBVQTHURIwDxUyISVDRZESz7t3FBvrONxXxDdmkyCq0JUnJ/l4lP1pqxHZPdY
         VAl2w2ApAYuZ6l9AVr5/tla51n4u9enx0punmTqH42h+PlmtxOYiV2bKphWOlaizIt4N
         pxiAC6qEl5DYdBkp7sf5bMXA3gUSr4wKRDhqKlSbR1j2vqu5HjDnaAHLICqxEMKfxGkv
         jEyBUJfOVQSZNvqTX92WAdQajdU7KN6dyowe4ZgEMJVwBHqa9aAwYATadjKHsmPca+KT
         Nn8zlOiv5Bmv2rqBdN+MHqHZkOxYCxAhVJFB0evmjBB/iiNE802EgxOQzr3FdiNmOTXD
         iiZA==
X-Gm-Message-State: APzg51B+hCV2S7uwCe2x4tkM82FgHY3SASsEE4Q+DVuuvZaVfQRUVpk5
        jwvZyo7hkzHWYOkqTDJ9CAU=
X-Google-Smtp-Source: ANB0Vdb2clCH7JXbLJRsoGkmFTGK9wy4dhDOfvdfNBxhHr/fD2e/lnm+rTmML32Tofsl3LHCcDEm+w==
X-Received: by 2002:a37:5744:: with SMTP id l65-v6mr21694975qkb.216.1537295691683;
        Tue, 18 Sep 2018 11:34:51 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:51 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] ALSA: hda/ca0132 - Add output set commands for AE-5
Date:   Tue, 18 Sep 2018 14:33:40 -0400
Message-Id: <1537295625-8082-13-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds output selection commands for the AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 79 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4de94d7..364c3fe 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -666,6 +666,29 @@ static const struct ct_dsp_volume_ctl ca0132_alt_vol_ctls[] = {
 	}
 };
 
+/* Values for ca0113_mmio_command_set for selecting output. */
+#define AE5_CA0113_OUT_SET_COMMANDS 6
+struct ae5_ca0113_output_set {
+	unsigned int group[AE5_CA0113_OUT_SET_COMMANDS];
+	unsigned int target[AE5_CA0113_OUT_SET_COMMANDS];
+	unsigned int vals[AE5_CA0113_OUT_SET_COMMANDS];
+};
+
+static const struct ae5_ca0113_output_set ae5_ca0113_output_presets[] = {
+	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+	  .vals =   { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f }
+	},
+	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+	  .vals =   { 0x3f, 0x3f, 0x00, 0x00, 0x00, 0x00 }
+	},
+	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+	  .vals =   { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f }
+	}
+};
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
@@ -4025,6 +4048,18 @@ static int ca0132_select_out(struct hda_codec *codec)
 	return err < 0 ? err : 0;
 }
 
+static void ae5_mmio_select_out(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i;
+
+	for (i = 0; i < AE5_CA0113_OUT_SET_COMMANDS; i++)
+		ca0113_mmio_command_set(codec,
+			ae5_ca0113_output_presets[spec->cur_out_type].group[i],
+			ae5_ca0113_output_presets[spec->cur_out_type].target[i],
+			ae5_ca0113_output_presets[spec->cur_out_type].vals[i]);
+}
+
 /*
  * These are the commands needed to setup output on each of the different card
  * types.
@@ -4041,16 +4076,24 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 7, false);
 			ca0113_mmio_gpio_set(codec, 4, true);
 			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
+			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
 		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
 		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
 			ca0113_mmio_gpio_set(codec, 1, true);
 			break;
+		case QUIRK_AE5:
+			ae5_mmio_select_out(codec);
+			tmp = FLOAT_ZERO;
+			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+			chipio_set_control_param(codec, 0x0d, 0xa4);
+			chipio_write(codec, 0x18b03c, 0x00000012);
+			break;
 		}
 		break;
 	case HEADPHONE_OUT:
@@ -4059,16 +4102,24 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 7, true);
 			ca0113_mmio_gpio_set(codec, 4, true);
 			ca0113_mmio_gpio_set(codec, 1, false);
-			chipio_set_control_param(codec, 0x0D, 0x12);
+			chipio_set_control_param(codec, 0x0d, 0x12);
 			break;
 		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x21);
+			chipio_set_control_param(codec, 0x0d, 0x21);
 			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
 			break;
 		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0D, 0x21);
+			chipio_set_control_param(codec, 0x0d, 0x21);
 			ca0113_mmio_gpio_set(codec, 0x1, false);
 			break;
+		case QUIRK_AE5:
+			ae5_mmio_select_out(codec);
+			tmp = FLOAT_ONE;
+			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+			chipio_set_control_param(codec, 0x0d, 0xa1);
+			chipio_write(codec, 0x18b03c, 0x00000012);
+			break;
 		}
 		break;
 	case SURROUND_OUT:
@@ -4077,15 +4128,23 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 			ca0113_mmio_gpio_set(codec, 7, false);
 			ca0113_mmio_gpio_set(codec, 4, true);
 			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x18);
+			chipio_set_control_param(codec, 0x0d, 0x18);
 			break;
 		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
 		case QUIRK_R3D:
 			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0D, 0x24);
+			chipio_set_control_param(codec, 0x0d, 0x24);
+			break;
+		case QUIRK_AE5:
+			ae5_mmio_select_out(codec);
+			tmp = FLOAT_ZERO;
+			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+			chipio_set_control_param(codec, 0x0d, 0xa4);
+			chipio_write(codec, 0x18b03c, 0x00000012);
 			break;
 		}
 		break;
@@ -4231,7 +4290,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		break;
 	}
 
-	/* run through the output dsp commands for line-out */
+	/* run through the output dsp commands for the selected output. */
 	for (i = 0; i < alt_out_presets[spec->cur_out_type].commands; i++) {
 		err = dspio_set_uint_param(codec,
 		alt_out_presets[spec->cur_out_type].mids[i],
-- 
2.7.4

