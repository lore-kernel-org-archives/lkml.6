Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400552086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400552086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJHRIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:08:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:08:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989uYsY559985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:56:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989uY1l559982;
        Mon, 8 Oct 2018 02:56:34 -0700
Date:   Mon, 8 Oct 2018 02:56:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-824eea38d239fb2a6027e65e18a5daef23019b00@git.kernel.org>
Cc:     riel@surriel.com, torvalds@linux-foundation.org,
        luto@amacapital.net, ravi.v.shankar@intel.com, luto@kernel.org,
        brgerst@gmail.com, bp@alien8.de, ak@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, markus.t.metzger@intel.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        chang.seok.bae@intel.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: chang.seok.bae@intel.com, tglx@linutronix.de,
          dave.hansen@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
          ravi.v.shankar@intel.com, riel@surriel.com,
          torvalds@linux-foundation.org, luto@amacapital.net,
          markus.t.metzger@intel.com, peterz@infradead.org,
          ak@linux.intel.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org,
          brgerst@gmail.com
In-Reply-To: <1537312139-5580-5-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-5-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/fsgsbase/64: Convert the ELF core dump code to
 the new FSGSBASE helpers
Git-Commit-ID: 824eea38d239fb2a6027e65e18a5daef23019b00
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

Commit-ID:  824eea38d239fb2a6027e65e18a5daef23019b00
Gitweb:     https://git.kernel.org/tip/824eea38d239fb2a6027e65e18a5daef23019b00
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:55 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:09 +0200

x86/fsgsbase/64: Convert the ELF core dump code to the new FSGSBASE helpers

Replace open-coded rdmsr()'s with their <asm/fsgsbase.h> API
counterparts.

No change in functionality intended.

[ mingo: Wrote new changelog. ]

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/1537312139-5580-5-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/elf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..1527ec351036 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -10,6 +10,7 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/auxvec.h>
+#include <asm/fsgsbase.h>
 
 typedef unsigned long elf_greg_t;
 
@@ -205,7 +206,6 @@ void set_personality_ia32(bool);
 
 #define ELF_CORE_COPY_REGS(pr_reg, regs)			\
 do {								\
-	unsigned long base;					\
 	unsigned v;						\
 	(pr_reg)[0] = (regs)->r15;				\
 	(pr_reg)[1] = (regs)->r14;				\
@@ -228,8 +228,8 @@ do {								\
 	(pr_reg)[18] = (regs)->flags;				\
 	(pr_reg)[19] = (regs)->sp;				\
 	(pr_reg)[20] = (regs)->ss;				\
-	rdmsrl(MSR_FS_BASE, base); (pr_reg)[21] = base;		\
-	rdmsrl(MSR_KERNEL_GS_BASE, base); (pr_reg)[22] = base;	\
+	(pr_reg)[21] = x86_fsbase_read_cpu();			\
+	(pr_reg)[22] = x86_gsbase_read_cpu_inactive();		\
 	asm("movl %%ds,%0" : "=r" (v)); (pr_reg)[23] = v;	\
 	asm("movl %%es,%0" : "=r" (v)); (pr_reg)[24] = v;	\
 	asm("movl %%fs,%0" : "=r" (v)); (pr_reg)[25] = v;	\
