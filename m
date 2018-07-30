Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A16FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2683020873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WATxpgJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2683020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeG3PXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:23:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41033 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeG3PXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:23:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so5583769ply.8;
        Mon, 30 Jul 2018 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kE7PjXU5llRJHB5rk8hyr4gVdBSe3+TpguvSPdwdSwE=;
        b=WATxpgJ9OhKwqV8ZqmY/VQQ17p64PgGVUfthS6EIPwMHcHgIxiwniYmw0w4yQ3dLL/
         Ay5tr0+1MEHIB5+s1pHreVDJMwYFYbLj1cpoPZ4LMEZHdmD4n06hyZS44TOqNTQCyCaz
         UA9BcILbggE45RpE0LtkfCN3bf4Mm1t8MSGO1wZvu6CoujUsN0Nk19vP6q1AZTZSomVx
         ZYIwZQo3LDMOMfmeBNfnV6h6rdktti9qHw8iqvt8SHrVyVUuna3n5Velhz4MQ+k7NMGF
         VT1iNmOmycGheiHW1rL0xev1Wq/UOzRqKClEYqbqs9vtJGZ9kzZd4wC7zMCrCKv0AjeY
         tHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kE7PjXU5llRJHB5rk8hyr4gVdBSe3+TpguvSPdwdSwE=;
        b=rJy/kMNu/NWm3mvE6Qc6assDC5AuMQI7HvLG6GG6rxqx/1nRIWR0b1pWLD19Zu4+UJ
         zo5/lMH8HPAED2+1AutevFCKGZuoOWWocF2FTOvjSvuSpV85Wt3CKPNC2Ze/0D3Tvr04
         nz+6VG0M+bE5j8t9ivFw78N3Kn0t+eRBPkbcoza3h95UcmZG/yZBe2Hvs77EADemsO1c
         4c1XNzL3mT2/j+4ql6c1OrxIki5ECeSK4OO+oxTpBriCoL9Tbn/VHwmV+vSdIgoeclLP
         kEflz/yLpBM3MMcATLdlIeJitlPJlsgoKYAty/Tt10CRF2NWBgmciVFaSdY6/J+T4jBj
         7J0Q==
X-Gm-Message-State: AOUpUlGjPVn4xKCKf03b0fXVz2Zwb3VZ4fdGhouKXQgmrm1pwKUERHmc
        g0VdjOZDfD3PsDp6gc+/4uk=
X-Google-Smtp-Source: AAOMgpfTFVnCFruTD9J8HlThCiQNDf0jwHsr8Qeox6khDt2nWaqPCmvQwRBnxuSSRjMynRjz9ZI4CQ==
X-Received: by 2002:a17:902:28a6:: with SMTP id f35-v6mr5534573plb.240.1532958525668;
        Mon, 30 Jul 2018 06:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id 1-v6sm25345114pfk.134.2018.07.30.06.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:48:45 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] power: reset: piix4-poweroff: Replace mdelay() with msleep() and usleep_range() in piix4_poweroff()
Date:   Mon, 30 Jul 2018 21:48:38 +0800
Message-Id: <20180730134838.9124-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piix4_poweroff() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/power/reset/piix4-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
index 20ce3ff5e039..5d4c72992d2c 100644
--- a/drivers/power/reset/piix4-poweroff.c
+++ b/drivers/power/reset/piix4-poweroff.c
@@ -47,7 +47,7 @@ static void piix4_poweroff(void)
 	     io_offset + PIIX4_FUNC3IO_PMCNTRL);
 
 	/* If the special cycle occurs too soon this doesn't work... */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/*
 	 * The PIIX4 will enter the suspend state only after seeing a special
@@ -59,7 +59,7 @@ static void piix4_poweroff(void)
 				   PIIX4_SUSPEND_MAGIC);
 
 	/* Give the system some time to power down, then error */
-	mdelay(1000);
+	msleep(1000);
 	pr_emerg("Unable to poweroff system\n");
 }
 
-- 
2.17.0

