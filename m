Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeCETMg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:12:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:47640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbeCETMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109089"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/7] perf mmap: Using stored 'overwrite' in perf_mmap__consume
Date: Mon,  5 Mar 2018 14:10:56 -0500
Message-Id: <1520277059-32749-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The 'overwrite' is set at initialization. It will not be changed.
Using it to replace the parameter of perf_mmap__consume().
The parameters will be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index da9e68b..c4e41d2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -121,9 +121,9 @@ void perf_mmap__put(struct perf_mmap *map)
 		perf_mmap__munmap(map);
 }
 
-void perf_mmap__consume(struct perf_mmap *map, bool overwrite)
+void perf_mmap__consume(struct perf_mmap *map, bool overwrite __maybe_unused)
 {
-	if (!overwrite) {
+	if (!map->overwrite) {
 		u64 old = map->prev;
 
 		perf_mmap__write_tail(map, old);
-- 
2.4.11
