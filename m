Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61248217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbeLTSDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:03:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLTSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:03:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI3gQ13680571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:03:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI3goI3680568;
        Thu, 20 Dec 2018 10:03:42 -0800
Date:   Thu, 20 Dec 2018 10:03:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-glyt6nzlt1yx56m5bshy6g83@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, jolsa@kernel.org, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify renameat2's flags argument
Git-Commit-ID: ca7ff2c8e7add62b661c414257e7ef12cd40a950
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

Commit-ID:  ca7ff2c8e7add62b661c414257e7ef12cd40a950
Gitweb:     https://git.kernel.org/tip/ca7ff2c8e7add62b661c414257e7ef12cd40a950
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 10:39:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:56 -0300

perf trace: Beautify renameat2's flags argument

  # strace -e renameat2 -f perf trace -e rename* mv c /tmp
  strace: Process 10824 attached
  [pid 10824] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp", RENAME_NOREPLACE) = -1 EXDEV (Invalid cross-device link)
  [pid 10824] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp/c", RENAME_NOREPLACE) = -1 EEXIST (File exists)
       1.857 ( 0.008 ms): mv/10824 renameat2(olddfd: CWD, oldname: 0x7ffc72ff3d81, newdfd: CWD, newname: 0x7ffc72ff3d83, flags: NOREPLACE) = -1 EXDEV Invalid cross-device link
       2.002 ( 0.006 ms): mv/10824 renameat2(olddfd: CWD, oldname: 0x7ffc72ff3d81, newdfd: CWD, newname: 0x55ad609efcc0, flags: NOREPLACE) = -1 EEXIST File exists
  mv: 'c' and '/tmp/c' are the same file
  [pid 10824] +++ exited with 1 +++
  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=10824, si_uid=0, si_status=1, si_utime=0, si_stime=0} ---
  +++ exited with 0 +++
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-glyt6nzlt1yx56m5bshy6g83@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c         |  3 ++-
 tools/perf/trace/beauty/Build      |  1 +
 tools/perf/trace/beauty/beauty.h   |  3 +++
 tools/perf/trace/beauty/renameat.c | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 60c61a89436f..4b3f8407f8d5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -801,7 +801,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "renameat2",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
-		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
+		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
+		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_sigprocmask",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 304313073242..10c85cd3eb4f 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -8,6 +8,7 @@ libperf-y += kcmp.o
 libperf-y += mount_flags.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
+libperf-y += renameat.o
 libperf-y += sockaddr.o
 libperf-y += socket.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 039c29039b2c..48ff3ce05325 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -144,6 +144,9 @@ size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_a
 size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG3 syscall_arg__scnprintf_prctl_arg3
 
+size_t syscall_arg__scnprintf_renameat2_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_RENAMEAT2_FLAGS syscall_arg__scnprintf_renameat2_flags
+
 size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_SOCKADDR syscall_arg__scnprintf_sockaddr
 
diff --git a/tools/perf/trace/beauty/renameat.c b/tools/perf/trace/beauty/renameat.c
new file mode 100644
index 000000000000..02c7207faee6
--- /dev/null
+++ b/tools/perf/trace/beauty/renameat.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+#include "trace/beauty/beauty.h"
+#include <uapi/linux/fs.h>
+
+static size_t renameat2__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+#include "trace/beauty/generated/rename_flags_array.c"
+       static DEFINE_STRARRAY(rename_flags);
+
+       return strarray__scnprintf_flags(&strarray__rename_flags, bf, size, flags);
+}
+
+size_t syscall_arg__scnprintf_renameat2_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+	return renameat2__scnprintf_flags(flags, bf, size);
+}
