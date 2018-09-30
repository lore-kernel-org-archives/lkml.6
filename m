Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AECC43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4720880
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBKozE5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED4720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeI3JfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44685 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeI3JfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id g184-v6so6163320qkc.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5P76N37fmmOIrfzPaLtOXsbuGCjX4GjBJQCYXczp3s=;
        b=dBKozE5bA/V/z2Vlge7xmPNkZ9TqWpGZxt9QdeqZ4tKjTXSU3N0kCDNFVop2uIC/em
         B58yWcYOfU0/Vd2f2vO164pejCBgkvI2S47OZp+1Tv00UElsvW/KwGnHKQDI62+bd78d
         tNQScYiEBwUe0J7xn6rYQtYdWY5l7T8DQ4AFCKqbNz3bt/Q2po84hmEVEwDwevjamdQN
         VB8QVatNsw/QThoKsD8nUD6XSK35K/h4YgkRiUe82gs7pknI/Jqvkqgek3uYWrHM/QhH
         +dLs/CJz5QbHzoUiFFnOJnlaqCGjiJfzaYfA737okoW1o9aIHqhg9teav6CAGD0bBti/
         y+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5P76N37fmmOIrfzPaLtOXsbuGCjX4GjBJQCYXczp3s=;
        b=CuAnGv6e2Y9IQ6AJ3PHljYxMq6HRqsQm3GZ+mZStIgs/Rnyg2JjsN5YmnLesK4iqMz
         8p4DjdTapH2vBvCZnoEIeVDFlx3XL+rhpz+9c+ql9mRetv6jRM2B+9jgRdBSISYSipQE
         8g6AVOl3hweYL3zsX5C2UEqu2Un5kzBgqH7YWks8BRfUVJR9fNl9+nJpBnWOzut9VSRN
         dBpPp9L6bdTMgz0mshxPdxWpZo1OC0oEhp0bPp9n8Got3Ikcd149kbZ9Q6wnIdjZ0p7Y
         kRRuK+c8SOGp0HjjuoirsWiXTPHnwO5hYOJSkhtihAkeiClEde5ua7hz9DrUXXbX8bNX
         dixw==
X-Gm-Message-State: ABuFfoj7L9rs7BmiYXEtsCWfhkfWUEK9TXPOupe2MhJ1EyTCChyBs3Pe
        EDkzRRC1NKy/J1MMc/YOLcE=
X-Google-Smtp-Source: ACcGV63/AGaMSfj6MVqZb00T/qHf6G/wMhU33TYGFrSx78HWDhtv2ZHXYkHYlSi9ruZobxwWCrfhjQ==
X-Received: by 2002:a37:d6c2:: with SMTP id p63-v6mr3913868qkl.190.1538276649794;
        Sat, 29 Sep 2018 20:04:09 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:09 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ALSA: hda/ca0132 - Add ZxR quirks + new quirk check function
Date:   Sat, 29 Sep 2018 23:03:18 -0400
Message-Id: <1538276607-30234-4-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds quirk ID's for the ZxR and it's daughter board, the
DBPro. It also adds a function for determining the quirk for each board
through HDA subsytem ID's instead of PCI subsystem ID's.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5a3fb56..08dd85d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1071,6 +1071,8 @@ enum {
 	QUIRK_ALIENWARE,
 	QUIRK_ALIENWARE_M17XR4,
 	QUIRK_SBZ,
+	QUIRK_ZXR,
+	QUIRK_ZXR_DBPRO,
 	QUIRK_R3DI,
 	QUIRK_R3D,
 	QUIRK_AE5,
@@ -8376,6 +8378,29 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	return 0;
 }
 
+/*
+ * The Sound Blaster ZxR shares the same PCI subsystem ID as some regular
+ * Sound Blaster Z cards. However, they have different HDA codec subsystem
+ * ID's. So, we check for the ZxR's subsystem ID, as well as the DBPro
+ * daughter boards ID.
+ */
+static void sbz_detect_quirk(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	switch (codec->core.subsystem_id) {
+	case 0x11020033:
+		spec->quirk = QUIRK_ZXR;
+		break;
+	case 0x1102003f:
+		spec->quirk = QUIRK_ZXR_DBPRO;
+		break;
+	default:
+		spec->quirk = QUIRK_SBZ;
+		break;
+	}
+}
+
 static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
@@ -8401,6 +8426,9 @@ static int patch_ca0132(struct hda_codec *codec)
 	else
 		spec->quirk = QUIRK_NONE;
 
+	if (spec->quirk == QUIRK_SBZ)
+		sbz_detect_quirk(codec);
+
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 
-- 
2.7.4

