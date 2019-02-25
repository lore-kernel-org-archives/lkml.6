Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9263BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616B42083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131539;
	bh=XuPM0VoMtljC1VrgxT7eJmHOspS2u3tviiTkVEJs48M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dNAEuoypwG+1xGIMZ7pDLkMCWeViIh+IX0G1GlXIpUHtk9tkeojIFjqX4wuCK4PDu
	 Q54EHZNogDbNN2wHEdgan2B1+e9kE7Hyje3OSPAHmLCVhROWyf4bo+lmvb2Rhox63A
	 ZMNOtzHjIGyYK3KGPP6LxbnCS31DfWn+rWcNLbow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfBYVWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730976AbfBYVWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:52 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DF221841;
        Mon, 25 Feb 2019 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129771;
        bh=XuPM0VoMtljC1VrgxT7eJmHOspS2u3tviiTkVEJs48M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcgMfHnfcl7C8c7OTPn+qQpTtNrWHEYvv8U7lO4KWgNfF28+NTRJtiUG20X9Df1TV
         NZZp9a0us4jSbjHLoy2gMoz2dnKhY/hNo2zyjZdKbxw0ZD9gRy5OS59nIo+qEgnix8
         dVL+XOk4iXbG0h9I9swKvzMoEYY4GmCGz/NM+Bfg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>, Tom Zanussi <tzanussi@gmail.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/37] perf script python: Add Python3 support to sctop.py
Date:   Mon, 25 Feb 2019 18:20:31 -0300
Message-Id: <20190225212035.24781-34-acme@kernel.org>
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

Support both Python2 and Python3 in the sctop.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-11-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/sctop.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 61621b93affb..987ffae7c8ca 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -8,7 +8,14 @@
 # will be refreshed every [interval] seconds.  The default interval is
 # 3 seconds.
 
-import os, sys, thread, time
+from __future__ import print_function
+
+import os, sys, time
+
+try:
+        import thread
+except ImportError:
+        import _thread as thread
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -62,18 +69,19 @@ def print_syscall_totals(interval):
 	while 1:
 		clear_term()
 		if for_comm is not None:
-			print "\nsyscall events for %s:\n\n" % (for_comm),
+			print("\nsyscall events for %s:\n" % (for_comm))
 		else:
-			print "\nsyscall events:\n\n",
+			print("\nsyscall events:\n")
 
-		print "%-40s  %10s\n" % ("event", "count"),
-		print "%-40s  %10s\n" % ("----------------------------------------", \
-						 "----------"),
+		print("%-40s  %10s" % ("event", "count"))
+		print("%-40s  %10s" %
+                        ("----------------------------------------",
+                        "----------"))
 
-		for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
+		for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
 					      reverse = True):
 			try:
-				print "%-40s  %10d\n" % (syscall_name(id), val),
+				print("%-40s  %10d" % (syscall_name(id), val))
 			except TypeError:
 				pass
 		syscalls.clear()
-- 
2.20.1

