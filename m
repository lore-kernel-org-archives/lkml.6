Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DCC28C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB01208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC0tfK8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB01208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755059AbeFNLWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:22:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41167 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeFNLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:22:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so3081629pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WG1ZM92egI9hXvjdDp5M7itqCRH08OMfu4yNNMx5wBI=;
        b=XC0tfK8aPUPdlH+dL/ffdqjTiKPuqaBuncIcogSjg9hjVUTjSal1EYhFRiku0AaYHL
         KSCuGEKX2ouLr6bCG+mlxZPCbFuX9Yhc5ygE2PZbvyuan4oqzfO/GyFoabvaaXKLM4+b
         Bc/MgVUmNDZK9kh0xKntASJuvSlgJF7lvVPKgDBfH+kKNCbyeS9xVMn7Eh7LgyTlyzoq
         1+8HM9GgTNS8Ds8zCyu3xRHf41QieVf94bts0hTNmrA7lyCI6CJ3u+bqWazmnwVg2f0G
         H3DOJ2QeBPd768Kau/GoxIZIifuBi3TfBANfmwbHws7nRHWBY8caH41K4g6S+G645eBN
         a9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WG1ZM92egI9hXvjdDp5M7itqCRH08OMfu4yNNMx5wBI=;
        b=qQHq+U4gjdiwTAvMxbqJIJUR6aDFwrz5709sSNpPHs8/BjLj94DjShB6JwbO9Qu4Dt
         LjX3g0CxU/uZLbofHSo2mhU2kKzXA3VFyvLOLXTqIQ6Dw9zLO6L3/ltYxCtDBh4JjAjW
         o+OEu1ScsY+dNYw9om2/x+0qtoOcNExRiyLNSZHPcHnj7YqSCYSs4vhJwKOmxonLM6Jk
         LCfQyiLQRUdGXffvbZ1gzej/mv287zGzCBKFuTWdxoivk55Nm//p7/+7Aeftr6xceMj4
         nNemjCB/3ml9fyVvyauyh0paNq+/aVVTZKldwHGBuNhHz/xmGJOMSxRdru114g59uFuB
         Ed2w==
X-Gm-Message-State: APt69E1rxyNk3uqwjTTULGFEzy8e4VQ26W/VPXqppNIC+1bgOBspFjSG
        LLylCG7o9xZLBxhHQ0G5Rao=
X-Google-Smtp-Source: ADUXVKJXRCw1wBhBMNsYtNnWHGgCc5SeOlvT0jpP9m0k3T5LG6PvUpE1T97fFzcwObttHLp99E3JPw==
X-Received: by 2002:a65:4a92:: with SMTP id b18-v6mr1913957pgu.107.1528975349943;
        Thu, 14 Jun 2018 04:22:29 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id c4-v6sm10784525pfe.53.2018.06.14.04.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 04:22:29 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: sonicvibes: add error handling for snd_ctl_add
Date:   Thu, 14 Jun 2018 19:22:18 +0800
Message-Id: <1528975341-51696-1-git-send-email-jiazhouyang09@gmail.com>
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
---
 sound/pci/sonicvibes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index a8abb15..75225b04 100644
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
@@ -1515,7 +1519,10 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		return err;
 	}
 
-	snd_sonicvibes_create_gameport(sonic);
+	if ((err = snd_sonicvibes_create_gameport(sonic)) < 0) {
+		snd_card_free(card);
+		return err;
+        }
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
-- 
2.7.4

