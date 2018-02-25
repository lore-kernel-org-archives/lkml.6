Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBYR0Y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:26:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52812 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeBYRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:03 -0500
X-Google-Smtp-Source: AH8x226JE++JO7176kNOjBYdG7RK0rnsj9OVv6NtbpZET2v7wHGTSJAC2bdHOWwQ0ImOJ8+9UE9u4w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 08/21] powerpc: Make function __giveup_fpu static
Date: Sun, 25 Feb 2018 18:22:23 +0100
Message-Id: <20180225172236.29650-9-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PPC_FPU is defined the prototype exposed in asm/switch_to.h is:

  extern void giveup_fpu(struct task_struct *);

Change the function prototype of __giveup_fpu to static. Fix warning
(treated as error in W=1):

  CC      arch/powerpc/kernel/process.o
arch/powerpc/kernel/process.c:176:6: error: no previous prototype for ‘__giveup_fpu’ [-Werror=missing-prototypes]
 void __giveup_fpu(struct task_struct *tsk)
      ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1738c4127b32..3ac98c0463d6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -173,7 +173,7 @@ void __msr_check_and_clear(unsigned long bits)
 EXPORT_SYMBOL(__msr_check_and_clear);
 
 #ifdef CONFIG_PPC_FPU
-void __giveup_fpu(struct task_struct *tsk)
+static void __giveup_fpu(struct task_struct *tsk)
 {
 	unsigned long msr;
 
-- 
2.11.0
