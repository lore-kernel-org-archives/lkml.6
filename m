Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDFRGp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:06:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51071 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeDFRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:06:43 -0400
Date: Fri, 6 Apr 2018 10:05:32 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-08y1ln3xjn76zvizz1i1dsvn@git.kernel.org>
Cc: yao.jin@linux.intel.com, tglx@linutronix.de, wangnan0@huawei.com,
        mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, dsahern@gmail.com
Reply-To: dsahern@gmail.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        acme@redhat.com, namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        adrian.hunter@intel.com, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate browser: Fixup vertical line
 separating metrics from instructions
Git-Commit-ID: e726c8511c052ba40dc943517b54011e42c2dfa3
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

Commit-ID:  e726c8511c052ba40dc943517b54011e42c2dfa3
Gitweb:     https://git.kernel.org/tip/e726c8511c052ba40dc943517b54011e42c2dfa3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 5 Apr 2018 11:35:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 5 Apr 2018 11:50:44 -0300

perf annotate browser: Fixup vertical line separating metrics from instructions

Now that we can have extra title lines we should use ui_browser->rows
and not ->height when drawing lines, as it will use ui_browser__gotorc()
and that will take the extra title lines into account, which was causing
an off by one at the end of the vertical line drawn by
__ui_browser__vline(), fix it.

The visual effect was that the last line, with status messages, was
being overwritten by the vertical line, looking like:

Press 'h' for help on│key bindings

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ef9ff6017e3c ("perf ui browser: Move the extra title lines from the hists browser")
Link: https://lkml.kernel.org/n/tip-08y1ln3xjn76zvizz1i1dsvn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 78bcd220f1b6..12c099a87f8b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -218,7 +218,7 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 		annotate_browser__draw_current_jump(browser);
 
 	ui_browser__set_color(browser, HE_COLORSET_NORMAL);
-	__ui_browser__vline(browser, pcnt_width, 0, browser->height - 1);
+	__ui_browser__vline(browser, pcnt_width, 0, browser->rows - 1);
 	return ret;
 }
 
