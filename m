Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A020C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7AA21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7AA21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbeKLP5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:57:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbeKLP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:57:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAC652pB3548638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Nov 2018 22:05:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAC652m53548635;
        Sun, 11 Nov 2018 22:05:02 -0800
Date:   Sun, 11 Nov 2018 22:05:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Muchun Song <tipbot@zytor.com>
Message-ID: <tip-ed8885a14433aec04067463493051eaaeef3255f@git.kernel.org>
Cc:     smuchun@gmail.com, torvalds@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, torvalds@linux-foundation.org, smuchun@gmail.com,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20181110075202.61172-1-smuchun@gmail.com>
References: <20181110075202.61172-1-smuchun@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Make some variables static
Git-Commit-ID: ed8885a14433aec04067463493051eaaeef3255f
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

Commit-ID:  ed8885a14433aec04067463493051eaaeef3255f
Gitweb:     https://git.kernel.org/tip/ed8885a14433aec04067463493051eaaeef3255f
Author:     Muchun Song <smuchun@gmail.com>
AuthorDate: Sat, 10 Nov 2018 15:52:02 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 06:18:15 +0100

sched/fair: Make some variables static

The variables are local to the source and do not
need to be in global scope, so make them static.

Signed-off-by: Muchun Song <smuchun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181110075202.61172-1-smuchun@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d1f91e6efe51..e30dea59d215 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -38,7 +38,7 @@
  * (default: 6ms * (1 + ilog(ncpus)), units: nanoseconds)
  */
 unsigned int sysctl_sched_latency			= 6000000ULL;
-unsigned int normalized_sysctl_sched_latency		= 6000000ULL;
+static unsigned int normalized_sysctl_sched_latency	= 6000000ULL;
 
 /*
  * The initial- and re-scaling of tunables is configurable
@@ -58,8 +58,8 @@ enum sched_tunable_scaling sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_L
  *
  * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_min_granularity		= 750000ULL;
-unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
+unsigned int sysctl_sched_min_granularity			= 750000ULL;
+static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
 
 /*
  * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
@@ -81,8 +81,8 @@ unsigned int sysctl_sched_child_runs_first __read_mostly;
  *
  * (default: 1 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_wakeup_granularity		= 1000000UL;
-unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
+unsigned int sysctl_sched_wakeup_granularity			= 1000000UL;
+static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
@@ -116,7 +116,7 @@ unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
  *
  * (default: ~20%)
  */
-unsigned int capacity_margin				= 1280;
+static unsigned int capacity_margin			= 1280;
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
