Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B866721479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B866721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeGLOJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:09:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeGLOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:09:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CDwMHb3934290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 06:58:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CDwLoE3934287;
        Thu, 12 Jul 2018 06:58:21 -0700
Date:   Thu, 12 Jul 2018 06:58:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jeremy Cline <tipbot@zytor.com>
Message-ID: <tip-770d2f86c0051d4f2c0ab9d74d68434cb383241d@git.kernel.org>
Cc:     acme@redhat.com, jeremy@jcline.org, hpa@zytor.com,
        herton@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        mingo@kernel.org
Reply-To: herton@redhat.com, jeremy@jcline.org, hpa@zytor.com,
          acme@redhat.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          peterz@infradead.org, jolsa@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <0100016341a72ebe-e572899e-f445-4765-98f0-c314935727f9-000000@email.amazonses.com>
References: <0100016341a72ebe-e572899e-f445-4765-98f0-c314935727f9-000000@email.amazonses.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: Add Python 3 support to
 Core.py
Git-Commit-ID: 770d2f86c0051d4f2c0ab9d74d68434cb383241d
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

Commit-ID:  770d2f86c0051d4f2c0ab9d74d68434cb383241d
Gitweb:     https://git.kernel.org/tip/770d2f86c0051d4f2c0ab9d74d68434cb383241d
Author:     Jeremy Cline <jeremy@jcline.org>
AuthorDate: Tue, 8 May 2018 21:27:45 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:50 -0300

perf scripts python: Add Python 3 support to Core.py

Support both Python 2 and Python 3 in Core.py. This should have no
functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a72ebe-e572899e-f445-4765-98f0-c314935727f9-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  | 40 +++++++++-------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
index 38dfb720fb6f..54ace2f6bc36 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
@@ -31,10 +31,8 @@ def flag_str(event_name, field_name, value):
     string = ""
 
     if flag_fields[event_name][field_name]:
-	print_delim = 0
-        keys = flag_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        print_delim = 0
+        for idx in sorted(flag_fields[event_name][field_name]['values']):
             if not value and not idx:
                 string += flag_fields[event_name][field_name]['values'][idx]
                 break
@@ -51,14 +49,12 @@ def symbol_str(event_name, field_name, value):
     string = ""
 
     if symbolic_fields[event_name][field_name]:
-        keys = symbolic_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        for idx in sorted(symbolic_fields[event_name][field_name]['values']):
             if not value and not idx:
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
-	    if (value == idx):
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+            if (value == idx):
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
 
     return string
@@ -74,19 +70,17 @@ def trace_flag_str(value):
     string = ""
     print_delim = 0
 
-    keys = trace_flags.keys()
-
-    for idx in keys:
-	if not value and not idx:
-	    string += "NONE"
-	    break
-
-	if idx and (value & idx) == idx:
-	    if print_delim:
-		string += " | ";
-	    string += trace_flags[idx]
-	    print_delim = 1
-	    value &= ~idx
+    for idx in trace_flags:
+        if not value and not idx:
+            string += "NONE"
+            break
+
+        if idx and (value & idx) == idx:
+            if print_delim:
+                string += " | ";
+            string += trace_flags[idx]
+            print_delim = 1
+            value &= ~idx
 
     return string
 
