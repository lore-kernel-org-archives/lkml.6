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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA7BECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAE7214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN0kcKPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAE7214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbeISAIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40076 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbeISAIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so2674480qtj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHHeGolKO1w+IspvZQ9xwsP7zrrpUFlXJw555hGFu1U=;
        b=mN0kcKPGzApILPAy5chzYEJwBW0xxniyQKdHiVUU7ohii0Fl547S2/Qxn63Is6Mu4c
         FR+3BH/srWg5ZKHtBZYrs6wZVWIlxjxyu5Q2BmXPVSij1IAZydWYeYNBCVTxBaB2t81U
         2yEzKLv1uccar0vt6WQkQGUzckJWqpwB7tjYHX6bT+1wBahXdkTroMwA3OXuWSmxP/eY
         2Q3l0LPMfqPrXlnBwH6XLzokf64tSWIQ12p39uJ8kaJp6/AF9xToeRg76FeO28SRqWbM
         x9OYBMot5rLwwoDPPYY2cico5S3rl4C9r+/2IjktWqiAtqWIMaQZtFbfFECLVWbDxHVt
         XF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHHeGolKO1w+IspvZQ9xwsP7zrrpUFlXJw555hGFu1U=;
        b=k9iflO2zjJLmXc9TTOD+kepQplHJWbaJy8m4BLf2S4BzewnkMI4aipz7ZypfUcz5sf
         3zIp8ubBsnSYUXh563Rd9zobo+FtsIYVhjn2tep2m79mzzPcYk8mQjmQiuePLF0226Iu
         M0J7AJXaTysDso3nIWXTVeiyCIijwSvLdvSZ5pNOKS/TLGuDWrvKrLbMnIJMgHvHVzy1
         aZfb+uByV3qq0U9NMHGBft4ry/rsevGacZ3oqxnxODzBgmqVKMbQLj/uoA/reVFu31Ma
         W53pU/oXwl2ZD+ZWkJTmhDUYKnMrrOYwAkFDQw4e91hv83FWIZDGve6Uvpt/l5srpmH5
         4ojg==
X-Gm-Message-State: APzg51B1zF5cH8AA/XkbELSY4BXuvYQdq4cZ58uG0/fkatKng9/zsBaE
        yAmcVHgs6qDtSSdilEmudKSp/63k
X-Google-Smtp-Source: ANB0VdYa7YWMJ8E8zcp8JcFAhP5bAOTxPY860A/T4vkBMZVx/7EROarJrLVeluzMT5hRFNI6G8pJLA==
X-Received: by 2002:a0c:f7d2:: with SMTP id f18-v6mr22212043qvo.83.1537295698123;
        Tue, 18 Sep 2018 11:34:58 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:57 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] ALSA: hda/ca0132 - Add AE-5 exit function
Date:   Tue, 18 Sep 2018 14:33:43 -0400
Message-Id: <1537295625-8082-16-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds exit commands for the AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7048cc0..9541ab5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7665,6 +7665,31 @@ static void r3d_exit_chip(struct hda_codec *codec)
 	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x5b);
 }
 
+static void ae5_exit_chip(struct hda_codec *codec)
+{
+	chipio_set_stream_control(codec, 0x03, 0);
+	chipio_set_stream_control(codec, 0x04, 0);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
+	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
+	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
+	ca0113_mmio_command_set(codec, 0x30, 0x30, 0x00);
+	ca0113_mmio_command_set(codec, 0x30, 0x2b, 0x00);
+	ca0113_mmio_command_set(codec, 0x30, 0x2d, 0x00);
+	ca0113_mmio_gpio_set(codec, 0, false);
+	ca0113_mmio_gpio_set(codec, 1, false);
+
+	snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
+
+	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
+
+	chipio_set_stream_control(codec, 0x18, 0);
+	chipio_set_stream_control(codec, 0x0c, 0);
+
+	snd_hda_codec_write(codec, 0x01, 0, 0x724, 0x83);
+}
+
 static void ca0132_exit_chip(struct hda_codec *codec)
 {
 	/* put any chip cleanup stuffs here. */
@@ -8109,6 +8134,9 @@ static void ca0132_free(struct hda_codec *codec)
 	case QUIRK_R3D:
 		r3d_exit_chip(codec);
 		break;
+	case QUIRK_AE5:
+		ae5_exit_chip(codec);
+		break;
 	case QUIRK_R3DI:
 		r3di_gpio_shutdown(codec);
 		break;
-- 
2.7.4

