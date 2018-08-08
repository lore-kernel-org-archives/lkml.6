Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F43C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1995C2177D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok5j+2lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1995C2177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeHHTzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:49 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44933 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:48 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so2463248ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJpyd41qAC8imAN1StMw64515r0067ueDIdBahh60U0=;
        b=Ok5j+2lzESuF3aDoi2JHKYspVR/RglWR0gILQ1LVlln3QgCB7l7z0eqNuRQKuhQdvw
         re/mRQX4IzXtmQzPsTt0/7F+vh3rv4N4QIAMNwh14KFj3IIDyXRWm0qpTGYqYNl8oepY
         D2D1CvRAAS9hHy+qENuBrIA5hFqIM6qKuvxfTMHqOf9KTR5A84Z+Fcox5bU1MlcOuzJh
         PYBo9vUpzs38+tL9FAstITmiLIz2f+FgR7PX8q/mFShB+sGbkaJ/CAy6erBswOIMLX1p
         4+euNK2Er/4Volar4sOJTCOLc/hWX97V6iWonZafPJnzqgC+DQFYUS/ORfWWsa0A+oaK
         wurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJpyd41qAC8imAN1StMw64515r0067ueDIdBahh60U0=;
        b=L9EnWNqWhIwWDQC4BaNZv+S2xJs9qRj41WKkJtveL5+f5fPjILD87DmjeI6man/f2C
         f/weiVuQob1LTLONiD2qRDA1+lpSNKZE3KU3HZUTYjQFGY6WBBUP86ZfVPeYKpfpZzw3
         Z7jPBtthvrT1TYBqDpVjeXPD6zrKYwga9P1pTZxLexyypqFdESCx8IYAL154uYvW7IOC
         cXD5CoTRrVIRjsIZr7aL20YtCwy0bUYiZyjyiNLh8vVtl7XaqmpmaewiFSjWEzZcavFc
         /3HyqybviBKWPmthV/kmSkIS+TdZnQMvtLH/rxewyUGtRFSufcYePeYdbV4ezeL5IjLt
         YlNg==
X-Gm-Message-State: AOUpUlFjICFteXYsSuHbmWx5NCHseTeOeTvpZ6+L1hpsL9ZlIcQH2HL/
        RYijSM5v9+DZjGi41GeFMfg=
X-Google-Smtp-Source: AA+uWPw+c9zkzeJ9ophYAY9h5N7tbBJYBYy4514X8/PoZHZ1Qj0H97ybXfVXaeXZU7ofno9JqRUGnw==
X-Received: by 2002:a6b:b452:: with SMTP id d79-v6mr3100059iof.163.1533749706816;
        Wed, 08 Aug 2018 10:35:06 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:06 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] ALSA: hda/ca0132 - Create mmio gpio function to make code clearer
Date:   Wed,  8 Aug 2018 13:34:12 -0400
Message-Id: <1533749663-8200-2-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new function, ca0132_mmio_gpio_set, to clear up what
is going on with writes to mmio region 0x320.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 62 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 321e95c..9a92a64 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3073,6 +3073,24 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
  */
 
 /*
+ * For cards with PCI-E region2 (Sound Blaster Z/ZxR, Recon3D, and AE-5)
+ * the mmio address 0x320 is used to set GPIO pins. The format for the data
+ * The first eight bits are just the number of the pin. So far, I've only seen
+ * this number go to 7.
+ */
+static void ca0132_mmio_gpio_set(struct hda_codec *codec, unsigned int gpio_pin,
+		bool enable)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned short gpio_data;
+
+	gpio_data = gpio_pin & 0xF;
+	gpio_data |= ((enable << 8) & 0x100);
+
+	writew(gpio_data, spec->mem_base + 0x320);
+}
+
+/*
  * Sets up the GPIO pins so that they are discoverable. If this isn't done,
  * the card shows as having no GPIO pins.
  */
@@ -3947,9 +3965,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		/*speaker out config*/
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			writew(0x0007, spec->mem_base + 0x320);
-			writew(0x0104, spec->mem_base + 0x320);
-			writew(0x0101, spec->mem_base + 0x320);
+			ca0132_mmio_gpio_set(codec, 7, false);
+			ca0132_mmio_gpio_set(codec, 4, true);
+			ca0132_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0D, 0x18);
 			break;
 		case QUIRK_R3DI:
@@ -3983,9 +4001,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		/* Headphone out config*/
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			writew(0x0107, spec->mem_base + 0x320);
-			writew(0x0104, spec->mem_base + 0x320);
-			writew(0x0001, spec->mem_base + 0x320);
+			ca0132_mmio_gpio_set(codec, 7, true);
+			ca0132_mmio_gpio_set(codec, 4, true);
+			ca0132_mmio_gpio_set(codec, 1, false);
 			chipio_set_control_param(codec, 0x0D, 0x12);
 			break;
 		case QUIRK_R3DI:
@@ -4025,9 +4043,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		/* Surround out config*/
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			writew(0x0007, spec->mem_base + 0x320);
-			writew(0x0104, spec->mem_base + 0x320);
-			writew(0x0101, spec->mem_base + 0x320);
+			ca0132_mmio_gpio_set(codec, 7, false);
+			ca0132_mmio_gpio_set(codec, 4, true);
+			ca0132_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0D, 0x18);
 			break;
 		case QUIRK_R3DI:
@@ -4291,7 +4309,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 	case REAR_MIC:
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			writew(0x0000, spec->mem_base + 0x320);
+			ca0132_mmio_gpio_set(codec, 0, false);
 			tmp = FLOAT_THREE;
 			break;
 		case QUIRK_R3DI:
@@ -4323,7 +4341,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		ca0132_mic_boost_set(codec, 0);
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			writew(0x0000, spec->mem_base + 0x320);
+			ca0132_mmio_gpio_set(codec, 0, false);
 			break;
 		case QUIRK_R3DI:
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
@@ -4349,8 +4367,8 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 	case FRONT_MIC:
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			writew(0x0100, spec->mem_base + 0x320);
-			writew(0x0005, spec->mem_base + 0x320);
+			ca0132_mmio_gpio_set(codec, 0, true);
+			ca0132_mmio_gpio_set(codec, 5, false);
 			tmp = FLOAT_THREE;
 			break;
 		case QUIRK_R3DI:
@@ -6891,16 +6909,12 @@ static void sbz_region2_exit(struct hda_codec *codec)
 		writeb(0x0, spec->mem_base + 0x100);
 	for (i = 0; i < 8; i++)
 		writeb(0xb3, spec->mem_base + 0x304);
-	/*
-	 * I believe these are GPIO, with the right most hex digit being the
-	 * gpio pin, and the second digit being on or off. We see this more in
-	 * the input/output select functions.
-	 */
-	writew(0x0000, spec->mem_base + 0x320);
-	writew(0x0001, spec->mem_base + 0x320);
-	writew(0x0104, spec->mem_base + 0x320);
-	writew(0x0005, spec->mem_base + 0x320);
-	writew(0x0007, spec->mem_base + 0x320);
+
+	ca0132_mmio_gpio_set(codec, 0, false);
+	ca0132_mmio_gpio_set(codec, 1, false);
+	ca0132_mmio_gpio_set(codec, 4, true);
+	ca0132_mmio_gpio_set(codec, 5, false);
+	ca0132_mmio_gpio_set(codec, 7, false);
 }
 
 static void sbz_set_pin_ctl_default(struct hda_codec *codec)
@@ -7237,7 +7251,7 @@ static int ca0132_init(struct hda_codec *codec)
 	ca0132_refresh_widget_caps(codec);
 
 	if (spec->quirk == QUIRK_SBZ)
-		writew(0x0107, spec->mem_base + 0x320);
+		ca0132_mmio_gpio_set(codec, 7, true);
 
 	switch (spec->quirk) {
 	case QUIRK_R3DI:
-- 
2.7.4

