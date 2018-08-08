Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994A6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553612178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ2VYX2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553612178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeHHTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:58 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35019 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:56 -0400
Received: by mail-it0-f51.google.com with SMTP id 139-v6so4688434itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KmLMbsGiBZoh8+1j9BQC4vk7Cdxb0jDVQBaaqRTBDMo=;
        b=kZ2VYX2IEkCkxOJ2Z4lruq9eo850WUDjrBLS9Oo5ZGGzRZ14jQDwDvbuOByNSy92bl
         QQ8VOyC8eEBSKXgPwxBZnur0imJ1uMJoIlL5KCAwjfGum/XXzOECdLMT0LkQwPdgNa61
         +Xz2N9ONMUtaJxFJgqFt8lvFjQPo0eYe899DGuobpgKnLcMddWooFo0isAbvy+GYSI4x
         +XaAKoCrJmpGgW/8mUm85AmDNg0j2SqZ9QBjcydlA4Ws+Sbui1XHPqlsjuDgEDQZrVnd
         GWhvPmD0hw9wVU6jHAnRZGB5ySEJRvo9jcV4GFI7fMB2wZjBenaNkkPokf6Olaz9aZWo
         YahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KmLMbsGiBZoh8+1j9BQC4vk7Cdxb0jDVQBaaqRTBDMo=;
        b=Dv8PYP1/b+SN6iXghEpT+uQXZqNj9QNXGFkKTvhdrj1pNTSlGw8uzgZw5Rr/b2H2I2
         8ugfs1Qu0ruCbL+tbX30Byq/Dds6eLiY/awC7PaWSq3aOpc7QrSkvtgJdg/pIS5/LkbA
         aw3urFu5FVBZIzr1Hr7G8zQAm1e8KoMOPxdbT9+vuKJmEf0Xj8qdRW4bvw9aQyELmQ0+
         hONU+s7/iCk9rpEcE8VaQeSatXTCVGkCpFn/Nz4ipAf5GtKDkIiESmtJMW6WAezqIAje
         u7eMLyCYP5l7FRm0PC/Gt+uL/J7qI9kgObd9hR1BceqPXtPe3s5idbN4zobrV+uI7MPM
         MlDQ==
X-Gm-Message-State: AOUpUlFGzF/dys0ywARTLxUn5yCVthOSJjJqqWiukVY4Xxu6/jaIfrgN
        ci53B5L0AqT/tVR7Xz8NbBM=
X-Google-Smtp-Source: AA+uWPxNgM5Z1Esmh+ca/mtCg+pau3h8cpjztUk3EbOdm1Fu5ZADkn64gMt5RIxOtgYqwcJATUiQaw==
X-Received: by 2002:a24:bd82:: with SMTP id x124-v6mr44024ite.143.1533749715001;
        Wed, 08 Aug 2018 10:35:15 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:14 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ALSA: hda/ca0132 - Add Recon3D pincfg
Date:   Wed,  8 Aug 2018 13:34:16 -0400
Message-Id: <1533749663-8200-6-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pin configs from the Recon3D, taken from the Window's
driver.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bec31b2..2ee9549 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1026,6 +1026,21 @@ static const struct hda_pintbl sbz_pincfgs[] = {
 	{}
 };
 
+/* Recon3D pin configs taken from Windows Driver */
+static const struct hda_pintbl r3d_pincfgs[] = {
+	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x01c520f0 }, /* SPDIF In */
+	{ 0x0f, 0x0221401f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01016011 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01011014 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x02a090f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
 /* Recon3D integrated pin configs taken from Windows Driver */
 static const struct hda_pintbl r3di_pincfgs[] = {
 	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
@@ -7397,8 +7412,15 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->unsol_tag_amic1 = 0x11;
 		break;
 	case QUIRK_SBZ:
-		codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
-		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+	case QUIRK_R3D:
+		if (spec->quirk == QUIRK_SBZ) {
+			codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
+			snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+		}
+		if (spec->quirk == QUIRK_R3D) {
+			codec_dbg(codec, "%s: QUIRK_R3D applied.\n", __func__);
+			snd_hda_apply_pincfgs(codec, r3d_pincfgs);
+		}
 
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
-- 
2.7.4

