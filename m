Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DF8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEDE21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLRN4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:56:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeLRN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:56:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDtM0T2851535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:55:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDtLfA2851532;
        Tue, 18 Dec 2018 05:55:21 -0800
Date:   Tue, 18 Dec 2018 05:55:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-2a07d814747b386feec7d7150fe519feb2a2a5f2@git.kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com,
        alexey.budankov@linux.intel.com
Reply-To: namhyung@kernel.org, ak@linux.intel.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com>
References: <5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build feature: Check if libaio is available
Git-Commit-ID: 2a07d814747b386feec7d7150fe519feb2a2a5f2
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

Commit-ID:  2a07d814747b386feec7d7150fe519feb2a2a5f2
Gitweb:     https://git.kernel.org/tip/2a07d814747b386feec7d7150fe519feb2a2a5f2
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 6 Nov 2018 12:03:35 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:54 -0300

tools build feature: Check if libaio is available

This will be used by 'perf record' to speed up reading the perf ring
buffer.

Committer testing:

  $ make -C tools/perf O=/tmp/build/perf
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ OFF ]
  ...                      libaudit: [ OFF ]
  ...                        libbfd: [ OFF ]
  ...                        libelf: [ on  ]
  ...                       libnuma: [ OFF ]
  ...        numa_num_possible_cpus: [ OFF ]
  ...                       libperl: [ OFF ]
  ...                     libpython: [ OFF ]
  ...                      libslang: [ on  ]
  ...                     libcrypto: [ on  ]
  ...                     libunwind: [ on  ]
  ...            libdw-dwarf-unwind: [ on  ]
  ...                          zlib: [ on  ]
  ...                          lzma: [ on  ]
  ...                     get_cpuid: [ on  ]
  ...                           bpf: [ on  ]
  ...                        libaio: [ on  ]

  $ ls -la /tmp/build/perf/feature/test-libaio.*
  -rwxrwxr-x. 1 acme acme 18296 Nov 26 08:49 /tmp/build/perf/feature/test-libaio.bin
  -rw-rw-r--. 1 acme acme  1165 Nov 26 08:49 /tmp/build/perf/feature/test-libaio.d
  -rw-rw-r--. 1 acme acme     0 Nov 26 08:49 /tmp/build/perf/feature/test-libaio.make.output
  $
  $ grep -i aio /tmp/build/perf/FEATURE-DUMP
  feature-libaio=1
  $

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature      |  6 ++++--
 tools/build/feature/Makefile      |  6 +++++-
 tools/build/feature/test-all.c    |  5 +++++
 tools/build/feature/test-libaio.c | 16 ++++++++++++++++
 tools/perf/Makefile.config        |  6 ++++++
 tools/perf/Makefile.perf          |  7 ++++++-
 6 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8a123834a2a3..d47b8f73e2e7 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,7 +70,8 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libopencsd
+        libopencsd			\
+        libaio
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -116,7 +117,8 @@ FEATURE_DISPLAY ?=              \
          zlib                   \
          lzma                   \
          get_cpuid              \
-         bpf
+         bpf			\
+         libaio
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 38c22e122cb0..2dbcc0d00f52 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -61,7 +61,8 @@ FILES=                                          \
          test-libopencsd.bin			\
          test-clang.bin				\
          test-llvm.bin				\
-         test-llvm-version.bin
+         test-llvm-version.bin			\
+         test-libaio.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -297,6 +298,9 @@ $(OUTPUT)test-clang.bin:
 
 -include $(OUTPUT)*.d
 
+$(OUTPUT)test-libaio.bin:
+	$(BUILD) -lrt
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 58f01b950195..20cdaa4fc112 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -174,6 +174,10 @@
 # include "test-libopencsd.c"
 #undef main
 
+#define main main_test_libaio
+# include "test-libaio.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -214,6 +218,7 @@ int main(int argc, char *argv[])
 	main_test_sdt();
 	main_test_setns();
 	main_test_libopencsd();
+	main_test_libaio();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libaio.c b/tools/build/feature/test-libaio.c
new file mode 100644
index 000000000000..932133c9a265
--- /dev/null
+++ b/tools/build/feature/test-libaio.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <aio.h>
+
+int main(void)
+{
+	struct aiocb aiocb;
+
+	aiocb.aio_fildes  = 0;
+	aiocb.aio_offset  = 0;
+	aiocb.aio_buf     = 0;
+	aiocb.aio_nbytes  = 0;
+	aiocb.aio_reqprio = 0;
+	aiocb.aio_sigevent.sigev_notify = 1 /*SIGEV_NONE*/;
+
+	return (int)aio_return(&aiocb);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c643d5e0c26b..b66f97a04b12 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -365,6 +365,12 @@ ifeq ($(feature-glibc), 1)
   CFLAGS += -DHAVE_GLIBC_SUPPORT
 endif
 
+ifeq ($(feature-libaio), 1)
+  ifndef NO_AIO
+    CFLAGS += -DHAVE_AIO_SUPPORT
+  endif
+endif
+
 ifdef NO_DWARF
   NO_LIBDW_DWARF_UNWIND := 1
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 239e7b3270f4..67e9adbe6ee8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -101,8 +101,13 @@ include ../scripts/utilities.mak
 # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
-
+#
 # Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+#
+# Define NO_AIO if you do not want support of Posix AIO based trace
+# streaming for record mode. Currently Posix AIO trace streaming is
+# supported only when linking with glibc.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
