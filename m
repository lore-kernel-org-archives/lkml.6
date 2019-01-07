Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E090FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47620838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAGCwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:52:40 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53938 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAGCwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:52:40 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8FB7472CC6C;
        Mon,  7 Jan 2019 05:52:36 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8502A8E5C51; Mon,  7 Jan 2019 05:52:36 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:52:36 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/22] asm-generic/syscall.h: prepare for inclusion by
 other files
Message-ID: <20190107025236.GA1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the very beginning and up to now asm-generic/syscall.h is used for
documentation purposes only, it could not be included by arch-specific
asm/syscall.h files due to static/non-static conflict of function
prototypes.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: unchanged
    v6: initial revision

 include/asm-generic/syscall.h | 39 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 0c938a4354f6..9863a5f8fbe8 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -16,8 +16,8 @@
  * cannot return to user mode while we are looking at it.
  */
 
-#ifndef _ASM_SYSCALL_H
-#define _ASM_SYSCALL_H	1
+#ifndef _ASM_GENERIC_SYSCALL_H
+#define _ASM_GENERIC_SYSCALL_H	1
 
 struct task_struct;
 struct pt_regs;
@@ -38,7 +38,8 @@ struct pt_regs;
  *
  * It's only valid to call this when @task is known to be blocked.
  */
-int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
+static int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
 
 /**
  * syscall_rollback - roll back registers after an aborted system call
@@ -56,7 +57,8 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  * system call instruction.  This may not be the same as what the
  * register state looked like at system call entry tracing.
  */
-void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
+static void
+syscall_rollback(struct task_struct *task, struct pt_regs *regs);
 
 /**
  * syscall_get_error - check result of traced system call
@@ -68,7 +70,8 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs);
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
+static long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs);
 
 /**
  * syscall_get_return_value - get the return value of a traced system call
@@ -81,7 +84,8 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs);
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
+static long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
 
 /**
  * syscall_set_return_value - change the return value of a traced system call
@@ -98,8 +102,9 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs);
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
-			      int error, long val);
+static void
+syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
+			 int error, long val);
 
 /**
  * syscall_get_arguments - extract system call parameter values
@@ -118,8 +123,9 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
  */
-void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n, unsigned long *args);
+static void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, unsigned long *args);
 
 /**
  * syscall_set_arguments - change system call parameter value
@@ -138,9 +144,10 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
  */
-void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n,
-			   const unsigned long *args);
+static void
+syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n,
+		      const unsigned long *args);
 
 /**
  * syscall_get_arch - return the AUDIT_ARCH for the current system call
@@ -153,5 +160,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
  */
-int syscall_get_arch(void);
-#endif	/* _ASM_SYSCALL_H */
+static int
+syscall_get_arch(void);
+
+#endif	/* _ASM_GENERIC_SYSCALL_H */
-- 
ldv
