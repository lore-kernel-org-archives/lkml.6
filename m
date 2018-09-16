Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EBECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C8D2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C8D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeIQBqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:46:48 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52896 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeIQBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:46:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 6F63FC0CC3;
        Sun, 16 Sep 2018 20:22:37 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NUSgRSRwR0xm; Sun, 16 Sep 2018 20:22:37 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B53E4C0CB9;
        Sun, 16 Sep 2018 20:22:28 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest fixes update for Linux 4.19-rc5
Message-ID: <ce9af2b4-86e1-6603-cd36-b900fb583e6f@kernel.org>
Date:   Sun, 16 Sep 2018 14:22:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E95E753461B77C2529D70351"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E95E753461B77C2529D70351
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 4.19-rc5

linux-kselftest-4.19-rc5

This Kselftest fixes update for 4.19-rc5 consists of:

-- fixes to build failures
-- fixes to add missing config files to increase test coverage
-- fixes to cgroup test and a new cgroup test for memory.oom.group

Please note that the selftests: add headers_install to lib.mk patch changes
the main Makefile. Some tests can't build without headers installed. This 
fixes such test build failures.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.19-rc5

for you to fetch changes up to a987785dcd6c8ae2915460582aebd6481c81eb67:

  Add tests for memory.oom.group (2018-09-07 16:36:01 -0600)

----------------------------------------------------------------
linux-kselftest-4.19-rc5

This Kselftest fixes update for 4.19-rc5 consists of:

-- fixes to build failures
-- fixes to add missing config files to increase test coverage
-- fixes to cgroup test and a new cgroup test for memory.oom.group

----------------------------------------------------------------
Anders Roxell (2):
      selftests: android: move config up a level
      selftests: add headers_install to lib.mk

Jay Kamat (2):
      Fix cg_read_strcmp()
      Add tests for memory.oom.group

Lei Yang (3):
      selftests/efivarfs: add required kernel configs
      selftests: memory-hotplug: add required configs
      cgroup: kselftests: add test_core to .gitignore

Thiago Jung Bauermann (1):
      selftests: kselftest: Remove outdated comment

 Makefile                                           |  14 +-
 scripts/subarch.include                            |  13 ++
 tools/testing/selftests/android/Makefile           |   2 +-
 tools/testing/selftests/android/{ion => }/config   |   0
 tools/testing/selftests/android/ion/Makefile       |   2 +
 tools/testing/selftests/cgroup/.gitignore          |   1 +
 tools/testing/selftests/cgroup/cgroup_util.c       |  38 +++-
 tools/testing/selftests/cgroup/cgroup_util.h       |   1 +
 tools/testing/selftests/cgroup/test_memcontrol.c   | 205 +++++++++++++++++++++
 tools/testing/selftests/efivarfs/config            |   1 +
 tools/testing/selftests/futex/functional/Makefile  |   1 +
 tools/testing/selftests/gpio/Makefile              |   7 +-
 tools/testing/selftests/kselftest.h                |   1 -
 tools/testing/selftests/kvm/Makefile               |   7 +-
 tools/testing/selftests/lib.mk                     |  12 ++

----------------------------------------------------------------

--------------E95E753461B77C2529D70351
Content-Type: text/x-patch;
 name="linux-kselftest-4.19-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.19-rc5.diff"

diff --git a/Makefile b/Makefile
index 2b458801ba74..8b3fbdb2759b 100644
--- a/Makefile
+++ b/Makefile
@@ -299,19 +299,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
-# SUBARCH tells the usermode build what the underlying arch is.  That is set
-# first, and if a usermode build is happening, the "ARCH=um" on the command
-# line overrides the setting of ARCH below.  If a native build is happening,
-# then ARCH is assigned, getting whatever value it gets normally, and
-# SUBARCH is subsequently ignored.
-
-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
-				  -e s/sun4u/sparc64/ \
-				  -e s/arm.*/arm/ -e s/sa110/arm/ \
-				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-				  -e s/riscv.*/riscv/)
+include scripts/subarch.include
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
diff --git a/scripts/subarch.include b/scripts/subarch.include
new file mode 100644
index 000000000000..650682821126
--- /dev/null
+++ b/scripts/subarch.include
@@ -0,0 +1,13 @@
+# SUBARCH tells the usermode build what the underlying arch is.  That is set
+# first, and if a usermode build is happening, the "ARCH=um" on the command
+# line overrides the setting of ARCH below.  If a native build is happening,
+# then ARCH is assigned, getting whatever value it gets normally, and
+# SUBARCH is subsequently ignored.
+
+SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+				  -e s/sun4u/sparc64/ \
+				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
+				  -e s/riscv.*/riscv/)
diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 72c25a3cb658..d9a725478375 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -6,7 +6,7 @@ TEST_PROGS := run.sh
 
 include ../lib.mk
 
-all:
+all: khdr
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/config
similarity index 100%
rename from tools/testing/selftests/android/ion/config
rename to tools/testing/selftests/android/config
diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index e03695287f76..88cfe88e466f 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -10,6 +10,8 @@ $(TEST_GEN_FILES): ipcsocket.c ionutils.c
 
 TEST_PROGS := ion_test.sh
 
+KSFT_KHDR_INSTALL := 1
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 95eb3a53c381..adacda50a4b2 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -1 +1,2 @@
 test_memcontrol
+test_core
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1c5d2b2a583b..14c9fe284806 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -89,17 +89,28 @@ int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
 int cg_read_strcmp(const char *cgroup, const char *control,
 		   const char *expected)
 {
-	size_t size = strlen(expected) + 1;
+	size_t size;
 	char *buf;
+	int ret;
+
+	/* Handle the case of comparing against empty string */
+	if (!expected)
+		size = 32;
+	else
+		size = strlen(expected) + 1;
 
 	buf = malloc(size);
 	if (!buf)
 		return -1;
 
-	if (cg_read(cgroup, control, buf, size))
+	if (cg_read(cgroup, control, buf, size)) {
+		free(buf);
 		return -1;
+	}
 
-	return strcmp(expected, buf);
+	ret = strcmp(expected, buf);
+	free(buf);
+	return ret;
 }
 
 int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
@@ -337,3 +348,24 @@ int is_swap_enabled(void)
 
 	return cnt > 1;
 }
+
+int set_oom_adj_score(int pid, int score)
+{
+	char path[PATH_MAX];
+	int fd, len;
+
+	sprintf(path, "/proc/%d/oom_score_adj", pid);
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return fd;
+
+	len = dprintf(fd, "%d", score);
+	if (len < 0) {
+		close(fd);
+		return len;
+	}
+
+	close(fd);
+	return 0;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 1ff6f9f1abdc..9ac8b7958f83 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -40,3 +40,4 @@ extern int get_temp_fd(void);
 extern int alloc_pagecache(int fd, size_t size);
 extern int alloc_anon(const char *cgroup, void *arg);
 extern int is_swap_enabled(void);
+extern int set_oom_adj_score(int pid, int score);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index cf0bddc9d271..28d321ba311b 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -2,6 +2,7 @@
 #define _GNU_SOURCE
 
 #include <linux/limits.h>
+#include <linux/oom.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -202,6 +203,36 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 	return 0;
 }
 
+static int alloc_anon_noexit(const char *cgroup, void *arg)
+{
+	int ppid = getppid();
+
+	if (alloc_anon(cgroup, arg))
+		return -1;
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	return 0;
+}
+
+/*
+ * Wait until processes are killed asynchronously by the OOM killer
+ * If we exceed a timeout, fail.
+ */
+static int cg_test_proc_killed(const char *cgroup)
+{
+	int limit;
+
+	for (limit = 10; limit > 0; limit--) {
+		if (cg_read_strcmp(cgroup, "cgroup.procs", "") == 0)
+			return 0;
+
+		usleep(100000);
+	}
+	return -1;
+}
+
 /*
  * First, this test creates the following hierarchy:
  * A       memory.min = 50M,  memory.max = 200M
@@ -964,6 +995,177 @@ static int test_memcg_sock(const char *root)
 	return ret;
 }
 
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes in the leaf (but not the parent) were killed.
+ */
+static int test_memcg_oom_group_leaf_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child;
+
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+
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
+	if (cg_write(child, "memory.max", "50M"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.oom.group", "1"))
+		goto cleanup;
+
+	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	if (!cg_run(child, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_test_proc_killed(child))
+		goto cleanup;
+
+	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
+		goto cleanup;
+
+	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
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
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes in the parent and leaf were killed.
+ */
+static int test_memcg_oom_group_parent_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child;
+
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.max", "80M"))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.oom.group", "1"))
+		goto cleanup;
+
+	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+
+	if (!cg_run(child, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_test_proc_killed(child))
+		goto cleanup;
+	if (cg_test_proc_killed(parent))
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
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes were killed except those set with OOM_SCORE_ADJ_MIN
+ */
+static int test_memcg_oom_group_score_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	int safe_pid;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "50M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.oom.group", "1"))
+		goto cleanup;
+
+	safe_pid = cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
+	if (set_oom_adj_score(safe_pid, OOM_SCORE_ADJ_MIN))
+		goto cleanup;
+
+	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
+		goto cleanup;
+
+	if (kill(safe_pid, SIGKILL))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -978,6 +1180,9 @@ struct memcg_test {
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
 	T(test_memcg_sock),
+	T(test_memcg_oom_group_leaf_events),
+	T(test_memcg_oom_group_parent_events),
+	T(test_memcg_oom_group_score_events),
 };
 #undef T
 
diff --git a/tools/testing/selftests/efivarfs/config b/tools/testing/selftests/efivarfs/config
new file mode 100644
index 000000000000..4e151f1005b2
--- /dev/null
+++ b/tools/testing/selftests/efivarfs/config
@@ -0,0 +1 @@
+CONFIG_EFIVAR_FS=y
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ff8feca49746..ad1eeb14fda7 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES := \
 
 TEST_PROGS := run.sh
 
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb47565c55..4665cdbf1a8d 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -21,11 +21,8 @@ endef
 CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+$(BINARIES):| khdr
+$(BINARIES): ../../../gpio/gpio-utils.o
 
 ../../../gpio/gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 15e6b75fc3a5..a3edb2c8e43d 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -19,7 +19,6 @@
 #define KSFT_FAIL  1
 #define KSFT_XFAIL 2
 #define KSFT_XPASS 3
-/* Treat skip as pass */
 #define KSFT_SKIP  4
 
 /* counters */
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 03b0f551bedf..87d1a8488af8 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -37,9 +37,6 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
-$(LINUX_HDR_PATH):
-	make -C $(top_srcdir) headers_install
-
-all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
+all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
+$(STATIC_LIBS):| khdr
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 17ab36605a8e..0a8e75886224 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,8 +16,20 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+top_srcdir ?= ../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH		?= $(SUBARCH)
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
+.PHONY: khdr
+khdr:
+	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
+
+ifdef KSFT_KHDR_INSTALL
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
+endif
+
 .ONESHELL:
 define RUN_TEST_PRINT_RESULT
 	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
diff --git a/tools/testing/selftests/memory-hotplug/config b/tools/testing/selftests/memory-hotplug/config
index 2fde30191a47..a7e8cd5bb265 100644
--- a/tools/testing/selftests/memory-hotplug/config
+++ b/tools/testing/selftests/memory-hotplug/config
@@ -2,3 +2,4 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_NOTIFIER_ERROR_INJECTION=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
+CONFIG_MEMORY_HOTREMOVE=y
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9cca68e440a0..919aa2ac00af 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
index a728040edbe1..14cfcf006936 100644
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := hwtstamp_config rxtimestamp timestamping txtimestamp
 
 all: $(TEST_PROGS)
 
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9881876d2aa0..e94b7b14bcb2 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -26,10 +26,6 @@ TEST_PROGS := run_vmtests
 
 include ../lib.mk
 
-$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install

--------------E95E753461B77C2529D70351--
