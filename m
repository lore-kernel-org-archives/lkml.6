Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeDPGqG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:46:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeDPGqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:46:05 -0400
Date: Sun, 15 Apr 2018 23:45:44 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-22e9af4e94801bbdf6945e55db64b877be7c71b3@git.kernel.org>
Cc: yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        ak@linux.intel.com, kan.liang@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: acme@redhat.com, kan.liang@linux.intel.com, ak@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
In-Reply-To: <1523269609-28824-3-git-send-email-yao.jin@linux.intel.com>
References: <1523269609-28824-3-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Rename HAVE_SYSCALL_TABLE to
 HAVE_SYSCALL_TABLE_SUPPORT
Git-Commit-ID: 22e9af4e94801bbdf6945e55db64b877be7c71b3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  22e9af4e94801bbdf6945e55db64b877be7c71b3
Gitweb:     https://git.kernel.org/tip/22e9af4e94801bbdf6945e55db64b877be7c71b3
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 9 Apr 2018 18:26:48 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:31 -0300

perf tools: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT

To be consistent with other HAVE_XXX_SUPPORT uses in Makefile.config,
this patch renames HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT and
updates the C code accordingly.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1523269609-28824-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config          | 2 +-
 tools/perf/builtin-help.c           | 2 +-
 tools/perf/perf.c                   | 4 ++--
 tools/perf/util/generate-cmdlist.sh | 2 +-
 tools/perf/util/syscalltbl.c        | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6b307e97dc57..ae7dc46e8f8a 100644
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
index 4aca13f23b9d..1c41b4eaf73c 100644
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
index 1659029d03fc..20a08cb32332 100644
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
index ff17920a5ebc..c3cef36d4176 100755
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
index 895122d638dd..0ee7f568d60c 100644
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
