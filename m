Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F46C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA038208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA038208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbeGJUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:25:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbeGJUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:25:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AKO7sx3268165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 13:24:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AKO7wB3268161;
        Tue, 10 Jul 2018 13:24:07 -0700
Date:   Tue, 10 Jul 2018 13:24:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-4f4c0acdf4652a964da869d578a3c8bf6df14ce2@git.kernel.org>
Cc:     rostedt@goodmis.org, andi@firstfloor.org, bmaurer@fb.com,
        linux@arm.linux.org.uk, mingo@kernel.org, davejwatson@fb.com,
        cl@linux.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        boqun.feng@gmail.com, akpm@linux-foundation.org,
        mtk.manpages@gmail.com, mathieu.desnoyers@efficios.com,
        catalin.marinas@arm.com, josh@joshtriplett.org, hpa@zytor.com,
        luto@amacapital.net, joelaf@google.com, peterz@infradead.org,
        will.deacon@arm.com, paulmck@linux.vnet.ibm.com, pjt@google.com,
        linux-kernel@vger.kernel.org
Reply-To: mathieu.desnoyers@efficios.com, cl@linux.com,
          mtk.manpages@gmail.com, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, boqun.feng@gmail.com,
          tglx@linutronix.de, bmaurer@fb.com, davejwatson@fb.com,
          linux@arm.linux.org.uk, mingo@kernel.org, rostedt@goodmis.org,
          andi@firstfloor.org, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, pjt@google.com, paulmck@linux.vnet.ibm.com,
          joelaf@google.com, peterz@infradead.org, catalin.marinas@arm.com,
          hpa@zytor.com, josh@joshtriplett.org, luto@amacapital.net
In-Reply-To: <20180709195155.7654-6-mathieu.desnoyers@efficios.com>
References: <20180709195155.7654-6-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] rseq: Remove unused types_32_64.h uapi header
Git-Commit-ID: 4f4c0acdf4652a964da869d578a3c8bf6df14ce2
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

Commit-ID:  4f4c0acdf4652a964da869d578a3c8bf6df14ce2
Gitweb:     https://git.kernel.org/tip/4f4c0acdf4652a964da869d578a3c8bf6df14ce2
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 9 Jul 2018 15:51:54 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Jul 2018 22:18:52 +0200

rseq: Remove unused types_32_64.h uapi header

This header was introduced in the 4.18 merge window, and rseq does
not need it anymore. Nuke it before the final release.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Paul Turner <pjt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Chris Lameter <cl@linux.com>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180709195155.7654-6-mathieu.desnoyers@efficios.com

---
 include/uapi/linux/types_32_64.h | 50 ----------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/uapi/linux/types_32_64.h b/include/uapi/linux/types_32_64.h
deleted file mode 100644
index 0a87ace34a57..000000000000
--- a/include/uapi/linux/types_32_64.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_TYPES_32_64_H
-#define _UAPI_LINUX_TYPES_32_64_H
-
-/*
- * linux/types_32_64.h
- *
- * Integer type declaration for pointers across 32-bit and 64-bit systems.
- *
- * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-#ifdef __KERNEL__
-# include <linux/types.h>
-#else
-# include <stdint.h>
-#endif
-
-#include <asm/byteorder.h>
-
-#ifdef __BYTE_ORDER
-# if (__BYTE_ORDER == __BIG_ENDIAN)
-#  define LINUX_BYTE_ORDER_BIG_ENDIAN
-# else
-#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
-# endif
-#else
-# ifdef __BIG_ENDIAN
-#  define LINUX_BYTE_ORDER_BIG_ENDIAN
-# else
-#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
-# endif
-#endif
-
-#ifdef __LP64__
-# define LINUX_FIELD_u32_u64(field)			__u64 field
-# define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	field = (intptr_t)v
-#else
-# ifdef LINUX_BYTE_ORDER_BIG_ENDIAN
-#  define LINUX_FIELD_u32_u64(field)	__u32 field ## _padding, field
-#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
-	field ## _padding = 0, field = (intptr_t)v
-# else
-#  define LINUX_FIELD_u32_u64(field)	__u32 field, field ## _padding
-#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
-	field = (intptr_t)v, field ## _padding = 0
-# endif
-#endif
-
-#endif /* _UAPI_LINUX_TYPES_32_64_H */
