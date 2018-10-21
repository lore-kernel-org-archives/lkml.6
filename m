Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6DECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E77C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJURPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:15:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJURPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:15:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9L90wTT2013092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 Oct 2018 02:00:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9L90tGk2013078;
        Sun, 21 Oct 2018 02:00:55 -0700
Date:   Sun, 21 Oct 2018 02:00:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-162041425193602b15774c61740ad8e7dc157df3@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, luto@kernel.org, jannh@google.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ebiederm@xmission.com,
        sean.j.christopherson@intel.com
Reply-To: tglx@linutronix.de, jannh@google.com,
          dave.hansen@linux.intel.com, peterz@infradead.org,
          torvalds@linux-foundation.org, luto@kernel.org, mingo@kernel.org,
          ebiederm@xmission.com, sean.j.christopherson@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20181019140842.12F929FA@viggo.jf.intel.com>
References: <20181019140842.12F929FA@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Kill stray kernel fault handling comment
Git-Commit-ID: 162041425193602b15774c61740ad8e7dc157df3
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

Commit-ID:  162041425193602b15774c61740ad8e7dc157df3
Gitweb:     https://git.kernel.org/tip/162041425193602b15774c61740ad8e7dc157df3
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 19 Oct 2018 07:08:42 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 21 Oct 2018 10:58:10 +0200

x86/mm: Kill stray kernel fault handling comment

I originally had matching user and kernel comments, but the kernel
one got improved.  Some errant conflict resolution kicked the commment
somewhere wrong.  Kill it.

Reported-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: aa37c51b94 ("x86/mm: Break out user address space handling")
Link: http://lkml.kernel.org/r/20181019140842.12F929FA@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a16652982f98..bd047438d23d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -963,7 +963,6 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 		__bad_area(regs, error_code, address, vma, SEGV_ACCERR);
 }
 
-/* Handle faults in the kernel portion of the address space */
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  u32 *pkey, unsigned int fault)
