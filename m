Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECB5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B921763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5B921763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeHMMIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:08:49 -0400
Received: from exmail.andestech.com ([59.124.169.137]:26328 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeHMMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:08:48 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7D9Ptbd066566;
        Mon, 13 Aug 2018 17:25:55 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 13 Aug 2018
 17:27:09 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, Zong Li <zong@andestech.com>
Subject: [PATCH 2/3] nds32: Clean up the coding style
Date:   Mon, 13 Aug 2018 17:26:52 +0800
Message-ID: <86e0f46fa65b66142f5ac2b777957f03cfd26d64.1534151351.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534151350.git.zong@andestech.com>
References: <cover.1534151350.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7D9Ptbd066566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Adjust indentation.
2. Unify argument name of each macro.
3. Add space after comma in parameters list.
4. Add space after 'if' keyword.
5. Replace space by tab.
6. Change asm volatile to __asm__ __volatile__

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/include/asm/uaccess.h | 201 ++++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 98 deletions(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 3f771e0..e1a2b5b 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -38,7 +38,7 @@ struct exception_table_entry {
 extern int fixup_exception(struct pt_regs *regs);
 
 #define KERNEL_DS 	((mm_segment_t) { ~0UL })
-#define USER_DS     	((mm_segment_t) {TASK_SIZE - 1})
+#define USER_DS		((mm_segment_t) {TASK_SIZE - 1})
 
 #define get_ds()	(KERNEL_DS)
 #define get_fs()	(current_thread_info()->addr_limit)
@@ -49,11 +49,11 @@ static inline void set_fs(mm_segment_t fs)
 	current_thread_info()->addr_limit = fs;
 }
 
-#define segment_eq(a, b)    ((a) == (b))
+#define segment_eq(a, b)	((a) == (b))
 
 #define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
 
-#define access_ok(type, addr, size)                 \
+#define access_ok(type, addr, size)	\
 	__range_ok((unsigned long)addr, (unsigned long)size)
 /*
  * Single-value transfer routines.  They automatically use the right
@@ -75,46 +75,48 @@ static inline void set_fs(mm_segment_t fs)
  * versions are void (ie, don't return a value as such).
  */
 
-#define get_user(x,p)							\
+#define get_user(x, ptr)						\
 ({									\
 	long __e = -EFAULT;						\
-	const __typeof__(*(p)) __user *__p = (p);			\
-	if(likely(access_ok(VERIFY_READ, __p, sizeof(*__p)))) {		\
+	const __typeof__(*(ptr)) __user *__p = (ptr);			\
+	if (likely(access_ok(VERIFY_READ, __p, sizeof(*__p)))) {	\
 		__e = __get_user(x, __p);				\
-	} else								\
-		x = 0;							\
+	} else {							\
+		(x) = 0;						\
+	}								\
 	__e;								\
 })
-#define __get_user(x,ptr)						\
+
+#define __get_user(x, ptr)						\
 ({									\
 	long __gu_err = 0;						\
-	__get_user_err((x),(ptr),__gu_err);				\
+	__get_user_err((x), (ptr), __gu_err);				\
 	__gu_err;							\
 })
 
-#define __get_user_error(x,ptr,err)					\
+#define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_err((x),(ptr),err);					\
-	(void) 0;							\
+	__get_user_err((x), (ptr), err);				\
+	(void)0;							\
 })
 
-#define __get_user_err(x,ptr,err)					\
+#define __get_user_err(x, ptr, err)					\
 do {									\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	unsigned long __gu_val;						\
 	__chk_user_ptr(__gu_addr);					\
 	switch (sizeof(*(__gu_addr))) {					\
 	case 1:								\
-		__get_user_asm("lbi",__gu_val,__gu_addr,err);		\
+		__get_user_asm("lbi", __gu_val, __gu_addr, (err));	\
 		break;							\
 	case 2:								\
-		__get_user_asm("lhi",__gu_val,__gu_addr,err);		\
+		__get_user_asm("lhi", __gu_val, __gu_addr, (err));	\
 		break;							\
 	case 4:								\
-		__get_user_asm("lwi",__gu_val,__gu_addr,err);		\
+		__get_user_asm("lwi", __gu_val, __gu_addr, (err));	\
 		break;							\
 	case 8:								\
-		__get_user_asm_dword(__gu_val,__gu_addr,err);		\
+		__get_user_asm_dword(__gu_val, __gu_addr, (err));	\
 		break;							\
 	default:							\
 		BUILD_BUG(); 						\
@@ -123,23 +125,23 @@ do {									\
 	(x) = (__typeof__(*(__gu_addr)))__gu_val;			\
 } while (0)
 
-#define __get_user_asm(inst,x,addr,err)					\
-	asm volatile(							\
-	"1:	"inst"	%1,[%2]\n"					\
-	"2:\n"								\
-	"	.section .fixup,\"ax\"\n"				\
-	"	.align	2\n"						\
-	"3:	move %0, %3\n"						\
-	"	move %1, #0\n"						\
-	"	b	2b\n"						\
-	"	.previous\n"						\
-	"	.section __ex_table,\"a\"\n"				\
-	"	.align	3\n"						\
-	"	.long	1b, 3b\n"					\
-	"	.previous"						\
-	: "+r" (err), "=&r" (x)						\
-	: "r" (addr), "i" (-EFAULT)					\
-	: "cc")
+#define __get_user_asm(inst, x, addr, err)				\
+	__asm__ __volatile__ (						\
+		"1:	"inst"	%1,[%2]\n"				\
+		"2:\n"							\
+		"	.section .fixup,\"ax\"\n"			\
+		"	.align	2\n"					\
+		"3:	move %0, %3\n"					\
+		"	move %1, #0\n"					\
+		"	b	2b\n"					\
+		"	.previous\n"					\
+		"	.section __ex_table,\"a\"\n"			\
+		"	.align	3\n"					\
+		"	.long	1b, 3b\n"				\
+		"	.previous"					\
+		: "+r" (err), "=&r" (x)					\
+		: "r" (addr), "i" (-EFAULT)				\
+		: "cc")
 
 #ifdef __NDS32_EB__
 #define __gu_reg_oper0 "%H1"
@@ -150,62 +152,64 @@ do {									\
 #endif
 
 #define __get_user_asm_dword(x, addr, err) 				\
-	asm volatile(			    				\
-	"\n1:\tlwi " __gu_reg_oper0 ",[%2]\n"				\
-	"\n2:\tlwi " __gu_reg_oper1 ",[%2+4]\n"				\
-	"3:\n"								\
-	"	.section .fixup,\"ax\"\n"				\
-	"	.align	2\n"						\
-	"4:	move	%0, %3\n"					\
-	"	b	3b\n"						\
-	"	.previous\n"						\
-	"	.section __ex_table,\"a\"\n"				\
-	"	.align	3\n"						\
-	"	.long	1b, 4b\n"					\
-	"	.long	2b, 4b\n"					\
-	"	.previous"						\
-	: "+r"(err), "=&r"(x)                				\
-	: "r"(addr), "i"(-EFAULT) 					\
-	: "cc")
-#define put_user(x,p)							\
+	__asm__ __volatile__ (						\
+		"\n1:\tlwi " __gu_reg_oper0 ",[%2]\n"			\
+		"\n2:\tlwi " __gu_reg_oper1 ",[%2+4]\n"			\
+		"3:\n"							\
+		"	.section .fixup,\"ax\"\n"			\
+		"	.align	2\n"					\
+		"4:	move	%0, %3\n"				\
+		"	b	3b\n"					\
+		"	.previous\n"					\
+		"	.section __ex_table,\"a\"\n"			\
+		"	.align	3\n"					\
+		"	.long	1b, 4b\n"				\
+		"	.long	2b, 4b\n"				\
+		"	.previous"					\
+		: "+r"(err), "=&r"(x)					\
+		: "r"(addr), "i"(-EFAULT)				\
+		: "cc")
+
+#define put_user(x, ptr)						\
 ({									\
 	long __e = -EFAULT;						\
-	__typeof__(*(p)) __user *__p = (p);				\
-	if(likely(access_ok(VERIFY_WRITE, __p, sizeof(*__p)))) {	\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	if (likely(access_ok(VERIFY_WRITE, __p, sizeof(*__p)))) {	\
 		__e = __put_user(x, __p);				\
 	}								\
 	__e;								\
 })
-#define __put_user(x,ptr)						\
+
+#define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
-	__put_user_err((x),(ptr),__pu_err);				\
+	__put_user_err((x), (ptr), __pu_err);				\
 	__pu_err;							\
 })
 
-#define __put_user_error(x,ptr,err)					\
+#define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_err((x),(ptr),err);					\
-	(void) 0;							\
+	__put_user_err((x), (ptr), err);				\
+	(void)0;							\
 })
 
-#define __put_user_err(x,ptr,err)					\
+#define __put_user_err(x, ptr, err)					\
 do {									\
 	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
 	__typeof__(*(__pu_addr)) __pu_val = (x);			\
 	__chk_user_ptr(__pu_addr);					\
 	switch (sizeof(*(__pu_addr))) {					\
 	case 1:								\
-		__put_user_asm("sbi",__pu_val,__pu_addr,err);		\
+		__put_user_asm("sbi", __pu_val, __pu_addr, (err));	\
 		break;							\
 	case 2: 							\
-		__put_user_asm("shi",__pu_val,__pu_addr,err);		\
+		__put_user_asm("shi", __pu_val, __pu_addr, (err));	\
 		break;							\
 	case 4: 							\
-		__put_user_asm("swi",__pu_val,__pu_addr,err);		\
+		__put_user_asm("swi", __pu_val, __pu_addr, (err));	\
 		break;							\
 	case 8:								\
-		__put_user_asm_dword(__pu_val,__pu_addr,err);		\
+		__put_user_asm_dword(__pu_val, __pu_addr, (err));	\
 		break;							\
 	default:							\
 		BUILD_BUG(); 						\
@@ -213,22 +217,22 @@ do {									\
 	}								\
 } while (0)
 
-#define __put_user_asm(inst,x,addr,err)					\
-	asm volatile(							\
-	"1:	"inst"	%1,[%2]\n"					\
-	"2:\n"								\
-	"	.section .fixup,\"ax\"\n"				\
-	"	.align	2\n"						\
-	"3:	move	%0, %3\n"					\
-	"	b	2b\n"						\
-	"	.previous\n"						\
-	"	.section __ex_table,\"a\"\n"				\
-	"	.align	3\n"						\
-	"	.long	1b, 3b\n"					\
-	"	.previous"						\
-	: "+r" (err)							\
-	: "r" (x), "r" (addr), "i" (-EFAULT)				\
-	: "cc")
+#define __put_user_asm(inst, x, addr, err)				\
+	__asm__ __volatile__ (						\
+		"1:	"inst"	%1,[%2]\n"				\
+		"2:\n"							\
+		"	.section .fixup,\"ax\"\n"			\
+		"	.align	2\n"					\
+		"3:	move	%0, %3\n"				\
+		"	b	2b\n"					\
+		"	.previous\n"					\
+		"	.section __ex_table,\"a\"\n"			\
+		"	.align	3\n"					\
+		"	.long	1b, 3b\n"				\
+		"	.previous"					\
+		: "+r" (err)						\
+		: "r" (x), "r" (addr), "i" (-EFAULT)			\
+		: "cc")
 
 #ifdef __NDS32_EB__
 #define __pu_reg_oper0 "%H2"
@@ -239,23 +243,24 @@ do {									\
 #endif
 
 #define __put_user_asm_dword(x, addr, err) 				\
-	asm volatile(			    				\
-	"\n1:\tswi " __pu_reg_oper0 ",[%1]\n"				\
-	"\n2:\tswi " __pu_reg_oper1 ",[%1+4]\n"				\
-	"3:\n"								\
-	"	.section .fixup,\"ax\"\n"				\
-	"	.align	2\n"						\
-	"4:	move	%0, %3\n"					\
-	"	b	3b\n"						\
-	"	.previous\n"						\
-	"	.section __ex_table,\"a\"\n"				\
-	"	.align	3\n"						\
-	"	.long	1b, 4b\n"					\
-	"	.long	2b, 4b\n"					\
-	"	.previous"						\
-	: "+r"(err)                					\
-	: "r"(addr), "r"(x), "i"(-EFAULT) 				\
-	: "cc")
+	__asm__ __volatile__ (						\
+		"\n1:\tswi " __pu_reg_oper0 ",[%1]\n"			\
+		"\n2:\tswi " __pu_reg_oper1 ",[%1+4]\n"			\
+		"3:\n"							\
+		"	.section .fixup,\"ax\"\n"			\
+		"	.align	2\n"					\
+		"4:	move	%0, %3\n"				\
+		"	b	3b\n"					\
+		"	.previous\n"					\
+		"	.section __ex_table,\"a\"\n"			\
+		"	.align	3\n"					\
+		"	.long	1b, 4b\n"				\
+		"	.long	2b, 4b\n"				\
+		"	.previous"					\
+		: "+r"(err)						\
+		: "r"(addr), "r"(x), "i"(-EFAULT)			\
+		: "cc")
+
 extern unsigned long __arch_clear_user(void __user * addr, unsigned long n);
 extern long strncpy_from_user(char *dest, const char __user * src, long count);
 extern __must_check long strlen_user(const char __user * str);
-- 
2.7.4

