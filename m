Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeDUHxV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:53:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeDUHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:53:20 -0400
Date: Sat, 21 Apr 2018 00:52:56 -0700
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-66f5a0779af2a4f28b1832f6c20bc9d3b1ab1886@git.kernel.org>
Cc: mingo@kernel.org, jolsa@redhat.com, tglx@linutronix.de,
        pombredanne@nexb.com, uneedsihyeon@gmail.com,
        ravi.bangoria@linux.vnet.ibm.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kstewart@linuxfoundation.org, hpa@zytor.com, namhyung@kernel.org,
        kjlx@templeofstupid.com, acme@redhat.com, peterz@infradead.org
Reply-To: uneedsihyeon@gmail.com, pombredanne@nexb.com, tglx@linutronix.de,
        jolsa@redhat.com, mingo@kernel.org, mhiramat@kernel.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ravi.bangoria@linux.vnet.ibm.com,
        kjlx@templeofstupid.com, namhyung@kernel.org, peterz@infradead.org,
        acme@redhat.com
In-Reply-To: <20180417041346.5617-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417041346.5617-2-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add '\n' at the end of parse-options
 error messages
Git-Commit-ID: 66f5a0779af2a4f28b1832f6c20bc9d3b1ab1886
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

Commit-ID:  66f5a0779af2a4f28b1832f6c20bc9d3b1ab1886
Gitweb:     https://git.kernel.org/tip/66f5a0779af2a4f28b1832f6c20bc9d3b1ab1886
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Tue, 17 Apr 2018 09:43:44 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:51 -0300

perf tools: Add '\n' at the end of parse-options error messages

Few error messages does not have '\n' at the end and thus next prompt
gets printed in the same line. Ex,

  linux~$ perf buildid-cache -verbose --add ./a.out
   Error: did you mean `--verbose` (with two dashes ?)linux~$

Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180417041346.5617-2-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index f6a1babcbac4..cb7154eccbdc 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -433,7 +433,7 @@ match:
 
 	if (ambiguous_option) {
 		 fprintf(stderr,
-			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)",
+			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)\n",
 			 arg,
 			 (ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			 ambiguous_option->long_name,
@@ -458,7 +458,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (strstarts(arg, "no-")) {
-		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 		exit(129);
 	}
 
@@ -466,7 +466,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (strstarts(options->long_name, arg)) {
-			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 			exit(129);
 		}
 	}
