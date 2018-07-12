Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44E321471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44E321471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeGLOMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:12:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeGLOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:12:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE0Qgh3934633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:00:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE0P0I3934630;
        Thu, 12 Jul 2018 07:00:25 -0700
Date:   Thu, 12 Jul 2018 07:00:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jeremy Cline <tipbot@zytor.com>
Message-ID: <tip-12aa6c7389a321b4b5d921f89c3f83b9750598f7@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jeremy@jcline.org, tglx@linutronix.de,
        hpa@zytor.com, herton@redhat.com, mingo@kernel.org,
        peterz@infradead.org, jolsa@redhat.com, acme@redhat.com
Reply-To: mingo@kernel.org, peterz@infradead.org, jolsa@redhat.com,
          acme@redhat.com, herton@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, jeremy@jcline.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org
In-Reply-To: <0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com>
References: <0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: Add Python 3 support to
 EventClass.py
Git-Commit-ID: 12aa6c7389a321b4b5d921f89c3f83b9750598f7
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

Commit-ID:  12aa6c7389a321b4b5d921f89c3f83b9750598f7
Gitweb:     https://git.kernel.org/tip/12aa6c7389a321b4b5d921f89c3f83b9750598f7
Author:     Jeremy Cline <jeremy@jcline.org>
AuthorDate: Tue, 8 May 2018 21:27:48 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:50 -0300

perf scripts python: Add Python 3 support to EventClass.py

Support both Python 2 and Python 3 in EventClass.py. ``print`` is now a
function rather than a statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py  | 4 +++-
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
