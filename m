Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C75C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CF324A79
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CF324A79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934658AbeFWBV5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934461AbeFWBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:21:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78CBC24A79;
        Sat, 23 Jun 2018 01:21:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fWXEf-0008Rm-HE; Fri, 22 Jun 2018 21:21:05 -0400
Message-Id: <20180623012105.432739445@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Jun 2018 21:20:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4/5] tracing: Fix some errors in histogram documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-tracing-Fix-some-errors-in-histogram-documentation.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Fix typos, inconsistencies in using quotes, incorrect section number,
etc. in the trace histogram documentation.

Link: http://lkml.kernel.org/r/20180614224859.55864-1-joel@joelfernandes.org

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.txt | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index e73bcf9cb5f3..7ffea6aa22e3 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1729,35 +1729,35 @@ If a variable isn't a key variable or prefixed with 'vals=', the
 associated event field will be saved in a variable but won't be summed
 as a value:
 
-  # echo 'hist:keys=next_pid:ts1=common_timestamp ... >> event/trigger
+  # echo 'hist:keys=next_pid:ts1=common_timestamp ...' >> event/trigger
 
 Multiple variables can be assigned at the same time.  The below would
 result in both ts0 and b being created as variables, with both
 common_timestamp and field1 additionally being summed as values:
 
-  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ... >> \
+  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ...' >> \
 	event/trigger
 
 Note that variable assignments can appear either preceding or
 following their use.  The command below behaves identically to the
 command above:
 
-  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ... >> \
+  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ...' >> \
 	event/trigger
 
 Any number of variables not bound to a 'vals=' prefix can also be
 assigned by simply separating them with colons.  Below is the same
 thing but without the values being summed in the histogram:
 
-  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ... >> event/trigger
+  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ...' >> event/trigger
 
 Variables set as above can be referenced and used in expressions on
 another event.
 
 For example, here's how a latency can be calculated:
 
-  # echo 'hist:keys=pid,prio:ts0=common_timestamp ... >> event1/trigger
-  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ... >> event2/trigger
+  # echo 'hist:keys=pid,prio:ts0=common_timestamp ...' >> event1/trigger
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...' >> event2/trigger
 
 In the first line above, the event's timetamp is saved into the
 variable ts0.  In the next line, ts0 is subtracted from the second
@@ -1766,7 +1766,7 @@ yet another variable, 'wakeup_lat'.  The hist trigger below in turn
 makes use of the wakeup_lat variable to compute a combined latency
 using the same key and variable from yet another event:
 
-  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ... >> event3/trigger
+  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
 2.2.2 Synthetic Events
 ----------------------
@@ -1807,10 +1807,11 @@ the command that defined it with a '!':
 At this point, there isn't yet an actual 'wakeup_latency' event
 instantiated in the event subsytem - for this to happen, a 'hist
 trigger action' needs to be instantiated and bound to actual fields
-and variables defined on other events (see Section 6.3.3 below).
+and variables defined on other events (see Section 2.2.3 below on
+how that is done using hist trigger 'onmatch' action). Once that is
+done, the 'wakeup_latency' synthetic event instance is created.
 
-Once that is done, an event instance is created, and a histogram can
-be defined using it:
+A histogram can now be defined for the new synthetic event:
 
   # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
         /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
@@ -1960,7 +1961,7 @@ hist trigger specification.
     back to that pid, the timestamp difference is calculated.  If the
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, the values specified in the save() fields are
-    recoreded:
+    recorded:
 
     # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
             if comm=="cyclictest"' >> \
-- 
2.17.1


