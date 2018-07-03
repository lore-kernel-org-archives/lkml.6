Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026D323EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026D323EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeGCIgT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:36:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeGCIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:36:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w638ZfPT214163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 01:35:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w638ZfOo214160;
        Tue, 3 Jul 2018 01:35:41 -0700
Date:   Tue, 3 Jul 2018 01:35:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tglx@linutronix.de, dvlasenk@redhat.com,
        jbeulich@suse.com, bp@alien8.de, brgerst@gmail.com,
        peterz@infradead.org, hpa@zytor.com, JBeulich@suse.com,
        mingo@kernel.org, luto@kernel.org
Reply-To: jbeulich@suse.com, bp@alien8.de, brgerst@gmail.com,
          peterz@infradead.org, hpa@zytor.com, luto@kernel.org,
          JBeulich@suse.com, mingo@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, tglx@linutronix.de, dvlasenk@redhat.com
In-Reply-To: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
References: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Git-Commit-ID: 6709812f094d96543b443645c68daaa32d3d3e77
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

Commit-ID:  6709812f094d96543b443645c68daaa32d3d3e77
Gitweb:     https://git.kernel.org/tip/6709812f094d96543b443645c68daaa32d3d3e77
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 2 Jul 2018 04:47:57 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:59:29 +0200

x86/entry/64: Add two more instruction suffixes

Sadly, other than claimed in:

  a368d7fd2a ("x86/entry/64: Add instruction suffix")

... there are two more instances which want to be adjusted.

As said there, omitting suffixes from instructions in AT&T mode is bad
practice when operand size cannot be determined by the assembler from
register operands, and is likely going to be warned about by upstream
gas in the future (mine does already).

Add the other missing suffixes here as well.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c6f3677e6105..65aa16d845f6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ END(native_usergs_sysret64)
 .endm
 
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -702,7 +702,7 @@ retint_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Interrupts are off */
 	/* Check if we need preemption */
-	bt	$9, EFLAGS(%rsp)		/* were interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
 	jnc	1f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
