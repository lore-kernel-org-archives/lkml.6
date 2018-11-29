Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72198C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3570620673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmjGbKZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3570620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeK3LFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:05:40 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34429 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeK3LFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:05:39 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so2311489vsi.1;
        Thu, 29 Nov 2018 15:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCEDsDAx5PMCLS87mnomliQo7+OlS9XDiZToeHzkvd8=;
        b=mmjGbKZ0vWPPX9PvKFCKyUSt1IuA48nGwdwz91qQzFuvZnRCscauYMRaLZ+QKJnAAL
         4ig0quvaTvgY2cAiD4x1RWlflG1e8mub8UBevOzXiEEwsJ8eKwqGTA2ePwP5axITlHrN
         ULHPW6qwCNENsguqwomkNxORWvlSPYpICKGAGrdXQ424q+waU+iUArfa35endLQy0OV6
         KDwHKwVUOMmsVsWUBVdCohhOzL0Wzy2THqHCPPaQTt0nzQSK1334GmybxptJWgqW9bu/
         ARUdjb7XKm0anRe81pE+EalcNCtN5JEjRHV2w5AyNCyQA5vOMad9rx1mPCaAjqHjnt8R
         favQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCEDsDAx5PMCLS87mnomliQo7+OlS9XDiZToeHzkvd8=;
        b=FsiOEOsvz0AswYIal3IneuyqZwIL2jxQ0/RwAmnZCTTwu5+pEffLzD90YsaiWcxpHa
         f6EP7mty3XtzRIdYp/q3IgGM+13lVBB+CvWrn1WzP17bkikglqC5Ie4BwuhsaMuNIeTe
         DyrB12aEwkeqELxTGpbHdPZXeIKHc3YDlb9jRtmgeT38nVGdhf8BcUGdCLjNW5tE7IKG
         xVyWBvUEV2NBvpKBtdpSK59c4s19ovUDiQLSGGMgipyukMNnWxsW6Mk3b2f0/B0k/F+O
         BJ6Lo59thS0Gnydm8/FaqRuMEPr0N6bF9rjIcLg9uL+sx+eetIywbIPfjUMGRTQ04m+r
         ioFA==
X-Gm-Message-State: AA+aEWaHbIjcuZdm1EESC/090R93VfOBrSFAUXkRdQG3+5jrvq097oA9
        M3xlclxqrmjE8q7EbkrqcQ==
X-Google-Smtp-Source: AFSGD/XuoGvBSP/fhx1JhcrCEBVqrq7L2JUBMMs/9GDFHw1T8qsUlUOQl13+Mr1hqjVXAktNldT6SQ==
X-Received: by 2002:a67:45d8:: with SMTP id z85mr1591233vsf.106.1543535901088;
        Thu, 29 Nov 2018 15:58:21 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id d195sm520831vka.29.2018.11.29.15.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:58:20 -0800 (PST)
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
Subject: [PATCH v8 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Thu, 29 Nov 2018 18:57:38 -0500
Message-Id: <20181129235742.14332-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129235742.14332-1-ayman.bagabas@gmail.com>
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
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
2.19.1

