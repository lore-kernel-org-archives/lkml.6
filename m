Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824391-2-13777549206160739344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824390; b=c6fdX8jVv7oABksVct9c22dzW/7B4zuk7zdbQ6b4dBvWDHB
    iHpKm7sFWB67A/zyb1ZaGz+2PXb4nj+eFd2rD4X4buLQkfeQnwtFfRb1CP9S0qId
    LebW1mGYzeyRHmIjVp8Zt7lWd7HozjUhSwBYwMFGu4UerW0OTlUT80r3nSYwyDRJ
    +foDLoqsbgpsTA24hNK2Ievs/m2gys9gpI2HKYocu+OTZQIrlivHwCxvGC5n8IWH
    M78ll0qQ7JtZe9XIfZVWFLz36T3/XTp2S0W7bKhelnIwsdY7LKtmhuYREFUr7vn/
    KVgYw8rPcIXs+57BfE8DZBc/KRdUeg5wHD9KZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824390; bh=LWF0IMd/xYNSFoXyvzl
    Qwmsa0W+jQc4wDNoUOMoeXKo=; b=Ic0QUzD5pdTwX/4jXDC2zFvbKiIhHq2VI8s
    OWi/8UjMwKaOHD36BbQCv8ghF5ylwdFfZron7E4w5SiiClIZphOmymKu/Ym2JE7d
    oZ+yO5+jUM1bVv/nABB64TjkwXl1RBpAF7QQwwqIrm+jF+Pfuhc4zQMU9/zBMH8F
    45ckdiY1EUeXwplS6h2clSzlT8Qfhn6BHax2EEpyAXoNYPvLupi53aBTmvn6wNSS
    ouIkyZ4hy5AuqXmgV5oYK8fR5Zn05udKqhc+34XpUjkM5UvweQf8YtLLc1vu634D
    j+R9AV+jWPv4PaG9UrUiJb9V16aiuaUhTSkLUcyYwF2kmT/c/FA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeCLDNI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:13:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41572 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932799AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.863632578@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 71/76] x86: reorganize SMAP handling in user space
 accesses
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 11f1a4b9755f5dbc3e822a96502ebe9b044b14d8 upstream.

This reorganizes how we do the stac/clac instructions in the user access
code.  Instead of adding the instructions directly to the same inline
asm that does the actual user level access and exception handling, add
them at a higher level.

This is mainly preparation for the next step, where we will expose an
interface to allow users to mark several accesses together as being user
space accesses, but it does already clean up some code:

 - the inlined trivial cases of copy_in_user() now do stac/clac just
   once over the accesses: they used to do one pair around the user
   space read, and another pair around the write-back.

 - the {get,put}_user_ex() macros that are used with the catch/try
   handling don't do any stac/clac at all, because that happens in the
   try/catch surrounding them.

Other than those two cleanups that happened naturally from the
re-organization, this should not make any difference. Yet.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/uaccess.h    | 53 ++++++++++++++--------
 arch/x86/include/asm/uaccess_64.h | 94 +++++++++++++++++++++++++++------------
 2 files changed, 101 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -143,6 +143,9 @@ extern int __get_user_4(void);
 extern int __get_user_8(void);
 extern int __get_user_bad(void);
 
+#define __uaccess_begin() stac()
+#define __uaccess_end()   clac()
+
 /*
  * This is a type: either unsigned long, if the argument fits into
  * that type, or otherwise unsigned long long.
@@ -201,10 +204,10 @@ __typeof__(__builtin_choose_expr(sizeof(
 
 #ifdef CONFIG_X86_32
 #define __put_user_asm_u64(x, addr, err, errret)			\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	movl %%eax,0(%2)\n"			\
 		     "2:	movl %%edx,4(%2)\n"			\
-		     "3: " ASM_CLAC "\n"				\
+		     "3:"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "4:	movl %3,%0\n"				\
 		     "	jmp 3b\n"					\
@@ -215,10 +218,10 @@ __typeof__(__builtin_choose_expr(sizeof(
 		     : "A" (x), "r" (addr), "i" (errret), "0" (err))
 
 #define __put_user_asm_ex_u64(x, addr)					\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	movl %%eax,0(%1)\n"			\
 		     "2:	movl %%edx,4(%1)\n"			\
-		     "3: " ASM_CLAC "\n"				\
+		     "3:"						\
 		     _ASM_EXTABLE_EX(1b, 2b)				\
 		     _ASM_EXTABLE_EX(2b, 3b)				\
 		     : : "A" (x), "r" (addr))
@@ -311,6 +314,10 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * This doesn't do __uaccess_begin/end - the exception handling
+ * around it must do that.
+ */
 #define __put_user_size_ex(x, ptr, size)				\
 do {									\
 	__chk_user_ptr(ptr);						\
@@ -365,9 +372,9 @@ do {									\
 } while (0)
 
 #define __get_user_asm(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	mov"itype" %2,%"rtype"1\n"		\
-		     "2: " ASM_CLAC "\n"				\
+		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %3,%0\n"				\
 		     "	xor"itype" %"rtype"1,%"rtype"1\n"		\
@@ -377,6 +384,10 @@ do {									\
 		     : "=r" (err), ltype(x)				\
 		     : "m" (__m(addr)), "i" (errret), "0" (err))
 
+/*
+ * This doesn't do __uaccess_begin/end - the exception handling
+ * around it must do that.
+ */
 #define __get_user_size_ex(x, ptr, size)				\
 do {									\
 	__chk_user_ptr(ptr);						\
@@ -407,7 +418,9 @@ do {									\
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	int __pu_err;						\
+	__uaccess_begin();					\
 	__put_user_size((x), (ptr), (size), __pu_err, -EFAULT);	\
+	__uaccess_end();					\
 	__pu_err;						\
 })
 
@@ -415,7 +428,9 @@ do {									\
 ({									\
 	int __gu_err;							\
 	unsigned long __gu_val;						\
+	__uaccess_begin();						\
 	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
+	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;							\
 })
@@ -430,9 +445,9 @@ struct __large_struct { unsigned long bu
  * aliasing issues.
  */
 #define __put_user_asm(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	mov"itype" %"rtype"1,%2\n"		\
-		     "2: " ASM_CLAC "\n"				\
+		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %3,%0\n"				\
 		     "	jmp 2b\n"					\
@@ -452,11 +467,11 @@ struct __large_struct { unsigned long bu
  */
 #define uaccess_try	do {						\
 	current_thread_info()->uaccess_err = 0;				\
-	stac();								\
+	__uaccess_begin();						\
 	barrier();
 
 #define uaccess_catch(err)						\
-	clac();								\
+	__uaccess_end();						\
 	(err) |= (current_thread_info()->uaccess_err ? -EFAULT : 0);	\
 } while (0)
 
@@ -552,12 +567,13 @@ extern void __cmpxchg_wrong_size(void)
 	__typeof__(ptr) __uval = (uval);				\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
+	__uaccess_begin();						\
 	switch (size) {							\
 	case 1:								\
 	{								\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgb %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -571,9 +587,9 @@ extern void __cmpxchg_wrong_size(void)
 	}								\
 	case 2:								\
 	{								\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgw %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -587,9 +603,9 @@ extern void __cmpxchg_wrong_size(void)
 	}								\
 	case 4:								\
 	{								\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -606,9 +622,9 @@ extern void __cmpxchg_wrong_size(void)
 		if (!IS_ENABLED(CONFIG_X86_64))				\
 			__cmpxchg_wrong_size();				\
 									\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -623,6 +639,7 @@ extern void __cmpxchg_wrong_size(void)
 	default:							\
 		__cmpxchg_wrong_size();					\
 	}								\
+	__uaccess_end();						\
 	*__uval = __old;						\
 	__ret;								\
 })
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -56,35 +56,49 @@ int __copy_from_user_nocheck(void *dst,
 	if (!__builtin_constant_p(size))
 		return copy_user_generic(dst, (__force void *)src, size);
 	switch (size) {
-	case 1:__get_user_asm(*(u8 *)dst, (u8 __user *)src,
+	case 1:
+		__uaccess_begin();
+		__get_user_asm(*(u8 *)dst, (u8 __user *)src,
 			      ret, "b", "b", "=q", 1);
+		__uaccess_end();
 		return ret;
-	case 2:__get_user_asm(*(u16 *)dst, (u16 __user *)src,
+	case 2:
+		__uaccess_begin();
+		__get_user_asm(*(u16 *)dst, (u16 __user *)src,
 			      ret, "w", "w", "=r", 2);
+		__uaccess_end();
 		return ret;
-	case 4:__get_user_asm(*(u32 *)dst, (u32 __user *)src,
+	case 4:
+		__uaccess_begin();
+		__get_user_asm(*(u32 *)dst, (u32 __user *)src,
 			      ret, "l", "k", "=r", 4);
+		__uaccess_end();
 		return ret;
-	case 8:__get_user_asm(*(u64 *)dst, (u64 __user *)src,
+	case 8:
+		__uaccess_begin();
+		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			      ret, "q", "", "=r", 8);
+		__uaccess_end();
 		return ret;
 	case 10:
+		__uaccess_begin();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=r", 10);
-		if (unlikely(ret))
-			return ret;
-		__get_user_asm(*(u16 *)(8 + (char *)dst),
-			       (u16 __user *)(8 + (char __user *)src),
-			       ret, "w", "w", "=r", 2);
+		if (likely(!ret))
+			__get_user_asm(*(u16 *)(8 + (char *)dst),
+				       (u16 __user *)(8 + (char __user *)src),
+				       ret, "w", "w", "=r", 2);
+		__uaccess_end();
 		return ret;
 	case 16:
+		__uaccess_begin();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=r", 16);
-		if (unlikely(ret))
-			return ret;
-		__get_user_asm(*(u64 *)(8 + (char *)dst),
-			       (u64 __user *)(8 + (char __user *)src),
-			       ret, "q", "", "=r", 8);
+		if (likely(!ret))
+			__get_user_asm(*(u64 *)(8 + (char *)dst),
+				       (u64 __user *)(8 + (char __user *)src),
+				       ret, "q", "", "=r", 8);
+		__uaccess_end();
 		return ret;
 	default:
 		return copy_user_generic(dst, (__force void *)src, size);
@@ -106,35 +120,51 @@ int __copy_to_user_nocheck(void __user *
 	if (!__builtin_constant_p(size))
 		return copy_user_generic((__force void *)dst, src, size);
 	switch (size) {
-	case 1:__put_user_asm(*(u8 *)src, (u8 __user *)dst,
+	case 1:
+		__uaccess_begin();
+		__put_user_asm(*(u8 *)src, (u8 __user *)dst,
 			      ret, "b", "b", "iq", 1);
+		__uaccess_end();
 		return ret;
-	case 2:__put_user_asm(*(u16 *)src, (u16 __user *)dst,
+	case 2:
+		__uaccess_begin();
+		__put_user_asm(*(u16 *)src, (u16 __user *)dst,
 			      ret, "w", "w", "ir", 2);
+		__uaccess_end();
 		return ret;
-	case 4:__put_user_asm(*(u32 *)src, (u32 __user *)dst,
+	case 4:
+		__uaccess_begin();
+		__put_user_asm(*(u32 *)src, (u32 __user *)dst,
 			      ret, "l", "k", "ir", 4);
+		__uaccess_end();
 		return ret;
-	case 8:__put_user_asm(*(u64 *)src, (u64 __user *)dst,
+	case 8:
+		__uaccess_begin();
+		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
 			      ret, "q", "", "er", 8);
+		__uaccess_end();
 		return ret;
 	case 10:
+		__uaccess_begin();
 		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
 			       ret, "q", "", "er", 10);
-		if (unlikely(ret))
-			return ret;
-		asm("":::"memory");
-		__put_user_asm(4[(u16 *)src], 4 + (u16 __user *)dst,
-			       ret, "w", "w", "ir", 2);
+		if (likely(!ret)) {
+			asm("":::"memory");
+			__put_user_asm(4[(u16 *)src], 4 + (u16 __user *)dst,
+				       ret, "w", "w", "ir", 2);
+		}
+		__uaccess_end();
 		return ret;
 	case 16:
+		__uaccess_begin();
 		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
 			       ret, "q", "", "er", 16);
-		if (unlikely(ret))
-			return ret;
-		asm("":::"memory");
-		__put_user_asm(1[(u64 *)src], 1 + (u64 __user *)dst,
-			       ret, "q", "", "er", 8);
+		if (likely(!ret)) {
+			asm("":::"memory");
+			__put_user_asm(1[(u64 *)src], 1 + (u64 __user *)dst,
+				       ret, "q", "", "er", 8);
+		}
+		__uaccess_end();
 		return ret;
 	default:
 		return copy_user_generic((__force void *)dst, src, size);
@@ -160,39 +190,47 @@ int __copy_in_user(void __user *dst, con
 	switch (size) {
 	case 1: {
 		u8 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u8 __user *)src,
 			       ret, "b", "b", "=q", 1);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u8 __user *)dst,
 				       ret, "b", "b", "iq", 1);
+		__uaccess_end();
 		return ret;
 	}
 	case 2: {
 		u16 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u16 __user *)src,
 			       ret, "w", "w", "=r", 2);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u16 __user *)dst,
 				       ret, "w", "w", "ir", 2);
+		__uaccess_end();
 		return ret;
 	}
 
 	case 4: {
 		u32 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u32 __user *)src,
 			       ret, "l", "k", "=r", 4);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u32 __user *)dst,
 				       ret, "l", "k", "ir", 4);
+		__uaccess_end();
 		return ret;
 	}
 	case 8: {
 		u64 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u64 __user *)src,
 			       ret, "q", "", "=r", 8);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u64 __user *)dst,
 				       ret, "q", "", "er", 8);
+		__uaccess_end();
 		return ret;
 	}
 	default:
