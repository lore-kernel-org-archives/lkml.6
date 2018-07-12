Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C01AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7875208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7875208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbeGLOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:11:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeGLOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:11:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CDxO6v3934351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 06:59:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CDxOSM3934348;
        Thu, 12 Jul 2018 06:59:24 -0700
Date:   Thu, 12 Jul 2018 06:59:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jeremy Cline <tipbot@zytor.com>
Message-ID: <tip-c45b168effb12719f6dfc8d2c20ba8c057e8c16b@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        herton@redhat.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        namhyung@kernel.org
Reply-To: acme@redhat.com, herton@redhat.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, jeremy@jcline.org,
          namhyung@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <0100016341a730c6-8db8b9b1-da2d-4ee3-96bf-47e0ae9796bd-000000@email.amazonses.com>
References: <0100016341a730c6-8db8b9b1-da2d-4ee3-96bf-47e0ae9796bd-000000@email.amazonses.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: Add Python 3 support to
 Util.py
Git-Commit-ID: c45b168effb12719f6dfc8d2c20ba8c057e8c16b
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

Commit-ID:  c45b168effb12719f6dfc8d2c20ba8c057e8c16b
Gitweb:     https://git.kernel.org/tip/c45b168effb12719f6dfc8d2c20ba8c057e8c16b
Author:     Jeremy Cline <jeremy@jcline.org>
AuthorDate: Tue, 8 May 2018 21:27:46 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:50 -0300

perf scripts python: Add Python 3 support to Util.py

Support both Python 2 and Python 3 in Util.py. The dict class no longer
has a ``has_key`` method and print is now a function rather than a
statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a730c6-8db8b9b1-da2d-4ee3-96bf-47e0ae9796bd-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py     | 11 ++++++-----
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
