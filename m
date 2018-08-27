Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A35C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE1A208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE1A208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeH0Xe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:34:57 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38759 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0Xdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:46 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Mbyf0-1gBM4l1S7i-00JNUb; Mon, 27 Aug 2018 21:45:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/14] y2038: Remove stat64 family from default syscall set
Date:   Mon, 27 Aug 2018 21:45:22 +0200
Message-Id: <20180827194531.3796559-6-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:igrE4gERJEo+kEelQStiIqH+Zmx2zakwnV1Y9q8rzHSJSjFzJ34
 7hDWUXVcOlpUt6y6OGLsGCdr7vmR23mTNPzsqFlBF1KAEzMvszYTAA649INWGlLwPsE27cg
 FNy6S7ziri4tY2yXUfgacUtQBiMcjiJQNM6+oAkBSVr5iazMxAr1ueDyyJtu55Shf7bBqKb
 ixuJg10g7FjAoi5WOu3Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dhyiS7C+TOE=:kJb/Uirr9K9RyDguMmy/BJ
 QFKaHbiQAJnysouRVE5wYVTjhWV+vmdwF6iXq8I1fiNmtaJc9cIAV4Eb0TkAdVdcobTMAnuFn
 fmJGB45ceBaiHFGoiipk+tEEisoLQRRZVqLADTZgaKu6FA8xYPSQgpTUkNItYJAFdSg6ZaNzt
 ItDIrZ/y2Dzr9v/ktHt2Jqcb/kh84BVS3Ephbt4TBEbV1U9/Tn9No4PY7gpkX8lJ55jRAE7RP
 7Qgvc0hDfVfTgZ5UlM0c1l7sS8k9SJdhcZfKrJz1iulijQlSp1DKo2DzkV6qhP/RDYoFb10Zu
 C9BWVx4jPWEATqdknG117Gq5BSqJkYolLDp4bgTQQQOC9n/2JE2HTc9OfLFoFyDUYYdEwYNju
 W6TZQ8aUmGC6ETecKtNBEPwWhpGNXzT4NlPJNZgDav6LX1xZ25/DBM9a3URRe+gTN1poy8Nhw
 rt5maDLaPV1AuBtTVJPavrZ6om+Jw4O59Xfloo1fN6nYXBb6PFl0XmmDzB1w+GmpqHgoa5B6D
 PRUDrkVBVUbdkNjsFbes4DnPxd3lGytYxjSwAvq0xSIbW9GCpm8gknffEHErq5Cd/58mMInJH
 KqZzi3K18hNQ2hKLHjXk9RTZ2SxEfr1hjJXmuyznh/xHacgHWinpOqEPQvvyIkztJoqeAlqLj
 IDyt4+ZTi8j+9uis6zHrbzKmJIFxGx/+6W1LqDRx9XC0g2NEx0gL5WmfAgToeSpJGK+4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New architectures should no longer need stat64, which is not y2038
safe and has been replaced by statx(). This removes the 'select
__ARCH_WANT_STAT64' statement from asm-generic/unistd.h and instead
moves it into the respective asm/unistd.h UAPI header files for each
architecture that uses it today.

In the generic file, the system call number and entry points are now
made conditional, so newly added architectures (e.g. riscv32 or csky)
will never need to carry backwards compatiblity for it.

arm64 is the only 64-bit architecture using the asm-generic/unistd.h
file, and it already sets __ARCH_WANT_NEW_STAT in its headers, and I
use the same #ifdef here: future 64-bit architectures therefore won't
see newstat or stat64 any more. They don't suffer from the y2038 time_t
overflow, but for consistency it seems best to also let them use statx().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/uapi/asm/unistd.h       | 1 +
 arch/c6x/include/uapi/asm/unistd.h       | 1 +
 arch/h8300/include/uapi/asm/unistd.h     | 1 +
 arch/hexagon/include/uapi/asm/unistd.h   | 1 +
 arch/nds32/include/uapi/asm/unistd.h     | 1 +
 arch/nios2/include/uapi/asm/unistd.h     | 1 +
 arch/openrisc/include/uapi/asm/unistd.h  | 1 +
 arch/unicore32/include/uapi/asm/unistd.h | 1 +
 include/asm-generic/unistd.h             | 1 -
 include/uapi/asm-generic/unistd.h        | 2 ++
 10 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index 517178b1daef..3b3543fd151c 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -17,6 +17,7 @@
 #define _UAPI_ASM_ARC_UNISTD_H
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 0d2daf7f9809..6b2fe792de9d 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -16,6 +16,7 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
 
 /* Use the standard ABI for syscalls. */
diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
index 7dd20ef7625a..628195823816 100644
--- a/arch/h8300/include/uapi/asm/unistd.h
+++ b/arch/h8300/include/uapi/asm/unistd.h
@@ -1,5 +1,6 @@
 #define __ARCH_NOMMU
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index ea181e79162e..c91ca7d02461 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -29,6 +29,7 @@
 
 #define sys_mmap2 sys_mmap_pgoff
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index 6e95901cabe3..603e826e0449 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYNC_FILE_RANGE2
 
 /* Use the standard ABI for syscalls */
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index b6bdae04bc84..d9948d88790b 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -19,6 +19,7 @@
  #define sys_mmap2 sys_mmap_pgoff
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index 11c5a58ab333..ec37df18d8ed 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -20,6 +20,7 @@
 #define sys_mmap2 sys_mmap_pgoff
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 65856eaab163..1e8fe5941b8a 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -15,4 +15,5 @@
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index cdf904265caf..ea74eca8463f 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -8,6 +8,5 @@
  * be selected by default.
  */
 #if __BITS_PER_LONG == 32
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_LLSEEK
 #endif
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index df4bedb9b01c..538546edbfbd 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -242,10 +242,12 @@ __SYSCALL(__NR_tee, sys_tee)
 /* fs/stat.c */
 #define __NR_readlinkat 78
 __SYSCALL(__NR_readlinkat, sys_readlinkat)
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 #define __NR3264_fstatat 79
 __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
 #define __NR3264_fstat 80
 __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
+#endif
 
 /* fs/sync.c */
 #define __NR_sync 81
-- 
2.18.0

