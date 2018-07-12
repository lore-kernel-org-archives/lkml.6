Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AEAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64231208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64231208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeGLOL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:11:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbeGLOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:11:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CDxtxi3934399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 06:59:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CDxthh3934396;
        Thu, 12 Jul 2018 06:59:55 -0700
Date:   Thu, 12 Jul 2018 06:59:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jeremy Cline <tipbot@zytor.com>
Message-ID: <tip-8c1c1ab2d2a77cb50841822168e56d11c4ebfd6e@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, tglx@linutronix.de, jeremy@jcline.org,
        herton@redhat.com, jolsa@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org
Reply-To: peterz@infradead.org, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jeremy@jcline.org, herton@redhat.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          namhyung@kernel.org, mingo@kernel.org
In-Reply-To: <0100016341a737a5-44ec436f-3440-4cac-a03f-ddfa589bf308-000000@email.amazonses.com>
References: <0100016341a737a5-44ec436f-3440-4cac-a03f-ddfa589bf308-000000@email.amazonses.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: Add Python 3 support to
 sched-migration.py
Git-Commit-ID: 8c1c1ab2d2a77cb50841822168e56d11c4ebfd6e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8c1c1ab2d2a77cb50841822168e56d11c4ebfd6e
Gitweb:     https://git.kernel.org/tip/8c1c1ab2d2a77cb50841822168e56d11c4ebfd6e
Author:     Jeremy Cline <jeremy@jcline.org>
AuthorDate: Tue, 8 May 2018 21:27:47 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:50 -0300

perf scripts python: Add Python 3 support to sched-migration.py

Support both Python 2 and Python 3 in the sched-migration.py script.
This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a737a5-44ec436f-3440-4cac-a03f-ddfa589bf308-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/sched-migration.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index de66cb3b72c9..3473e7f66081 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -9,13 +9,17 @@
 # This software is distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
-
+from __future__ import print_function
 
 import os
 import sys
 
 from collections import defaultdict
-from UserList import UserList
+try:
+    from UserList import UserList
+except ImportError:
+    # Python 3: UserList moved to the collections package
+    from collections import UserList
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -300,7 +304,7 @@ class TimeSliceList(UserList):
 		if i == -1:
 			return
 
-		for i in xrange(i, len(self.data)):
+		for i in range(i, len(self.data)):
 			timeslice = self.data[i]
 			if timeslice.start > end:
 				return
@@ -336,8 +340,8 @@ class SchedEventProxy:
 		on_cpu_task = self.current_tsk[headers.cpu]
 
 		if on_cpu_task != -1 and on_cpu_task != prev_pid:
-			print "Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
-				(headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
+			print("Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
+				headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
 
 		threads[prev_pid] = prev_comm
 		threads[next_pid] = next_comm
