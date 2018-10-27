Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 03:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E53A2082B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 03:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJTj2uzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E53A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeJ0LpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 07:45:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42603 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJ0LpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 07:45:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so1305093plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 20:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7tP0R3+lL6Cs3V3JwrNwgGApMEt4w+/POjXDuxjCN1k=;
        b=KJTj2uzQP0+soyBm++INZw6pYYfLD+TYpG88L7br0vNma8MqAdYAHD5Wb7qzMLlPbZ
         ipMu4TgbG642rjeqQ9tsUQXLqWZPPzrSbKucJjP2I9JDgOHVMXto5lKacBXIt0mUUP47
         3Hl9QkN7jhVSWSxNe+N5Sl0TlOcEtYRaZZbrxY18OOAbpgwUtz6swvOVv2dc2QpuSrAl
         fRRR+smBCG+Rc9HiBTAGSrdr28jKWmOq/iTUSXyM5CsTBSSDX1QK5eoueA/ErEXIbQtb
         xpJkM5CjjIlfgwG1ZcZNkKXaagcAWwrcVDjHqH13UN/zHePbaZMWKi9O6PgdRJaC6G/R
         5prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7tP0R3+lL6Cs3V3JwrNwgGApMEt4w+/POjXDuxjCN1k=;
        b=uBoo1tFwiJ1EeTyD31HsLqAG+hXUMg2PW2QbK1chh+0qEd1YvPDM64aVb+rIOvWZPV
         3cNDQleMHJT8LIwtp1CO9cDuDC9NP+jtRv04DNXb4op6ISugpNDH5WlcsIR7U2pcXDpu
         zo7JRxHRr17OIIA7sVZ78UVcekOcn3OyzMxz1bZznja+Ew7hbHNGFUyQrLCwk4kvoxRy
         J5PBVM29QkR7D2xaBjOPE0Nci4EmLu0Msr4+lk+hHXwAUACiXVAHIr0DqNNX7OsolvX6
         WWgZ7hD1fluSxiIFU3hFks0V1Qhujudq7ld8MTyFNRvSTnBH3ZQSJfgTFNoBnpZPer7m
         ivdQ==
X-Gm-Message-State: AGRZ1gJNm5oAaom0p4x1i0R9HtfJINbvZ5PWocsyJJD1A3xwjLP7hryq
        fvhkvUkBNGixC00eWeGkbck=
X-Google-Smtp-Source: AJdET5f8yyFsNkifCpz5dxbz5h9yaspo2wziZacRZxaUooH66A+eFru3VY3C/tkX/HC88jK4kJVJtA==
X-Received: by 2002:a17:902:f097:: with SMTP id go23mr5813248plb.328.1540609534009;
        Fri, 26 Oct 2018 20:05:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id n79-v6sm20988784pfk.19.2018.10.26.20.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 20:05:33 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Fix a comment in pick_next_task_rt()
Date:   Sat, 27 Oct 2018 11:05:17 +0800
Message-Id: <20181027030517.23292-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f4ebcbc0d7e0 ("sched/rt: Substract number of tasks of throttled
queues from rq->nr_running") added a new member rt_rq->rt_queued, which
is used to indicate the status of rq->rt enqueue or dequeue. So, the
check rt_nr_running was removed and we now check rt_queued.

Fix the comment in pick_next_task_rt() to avoid confusing.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..a21ea6021929 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1561,7 +1561,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/*
 	 * We may dequeue prev's rt_rq in put_prev_task().
-	 * So, we update time before rt_nr_running check.
+	 * So, we update time before rt_queued check.
 	 */
 	if (prev->sched_class == &rt_sched_class)
 		update_curr_rt(rq);
-- 
2.17.1

