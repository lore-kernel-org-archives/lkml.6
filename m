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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB43DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859AF214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usxB7bXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859AF214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbeISAI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35729 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbeISAI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id f62-v6so1595703qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gVvwJUUsuoo61qdK9/n8q8dibmVNerp3vNU6K3KNlaM=;
        b=usxB7bXW5xqzLuDB9CwrjAfED29IjMx+82WeHSmEu5xUhuVg7bzWLE5iWBEkK00+dP
         weNIONAQKaLPm/9hAj+LNTxGIrp93OkWnCnARbs/L3/WqzRoSJd/GG9uuOMEeHO+Oajs
         biFEOBS2L2OQbxhp9bMkX9qCvM5DKjDLpLw4ekyNEJUF0IS0MbnK0Og6lAGiu+OfXine
         rqhPr5rnRnYQmfIJzZl3TWTZeKZeA3Pq0ALP132c6YREWsc80c3wEW4m1+Z72FJbEbCy
         TJklO0yauDhLWZN5IGH/3iobDdsNRtq7unaV507mUueGQpqtJul9AeD9Y+8QiaymuZcS
         YBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gVvwJUUsuoo61qdK9/n8q8dibmVNerp3vNU6K3KNlaM=;
        b=T9IprHvE94nYp4ELkBxZOM8BOT1M4L6CJaC8+wo8cBaqESIPoPBbQnnsVP92d6YFgP
         hLCfNh2cpajVpdlhijljIfDQiZEtzrowJSXL4noFVZKiY/R5chH2ZJxECSuI7N+1pesV
         6ZWUQRbIklWW9cDwfMoBS3heXR+t+iDbyI/C9exZCYlp03VE85Hrnz1sD1HDjXF77q+5
         9as1f7iPdJQ7y0Gh/OuXbUABimFuuzq/SJGA3FgL9waSTiG7p+V4/SDkrcc9p2hAGz4C
         WvU5bIf4N/AoKygRwLSpLBrwEJhVHtLKRlxVhPnGshQJgH4crT1wlFXqd8RK0KDOiDG+
         P6Ag==
X-Gm-Message-State: APzg51CaN8oBMTtDrj1CCluiyP2eK7McxhiLluJIOz5wWLy2XW9lCrZJ
        o2KPq73jXYoOt08ivh0PeIo=
X-Google-Smtp-Source: ANB0VdaKyf60zUOauuxx7I4GEuDteDkwFDdC+T6kPddeAW/Vh4tb9dkKVB5V88xDoNYorSmB8ImvoQ==
X-Received: by 2002:a37:ac0d:: with SMTP id e13-v6mr21854659qkm.100.1537295676532;
        Tue, 18 Sep 2018 11:34:36 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:36 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] ALSA: hda/ca0132 - Change ca0132_mmio_init for AE-5
Date:   Tue, 18 Sep 2018 14:33:33 -0400
Message-Id: <1537295625-8082-6-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the unique writes for the AE-5 on startup to
ca0132_mmio_init. The other cards share some addresses written to, but
use different values.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 61 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7c870c4..51af3dc 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7223,23 +7223,72 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 
-	writel(0x00000000, spec->mem_base + 0x400);
-	writel(0x00000000, spec->mem_base + 0x408);
-	writel(0x00000000, spec->mem_base + 0x40C);
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0x400);
+	else
+		writel(0x00000000, spec->mem_base + 0x400);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0x408);
+	else
+		writel(0x00000000, spec->mem_base + 0x408);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0x40c);
+	else
+		writel(0x00000000, spec->mem_base + 0x40C);
+
 	writel(0x00880680, spec->mem_base + 0x01C);
-	writel(0x00000083, spec->mem_base + 0xC0C);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000080, spec->mem_base + 0xC0C);
+	else
+		writel(0x00000083, spec->mem_base + 0xC0C);
+
 	writel(0x00000030, spec->mem_base + 0xC00);
 	writel(0x00000000, spec->mem_base + 0xC04);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000000, spec->mem_base + 0xC0C);
+	else
+		writel(0x00000003, spec->mem_base + 0xC0C);
+
 	writel(0x00000003, spec->mem_base + 0xC0C);
 	writel(0x00000003, spec->mem_base + 0xC0C);
 	writel(0x00000003, spec->mem_base + 0xC0C);
-	writel(0x00000003, spec->mem_base + 0xC0C);
-	writel(0x000000C1, spec->mem_base + 0xC08);
+
+	if (spec->quirk == QUIRK_AE5)
+		writel(0x00000001, spec->mem_base + 0xC08);
+	else
+		writel(0x000000C1, spec->mem_base + 0xC08);
+
 	writel(0x000000F1, spec->mem_base + 0xC08);
 	writel(0x00000001, spec->mem_base + 0xC08);
 	writel(0x000000C7, spec->mem_base + 0xC08);
 	writel(0x000000C1, spec->mem_base + 0xC08);
 	writel(0x00000080, spec->mem_base + 0xC04);
+
+	if (spec->quirk == QUIRK_AE5) {
+		writel(0x00000000, spec->mem_base + 0x42c);
+		writel(0x00000000, spec->mem_base + 0x46c);
+		writel(0x00000000, spec->mem_base + 0x4ac);
+		writel(0x00000000, spec->mem_base + 0x4ec);
+		writel(0x00000000, spec->mem_base + 0x43c);
+		writel(0x00000000, spec->mem_base + 0x47c);
+		writel(0x00000000, spec->mem_base + 0x4bc);
+		writel(0x00000000, spec->mem_base + 0x4fc);
+		writel(0x00000600, spec->mem_base + 0x100);
+		writel(0x00000014, spec->mem_base + 0x410);
+		writel(0x0000060f, spec->mem_base + 0x100);
+		writel(0x0000070f, spec->mem_base + 0x100);
+		writel(0x00000aff, spec->mem_base + 0x830);
+		writel(0x00000000, spec->mem_base + 0x86c);
+		writel(0x0000006b, spec->mem_base + 0x800);
+		writel(0x00000001, spec->mem_base + 0x86c);
+		writel(0x0000006b, spec->mem_base + 0x800);
+		writel(0x00000057, spec->mem_base + 0x804);
+		writel(0x00800000, spec->mem_base + 0x20c);
+	}
 }
 
 /*
-- 
2.7.4

