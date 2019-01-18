Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B36C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A8520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfARQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:20:34 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfARQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKKd7-1gWQWS33t9-00LmRg; Fri, 18 Jan 2019 17:19:23 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/29] ARM: add migrate_pages() system call
Date:   Fri, 18 Jan 2019 17:18:12 +0100
Message-Id: <20190118161835.2259170-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o3bTb4elB3z+286rn9+b5BP7tK9ifOmWUW+jka5ZcLRoBINPDJf
 u8PIZcP2oUy73YnUflDiwxkNfXIDgII5Pyhk+V14swnaTnFx5ocmSc3GvbMfPHBlAdH2hOO
 HnGoII6EJed1+C6r0RoTYwRkjRvEbyOrLcmhc5DagzjWZlLv5X7xA8BSuap5Ej3vVq2kBkR
 J33viKVBFQ1JhizF8SI/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3TL+IMUlpzQ=:W4KhIatfhW7FMFXhanW/DA
 GRXuaIVZT5yLKobF9hxOAr0++qzuCRc1CvEdJhCRmyjg3tVnuVTea/UC1uvUl5+b8WbMQGZ2y
 IhAzxeBsFmWL53O9WpTTqoDT/nboxRQDmswH0/f/GTKPMN2z3vZwVUlRhzoSirbpF+lnxfjOZ
 sN/4WLTGYuHpbqrOxsstykpo2y8LRe1POgk4jbusH6bQF90n6M4iRhVrGRIOrVw2bdttMMlAA
 uT0OtEXxzSfFi0CYobAlGKnZqnyNhrd53D0fMCInpqHILWFd1DtjVcSRRThpH/sAtDi0bB10+
 Ugb1IEqZY/t6Vwsm27UEtY2WdRDnob3jplYpxp7LEYnA9+MmRRxsSQGX4rwbfAh61hF01Z6w6
 c1gGmtntitfEHrg2cn23IhBqYw4oKw2FRJOxB9tDFAw7RHOCw9DS4DZeuAH/963xwTtIZQzNY
 1aXUG6Znslmrc13+enLNNpHHdqS95uRqE0RLgCHtmqVJSvSINH3VB0iFWhAu52D9FeScou6Jt
 DMCljPSLrh3jHaukqC84MTlYT6tYVfPoAwYvF7QgVEd2kgvyMgY2cHJMjfNpvBVodJDtgelWN
 WyT2nqJHgERRpJagCPwbdtU6mcbVNfRzxffHnacQ4vUxt4V/sJi/kqkoPRbuRzxPSp7atXUfB
 1YBkP5nZaJQ1KkngOFAwcAZDCXzHTa7u9SVJNuPiXS2Wwsi0eYe4gZnZnIKeg8MQ2APOz+PXy
 XOmiTdMMxuVgn48bnD8Kw1Cy5XKVXUIjyQPYnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_pages system call has an assigned number on all architectures
except ARM. When it got added initially in commit d80ade7b3231 ("ARM:
Fix warning: #warning syscall migrate_pages not implemented"), it was
intentionally left out based on the observation that there are no 32-bit
ARM NUMA systems.

However, there are now arm64 NUMA machines that can in theory run 32-bit
kernels (actually enabling NUMA there would require additional work)
as well as 32-bit user space on 64-bit kernels, so that argument is no
longer very strong.

Assigning the number lets us use the system call on 64-bit kernels as well
as providing a more consistent set of syscalls across architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unistd.h     | 1 -
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 88ef2ce1f69a..d713587dfcf4 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -45,7 +45,6 @@
  * Unimplemented (or alternatively implemented) syscalls
  */
 #define __IGNORE_fadvise64_64
-#define __IGNORE_migrate_pages
 
 #ifdef __ARM_EABI__
 /*
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 8edf93b4490f..86de9eb34296 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -414,3 +414,4 @@
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
+400	common	migrate_pages		sys_migrate_pages
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a7b1fc58ffdf..261216c3336e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		400
+#define __NR_compat_syscalls		401
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 04ee190b90fe..f15bcbacb8f6 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_migrate_pages 400
+__SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

