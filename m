Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6FB204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6FB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeKEPZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:25:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeKEPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:25:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA566prn217386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Nov 2018 22:06:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA566om0217383;
        Sun, 4 Nov 2018 22:06:50 -0800
Date:   Sun, 4 Nov 2018 22:06:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-e1ff516a56ad56c476b47795d3811eef79d25fbe@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        xu.xi8@zte.com.cn, tglx@linutronix.de, wang.yi59@zte.com.cn
Reply-To: tglx@linutronix.de, wang.yi59@zte.com.cn, xu.xi8@zte.com.cn,
          hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1541379013-11352-1-git-send-email-wang.yi59@zte.com.cn>
References: <1541379013-11352-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Fix a comment in task_numa_fault()
Git-Commit-ID: e1ff516a56ad56c476b47795d3811eef79d25fbe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e1ff516a56ad56c476b47795d3811eef79d25fbe
Gitweb:     https://git.kernel.org/tip/e1ff516a56ad56c476b47795d3811eef79d25fbe
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Mon, 5 Nov 2018 08:50:13 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Nov 2018 07:03:59 +0100

sched/fair: Fix a comment in task_numa_fault()

Duplicated 'case it'.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Xi Xu <xu.xi8@zte.com.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/1541379013-11352-1-git-send-email-wang.yi59@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb661cc..3648d0300fdf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2400,8 +2400,8 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 		local = 1;
 
 	/*
-	 * Retry task to preferred node migration periodically, in case it
-	 * case it previously failed, or the scheduler moved us.
+	 * Retry to migrate task to preferred node periodically, in case it
+	 * previously failed, or the scheduler moved us.
 	 */
 	if (time_after(jiffies, p->numa_migrate_retry)) {
 		task_numa_placement(p);
