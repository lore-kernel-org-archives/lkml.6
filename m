Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF002083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131579;
	bh=4fMlJ3mQCfnEtwwkJTAUJswjfi5kA5jAvnqABWOkPiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FEZv+sdqNxdg8VxhWj0QOfv9dLuM4MCfvZuKVrcshrLH64XCoh0fzXYIsc4jDzwoj
	 C53M23pi7jElRJ+csMv7RCZcrYaJAISpO5zKlYu2ww85lydwta1robwWJKLHP2HGwo
	 I1uwxLboDZxRjpt4DxffoAEic8ywx0HfzwzpWEfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfBYVw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbfBYVWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:37 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50D52186A;
        Mon, 25 Feb 2019 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129756;
        bh=4fMlJ3mQCfnEtwwkJTAUJswjfi5kA5jAvnqABWOkPiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aB1QvJsLYszrSWR6BVTtZUS1pzS72iNA5qyO/W+yN9bIIJj4lIz52+D2pu0j6Xf5p
         jeheFKjhz86a2hTQCJh9c8/QdWdF+/1xkUaHZL5BbU8SH/NT9oX3bE8lDMMNvbudRy
         8ORqItLN/Qg1A/EgPL9RrXAf510n7H6ii2zKKsgU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>, Tom Zanussi <tzanussi@gmail.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/37] perf script python: Add Python3 support to failed-syscalls-by-pid.py
Date:   Mon, 25 Feb 2019 18:20:27 -0300
Message-Id: <20190225212035.24781-30-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the failed-syscalls-by-pid.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-5-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/failed-syscalls-by-pid.py  | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
index cafeff3d74db..3648e8b986ec 100644
--- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
+++ b/tools/perf/scripts/python/failed-syscalls-by-pid.py
@@ -5,6 +5,8 @@
 # Displays system-wide failed system call totals, broken down by pid.
 # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -32,7 +34,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_error_totals()
@@ -57,22 +59,21 @@ def syscalls__sys_exit(event_name, context, common_cpu,
 
 def print_error_totals():
     if for_comm is not None:
-	    print "\nsyscall errors for %s:\n\n" % (for_comm),
+	    print("\nsyscall errors for %s:\n" % (for_comm))
     else:
-	    print "\nsyscall errors:\n\n",
+	    print("\nsyscall errors:\n")
 
-    print "%-30s  %10s\n" % ("comm [pid]", "count"),
-    print "%-30s  %10s\n" % ("------------------------------", \
-                                 "----------"),
+    print("%-30s  %10s" % ("comm [pid]", "count"))
+    print("%-30s  %10s" % ("------------------------------", "----------"))
 
     comm_keys = syscalls.keys()
     for comm in comm_keys:
 	    pid_keys = syscalls[comm].keys()
 	    for pid in pid_keys:
-		    print "\n%s [%d]\n" % (comm, pid),
+		    print("\n%s [%d]" % (comm, pid))
 		    id_keys = syscalls[comm][pid].keys()
 		    for id in id_keys:
-			    print "  syscall: %-16s\n" % syscall_name(id),
+			    print("  syscall: %-16s" % syscall_name(id))
 			    ret_keys = syscalls[comm][pid][id].keys()
-			    for ret, val in sorted(syscalls[comm][pid][id].iteritems(), key = lambda(k, v): (v, k),  reverse = True):
-				    print "    err = %-20s  %10d\n" % (strerror(ret), val),
+			    for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]),  reverse = True):
+				    print("    err = %-20s  %10d" % (strerror(ret), val))
-- 
2.20.1

