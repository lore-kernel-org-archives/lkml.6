Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01013C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12FA20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfARQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:21:01 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfARQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:59 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZTyi-1gheoB1V02-00WSdJ; Fri, 18 Jan 2019 17:19:37 +0100
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
Subject: [PATCH v2 16/29] alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
Date:   Fri, 18 Jan 2019 17:18:22 +0100
Message-Id: <20190118161835.2259170-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jsOw7NqQKS2zQ2Kn3Rl+vMqYljPTdUEHSKVnWEW+0Z+etDrnxOY
 fHRBu4AJ2H9ITzOOnIQmu/LvPg6oaokuIwQkItp+qBdIdD7bxckPyZ8Sxs4NOwtEHCSAnUH
 PATcQhNN+ieYB856u8/+6Y9ZbSsp4EBrFe61HTPJVqvuCuDQ4awBecyCY2Y/F+xR0K6VrtS
 S0fFIjG7g4/x+H+4JviEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JL+1HsoFxsM=:cBJFwJBy7OBl33SJgynGOf
 EmNur2v4677HGSFzkbfaknFA95n0HTqqKB3lK8G36N+kfz/YYAgyNSQ0vsAdfHv8lhYMjGt9p
 M8WUKHlEr7hakd0YFqTMmYqzuRvf5OQhCO6VJWob6XAwR6tpdkRzOCkrG6G8sfDz0d6VY/hNz
 upEFggyCa4tZuOyNQJx/K1uvR42DpkBjNILmF7YFo+UwNzmRIGTttYrsBYHTpe1PkzRgVit+r
 j7SLw9Mb4BkxItIIOg0Qt2c5Oq54DLbA/d+tWgz6QwpjgSfDyguWB8kYlWaqTPuPH9rvSikR/
 z5iJ6+Y+g9zoUxtfCYnatVYC9tJKDuimc9MbGNzttROXmBklb/ksFc6NTsXvlop93uHH8kFZW
 EH8Uk0MtSGHSMNTx7TfNxVjZQD2p41Af7cdpQ0q7LLJMZ12Wiz3jRYV1s++sEe5YekYRPxPzI
 0UeWAqx5PBKwf0P5EIiRcD7zYJVp12kr6tChz9H4IAiwv9yHUyveQLYhjbD63KLNdQmOWwgxQ
 FDoUySY8h2BSH/6fWX31CKmRwF+KPHvEnrGvFcULjAx96+rWzASZopKWtsi/Oj9ONCxHrFK77
 zfvU9jlkJIiLbhOXwmibd0u52gtfrTcK5qxrB/RMFagbDTt5V/H0K7p98rbF0qtMgChfmWlw6
 9js9moRUD3b7UoD0g2g2uzOd41lIuDs6xFGHIXcYshauq1Q8Mf7vrPy5HgZEfkX3yFqd1V5g5
 9v/xHx798WmtLAP2+pB9Fa8UydU7D6olbZ12sQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha has traditionally followed the OSF1 calling conventions
here, with its getxpid, getxuid, getxgid system calls returning
two different values in separate registers.

Following what glibc has done here, we can define getpid,
getuid and getgid to be aliases for getxpid, getxuid and getxgid
respectively, and add new system call numbers for getppid, geteuid
and getegid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h        | 11 -----------
 arch/alpha/include/uapi/asm/unistd.h   |  5 +++++
 arch/alpha/kernel/syscalls/syscall.tbl |  3 +++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 31ad350b58a0..986f5da9b7d8 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -19,15 +19,4 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
-/*
- * Ignore legacy syscalls that we don't use.
- */
-#define __IGNORE_getegid
-#define __IGNORE_geteuid
-#define __IGNORE_getgid
-#define __IGNORE_getpid
-#define __IGNORE_getppid
-#define __IGNORE_getuid
-
-
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 4507071f995f..71fd5db06866 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -7,6 +7,11 @@
 #define __NR_umount	__NR_umount2
 #define __NR_osf_shmat	__NR_shmat
 
+/* These return an extra value but can be used as aliases */
+#define __NR_getpid	__NR_getxpid
+#define __NR_getuid	__NR_getxuid
+#define __NR_getgid	__NR_getxgid
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0ebd59fdcb8b..337b8108771a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -458,3 +458,6 @@
 527	common	rseq				sys_rseq
 528	common	statfs64			sys_statfs64
 529	common	fstatfs64			sys_fstatfs64
+530	common	getegid				sys_getegid
+531	common	geteuid				sys_geteuid
+532	common	getppid				sys_getppid
-- 
2.20.0

