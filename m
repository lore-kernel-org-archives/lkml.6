Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169E20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1O5utNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8169E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeLKGCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:02:33 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38789 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeLKGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:02:27 -0500
Received: by mail-vk1-f196.google.com with SMTP id w72so3121308vkd.5;
        Mon, 10 Dec 2018 22:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGPxibAY8ZyyYRmZa+UWB/0XnyEXDhHmRXiLVIHOJb4=;
        b=Z1O5utNgraZKxKcJ5EfoMMJt4kgDWSBxQGiy59Vy5C/9cfemaNWubfO4Py2UPYoE5o
         LaDu4jdakK/z4Zx0Pp4sPZJN7yePmVYUWbU6ya0Uk2sBl4SV/fCGeWSfe7GFv2GC8j2x
         i3dB2RUGEZIH+anp4S5fQAuQfTzQd0SqNJcTFQS1Y2Vm03eEuHASjlgqN/1H8dreOUka
         GnWkxyok22Qe5SAR0fiiCMqe8TwW4EAvMLVgzj/Dwg233ZIdXkdAJx6AfIYYxo8t7kzO
         Yl2TZgpeQVXgDKyJakKgb+HAq9J0DbrZFypM6Rgp3VmEonDH5XxPk5RfjhxFJ9OFFW6S
         DWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGPxibAY8ZyyYRmZa+UWB/0XnyEXDhHmRXiLVIHOJb4=;
        b=lURbAYb/SG+Pi5sDQO2juuZdecM1fTCi+j1YlhSUvkOHhC9LJJ+gcvLZ23kt2ihIAN
         UBPCqPEEkOtcsHfYwJyRjFac6U3cJbu5k4tFlVE/5CcpuFZc+0qMIreCo9umDOc5iL3c
         CZlmP6fBeWDbEsXeXR7dI364S0WbLdMDcllZmUBWyRAy8jhE/RzGV/skPWnuxtGm//MI
         e9HDwbD4Sxmwdo5w2gtHNNnDZXCH64P6AkpXRvKQ6F5sSIC8XGKYGdv0tZ8loCymdPDV
         lCdiuudGv0dyEfk1RqCHbADV9G+Yn7hD+Zt8WdPgKCIFMZl3XlivjPXmqr5SxOiyxoSL
         Y7vg==
X-Gm-Message-State: AA+aEWZFpT2IXYiOTxlYuCiz+XmE/ZTLk+qLjWIf9oLzC8ojN7tiZ3fz
        LhF9n9WYc3r9488h1OLPEg==
X-Google-Smtp-Source: AFSGD/Vv0WFqF3cjeLbRbChg1DQAY39tRp7M5uy07YB4PxcjevEj7ilLqee5Kp5fP1xUh0CHa3QHzw==
X-Received: by 2002:a1f:34c7:: with SMTP id b190mr6364821vka.55.1544508145996;
        Mon, 10 Dec 2018 22:02:25 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id a137sm5700765vsd.24.2018.12.10.22.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 22:02:25 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v10 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Tue, 11 Dec 2018 01:01:22 -0500
Message-Id: <20181211060125.28671-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211060125.28671-1-ayman.bagabas@gmail.com>
References: <20181211060125.28671-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the micmute key. This patch
enables the use of micmute LED for these devices:
1. Matebook X (19e5:3200), (19e5:3201)
2. Matebook X Pro (19e5:3204)

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1326f32f4574..9766fd249bdf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5776,7 +5776,9 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x1e, 0x411111f0},
 			{0x21, 0x04211020},
 			{ }
-		}
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_MIC_MUTE_LED
 	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6608,6 +6610,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
+	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
-- 
2.19.2

