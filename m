Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A148E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A148E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIJRdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:33:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:33:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ACcZug1846566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 05:38:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ACcZmh1846563;
        Mon, 10 Sep 2018 05:38:35 -0700
Date:   Mon, 10 Sep 2018 05:38:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ben Hutchings <tipbot@zytor.com>
Message-ID: <tip-dc5591a03f1d6dae6b11cdf1d74b023f7ac0fdbf@git.kernel.org>
Cc:     alexander.levin@verizon.com, ben@decadent.org.uk,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        joel@joelfernandes.org, rostedt@goodmis.org, will.deacon@arm.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org, will.deacon@arm.com,
          rostedt@goodmis.org, ben@decadent.org.uk,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          joel@joelfernandes.org, alexander.levin@verizon.com
In-Reply-To: <20180828203315.GD18030@decadent.org.uk>
References: <20180828203315.GD18030@decadent.org.uk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/lockdep: Delete unnecessary #include
Git-Commit-ID: dc5591a03f1d6dae6b11cdf1d74b023f7ac0fdbf
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

Commit-ID:  dc5591a03f1d6dae6b11cdf1d74b023f7ac0fdbf
Gitweb:     https://git.kernel.org/tip/dc5591a03f1d6dae6b11cdf1d74b023f7ac0fdbf
Author:     Ben Hutchings <ben@decadent.org.uk>
AuthorDate: Tue, 28 Aug 2018 21:33:15 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 13:48:25 +0200

locking/lockdep: Delete unnecessary #include

Commit:

  c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")

added the inclusion of <trace/events/preemptirq.h>.

liblockdep doesn't have a stub version of that header so now fails to build.

However, commit:

  bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize preemptirq tracepoints and unify their usage"")

removed the use of functions declared in that header. So delete the #include.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <alexander.levin@verizon.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize ...")
Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints ...")
Link: http://lkml.kernel.org/r/20180828203315.GD18030@decadent.org.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..dd13f865ad40 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,7 +55,6 @@
 
 #include "lockdep_internals.h"
 
-#include <trace/events/preemptirq.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/lock.h>
 
