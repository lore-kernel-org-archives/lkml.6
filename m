Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF47C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1472D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1472D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeGZJar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:30:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60869 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbeGZJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:30:47 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lx7s1-1g27Ml2ctV-016hjM; Thu, 26 Jul 2018 10:14:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Michal Marek <mmarek@suse.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [stable 4.4] turn off -Wattribute-alias
Date:   Thu, 26 Jul 2018 10:13:24 +0200
Message-Id: <20180726081358.3829157-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726081358.3829157-1-arnd@arndb.de>
References: <20180726081358.3829157-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GihAiSmE8BnNsDQw6v3tzy9UyBR1tQ3B1YBbajITLQOYOObhYz1
 4QSBxBUTuN3YulbopGq08LbM0SQlY1DMuSPsAixqoD5O9Ybh8KZp0hS/2GJ/VticnvZc7z3
 cOHMMmUJryqgzB9eRyQJJk9rylTjB29Pwk3xTPIsgos4sMv3oG363Isb5RjQn2mITh6kOWR
 FSdhPuAY6Bp3unR7+BSGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gOUurGlAMi4=:PVZ2qdz1z2WbcKJsnnuCan
 GmDUeeRNaJL/lqHR5Ihvp3kxgF3+niHVjOUGux9ab4Rz9gevRKfeijcIw3MUobj5PRC2WYiuA
 GhFNo6ot7yWoIjBLyvxBaxN2xL9EznJJd/lfloGqreoyuxU+jWRBLiy8A0PyOChBzc+S0d5HQ
 yEgEz2esRE7k/l7R/s4MZnnX6O+068TDBXZLileyFcDbsTMIOwT7Vma1MK7kQ3rfwLJgHu8wQ
 ++WNUFKIFNm8YALDhu7AafDhFlIyp6qfCwy7fRG3jJPVyrgkEoO27xFxD22i9WCXJDPpjiATR
 RBA2OkCWpUGkx3u7zJgCGM8qJNvAwvvbTBwuK+Z/USJWHvKZ6qAMJNsODqdJ4lVl0nDYpG7o3
 bJx5FtsysJouXxok+xUUt1/FLsZsJyn50xLuSKIhw89QibKUQMD+lIoJxh2oQrGH/gSfNYcvN
 C6qBb1KCC9XscqavRmed1/Dtm7owR79ABQA9o0KMj/GB1jGnlo6+4HWVqYH3am5/F+zTB9V4X
 GChY0c4LI+V1AZKqlftCP4gzW5acax4qgkBrYMXFrGvks+KSWH2g+IsjvwKrAHUNV1NaqBlEK
 9WwQ7aassc+qFq+x1izpPQiZXDf2Lw2wpT0iqbRD1vYkbsOpDgytZYm3l4KVvvKiEMLMZNNqz
 geDFwZSKtyZc+74eCMOUHWQx+nRR5XcsSEjcROjXN18R+EF4myFgx5iYLeAHIFd2rgHM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with gcc-8.1, we get a warning about all system call definitions,
which use an alias between functions with incompatible prototypes, e.g.:

In file included from ../mm/process_vm_access.c:19:
../include/linux/syscalls.h:211:18: warning: 'sys_process_vm_readv' alias between functions of incompatible types 'long int(pid_t,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)' {aka 'long int(int,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
 ^~~~~~~~~~~~~~~
../include/linux/syscalls.h:215:18: note: aliased declaration here
  asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,

This is really noisy and does not indicate a real problem. In the latest
mainline kernel, this was addressed by commit bee20031772a ("disable
-Wattribute-alias warning for SYSCALL_DEFINEx()"), which seems too invasive
to backport.

This takes a much simpler approach and just disables the warning across the
kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 54690fee0485..4812b35df210 100644
--- a/Makefile
+++ b/Makefile
@@ -624,6 +624,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os
-- 
2.18.0

