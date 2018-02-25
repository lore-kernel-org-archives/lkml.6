Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeBYRXs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:48 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40165 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeBYRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:11 -0500
X-Google-Smtp-Source: AH8x224OCC2Vtw2CLt8er7F90BvD8op3fQSjO1js4z3QcB4Vy4Yo+JAxUHwwpKE3Ur8vRjdrljDUWw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 20/21] powerpc: Add missing prototypes for ppc_select & ppc_fadvise64_64
Date: Sun, 25 Feb 2018 18:22:35 +0100
Message-Id: <20180225172236.29650-21-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing prototypes for ppc_select & ppc_fadvise64_64 to header
asm-prototypes.h. Fix the following warnings (treated as errors in W=1)

  CC      arch/powerpc/kernel/syscalls.o
arch/powerpc/kernel/syscalls.c:87:1: error: no previous prototype for ‘ppc_select’ [-Werror=missing-prototypes]
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
 ^~~~~~~~~~
arch/powerpc/kernel/syscalls.c:119:6: error: no previous prototype for ‘ppc_fadvise64_64’ [-Werror=missing-prototypes]
 long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
      ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/asm-prototypes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7c23d9ead694..4d8b89b46018 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -93,7 +93,11 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 			 int ndbg, struct sig_dbg_op __user *dbg,
 			 int r6, int r7, int r8,
 			 struct pt_regs *regs);
+int
+ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp);
 #endif
+long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
+		      u32 len_high, u32 len_low);
 long sys_switch_endian(void);
 notrace unsigned int __check_irq_replay(void);
 void notrace restore_interrupts(void);
-- 
2.11.0
