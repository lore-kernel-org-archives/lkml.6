Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeFAL1B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:27:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeFALZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:21 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv2 17/19] arm64: use SYSCALL_DEFINE6() for mmap
Date: Fri,  1 Jun 2018 12:24:39 +0100
Message-Id: <20180601112441.37810-18-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't currently annotate our mmap implementation as a syscall, as we
need to do to use pt_regs syscall wrappers.

Let's mark it as a real syscall.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index a82c3f7a9a90..2ad1497a184e 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -27,9 +27,9 @@
 #include <linux/syscalls.h>
 #include <asm/cpufeature.h>
 
-asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
-			 unsigned long prot, unsigned long flags,
-			 unsigned long fd, off_t off)
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, off_t, off)
 {
 	if (offset_in_page(off) != 0)
 		return -EINVAL;
-- 
2.11.0
