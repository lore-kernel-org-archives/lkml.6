Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeENOmF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:42:05 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:40956 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeENOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:42:04 -0400
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="393178418"
From: Christian Hansen <chansen3@cisco.com>
To: catalin.marinas@arm.com, linux@dominikbrodowski.net
Cc: xe-linux-external@cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christian Hansen <chansen3@cisco.com>
Subject: [PATCH] arm64: allowing mmap to be traced
Date: Mon, 14 May 2018 14:32:42 +0000
Message-Id: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
X-Mailer: git-send-email 2.5.0
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding missing macro which is present all other system calls to
to mmap declaration for ARM.  This allows it to appear as a kernel
tracing target.

Signed-off-by: Christian Hansen <chansen3@cisco.com>
---
 arch/arm64/kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 72981ba..1ccdbfc 100644
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
2.5.0
