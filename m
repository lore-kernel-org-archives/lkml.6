Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909662-2-6128972407009860720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909661; b=qG61dw6GdkQ0v86f3zEmvuAYBLmubcaxfnnSyDYcjeXKSQn
    pxdGw66DFGmd/0ILsdiDor4y+67iC4RhuFiShTHgMGIUN3Qd8ceFYVQeVfQw3yaC
    IHkTN/7z0JRcXUDtd3NCNc4VQhH8yE4TnyUCsgTZBUA+X8399YT6JS57alt9ysiC
    XW5vYn7YIHDDdDkhtH4xO/xP7oYmLY3VkEDOX225Kfu9PsJxl3FynWB9AfT+unuD
    N7AVENonOEJ9ihHswjCcdzWeqFDcBqZMKZgmYMP5U5RY1B6/jeRQuM0bP5vQn9wA
    +NcNKX6ywe8Hyq79voBDE7rzw1gmsI8yVGa4/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909661;
    bh=DuN6SyTg5l99yxUh5yRn/aUeDXw1S1qe26nBS+h01No=; b=QFBTKEtt0KUZ
    h94R+PsyF1+JJynr3lG60Hwmitz686MJ5tOnBeec1TPS0DdJ36FBVLoQIbeMHD0U
    sBXW67vIsJ8ZDaLAjY50XbZwncAc4i8RsFMFiaoitFvrr0NZJXFLuq+P0sjzyqPn
    c9WTbXlwn6RcA5ZIqs0uaCn+MlMq+HmUKjXng/cKfQB8Oe2GZOjKhsEI3XvwWsEy
    uIyAf0rH+V+eMPtWtWQLIksjid6xZIUZi/gaTpP1nf/7yorbej/3n3wPWSTDjdby
    GyxX3Vc8gMD9ogz8Z5MoaZ7L78/QtuG+IPFoVj/8U4sANEHw+aL5iYL5zORggSlP
    esrz8Rwfbw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=H7HFHdWR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QUY+VyOS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=H7HFHdWR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QUY+VyOS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030668AbeCAM4A (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:56:00 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34463 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030663AbeCAMz6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:55:58 -0500
X-Google-Smtp-Source: AG47ELvhyg1eGEAZevMH/odl+bSTRZmh1BoMQCmnO/m+ISoKOXKuP1mneN/pr1+d/ax1WrbLVDGj6A==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 06/45] arm64: Factor out PAN enabling/disabling into separate uaccess_* macros
Date: Thu,  1 Mar 2018 20:53:43 +0800
Message-Id: <1519908862-11425-7-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Catalin Marinas <catalin.marinas@arm.com>

commit bd38967d406 upstream.

This patch moves the directly coded alternatives for turning PAN on/off
into separate uaccess_{enable,disable} macros or functions. The asm
macros take a few arguments which will be used in subsequent patches.

Note that any (unlikely) access that the compiler might generate between
uaccess_enable() and uaccess_disable(), other than those explicitly
specified by the user access code, will not be protected by PAN.

Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/futex.h       | 17 ++++----
 arch/arm64/include/asm/uaccess.h     | 79 +++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/armv8_deprecated.c | 11 +++--
 arch/arm64/lib/clear_user.S          | 11 ++---
 arch/arm64/lib/copy_from_user.S      | 11 ++---
 arch/arm64/lib/copy_in_user.S        | 11 ++---
 arch/arm64/lib/copy_to_user.S        | 11 ++---
 7 files changed, 93 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index f2585cd..85c4a89 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -21,15 +21,12 @@
 #include <linux/futex.h>
 #include <linux/uaccess.h>
 
-#include <asm/alternative.h>
-#include <asm/cpufeature.h>
 #include <asm/errno.h>
-#include <asm/sysreg.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)		\
+do {									\
+	uaccess_enable();						\
 	asm volatile(							\
-	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,		\
-		    CONFIG_ARM64_PAN)					\
 "	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w1, %2\n"						\
 	insn "\n"							\
@@ -44,11 +41,11 @@
 "	.popsection\n"							\
 	_ASM_EXTABLE(1b, 4b)						\
 	_ASM_EXTABLE(2b, 4b)						\
-	ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,		\
-		    CONFIG_ARM64_PAN)					\
 	: "=&r" (ret), "=&r" (oldval), "+Q" (*uaddr), "=&r" (tmp)	\
 	: "r" (oparg), "Ir" (-EFAULT)					\
-	: "memory")
+	: "memory");							\
+	uaccess_disable();						\
+} while (0)
 
 static inline int
 futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
@@ -118,8 +115,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	uaccess_enable();
 	asm volatile("// futex_atomic_cmpxchg_inatomic\n"
-ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
 "	prfm	pstl1strm, %2\n"
 "1:	ldxr	%w1, %2\n"
 "	sub	%w3, %w1, %w4\n"
@@ -134,10 +131,10 @@ ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
 "	.popsection\n"
 	_ASM_EXTABLE(1b, 4b)
 	_ASM_EXTABLE(2b, 4b)
-ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
 	: "+r" (ret), "=&r" (val), "+Q" (*uaddr), "=&r" (tmp)
 	: "r" (oldval), "r" (newval), "Ir" (-EFAULT)
 	: "memory");
+	uaccess_disable();
 
 	*uval = val;
 	return ret;
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 811cf16..94e1457 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -18,6 +18,11 @@
 #ifndef __ASM_UACCESS_H
 #define __ASM_UACCESS_H
 
+#include <asm/alternative.h>
+#include <asm/sysreg.h>
+
+#ifndef __ASSEMBLY__
+
 /*
  * User space memory access functions
  */
@@ -26,10 +31,8 @@
 #include <linux/string.h>
 #include <linux/thread_info.h>
 
-#include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/ptrace.h>
-#include <asm/sysreg.h>
 #include <asm/errno.h>
 #include <asm/memory.h>
 #include <asm/compiler.h>
@@ -121,6 +124,44 @@ static inline void set_fs(mm_segment_t fs)
 	"	.popsection\n"
 
 /*
+ * User access enabling/disabling.
+ */
+#define __uaccess_disable(alt)						\
+do {									\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), alt,			\
+			CONFIG_ARM64_PAN));				\
+} while (0)
+
+#define __uaccess_enable(alt)						\
+do {									\
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), alt,			\
+			CONFIG_ARM64_PAN));				\
+} while (0)
+
+static inline void uaccess_disable(void)
+{
+	__uaccess_disable(ARM64_HAS_PAN);
+}
+
+static inline void uaccess_enable(void)
+{
+	__uaccess_enable(ARM64_HAS_PAN);
+}
+
+/*
+ * These functions are no-ops when UAO is present.
+ */
+static inline void uaccess_disable_not_uao(void)
+{
+	__uaccess_disable(ARM64_ALT_PAN_NOT_UAO);
+}
+
+static inline void uaccess_enable_not_uao(void)
+{
+	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
+}
+
+/*
  * The "__xxx" versions of the user access functions do not verify the address
  * space - it must have been done previously with a separate "access_ok()"
  * call.
@@ -147,8 +188,7 @@ static inline void set_fs(mm_segment_t fs)
 do {									\
 	unsigned long __gu_val;						\
 	__chk_user_ptr(ptr);						\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_ALT_PAN_NOT_UAO,\
-			CONFIG_ARM64_PAN));				\
+	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
@@ -169,9 +209,8 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
+	uaccess_disable_not_uao();					\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_ALT_PAN_NOT_UAO,\
-			CONFIG_ARM64_PAN));				\
 } while (0)
 
 #define __get_user(x, ptr)						\
@@ -216,8 +255,7 @@ do {									\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	__chk_user_ptr(ptr);						\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_ALT_PAN_NOT_UAO,\
-			CONFIG_ARM64_PAN));				\
+	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
 		__put_user_asm("strb", "sttrb", "%w", __pu_val, (ptr),	\
@@ -238,8 +276,7 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_ALT_PAN_NOT_UAO,\
-			CONFIG_ARM64_PAN));				\
+	uaccess_disable_not_uao();					\
 } while (0)
 
 #define __put_user(x, ptr)						\
@@ -332,4 +369,26 @@ extern long strncpy_from_user(char *dest, const char __user *src, long count);
 extern __must_check long strlen_user(const char __user *str);
 extern __must_check long strnlen_user(const char __user *str, long n);
 
+#else	/* __ASSEMBLY__ */
+
+#include <asm/assembler.h>
+
+/*
+ * User access enabling/disabling macros. These are no-ops when UAO is
+ * present.
+ */
+	.macro	uaccess_disable_not_uao, tmp1
+alternative_if ARM64_ALT_PAN_NOT_UAO
+	SET_PSTATE_PAN(1)
+alternative_else_nop_endif
+	.endm
+
+	.macro	uaccess_enable_not_uao, tmp1, tmp2
+alternative_if ARM64_ALT_PAN_NOT_UAO
+	SET_PSTATE_PAN(0)
+alternative_else_nop_endif
+	.endm
+
+#endif	/* __ASSEMBLY__ */
+
 #endif /* __ASM_UACCESS_H */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index c0ede23..29d2ad8 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 
-#include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
 #include <asm/opcodes.h>
@@ -285,10 +284,10 @@ static void __init register_insn_emulation_sysctl(struct ctl_table *table)
 #define __SWP_LL_SC_LOOPS	4
 
 #define __user_swpX_asm(data, addr, res, temp, temp2, B)	\
+do {								\
+	uaccess_enable();					\
 	__asm__ __volatile__(					\
 	"	mov		%w3, %w7\n"			\
-	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
-		    CONFIG_ARM64_PAN)				\
 	"0:	ldxr"B"		%w2, [%4]\n"			\
 	"1:	stxr"B"		%w0, %w1, [%4]\n"		\
 	"	cbz		%w0, 2f\n"			\
@@ -306,13 +305,13 @@ static void __init register_insn_emulation_sysctl(struct ctl_table *table)
 	"	.popsection"					\
 	_ASM_EXTABLE(0b, 4b)					\
 	_ASM_EXTABLE(1b, 4b)					\
-	ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,	\
-		CONFIG_ARM64_PAN)				\
 	: "=&r" (res), "+r" (data), "=&r" (temp), "=&r" (temp2)	\
 	: "r" ((unsigned long)addr), "i" (-EAGAIN),		\
 	  "i" (-EFAULT),					\
 	  "i" (__SWP_LL_SC_LOOPS)				\
-	: "memory")
+	: "memory");						\
+	uaccess_disable();					\
+} while (0)
 
 #define __user_swp_asm(data, addr, res, temp, temp2) \
 	__user_swpX_asm(data, addr, res, temp, temp2, "")
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 5d1cad3..d7150e3 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -17,10 +17,7 @@
  */
 #include <linux/linkage.h>
 
-#include <asm/alternative.h>
-#include <asm/assembler.h>
-#include <asm/cpufeature.h>
-#include <asm/sysreg.h>
+#include <asm/uaccess.h>
 
 	.text
 
@@ -33,8 +30,7 @@
  * Alignment fixed up by hardware.
  */
 ENTRY(__clear_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_enable_not_uao x2, x3
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
 	b.mi	2f
@@ -54,8 +50,7 @@ uao_user_alternative 9f, strh, sttrh, wzr, x0, 2
 	b.mi	5f
 uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
 5:	mov	x0, #0
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_disable_not_uao x2
 	ret
 ENDPROC(__clear_user)
 
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 4fd67ea..cfe1339 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -16,11 +16,8 @@
 
 #include <linux/linkage.h>
 
-#include <asm/alternative.h>
-#include <asm/assembler.h>
 #include <asm/cache.h>
-#include <asm/cpufeature.h>
-#include <asm/sysreg.h>
+#include <asm/uaccess.h>
 
 /*
  * Copy from user space to a kernel buffer (alignment handled by the hardware)
@@ -67,12 +64,10 @@
 
 end	.req	x5
 ENTRY(__arch_copy_from_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_enable_not_uao x3, x4
 	add	end, x0, x2
 #include "copy_template.S"
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_disable_not_uao x3
 	mov	x0, #0				// Nothing to copy
 	ret
 ENDPROC(__arch_copy_from_user)
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index f7292dd0..718b1c4 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -18,11 +18,8 @@
 
 #include <linux/linkage.h>
 
-#include <asm/alternative.h>
-#include <asm/assembler.h>
 #include <asm/cache.h>
-#include <asm/cpufeature.h>
-#include <asm/sysreg.h>
+#include <asm/uaccess.h>
 
 /*
  * Copy from user space to user space (alignment handled by the hardware)
@@ -68,12 +65,10 @@
 
 end	.req	x5
 ENTRY(__copy_in_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_enable_not_uao x3, x4
 	add	end, x0, x2
 #include "copy_template.S"
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_disable_not_uao x3
 	mov	x0, #0
 	ret
 ENDPROC(__copy_in_user)
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 7a7efe2..e99e31c 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -16,11 +16,8 @@
 
 #include <linux/linkage.h>
 
-#include <asm/alternative.h>
-#include <asm/assembler.h>
 #include <asm/cache.h>
-#include <asm/cpufeature.h>
-#include <asm/sysreg.h>
+#include <asm/uaccess.h>
 
 /*
  * Copy to user space from a kernel buffer (alignment handled by the hardware)
@@ -66,12 +63,10 @@
 
 end	.req	x5
 ENTRY(__arch_copy_to_user)
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_enable_not_uao x3, x4
 	add	end, x0, x2
 #include "copy_template.S"
-ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
-	    CONFIG_ARM64_PAN)
+	uaccess_disable_not_uao x3
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_to_user)
-- 
2.7.4
