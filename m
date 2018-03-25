Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeCYWJZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:09:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeCYWJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:09:19 -0400
Date: Sun, 25 Mar 2018 15:07:56 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-45twzienhz7ypbad0sbvojku@git.kernel.org>
Cc: ak@linux.intel.com, acme@redhat.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, wangnan0@huawei.com, hpa@zytor.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        jolsa@kernel.org, yao.jin@linux.intel.com, wangnan0@huawei.com,
        hpa@zytor.com, dsahern@gmail.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, acme@redhat.com, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move annotation_options out of the
 TUI browser
Git-Commit-ID: 98bc80b0a199619d2987e61e42415a1ae7a1d7fb
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

Commit-ID:  98bc80b0a199619d2987e61e42415a1ae7a1d7fb
Gitweb:     https://git.kernel.org/tip/98bc80b0a199619d2987e61e42415a1ae7a1d7fb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 10:03:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:27 -0300

perf annotate: Move annotation_options out of the TUI browser

This will be useful when making parts of the TUI browser generic enough
to be used for a new stdio mode, available even when the TUI is not
built in, for explicit user decision or when the necessary library devel
files, for the slang library currently, are not available in the build
system.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-45twzienhz7ypbad0sbvojku@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 10 +---------
 tools/perf/util/annotate.h        | 10 ++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 618edf96353c..69ec968ac0be 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -31,15 +31,7 @@ struct browser_line {
 	int	jump_sources;
 };
 
-static struct annotate_browser_opt {
-	bool hide_src_code,
-	     use_offset,
-	     jump_arrows,
-	     show_linenr,
-	     show_nr_jumps,
-	     show_nr_samples,
-	     show_total_period;
-} annotate_browser__opts = {
+static struct annotation_options annotate_browser__opts = {
 	.use_offset	= true,
 	.jump_arrows	= true,
 };
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7e914e834101..e924033432a3 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -58,6 +58,16 @@ bool ins__is_lock(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
+struct annotation_options {
+	bool hide_src_code,
+	     use_offset,
+	     jump_arrows,
+	     show_linenr,
+	     show_nr_jumps,
+	     show_nr_samples,
+	     show_total_period;
+};
+
 struct annotation;
 
 struct sym_hist_entry {
