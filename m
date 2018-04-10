Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeDJF3A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:29:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39553 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeDJF26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:28:58 -0400
Date: Mon, 9 Apr 2018 22:28:44 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uj0n76yqh5bf98i0edckd47t@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, dsahern@gmail.com,
        wangnan0@huawei.com, jolsa@kernel.org, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
        wangnan0@huawei.com, jolsa@kernel.org, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Show extra_title_lines in the
 'D' debug hotkey
Git-Commit-ID: fdae6400809aa179f8ca04e32f3eb176fb3b3a9d
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

Commit-ID:  fdae6400809aa179f8ca04e32f3eb176fb3b3a9d
Gitweb:     https://git.kernel.org/tip/fdae6400809aa179f8ca04e32f3eb176fb3b3a9d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 6 Apr 2018 11:56:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 6 Apr 2018 12:22:06 -0300

perf hists browser: Show extra_title_lines in the 'D' debug hotkey

To help in fixing problems in the browser.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-uj0n76yqh5bf98i0edckd47t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b06afb8f51fb..de17e59d9952 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -659,9 +659,10 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			struct hist_entry *h = rb_entry(browser->b.top,
 							struct hist_entry, rb_node);
 			ui_helpline__pop();
-			ui_helpline__fpush("%d: nr_ent=(%d,%d), rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
+			ui_helpline__fpush("%d: nr_ent=(%d,%d), etl: %d, rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
 					   seq++, browser->b.nr_entries,
 					   browser->hists->nr_entries,
+					   browser->b.extra_title_lines,
 					   browser->b.rows,
 					   browser->b.index,
 					   browser->b.top_idx,
