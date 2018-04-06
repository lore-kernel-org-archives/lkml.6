Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeDFRGh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:06:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeDFRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:06:36 -0400
Date: Fri, 6 Apr 2018 10:06:05 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dfcpokt1pm5ixm8n9pxwtstz@git.kernel.org>
Cc: adrian.hunter@intel.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        dsahern@gmail.com, mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, jolsa@kernel.org, ak@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org, dsahern@gmail.com,
        namhyung@kernel.org, adrian.hunter@intel.com, yao.jin@linux.intel.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf ui browser: Fixup cleaning unused lines at
 the bottom
Git-Commit-ID: caf61de356189f0925b23c3922bd16b53bb7c768
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

Commit-ID:  caf61de356189f0925b23c3922bd16b53bb7c768
Gitweb:     https://git.kernel.org/tip/caf61de356189f0925b23c3922bd16b53bb7c768
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 5 Apr 2018 11:43:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 5 Apr 2018 11:51:28 -0300

perf ui browser: Fixup cleaning unused lines at the bottom

Now that we can have extra title lines we should use ui_browser->rows
and not ->height when drawing lines, as well as adding
ui_browser->extra_title_lines to browser->y when cleaning unused lines
at the bottom, otherwise we end up clobbering with spaces the last line
just shown by ui_browser->refresh() routine.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ef9ff6017e3c ("perf ui browser: Move the extra title lines from the hists browser")
Link: https://lkml.kernel.org/n/tip-dfcpokt1pm5ixm8n9pxwtstz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index d7bb2591838e..4f75561424ed 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -343,8 +343,8 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 	else
 		width += 1;
 
-	SLsmg_fill_region(browser->y + row, browser->x,
-			  browser->height - row, width, ' ');
+	SLsmg_fill_region(browser->y + row + browser->extra_title_lines, browser->x,
+			  browser->rows - row, width, ' ');
 
 	return 0;
 }
