Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeBYRX6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:58 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37449 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeBYRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:10 -0500
X-Google-Smtp-Source: AG47ELsVWXnw8r13jqYWK1SklLqtJoPT3xRzefYmVGibWCWGQbuYSkMs/mQ2ARAf9YG0yjo1iMq6yw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 17/21] powerpc: Add missing prototype for sys_debug_setcontext
Date: Sun, 25 Feb 2018 18:22:32 +0100
Message-Id: <20180225172236.29650-18-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
the function sys_debug_setcontext was added without a prototype.

Fix compilation warning (treated as error in W=1):

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
 int sys_debug_setcontext(struct ucontext __user *ctx,
     ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/asm-prototypes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 0af1925e30db..7c23d9ead694 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -89,6 +89,10 @@ int sys_swapcontext(struct ucontext __user *old_ctx,
 long sys_swapcontext(struct ucontext __user *old_ctx,
 		    struct ucontext __user *new_ctx,
 		    int ctx_size, int r6, int r7, int r8, struct pt_regs *regs);
+int sys_debug_setcontext(struct ucontext __user *ctx,
+			 int ndbg, struct sig_dbg_op __user *dbg,
+			 int r6, int r7, int r8,
+			 struct pt_regs *regs);
 #endif
 long sys_switch_endian(void);
 notrace unsigned int __check_irq_replay(void);
-- 
2.11.0
