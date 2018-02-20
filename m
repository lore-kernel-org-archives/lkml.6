Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeBTK0j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:26:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBTK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:26:36 -0500
Date: Tue, 20 Feb 2018 02:26:06 -0800
From: tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-3b3a9268bba62b35a29bafe0931715b1725fdf26@git.kernel.org>
Cc: mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, hpa@zytor.com, jannh@google.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com, tglx@linutronix.de,
        brgerst@gmail.com, torvalds@linux-foundation.org, bp@alien8.de
Reply-To: luto@kernel.org, peterz@infradead.org, jpoimboe@redhat.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jannh@google.com, dvlasenk@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, brgerst@gmail.com, bp@alien8.de
In-Reply-To: <20180219175039.253089-1-jannh@google.com>
References: <20180219175039.253089-1-jannh@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Remove stale comment about KMEMCHECK
Git-Commit-ID: 3b3a9268bba62b35a29bafe0931715b1725fdf26
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3b3a9268bba62b35a29bafe0931715b1725fdf26
Gitweb:     https://git.kernel.org/tip/3b3a9268bba62b35a29bafe0931715b1725fdf26
Author:     Jann Horn <jannh@google.com>
AuthorDate: Mon, 19 Feb 2018 18:50:39 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:33:39 +0100

x86/mm: Remove stale comment about KMEMCHECK

This comment referred to a conditional call to kmemcheck_hide() that was
here until commit 4950276672fc ("kmemcheck: remove annotations").

Now that kmemcheck has been removed, it doesn't make sense anymore.

Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180219175039.253089-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 800de81..c88573d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1248,10 +1248,6 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	tsk = current;
 	mm = tsk->mm;
 
-	/*
-	 * Detect and handle instructions that would cause a page fault for
-	 * both a tracked kernel page and a userspace page.
-	 */
 	prefetchw(&mm->mmap_sem);
 
 	if (unlikely(kmmio_fault(regs, address)))
