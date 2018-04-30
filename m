Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2056830-1525128480-2-4252778818391257923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525128479; b=RUgff30jRNl1NYY9Id35CtvOMhASGU7N71mkWMh/iKDMAixJ0f
    ZdcGh66LNQwCHZtwfALzlpIqHSLWuP8/iHhLo/0UDGIOCck5uihqLlCEBXAI3Fyw
    9IT/poJQFIHJMRwQEDGbsgiFU3Wkggj0nRHrzXBYjb++dAmUlbjuwunHRGmTU6hl
    +8WwcC/E7cqS+HzUZ7vZtTCyEsCwucabL/FWp7dwSohlY7aXsc+KKBu8/HNlr3Gl
    Sl7I2TZGEmRFt/9/24H3m1WsbAydcmFhjqABXTOqsKHXJFIgs5T9dVF0nECWjhQ0
    9DoIdypWYB6UzCv1e+ojjdveEW8oS4gnocqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525128479; bh=
    WhIqO8M4FvE30NKnk8bLDYGQORAYepumfUyOUCINWxk=; b=aP4qO7UAiZHf2p+5
    tCaVDiLpLMZFuMhs31oEfxSS+aexLPA6OiEBg+8abmzTqTLPqzNjfjdt5vqNeQjK
    GqhIWehd/fd1LdjaFr3MY2vqoKU7J/9h/V7Y4l5RSRMhd99RwnDBlv2EXi4MoLcU
    q7Fit/XKFsnVkezOAFxlx9UHpZ7uv8kRwIeW3F2WEcUSHL6do8Kolxt5udQwZ500
    jaNBUlyvbBYDZV1w9JKBZ9VHyTT580o5Hq4q85fNJsBCHSlsqet7eeKlsakQqMxI
    /NnL6Yv2t2GHtoVdP6nd3x44MSznB2hmLZm39q0o0SdaI7g/ZhwNnOyQcbGRMG+t
    C45BAQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgrjklvDUy4Qftlt/rO2a2Y2vxowkVA4988MEOoIbBIn2pPDyBb7oJpcTCNtvbQainAsh/VsrLRBhynz02C2d6S/w4CyVU3Qc+iLp9qaNHnBj2Yy+OV
    f5dQE0CALONzlEm4dHfXZCDNboxt6ehGMvyMXzwR1MY09fta6vMW4+VJxeBpysHyQ7SJaWK0Q0RGKD6dBV30N+DNj+h/SCcsEumtlTV19MggIgf88+hJKx9T
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=SOq6UgPBAAAA:8
    a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8 a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=K9fvYg9zRn_gSVpeIkAA:9 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755441AbeD3Wop (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:44:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:52856 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755285AbeD3Woo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Apr 2018 18:44:44 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 01/14] uapi headers: Provide types_32_64.h (v2)
Date: Mon, 30 Apr 2018 18:44:20 -0400
Message-Id: <20180430224433.17407-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Provide helper macros for fields which represent pointers in
kernel-userspace ABI. This facilitates handling of 32-bit
user-space by 64-bit kernels by defining those fields as
32-bit 0-padding and 32-bit integer on 32-bit architectures,
which allows the kernel to treat those as 64-bit integers.
The order of padding and 32-bit integer depends on the
endianness.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andrew Hunter <ahh@google.com>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org

---

Changes since v1:
- Public uapi headers use __u32 and __u64 rather than uint32_t and
  uint64_t.
---
 include/uapi/linux/types_32_64.h | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/uapi/linux/types_32_64.h

diff --git a/include/uapi/linux/types_32_64.h b/include/uapi/linux/types_32_64.h
new file mode 100644
index 000000000000..0a87ace34a57
--- /dev/null
+++ b/include/uapi/linux/types_32_64.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_TYPES_32_64_H
+#define _UAPI_LINUX_TYPES_32_64_H
+
+/*
+ * linux/types_32_64.h
+ *
+ * Integer type declaration for pointers across 32-bit and 64-bit systems.
+ *
+ * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifdef __KERNEL__
+# include <linux/types.h>
+#else
+# include <stdint.h>
+#endif
+
+#include <asm/byteorder.h>
+
+#ifdef __BYTE_ORDER
+# if (__BYTE_ORDER == __BIG_ENDIAN)
+#  define LINUX_BYTE_ORDER_BIG_ENDIAN
+# else
+#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
+# endif
+#else
+# ifdef __BIG_ENDIAN
+#  define LINUX_BYTE_ORDER_BIG_ENDIAN
+# else
+#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
+# endif
+#endif
+
+#ifdef __LP64__
+# define LINUX_FIELD_u32_u64(field)			__u64 field
+# define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	field = (intptr_t)v
+#else
+# ifdef LINUX_BYTE_ORDER_BIG_ENDIAN
+#  define LINUX_FIELD_u32_u64(field)	__u32 field ## _padding, field
+#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
+	field ## _padding = 0, field = (intptr_t)v
+# else
+#  define LINUX_FIELD_u32_u64(field)	__u32 field, field ## _padding
+#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
+	field = (intptr_t)v, field ## _padding = 0
+# endif
+#endif
+
+#endif /* _UAPI_LINUX_TYPES_32_64_H */
-- 
2.11.0

