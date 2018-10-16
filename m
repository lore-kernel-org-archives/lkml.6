Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14356C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9404208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9404208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJPOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:12:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJPOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:12:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9G6Ln3e3977005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Oct 2018 23:21:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9G6Ln713977001;
        Mon, 15 Oct 2018 23:21:49 -0700
Date:   Mon, 15 Oct 2018 23:21:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-0cd6fa95a4a44ff2d649957423946c19eb98e825@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
          tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          bp@alien8.de
In-Reply-To: <c47daa1888dc2298e7e1d3f82bd76b776ea33393.1539542111.git.luto@kernel.org>
References: <c47daa1888dc2298e7e1d3f82bd76b776ea33393.1539542111.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Further improve paranoid_entry
 comments
Git-Commit-ID: 0cd6fa95a4a44ff2d649957423946c19eb98e825
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

Commit-ID:  0cd6fa95a4a44ff2d649957423946c19eb98e825
Gitweb:     https://git.kernel.org/tip/0cd6fa95a4a44ff2d649957423946c19eb98e825
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 14 Oct 2018 11:38:18 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 08:19:34 +0200

x86/entry/64: Further improve paranoid_entry comments

Commit:

  16561f27f94e ("x86/entry: Add some paranoid entry/exit CR3 handling comments")

... added some comments.  This improves them a bit:

 - When I first read the new comments, it was unclear to me whether
   they were referring to the case where paranoid_entry interrupted
   other entry code or where paranoid_entry was itself interrupted.
   Clarify it.

 - Remove the EBX comment.  We no longer use EBX as a SWAPGS
   indicator.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/c47daa1888dc2298e7e1d3f82bd76b776ea33393.1539542111.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1d9b4a300c8c..f95dcb209fdf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1189,15 +1189,13 @@ ENTRY(paranoid_entry)
 1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
-	 * verbatim, at exit.  Needed if kernel is interrupted
-	 * after switching to the user CR3 value but before
-	 * returning to userspace.
+	 * verbatim, at exit.  Needed if paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
 	 *
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
-	 * to kernel code, but with a user CR3 value.  The %ebx flag
-	 * for SWAPGS is also unusable for CR3 because there is a
-	 * window with a user GS and a kernel CR3.
+	 * to kernel code, but with a user CR3 value.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
