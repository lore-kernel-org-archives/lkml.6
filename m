Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE52C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC6C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJDQ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:57:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39845 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeJDQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:57:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94A4jSo2703519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 03:04:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94A4jiu2703516;
        Thu, 4 Oct 2018 03:04:45 -0700
Date:   Thu, 4 Oct 2018 03:04:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Rafael J. Wysocki" <tipbot@zytor.com>
Message-ID: <tip-9c2298aad355d8c1957df3015448fef333526934@git.kernel.org>
Cc:     rafael.j.wysocki@intel.com, tj@kernel.org,
        linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
Reply-To: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
          tj@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <3803514.xkx7zY50tF@aspire.rjw.lan>
References: <3803514.xkx7zY50tF@aspire.rjw.lan>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Fix comment regarding nr_iowait_cpu()
 and get_iowait_load()
Git-Commit-ID: 9c2298aad355d8c1957df3015448fef333526934
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

Commit-ID:  9c2298aad355d8c1957df3015448fef333526934
Gitweb:     https://git.kernel.org/tip/9c2298aad355d8c1957df3015448fef333526934
Author:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate: Thu, 4 Oct 2018 11:05:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 4 Oct 2018 11:25:56 +0200

sched/core: Fix comment regarding nr_iowait_cpu() and get_iowait_load()

The comment related to nr_iowait_cpu() and get_iowait_load() confuses
cpufreq with cpuidle and is not very useful for this reason, so fix it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: e33a9bba85a8 "sched/core: move IO scheduling accounting from io_schedule_timeout() into scheduler"
Link: http://lkml.kernel.org/r/3803514.xkx7zY50tF@aspire.rjw.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 56b3c1781276..fe0223121883 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2916,10 +2916,10 @@ unsigned long nr_iowait(void)
 }
 
 /*
- * Consumers of these two interfaces, like for example the cpufreq menu
- * governor are using nonsensical data. Boosting frequency for a CPU that has
- * IO-wait which might not even end up running the task when it does become
- * runnable.
+ * Consumers of these two interfaces, like for example the cpuidle menu
+ * governor, are using nonsensical data. Preferring shallow idle state selection
+ * for a CPU that has IO-wait which might not even end up running the task when
+ * it does become runnable.
  */
 
 unsigned long nr_iowait_cpu(int cpu)
