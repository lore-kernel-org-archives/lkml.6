Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525128384-2-948953949473447743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525128383; b=OYblnWbcZKAfeEJxbAUyPPs8UyAuoqQy2Eryn0R+PhOkhCRBSV
    GsV3igxMBrh3zhmvTAyMy5VO5VAqhGbhTYaUzIBroc47cN78JoYF3uXOy6eGIx/5
    1bXpzDxQ3mlZwitL1DYAIGAhhJkAGXLfnExT/qK6RvlI8WuIKidFkoonvgtHlS/g
    4FzLhy5iyACLdtUQ4naJqlJbIW5H6nrHf0ozSxIfkBPRd7jGPxT8thURq5vvO0Wb
    zYRTAk1lx7P7xzW6BysCPlYl0dO7L1tNZQ1wkA54vdF4rjszcJEwisDKOJloYM5w
    cqKsJtO8cjHBIkR9VFeiQl1JCxRzSDcz4mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525128383; bh=
    is2vU9aEkF0duWv5O1xSLAruVNPQEbHvkk8f5fk36YE=; b=UQwx9on/xsG3VHDT
    YJmXwzPOzDaAludX7UGe+HBaiqwv33ecgB+PYW8/NA2XIWFASKD89b0mnEnkHb6v
    SZqPSAdZwvRoK5/VPagtH+zNPrggSMdv96TvG5nVxKUGne2r9IJHyOaQSbNEw0LX
    1h+A7TLc/sHcjcxLRpPIZYuz7ZNRfORyAHnTSO56HUQt8YH/IQWrsxOicNfdBsuI
    Z4C5QuBYBXlDqruwqrtMbEiKl1XdFlkrDCMw8PltiYMj/zfN1imPd0ppSK08TL4q
    d7yPCU80ldvyJdpVJME5czSl2Bi7pB5cmLyhwXyVFCtzFR8yGUT1hDJo6/36X5AV
    RirM+g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfHcAdhkDH2H8dkUdOdd0KoK4ePQnsmdGL5YcPAWJwUYSHTOoMDV5Izqm+ch1BBW5yM4auV9WDoMafS9/wOzVZSiJWH3mFN/Ss05vTD4dgBP7f9IPr4Pw
    coC4JTdVt77pssiiVdr6INuabiwFN5QuAuomq1q8KbFouj2HHRuy6WXMD/z0d9nXMsXI80ij9gTPUsUZrSQSxZxK8U+TLSoOpj7zPVGN8sUljgYz6nhCgOri
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=hD80L64hAAAA:8 a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8
    a=JfrnYn6hAAAA:8 a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8
    a=NufY4J3AAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8
    a=VnNF1IyMAAAA:8 a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=AwZSytpVKLOqVwy649oA:9 a=_8AhX-s6a2Kginuz:21
    a=TgIcoDdBo46mM9it:21 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbeD3WqH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:46:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:53010 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755460AbeD3Wos (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Apr 2018 18:44:48 -0400
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 12/14] rseq: selftests: Provide basic percpu ops test (v2)
Date: Mon, 30 Apr 2018 18:44:31 -0400
Message-Id: <20180430224433.17407-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"basic_percpu_ops_test" is a slightly more "realistic" variant,
implementing a few simple per-cpu operations and testing their
correctness.

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
Changes since v1:
- Use only rseq, remove use of cpu_opv system call.
---
 .../testing/selftests/rseq/basic_percpu_ops_test.c | 313 +++++++++++++++++++++
 1 file changed, 313 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/basic_percpu_ops_test.c

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
new file mode 100644
index 000000000000..96ef27905879
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
+#include "rseq.h"
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+struct percpu_lock_entry {
+	intptr_t v;
+} __attribute__((aligned(128)));
+
+struct percpu_lock {
+	struct percpu_lock_entry c[CPU_SETSIZE];
+};
+
+struct test_data_entry {
+	intptr_t count;
+} __attribute__((aligned(128)));
+
+struct spinlock_test_data {
+	struct percpu_lock lock;
+	struct test_data_entry c[CPU_SETSIZE];
+	int reps;
+};
+
+struct percpu_list_node {
+	intptr_t data;
+	struct percpu_list_node *next;
+};
+
+struct percpu_list_entry {
+	struct percpu_list_node *head;
+} __attribute__((aligned(128)));
+
+struct percpu_list {
+	struct percpu_list_entry c[CPU_SETSIZE];
+};
+
+/* A simple percpu spinlock.  Returns the cpu lock was acquired on. */
+int rseq_this_cpu_lock(struct percpu_lock *lock)
+{
+	int cpu;
+
+	for (;;) {
+		int ret;
+
+		cpu = rseq_cpu_start();
+		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
+					 0, 1, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	/*
+	 * Acquire semantic when taking lock after control dependency.
+	 * Matches rseq_smp_store_release().
+	 */
+	rseq_smp_acquire__after_ctrl_dep();
+	return cpu;
+}
+
+void rseq_percpu_unlock(struct percpu_lock *lock, int cpu)
+{
+	assert(lock->c[cpu].v == 1);
+	/*
+	 * Release lock, with release semantic. Matches
+	 * rseq_smp_acquire__after_ctrl_dep().
+	 */
+	rseq_smp_store_release(&lock->c[cpu].v, 0);
+}
+
+void *test_percpu_spinlock_thread(void *arg)
+{
+	struct spinlock_test_data *data = arg;
+	int i, cpu;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	for (i = 0; i < data->reps; i++) {
+		cpu = rseq_this_cpu_lock(&data->lock);
+		data->c[cpu].count++;
+		rseq_percpu_unlock(&data->lock, cpu);
+	}
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	return NULL;
+}
+
+/*
+ * A simple test which implements a sharded counter using a per-cpu
+ * lock.  Obviously real applications might prefer to simply use a
+ * per-cpu increment; however, this is reasonable for a test and the
+ * lock can be extended to synchronize more complicated operations.
+ */
+void test_percpu_spinlock(void)
+{
+	const int num_threads = 200;
+	int i;
+	uint64_t sum;
+	pthread_t test_threads[num_threads];
+	struct spinlock_test_data data;
+
+	memset(&data, 0, sizeof(data));
+	data.reps = 5000;
+
+	for (i = 0; i < num_threads; i++)
+		pthread_create(&test_threads[i], NULL,
+			       test_percpu_spinlock_thread, &data);
+
+	for (i = 0; i < num_threads; i++)
+		pthread_join(test_threads[i], NULL);
+
+	sum = 0;
+	for (i = 0; i < CPU_SETSIZE; i++)
+		sum += data.c[i].count;
+
+	assert(sum == (uint64_t)data.reps * num_threads);
+}
+
+void this_cpu_list_push(struct percpu_list *list,
+			struct percpu_list_node *node,
+			int *_cpu)
+{
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr, newval, expect;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load list->c[cpu].head with single-copy atomicity. */
+		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
+		newval = (intptr_t)node;
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		node->next = (struct percpu_list_node *)expect;
+		ret = rseq_cmpeqv_storev(targetptr, expect, newval, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+}
+
+/*
+ * Unlike a traditional lock-less linked list; the availability of a
+ * rseq primitive allows us to implement pop without concerns over
+ * ABA-type races.
+ */
+struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
+					   int *_cpu)
+{
+	for (;;) {
+		struct percpu_list_node *head;
+		intptr_t *targetptr, expectnot, *load;
+		off_t offset;
+		int ret, cpu;
+
+		cpu = rseq_cpu_start();
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		expectnot = (intptr_t)NULL;
+		offset = offsetof(struct percpu_list_node, next);
+		load = (intptr_t *)&head;
+		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
+						 offset, load, cpu);
+		if (rseq_likely(!ret)) {
+			if (_cpu)
+				*_cpu = cpu;
+			return head;
+		}
+		if (ret > 0)
+			return NULL;
+		/* Retry if rseq aborts. */
+	}
+}
+
+/*
+ * __percpu_list_pop is not safe against concurrent accesses. Should
+ * only be used on lists that are not concurrently modified.
+ */
+struct percpu_list_node *__percpu_list_pop(struct percpu_list *list, int cpu)
+{
+	struct percpu_list_node *node;
+
+	node = list->c[cpu].head;
+	if (!node)
+		return NULL;
+	list->c[cpu].head = node->next;
+	return node;
+}
+
+void *test_percpu_list_thread(void *arg)
+{
+	int i;
+	struct percpu_list *list = (struct percpu_list *)arg;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	for (i = 0; i < 100000; i++) {
+		struct percpu_list_node *node;
+
+		node = this_cpu_list_pop(list, NULL);
+		sched_yield();  /* encourage shuffling */
+		if (node)
+			this_cpu_list_push(list, node, NULL);
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu linked list from many threads.  */
+void test_percpu_list(void)
+{
+	int i, j;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_list list;
+	pthread_t test_threads[200];
+	cpu_set_t allowed_cpus;
+
+	memset(&list, 0, sizeof(list));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		for (j = 1; j <= 100; j++) {
+			struct percpu_list_node *node;
+
+			expected_sum += j;
+
+			node = malloc(sizeof(*node));
+			assert(node);
+			node->data = j;
+			node->next = list.c[i].head;
+			list.c[i].head = node;
+		}
+	}
+
+	for (i = 0; i < 200; i++)
+		pthread_create(&test_threads[i], NULL,
+		       test_percpu_list_thread, &list);
+
+	for (i = 0; i < 200; i++)
+		pthread_join(test_threads[i], NULL);
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while ((node = __percpu_list_pop(&list, i))) {
+			sum += node->data;
+			free(node);
+		}
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	assert(sum == expected_sum);
+}
+
+int main(int argc, char **argv)
+{
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	printf("spinlock\n");
+	test_percpu_spinlock();
+	printf("percpu_list\n");
+	test_percpu_list();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	return 0;
+
+error:
+	return -1;
+}
+
-- 
2.11.0

