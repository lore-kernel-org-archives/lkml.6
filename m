Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64929C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0188621479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0188621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJIWV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:21:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJIWV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:21:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F4FLL1083526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:04:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F4F931083523;
        Tue, 9 Oct 2018 08:04:15 -0700
Date:   Tue, 9 Oct 2018 08:04:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-88259744e253777e898c186f08670c86dd8199bf@git.kernel.org>
Cc:     luto@kernel.org, sean.j.christopherson@intel.com,
        dave.hansen@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jannh@google.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: luto@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
          sean.j.christopherson@intel.com, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de, jannh@google.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180928160227.077DDD7A@viggo.jf.intel.com>
References: <20180928160227.077DDD7A@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Fix exception table comments
Git-Commit-ID: 88259744e253777e898c186f08670c86dd8199bf
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

Commit-ID:  88259744e253777e898c186f08670c86dd8199bf
Gitweb:     https://git.kernel.org/tip/88259744e253777e898c186f08670c86dd8199bf
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 28 Sep 2018 09:02:27 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:16 +0200

x86/mm: Fix exception table comments

The comments here are wrong.  They are too absolute about where
faults can occur when running in the kernel.  The comments are
also a bit hard to match up with the code.

Trim down the comments, and make them more precise.

Also add a comment explaining why we are doing the
bad_area_nosemaphore() path here.

Cc: x86@kernel.org
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180928160227.077DDD7A@viggo.jf.intel.com
---
 arch/x86/mm/fault.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1d838701a5f7..57b074b02ebb 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1351,24 +1351,26 @@ void do_user_addr_fault(struct pt_regs *regs,
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/*
-	 * When running in the kernel we expect faults to occur only to
-	 * addresses in user space.  All other faults represent errors in
-	 * the kernel and should generate an OOPS.  Unfortunately, in the
-	 * case of an erroneous fault occurring in a code path which already
-	 * holds mmap_sem we will deadlock attempting to validate the fault
-	 * against the address space.  Luckily the kernel only validly
-	 * references user space from well defined areas of code, which are
-	 * listed in the exceptions table.
+	 * Kernel-mode access to the user address space should only occur
+	 * on well-defined single instructions listed in the exception
+	 * tables.  But, an erroneous kernel fault occurring outside one of
+	 * those areas which also holds mmap_sem might deadlock attempting
+	 * to validate the fault against the address space.
 	 *
-	 * As the vast majority of faults will be valid we will only perform
-	 * the source reference check when there is a possibility of a
-	 * deadlock. Attempt to lock the address space, if we cannot we then
-	 * validate the source. If this is invalid we can skip the address
-	 * space check, thus avoiding the deadlock:
+	 * Only do the expensive exception table search when we might be at
+	 * risk of a deadlock.  This happens if we
+	 * 1. Failed to acquire mmap_sem, and
+	 * 2. The access did not originate in userspace.  Note: either the
+	 *    hardware or earlier page fault code may set X86_PF_USER
+	 *    in sw_error_code.
 	 */
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
 		if (!(sw_error_code & X86_PF_USER) &&
 		    !search_exception_tables(regs->ip)) {
+			/*
+			 * Fault from code in kernel from
+			 * which we do not expect faults.
+			 */
 			bad_area_nosemaphore(regs, sw_error_code, address, NULL);
 			return;
 		}
