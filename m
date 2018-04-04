Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeDDFdb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:33:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDDFda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:33:30 -0400
Date: Tue, 3 Apr 2018 22:33:16 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sntpyzxsnme9jvuz2qntwoh2@git.kernel.org>
Cc: mingo@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        namhyung@kernel.org, adrian.hunter@intel.com, mliska@suse.cz,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: mliska@suse.cz, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com,
        acme@redhat.com, mingo@kernel.org, dsahern@gmail.com, hpa@zytor.com,
        jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Rename
 perf_evsel_browser_title to a more descriptive name
Git-Commit-ID: f016d24acd95660ca264e0424c8037391d165553
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

Commit-ID:  f016d24acd95660ca264e0424c8037391d165553
Gitweb:     https://git.kernel.org/tip/f016d24acd95660ca264e0424c8037391d165553
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 2 Apr 2018 14:00:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 3 Apr 2018 10:22:42 -0300

perf hists browser: Rename perf_evsel_browser_title to a more descriptive name

Rename it to hists_browser__scnprintf_title() to better reflect that it
provides a scnprintf-like function operating on a hists_browser
instance.

This paves the way to have a non-hists_browser specific function to
scnprintf format a title with per evsel information to use in other
tools or UIs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-sntpyzxsnme9jvuz2qntwoh2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8b4e82548f8e..2ac66011354f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -32,8 +32,7 @@
 
 extern void hist_browser__init_hpp(void);
 
-static int perf_evsel_browser_title(struct hist_browser *browser,
-				    char *bf, size_t size);
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size);
 static void hist_browser__update_nr_entries(struct hist_browser *hb);
 
 static struct rb_node *hists__filter_entries(struct rb_node *nd,
@@ -2183,7 +2182,7 @@ perf_evsel_browser__new(struct perf_evsel *evsel,
 	if (browser) {
 		browser->hbt   = hbt;
 		browser->env   = env;
-		browser->title = perf_evsel_browser_title;
+		browser->title = hists_browser__scnprintf_title;
 	}
 	return browser;
 }
@@ -2209,8 +2208,7 @@ static inline bool is_report_browser(void *timer)
 	return timer == NULL;
 }
 
-static int perf_evsel_browser_title(struct hist_browser *browser,
-				char *bf, size_t size)
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size)
 {
 	struct hist_browser_timer *hbt = browser->hbt;
 	struct hists *hists = browser->hists;
