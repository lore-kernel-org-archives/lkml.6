Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeEHV3J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:29:09 -0400
Received: from a8-57.smtp-out.amazonses.com ([54.240.8.57]:37892 "EHLO
        a8-57.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756024AbeEHV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:47 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 4/8] perf scripts python: Add Python 3 support to Util.py
Date: Tue, 8 May 2018 21:27:46 +0000
Message-ID: <0100016341a730c6-8db8b9b1-da2d-4ee3-96bf-47e0ae9796bd-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.57
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in Util.py. The dict class no longer
has a ``has_key`` method and print is now a function rather than a
statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py     | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
index f6c84966e4f8..7384dcb628c4 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
@@ -5,6 +5,7 @@
 # This software may be distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
+from __future__ import print_function
 
 import errno, os
 
@@ -33,7 +34,7 @@ def nsecs_str(nsecs):
     return str
 
 def add_stats(dict, key, value):
-	if not dict.has_key(key):
+	if key not in dict:
 		dict[key] = (value, value, value, 1)
 	else:
 		min, max, avg, count = dict[key]
@@ -72,10 +73,10 @@ try:
 except:
 	if not audit_package_warned:
 		audit_package_warned = True
-		print "Install the audit-libs-python package to get syscall names.\n" \
-                    "For example:\n  # apt-get install python-audit (Ubuntu)" \
-                    "\n  # yum install audit-libs-python (Fedora)" \
-                    "\n  etc.\n"
+		print("Install the audit-libs-python package to get syscall names.\n"
+                    "For example:\n  # apt-get install python-audit (Ubuntu)"
+                    "\n  # yum install audit-libs-python (Fedora)"
+                    "\n  etc.\n")
 
 def syscall_name(id):
 	try:
-- 
2.17.0
