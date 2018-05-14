Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281067-2-4449258985392358832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281067; b=XNjIMvzlD7AGaGWLfDGcxvzr9sEpVQpYDJAats/7oDZy2YS36h
    2E46ha0WN9CYXXbeFSiPyqcOUmNirsYz/Y/9dBo1+6CW/DpO2B55Q0KVNfTUANdc
    wSX8eRQkinCW2XWU53Cq5aLkRnScy58/WBUDkz+purxRypGni+ZQ5o/tMefpYiCk
    dDH+hZSJEs+uDyZAkJVQy5y2NgHY9a7yfEy8RHc+GvRZq2vZgPcZ45HoY77KS0FW
    bIwleJzy7lrjCxNcmfhNIQ3rW6m+9O6DfYML3ib9QlSUVPejaDz3lI4M+QqD3lo3
    vVneZXATWigSltZYtNSgW3j6yoQrFFMn0sRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281067; bh=3i3sGmYt67pdGpb2iovEMbsoKKLuXr
    KK2JpgEXwN6wQ=; b=S4z4/jBPPXZDHl6AXWJZnbcUVZDI08WYHQ2JMizKxQh5LF
    Zw42FRZT/tV6TG9FS+SCwIeiBTkcO8iQiPqDC78+pELB3JtmyGZCfjnxVbI6UOIV
    XOhnIvDl8Isj1588Mz6Ie4iHegjl8X8H4lVqI+w6oFzIm31NydVLIRO6K2G3GAFU
    oPUv0wIoKPV7CWGHFMTPnpYr6I3ZSTy/L4ElySJExdt/WuD5rkB9FsIusBIzfWU7
    qQvSoxwIDINePY7Fx0YW1qTjuGYkdvcdGdQ0hukSBf0kgwO+yIzsvk77VFqmx6ln
    GWfR858ub+/7VTvpkoMBv5U2M5Om6DACO6XPtVJQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GBaZiLic x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=GBaZiLic x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEdUDCZcxiZ5Xetwh6QhUqUf88GBZiEYqkNoFDNJLWATt1caunuR67Ne7Ly2xSPrMMlHQW+3Px/FBt3SOg8zucq9MLfB6RTdBU5Chn1YmfiqcnMJ5FVo
    crhqP6ykVARkbbwJBs4KSIXiq85h8pgCTWN2EyhSPIGfFKvydrNZZOEbodnGldrRiMLF/OV++b1Exj/GiQU7qgR0oYkt6uTnGD/X3IwrGCD3QdHxTAHRFHY7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8
    a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8 a=GGVBRzX_JipyLRjk0_4A:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=6oWmYt7CaPY7q_fQ:21 a=pLNYK92yk1B_08-v:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeENG5n (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753701AbeENG5l (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:57:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 32/62] mm, oom: fix concurrent munlock and oom reaper unmap, v3
Date: Mon, 14 May 2018 08:48:48 +0200
Message-Id: <20180514064818.131463728@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>

commit 27ae357fa82be5ab73b2ef8d39dcb8ca2563483a upstream.

Since exit_mmap() is done without the protection of mm->mmap_sem, it is
possible for the oom reaper to concurrently operate on an mm until
MMF_OOM_SKIP is set.

This allows munlock_vma_pages_all() to concurrently run while the oom
reaper is operating on a vma.  Since munlock_vma_pages_range() depends
on clearing VM_LOCKED from vm_flags before actually doing the munlock to
determine if any other vmas are locking the same memory, the check for
VM_LOCKED in the oom reaper is racy.

This is especially noticeable on architectures such as powerpc where
clearing a huge pmd requires serialize_against_pte_lookup().  If the pmd
is zapped by the oom reaper during follow_page_mask() after the check
for pmd_none() is bypassed, this ends up deferencing a NULL ptl or a
kernel oops.

Fix this by manually freeing all possible memory from the mm before
doing the munlock and then setting MMF_OOM_SKIP.  The oom reaper can not
run on the mm anymore so the munlock is safe to do in exit_mmap().  It
also matches the logic that the oom reaper currently uses for
determining when to set MMF_OOM_SKIP itself, so there's no new risk of
excessive oom killing.

This issue fixes CVE-2018-1000200.

Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1804241526320.238665@chino.kir.corp.google.com
Fixes: 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
Signed-off-by: David Rientjes <rientjes@google.com>
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>	[4.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/oom.h |    2 +
 mm/mmap.c           |   44 ++++++++++++++++++------------
 mm/oom_kill.c       |   74 ++++++++++++++++++++++++++++------------------------
 3 files changed, 68 insertions(+), 52 deletions(-)

--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -95,6 +95,8 @@ static inline int check_stable_address_s
 	return 0;
 }
 
+void __oom_reap_task_mm(struct mm_struct *mm);
+
 extern unsigned long oom_badness(struct task_struct *p,
 		struct mem_cgroup *memcg, const nodemask_t *nodemask,
 		unsigned long totalpages);
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2982,6 +2982,32 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
 
+	if (unlikely(mm_is_oom_victim(mm))) {
+		/*
+		 * Manually reap the mm to free as much memory as possible.
+		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
+		 * this mm from further consideration.  Taking mm->mmap_sem for
+		 * write after setting MMF_OOM_SKIP will guarantee that the oom
+		 * reaper will not run on this mm again after mmap_sem is
+		 * dropped.
+		 *
+		 * Nothing can be holding mm->mmap_sem here and the above call
+		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
+		 * __oom_reap_task_mm() will not block.
+		 *
+		 * This needs to be done before calling munlock_vma_pages_all(),
+		 * which clears VM_LOCKED, otherwise the oom reaper cannot
+		 * reliably test it.
+		 */
+		mutex_lock(&oom_lock);
+		__oom_reap_task_mm(mm);
+		mutex_unlock(&oom_lock);
+
+		set_bit(MMF_OOM_SKIP, &mm->flags);
+		down_write(&mm->mmap_sem);
+		up_write(&mm->mmap_sem);
+	}
+
 	if (mm->locked_vm) {
 		vma = mm->mmap;
 		while (vma) {
@@ -3003,24 +3029,6 @@ void exit_mmap(struct mm_struct *mm)
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
-
-	if (unlikely(mm_is_oom_victim(mm))) {
-		/*
-		 * Wait for oom_reap_task() to stop working on this
-		 * mm. Because MMF_OOM_SKIP is already set before
-		 * calling down_read(), oom_reap_task() will not run
-		 * on this "mm" post up_write().
-		 *
-		 * mm_is_oom_victim() cannot be set from under us
-		 * either because victim->mm is already set to NULL
-		 * under task_lock before calling mmput and oom_mm is
-		 * set not NULL by the OOM killer only if victim->mm
-		 * is found not NULL while holding the task_lock.
-		 */
-		set_bit(MMF_OOM_SKIP, &mm->flags);
-		down_write(&mm->mmap_sem);
-		up_write(&mm->mmap_sem);
-	}
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
 
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -456,7 +456,6 @@ bool process_shares_mm(struct task_struc
 	return false;
 }
 
-
 #ifdef CONFIG_MMU
 /*
  * OOM Reaper kernel thread which tries to reap the memory used by the OOM
@@ -467,16 +466,51 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reape
 static struct task_struct *oom_reaper_list;
 static DEFINE_SPINLOCK(oom_reaper_lock);
 
-static bool __oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
+void __oom_reap_task_mm(struct mm_struct *mm)
 {
-	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
+
+	/*
+	 * Tell all users of get_user/copy_from_user etc... that the content
+	 * is no longer stable. No barriers really needed because unmapping
+	 * should imply barriers already and the reader would hit a page fault
+	 * if it stumbled over a reaped memory.
+	 */
+	set_bit(MMF_UNSTABLE, &mm->flags);
+
+	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
+		if (!can_madv_dontneed_vma(vma))
+			continue;
+
+		/*
+		 * Only anonymous pages have a good chance to be dropped
+		 * without additional steps which we cannot afford as we
+		 * are OOM already.
+		 *
+		 * We do not even care about fs backed pages because all
+		 * which are reclaimable have already been reclaimed and
+		 * we do not want to block exit_mmap by keeping mm ref
+		 * count elevated without a good reason.
+		 */
+		if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
+			struct mmu_gather tlb;
+
+			tlb_gather_mmu(&tlb, mm, vma->vm_start, vma->vm_end);
+			unmap_page_range(&tlb, vma, vma->vm_start, vma->vm_end,
+					 NULL);
+			tlb_finish_mmu(&tlb, vma->vm_start, vma->vm_end);
+		}
+	}
+}
+
+static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
+{
 	bool ret = true;
 
 	/*
 	 * We have to make sure to not race with the victim exit path
 	 * and cause premature new oom victim selection:
-	 * __oom_reap_task_mm		exit_mm
+	 * oom_reap_task_mm		exit_mm
 	 *   mmget_not_zero
 	 *				  mmput
 	 *				    atomic_dec_and_test
@@ -524,35 +558,8 @@ static bool __oom_reap_task_mm(struct ta
 
 	trace_start_task_reaping(tsk->pid);
 
-	/*
-	 * Tell all users of get_user/copy_from_user etc... that the content
-	 * is no longer stable. No barriers really needed because unmapping
-	 * should imply barriers already and the reader would hit a page fault
-	 * if it stumbled over a reaped memory.
-	 */
-	set_bit(MMF_UNSTABLE, &mm->flags);
-
-	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
-		if (!can_madv_dontneed_vma(vma))
-			continue;
+	__oom_reap_task_mm(mm);
 
-		/*
-		 * Only anonymous pages have a good chance to be dropped
-		 * without additional steps which we cannot afford as we
-		 * are OOM already.
-		 *
-		 * We do not even care about fs backed pages because all
-		 * which are reclaimable have already been reclaimed and
-		 * we do not want to block exit_mmap by keeping mm ref
-		 * count elevated without a good reason.
-		 */
-		if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
-			tlb_gather_mmu(&tlb, mm, vma->vm_start, vma->vm_end);
-			unmap_page_range(&tlb, vma, vma->vm_start, vma->vm_end,
-					 NULL);
-			tlb_finish_mmu(&tlb, vma->vm_start, vma->vm_end);
-		}
-	}
 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 			task_pid_nr(tsk), tsk->comm,
 			K(get_mm_counter(mm, MM_ANONPAGES)),
@@ -573,13 +580,12 @@ static void oom_reap_task(struct task_st
 	struct mm_struct *mm = tsk->signal->oom_mm;
 
 	/* Retry the down_read_trylock(mmap_sem) a few times */
-	while (attempts++ < MAX_OOM_REAP_RETRIES && !__oom_reap_task_mm(tsk, mm))
+	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
 		schedule_timeout_idle(HZ/10);
 
 	if (attempts <= MAX_OOM_REAP_RETRIES)
 		goto done;
 
-
 	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
 		task_pid_nr(tsk), tsk->comm);
 	debug_show_all_locks();
