Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756076AbeEHV1x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:27:53 -0400
Received: from a8-53.smtp-out.amazonses.com ([54.240.8.53]:41244 "EHLO
        a8-53.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756047AbeEHV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:27:49 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 5/8] perf scripts python: Add Python 3 support to EventClass.py
Date: Tue, 8 May 2018 21:27:48 +0000
Message-ID: <0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
References: <cover.1525811971.git.jeremy@jcline.org>
X-SES-Outgoing: 2018.05.08-54.240.8.53
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in EventClass.py. ``print`` is now a
function rather than a statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
index 81a56cd2b3c1..21a7a1298094 100755
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
@@ -8,6 +8,7 @@
 # PerfEvent is the base class for all perf event sample, PebsEvent
 # is a HW base Intel x86 PEBS event, and user could add more SW/HW
 # event classes based on requirements.
+from __future__ import print_function
 
 import struct
 
@@ -44,7 +45,8 @@ class PerfEvent(object):
                 PerfEvent.event_num += 1
 
         def show(self):
-                print "PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" % (self.name, self.symbol, self.comm, self.dso)
+                print("PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" %
+                      (self.name, self.symbol, self.comm, self.dso))
 
 #
 # Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
-- 
2.17.0
