Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeEHV2h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:28:37 -0400
Received: from a8-57.smtp-out.amazonses.com ([54.240.8.57]:37892 "EHLO
        a8-57.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756050AbeEHV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:52 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 7/8] perf scripts python: Add Python 3 support to stat-cpi.py
Date: Tue, 8 May 2018 21:27:51 +0000
Message-ID: <0100016341a74569-b9ac2ac6-f99b-41ed-be0d-f7cb3c69e6de-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.57
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in stat-cpi.py. This should have no
functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 tools/perf/scripts/python/stat-cpi.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
index 8410672efb8b..fc53a03da412 100644
--- a/tools/perf/scripts/python/stat-cpi.py
+++ b/tools/perf/scripts/python/stat-cpi.py
@@ -1,6 +1,8 @@
 #!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 data    = {}
 times   = []
 threads = []
@@ -59,7 +61,8 @@ def stat__interval(time):
             if ins != 0:
                 cpi = cyc/float(ins)
 
-            print "%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins)
+            print("%15f: cpu %d, thread %d -> cpi %f (%d/%d)" %
+                  (time/(float(1000000000)), cpu, thread, cpi, cyc, ins))
 
 def trace_end():
     pass
-- 
2.17.0
