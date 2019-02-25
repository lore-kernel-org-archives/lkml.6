Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2C12083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131523;
	bh=alwkXTBX+YJXtadkw7p7bOf76FHbUyupujnKkMJ8dUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mXLLi/s3oU/2iQo3ZiccezM2xUV9msdSaDJmqDAcLxovimz/ztoH25JIf9YWJrRmB
	 WWo1yulMR2lGyam8MyG1wC6mejAAOlk/PFgg1mCBL5cn+ev/kMjSUlE0onnThTY65t
	 qhkpitLjexGhh0417VHR7P1PGIaOnq3ptGR27Atg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfBYVwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbfBYVXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:00 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B0621841;
        Mon, 25 Feb 2019 21:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129780;
        bh=alwkXTBX+YJXtadkw7p7bOf76FHbUyupujnKkMJ8dUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vm3PI5r7nHB3I8s+vw0nYfkaXQB/X/+8WyQDgqgqwXkpkt3JLQOcdTxEBKE6SLMCR
         uJjUikoZlyZ+R7sULbWgwk8M03Opj2Q/NJuOruOGoQOzaeSBlIECybZGp5rbmFIfvd
         OSVkprSpCGZetxjxWfncPpX0mzBVRu/Ka1GO9hWQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/37] perf script python: Add Python3 support to stat-cpi.py
Date:   Mon, 25 Feb 2019 18:20:33 -0300
Message-Id: <20190225212035.24781-36-acme@kernel.org>
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

Support both Python2 and Python3 in the stat-cpi.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190222230619.17887-13-tonyj@suse.de
Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/stat-cpi.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
index a81ad8835a74..01fa933ff3cf 100644
--- a/tools/perf/scripts/python/stat-cpi.py
+++ b/tools/perf/scripts/python/stat-cpi.py
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 data    = {}
 times   = []
 threads = []
@@ -19,8 +21,8 @@ def store_key(time, cpu, thread):
         threads.append(thread)
 
 def store(time, event, cpu, thread, val, ena, run):
-    #print "event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" % \
-    #      (event, cpu, thread, time, val, ena, run)
+    #print("event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" %
+    #      (event, cpu, thread, time, val, ena, run))
 
     store_key(time, cpu, thread)
     key = get_key(time, event, cpu, thread)
@@ -58,7 +60,7 @@ def stat__interval(time):
             if ins != 0:
                 cpi = cyc/float(ins)
 
-            print "%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins)
+            print("%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins))
 
 def trace_end():
     pass
@@ -74,4 +76,4 @@ def trace_end():
 #                if ins != 0:
 #                    cpi = cyc/float(ins)
 #
-#                print "time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi)
+#                print("time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi))
-- 
2.20.1

