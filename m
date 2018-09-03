Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CC5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBDC20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBDC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeICPGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:06:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICPGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:06:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83AjoDV3274467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 03:45:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83AjnLG3274464;
        Mon, 3 Sep 2018 03:45:49 -0700
Date:   Mon, 3 Sep 2018 03:45:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-4331f4d5ada5684fc77fa16e3f6177f077c9e6ec@git.kernel.org>
Cc:     tglx@linutronix.de, rdunlap@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        mark.rutland@arm.com
Reply-To: tglx@linutronix.de, rdunlap@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          mark.rutland@arm.com
In-Reply-To: <0a1e678d-c8c5-b32c-2640-ed4e94d399d2@infradead.org>
References: <0a1e678d-c8c5-b32c-2640-ed4e94d399d2@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Fix kernel-doc atomic.h warnings
Git-Commit-ID: 4331f4d5ada5684fc77fa16e3f6177f077c9e6ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4331f4d5ada5684fc77fa16e3f6177f077c9e6ec
Gitweb:     https://git.kernel.org/tip/4331f4d5ada5684fc77fa16e3f6177f077c9e6ec
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sun, 2 Sep 2018 19:30:53 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 12:41:41 +0200

x86: Fix kernel-doc atomic.h warnings

Fix kernel-doc warnings in arch/x86/include/asm/atomic.h that are caused by
having a #define macro between the kernel-doc notation and the function
name.  Fixed by moving the #define macro to after the function
implementation.

Make the same change for atomic64_{32,64}.h for consistency even though
there were no kernel-doc warnings found in these header files, but there
would be if they were used in generation of documentation.

Fixes these kernel-doc warnings:

../arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'i' description in 'arch_atomic_sub_and_test'
../arch/x86/include/asm/atomic.h:84: warning: Excess function parameter 'v' description in 'arch_atomic_sub_and_test'
../arch/x86/include/asm/atomic.h:96: warning: Excess function parameter 'v' description in 'arch_atomic_inc'
../arch/x86/include/asm/atomic.h:109: warning: Excess function parameter 'v' description in 'arch_atomic_dec'
../arch/x86/include/asm/atomic.h:124: warning: Excess function parameter 'v' description in 'arch_atomic_dec_and_test'
../arch/x86/include/asm/atomic.h:138: warning: Excess function parameter 'v' description in 'arch_atomic_inc_and_test'
../arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'i' description in 'arch_atomic_add_negative'
../arch/x86/include/asm/atomic.h:153: warning: Excess function parameter 'v' description in 'arch_atomic_add_negative'

Fixes: 18cc1814d4e7 ("atomics/treewide: Make test ops optional")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/0a1e678d-c8c5-b32c-2640-ed4e94d399d2@infradead.org


---
 arch/x86/include/asm/atomic.h      | 12 ++++++------
 arch/x86/include/asm/atomic64_32.h |  8 ++++----
 arch/x86/include/asm/atomic64_64.h | 12 ++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index b143717b92b3..ce84388e540c 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -80,11 +80,11 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, "er", i, "%0", e);
 }
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
 /**
  * arch_atomic_inc - increment atomic variable
@@ -92,12 +92,12 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic_inc arch_atomic_inc
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
 		     : "+m" (v->counter));
 }
+#define arch_atomic_inc arch_atomic_inc
 
 /**
  * arch_atomic_dec - decrement atomic variable
@@ -105,12 +105,12 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic_dec arch_atomic_dec
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
 		     : "+m" (v->counter));
 }
+#define arch_atomic_dec arch_atomic_dec
 
 /**
  * arch_atomic_dec_and_test - decrement and test
@@ -120,11 +120,11 @@ static __always_inline void arch_atomic_dec(atomic_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", e);
 }
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
 /**
  * arch_atomic_inc_and_test - increment and test
@@ -134,11 +134,11 @@ static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", e);
 }
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
 /**
  * arch_atomic_add_negative - add and test if negative
@@ -149,11 +149,11 @@ static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-#define arch_atomic_add_negative arch_atomic_add_negative
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, "er", i, "%0", s);
 }
+#define arch_atomic_add_negative arch_atomic_add_negative
 
 /**
  * arch_atomic_add_return - add integer and return
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ef959f02d070..6a5b0ec460da 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -205,12 +205,12 @@ static inline long long arch_atomic64_sub(long long i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic64_inc arch_atomic64_inc
 static inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
 }
+#define arch_atomic64_inc arch_atomic64_inc
 
 /**
  * arch_atomic64_dec - decrement atomic64 variable
@@ -218,12 +218,12 @@ static inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic64_dec arch_atomic64_dec
 static inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
 }
+#define arch_atomic64_dec arch_atomic64_dec
 
 /**
  * arch_atomic64_add_unless - add unless the number is a given value
@@ -245,7 +245,6 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, long long a,
 	return (int)a;
 }
 
-#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
@@ -253,8 +252,8 @@ static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 			     "S" (v) : "ecx", "edx", "memory");
 	return r;
 }
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 
-#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 static inline long long arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	long long r;
@@ -262,6 +261,7 @@ static inline long long arch_atomic64_dec_if_positive(atomic64_t *v)
 			     "S" (v) : "ecx", "memory");
 	return r;
 }
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 #undef alternative_atomic64
 #undef __alternative_atomic64
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 4343d9b4f30e..5f851d92eecd 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -71,11 +71,11 @@ static inline void arch_atomic64_sub(long i, atomic64_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, "er", i, "%0", e);
 }
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 
 /**
  * arch_atomic64_inc - increment atomic64 variable
@@ -83,13 +83,13 @@ static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic64_inc arch_atomic64_inc
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter));
 }
+#define arch_atomic64_inc arch_atomic64_inc
 
 /**
  * arch_atomic64_dec - decrement atomic64 variable
@@ -97,13 +97,13 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic64_dec arch_atomic64_dec
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter));
 }
+#define arch_atomic64_dec arch_atomic64_dec
 
 /**
  * arch_atomic64_dec_and_test - decrement and test
@@ -113,11 +113,11 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e);
 }
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 
 /**
  * arch_atomic64_inc_and_test - increment and test
@@ -127,11 +127,11 @@ static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e);
 }
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 
 /**
  * arch_atomic64_add_negative - add and test if negative
@@ -142,11 +142,11 @@ static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-#define arch_atomic64_add_negative arch_atomic64_add_negative
 static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
 }
+#define arch_atomic64_add_negative arch_atomic64_add_negative
 
 /**
  * arch_atomic64_add_return - add and return
