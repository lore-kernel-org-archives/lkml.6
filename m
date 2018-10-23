Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3FDC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4B620671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4B620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJWPBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:01:40 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56902 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbeJWPBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:01:39 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 00ADCC9EF1447FCE2E0A;
        Tue, 23 Oct 2018 14:39:35 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9N6dPc2099503;
        Tue, 23 Oct 2018 14:39:25 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018102314393869-6202755 ;
          Tue, 23 Oct 2018 14:39:38 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] sched/fair: fix a comment in task_numa_fault()
Date:   Tue, 23 Oct 2018 14:40:40 +0800
Message-Id: <1540276840-43841-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-23 14:39:38,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-23 14:39:21,
        Serialize complete at 2018-10-23 14:39:21
X-MAIL: mse01.zte.com.cn w9N6dPc2099503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment in task_numa_fault() to avoid confusing.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Xi Xu <xu.xi8@zte.com.cn>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 908c9cd..6430c0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2422,8 +2422,8 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 		local = 1;
 
 	/*
-	 * Retry task to preferred node migration periodically, in case it
-	 * case it previously failed, or the scheduler moved us.
+	 * Retry to migrate task to preferred node periodically, in case it
+	 * previously failed, or the scheduler moved us.
 	 */
 	if (time_after(jiffies, p->numa_migrate_retry)) {
 		task_numa_placement(p);
-- 
1.8.3.1

