Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC04BC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C6020685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuRfyrU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C6020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeI3Jf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35383 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeI3JfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id z14-v6so10729707qtn.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xt15F7EkQCZWxPuHMPRVWFzZ645D6lUEdCUkZI+iNdk=;
        b=UuRfyrU9v3i3kI8able0AAasuRYcfh91z34RknsxzxISvdWlCHkVCRtnwVzUmnp4FK
         cdXAIbeM9bt6OfJUPkf4fUoD6WJ8ezjmNTMN/BfB15uorJl2GmjaSDTuOgXHUK1fn5/O
         l+iFf1Zat+WluQjW61dWIqcLoeIEj3vcv/tRa5Rerm2L2fWxUm9dKWyQSbwmPSgmNOvF
         TG/nBzecA/DSvRGQJqDuaQDWIU9freMkHGGr23c7e811km1HDCjhSCNGYcEnRVRVbWuP
         NNnDDuCz9Xm7e3MiAYR+Hc8ygClhS8vSKpgIdR/v9W8Ea7WSJfjm8adv7cSFF+luT3sJ
         7iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xt15F7EkQCZWxPuHMPRVWFzZ645D6lUEdCUkZI+iNdk=;
        b=TVlNDa5hD++gKaK+id91p7cFcqzgwpDtWf+zEoaOtyrJwfe4hL2OfKpL5/o2rPOP6q
         T3AR6x+ZFdwsI+HB5MDtUwITNTU6L47imnWf1kmj6RTpZu4JeupJVbKvqfX4F4oxwnFh
         5Jm7FIBmAwYvmZXI+tmvEp1jmZCGYDjxBYUiijtkW5T6G5ThMmdEc0Qs5McRu188w0tN
         xto7CAK5pAEInH/jeYzdYmj37cxvpxZ2WNXzssTVHPshl3/xmbwWJrzs5uHqqdzfWltT
         HuPEZM7AY0tulH+UkVM4KoNUywXil8SK0enPEKKLH5WOIlH1J+v4q8TXAR0XAFh2+IHZ
         QHxA==
X-Gm-Message-State: ABuFfojfTP3LgwHZR4CWE+zUZ7Q3cCAqyjt05vl9mBrU84ixgZJQ1xcd
        2jc+b3FRXe2d9eWWjRveWHM=
X-Google-Smtp-Source: ACcGV60Q/omQ0Wxjv27xKwqjPr1+mchqIIYQ0hirc6X+9pE0eQ/PL6NPEtCrPZoc1bCWEEXjZXyTtw==
X-Received: by 2002:a0c:d7c3:: with SMTP id g3-v6mr4024845qvj.85.1538276658474;
        Sat, 29 Sep 2018 20:04:18 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:18 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ALSA: hda/ca0132 - Add ZxR DSP post-download commands
Date:   Sat, 29 Sep 2018 23:03:22 -0400
Message-Id: <1538276607-30234-8-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds commands for setting up the ZxR after the DSP is
downloaded. The ZxR already shares most of the post-download commands
from the regular Sound Blaster Z.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6e48c3d..729766a 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6854,19 +6854,29 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 	chipio_set_stream_channels(codec, 0x0C, 6);
 	chipio_set_stream_control(codec, 0x0C, 1);
 	/* No clue what these control */
-	chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
-	chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
-	chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
-	chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
-	chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
-	chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
-	chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
-	chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
-	chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
-	chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
-	chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
-	chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
-
+	if (spec->quirk == QUIRK_SBZ) {
+		chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
+		chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
+		chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
+		chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
+		chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
+		chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
+		chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
+		chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
+		chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
+		chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
+		chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
+		chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
+	} else if (spec->quirk == QUIRK_ZXR) {
+		chipio_write_no_mutex(codec, 0x190038, 0x000140c2);
+		chipio_write_no_mutex(codec, 0x19003c, 0x000141c3);
+		chipio_write_no_mutex(codec, 0x190040, 0x000150c4);
+		chipio_write_no_mutex(codec, 0x190044, 0x000151c5);
+		chipio_write_no_mutex(codec, 0x190050, 0x000142c8);
+		chipio_write_no_mutex(codec, 0x190054, 0x000143c9);
+		chipio_write_no_mutex(codec, 0x190058, 0x000152ca);
+		chipio_write_no_mutex(codec, 0x19005c, 0x000153cb);
+	}
 	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
 
 	codec_dbg(codec, "Startup Data exited, mutex released.\n");
@@ -8161,6 +8171,7 @@ static int ca0132_init(struct hda_codec *codec)
 		r3d_setup_defaults(codec);
 		break;
 	case QUIRK_SBZ:
+	case QUIRK_ZXR:
 		sbz_setup_defaults(codec);
 		break;
 	case QUIRK_AE5:
-- 
2.7.4

