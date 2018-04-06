Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeDFUiR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:38:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:44017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeDFUiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:38:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="32212354"
From: Andi Kleen <andi@firstfloor.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/4] perf, tools, record: Remove misleading error suggestion
Date: Fri,  6 Apr 2018 13:38:11 -0700
Message-Id: <20180406203812.3087-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406203812.3087-1-andi@firstfloor.org>
References: <20180406203812.3087-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When perf record encounters an error setting up an event it suggests
to enable CONFIG_PERF_EVENTS. This is misleading because:
- Usually it is enabled (it is really hard to disable on x86)
- The problem is usually somewhere else, e.g. the CPU is not supported
or an invalid configuration has been used.

Remove the misleading suggestion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1ac8d9236efd..66b62570c855 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2894,8 +2894,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"/bin/dmesg may provide additional information.\n"
-	"No CONFIG_PERF_EVENTS=y kernel support configured?",
+	"/bin/dmesg | grep -i perf may provide additional information.\n",
 			 err, str_error_r(err, sbuf, sizeof(sbuf)),
 			 perf_evsel__name(evsel));
 }
-- 
2.14.3
