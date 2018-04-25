Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672438-2-1468386407775837982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensvnl, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672437; b=shO4dOCfLk0vfHDGm9S4S7+ezmRPZx94NDRVQZN+t6kkeNpEva
    xDVkhtSB8k1kBBo2ehDJCYMCaVCe9sxDJVmc+Qr+LstkdXL0bk9MNidUBAresqxq
    I7PoK737a3WXxdkXE35c2xMu/d5IB6D9n8r0BtnZk0DFi+Yj4DE7k4DDa7D4yjOQ
    mGv5nHMTi2XB/rmmnxb4ymjmdZSd8cZhiWf8AscSP7HQKc+kArtfj7kZu/vzLXL1
    AvGBjBEboaTAXF0NfAlLpMM7ogRau80m6ceQCdkrRNV+s8Pwh6ydHiC2ULN1uz+1
    ctqu7++EfCHvLgxfALmimF6QAM8kit2DZy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672437; bh=
    Sz50PIc1WGoaJozL3xYQPkgkeOTZ5XGcVuczWGXt7Ec=; b=M/T52QCZuwoLlff8
    qaWQTK2GiSrJfdjEJmylXcZuNBPG8JqMppVEDb16OwqMnLbsZdgQMhJQyf38h+Iq
    sLsXwQIFGs4UMNTizIjjmaHZyf1H1Xcx+1/wiu8J8jbCh0bBpu7N4cw4MY0UQKqB
    MiFb+CQGzNidaG4NKA51k0Ie3LUzqm06ry3xtO5YiSEMiqiG0EDEJ0F3mMGsqCuW
    RKbKEPzjfDKe8K1wx7aZTjA4FT/IPhHaFDXWhosYp//Vi6IXkEFmkmt17fZtLF0z
    dCVUK7MnTmjWNPbw2Oud1hdatTtU5yEQJwGPGsLaIJt6IzRWj3NImkfqE2A3ejeo
    SGU0Pw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF+l8u4t5JdoEhB7nEqb2hLmWGIP4Q5JvXf4ZDmV0ZvIDoxiol60cbOV7l49hTnqRXtSGzJ6+qX54HYD7R5vvXWxayb2DXRpX1O6RnBklQfKxhLMAuQz
    Nsl9lLL+rWO4sgivyO3cmdwqHcHUkrTPQFCOsQttzI6I2d1JgRYQ9PCtJVepnaepBoASvAxitwNljGBCZ7HxHe51J/K9VBuh+oUoPQohlpbvvVHdYEI8yRsT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=hfKzGWloNtC3uFMtx0wA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbeDYQGg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:06:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755156AbeDYQF1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:05:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 04/17] asm-generic: Remove unneeded __ARCH_WANT_SYS_LLSEEK macro
Date: Wed, 25 Apr 2018 18:02:58 +0200
Message-Id: <20180425160311.2718314-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:JxvRsHB1k6SJGigXsJjEGgLSwwZKUUr2rQ7A1SI1o5ybwwciWxb
 1maoLkfrLvrV2VadmhBWMxrfsrhtaLU6dGWVciENpfB25CE8FKLFiCTqVN+I7aJ0NH1QYhL
 MM4uuJU4vN25g1n+NheSQtyCS6waybcO0jSce/hVyE72/v1WvO50m4OrHK8Ur21mZ8XnfTP
 w2/XTf9MdzORrAk+qkjLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZniTOUg+Jak=:Gz78YFQtfeSdVTGvQZvNvU
 wFHxi82gMCU74Ntefd8i+zD50PAnIQlpYrKl/ionOx/BvEi9SIUt9bzKppvuY474F8/uKEbIy
 mgGOCyk0qM7S+9TE0QZljBumnwlHI6qKA7mGofc1A2q2yWNPdlYJeEkhXfglhj49CMpCCJ6pq
 SUfcwxV+mZJtlr2ieEYYxxu+luxkDkdjA22zIkDaTaMWg+XK/9Bh+9k6N/rDYOW23B8OqE5yA
 Zbt9vLI23NfntRJoanrAK3QCFI7sy6wT2x1RrwT+3Jk3VXzNsMTPp+FTFmjtI8nBQ449Wwthh
 Sjwh3+YfB+sSBDStgWiT0eK6/RswUBmx4dB0goi9YoQKRWfNFO0VTuIOMkXKckiblpKO+rN+G
 HEoMSW+qhMcezKQkndNSrX9oZuZOTMGznEjY11GVaVxcJ1QYwT4Me75a0z5yzai1helwDc0XW
 zvB4V9YhLiyiwksa4vJvCbniaQ4kgiZmblBLImKX0B2bkElrlQcAXs/GJ0FtkUhv0Fa0UyLol
 tcisl2StyOqS9w4M0nkacgfFdLPLl4klg3aMGcJJ0KKfyr32YLCHkG7tP1Lxia5mZnT3nrPAy
 KX3Mb8WoAQ4nv3p6mQAUGSyp3OwkU1EMbqVgPiKPulJOG0wQZ4EfzaRgfcmEVwnL5xnnzQ6xw
 SZdodsZ2RmIgwA/N1a0dAWVKXkgu5NC0U8OTuri3LDYbUO2iIJHz7YvrP7jJ4t5kNyz8=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sys_llseek sytem call is needed on all 32-bit architectures and
none of the 64-bit ones, so we can remove the __ARCH_WANT_SYS_LLSEEK guard
and simplify the include/asm-generic/unistd.h header further.

Since 32-bit tasks can run either natively or in compat mode on 64-bit
architectures, we have to check for both !CONFIG_64BIT and CONFIG_COMPAT.

There are a few 64-bit architectures that also reference sys_llseek
in their 64-bit ABI (e.g. sparc), but I verified that those all
select CONFIG_COMPAT, so the #if check is still correct here. It's
a bit odd to include it in the syscall table though, as it's the
same as sys_lseek() on 64-bit, but with strange calling conventions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unistd.h        | 1 -
 arch/arm64/include/asm/unistd.h      | 1 -
 arch/m68k/include/asm/unistd.h       | 1 -
 arch/microblaze/include/asm/unistd.h | 1 -
 arch/mips/include/asm/unistd.h       | 1 -
 arch/parisc/include/asm/unistd.h     | 1 -
 arch/powerpc/include/asm/unistd.h    | 1 -
 arch/s390/include/asm/unistd.h       | 1 -
 arch/sh/include/asm/unistd.h         | 1 -
 arch/sparc/include/asm/unistd.h      | 1 -
 arch/x86/include/asm/unistd.h        | 1 -
 arch/xtensa/include/asm/unistd.h     | 1 -
 fs/read_write.c                      | 2 +-
 include/asm-generic/unistd.h         | 9 ---------
 14 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 07e58010d597..8f1159c26f20 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -21,7 +21,6 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a0baa9af5487..5c3c1398c62e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -18,7 +18,6 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index db22cdadc38a..e680031bda7b 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -22,7 +22,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_MMAP
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index 62ee12c247c1..8921ba34d733 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -27,7 +27,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 /* #define __ARCH_WANT_SYS_OLD_GETRLIMIT */
 #define __ARCH_WANT_SYS_OLDUMOUNT
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index d7878b3e16d8..c2174b80e50e 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -34,7 +34,6 @@
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_UNAME
 #define __ARCH_WANT_SYS_OLDUMOUNT
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index b36273bacca7..a0c38374fff0 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -156,7 +156,6 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index d78c1f49272d..fb8fb304ceaf 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -36,7 +36,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_UNAME
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 1d181373288a..a2d583ea526d 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -26,7 +26,6 @@
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_MMAP
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index a845b57eac69..a99234b61051 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -20,7 +20,6 @@
 # define __ARCH_WANT_SYS_SOCKETCALL
 # define __ARCH_WANT_SYS_FADVISE64
 # define __ARCH_WANT_SYS_GETPGRP
-# define __ARCH_WANT_SYS_LLSEEK
 # define __ARCH_WANT_SYS_NICE
 # define __ARCH_WANT_SYS_OLD_GETRLIMIT
 # define __ARCH_WANT_SYS_OLD_UNAME
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 3544244685e1..f7514d3eae7b 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -34,7 +34,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 35b66bbf8028..153d2a5e6b02 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -38,7 +38,6 @@
 # define __ARCH_WANT_SYS_FADVISE64
 # define __ARCH_WANT_SYS_GETHOSTNAME
 # define __ARCH_WANT_SYS_GETPGRP
-# define __ARCH_WANT_SYS_LLSEEK
 # define __ARCH_WANT_SYS_NICE
 # define __ARCH_WANT_SYS_OLDUMOUNT
 # define __ARCH_WANT_SYS_OLD_GETRLIMIT
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index 0d532ab60b37..574e5520968c 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -8,7 +8,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_GETPGRP
 
 /* 
diff --git a/fs/read_write.c b/fs/read_write.c
index c4eabbfc90df..8f50b5f9bbd6 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -331,7 +331,7 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
 }
 #endif
 
-#ifdef __ARCH_WANT_SYS_LLSEEK
+#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
 SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		unsigned long, offset_low, loff_t __user *, result,
 		unsigned int, whence)
diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index ea74eca8463f..71d2fcf9dbcd 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -1,12 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <uapi/asm-generic/unistd.h>
 #include <linux/export.h>
-
-/*
- * These are required system calls, we should
- * invert the logic eventually and let them
- * be selected by default.
- */
-#if __BITS_PER_LONG == 32
-#define __ARCH_WANT_SYS_LLSEEK
-#endif
-- 
2.9.0

