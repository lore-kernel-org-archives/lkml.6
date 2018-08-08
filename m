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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C92216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZyoGrNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C92216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeHHT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:56:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45458 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHT4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:56:05 -0400
Received: by mail-io0-f196.google.com with SMTP id k16-v6so2452992iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AWih7wUaLItSxunUAGBPh7BFuHKe3P2hg/fJSjXu3qo=;
        b=kZyoGrNz8qWgXmNPGtQ93Rf9ndULxQ4PltK/6II65mSAN2MfR6giAUL9yle5AOscZG
         ueZSQ+SMxlIUBDrqAbhrM/5F9iNu6KjLsMeRQfo3QQ6r+YfjRXEjeNDqs90UX657eK74
         Ts6jMhasvovq8aSnbpL8v/+v1tTzmA1H9Bh6tMf1PcF3zMEb0ezt4hZ8bsx96NGiE7w0
         we+K8RRxFi3KIeudj62RYX5btfOM88GEtDkaLXJPBiHgRqjM+zN51qpkwSHs16d6JWLk
         narC5DkwrDe7sda6NtDbeprC6/fcr9Oo/1GcUKbjX6rE1H1QIYEz5SahOE2qQoWMw+Hk
         +o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AWih7wUaLItSxunUAGBPh7BFuHKe3P2hg/fJSjXu3qo=;
        b=IGIAtBlfL738gt1u2Jc6nfuw+hdKU30RBcL20lYqg+dZTiyYWHkaEM0s1am48lDcNx
         crBwPuOVkAD6aVxGPLFswgDX1C6dhVCvYRN02xZyv+BwPLSPdxND4QIWo+ZqrzAB7mBa
         oK01Q94f8BWWZdQnBJDoXObZHRSJYfyJlF5AQLqE8RgIsjGOCSCt0WqW9kGYqjeutdt1
         EkPyzXUTDaAQmRANxZRdvgicaZyO5s4gtd3ROE9qrhqxL2QXqmndw5K9BFOhLIK1UjZr
         nVtRH4M8qrG6y3QEcZJ2zRTjS4x83+spJBXeufliQdAYtsavVg9CXxg3BlbVc+rgppRR
         4Rdw==
X-Gm-Message-State: AOUpUlHjPn/nENOxukr4sWr2LxSxhtvr6eWEqF2n+qEQjb9Gi8S5fjpw
        uyYlRE0p327aoR3+MDkB6Io=
X-Google-Smtp-Source: AA+uWPxsev2KDL4ceuaNu5C3d0zM1ZgggcTAQ0/a1zo63Ejm0oTExsRc3bDbQTsj8AK5+qdFUv0vqg==
X-Received: by 2002:a5e:8f0a:: with SMTP id c10-v6mr406363iok.92.1533749723268;
        Wed, 08 Aug 2018 10:35:23 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:22 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ALSA: hda/ca0132 - Add Recon3D input and output select commands
Date:   Wed,  8 Aug 2018 13:34:20 -0400
Message-Id: <1533749663-8200-10-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds commands to the alternative input and output select
commands to support the Recon3D.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0257fb9..18b97df 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3993,6 +3993,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			chipio_set_control_param(codec, 0x0D, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			ca0132_mmio_gpio_set(codec, 1, true);
+			break;
 		}
 
 		/* disable headphone node */
@@ -4029,6 +4033,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			chipio_set_control_param(codec, 0x0D, 0x21);
 			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
 			break;
+		case QUIRK_R3D:
+			chipio_set_control_param(codec, 0x0D, 0x21);
+			ca0132_mmio_gpio_set(codec, 0x1, false);
+			break;
 		}
 
 		snd_hda_codec_write(codec, spec->out_pins[0], 0,
@@ -4071,6 +4079,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			chipio_set_control_param(codec, 0x0D, 0x24);
 			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
 			break;
+		case QUIRK_R3D:
+			ca0132_mmio_gpio_set(codec, 1, true);
+			chipio_set_control_param(codec, 0x0D, 0x24);
+			break;
 		}
 		/* enable line out node */
 		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
@@ -4328,6 +4340,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 	case REAR_MIC:
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
+		case QUIRK_R3D:
 			ca0132_mmio_gpio_set(codec, 0, false);
 			tmp = FLOAT_THREE;
 			break;
@@ -4360,6 +4373,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		ca0132_mic_boost_set(codec, 0);
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
+		case QUIRK_R3D:
 			ca0132_mmio_gpio_set(codec, 0, false);
 			break;
 		case QUIRK_R3DI:
@@ -4386,6 +4400,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 	case FRONT_MIC:
 		switch (spec->quirk) {
 		case QUIRK_SBZ:
+		case QUIRK_R3D:
 			ca0132_mmio_gpio_set(codec, 0, true);
 			ca0132_mmio_gpio_set(codec, 5, false);
 			tmp = FLOAT_THREE;
-- 
2.7.4

