Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeBYR1L (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:27:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50217 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeBYRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:22:59 -0500
X-Google-Smtp-Source: AG47ELt/sxJbmhBM3MoqNIKJoXtjQM65SU2Ku9GAz8Oh0MxwFqvXMWyZEtDMZ3wCCgIFs09evQkNnA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 04/21] powerpc: Mark both tmp variables as unused
Date: Sun, 25 Feb 2018 18:22:19 +0100
Message-Id: <20180225172236.29650-5-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the value of `tmp` is never intended to be read, declare both `tmp`
variables as unused. Fix warning (treated as error in W=1):

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function ‘sys_swapcontext’:
arch/powerpc/kernel/signal_32.c:1048:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
  unsigned char tmp;
                ^~~
arch/powerpc/kernel/signal_32.c: In function ‘sys_debug_setcontext’:
arch/powerpc/kernel/signal_32.c:1234:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
  unsigned char tmp;
                ^~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/signal_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index a46de0035214..492f03451877 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1045,7 +1045,7 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 		     struct ucontext __user *new_ctx,
 		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
 {
-	unsigned char tmp;
+	unsigned char tmp __maybe_unused;
 	int ctx_has_vsx_region = 0;
 
 #ifdef CONFIG_PPC64
@@ -1231,7 +1231,7 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 {
 	struct sig_dbg_op op;
 	int i;
-	unsigned char tmp;
+	unsigned char tmp __maybe_unused;
 	unsigned long new_msr = regs->msr;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long new_dbcr0 = current->thread.debug.dbcr0;
-- 
2.11.0
