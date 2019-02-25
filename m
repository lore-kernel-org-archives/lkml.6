Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492E02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131620;
	bh=vHMNAe1XIROEVufwhWDn0DAIbhXRFzJ27wk89wbFtEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UivK4l/5D9GCbsshEFDM4DL92rTg/YHIsJ4B8htC3OHLEEcu7+yi/amVhu6IPHRfu
	 hgf6fvLN/hjrfBIlRlDCy2lfGBFcnBfpXE+vh5Mq9BNMMBo57f7yPfCnpBPDOjTpB2
	 nILH3cvEi9ym1iTg7LFC/UekNp5cxc2fplVkrfmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfBYVvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbfBYVXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:09 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4CF21841;
        Mon, 25 Feb 2019 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129788;
        bh=vHMNAe1XIROEVufwhWDn0DAIbhXRFzJ27wk89wbFtEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6cqhu8saEHFoQA0fiQBFE5Ausd9rx3Ze/Rp920G4nptMynyTYu6Tfm3PIEqMe8tF
         gS7MxpIN/o+LKWllTHy03sG9B7xpBlSJLio9IxlXsYa6d7fhEAdWHTMJ6urT0oyRe6
         E6ilN6y31JLaEtnZuFQdQ9FSJeEjOGU4U0kBmy3E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/37] perf script python: Add Python3 support to syscall-counts-by-pid.py
Date:   Mon, 25 Feb 2019 18:20:35 -0300
Message-Id: <20190225212035.24781-38-acme@kernel.org>
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

Support both Python2 and Python3 in the syscall-counts-by-pid.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190222230619.17887-15-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/syscall-counts-by-pid.py   | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/perf/scripts/python/syscall-counts-by-pid.py
index daf314cc5dd3..42782487b0e9 100644
--- a/tools/perf/scripts/python/syscall-counts-by-pid.py
+++ b/tools/perf/scripts/python/syscall-counts-by-pid.py
@@ -5,6 +5,8 @@
 # Displays system-wide system call totals, broken down by syscall.
 # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
 
+from __future__ import print_function
+
 import os, sys
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
@@ -31,7 +33,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_syscall_totals()
@@ -55,20 +57,20 @@ def syscalls__sys_enter(event_name, context, common_cpu,
 
 def print_syscall_totals():
     if for_comm is not None:
-	    print "\nsyscall events for %s:\n\n" % (for_comm),
+	    print("\nsyscall events for %s:\n" % (for_comm))
     else:
-	    print "\nsyscall events by comm/pid:\n\n",
+	    print("\nsyscall events by comm/pid:\n")
 
-    print "%-40s  %10s\n" % ("comm [pid]/syscalls", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "----------"),
+    print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
+    print("%-40s  %10s" % ("----------------------------------------",
+                            "----------"))
 
     comm_keys = syscalls.keys()
     for comm in comm_keys:
 	    pid_keys = syscalls[comm].keys()
 	    for pid in pid_keys:
-		    print "\n%s [%d]\n" % (comm, pid),
+		    print("\n%s [%d]" % (comm, pid))
 		    id_keys = syscalls[comm][pid].keys()
-		    for id, val in sorted(syscalls[comm][pid].iteritems(), \
-				  key = lambda(k, v): (v, k),  reverse = True):
-			    print "  %-38s  %10d\n" % (syscall_name(id), val),
+		    for id, val in sorted(syscalls[comm][pid].items(), \
+				  key = lambda kv: (kv[1], kv[0]),  reverse = True):
+			    print("  %-38s  %10d" % (syscall_name(id), val))
-- 
2.20.1

