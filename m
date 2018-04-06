Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDFRHL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:07:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53693 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeDFRHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:07:08 -0400
Date: Fri, 6 Apr 2018 10:06:36 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-oev1469y02hmfere6r2kkxp6@git.kernel.org>
Cc: kan.liang@intel.com, wangnan0@huawei.com, adrian.hunter@intel.com,
        tglx@linutronix.de, dsahern@gmail.com, acme@redhat.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, namhyung@kernel.org
Reply-To: dsahern@gmail.com, wangnan0@huawei.com, adrian.hunter@intel.com,
        tglx@linutronix.de, kan.liang@intel.com, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Remove duplicated 'samples' in lost
 samples warning
Git-Commit-ID: 41a43dacecdbc9aec9d307bd9f6aa5ec16d65832
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

Commit-ID:  41a43dacecdbc9aec9d307bd9f6aa5ec16d65832
Gitweb:     https://git.kernel.org/tip/41a43dacecdbc9aec9d307bd9f6aa5ec16d65832
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 5 Apr 2018 14:34:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 5 Apr 2018 14:34:09 -0300

perf report: Remove duplicated 'samples' in lost samples warning

The following message, emitted when samples are lost due to system
overload, had one 'samples' too many, ditch it:

   Processed 25333 samples and lost 20.88% samples!

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: https://lkml.kernel.org/n/tip-oev1469y02hmfere6r2kkxp6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c71ced7db152..f4a7a437ee87 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1591,7 +1591,7 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
 		drop_rate = (double)stats->total_lost_samples /
 			    (double) (stats->nr_events[PERF_RECORD_SAMPLE] + stats->total_lost_samples);
 		if (drop_rate > 0.05) {
-			ui__warning("Processed %" PRIu64 " samples and lost %3.2f%% samples!\n\n",
+			ui__warning("Processed %" PRIu64 " samples and lost %3.2f%%!\n\n",
 				    stats->nr_events[PERF_RECORD_SAMPLE] + stats->total_lost_samples,
 				    drop_rate * 100.0);
 		}
