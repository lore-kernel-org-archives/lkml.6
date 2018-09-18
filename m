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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B2ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED35214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf63QOLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED35214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeISAIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34338 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbeISAIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id p84-v6so1350141qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k01POrarDDLVJs0ruGqogqk2Cobs4ohFKEzbmSuT58s=;
        b=Cf63QOLbANH24lI1/bswz/+HfONQD+oPpsCEtcQwuFN62moKXock8uRPjxseM2oPbT
         +OBl4/S1J8sPJd0Jd7NDOgklPqjaV15vGyYCZFXZCIVm0bgHJZxPmDvNgy2W6QMFxM52
         h4PQaDcP0SD96mhOQE7B4fZQ8m+xoevcnnGS/EimFjq2esF46mociRqKxVWC6rl9wABM
         8aVAKjxXN48loq2hmzd87OD+FjIsjoTQi/NfwSLQ+n0h8UydNtjAWYCFWYm1FoSN4TIv
         62s4jLjxwDVPxh/m3lsrSped91kVpDtw92EQPvsfIOEQlLRVNJ2Gbbvq6MmpRdtYTdBT
         e5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k01POrarDDLVJs0ruGqogqk2Cobs4ohFKEzbmSuT58s=;
        b=VE8yKlYnyAoWjLz4bUcYWAyhInTXs7+N0sQbEHtLXahK0UFw7DZNm8lpjsrxSqy4SD
         jNJePhKQAgbmSEVPrzRx/aLc6MNyRPY4V9FtzIH7bfU3CE/LetrlITeRyhnSLhtVS9la
         x216AW9dT6D5humgEWxVozU/Y7MmhHQu2PeNggm59s2uyGS8Hq7RfKchXD3I5Va6IFA1
         yaSGeutUvRJyaIc8zbBkEEvPUIDOvlvIysd67YTKofhvh5z+aPnCSUyNT/YVgZLVqz/0
         FFFtCFzfabVY4JuVRicb05XvPlHMGqW8BEDzEAkbo1li3OuxIZZEK1rdLr5WO8svtcvt
         AmHA==
X-Gm-Message-State: APzg51CQF/82DJcf8hZrkdPI3vjymNL+U5rEkK/qBJk+dZBQbgsO/hrA
        q3Ulr7Y66Me88Tp/EuPdG60=
X-Google-Smtp-Source: ANB0VdZ/toV0r7Yo6S5O69sHwz48rR0FT1DhgJDSGwZIPjbpxOQoJDbMIG8HsQmWrPYkMov3+s6klw==
X-Received: by 2002:a37:a0c2:: with SMTP id j185-v6mr21756924qke.67.1537295678702;
        Tue, 18 Sep 2018 11:34:38 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:38 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] ALSA: hda/ca0132 - Add AE-5 pre-init and ca0113 functions
Date:   Tue, 18 Sep 2018 14:33:34 -0400
Message-Id: <1537295625-8082-7-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AE-5 pre-init functions that happen before the main
ca0132_alt_init, and gives functions related to the ca0113 a ca0113
prefix instead of ca0132. It also adds functions to write to the 8051's
SFRs, and to write the special ca0113 commands for the AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 157 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 134 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 51af3dc..4b95dc0 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1483,6 +1483,20 @@ static void chipio_set_conn_rate(struct hda_codec *codec,
 }
 
 /*
+ * Writes to the 8051's internal address space directly instead of indirectly,
+ * giving access to the special function registers located at addresses
+ * 0x80-0xFF.
+ */
+static void chipio_8051_write_direct(struct hda_codec *codec,
+		unsigned int addr, unsigned int data)
+{
+	unsigned int verb;
+
+	verb = VENDOR_CHIPIO_8051_WRITE_DIRECT | data;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, verb, addr);
+}
+
+/*
  * Enable clocks.
  */
 static void chipio_enable_clocks(struct hda_codec *codec)
@@ -3117,7 +3131,9 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 }
 
 /*
- * Setup GPIO for the other variants of Core3D.
+ * ca0113 related functions. The ca0113 acts as the HDA bus for the pci-e
+ * based cards, and has a second mmio region, region2, that's used for special
+ * commands.
  */
 
 /*
@@ -3125,8 +3141,11 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
  * the mmio address 0x320 is used to set GPIO pins. The format for the data
  * The first eight bits are just the number of the pin. So far, I've only seen
  * this number go to 7.
+ * AE-5 note: The AE-5 seems to use pins 2 and 3 to somehow set the color value
+ * of the on-card LED. It seems to use pin 2 for data, then toggles 3 to on and
+ * then off to send that bit.
  */
-static void ca0132_mmio_gpio_set(struct hda_codec *codec, unsigned int gpio_pin,
+static void ca0113_mmio_gpio_set(struct hda_codec *codec, unsigned int gpio_pin,
 		bool enable)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -3139,6 +3158,54 @@ static void ca0132_mmio_gpio_set(struct hda_codec *codec, unsigned int gpio_pin,
 }
 
 /*
+ * Special pci region2 commands that are only used by the AE-5. They follow
+ * a set format, and require reads at certain points to seemingly 'clear'
+ * the response data. My first tests didn't do these reads, and would cause
+ * the card to get locked up until the memory was read. These commands
+ * seem to work with three distinct values that I've taken to calling group,
+ * target-id, and value.
+ */
+static void ca0113_mmio_command_set(struct hda_codec *codec, unsigned int group,
+		unsigned int target, unsigned int value)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int write_val;
+
+	writel(0x0000007e, spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+	writel(0x0000005a, spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+
+	writel(0x00800005, spec->mem_base + 0x20c);
+	writel(group, spec->mem_base + 0x804);
+
+	writel(0x00800005, spec->mem_base + 0x20c);
+	write_val = (target & 0xff);
+	write_val |= (value << 8);
+
+
+	writel(write_val, spec->mem_base + 0x204);
+	/*
+	 * Need delay here or else it goes too fast and works inconsistently.
+	 */
+	msleep(20);
+
+	readl(spec->mem_base + 0x860);
+	readl(spec->mem_base + 0x854);
+	readl(spec->mem_base + 0x840);
+
+	writel(0x00800004, spec->mem_base + 0x20c);
+	writel(0x00000000, spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+	readl(spec->mem_base + 0x210);
+}
+
+/*
+ * Setup GPIO for the other variants of Core3D.
+ */
+
+/*
  * Sets up the GPIO pins so that they are discoverable. If this isn't done,
  * the card shows as having no GPIO pins.
  */
@@ -4013,9 +4080,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		/*speaker out config*/
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			ca0132_mmio_gpio_set(codec, 7, false);
-			ca0132_mmio_gpio_set(codec, 4, true);
-			ca0132_mmio_gpio_set(codec, 1, true);
+			ca0113_mmio_gpio_set(codec, 7, false);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0D, 0x18);
 			break;
 		case QUIRK_R3DI:
@@ -4024,7 +4091,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			break;
 		case QUIRK_R3D:
 			chipio_set_control_param(codec, 0x0D, 0x24);
-			ca0132_mmio_gpio_set(codec, 1, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
 			break;
 		}
 
@@ -4053,9 +4120,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		/* Headphone out config*/
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			ca0132_mmio_gpio_set(codec, 7, true);
-			ca0132_mmio_gpio_set(codec, 4, true);
-			ca0132_mmio_gpio_set(codec, 1, false);
+			ca0113_mmio_gpio_set(codec, 7, true);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, false);
 			chipio_set_control_param(codec, 0x0D, 0x12);
 			break;
 		case QUIRK_R3DI:
@@ -4064,7 +4131,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			break;
 		case QUIRK_R3D:
 			chipio_set_control_param(codec, 0x0D, 0x21);
-			ca0132_mmio_gpio_set(codec, 0x1, false);
+			ca0113_mmio_gpio_set(codec, 0x1, false);
 			break;
 		}
 
@@ -4099,9 +4166,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		/* Surround out config*/
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
-			ca0132_mmio_gpio_set(codec, 7, false);
-			ca0132_mmio_gpio_set(codec, 4, true);
-			ca0132_mmio_gpio_set(codec, 1, true);
+			ca0113_mmio_gpio_set(codec, 7, false);
+			ca0113_mmio_gpio_set(codec, 4, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0D, 0x18);
 			break;
 		case QUIRK_R3DI:
@@ -4109,7 +4176,7 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
 		case QUIRK_R3D:
-			ca0132_mmio_gpio_set(codec, 1, true);
+			ca0113_mmio_gpio_set(codec, 1, true);
 			chipio_set_control_param(codec, 0x0D, 0x24);
 			break;
 		}
@@ -4370,7 +4437,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
 		case QUIRK_R3D:
-			ca0132_mmio_gpio_set(codec, 0, false);
+			ca0113_mmio_gpio_set(codec, 0, false);
 			tmp = FLOAT_THREE;
 			break;
 		case QUIRK_R3DI:
@@ -4403,7 +4470,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
 		case QUIRK_R3D:
-			ca0132_mmio_gpio_set(codec, 0, false);
+			ca0113_mmio_gpio_set(codec, 0, false);
 			break;
 		case QUIRK_R3DI:
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
@@ -4430,8 +4497,8 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
 		case QUIRK_R3D:
-			ca0132_mmio_gpio_set(codec, 0, true);
-			ca0132_mmio_gpio_set(codec, 5, false);
+			ca0113_mmio_gpio_set(codec, 0, true);
+			ca0113_mmio_gpio_set(codec, 5, false);
 			tmp = FLOAT_THREE;
 			break;
 		case QUIRK_R3DI:
@@ -6977,11 +7044,11 @@ static void sbz_region2_exit(struct hda_codec *codec)
 	for (i = 0; i < 8; i++)
 		writeb(0xb3, spec->mem_base + 0x304);
 
-	ca0132_mmio_gpio_set(codec, 0, false);
-	ca0132_mmio_gpio_set(codec, 1, false);
-	ca0132_mmio_gpio_set(codec, 4, true);
-	ca0132_mmio_gpio_set(codec, 5, false);
-	ca0132_mmio_gpio_set(codec, 7, false);
+	ca0113_mmio_gpio_set(codec, 0, false);
+	ca0113_mmio_gpio_set(codec, 1, false);
+	ca0113_mmio_gpio_set(codec, 4, true);
+	ca0113_mmio_gpio_set(codec, 5, false);
+	ca0113_mmio_gpio_set(codec, 7, false);
 }
 
 static void sbz_set_pin_ctl_default(struct hda_codec *codec)
@@ -7292,6 +7359,47 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 }
 
 /*
+ * This function writes to some SFR's, does some region2 writes, and then
+ * eventually resets the codec with the 0x7ff verb. Not quite sure why it does
+ * what it does.
+ */
+static void ae5_register_set(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	chipio_8051_write_direct(codec, 0x93, 0x10);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x44);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc2);
+
+	writeb(0x0f, spec->mem_base + 0x304);
+	writeb(0x0f, spec->mem_base + 0x304);
+	writeb(0x0f, spec->mem_base + 0x304);
+	writeb(0x0f, spec->mem_base + 0x304);
+	writeb(0x0e, spec->mem_base + 0x100);
+	writeb(0x1f, spec->mem_base + 0x304);
+	writeb(0x0c, spec->mem_base + 0x100);
+	writeb(0x3f, spec->mem_base + 0x304);
+	writeb(0x08, spec->mem_base + 0x100);
+	writeb(0x7f, spec->mem_base + 0x304);
+	writeb(0x00, spec->mem_base + 0x100);
+	writeb(0xff, spec->mem_base + 0x304);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x2d, 0x3f);
+
+	chipio_8051_write_direct(codec, 0x90, 0x00);
+	chipio_8051_write_direct(codec, 0x90, 0x10);
+
+	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
+
+	chipio_write(codec, 0x18b0a4, 0x000000c2);
+
+	snd_hda_codec_write(codec, 0x01, 0, 0x7ff, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x7ff, 0x00);
+}
+
+/*
  * Extra init functions for alternative ca0132 codecs. Done
  * here so they don't clutter up the main ca0132_init function
  * anymore than they have to.
@@ -7365,6 +7473,9 @@ static int ca0132_init(struct hda_codec *codec)
 
 	snd_hda_power_up_pm(codec);
 
+	if (spec->quirk == QUIRK_AE5)
+		ae5_register_set(codec);
+
 	ca0132_init_unsol(codec);
 	ca0132_init_params(codec);
 	ca0132_init_flags(codec);
-- 
2.7.4

