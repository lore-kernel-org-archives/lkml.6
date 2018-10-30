Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444872075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyTfcAQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444872075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJ3Xjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:39:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45544 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJ3Xjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:39:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id v5-v6so1044452pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pjgxNZM2WE2d3ONPl/GeCY4/NIOvaMxXAvrJVd5+Azk=;
        b=VyTfcAQFCkWEDRFn7l+mv4oQuBveV6lGiicpiPrF8IeCJw+QimVLTyPTEyiggibU3t
         4qUXqGqc39ypFtbUZNy+0H+yTEkEM0I8tS909IlcK4UcLdA7u4MRDgdtZIoV91x3nUA9
         l8imL2j3CIYQ18Qcfvaxu2/unCDtXQgAfAd36EpP2caoWY2Cffos4RydRYe8LlhgZeYp
         bCzIE8PkDhOlo0tq7CoECQbZdQOJ655KlhCNL9Zn9jjV7F/RIt//L7+13M+IDLG3DKmh
         BcBeSDQ1slJow61BXnzNlBNqf8DyJsRXZXlXIjhoBNASDC9Ez9CognvxFCG9Ro/xgqTZ
         Cdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pjgxNZM2WE2d3ONPl/GeCY4/NIOvaMxXAvrJVd5+Azk=;
        b=JjZUFjIPjYig6iUw8snxbCy20X3CutRsqCGeTyy+acO+sRkIUIxc/B6172/CbuOwZh
         kGOMuantEIAuOfAhV9fhMPohQMlE0sBIwWNuHrvFWevGs49FOZv5P8htDjdkcFnMQDzC
         Wa3DtrDx+o5dIrC9dEOg5dLJIwyn/ztxLeh4TANFz5S+vc/eONQc/+4OsYiogKPxDs2p
         iGJDvHq/wlvod2C3FO0KUWhTsNjAWselk0MheN+byNln1qowXblIyIc6Sp5AsGMhqGxd
         mICesPJE+Bg1Uybu+WnbklHOwFf4j+Jkf69ttusB4xZ3X3hIHk7St24uf6GiBIFYL2fg
         37lg==
X-Gm-Message-State: AGRZ1gJQy3iCBPnm4SPn0voq8UWi1IHzsvaskXu9TQXj5EVSYnIL4U73
        frWcPsvQ0n7PDPj+WY+arpk=
X-Google-Smtp-Source: AJdET5f2a96Ux3PvntGSJbeLQn3D9bEWe7a2NlAwgday+bn97CazEZWszYVuetEB8Rm82BWQrICnUg==
X-Received: by 2002:a63:1157:: with SMTP id 23mr18446603pgr.245.1540910747742;
        Tue, 30 Oct 2018 07:45:47 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id q2-v6sm26055490pgk.4.2018.10.30.07.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:45:46 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Remove unnecessary CONFIG_RT_GROUP_SCHED in rt_se_prio()
Date:   Tue, 30 Oct 2018 22:45:30 +0800
Message-Id: <20181030144530.89995-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RT_GROUP_SCHED is not configured, group_rt_rq() will
return NULL. With this patch applied, we also can get the same result.
Because the compiler will help us optimize the code.

So, we can remove unnecessary CONFIG_RT_GROUP_SCHED in rt_se_prio().

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a21ea6021929..47b4800761db 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -894,12 +894,10 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	struct rt_rq *rt_rq = group_rt_rq(rt_se);
 
 	if (rt_rq)
 		return rt_rq->highest_prio.curr;
-#endif
 
 	return rt_task_of(rt_se)->prio;
 }
-- 
2.17.1

