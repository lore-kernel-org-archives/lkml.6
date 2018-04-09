Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758033AbeDICdF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:33:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:4905 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754232AbeDICdB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:33:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,426,1517904000";
   d="scan'208";a="215038564"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/3] perf: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
Date: Mon,  9 Apr 2018 18:26:48 +0800
Message-Id: <1523269609-28824-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
References: <1523269609-28824-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make consistent with other HAVE_XXX_SUPPORT in Makefile.config,
this patch renames HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
and update the C code accordingly.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Makefile.config          | 2 +-
 tools/perf/builtin-help.c           | 2 +-
 tools/perf/perf.c                   | 4 ++--
 tools/perf/util/generate-cmdlist.sh | 2 +-
 tools/perf/util/syscalltbl.c        | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c7abd83..9ea9b06 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -68,7 +68,7 @@ ifeq ($(NO_PERF_REGS),0)
 endif
 
 ifneq ($(NO_SYSCALL_TABLE),1)
-  CFLAGS += -DHAVE_SYSCALL_TABLE
+  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
 endif
 
 # So far there's only x86 and arm libdw unwind support merged in perf.
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 4aca13f..1c41b4e 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -439,7 +439,7 @@ int cmd_help(int argc, const char **argv)
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
 #endif
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		"trace",
 #endif
 	NULL };
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1659029..20a08cb 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -73,7 +73,7 @@ static struct cmd_struct commands[] = {
 	{ "lock",	cmd_lock,	0 },
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 	{ "trace",	cmd_trace,	0 },
 #endif
 	{ "inject",	cmd_inject,	0 },
@@ -491,7 +491,7 @@ int main(int argc, const char **argv)
 		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		setup_path();
 		argv[0] = "trace";
 		return cmd_trace(argc, argv);
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index ff17920..c3cef36 100755
--- a/tools/perf/util/generate-cmdlist.sh
+++ b/tools/perf/util/generate-cmdlist.sh
@@ -38,7 +38,7 @@ do
 done
 echo "#endif /* HAVE_LIBELF_SUPPORT */"
 
-echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)"
+echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
 sort |
 while read cmd
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 895122d..0ee7f56 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 
-#ifdef HAVE_SYSCALL_TABLE
+#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 #include <string.h>
 #include "string2.h"
 #include "util.h"
@@ -139,7 +139,7 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
 
-#else /* HAVE_SYSCALL_TABLE */
+#else /* HAVE_SYSCALL_TABLE_SUPPORT */
 
 #include <libaudit.h>
 
@@ -176,4 +176,4 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 {
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
-#endif /* HAVE_SYSCALL_TABLE */
+#endif /* HAVE_SYSCALL_TABLE_SUPPORT */
-- 
2.7.4
