Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbeCGOEK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:04:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:30695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933670AbeCGODa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:03:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="36206854"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] perf intel-pt: Remove a check for sampling mode
Date: Wed,  7 Mar 2018 16:02:28 +0200
Message-Id: <1520431349-30689-9-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
References: <1520431349-30689-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT code already has some preparation for AUX area sampling mode.
However the implementation has changed from the first proposal and one
of the side-effects is that it will not be impossible to support snapshot
mode and sampling mode at the same time. Although there are no plans to
support it, let validation (not yet implemented) control whether it is
allowed rather than low-level functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9a4f9cdb752f..5c5c155fba78 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2061,9 +2061,6 @@ static int intel_pt_process_auxtrace_event(struct perf_session *session,
 	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
 					   auxtrace);
 
-	if (pt->sampling_mode)
-		return 0;
-
 	if (!pt->data_queued) {
 		struct auxtrace_buffer *buffer;
 		off_t data_offset;
-- 
1.9.1
