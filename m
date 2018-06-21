Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4B20020
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C4B20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbeFUK2u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:28:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeFUK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:28:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5LASUNh3847695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Jun 2018 03:28:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5LASU3v3847692;
        Thu, 21 Jun 2018 03:28:30 -0700
Date:   Thu, 21 Jun 2018 03:28:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-a449a5325528c1ef2c5efae0fa422bf1c4a270e6@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, reinette.chatre@intel.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, reinette.chatre@intel.com,
          tglx@linutronix.de
In-Reply-To: <5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com>
References: <5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Simplify index type
Git-Commit-ID: a449a5325528c1ef2c5efae0fa422bf1c4a270e6
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

Commit-ID:  a449a5325528c1ef2c5efae0fa422bf1c4a270e6
Gitweb:     https://git.kernel.org/tip/a449a5325528c1ef2c5efae0fa422bf1c4a270e6
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Tue, 19 Jun 2018 23:19:27 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 21 Jun 2018 11:21:35 +0200

x86/intel_rdt: Simplify index type

Simplify this pattern:

 #ifdef CONFIG_X86_64
	u64 i;
 #else
	u32 i;
 #endif

... to the more natural and shorter one:

	unsigned long i;

No change in functionality.

Acked-by Thomas Gleixner <tglx@linutronix.de>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: fenghua.yu@intel.com
Cc: hpa@zytor.com
Cc: tony.luck@intel.com
Fixes: 0438fb1aebf4 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
Link: https://lkml.kernel.org/r/5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index a1670e50d6ce..df68972d5e3e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -415,11 +415,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	struct rdtgroup *rdtgrp = _rdtgrp;
 	struct pseudo_lock_region *plr = rdtgrp->plr;
 	u32 rmid_p, closid_p;
-#ifdef CONFIG_X86_64
-	u64 i;
-#else
-	u32 i;
-#endif
+	unsigned long i;
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
@@ -874,11 +870,7 @@ static int measure_cycles_lat_fn(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	u64 start, end;
-#ifdef CONFIG_X86_64
-	u64 i;
-#else
-	u32 i;
-#endif
+	unsigned long i;
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
@@ -932,11 +924,7 @@ static int measure_cycles_perf_fn(void *_plr)
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long long l2_hits, l2_miss;
 	u64 l2_hit_bits, l2_miss_bits;
-#ifdef CONFIG_X86_64
-	u64 i;
-#else
-	u32 i;
-#endif
+	unsigned long i;
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
