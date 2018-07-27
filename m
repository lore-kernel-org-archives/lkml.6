Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D3208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1yKzryy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeG0Ngn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbeG0Ngn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:36:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE10208AD;
        Fri, 27 Jul 2018 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693703;
        bh=rmdQT+Lk7UKciEZogA/axNlSdMXAAjebf0Ht9CndDTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1yKzryy+DlZMawEfE+l+cWpixPD9B7n0pS34rYYVmi6N2td+9fveFm4osWKwit1m
         T2MHNpjNOCrR/c/xb6nYDKSjqXlkaPt+MCK9wRU+qhBW9SKZBjoe5o2JIZl5CZzCyv
         U9XEWaf/ciN/TDpia+chMbq9zLe+2/0O5dZ42bhc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] selftests/ftrace: Use loopback address instead of localhost
Date:   Fri, 27 Jul 2018 21:14:40 +0900
Message-Id: <153269368036.3084.11089045823444073169.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153269339575.3084.16279591141931053689.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use raw loopback address instead of localhost, because
"localhost" can depend on nsswitch and in some case
we can not resolve the localhost.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/event/event-enable.tc  |    2 +-
 .../selftests/ftrace/test.d/event/event-pid.tc     |    2 +-
 .../ftrace/test.d/event/subsystem-enable.tc        |    2 +-
 .../ftrace/test.d/event/toplevel-enable.tc         |    2 +-
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |    2 +-
 .../inter-event/trigger-field-variable-support.tc  |    2 +-
 .../trigger-inter-event-combined-hist.tc           |    2 +-
 .../inter-event/trigger-onmatch-action-hist.tc     |    2 +-
 .../trigger-onmatch-onmax-action-hist.tc           |    2 +-
 .../inter-event/trigger-onmax-action-hist.tc       |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index 386dbddbdc11..a028628cdd0e 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -14,7 +14,7 @@ fail() { #msg
 }
 
 yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
+    ping 127.0.0.1 -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
 if [ ! -f set_event -o ! -d events/sched ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index 6dbf67544fde..6d2897f6a106 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -17,7 +17,7 @@ fail() { #msg
 }
 
 yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
+    ping 127.0.0.1 -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
 if [ ! -f set_event -o ! -d events/sched ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index 10eb17f161b7..9f0221b39d4d 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -14,7 +14,7 @@ fail() { #msg
 }
 
 yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
+    ping 127.0.0.1 -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
 if [ ! -f set_event -o ! -d events/sched ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 8d55a233c1a4..5f3611047d3a 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -13,7 +13,7 @@ fail() { #msg
 }
 
 yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
+    ping 127.0.0.1 -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
 if [ ! -f available_events -o ! -f set_event -o ! -d events ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 970903cb7834..cd52cf6a1fc4 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -49,7 +49,7 @@ fail() { # msg
 }
 
 yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
+    ping 127.0.0.1 -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
 do_test() {
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 575af23df04e..59b58c77e9ce 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -23,7 +23,7 @@ echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/
 echo 'hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
 echo 'hist:keys=pid,prio,comm:vals=lat:sort=pid,prio' > events/synthetic/wakeup_latency/trigger
 
-ping localhost -c 3
+ping 127.0.0.1 -c 3
 if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
     fail "Failed to create inter-event histogram"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 92aef26e2631..0a7709fdfd8e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -37,7 +37,7 @@ echo 'waking+wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking+wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
 echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking+wakeup_latency/trigger
 
-ping localhost -c 3
+ping 127.0.0.1 -c 3
 if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
     fail "Failed to create combined histogram"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index 1ef5dd4521f0..c5bdf8338aeb 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -29,7 +29,7 @@ echo "Test histogram variables,simple expression support and onmatch action"
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
 echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
-ping localhost -c 5
+ping 127.0.0.1 -c 5
 if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
     fail "Failed to create onmatch action inter-event histogram"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index 7234683ee5e5..47cb76bfd9c0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -29,7 +29,7 @@ echo "Test histogram variables,simple expression support and onmatch-onmax actio
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm):onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
 echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
-ping localhost -c 5
+ping 127.0.0.1 -c 5
 if [ ! grep -q "ping" events/synthetic/wakeup_latency/hist -o ! grep -q "max:" events/sched/sched_switch/hist]; then
     fail "Failed to create onmatch-onmax action inter-event histogram"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 55b9630a1d70..6fa0c449035c 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -27,7 +27,7 @@ echo "Test onmax action"
 
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_waking/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
-ping localhost -c 3
+ping 127.0.0.1 -c 3
 if ! grep -q "max:" events/sched/sched_switch/hist; then
     fail "Failed to create onmax action inter-event histogram"
 fi

