Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F5320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeGYPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:38:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeGYPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:38:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEQT7P402149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:26:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEQTh3402146;
        Wed, 25 Jul 2018 07:26:29 -0700
Date:   Wed, 25 Jul 2018 07:26:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-67d9f6c256cd66e15f85c92670f52a7ad4689cff@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        riel@surriel.com, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org,
          srikar@linux.vnet.ibm.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, riel@surriel.com, hpa@zytor.com
In-Reply-To: <1529514181-9842-7-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-7-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Reverse the order of printing faults
Git-Commit-ID: 67d9f6c256cd66e15f85c92670f52a7ad4689cff
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

Commit-ID:  67d9f6c256cd66e15f85c92670f52a7ad4689cff
Gitweb:     https://git.kernel.org/tip/67d9f6c256cd66e15f85c92670f52a7ad4689cff
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:47 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:07 +0200

sched/debug: Reverse the order of printing faults

Fix the order in which the private and shared numa faults are getting
printed.

No functional changes.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25215.7     25375.3     0.63
1     72107       72617       0.70

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-7-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c96e89cc4bc7..870d4f3da285 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -842,8 +842,8 @@ void print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 		unsigned long tpf, unsigned long gsf, unsigned long gpf)
 {
 	SEQ_printf(m, "numa_faults node=%d ", node);
-	SEQ_printf(m, "task_private=%lu task_shared=%lu ", tsf, tpf);
-	SEQ_printf(m, "group_private=%lu group_shared=%lu\n", gsf, gpf);
+	SEQ_printf(m, "task_private=%lu task_shared=%lu ", tpf, tsf);
+	SEQ_printf(m, "group_private=%lu group_shared=%lu\n", gpf, gsf);
 }
 #endif
 
