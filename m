Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4156032-1522167676-2-16002366145902092341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167673; b=rsTQlFz+V3Zd/aH6qfJWRjlbJb/f8irl42G7GYIBrwitiE4
    UGYHgIZFAg6qpFWjEgnIIQah7rgyuzhW0BCNwkUVCa0URKju/CVBOIFZ2MFCAgop
    iEKJFCSu3jsbu3CG9We2YwaTjlKDBHSAisbPdOVbRwg2kxKc5/QBaBkxpH11mDHE
    bwzWvS6pSqztJ9Y04m6tigvgHpkhHobdtL/Q1ww39QhgPmnzFQpBIttZ7kcHfD5X
    KDFTu/XCyIQ9wBcNKdE4DEw3x3+Gmm1aO0MBNQ63xWwzjR0yZSLNAn/MwdlSefNg
    WLUPmoFEMZLfr013qwFleynGx52+DNvs082+zWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522167673;
    bh=NxQ8EBcIa9l6h11s5E/CRM+nFSKcq+qFXaspmany5BQ=; b=YLSUspUrEXoZ
    UaTigNAeCiAdmEewBDR0R8y9ZsgYVQOVlxv5KVDRAh3ht3bdcouHSeo+DtxSnWV6
    iSP3brERvxAAdbX+G6qKxTNDDYVDE5cpMUykB4RAIqIbw+kp66WesDYgzLGPAAAg
    K82fuKKRo5FxGoa6gLmRV13HQV+mFbmvcNDRO9G0hCIgFCANRd2MQLROZFkhR1qo
    JiEz0ghpIdNpWe8us1e7PWr733wkDEb1MoyZAbgMPqbGAB4NpYW1KZbTr/NWCku7
    PrhQ5vIojNzCZDowlWWpCCRlRznA6jR6Jd4lxXbQmgrg36kNt/pKczRYGta3liIt
    ka2xgs2w7w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMX9AJOmtEhnt9rF/oQ3SNpqamWArTVjBTYYsl4l3gCJgygXjVzg+ydKVlM175CvDRx8PTTa/5WNyg0Jfoid7MArskvkQrAUTU2rOTzaR9dktGenUr0H
    B3qS01mVYfVLQQEnp6ka4oiassNqRSgBDiEbkfMi+Tbjhavu08vO6Q5w3hXjupwVlLa+pG4uBRtyxcvp1FZR/MpmpOGdECKgVsaMAZyjlvWDoL7n2l0VUIsJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=7d_E57ReAAAA:8
    a=hD80L64hAAAA:8 a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8
    a=JfrnYn6hAAAA:8 a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8
    a=NufY4J3AAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8
    a=VnNF1IyMAAAA:8 a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=W636IStVJ5K3otUhpKgA:9 a=AoVROvePlQHjt0pF:21
    a=gdfAiUalvx0oQSSa:21 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeC0QVL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:21:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:53936 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeC0QVA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 12:21:00 -0400
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 4.17 17/21] rseq: selftests: Provide percpu_op API
Date: Tue, 27 Mar 2018 12:05:38 -0400
Message-Id: <20180327160542.28457-18-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce percpu-op.h API. It uses rseq internally as fast-path if
invoked from the right CPU, else cpu_opv as slow-path if called
from the wrong CPU or if rseq fails.

This allows acting on per-cpu data from various CPUs transparently from
user-space: cpu_opv will take care of migrating the thread to the
requested CPU. Use-cases such as rebalancing memory across per-cpu
memory pools, or migrating tasks for a user-space scheduler, are thus
facilitated. This also handles debugger single-stepping.

The use from userspace is, e.g. for a counter increment:

    int cpu, ret;

    cpu = rseq_cpu_start();
    ret = percpu_addv(&data->c[cpu].count, 1, cpu);
    if (unlikely(ret)) {
         perror("percpu_addv");
         return -1;
    }
    return 0;

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Shuah Khan <shuahkh@osg.samsung.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul Turner <pjt@google.com>
CC: Andrew Hunter <ahh@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 tools/testing/selftests/rseq/percpu-op.h | 163 +++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/percpu-op.h

diff --git a/tools/testing/selftests/rseq/percpu-op.h b/tools/testing/selftests/rseq/percpu-op.h
new file mode 100644
index 000000000000..c17d165438a6
--- /dev/null
+++ b/tools/testing/selftests/rseq/percpu-op.h
@@ -0,0 +1,163 @@
+/*
+ * percpu-op.h
+ *
+ * (C) Copyright 2017 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef PERCPU_OP_H
+#define PERCPU_OP_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <stdlib.h>
+#include "rseq.h"
+#include "cpu-op.h"
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv,
+			 int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_storev(v, expect, newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_storev(v, expect, newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpnev_storeoffp_load(v, expectnot, voffp, load, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpnev_storeoffp_load(v, expectnot, voffp,
+						    load, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	if (rseq_unlikely(rseq_addv(v, count, cpu)))
+		return cpu_op_addv(v, count, cpu);
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_storev_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t newv2,
+				intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2,
+					   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_storev_storev(v, expect, v2, newv2,
+						   newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_storev_storev_release(intptr_t *v, intptr_t expect,
+					intptr_t *v2, intptr_t newv2,
+					intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trystorev_storev_release(v, expect, v2, newv2,
+						   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_storev_mb_storev(v, expect, v2, newv2,
+						      newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+				intptr_t *v2, intptr_t expect2,
+				intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_cmpeqv_storev(v, expect, v2, expect2, newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_cmpeqv_storev(v, expect, v2, expect2,
+						   newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_memcpy_storev(intptr_t *v, intptr_t expect,
+				void *dst, void *src, size_t len,
+				intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
+					   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_memcpy_storev(v, expect, dst, src, len,
+						   newv, cpu);
+	}
+	return 0;
+}
+
+static inline __attribute__((always_inline))
+int percpu_cmpeqv_memcpy_storev_release(intptr_t *v, intptr_t expect,
+					void *dst, void *src, size_t len,
+					intptr_t newv, int cpu)
+{
+	int ret;
+
+	ret = rseq_cmpeqv_trymemcpy_storev_release(v, expect, dst, src, len,
+						   newv, cpu);
+	if (rseq_unlikely(ret)) {
+		if (ret > 0)
+			return ret;
+		return cpu_op_cmpeqv_memcpy_mb_storev(v, expect, dst, src, len,
+						      newv, cpu);
+	}
+	return 0;
+}
+
+#endif  /* PERCPU_OP_H_ */
-- 
2.11.0

