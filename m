Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeDFLZN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbeDFLZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:25:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB2B21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH 5/6] perf report: Remove duplicated 'samples' in lost samples warning
Date: Fri,  6 Apr 2018 08:24:38 -0300
Message-Id: <20180406112439.21685-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406112439.21685-1-acme@kernel.org>
References: <20180406112439.21685-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
