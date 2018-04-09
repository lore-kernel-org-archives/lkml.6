Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbeDITfP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753923AbeDITfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:35:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62567217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/13] perf hists browser: Show extra_title_lines in the 'D' debug hotkey
Date: Mon,  9 Apr 2018 16:34:32 -0300
Message-Id: <20180409193437.14199-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
