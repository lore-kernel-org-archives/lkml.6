Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF546C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF75208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkCBGHjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF75208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754995AbeFNLlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:41:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39143 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeFNLln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:41:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so2807737pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wOUU805BKAZU6r+UYJht8HZHUH1hPa5LCtmNQZIYWZY=;
        b=EkCBGHjxMwAPv9s3Mq7INZrvPdadvjs6tc3gguWxVT8/uttpvSFFUHeOnmRbFoRRhu
         yzCkifT6WmRa1X8qfS5rQts0GoQJHQ6zuCYR5NDL8opt9aoT+3WA5RFPn1jd/q+P9zF2
         FQzMyt7qH4vpXPz2OD8JAYncatfraQjoZctcmUfeurTYe9gp0kBAfI2SoEEFy6GXafrY
         cD87r/oSRDVTR4I7URO8YWWumkBz0dkPKxgoOXyay78gYQG4gOKDQzRr3aKU/NiDPmL8
         L9QjdirHd9AprkQ78WmAohhFkimtl2m05Sf2ziVEJR0uOH7/NgW2JbM5x0aSPMsNN7U9
         /wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wOUU805BKAZU6r+UYJht8HZHUH1hPa5LCtmNQZIYWZY=;
        b=txs/90hOWD+869eWA76+MsdDBVodjQ1x2MxKUNyrpHOH1Km8tqzw1UD467JS/NWv6F
         M9tNW93lXt1wT9iIXYcl1PI7h8pio3KdyFfNcFssYsO/OynBOPxnV0quoMcu9k98hUCn
         zmRQoajqsb4qPNyfmOz/2zy+/qYYoCXlKRI9ckPR2kuDH+i37i0E7ESYJ4iJaNv13F4U
         f77k/IxAjlpkcXvR6lHr9o/oLUdcTLv2iL9PIb2Vabd0D7E+rRtbtGlW/ud0QPQR7cUt
         nU91ya37b7I8xMyqbys7OSTG+whGtHE2tEC51vMqhh+Nkr4yFp9M4XnfYJ4Mi3dGnSaA
         4ipA==
X-Gm-Message-State: APt69E3caMjsIFA414sC5gqD18FOQsMrVnSwrXMZCDO5+SGU4iQi9im8
        bpiC7Jlr3h3t92cdwYvTXmo=
X-Google-Smtp-Source: ADUXVKIbe4A3+eHXWbPxd4QEMTdkCCGF69TFDcLyES5lVxxcIKIw/u+opFHmvAyi3KtxPWr/aZ+6FA==
X-Received: by 2002:a65:62ce:: with SMTP id m14-v6mr1997188pgv.407.1528976503464;
        Thu, 14 Jun 2018 04:41:43 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id i71-v6sm6637082pgd.22.2018.06.14.04.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 04:41:42 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ALSA: sonicvibes: add error handling for snd_ctl_add
Date:   Thu, 14 Jun 2018 19:41:37 +0800
Message-Id: <1528976499-52071-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528704521-34060-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528704521-34060-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Check the return value of snd_sonicvibes_create_gameport.
v2->v3:
- Fix the code style.
---
 sound/pci/sonicvibes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index a8abb15..7fbdb70 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1188,6 +1188,7 @@ SONICVIBES_SINGLE("Joystick Speed", 0, SV_IREG_GAME_PORT, 1, 15, 0);
 static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 {
 	struct gameport *gp;
+	int err;
 
 	sonic->gameport = gp = gameport_allocate_port();
 	if (!gp) {
@@ -1203,7 +1204,10 @@ static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 
 	gameport_register_port(gp);
 
-	snd_ctl_add(sonic->card, snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+	err = snd_ctl_add(sonic->card,
+		snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+	if (err < 0)
+		return err;
 
 	return 0;
 }
@@ -1515,7 +1519,11 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		return err;
 	}
 
-	snd_sonicvibes_create_gameport(sonic);
+	err = snd_sonicvibes_create_gameport(sonic);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
-- 
2.7.4

