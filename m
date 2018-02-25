Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBYRXy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:54 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34536 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeBYRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:10 -0500
X-Google-Smtp-Source: AH8x227foPbKKH6pIu/4CmKzWPt3ZES/1p1Oa0qDm4R2U9EHiwyAQ0QegINA2YcliatZLsj7MOzg5g==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 18/21] powerpc: Add missing prototypes for sys_sigreturn & sys_rt_sigreturn
Date: Sun, 25 Feb 2018 18:22:33 +0100
Message-Id: <20180225172236.29650-19-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two functions did not have a prototype defined in signal.h header. Fix the
following two warnings (treated as errors in W=1):

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c:1135:6: error: no previous prototype for ‘sys_rt_sigreturn’ [-Werror=missing-prototypes]
 long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
      ^~~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1422:6: error: no previous prototype for ‘sys_sigreturn’ [-Werror=missing-prototypes]
 long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
      ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/signal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 7c59d88b9d86..a6467f843acf 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -49,6 +49,11 @@ extern int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 #else /* CONFIG_PPC64 */
 
+extern long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
+		     struct pt_regs *regs);
+extern long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
+		       struct pt_regs *regs);
+
 static inline int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 				     struct task_struct *tsk)
 {
-- 
2.11.0
