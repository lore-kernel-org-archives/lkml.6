Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968720881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeJPPLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:11:07 -0400
Received: from mo-csw-fb1514.securemx.jp ([210.130.202.170]:38424 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:11:07 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id w9G72nRs018779; Tue, 16 Oct 2018 16:02:49 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id w9G7115Y005207; Tue, 16 Oct 2018 16:01:02 +0900
X-Iguazu-Qid: 34tKGYFtwQQ7t5gOyz
X-Iguazu-QSIG: v=1; s=0; t=1539673261; q=34tKGYFtwQQ7t5gOyz; m=pxvGA7ZGbR6Vkl6CXuhSrj7tUz7j0HbKseWrqU3uIPA=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1513) id w9G70pZu019646;
        Tue, 16 Oct 2018 16:00:51 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w9G70pQw029484;
        Tue, 16 Oct 2018 16:00:51 +0900 (JST)
From:   Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
To:     stable@vger.kernel.org
Cc:     Rik van Riel <riel@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, pbonzini@redhat.com,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bo Gan <ganb@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        yu-cheng yu <yu-cheng.yu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4.4 3/4] x86/fpu: Remove struct fpu::counter
Date:   Tue, 16 Oct 2018 16:00:02 +0900
X-TSB-HOP: ON
Message-Id: <1539673203-21068-4-git-send-email-daniel.sangorrin@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539673203-21068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1539673203-21068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@redhat.com>

commit 3913cc3507575273beb165a5e027a081913ed507 upstream.

With the lazy FPU code gone, we no longer use the counter field
in struct fpu for anything. Get rid it.

Signed-off-by: Rik van Riel <riel@redhat.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1475627678-20788-6-git-send-email-riel@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 arch/x86/include/asm/fpu/internal.h |  3 ---
 arch/x86/include/asm/fpu/types.h    | 11 -----------
 arch/x86/kernel/fpu/core.c          |  3 ---
 3 files changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 2ff03cc..16825dd 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -575,15 +575,12 @@ switch_fpu_prepare(struct fpu *old_fpu, struct fpu *new_fpu, int cpu)
 
 		/* Don't change CR0.TS if we just switch! */
 		if (fpu.preload) {
-			new_fpu->counter++;
 			__fpregs_activate(new_fpu);
 			prefetch(&new_fpu->state);
 		}
 	} else {
-		old_fpu->counter = 0;
 		old_fpu->last_cpu = -1;
 		if (fpu.preload) {
-			new_fpu->counter++;
 			if (fpu_want_lazy_restore(new_fpu, cpu))
 				fpu.preload = 0;
 			else
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 1c6f6ac..dcb85a9 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -303,17 +303,6 @@ struct fpu {
 	unsigned char			fpregs_active;
 
 	/*
-	 * @counter:
-	 *
-	 * This counter contains the number of consecutive context switches
-	 * during which the FPU stays used. If this is over a threshold, the
-	 * lazy FPU restore logic becomes eager, to save the trap overhead.
-	 * This is an unsigned char so that after 256 iterations the counter
-	 * wraps and the context switch behavior turns lazy again; this is to
-	 * deal with bursty apps that only use the FPU for a short time:
-	 */
-	unsigned char			counter;
-	/*
 	 * @state:
 	 *
 	 * In-memory copy of all FPU registers that we save/restore
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index b282364..b322325 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -250,7 +250,6 @@ static void fpu_copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 
 int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 {
-	dst_fpu->counter = 0;
 	dst_fpu->fpregs_active = 0;
 	dst_fpu->last_cpu = -1;
 
@@ -353,7 +352,6 @@ void fpu__restore(struct fpu *fpu)
 	kernel_fpu_disable();
 	fpregs_activate(fpu);
 	copy_kernel_to_fpregs(&fpu->state);
-	fpu->counter++;
 	kernel_fpu_enable();
 }
 EXPORT_SYMBOL_GPL(fpu__restore);
@@ -370,7 +368,6 @@ EXPORT_SYMBOL_GPL(fpu__restore);
 void fpu__drop(struct fpu *fpu)
 {
 	preempt_disable();
-	fpu->counter = 0;
 
 	if (fpu->fpregs_active) {
 		/* Ignore delayed exceptions from user space */
-- 
2.7.4

