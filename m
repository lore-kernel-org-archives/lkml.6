Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCYWIj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:08:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeCYWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:08:35 -0400
Date: Sun, 25 Mar 2018 15:08:23 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-fisud7pcak3prk7uwsvs3g2e@git.kernel.org>
Cc: wangnan0@huawei.com, tglx@linutronix.de, jolsa@kernel.org,
        yao.jin@linux.intel.com, acme@redhat.com, dsahern@gmail.com,
        adrian.hunter@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
        yao.jin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, tglx@linutronix.de, ak@linux.intel.com,
        namhyung@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move cycles/IPC formatting width
 constants outside TUI
Git-Commit-ID: c426e5849b6019a0da7957e1acce4762c77f7c71
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

Commit-ID:  c426e5849b6019a0da7957e1acce4762c77f7c71
Gitweb:     https://git.kernel.org/tip/c426e5849b6019a0da7957e1acce4762c77f7c71
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 10:26:17 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:27 -0300

perf annotate: Move cycles/IPC formatting width constants outside TUI

These will be used in --stdio2 so lets move it first to reduce noise in
the following patches.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-fisud7pcak3prk7uwsvs3g2e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 19 ++++++++-----------
 tools/perf/util/annotate.h        |  3 +++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 69ec968ac0be..ca3d99c1e4d9 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -22,9 +22,6 @@ struct disasm_line_samples {
 	struct sym_hist_entry he;
 };
 
-#define IPC_WIDTH 6
-#define CYCLES_WIDTH 6
-
 struct browser_line {
 	u32	idx;
 	int	idx_asm;
@@ -107,7 +104,7 @@ static int annotate_browser__pcnt_width(struct annotate_browser *ab)
 
 static int annotate_browser__cycles_width(struct annotate_browser *ab)
 {
-	return ab->have_cycles ? IPC_WIDTH + CYCLES_WIDTH : 0;
+	return ab->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
@@ -194,19 +191,19 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	}
 	if (ab->have_cycles) {
 		if (al->ipc)
-			ui_browser__printf(browser, "%*.2f ", IPC_WIDTH - 1, al->ipc);
+			ui_browser__printf(browser, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
 		else if (!show_title)
-			ui_browser__write_nstring(browser, " ", IPC_WIDTH);
+			ui_browser__write_nstring(browser, " ", ANNOTATION__IPC_WIDTH);
 		else
-			ui_browser__printf(browser, "%*s ", IPC_WIDTH - 1, "IPC");
+			ui_browser__printf(browser, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
 
 		if (al->cycles)
 			ui_browser__printf(browser, "%*" PRIu64 " ",
-					   CYCLES_WIDTH - 1, al->cycles);
+					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
 		else if (!show_title)
-			ui_browser__write_nstring(browser, " ", CYCLES_WIDTH);
+			ui_browser__write_nstring(browser, " ", ANNOTATION__CYCLES_WIDTH);
 		else
-			ui_browser__printf(browser, "%*s ", CYCLES_WIDTH - 1, "Cycle");
+			ui_browser__printf(browser, "%*s ", ANNOTATION__CYCLES_WIDTH - 1, "Cycle");
 	}
 
 	SLsmg_write_char(' ');
@@ -359,7 +356,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	}
 
 	if (ab->have_cycles)
-		width = IPC_WIDTH + CYCLES_WIDTH;
+		width = ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH;
 
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e924033432a3..0407234b5157 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -58,6 +58,9 @@ bool ins__is_lock(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
+#define ANNOTATION__IPC_WIDTH 6
+#define ANNOTATION__CYCLES_WIDTH 6
+
 struct annotation_options {
 	bool hide_src_code,
 	     use_offset,
