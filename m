Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBYRZj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:25:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37440 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeBYRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:05 -0500
X-Google-Smtp-Source: AG47ELsR2NkAykNhpyCKZHHi9z8wbtkoTa9GJZJF5j8nzt+CHyDWeYC9N9uwKsmH0niFFm2oh06T9w==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 10/21] powerpc: Add missing prototype for slb_miss_bad_addr
Date: Sun, 25 Feb 2018 18:22:25 +0100
Message-Id: <20180225172236.29650-11-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit f0f558b131db ("powerpc/mm: Preserve CFAR value on SLB miss caused
by access to bogus address"), the function slb_miss_bad_addr was added
without a prototype. This commit adds it.

Fix a warning (treated as error in W=1):

  CC      arch/powerpc/kernel/traps.o
arch/powerpc/kernel/traps.c:1498:6: error: no previous prototype for ‘slb_miss_bad_addr’ [-Werror=missing-prototypes]
 void slb_miss_bad_addr(struct pt_regs *regs)
      ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7330150bfe34..0af1925e30db 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -62,6 +62,7 @@ void RunModeException(struct pt_regs *regs);
 void single_step_exception(struct pt_regs *regs);
 void program_check_exception(struct pt_regs *regs);
 void alignment_exception(struct pt_regs *regs);
+void slb_miss_bad_addr(struct pt_regs *regs);
 void StackOverflow(struct pt_regs *regs);
 void nonrecoverable_exception(struct pt_regs *regs);
 void kernel_fp_unavailable_exception(struct pt_regs *regs);
-- 
2.11.0
