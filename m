Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1142023-1526318128-2-2122924424625224229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526318127; b=cfLrX4sORSWxbX2fBLh5uPxnr1fOoQU6nFuDMqfRXQ9sB5WUG/
    0jJGXdISCW7E63SlEG86n1Zc0jJcDBfhdiWAVbPwW2NjHVzOq1ZcRTHCQyz2EaND
    PLSCg1IhRfCPcTv0si2iKg3h9bRPdWrHN4CunVWN9goytnudBrPsEkjyapBmzJXz
    97NFas7pz8XEAswPify4a85FCPq36SCe07ue6P+3XAuQOHk667Jxwa88rxSu+r7l
    yjFNQueYMC1cMNyKz1vGnK50FKO8zffMHe55Xgsa0URCP4f5yDjdr2WXQWCWxk0y
    6AHBd/cDB8iVwKaIAgUDI0k9RhObeP9P0hdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526318127; bh=
    i7kcUAjX4hkCW1ZNZSv8o/lUaBteICz2MEzb1A7dwIA=; b=DIsRFNJWibF1i711
    ry7DULyjnm8Eaf7wt+4lPrf4XhTK6Ai4DuXJjadZg3DIkkQVzj30az3oQr745DzW
    nxw1FiB0Rr/Ygdi/ry/886JmXzIcKaOnmcQknN3/ugxrkVjMQNq8Kbzf5Bsy/iIF
    0UWvSdnPkh2VwXFUP8cEN3h+23aZsHV1C7I3fKCx7D1m+AuQ8Gr3cXBDoYXOg7ui
    10g57q7Br60TCBawbRw83Nhfmi7v4aU7oZQ+FBOIEAPsEKSxT5WUOIoQnYvVOqj2
    M+mBrcw2Vxwb0T6NsRUY4L0iSAXyuzrCRTOjOVifttiVKXnZtCIqKIqOVwYjPaPv
    eVv5Hw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJtfD75Aa77IJiTRaQxrM4HVoNZlS3bvQA9PRpWQoldgOlXzVeuZkaOrZkPXrZo4u8qnFrUYixALdTP4pL8jaMVdchCoPnv+smYM1fUzf+l0ZW+OYG3l
    MgKwtsFrd6ZZG5DmeBQI95DAEp9GZcC8RIJgI7Buk/1eOv40H6mAgmgJFzoaZvrzZAdU/w8SW78SP3c+7DhJChhrg9/WDNAoKAdDqWb9xmM+v+hMNVo6oavV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=Z4Rwk6OoAAAA:8 a=wMNdZWldAAAA:8 a=QyXUC8HyAAAA:8 a=oGMlB6cnAAAA:8
    a=VwQbUJbxAAAA:8 a=tOO0nKmCAAAA:8 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8
    a=hGzw-44bAAAA:8 a=WPyIoOwQAAAA:8 a=rWkr9Ua9AAAA:8 a=hAG5_4vcAAAA:8
    a=krXkYPs_fn3HokzHESkA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=FUarYpL4UH3yWsho8X8J:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Gz67Kf0DkuxJ4rqyVRET:22 a=xmb-EsYY8bH0VWELuYED:22 a=HvKuF1_PTVFglORKqfwH:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=Qv-QrLrHZjTXZfLJ-zom:22 a=8Bh8Pg2EFav9IBZ9i9Tn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeENRP0 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:15:26 -0400
Received: from foss.arm.com ([217.140.101.70]:46922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeENRPZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 13:15:25 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Hogan <jhogan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH 01/11] prctl: Support movement of arch prctls out of common code
Date: Mon, 14 May 2018 18:14:17 +0100
Message-Id: <1526318067-4964-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The core framework for the prctl() syscall is unloved and looking
rather crusty these days.  It also relies on defining ancillary
boilerplate macros for each prctl() in order to control conditional
compilation of the different prctl calls.  We have better ways to
do this now, using Kconfig.

This patch defines a new arch hook arch_syscall().  Architectures
that implemement arch-specific syscalls can now select
HAVE_ARCH_SYSCALL in their Kconfig and define this function
appropriately.

The core prctl() implementation now matches option against the list
of common or legacy prctls, deferring to prctl_arch() if an
unrecognised option is encountered.

(arch_prctl() would have been a nicer name, but it conflicts with the
pre-existing syscall of the same name on x86, particularly in the um
code.)

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James Hogan <jhogan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86@kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/Kconfig                     |  3 +++
 include/linux/prctl.h            | 19 +++++++++++++++++++
 include/uapi/linux/prctl.h       |  6 +++---
 kernel/sys.c                     |  2 +-
 tools/include/uapi/linux/prctl.h |  6 +++---
 5 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/prctl.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665..b34b3e8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -969,4 +969,7 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_PRCTL_ARCH
+	bool
+
 source "kernel/gcov/Kconfig"
diff --git a/include/linux/prctl.h b/include/linux/prctl.h
new file mode 100644
index 0000000..5ce3713
--- /dev/null
+++ b/include/linux/prctl.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PRCTL_H
+#define _LINUX_PRCTL_H
+
+#include <linux/errno.h>
+#include <uapi/linux/prctl.h>
+
+#ifdef CONFIG_HAVE_PRCTL_ARCH
+extern int prctl_arch(int option, unsigned long arg2,
+	unsigned long arg3, unsigned long arg4, unsigned long arg5);
+#else
+static inline int prctl_arch(int option, unsigned long arg2,
+	unsigned long arg3, unsigned long arg4, unsigned long arg5)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* ! _LINUX_PRCTL_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index af5f8c2..c911ff0 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_PRCTL_H
-#define _LINUX_PRCTL_H
+#ifndef _UAPI_LINUX_PRCTL_H
+#define _UAPI_LINUX_PRCTL_H
 
 #include <linux/types.h>
 
@@ -207,4 +207,4 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
-#endif /* _LINUX_PRCTL_H */
+#endif /* _UAPI_LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index ad69218..5077f1e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2451,7 +2451,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = SVE_GET_VL();
 		break;
 	default:
-		error = -EINVAL;
+		error = prctl_arch(option, arg2, arg3, arg4, arg5);
 		break;
 	}
 	return error;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index af5f8c2..c911ff0 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_PRCTL_H
-#define _LINUX_PRCTL_H
+#ifndef _UAPI_LINUX_PRCTL_H
+#define _UAPI_LINUX_PRCTL_H
 
 #include <linux/types.h>
 
@@ -207,4 +207,4 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
-#endif /* _LINUX_PRCTL_H */
+#endif /* _UAPI_LINUX_PRCTL_H */
-- 
2.1.4
