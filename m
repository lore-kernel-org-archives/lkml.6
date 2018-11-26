Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4711C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC4020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV/iBa8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC4020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeK0GWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:22:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37323 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeK0GWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:22:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so7073202pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MzI81NucccUaVHbOJ5j62L7rs16WmtIUiqI4Shyr+bU=;
        b=LV/iBa8THj8abHueO9Bb2Y7dOb62jjdQm4gEOMjGy0Ek2ZRZGM0ZgJqMm7wGL6WV0K
         hDA5BpOn38VHwdIxAqvqBCltRDu67bz6/nZDosLFz0vUyKT6m3McHSqDp4d6dxY/awgG
         6eaQ4odXi3w9DxSPOjitdcQfQ8ctfH67gNLvbHeTkvw1DxXafE0A/Ay6IYoRT5Qb1btk
         nU7PA3hijHNxybV7SvaH9YB2do01c+FNujk0bQiU1S3yhH1HPgKxsJKtn7MrxuY38Hxp
         1g5NYroQ2VbQMV7UEX3VoPaakTz6VzIHYRfg9k95H1BaH6C/ZirGN4+WL8TgmzCioHDi
         wG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MzI81NucccUaVHbOJ5j62L7rs16WmtIUiqI4Shyr+bU=;
        b=H1YL0edHgHhwCOSM4EdxpR6+qYX46WVI/lA5jJkna5PykHO/JAeCsAeto1p4jubEgQ
         LYnGJRq8QzrAPglbxy4unmH9vdZA8R9ncn5MvP1ucjPdkEbocZYFshTUsmlEfHeedlDH
         8WP5851732fCbIngzR7yyuUbQE7K9ZOmH9pivS5VXGt93YKuiNE5RfFPdh+YK/Le689W
         7wlCl9eObephbX1+F1TSepC2O24nvu0pnb/bOP1/Eqd4uZHheU52cXUfydkje02ISf9L
         0Q3Q9O5VHzUKCf4YBU/y6wqOQ/u+i3Hd2kR8lroa/curNQBMWCNE9pTWRCrzuomHZ/Uf
         YNJQ==
X-Gm-Message-State: AA+aEWad2C68StWEsPgVI3HIvuf1hcuLsFdniZQBF1TTdkEz6AdxHT+h
        zbrpUn4LNuqSMyJHaNNC5QKIxg==
X-Google-Smtp-Source: AFSGD/U+YmPUUztC8MDN9rORkoKRP9GLZ57EmM+7w/LKgBUKlRtS0xIsEvdex/y1hhnuuO+lpThPfA==
X-Received: by 2002:a63:d157:: with SMTP id c23mr25951753pgj.170.1543260436810;
        Mon, 26 Nov 2018 11:27:16 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id 34sm2349919pgp.90.2018.11.26.11.27.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 11:27:16 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:27:07 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
In-Reply-To: <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils> <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com> <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting on a page migration entry has used wait_on_page_locked() all
along since 2006: but you cannot safely wait_on_page_locked() without
holding a reference to the page, and that extra reference is enough to
make migrate_page_move_mapping() fail with -EAGAIN, when a racing task
faults on the entry before migrate_page_move_mapping() gets there.

And that failure is retried nine times, amplifying the pain when
trying to migrate a popular page.  With a single persistent faulter,
migration sometimes succeeds; with two or three concurrent faulters,
success becomes much less likely (and the more the page was mapped,
the worse the overhead of unmapping and remapping it on each try).

This is especially a problem for memory offlining, where the outer
level retries forever (or until terminated from userspace), because
a heavy refault workload can trigger an endless loop of migration
failures.  wait_on_page_locked() is the wrong tool for the job.

David Herrmann (but was he the first?) noticed this issue in 2014:
https://marc.info/?l=linux-mm&m=140110465608116&w=2

Tim Chen started a thread in August 2017 which appears relevant:
https://marc.info/?l=linux-mm&m=150275941014915&w=2
where Kan Liang went on to implicate __migration_entry_wait():
https://marc.info/?l=linux-mm&m=150300268411980&w=2
and the thread ended up with the v4.14 commits:
2554db916586 ("sched/wait: Break up long wake list walk")
11a19c7b099f ("sched/wait: Introduce wakeup boomark in wake_up_page_bit")

Baoquan He reported "Memory hotplug softlock issue" 14 November 2018:
https://marc.info/?l=linux-mm&m=154217936431300&w=2

We have all assumed that it is essential to hold a page reference while
waiting on a page lock: partly to guarantee that there is still a struct
page when MEMORY_HOTREMOVE is configured, but also to protect against
reuse of the struct page going to someone who then holds the page locked
indefinitely, when the waiter can reasonably expect timely unlocking.

But in fact, so long as wait_on_page_bit_common() does the put_page(),
and is careful not to rely on struct page contents thereafter, there is
no need to hold a reference to the page while waiting on it.  That does
mean that this case cannot go back through the loop: but that's fine for
the page migration case, and even if used more widely, is limited by the
"Stop walking if it's locked" optimization in wake_page_function().

Add interface put_and_wait_on_page_locked() to do this, using "behavior"
enum in place of "lock" arg to wait_on_page_bit_common() to implement it.
No interruptible or killable variant needed yet, but they might follow:
I have a vague notion that reporting -EINTR should take precedence over
return from wait_on_page_bit_common() without knowing the page state,
so arrange it accordingly - but that may be nothing but pedantic.

__migration_entry_wait() still has to take a brief reference to the
page, prior to calling put_and_wait_on_page_locked(): but now that it
is dropped before waiting, the chance of impeding page migration is
very much reduced.  Should we perhaps disable preemption across this?

shrink_page_list()'s __ClearPageLocked(): that was a surprise!  This
survived a lot of testing before that showed up.  PageWaiters may have
been set by wait_on_page_bit_common(), and the reference dropped, just
before shrink_page_list() succeeds in freezing its last page reference:
in such a case, unlock_page() must be used.  Follow the suggestion from
Michal Hocko, just revert a978d6f52106 ("mm: unlockless reclaim") now:
that optimization predates PageWaiters, and won't buy much these days;
but we can reinstate it for the !PageWaiters case if anyone notices.

It does raise the question: should vmscan.c's is_page_cache_freeable()
and __remove_mapping() now treat a PageWaiters page as if an extra
reference were held?  Perhaps, but I don't think it matters much, since
shrink_page_list() already had to win its trylock_page(), so waiters are
not very common there: I noticed no difference when trying the bigger
change, and it's surely not needed while put_and_wait_on_page_locked()
is only used for page migration.

Reported-and-tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 77 ++++++++++++++++++++++++++++++++++-------
 mm/huge_memory.c        |  6 ++--
 mm/migrate.c            | 12 +++----
 mm/vmscan.c             | 10 ++----
 5 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 226f96f0dee0..e2d7039af6a3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -537,6 +537,8 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return wait_on_page_bit_killable(compound_head(page), PG_locked);
 }
 
+extern void put_and_wait_on_page_locked(struct page *page);
+
 /* 
  * Wait for a page to complete writeback
  */
diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8ee02c..575e16c037ca 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -981,7 +981,14 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	if (wait_page->bit_nr != key->bit_nr)
 		return 0;
 
-	/* Stop walking if it's locked */
+	/*
+	 * Stop walking if it's locked.
+	 * Is this safe if put_and_wait_on_page_locked() is in use?
+	 * Yes: the waker must hold a reference to this page, and if PG_locked
+	 * has now already been set by another task, that task must also hold
+	 * a reference to the *same usage* of this page; so there is no need
+	 * to walk on to wake even the put_and_wait_on_page_locked() callers.
+	 */
 	if (test_bit(key->bit_nr, &key->page->flags))
 		return -1;
 
@@ -1049,25 +1056,44 @@ static void wake_up_page(struct page *page, int bit)
 	wake_up_page_bit(page, bit);
 }
 
+/*
+ * A choice of three behaviors for wait_on_page_bit_common():
+ */
+enum behavior {
+	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
+			 * __lock_page() waiting on then setting PG_locked.
+			 */
+	SHARED,		/* Hold ref to page and check the bit when woken, like
+			 * wait_on_page_writeback() waiting on PG_writeback.
+			 */
+	DROP,		/* Drop ref to page before wait, no check when woken,
+			 * like put_and_wait_on_page_locked() on PG_locked.
+			 */
+};
+
 static inline int wait_on_page_bit_common(wait_queue_head_t *q,
-		struct page *page, int bit_nr, int state, bool lock)
+	struct page *page, int bit_nr, int state, enum behavior behavior)
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
+	bool bit_is_set;
 	bool thrashing = false;
+	bool delayacct = false;
 	unsigned long pflags;
 	int ret = 0;
 
 	if (bit_nr == PG_locked &&
 	    !PageUptodate(page) && PageWorkingset(page)) {
-		if (!PageSwapBacked(page))
+		if (!PageSwapBacked(page)) {
 			delayacct_thrashing_start();
+			delayacct = true;
+		}
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
 
 	init_wait(wait);
-	wait->flags = lock ? WQ_FLAG_EXCLUSIVE : 0;
+	wait->flags = behavior == EXCLUSIVE ? WQ_FLAG_EXCLUSIVE : 0;
 	wait->func = wake_page_function;
 	wait_page.page = page;
 	wait_page.bit_nr = bit_nr;
@@ -1084,14 +1110,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 		spin_unlock_irq(&q->lock);
 
-		if (likely(test_bit(bit_nr, &page->flags))) {
+		bit_is_set = test_bit(bit_nr, &page->flags);
+		if (behavior == DROP)
+			put_page(page);
+
+		if (likely(bit_is_set))
 			io_schedule();
-		}
 
-		if (lock) {
+		if (behavior == EXCLUSIVE) {
 			if (!test_and_set_bit_lock(bit_nr, &page->flags))
 				break;
-		} else {
+		} else if (behavior == SHARED) {
 			if (!test_bit(bit_nr, &page->flags))
 				break;
 		}
@@ -1100,12 +1129,23 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 			ret = -EINTR;
 			break;
 		}
+
+		if (behavior == DROP) {
+			/*
+			 * We can no longer safely access page->flags:
+			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
+			 * there is a risk of waiting forever on a page reused
+			 * for something that keeps it locked indefinitely.
+			 * But best check for -EINTR above before breaking.
+			 */
+			break;
+		}
 	}
 
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		if (!PageSwapBacked(page))
+		if (delayacct)
 			delayacct_thrashing_end();
 		psi_memstall_leave(&pflags);
 	}
@@ -1124,17 +1164,26 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 void wait_on_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, bit_nr, TASK_UNINTERRUPTIBLE, false);
+	wait_on_page_bit_common(q, page, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
 }
 EXPORT_SYMBOL(wait_on_page_bit);
 
 int wait_on_page_bit_killable(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, bit_nr, TASK_KILLABLE, false);
+	return wait_on_page_bit_common(q, page, bit_nr, TASK_KILLABLE, SHARED);
 }
 EXPORT_SYMBOL(wait_on_page_bit_killable);
 
+void put_and_wait_on_page_locked(struct page *page)
+{
+	wait_queue_head_t *q;
+
+	page = compound_head(page);
+	q = page_waitqueue(page);
+	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE, DROP);
+}
+
 /**
  * add_page_wait_queue - Add an arbitrary waiter to a page's wait queue
  * @page: Page defining the wait queue of interest
@@ -1264,7 +1313,8 @@ void __lock_page(struct page *__page)
 {
 	struct page *page = compound_head(__page);
 	wait_queue_head_t *q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE, true);
+	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE,
+				EXCLUSIVE);
 }
 EXPORT_SYMBOL(__lock_page);
 
@@ -1272,7 +1322,8 @@ int __lock_page_killable(struct page *__page)
 {
 	struct page *page = compound_head(__page);
 	wait_queue_head_t *q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, PG_locked, TASK_KILLABLE, true);
+	return wait_on_page_bit_common(q, page, PG_locked, TASK_KILLABLE,
+					EXCLUSIVE);
 }
 EXPORT_SYMBOL_GPL(__lock_page_killable);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 622cced74fd9..832ab11badc2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1501,8 +1501,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		wait_on_page_locked(page);
-		put_page(page);
+		put_and_wait_on_page_locked(page);
 		goto out;
 	}
 
@@ -1538,8 +1537,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		if (!get_page_unless_zero(page))
 			goto out_unlock;
 		spin_unlock(vmf->ptl);
-		wait_on_page_locked(page);
-		put_page(page);
+		put_and_wait_on_page_locked(page);
 		goto out;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index f7e4bfdc13b7..acda06f99754 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -327,16 +327,13 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 
 	/*
 	 * Once page cache replacement of page migration started, page_count
-	 * *must* be zero. And, we don't want to call wait_on_page_locked()
-	 * against a page without get_page().
-	 * So, we use get_page_unless_zero(), here. Even failed, page fault
-	 * will occur again.
+	 * is zero; but we must not call put_and_wait_on_page_locked() without
+	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
 	 */
 	if (!get_page_unless_zero(page))
 		goto out;
 	pte_unmap_unlock(ptep, ptl);
-	wait_on_page_locked(page);
-	put_page(page);
+	put_and_wait_on_page_locked(page);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -370,8 +367,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	if (!get_page_unless_zero(page))
 		goto unlock;
 	spin_unlock(ptl);
-	wait_on_page_locked(page);
-	put_page(page);
+	put_and_wait_on_page_locked(page);
 	return;
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 62ac0c488624..9c50d90b9bc5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1456,14 +1456,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			count_memcg_page_event(page, PGLAZYFREED);
 		} else if (!mapping || !__remove_mapping(mapping, page, true))
 			goto keep_locked;
-		/*
-		 * At this point, we have no other references and there is
-		 * no way to pick any more up (removed from LRU, removed
-		 * from pagecache). Can use non-atomic bitops now (and
-		 * we obviously don't have to worry about waking up a process
-		 * waiting on the page lock, because there are no references.
-		 */
-		__ClearPageLocked(page);
+
+		unlock_page(page);
 free_it:
 		nr_reclaimed++;
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
