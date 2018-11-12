Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A4F21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A4F21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeKLPxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:53:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbeKLPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:53:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAC60xc03546552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Nov 2018 22:00:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAC60xS53546549;
        Sun, 11 Nov 2018 22:00:59 -0800
Date:   Sun, 11 Nov 2018 22:00:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elvira Khabirova <tipbot@zytor.com>
Message-ID: <tip-d19f9130b814d33c03118493c17454f7d90075d1@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, lineprinter@altlinux.org,
        hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org
Reply-To: lineprinter@altlinux.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com, bp@alien8.de,
          peterz@infradead.org
In-Reply-To: <20181110042209.26333972@akathisia>
References: <20181110042209.26333972@akathisia>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ptrace: Fix documentation for
 tracehook_report_syscall_entry()
Git-Commit-ID: d19f9130b814d33c03118493c17454f7d90075d1
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

Commit-ID:  d19f9130b814d33c03118493c17454f7d90075d1
Gitweb:     https://git.kernel.org/tip/d19f9130b814d33c03118493c17454f7d90075d1
Author:     Elvira Khabirova <lineprinter@altlinux.org>
AuthorDate: Sat, 10 Nov 2018 04:22:09 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 04:53:27 +0100

x86/ptrace: Fix documentation for tracehook_report_syscall_entry()

tracehook_report_syscall_entry() is called not only
if %TIF_SYSCALL_TRACE is set, but also if %TIF_SYSCALL_EMU is set,
as appears from x86's entry code.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: ldv@altlinux.org
Cc: oleg@redhat.com
Cc: rostedt@goodmis.org
Link: http://lkml.kernel.org/r/20181110042209.26333972@akathisia
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/tracehook.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 40b0b4c1bf7b..df20f8bdbfa3 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -83,8 +83,8 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
  * tracehook_report_syscall_entry - task is about to attempt a system call
  * @regs:		user register state of current task
  *
- * This will be called if %TIF_SYSCALL_TRACE has been set, when the
- * current task has just entered the kernel for a system call.
+ * This will be called if %TIF_SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
+ * when the current task has just entered the kernel for a system call.
  * Full user register state is available here.  Changing the values
  * in @regs can affect the system call number and arguments to be tried.
  * It is safe to block here, preventing the system call from beginning.
