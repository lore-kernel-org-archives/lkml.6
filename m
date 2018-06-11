Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iLoxAAgtHlsNVAAAmS7hNA
	; Mon, 11 Jun 2018 08:04:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DBC2960792; Mon, 11 Jun 2018 08:04:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiYmd1JH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66EB2602FC;
	Mon, 11 Jun 2018 08:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66EB2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeFKIEV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:04:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40814 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeFKIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:04:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so11844819plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6buNHpilJC47JmswQicQ5Bz16gdrS9D7/ZFV6sZ6FoI=;
        b=WiYmd1JH3AbUZ0oobJopkuGjN1unFG13K9cIEIyN8iCANGpzmw1icqc26rZkRyuV6o
         SMuS/Vk6B54klQV/U5Z5jB6axlEh2XtbRh0M6JGuAS+WH02XGFvyYSFLDOPoJUEPMMgz
         jcVq33pRCmAtwAFByX/Vzq9DrZnWwUlF00v39LVedhoNLicy57jiMsPJZl0RlWD4kEhc
         QiBgmErDlCQm2BTJTrHtJFyX/UxRNFlzk5naQ2yRoVLdyQ2f+aNdwoE8pciQplud9ILZ
         jFrr2T9hzuOPaNyUbdwndx6oEMkgyDh3ttlqjUNnSKmLaUpW83/TvAR02aKvfkxTYaD9
         JCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6buNHpilJC47JmswQicQ5Bz16gdrS9D7/ZFV6sZ6FoI=;
        b=sjtCSzelUPzYnEgValPFHjBh5u30qN9euh33qVNJ5lLC9BW8qjMX4yHaGacEtFoFcY
         fzMnnf/3Er07y5EX1uwEGI1w3sXk1mKtADVhgap/TqwR+TNmhhiDPRIO5FTUAM93pQhs
         TqcYdv03xDYxxS8Q234/fvwRGy4b96CbXRCs2yjMWrDMSefPj/4Hd4mRyep7+0qaGDg/
         1kbqrPHyuquetRm5TKz+vmA47Zz666iQXvq87BOOM6f/J0EzgppFD74/T5YdQbfmKzpj
         bf72EL+nqdZ3lJ7vbBWDSfLKCbUmQUuih29h/vMMmClEgju9DceNuIofmOBxwa3goIJ9
         MP9A==
X-Gm-Message-State: APt69E2xutDDJ1jlRmuM3bMRS+ImMOeV6UZMwRMr68r+f50vcDdliUcn
        b7Pny+ekWNvokzFKVJUjsNU=
X-Google-Smtp-Source: ADUXVKJYIfEivV9KW65fv7S/CaZDwIjQTvFD3S0pHdVW/ySyaXwNeeIRQeFYuWwLtQYwWuwMbxVkuQ==
X-Received: by 2002:a17:902:6903:: with SMTP id j3-v6mr17253415plk.313.1528704258856;
        Mon, 11 Jun 2018 01:04:18 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id b84-v6sm83790897pfm.123.2018.06.11.01.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:04:18 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: fm801: add error handling for snd_ctl_add
Date: Mon, 11 Jun 2018 16:04:06 +0800
Message-Id: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
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
 sound/pci/fm801.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 73a67bc..e3fb9c6 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1068,11 +1068,19 @@ static int snd_fm801_mixer(struct fm801 *chip)
 		if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97_sec)) < 0)
 			return err;
 	}
-	for (i = 0; i < FM801_CONTROLS; i++)
-		snd_ctl_add(chip->card, snd_ctl_new1(&snd_fm801_controls[i], chip));
+	for (i = 0; i < FM801_CONTROLS; i++) {
+		err = snd_ctl_add(chip->card,
+			snd_ctl_new1(&snd_fm801_controls[i], chip));
+		if (err < 0)
+			return err;
+	}
 	if (chip->multichannel) {
-		for (i = 0; i < FM801_CONTROLS_MULTI; i++)
-			snd_ctl_add(chip->card, snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
+		for (i = 0; i < FM801_CONTROLS_MULTI; i++) {
+			err = snd_ctl_add(chip->card,
+				snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
+			if (err < 0)
+				return err;
+		}
 	}
 	return 0;
 }
-- 
2.7.4
