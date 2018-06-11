Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id py0yMo4oHlsVEAAAmS7hNA
	; Mon, 11 Jun 2018 07:45:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 68DDE606FA; Mon, 11 Jun 2018 07:45:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9oeeHIl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 00725607A4;
	Mon, 11 Jun 2018 07:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00725607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932386AbeFKHpw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:45:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35814 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbeFKHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:45:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15-v6so9341201pge.2;
        Mon, 11 Jun 2018 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pxo8K9YKGGcGEXwNw0iA013qkB/ESS9u++hAkgBSw1w=;
        b=g9oeeHIl5ITQyk33nU3nWaZmC1fYoaeqy/anDSsK4IH9RSHgvaH3tVDJzRDNtZUNHx
         cIpHkFQO9J9UEXJHEMuzD4MFWxfrpuyfPZAX4ti/muRjaRogrOHWd8VDz4BA0B+6QRqG
         ysEKCUGVuDix98oFfacrhVVskUc2sddvAqwZHWRVP/PMRkILqjv2wAy5POhmYg7cHEkK
         /oT8WXpizlSK2UI4FJVwU71VdDUe1TAHGXc4IqtBRzw237xf+Nta76YDHyOeVKYQBWzq
         zocrjr1XOLJn6T+kUjTdeG1iYC1Y7KmcCa02+5IRPOIPvuJ5cdYHB4Febc5uMDKqzcO6
         AbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pxo8K9YKGGcGEXwNw0iA013qkB/ESS9u++hAkgBSw1w=;
        b=fT7giCQfUBW/7GRCUehp6kHLgmZIEJV9+jwNlwwGWUs1KzKtz7VSWduZp6oCV2aIKr
         ZULXOxK/A1x49aR7MOvjnUcHIBSPvB38MPoyhsuZQsBL9Jnlb+RuU+YlqmcearTtElVw
         GbVoQRhG+y3HbD2rTR935k1fjK+oRIKcGjENuCjLfp4w6dZJ6iqXIOTTjQVY2juPDYHq
         mtMp+BvbA2MKl/eKyzQu2Pv6jz8Mt4jsvOiq1dqNZAijpVNcMfGUWcuhL01LpV4MXf1l
         KCjuHSot7g1tJlC7NxDHpteahJ0yMWKBZ8su2V0hTLh32FUzLyyR/9TKbjmc3c/JQp9r
         TiHw==
X-Gm-Message-State: APt69E33dwaV5gBQ44xKbyKqyJYf0o8VrwOlhSAnIOzRUHXXcVCqDkGq
        MBniJM41bkSCJkGBXI9qeF8=
X-Google-Smtp-Source: ADUXVKKrtwSlJjLafPZ8TTSAEMI3GvG4juErDFesonclQqFEGmluHCGj3THhzbLvKAHTiNY3Fd94sQ==
X-Received: by 2002:a63:a702:: with SMTP id d2-v6mr14153888pgf.246.1528703150256;
        Mon, 11 Jun 2018 00:45:50 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id v85-v6sm34835711pgb.50.2018.06.11.00.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 00:45:49 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brian Warner <brian.warner@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: cx88: add error handling for snd_ctl_add
Date: Mon, 11 Jun 2018 15:41:58 +0800
Message-Id: <1528702920-33410-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/media/pci/cx88/cx88-alsa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-alsa.c b/drivers/media/pci/cx88/cx88-alsa.c
index 8a28fda..d366793 100644
--- a/drivers/media/pci/cx88/cx88-alsa.c
+++ b/drivers/media/pci/cx88/cx88-alsa.c
@@ -962,8 +962,11 @@ static int cx88_audio_initdev(struct pci_dev *pci,
 		goto error;
 
 	/* If there's a wm8775 then add a Line-In ALC switch */
-	if (core->sd_wm8775)
-		snd_ctl_add(card, snd_ctl_new1(&snd_cx88_alc_switch, chip));
+	if (core->sd_wm8775) {
+		err = snd_ctl_add(card, snd_ctl_new1(&snd_cx88_alc_switch, chip));
+		if (err < 0)
+			goto error;
+	}
 
 	strcpy(card->driver, "CX88x");
 	sprintf(card->shortname, "Conexant CX%x", pci->device);
-- 
2.7.4
