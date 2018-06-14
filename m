Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D299C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E34120896
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TF9EzHdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E34120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965062AbeFNWtk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:49:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46881 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965005AbeFNWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:49:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id d2-v6so3553779pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RV11S1gqLOi262GbqLORk/JXtwyoyv+Tb4IVDmxwxQE=;
        b=TF9EzHdSKSCcUyeoq/MISgFiAg3QJv4hh1fc4vlewNuskwUnDzLACL4tuq3dGIbcH3
         WjfrgKpjd0P7QGW+3ggLzUd0FxI16Vocu/RnU0e0bxv1MQG0fpTLM3vgf/4nhN7xs484
         5N1nIviMGhCzsk7ptLJv4n/RXykhaTTK7tv7b3UmXXQnzuFF3CyQbksSNz6JJFqpI9jL
         idv7erXiqD3kR3iCpU3FncZoZ8ytA5h89FyTY7U5EJ8vvpwy3AT0fYHtQFsiVxGRW96L
         nvHGbRYu+06RkNaQfaOXuvNeBn1Zd/ul0XjRqjvfDghEq1/+SjfHK5meQ4Kw3d4n82Ln
         qugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RV11S1gqLOi262GbqLORk/JXtwyoyv+Tb4IVDmxwxQE=;
        b=KjlYzO6Ssuo2hTqCIQvuHcMFASOuoSJMFAESgxONTPO6PnKbvBKnKIob21szk/Cgqp
         jeMM7gyoFYk9QdKI1zpmP0ZZo4P8O9F6JensL0wCXg1ngdoZ/g8y3BYCpx6AooPSr4rx
         r5N0mxL1mYLx02B2p3Agits0Ggey2oCfYoOlVxg6V9N7sj/hjL14EzzmY21Y+5zx2lAQ
         /yYJ9WV3zcCLoP/bkp20KQh0HEYkxORWCBqXcgvU6eb2gqUK/Qh2CvzS73rW0K1vamyA
         IayUECT6l6azjHAhv9h5t2zjZGTSCmZHn6mQ0mrl9ECtRvLV8SgOvWe7f3wyR6mNH8mo
         GqMg==
X-Gm-Message-State: APt69E1+o2aiKlu1xU9yE170wvXStPrjrNViiH3ABnk3MNE/pTfhSuzY
        xu6gWPBRyuvjv49prN+jn82OnlB3l4g=
X-Google-Smtp-Source: ADUXVKKo7XP94GS4MpfII7ALLNgE+RK0vruXoq9nwmKqGo8e9YQ7GTDAApk3qswR8Ph8KsJ7Hymr+w==
X-Received: by 2002:a63:7d4c:: with SMTP id m12-v6mr3854598pgn.201.1529016576642;
        Thu, 14 Jun 2018 15:49:36 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x2-v6sm11063290pgq.33.2018.06.14.15.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 15:49:35 -0700 (PDT)
From:   Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        bigeasy@linutronix.de, mhiramat@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-rt-users@vger.kernel.org
Subject: [PATCH] tracing: Fix some errors in histogram documentation
Date:   Thu, 14 Jun 2018 15:48:59 -0700
Message-Id: <20180614224859.55864-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Fix typos, inconsistencies in using quotes, incorrect section number,
etc. in the trace histogram documentation.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/trace/histogram.txt | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index 6e05510afc28..da955cd696f6 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1730,35 +1730,35 @@ If a variable isn't a key variable or prefixed with 'vals=', the
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
@@ -1767,7 +1767,7 @@ yet another variable, 'wakeup_lat'.  The hist trigger below in turn
 makes use of the wakeup_lat variable to compute a combined latency
 using the same key and variable from yet another event:
 
-  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ... >> event3/trigger
+  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
 2.2.2 Synthetic Events
 ----------------------
@@ -1808,10 +1808,11 @@ the command that defined it with a '!':
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
@@ -1961,7 +1962,7 @@ hist trigger specification.
     back to that pid, the timestamp difference is calculated.  If the
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, the values specified in the save() fields are
-    recoreded:
+    recorded:
 
     # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
             if comm=="cyclictest"' >> \
-- 
2.18.0.rc1.242.g61856ae69a-goog

