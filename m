Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9256C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDBF20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDBF20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeIYPf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:35:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51591 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIYPf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:35:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9SV0C3385723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:28:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9SVXh3385720;
        Tue, 25 Sep 2018 02:28:31 -0700
Date:   Tue, 25 Sep 2018 02:28:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-2e85d5979e8d2866db6185de231461b21159ef6f@git.kernel.org>
Cc:     naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
        kstewart@linuxfoundation.org, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tmricht@linux.ibm.com, brueckner@linux.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        jolsa@kernel.org, sandipan@linux.ibm.com
Reply-To: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
          sandipan@linux.ibm.com, jolsa@kernel.org,
          brueckner@linux.ibm.com, tglx@linutronix.de, acme@redhat.com,
          alexander.shishkin@linux.intel.com, tmricht@linux.ibm.com,
          naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, ravi.bangoria@linux.ibm.com,
          kstewart@linuxfoundation.org
In-Reply-To: <20180912061229.22832-1-ravi.bangoria@linux.ibm.com>
References: <20180912061229.22832-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Add watchpoint test
Git-Commit-ID: 2e85d5979e8d2866db6185de231461b21159ef6f
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

Commit-ID:  2e85d5979e8d2866db6185de231461b21159ef6f
Gitweb:     https://git.kernel.org/tip/2e85d5979e8d2866db6185de231461b21159ef6f
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Wed, 12 Sep 2018 11:42:29 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Sep 2018 17:21:13 -0300

perf test: Add watchpoint test

We don't have a 'perf test' entry available to test the watchpoint
functionality.

Add a simple set of tests:

 - Read only watchpoint
 - Write only watchpoint
 - Read / Write watchpoint
 - Runtime watchpoint modification

Ex.: on powerpc:

  $ sudo perf test 22
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Ok
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180912061229.22832-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   9 ++
 tools/perf/tests/tests.h        |   3 +
 tools/perf/tests/wp.c           | 229 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 6c108fa79ae3..0b2b8305c965 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -21,6 +21,7 @@ perf-y += python-use.o
 perf-y += bp_signal.o
 perf-y += bp_signal_overflow.o
 perf-y += bp_account.o
+perf-y += wp.o
 perf-y += task-exit.o
 perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d7a5e1b9aa6f..54ca7d87236f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -120,6 +120,15 @@ static struct test generic_tests[] = {
 		.func = test__bp_accounting,
 		.is_supported = test__bp_signal_is_supported,
 	},
+	{
+		.desc = "Watchpoint",
+		.func = test__wp,
+		.subtest = {
+			.skip_if_fail	= false,
+			.get_nr		= test__wp_subtest_get_nr,
+			.get_desc	= test__wp_subtest_get_desc,
+		},
+	},
 	{
 		.desc = "Number of exit events of a simple workload",
 		.func = test__task_exit,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index a9760e790563..8e26a4148f30 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -59,6 +59,9 @@ int test__python_use(struct test *test, int subtest);
 int test__bp_signal(struct test *test, int subtest);
 int test__bp_signal_overflow(struct test *test, int subtest);
 int test__bp_accounting(struct test *test, int subtest);
+int test__wp(struct test *test, int subtest);
+const char *test__wp_subtest_get_desc(int subtest);
+int test__wp_subtest_get_nr(void);
 int test__task_exit(struct test *test, int subtest);
 int test__mem(struct test *test, int subtest);
 int test__sw_clock_freq(struct test *test, int subtest);
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
new file mode 100644
index 000000000000..017a99317f94
--- /dev/null
+++ b/tools/perf/tests/wp.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <linux/hw_breakpoint.h>
+#include "tests.h"
+#include "debug.h"
+#include "cloexec.h"
+
+#define WP_TEST_ASSERT_VAL(fd, text, val)       \
+do {                                            \
+	long long count;                        \
+	wp_read(fd, &count, sizeof(long long)); \
+	TEST_ASSERT_VAL(text, count == val);    \
+} while (0)
+
+volatile u64 data1;
+volatile u8 data2[3];
+
+static int wp_read(int fd, long long *count, int size)
+{
+	int ret = read(fd, count, size);
+
+	if (ret != size) {
+		pr_debug("failed to read: %d\n", ret);
+		return -1;
+	}
+	return 0;
+}
+
+static void get__perf_event_attr(struct perf_event_attr *attr, int wp_type,
+				 void *wp_addr, unsigned long wp_len)
+{
+	memset(attr, 0, sizeof(struct perf_event_attr));
+	attr->type           = PERF_TYPE_BREAKPOINT;
+	attr->size           = sizeof(struct perf_event_attr);
+	attr->config         = 0;
+	attr->bp_type        = wp_type;
+	attr->bp_addr        = (unsigned long)wp_addr;
+	attr->bp_len         = wp_len;
+	attr->sample_period  = 1;
+	attr->sample_type    = PERF_SAMPLE_IP;
+	attr->exclude_kernel = 1;
+	attr->exclude_hv     = 1;
+}
+
+static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
+{
+	int fd;
+	struct perf_event_attr attr;
+
+	get__perf_event_attr(&attr, wp_type, wp_addr, wp_len);
+	fd = sys_perf_event_open(&attr, 0, -1, -1,
+				 perf_event_open_cloexec_flag());
+	if (fd < 0)
+		pr_debug("failed opening event %x\n", attr.bp_type);
+
+	return fd;
+}
+
+static int wp_ro_test(void)
+{
+	int fd;
+	unsigned long tmp, tmp1 = rand();
+
+	fd = __event(HW_BREAKPOINT_R, (void *)&data1, sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	tmp = data1;
+	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
+
+	data1 = tmp1 + tmp;
+	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
+
+	close(fd);
+	return 0;
+}
+
+static int wp_wo_test(void)
+{
+	int fd;
+	unsigned long tmp, tmp1 = rand();
+
+	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	tmp = data1;
+	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 0);
+
+	data1 = tmp1 + tmp;
+	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 1);
+
+	close(fd);
+	return 0;
+}
+
+static int wp_rw_test(void)
+{
+	int fd;
+	unsigned long tmp, tmp1 = rand();
+
+	fd = __event(HW_BREAKPOINT_R | HW_BREAKPOINT_W, (void *)&data1,
+		     sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	tmp = data1;
+	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 1);
+
+	data1 = tmp1 + tmp;
+	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 2);
+
+	close(fd);
+	return 0;
+}
+
+static int wp_modify_test(void)
+{
+	int fd, ret;
+	unsigned long tmp = rand();
+	struct perf_event_attr new_attr;
+
+	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
+	if (fd < 0)
+		return -1;
+
+	data1 = tmp;
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
+
+	/* Modify watchpoint with disabled = 1 */
+	get__perf_event_attr(&new_attr, HW_BREAKPOINT_W, (void *)&data2[0],
+			     sizeof(u8) * 2);
+	new_attr.disabled = 1;
+	ret = ioctl(fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr);
+	if (ret < 0) {
+		pr_debug("ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) failed\n");
+		close(fd);
+		return ret;
+	}
+
+	data2[1] = tmp; /* Not Counted */
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
+
+	/* Enable the event */
+	ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (ret < 0) {
+		pr_debug("Failed to enable event\n");
+		close(fd);
+		return ret;
+	}
+
+	data2[1] = tmp; /* Counted */
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
+
+	data2[2] = tmp; /* Not Counted */
+	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 2);
+
+	close(fd);
+	return 0;
+}
+
+static bool wp_ro_supported(void)
+{
+#if defined (__x86_64__) || defined (__i386__)
+	return false;
+#else
+	return true;
+#endif
+}
+
+static void wp_ro_skip_msg(void)
+{
+#if defined (__x86_64__) || defined (__i386__)
+	pr_debug("Hardware does not support read only watchpoints.\n");
+#endif
+}
+
+static struct {
+	const char *desc;
+	int (*target_func)(void);
+	bool (*is_supported)(void);
+	void (*skip_msg)(void);
+} wp_testcase_table[] = {
+	{
+		.desc = "Read Only Watchpoint",
+		.target_func = &wp_ro_test,
+		.is_supported = &wp_ro_supported,
+		.skip_msg = &wp_ro_skip_msg,
+	},
+	{
+		.desc = "Write Only Watchpoint",
+		.target_func = &wp_wo_test,
+	},
+	{
+		.desc = "Read / Write Watchpoint",
+		.target_func = &wp_rw_test,
+	},
+	{
+		.desc = "Modify Watchpoint",
+		.target_func = &wp_modify_test,
+	},
+};
+
+int test__wp_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(wp_testcase_table);
+}
+
+const char *test__wp_subtest_get_desc(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
+		return NULL;
+	return wp_testcase_table[i].desc;
+}
+
+int test__wp(struct test *test __maybe_unused, int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(wp_testcase_table))
+		return TEST_FAIL;
+
+	if (wp_testcase_table[i].is_supported &&
+	    !wp_testcase_table[i].is_supported()) {
+		wp_testcase_table[i].skip_msg();
+		return TEST_SKIP;
+	}
+
+	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
+}
