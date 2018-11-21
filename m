Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96110214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96110214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbeKVBgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:36:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKVBgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:36:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF1XHD3416665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:01:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF1XQe3416662;
        Wed, 21 Nov 2018 07:01:33 -0800
Date:   Wed, 21 Nov 2018 07:01:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x56ypm940pwclwu45d7jfj47@git.kernel.org>
Cc:     wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: acme@redhat.com, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          mingo@kernel.org, dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools build feature: Check if
 get_current_dir_name() is available
Git-Commit-ID: 8feb8efef97a134933620071e0b6384cb3238b4e
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

Commit-ID:  8feb8efef97a134933620071e0b6384cb3238b4e
Gitweb:     https://git.kernel.org/tip/8feb8efef97a134933620071e0b6384cb3238b4e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Nov 2018 16:56:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Nov 2018 12:12:17 -0800

tools build feature: Check if get_current_dir_name() is available

As the namespace support code will use this, which is not available in
some non _GNU_SOURCE libraries such as Android's bionic used in my
container build tests (r12b and r15c at the moment).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-x56ypm940pwclwu45d7jfj47@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                           |  1 +
 tools/build/feature/Makefile                           |  4 ++++
 tools/build/feature/test-all.c                         |  5 +++++
 ...test-reallocarray.c => test-get_current_dir_name.c} |  4 +++-
 tools/perf/Makefile.config                             |  5 +++++
 tools/perf/util/Build                                  |  1 +
 tools/perf/util/get_current_dir_name.c                 | 18 ++++++++++++++++++
 tools/perf/util/util.h                                 |  4 ++++
 8 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index f216b2f5c3d7..d74bb9414d7c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -33,6 +33,7 @@ FEATURE_TESTS_BASIC :=                  \
         dwarf_getlocations              \
         fortify-source                  \
         sync-compare-and-swap           \
+        get_current_dir_name            \
         glibc                           \
         gtk2                            \
         gtk2-infobar                    \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0516259be70f..304b984f11b9 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -7,6 +7,7 @@ FILES=                                          \
          test-dwarf_getlocations.bin            \
          test-fortify-source.bin                \
          test-sync-compare-and-swap.bin         \
+         test-get_current_dir_name.bin          \
          test-glibc.bin                         \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
@@ -101,6 +102,9 @@ $(OUTPUT)test-bionic.bin:
 $(OUTPUT)test-libelf.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-get_current_dir_name.bin:
+	$(BUILD)
+
 $(OUTPUT)test-glibc.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 8dc20a61341f..56722bfe6bdd 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -34,6 +34,10 @@
 # include "test-libelf-mmap.c"
 #undef main
 
+#define main main_test_get_current_dir_name
+# include "test-get_current_dir_name.c"
+#undef main
+
 #define main main_test_glibc
 # include "test-glibc.c"
 #undef main
@@ -174,6 +178,7 @@ int main(int argc, char *argv[])
 	main_test_hello();
 	main_test_libelf();
 	main_test_libelf_mmap();
+	main_test_get_current_dir_name();
 	main_test_glibc();
 	main_test_dwarf();
 	main_test_dwarf_getlocations();
diff --git a/tools/build/feature/test-reallocarray.c b/tools/build/feature/test-get_current_dir_name.c
similarity index 60%
copy from tools/build/feature/test-reallocarray.c
copy to tools/build/feature/test-get_current_dir_name.c
index 8170de35150d..573000f93212 100644
--- a/tools/build/feature/test-reallocarray.c
+++ b/tools/build/feature/test-get_current_dir_name.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#include <unistd.h>
 #include <stdlib.h>
 
 int main(void)
 {
-	return !!reallocarray(NULL, 1, 1);
+	free(get_current_dir_name());
+	return 0;
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e30d20fb482d..a0e8c23f9125 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -299,6 +299,11 @@ ifndef NO_BIONIC
   endif
 endif
 
+ifeq ($(feature-get_current_dir_name), 1)
+  CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
+endif
+
+
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ecd9f9ceda77..b7bf201fe8a8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ libperf-y += evlist.o
 libperf-y += evsel.o
 libperf-y += evsel_fprintf.o
 libperf-y += find_bit.o
+libperf-y += get_current_dir_name.o
 libperf-y += kallsyms.o
 libperf-y += levenshtein.o
 libperf-y += llvm-utils.o
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
new file mode 100644
index 000000000000..267aa609a582
--- /dev/null
+++ b/tools/perf/util/get_current_dir_name.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+//
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+#include "util.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdlib.h>
+
+/* Android's 'bionic' library, for one, doesn't have this */
+
+char *get_current_dir_name(void)
+{
+	char pwd[PATH_MAX];
+
+	return getcwd(pwd, sizeof(pwd)) == NULL ? NULL : strdup(pwd);
+}
+#endif // HAVE_GET_CURRENT_DIR_NAME
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 14508ee7707a..ece040b799f6 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -59,6 +59,10 @@ int fetch_kernel_version(unsigned int *puint,
 
 const char *perf_tip(const char *dirpath);
 
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+char *get_current_dir_name(void);
+#endif
+
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
