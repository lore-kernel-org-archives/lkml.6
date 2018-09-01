Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4114FC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D118620841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soRnJkdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D118620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIAQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:09:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeIAQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:08:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so6620754plr.8;
        Sat, 01 Sep 2018 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3d0J28Vb3WA0wmPtWbShWTMZQB/NfXKpkJhNO0HBgaU=;
        b=soRnJkdVNCTroW9a2qD7K1mUt8l7qNso/vh+cYlnmP+vqH5tDSHx7ctxQI/2PfX5FD
         E1w0I5jNjWrXpavV40ZJqhZtEEvF/+JPiih8ulZBrxGBRXulvs6MWUUNwIrpXX/HF8eF
         sCGGtTSmzBdR69S99oLTAx5b2KubnWEtdZvRimLQe3qZxHQfms6Us4ZZzKNG+rB/ua6I
         5IHNy9imCsk3JgetSlAO5c67LoN53TTq/N/rPlPyyOAYO8oXmkwxOj2NXofZ1UiofHsV
         htej22WST5l3qZmPs1t1Rr+RPlND/BBb291bBBJ+P9inSxSHY7tFtaGZTMsC939g/ifN
         50dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3d0J28Vb3WA0wmPtWbShWTMZQB/NfXKpkJhNO0HBgaU=;
        b=i9FOK60UbP1MHXgIrF/JfQuoF5xmSV4VfCVyNCIJNR/cRM/LIfEV0avxTni9Lx9Dbu
         uE0Q1T8DcL5PE/oGqR/8auIqPBqU/4m5oXZLhQQvsCHnXyB4NDNXYBS4TIo+wzAlZ7Jx
         i2uddogMV9+P3MOe4I9pMMEMlkOTWTi04SE9bC8LQ7npUH5W2hW2zzaSBv69OmoxhmkU
         peR052T+Sey6LaygBEseXGjEiXES4Vke4EAXiW0kyNjTzmMHUvf4UOqNi1dMu/3d3hbJ
         GJANeeYB0MgESFLSF6FAsHCuUcVoxbD1GnLse7nRIHUSFHsBchH7JUdK/9qtZZTVsFNP
         n03A==
X-Gm-Message-State: APzg51DazCGfnXJj77rBql9tpBqPI9AZb8pwwgpa/p0u0B7pxInoUP/r
        QCXvSUD+xyN2rw3MTujiKJkUzN5x
X-Google-Smtp-Source: ANB0VdZ629PZy2mjJQfLxBINEV/rpIbvku6socEpMmscPb+SR7s1aTZSHbeAW3a1lRAJE2XQOOtr5A==
X-Received: by 2002:a17:902:9687:: with SMTP id n7-v6mr19753017plp.33.1535803032361;
        Sat, 01 Sep 2018 04:57:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id p1-v6sm16320878pfn.53.2018.09.01.04.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:57:11 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: mISDN: layer2: Fix a sleep-in-atomic-context bug in create_l2()
Date:   Sat,  1 Sep 2018 19:57:05 +0800
Message-Id: <20180901115705.31050-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kzalloc(GFP_KERNEL)
drivers/isdn/mISDN/layer2.c, 2126: kzalloc in create_l2
drivers/isdn/mISDN/tei.c, 1054: create_l2 in create_teimgr
drivers/isdn/mISDN/tei.c, 1278: create_teimgr in mgr_ctrl
drivers/isdn/mISDN/tei.c, 1048: [FUNC_PTR]mgr_ctrl in create_teimgr
drivers/isdn/mISDN/tei.c, 1045: _raw_read_lock_irqsave in create_teimgr

Note that [FUNC_PTR] means a function pointer call is used.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/mISDN/layer2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/mISDN/layer2.c b/drivers/isdn/mISDN/layer2.c
index 9ff0903a0e89..383f31ae4b92 100644
--- a/drivers/isdn/mISDN/layer2.c
+++ b/drivers/isdn/mISDN/layer2.c
@@ -2123,7 +2123,7 @@ create_l2(struct mISDNchannel *ch, u_int protocol, u_long options, int tei,
 	struct layer2		*l2;
 	struct channel_req	rq;
 
-	l2 = kzalloc(sizeof(struct layer2), GFP_KERNEL);
+	l2 = kzalloc(sizeof(struct layer2), GFP_ATOMIC);
 	if (!l2) {
 		printk(KERN_ERR "kzalloc layer2 failed\n");
 		return NULL;
-- 
2.17.0

