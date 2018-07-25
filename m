Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1D120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1D120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeGYPgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:36:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54887 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeGYPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:36:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PENmNn400345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:23:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PENmGm400342;
        Wed, 25 Jul 2018 07:23:48 -0700
Date:   Wed, 25 Jul 2018 07:23:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-6e30396767508101eacec8b93b068e8905e660dc@git.kernel.org>
Cc:     riel@surriel.com, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: riel@surriel.com, mingo@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          srikar@linux.vnet.ibm.com, mgorman@techsingularity.net
In-Reply-To: <1529514181-9842-2-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-2-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Remove redundant field
Git-Commit-ID: 6e30396767508101eacec8b93b068e8905e660dc
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

Commit-ID:  6e30396767508101eacec8b93b068e8905e660dc
Gitweb:     https://git.kernel.org/tip/6e30396767508101eacec8b93b068e8905e660dc
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:42 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:06 +0200

sched/numa: Remove redundant field

'numa_entry' is a struct list_head defined in task_struct, but never used.

No functional change.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-2-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 43731fe51c97..e0f4f56c9310 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1017,7 +1017,6 @@ struct task_struct {
 	u64				last_sum_exec_runtime;
 	struct callback_head		numa_work;
 
-	struct list_head		numa_entry;
 	struct numa_group		*numa_group;
 
 	/*
