Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF65C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86242075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86242075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJIORW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:17:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:17:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9971PJ2935374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 00:01:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9971Pgu935371;
        Tue, 9 Oct 2018 00:01:25 -0700
Date:   Tue, 9 Oct 2018 00:01:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-e054637597ba36d3729ba6a3a3dd7aad8e2a3003@git.kernel.org>
Cc:     mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, linux-mm@kvack.org,
        riel@surriel.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com,
        srikar@linux.vnet.ibm.com
Reply-To: peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
          riel@surriel.com, linux-mm@kvack.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          srikar@linux.vnet.ibm.com, hpa@zytor.com
In-Reply-To: <1538824999-31230-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1538824999-31230-1-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] mm, sched/numa: Remove remaining traces of NUMA
 rate-limiting
Git-Commit-ID: e054637597ba36d3729ba6a3a3dd7aad8e2a3003
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

Commit-ID:  e054637597ba36d3729ba6a3a3dd7aad8e2a3003
Gitweb:     https://git.kernel.org/tip/e054637597ba36d3729ba6a3a3dd7aad8e2a3003
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Sat, 6 Oct 2018 16:53:19 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Oct 2018 08:30:51 +0200

mm, sched/numa: Remove remaining traces of NUMA rate-limiting

Remove the leftover pglist_data::numabalancing_migrate_lock and its
initialization, we stopped using this lock with:

  efaffc5e40ae ("mm, sched/numa: Remove rate-limiting of automatic NUMA balancing migration")

[ mingo: Rewrote the changelog. ]

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-MM <linux-mm@kvack.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1538824999-31230-1-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/mmzone.h |  4 ----
 mm/page_alloc.c        | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3f4c0b167333..d4b0c79d2924 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -667,10 +667,6 @@ typedef struct pglist_data {
 	enum zone_type kcompactd_classzone_idx;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
-#endif
-#ifdef CONFIG_NUMA_BALANCING
-	/* Lock serializing the migrate rate limiting window */
-	spinlock_t numabalancing_migrate_lock;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 706a738c0aee..e2ef1c17942f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6193,15 +6193,6 @@ static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
 	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
 }
 
-#ifdef CONFIG_NUMA_BALANCING
-static void pgdat_init_numabalancing(struct pglist_data *pgdat)
-{
-	spin_lock_init(&pgdat->numabalancing_migrate_lock);
-}
-#else
-static void pgdat_init_numabalancing(struct pglist_data *pgdat) {}
-#endif
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pgdat_init_split_queue(struct pglist_data *pgdat)
 {
@@ -6226,7 +6217,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 {
 	pgdat_resize_init(pgdat);
 
-	pgdat_init_numabalancing(pgdat);
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
 
