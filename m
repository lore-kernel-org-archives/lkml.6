Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDFUiT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:38:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:62521 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeDFUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:38:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31643060"
From: Andi Kleen <andi@firstfloor.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4/4] perf, tools, record: Remove suggestion to enable APIC
Date: Fri,  6 Apr 2018 13:38:12 -0700
Message-Id: <20180406203812.3087-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406203812.3087-1-andi@firstfloor.org>
References: <20180406203812.3087-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

perf record suggests to enable the APIC on errors.

APIC is practically always used today and the problem is usually somewhere else.

Just remove the outdated suggestion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66b62570c855..3e87486c28fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2870,8 +2870,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 #if defined(__i386__) || defined(__x86_64__)
 		if (evsel->attr.type == PERF_TYPE_HARDWARE)
 			return scnprintf(msg, size, "%s",
-	"No hardware sampling interrupt available.\n"
-	"No APIC? If so then you can boot the kernel with the \"lapic\" boot parameter to force-enable it.");
+	"No hardware sampling interrupt available.\n");
 #endif
 		break;
 	case EBUSY:
-- 
2.14.3
