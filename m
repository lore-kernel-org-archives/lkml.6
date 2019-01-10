Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F762C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8E120685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfAJQ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:26:22 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:55305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfAJQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBDrM-1gZMT62Rmo-00CiB7; Thu, 10 Jan 2019 17:25:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 01/15] ia64: add __NR_umount2 definition
Date:   Thu, 10 Jan 2019 17:24:21 +0100
Message-Id: <20190110162435.309262-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AJT9SA8ciXw9tl+ZARfbMSJs7t7q7UPbK07TS1vkYi4fGRqmOxx
 AzigR/HepSHxzAtR37bpzxx0eGkGZ5xopih9slk2sajL2Y8iO5R4MzWIjYXabHCb7bInRu1
 vsNYQrqZWKPK8kqtpil2DEtQ/n/5Hq6pvEuRQVTxFUv9LuD45rAegpfUfRz8g1juc+SsTJ+
 0pTxXXrORP8FWsPcCwG3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4s/WZzVcApA=:kwrITPJtoivbXgR/XzcfCS
 pkpYqFhFQlsQKyMLy0+MrE9SargRvRxEGO4xzxwge96oOr5l1XOy4jx706ANglgWL9byXxHn0
 U0cKuYrCaviwkYroBqt9qaJtzty3wADcxNrGuhT/zOTS2Q7Riz7IldHuX16KeEFWyFm9mVs6s
 8HPk/+/EeX3wXNkvEzDUsJi20pKrDln6oB6JOlFFhxQy6oKY3pbYUa7k5AVgF1sY4X05OCgRD
 1XazxnJOTB2CtkJmbzIrNy8Kn3A1kKGRJBn9SSKU3Y01tG95Gbv7JvUys756+Ab/XB4Kb/3uz
 14AvsTl6oMGIlt0iQvDgNM5AXJmysWUBi/8pVmTlamH5towGC6GBIlPf/RnIeC/xadg1vwbPY
 CK7mVUtRTIpLCF6opAKESPZRLgVDgbLJxJtpnUMjbeXBJYJ0lolbmQUf7DAqcucufESRA+X2K
 qsq3Fp9zfaSs5wYDB5NfaClfWR480puynSpdi2q0LsppTn1R+5c4cKDaRHgBeNOz5vNaQwF6k
 HyQt4U0Tby8GuKvK9KESlpyGIspX8yJg/8BFohJ3i2L43KBIi4/mQuaZ+6LZgIpQBNLSFoDDl
 ctgwLUHXdAcq3PK0w4FpbE3J2GtUBNh+7d1JDDuuBTJRzPf0JmoOLS14+7q3FpYwmfEOfLplU
 ziJz0sQvp3H42S/DKH79DPgqf1HYmuJuhwRYG8JOBcfVdPbO+ug9KRAcg/y1QFSy85WLtTeSL
 bTU5u3uIKFITRGobPHpTko1au4thKRmfFGSVQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

The __IGNORE_* lines are now all obsolete and can be removed as
a side-effect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/unistd.h        | 14 --------------
 arch/ia64/include/uapi/asm/unistd.h   |  2 ++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 0b08ebd2dfde..9ba6110b10b9 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -12,20 +12,6 @@
 
 #define NR_syscalls		__NR_syscalls /* length of syscall table */
 
-/*
- * The following defines stop scripts/checksyscalls.sh from complaining about
- * unimplemented system calls.  Glibc provides for each of these by using
- * more modern equivalent system calls.
- */
-#define __IGNORE_fork		/* clone() */
-#define __IGNORE_time		/* gettimeofday() */
-#define __IGNORE_alarm		/* setitimer(ITIMER_REAL, ... */
-#define __IGNORE_pause		/* rt_sigprocmask(), rt_sigsuspend() */
-#define __IGNORE_utime		/* utimes() */
-#define __IGNORE_getpgrp	/* getpgid() */
-#define __IGNORE_vfork		/* clone() */
-#define __IGNORE_umount2	/* umount() */
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_UTIME
 
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index b2513922dcb5..013e0bcacc39 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
 
 #define __NR_Linux      1024
 
+#define __NR_umount __NR_umount2
+
 #include <asm/unistd_64.h>
 
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b22203b40bfe..e97caf51be42 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 17	common	getpid				sys_getpid
 18	common	getppid				sys_getppid
 19	common	mount				sys_mount
-20	common	umount				sys_umount
+20	common	umount2				sys_umount
 21	common	setuid				sys_setuid
 22	common	getuid				sys_getuid
 23	common	geteuid				sys_geteuid
-- 
2.20.0

