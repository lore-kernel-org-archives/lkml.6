Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24501ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C1120854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDXGPNgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C1120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeGRSNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:13:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38421 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbeGRSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:13:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so3679588wmf.3;
        Wed, 18 Jul 2018 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZHZyvZWaYFlZy4t9Me4Hp2dW+wIxR1+rJH+sanP6thA=;
        b=IDXGPNgOw5OlBwmj9rKhQOUlL64pFA6kO5IZH5iVODOYlMifpA7bvzC23IXAN938X4
         DvrglwxC9u+26tSh2Q3j/OS1JNjAUoHKihOqWgGd9TjoEBj0c4tObIkrFrpuijJ4JdRi
         ovNC/oz5crcJOGpXdjWPeVaqb2WuOCTauEtazRDU8aTzvQHEwM//aKVVFNUQUkiEWwhz
         bP97n/BB+bcobow6jNAc8jPlj9Vmlk7XGE0odxx6qmXEmIYK000LWaw5rp1iniZVXLJ9
         b3zJY0vEpGFNR19rk5i9cJUTTmAkKDzGzFWSEdTxSbzZUmADUxfTUCnepLRZJY54hoFB
         FWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZHZyvZWaYFlZy4t9Me4Hp2dW+wIxR1+rJH+sanP6thA=;
        b=EQbmmwgmrtDcOtaESLbq3mFOAvNaXmPTDSMpdnaF9wq1pM158Dy/PP1ZdtpM9R4roL
         VrKPYNDgJbdM5Q8wp7BIP/IUof48U0JRI8tiIe0qtSVxoDg3R2gfVJjhY3wvDSxm8bBR
         EY9C2Jhxe4AwtLz2oRws1mVwxmmf6kwijpad637VICKfc8lXvTHnFXzvf7+8rA5gM2Iy
         qMAXL3LOzo8eDk6MyxOq9WK1bdfdFB8e8n6CHrc9YPXmcV3xJ8zzROPv6oBpaHOxLs0z
         0Jnerbkpg8dczGkCLrInkQ0tvc+IRA7uwo3yFtRrfwmBb/Cujvffg+JhfROxw6/8ptS8
         viHw==
X-Gm-Message-State: AOUpUlFuPvLXnO1s6p6jRwjyS5gEybAEbfqUcp72CZ13K6JmprzPfZda
        YcsJ6AIuK2SIWf6oFSgmghW00989DgQ=
X-Google-Smtp-Source: AAOMgpfy8aSB+9ZoBpX84zXfziYxxXabzBXMFFzyxCO/0ubFhIVYQYyP6jtMhJTou/TqBgG+Y3GpGA==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr2043601wmo.11.1531935264309;
        Wed, 18 Jul 2018 10:34:24 -0700 (PDT)
Received: from localhost.localdomain (host241-253-dynamic.31-79-r.retail.telecomitalia.it. [79.31.253.241])
        by smtp.gmail.com with ESMTPSA id f8-v6sm6197773wrj.9.2018.07.18.10.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:34:23 -0700 (PDT)
From:   Claudio <claudiozumbo@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Claudio <claudiozumbo@gmail.com>,
        Claudio Zumbo <claudioz@fb.com>, Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com
Subject: [PATCH kselftest-next] Add cgroup core selftests
Date:   Wed, 18 Jul 2018 19:33:58 +0200
Message-Id: <20180718173358.14007-1-claudiozumbo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds tests for some of the core functionalities
of cgroups v2.

The commit adds tests for some core principles of croup V2 API:

- test_cgcore_internal_process_constraint

  Tests internal process constraint.
  You can't add a pid to a domain parent if a controller is enabled.

- test_cgcore_top_down_constraint_enable

   Tests that you can't enable a controller on a child if it's not enabled
   on the parent.

- test_cgcore_top_down_constraint_disable

  Tests that you can't disable a controller on a parent if it's
  enabled in a child.

- test_cgcore_no_internal_process_constraint_on_threads

  Tests that there's no internal process constrain on threaded cgroups.
  You can add threads/processes on a parent with a controller enabled.

- test_cgcore_parent_becomes_threaded

  Tests that when a child becomes threaded the parent type becomes
  domain threaded.

- test_cgcore_invalid_domain

  In a situation like:

  A (domain threaded) - B (threaded) - C (domain)

  it tests that C can't be used until it is turned into a threaded cgroup.
  The "cgroup.type" file will report "domain (invalid)" in these cases.
  Operations which fail due to invalid topology use EOPNOTSUPP as the errno.

- test_cgcore_populated

  In a situation like:

  A(0) - B(0) - C(1)
         \ D(0)

  It tests that A, B and C's "populated" fields would be 1 while D's 0.
  It tests that after the one process in C is moved to root, A,B and C's
  "populated" fields would flip to "0" and file modified events will
  be generated on the "cgroup.events" files of both cgroups.

Signed-off-by: Claudio Zumbo <claudioz@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 tools/testing/selftests/cgroup/Makefile      |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c |   8 +
 tools/testing/selftests/cgroup/cgroup_util.h |   1 +
 tools/testing/selftests/cgroup/test_core.c   | 395 +++++++++++++++++++++++++++
 4 files changed, 406 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_core.c

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
-- 
2.11.0

