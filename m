Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3274C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E9E20C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E9E20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHUBDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:03:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:51212 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeHUBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:03:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id A9D4BC0DAC;
        Mon, 20 Aug 2018 21:45:47 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BjtP8p99_xbf; Mon, 20 Aug 2018 21:45:47 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id A8998C0C26;
        Mon, 20 Aug 2018 21:45:40 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest update for Linux 4.19-rc1
Message-ID: <dd7bf602-8270-5d7d-1f57-10f6528d4382@kernel.org>
Date:   Mon, 20 Aug 2018 15:45:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A6FA09E283D28294E3DA703F"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A6FA09E283D28294E3DA703F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 4.19-rc1

This Kselftest update for 4.19-rc1:

- adds cgroup core selftests
- fixes compile warnings in android ion test
- fixes to bugs in exclude and skip paths in vDSO test
- removes obsolete config options
- adds missing .gitignore file

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.19-rc1

for you to fetch changes up to 01675e9503c4e20c5ce9aebdfe6a9cf2ae4991e0:

  selftests/ftrace: Fix kprobe string testcase to not probe notrace function (2018-08-09 11:26:33 -0600)

----------------------------------------------------------------
linux-kselftest-4.19-rc1

This Kselftest update for 4.19-rc1:

- adds cgroup core selftests
- fixes compile warnings in android ion test
- fixes to bugs in exclude and skip paths in vDSO test
- removes obsolete config options
- adds missing .gitignore file

----------------------------------------------------------------
Anders Roxell (2):
      selftests: cgroup: add gitignore file
      selftests: mount: remove no longer needed config option

Claudio (1):
      Add cgroup core selftests

Li Zhijian (1):
      selftests/android: initialize heap_type to avoid compiling warning

Masami Hiramatsu (1):
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function

Shuah Khan (Samsung OSG) (2):
      selftests: vDSO - fix to exclude x86 test on non-x86 platforms
      selftests: vDSO - fix to return KSFT_SKIP when test couldn't be run

 .../testing/selftests/android/ion/ionapp_export.c  |   1 +
 tools/testing/selftests/cgroup/.gitignore          |   1 +
 tools/testing/selftests/cgroup/Makefile            |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c       |   8 +
 tools/testing/selftests/cgroup/cgroup_util.h       |   1 +
 tools/testing/selftests/cgroup/test_core.c         | 395 +++++++++++++++++++++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  30 +-
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |   2 +-
 tools/testing/selftests/mount/config               |   1 -
 tools/testing/selftests/vDSO/Makefile              |  13 +-
tools/testing/selftests/vDSO/vdso_test.c           |   7 +-
 11 files changed, 435 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/.gitignore
 create mode 100644 tools/testing/selftests/cgroup/test_core.c

----------------------------------------------------------------

--------------A6FA09E283D28294E3DA703F
Content-Type: text/x-patch;
 name="linux-kselftest-4.19-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.19-rc1.diff"

diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
index a944e72621a9..b5fa0a2dc968 100644
--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -51,6 +51,7 @@ int main(int argc, char *argv[])
 
 	heap_size = 0;
 	flags = 0;
+	heap_type = ION_HEAP_TYPE_SYSTEM;
 
 	while ((opt = getopt(argc, argv, "hi:s:")) != -1) {
 		switch (opt) {
diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
new file mode 100644
index 000000000000..95eb3a53c381
--- /dev/null
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -0,0 +1 @@
+test_memcontrol
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index f7a31392eb2f..23fbaa4a9630 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -4,7 +4,9 @@ CFLAGS += -Wall
 all:
 
 TEST_GEN_PROGS = test_memcontrol
+TEST_GEN_PROGS += test_core
 
 include ../lib.mk
 
 $(OUTPUT)/test_memcontrol: cgroup_util.c
+$(OUTPUT)/test_core: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e9e3c470561..1c5d2b2a583b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -229,6 +229,14 @@ int cg_destroy(const char *cgroup)
 	return ret;
 }
 
+int cg_enter_current(const char *cgroup)
+{
+	char pidbuf[64];
+
+	snprintf(pidbuf, sizeof(pidbuf), "%d", getpid());
+	return cg_write(cgroup, "cgroup.procs", pidbuf);
+}
+
 int cg_run(const char *cgroup,
 	   int (*fn)(const char *cgroup, void *arg),
 	   void *arg)
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index fe82a297d4e0..1ff6f9f1abdc 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -32,6 +32,7 @@ extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
 		  void *arg);
+extern int cg_enter_current(const char *cgroup);
 extern int cg_run_nowait(const char *cgroup,
 			 int (*fn)(const char *cgroup, void *arg),
 			 void *arg);
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
new file mode 100644
index 000000000000..be59f9c34ea2
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -0,0 +1,395 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/limits.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+/*
+ * A(0) - B(0) - C(1)
+ *        \ D(0)
+ *
+ * A, B and C's "populated" fields would be 1 while D's 0.
+ * test that after the one process in C is moved to root,
+ * A,B and C's "populated" fields would flip to "0" and file
+ * modified events will be generated on the
+ * "cgroup.events" files of both cgroups.
+ */
+static int test_cgcore_populated(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_test_a = NULL, *cg_test_b = NULL;
+	char *cg_test_c = NULL, *cg_test_d = NULL;
+
+	cg_test_a = cg_name(root, "cg_test_a");
+	cg_test_b = cg_name(root, "cg_test_a/cg_test_b");
+	cg_test_c = cg_name(root, "cg_test_a/cg_test_b/cg_test_c");
+	cg_test_d = cg_name(root, "cg_test_a/cg_test_b/cg_test_d");
+
+	if (!cg_test_a || !cg_test_b || !cg_test_c || !cg_test_d)
+		goto cleanup;
+
+	if (cg_create(cg_test_a))
+		goto cleanup;
+
+	if (cg_create(cg_test_b))
+		goto cleanup;
+
+	if (cg_create(cg_test_c))
+		goto cleanup;
+
+	if (cg_create(cg_test_d))
+		goto cleanup;
+
+	if (cg_enter_current(cg_test_c))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_a, "cgroup.events", "populated 1\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_b, "cgroup.events", "populated 1\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_c, "cgroup.events", "populated 1\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	if (cg_enter_current(root))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_a, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_b, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_c, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cg_test_d)
+		cg_destroy(cg_test_d);
+	if (cg_test_c)
+		cg_destroy(cg_test_c);
+	if (cg_test_b)
+		cg_destroy(cg_test_b);
+	if (cg_test_a)
+		cg_destroy(cg_test_a);
+	free(cg_test_d);
+	free(cg_test_c);
+	free(cg_test_b);
+	free(cg_test_a);
+	return ret;
+}
+
+/*
+ * A (domain threaded) - B (threaded) - C (domain)
+ *
+ * test that C can't be used until it is turned into a
+ * threaded cgroup.  "cgroup.type" file will report "domain (invalid)" in
+ * these cases. Operations which fail due to invalid topology use
+ * EOPNOTSUPP as the errno.
+ */
+static int test_cgcore_invalid_domain(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *grandparent = NULL, *parent = NULL, *child = NULL;
+
+	grandparent = cg_name(root, "cg_test_grandparent");
+	parent = cg_name(root, "cg_test_grandparent/cg_test_parent");
+	child = cg_name(root, "cg_test_grandparent/cg_test_parent/cg_test_child");
+	if (!parent || !child || !grandparent)
+		goto cleanup;
+
+	if (cg_create(grandparent))
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	if (cg_read_strcmp(child, "cgroup.type", "domain invalid\n"))
+		goto cleanup;
+
+	if (!cg_enter_current(child))
+		goto cleanup;
+
+	if (errno != EOPNOTSUPP)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	if (grandparent)
+		cg_destroy(grandparent);
+	free(child);
+	free(parent);
+	free(grandparent);
+	return ret;
+}
+
+/*
+ * Test that when a child becomes threaded
+ * the parent type becomes domain threaded.
+ */
+static int test_cgcore_parent_becomes_threaded(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent = NULL, *child = NULL;
+
+	parent = cg_name(root, "cg_test_parent");
+	child = cg_name(root, "cg_test_parent/cg_test_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(child, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	if (cg_read_strcmp(parent, "cgroup.type", "domain threaded\n"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+	return ret;
+
+}
+
+/*
+ * Test that there's no internal process constrain on threaded cgroups.
+ * You can add threads/processes on a parent with a controller enabled.
+ */
+static int test_cgcore_no_internal_process_constraint_on_threads(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent = NULL, *child = NULL;
+
+	if (cg_read_strstr(root, "cgroup.controllers", "cpu") ||
+	    cg_read_strstr(root, "cgroup.subtree_control", "cpu")) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	parent = cg_name(root, "cg_test_parent");
+	child = cg_name(root, "cg_test_parent/cg_test_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	if (cg_write(child, "cgroup.type", "threaded"))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+cpu"))
+		goto cleanup;
+
+	if (cg_enter_current(parent))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	cg_enter_current(root);
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+	return ret;
+}
+
+/*
+ * Test that you can't enable a controller on a child if it's not enabled
+ * on the parent.
+ */
+static int test_cgcore_top_down_constraint_enable(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent = NULL, *child = NULL;
+
+	parent = cg_name(root, "cg_test_parent");
+	child = cg_name(root, "cg_test_parent/cg_test_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (!cg_write(child, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+	return ret;
+}
+
+/*
+ * Test that you can't disable a controller on a parent
+ * if it's enabled in a child.
+ */
+static int test_cgcore_top_down_constraint_disable(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent = NULL, *child = NULL;
+
+	parent = cg_name(root, "cg_test_parent");
+	child = cg_name(root, "cg_test_parent/cg_test_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(child, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (!cg_write(parent, "cgroup.subtree_control", "-memory"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+	return ret;
+}
+
+/*
+ * Test internal process constraint.
+ * You can't add a pid to a domain parent if a controller is enabled.
+ */
+static int test_cgcore_internal_process_constraint(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent = NULL, *child = NULL;
+
+	parent = cg_name(root, "cg_test_parent");
+	child = cg_name(root, "cg_test_parent/cg_test_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (!cg_enter_current(parent))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct corecg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_cgcore_internal_process_constraint),
+	T(test_cgcore_top_down_constraint_enable),
+	T(test_cgcore_top_down_constraint_disable),
+	T(test_cgcore_no_internal_process_constraint_on_threads),
+	T(test_cgcore_parent_becomes_threaded),
+	T(test_cgcore_invalid_domain),
+	T(test_cgcore_populated),
+};
+#undef T
+
+int main(int argc, char *argv[])
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a0002563e9ee..1ad70cdaf442 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -9,28 +9,22 @@ echo > kprobe_events
 
 case `uname -m` in
 x86_64)
-  ARG2=%si
-  OFFS=8
+  ARG1=%di
 ;;
 i[3456]86)
-  ARG2=%cx
-  OFFS=4
+  ARG1=%ax
 ;;
 aarch64)
-  ARG2=%x1
-  OFFS=8
+  ARG1=%x0
 ;;
 arm*)
-  ARG2=%r1
-  OFFS=4
+  ARG1=%r0
 ;;
 ppc64*)
-  ARG2=%r4
-  OFFS=8
+  ARG1=%r3
 ;;
 ppc*)
-  ARG2=%r4
-  OFFS=4
+  ARG1=%r3
 ;;
 *)
   echo "Please implement other architecture here"
@@ -38,17 +32,17 @@ ppc*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test1 test2 >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
 echo 0 > events/enable
 echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index 4fda01a08da4..519d2763f5d2 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -4,7 +4,7 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-TARGET_FUNC=create_trace_kprobe
+TARGET_FUNC=tracefs_create_dir
 
 dec_addr() { # hexaddr
   printf "%d" "0x"`echo $1 | tail -c 8`
diff --git a/tools/testing/selftests/mount/config b/tools/testing/selftests/mount/config
index b5d881e48548..416bd53ce982 100644
--- a/tools/testing/selftests/mount/config
+++ b/tools/testing/selftests/mount/config
@@ -1,2 +1 @@
 CONFIG_USER_NS=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index f5d7a7851e21..9e03d61f52fd 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,6 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../lib.mk
 
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+ifeq ($(ARCH),x86)
+TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
+endif
+
 ifndef CROSS_COMPILE
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -8,14 +16,11 @@ ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
 
-TEST_PROGS := $(OUTPUT)/vdso_test $(OUTPUT)/vdso_standalone_test_x86
-
-all: $(TEST_PROGS)
+all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
 
-EXTRA_CLEAN := $(TEST_PROGS)
 endif
diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selftests/vDSO/vdso_test.c
index 2df26bd0099c..eda53f833d8e 100644
--- a/tools/testing/selftests/vDSO/vdso_test.c
+++ b/tools/testing/selftests/vDSO/vdso_test.c
@@ -15,6 +15,8 @@
 #include <sys/auxv.h>
 #include <sys/time.h>
 
+#include "../kselftest.h"
+
 extern void *vdso_sym(const char *version, const char *name);
 extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
 extern void vdso_init_from_auxv(void *auxv);
@@ -37,7 +39,7 @@ int main(int argc, char **argv)
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
@@ -48,7 +50,7 @@ int main(int argc, char **argv)
 
 	if (!gtod) {
 		printf("Could not find %s\n", name);
-		return 1;
+		return KSFT_SKIP;
 	}
 
 	struct timeval tv;
@@ -59,6 +61,7 @@ int main(int argc, char **argv)
 		       (long long)tv.tv_sec, (long long)tv.tv_usec);
 	} else {
 		printf("%s failed\n", name);
+		return KSFT_FAIL;
 	}
 
 	return 0;

--------------A6FA09E283D28294E3DA703F--
