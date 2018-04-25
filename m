Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672679-2-13649498514155468970
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672678; b=t+6OApRO/v6pTeutL/zViiLBd1EZsIQUaY+jv5QDDZ2/5RryI+
    YL6B8KJsv03CnRTX5rdV8j/eLmK8SCpLSFZaBf89Tckv64OcLZqtM6PuZYtpQEom
    W4LNUAdQZvjPBR7sh5gCEp4bwonR1oOAHE3TSoxHFv8eGYgRkF/rxEKRZS4nyvSR
    UtHOg/nvY+yMgFzRbziTrjhhVKeRVxWtWGL+6GWXLYf470yblrqW6PIxM0tRsVAw
    lFegp3mpGx8x2Osco26GU5ui3MNbnuylqyxIV9hfGidTOGmpR12YQlAWRgxlSQv7
    ix+IeLTNCFYqOfi63zxWr3jc2YQL2MOlHBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672678; bh=
    4vd8OXlTfSTr+JrBwlcK33XSPqj6DQxgyqNWoyLHG+8=; b=KQe8W3SR7CbX/Drg
    SDjzbpAqwZOqUWN4g0jav31LgUMMtb8Qp87PUKh88j4IPO+9yB+6rX6AZkzTiGpJ
    N9Rb34Q/kc57hK8idV1VDNlLz7c29v2N70ARAEZmug8yrxzVnkR1RZT0NVXL4eQp
    XWqA+Ms2F0qxJi3BnhgWvPf9UF/kUHYaWmaSJAbgp8H1oEd3oQfz8zxh7/Js8F1H
    c/sP2pwyjEzFhcUZzXahsgFGIEUjXk6RIIEcg36nvLLO6J0Xw0HTFIu+fU7OUwab
    KglPNwHqw6liXC8sCGSukxvUoZjsxFI1KzXohoM9oMJjrBaXO26EsGX1PDmElS2F
    elgdTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfEyQPU4cfOtGHY3NlZo6GpQ7aRCOB6YsL0Vz/jxBEPiIVgOkdwLtD1Yj7yZo+/6pjc9LLLGy7sfC0mikjfQXbGi8vwDD9Obw2/QhDhlgxaKU6OAaGzg9
    aKIHB5vcKgD/TeW6n6dDfLq1HhmFdMxMzrm+nKAuODtXa10tUfbsmFf/BICGFO3oFTxoW+lB6mu2WCApqtYjDol7ETdZHj6ImWgCGExudyFXlkYHJpkNht6U
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=QhgII6dfkVvzS3v_z60A:9 a=eVA8P2CTddPxwPqW:21 a=0i5QKoeIqLwfcYKo:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbeDYQLH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:11:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbeDYQET (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:19 -0400
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
Subject: [PATCH 03/17] y2038: Remove stat64 family from default syscall set
Date: Wed, 25 Apr 2018 18:02:57 +0200
Message-Id: <20180425160311.2718314-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:kMuA/c47LV8E6q1W2aiOdOsUp3cl6mxC8TV14TRM6xgAatZ9/15
 2dDkNUQDASJoNI/eAUAnfYqiUT4gzkRxvhc6oNjSnrj7mxdHkFpbkYqoekgLrP6g7gcRk3g
 svyqQzStfHQ0cxFalZs6bi7fSt6dwqPeUsKRt+w3489pvFlapiRc9esrJQ6R+RD/LtQdba6
 lKHrFIB3g9obLDkqwT9Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7uiQpXHC848=:mBxjrN0EXu38QOlmHaaN7a
 NxwMLu/9I44+PdkuAPpu1/d7A0UOFxHkDv0eA5PH64E87aGsknKcPulT0Sd7DDU7j8Dz7IN+x
 O5e3KM0YB4+oCzDfbxCj8gUfJhyuP284y2ay3Qt4UR4gpq92onmcjlkZ5HM4HqG+nqSVspSUY
 DVHr2ABKX8niumES+QCMbnWthIUJOpOOh67jdrgYUZDe7eH9E2CaBZ4RF7+2UY88B4ZEhWLmf
 rnreuerQX5jpScKnXcOUCCpd8Oqo89/4cvsD9EZOr/n2Skg3bK9LANzAZ/4Y9UHs77Ed8eOGJ
 /aAbKsKY8bXgMxU6IfIL+n0F8vsaXnp7wqPMhj6lPy7O8sb4CXAZAuGnOLxags7kcA3ayCwae
 KyXUiQuNl0nOTfJzFCyoGa+jiIYL9CWEKSRF+4jWc6DIFMLzkLP/hR/z22oX0EjeTCGLSYKms
 KhNXjWGaPuFwheoio1/W2X/uF9AgJ8xTAm7vURlwp6NryYcYm9bFXeKik2uKBe3S9yIc1YLZz
 5R7tWbnMZ5BQMrKSNkcpceNp75WNX9bIrR5fljpN29dBBT5BuhrFL5Kf/bFgUZsu+yY2QoISy
 eUynAlXAuIctili0Kn3PS7uja87S7dUDzF9XuGw0CVvxkoruF0DF5e3EFZ+rHsZQ0BWyiFUmu
 DlnD1VwC/aQOxZFJkRsNa5VE6xvAwfEaUNDFVtDMuL2DE3zavONviF0fohv+wGATqdew=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 8bcb186c6f67..ce6a26c596e8 100644
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
2.9.0

