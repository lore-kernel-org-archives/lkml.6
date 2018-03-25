Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCYWJG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:09:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeCYWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:09:04 -0400
Date: Sun, 25 Mar 2018 15:08:52 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-pnwn1dg9345zawhgiorpsadf@git.kernel.org>
Cc: hpa@zytor.com, wangnan0@huawei.com, dsahern@gmail.com,
        yao.jin@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Reply-To: ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        yao.jin@linux.intel.com, dsahern@gmail.com, wangnan0@huawei.com,
        hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate tui: Use
 annotate_browser__cycles_width() mroe
Git-Commit-ID: 00ea0eb21e9ba38636608e3eb0ac332fc022d5bb
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

Commit-ID:  00ea0eb21e9ba38636608e3eb0ac332fc022d5bb
Gitweb:     https://git.kernel.org/tip/00ea0eb21e9ba38636608e3eb0ac332fc022d5bb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 10:28:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:27 -0300

perf annotate tui: Use annotate_browser__cycles_width() mroe

Instead of an open coded equivalent, will reduce a bit noise in
the following patches.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-pnwn1dg9345zawhgiorpsadf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ca3d99c1e4d9..0f84a52b4088 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -308,7 +308,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
 	u8 pcnt_width = annotate_browser__pcnt_width(ab);
-	int width = 0;
+	int width;
 
 	/* PLT symbols contain external offsets */
 	if (strstr(sym->name, "@plt"))
@@ -355,8 +355,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 		to = (u64)btarget->idx;
 	}
 
-	if (ab->have_cycles)
-		width = ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH;
+	width = annotate_browser__cycles_width(ab);
 
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser,
