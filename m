Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeFCRQR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 13:16:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFCRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 13:16:15 -0400
Date: Sun, 3 Jun 2018 10:15:57 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qtotspuztydjttxi7k6mec6h@git.kernel.org>
Cc: jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        wangnan0@huawei.com, dsahern@gmail.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, acme@redhat.com, dsahern@gmail.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace beauty prctl: Default header_dir to
 cwd to work without parms
Git-Commit-ID: 0d690fc043f17fe7afab4b3dd9a57ffa07bc8064
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

Commit-ID:  0d690fc043f17fe7afab4b3dd9a57ffa07bc8064
Gitweb:     https://git.kernel.org/tip/0d690fc043f17fe7afab4b3dd9a57ffa07bc8064
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 30 May 2018 10:29:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Jun 2018 16:13:06 -0300

perf trace beauty prctl: Default header_dir to cwd to work without parms

Useful when checking the effects of header synchs for the files it uses
as a input to generate string tables, in retrospect this is how it
should've been done from day 1, not requiring the header_dir to be set
on the Makefile, will change everything later, so that the only parm,
common to all generators will be $(srctree) and $(beauty_outdir).

So, to see what it generates, just call it without any parameters:

  $ tools/perf/trace/beauty/prctl_option.sh
  static const char *prctl_options[] = {
	  [1] = "SET_PDEATHSIG",
	  [2] = "GET_PDEATHSIG",
	  [3] = "GET_DUMPABLE",
	  [4] = "SET_DUMPABLE",
	  [5] = "GET_UNALIGN",
	  [6] = "SET_UNALIGN",
	  [7] = "GET_KEEPCAPS",
	  [8] = "SET_KEEPCAPS",
	  [9] = "GET_FPEMU",
	  [10] = "SET_FPEMU",
	  [11] = "GET_FPEXC",
	  [12] = "SET_FPEXC",
	  [13] = "GET_TIMING",
	  [14] = "SET_TIMING",
	  [15] = "SET_NAME",
	  [16] = "GET_NAME",
	  [19] = "GET_ENDIAN",
	  [20] = "SET_ENDIAN",
	  [21] = "GET_SECCOMP",
	  [22] = "SET_SECCOMP",
	  [25] = "GET_TSC",
	  [26] = "SET_TSC",
	  [27] = "GET_SECUREBITS",
	  [28] = "SET_SECUREBITS",
	  [29] = "SET_TIMERSLACK",
	  [30] = "GET_TIMERSLACK",
	  [35] = "SET_MM",
	  [36] = "SET_CHILD_SUBREAPER",
	  [37] = "GET_CHILD_SUBREAPER",
	  [38] = "SET_NO_NEW_PRIVS",
	  [39] = "GET_NO_NEW_PRIVS",
	  [40] = "GET_TID_ADDRESS",
	  [41] = "SET_THP_DISABLE",
	  [42] = "GET_THP_DISABLE",
	  [45] = "SET_FP_MODE",
	  [46] = "GET_FP_MODE",
  };
  static const char *prctl_set_mm_options[] = {
	  [1] = "START_CODE",
	  [2] = "END_CODE",
	  [3] = "START_DATA",
	  [4] = "END_DATA",
	  [5] = "START_STACK",
	  [6] = "START_BRK",
	  [7] = "BRK",
	  [8] = "ARG_START",
	  [9] = "ARG_END",
	  [10] = "ENV_START",
	  [11] = "ENV_END",
	  [12] = "AUXV",
	  [13] = "EXE_FILE",
	  [14] = "MAP",
	  [15] = "MAP_SIZE",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qtotspuztydjttxi7k6mec6h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 0be4138fbe71..f24722146ebe 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-header_dir=$1
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
 regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
