Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6105121850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129789;
	bh=PWzg+R3dKYQwG4yI4ggRzN1x9VmzA2CTFEMuQrG6i5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S9w8ovcYAIorG2+0YR20MHk7OOZaN6Yt7/3jk2BfOa7DJInIxDFaRh8bKvNfxJ0Mr
	 OEK2dmqCxfZ9qZz3MhOistz7ZU3X0xrkCvrSkIij9sxvw9AMy859tKTq9/d4k4AAMf
	 yO6IOakRxA3rpF/mV1kk7/eUsa+j39Sz23YJ7WGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfBYVXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731023AbfBYVXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:05 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE35521850;
        Mon, 25 Feb 2019 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129784;
        bh=PWzg+R3dKYQwG4yI4ggRzN1x9VmzA2CTFEMuQrG6i5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGUag0QrentcRkfLwgqdOXvzSDJMDLHeSyezUG1rAR5o3dbje1yzmRu6GZ6WaLRU3
         uhJiSXtrJ3Yo1IAeNa48D4ngsFAt2L5cHf9TjjVe1VbKEJYxiKswrUQvqfKwlfUQZ3
         aXanetkdsyQl3uKJaQrjtXX59jurJ1pQP6t7rAxA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 36/37] perf script python: Add Python3 support to syscall-counts.py
Date:   Mon, 25 Feb 2019 18:20:34 -0300
Message-Id: <20190225212035.24781-37-acme@kernel.org>
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

Support both Python2 and Python3 in the syscall-counts.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190222230619.17887-14-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/syscall-counts.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/syscall-counts.py b/tools/perf/scripts/python/syscall-counts.py
index e66a7730aeb5..0ebd89cfd42c 100644
--- a/tools/perf/scripts/python/syscall-counts.py
+++ b/tools/perf/scripts/python/syscall-counts.py
@@ -5,6 +5,8 @@
 # Displays system-wide system call totals, broken down by syscall.
 # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -28,7 +30,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_syscall_totals()
@@ -51,14 +53,14 @@ def syscalls__sys_enter(event_name, context, common_cpu,
 
 def print_syscall_totals():
     if for_comm is not None:
-	    print "\nsyscall events for %s:\n\n" % (for_comm),
+	    print("\nsyscall events for %s:\n" % (for_comm))
     else:
-	    print "\nsyscall events:\n\n",
+	    print("\nsyscall events:\n")
 
-    print "%-40s  %10s\n" % ("event", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "-----------"),
+    print("%-40s  %10s" % ("event", "count"))
+    print("%-40s  %10s" % ("----------------------------------------",
+                              "-----------"))
 
-    for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
+    for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
 				  reverse = True):
-	    print "%-40s  %10d\n" % (syscall_name(id), val),
+	    print("%-40s  %10d" % (syscall_name(id), val))
-- 
2.20.1

