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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE178ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A36214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZdyuml1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A36214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbeISAIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33604 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeISAIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id r37-v6so2701864qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1veMIU5kVv8HVo0+U/FjvJSv42zop/zYJr+DL9LOJeo=;
        b=TZdyuml1E8BYjUBZ7xNYnY9gJxXSlV112H50b36h5pMgYNY2Jwv44Kk4Fl3mu02FpX
         +GakR0l3+hFiipT6HQS2xfhdLClG3HnXypJ5kjkWqBzsCswsh8LO0A8yXuRpA45fN5y/
         lYBnovMroHkbUqYJRoKoaA65jswelO3EbgZhviKcCRByrv6eiT006sJ5tKUiBkiOO34G
         NtinKY/VSty/jbpRlum1rZK/OEiD91eZYsOvV69JMSE0BqabI5J2OTpUxA3ivgLYa2wF
         Jcn/PNoZdVSK8zRgSPlbWtPLnoRGUVyQMEXcj4q+hopACAlH1mhv/oh/je4On3elv0XB
         56HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1veMIU5kVv8HVo0+U/FjvJSv42zop/zYJr+DL9LOJeo=;
        b=rSdoZzKI2dbAYcrmrif1cbSim+J3wsksaYWYsaUg+hPsSlayiOcgdFNVcU35836A0p
         Lp8kXp68PUrJIDafMicNGwI1AcOFo5EJ7pK1bMYpyuQ1oJ8WkjhKJ6NhP7KqMKFUK+dg
         8cEmmVfwfCim3E5WJS1Aojic3jp3NwQegfCbVzEOTIMQSWo9+ueiFCPacowpaSiXJLjP
         H3DJ6GspbpP8IUG7vdMQrt5VzsTuf0beHIuDmNSqkQHMha8xwbmLlF79Fbr8H/WqgGO0
         +CPNEZGsZ9ME28r0y6qU6ASsuy6hiBFUMEv3iyxNdIO1Hw/mLRp+hvFxm075BXppKTzg
         qNUw==
X-Gm-Message-State: APzg51DM37JWTybtQ7P5u1kzuBDANyfylC4PbrrxlsyHocNvosrR0/oI
        5hqbxWikMfpszz8T80k2eNKX22K9
X-Google-Smtp-Source: ANB0Vda/hiXy8DeKWyiBumgtxNhs90UZ4a7Ckn5O9gHGo0S++Cs9prCgizRXtTwR+SdF5N7FReZvyQ==
X-Received: by 2002:ac8:36fa:: with SMTP id b55-v6mr22896930qtc.49.1537295682871;
        Tue, 18 Sep 2018 11:34:42 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:42 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] ALSA: hda/ca0132 - Change firmware name and usage
Date:   Tue, 18 Sep 2018 14:33:36 -0400
Message-Id: <1537295625-8082-9-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Recon3D, AE-5, Z and ZxR all share the same firmware file. Rename
this from the specific "ctefx-sbz.bin" to "ctefx-desktop.bin" and set
the AE-5 and Recon3D to use it as well.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 163d2ac..ea67b9c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -81,12 +81,12 @@
 #define SCP_GET    1
 
 #define EFX_FILE   "ctefx.bin"
-#define SBZ_EFX_FILE   "ctefx-sbz.bin"
+#define DESKTOP_EFX_FILE   "ctefx-desktop.bin"
 #define R3DI_EFX_FILE  "ctefx-r3di.bin"
 
 #ifdef CONFIG_SND_HDA_CODEC_CA0132_DSP
 MODULE_FIRMWARE(EFX_FILE);
-MODULE_FIRMWARE(SBZ_EFX_FILE);
+MODULE_FIRMWARE(DESKTOP_EFX_FILE);
 MODULE_FIRMWARE(R3DI_EFX_FILE);
 #endif
 
@@ -6770,12 +6770,14 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	 */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
-		if (request_firmware(&fw_entry, SBZ_EFX_FILE,
+	case QUIRK_R3D:
+	case QUIRK_AE5:
+		if (request_firmware(&fw_entry, DESKTOP_EFX_FILE,
 					codec->card->dev) != 0) {
-			codec_dbg(codec, "SBZ alt firmware not detected. ");
+			codec_dbg(codec, "Desktop firmware not found. ");
 			spec->alt_firmware_present = false;
 		} else {
-			codec_dbg(codec, "Sound Blaster Z firmware selected.");
+			codec_dbg(codec, "Desktop firmware selected.");
 			spec->alt_firmware_present = true;
 		}
 		break;
-- 
2.7.4

