Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9315DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5EA2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W15ak9+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5EA2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404351AbeHPTcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeHPTcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:32:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC982148E;
        Thu, 16 Aug 2018 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437201;
        bh=pthCohHGh3ELJP20AIJvpKMPq/OWv9JWqRaeVQAxfj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W15ak9+U9jk4yvh2OJTwgrVDsn+ZC7Qu5XByi7CZAd67sxiwXpwkzFNQ0OSowhiOg
         dlgr1N66O2bKpQvw1vir3uJ8Nw4U7C/TrmECJV934b/ji6+Ls3m0u7HQcDrSmfYrc5
         QM41WF8gleU/NmETFtpgwNCzdvzC82KmtleOGM3Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/32] selftests/ftrace: Remove unneeded per-test init/cleanup ftrace
Date:   Fri, 17 Aug 2018 01:32:58 +0900
Message-Id: <153443717828.23257.17582540186433089404.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ftracetest framework calls initialize_ftrace() right before
each test and after all tests, we don't need to init/cleanup
ftrace for each test case.
Just remove such unneeded init/cleanup code because it can
increase logfile size.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/event/event-enable.tc  |    6 ------
 .../selftests/ftrace/test.d/event/event-pid.tc     |    3 +--
 .../ftrace/test.d/event/subsystem-enable.tc        |    6 ------
 .../ftrace/test.d/event/toplevel-enable.tc         |    6 ------
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |    4 ----
 .../ftrace/test.d/ftrace/fgraph-filter.tc          |    9 ---------
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |    6 ------
 .../ftrace/test.d/ftrace/func_event_triggers.tc    |    3 ---
 .../ftrace/test.d/ftrace/func_profiler.tc          |    4 ----
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |   13 -------------
 .../test.d/ftrace/func_traceonoff_triggers.tc      |   11 -----------
 .../ftrace/test.d/kprobe/add_and_remove.tc         |    3 ---
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |    3 ---
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |    2 --
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    5 -----
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |    5 -----
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    4 ----
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |    5 -----
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    9 ---------
 .../ftrace/test.d/kprobe/kprobe_module.tc          |    5 -----
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |    2 --
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |    4 ----
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    5 -----
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    4 ----
 .../inter-event/trigger-extended-error-support.tc  |   12 ------------
 .../inter-event/trigger-field-variable-support.tc  |   13 -------------
 .../trigger-inter-event-combined-hist.tc           |   13 -------------
 .../inter-event/trigger-multi-actions-accept.tc    |   14 --------------
 .../inter-event/trigger-onmatch-action-hist.tc     |   13 -------------
 .../trigger-onmatch-onmax-action-hist.tc           |   13 -------------
 .../inter-event/trigger-onmax-action-hist.tc       |   13 -------------
 .../trigger-synthetic-event-createremove.tc        |   12 ------------
 .../ftrace/test.d/trigger/trigger-eventonoff.tc    |   12 ------------
 .../ftrace/test.d/trigger/trigger-filter.tc        |   14 --------------
 .../ftrace/test.d/trigger/trigger-hist-mod.tc      |   12 ------------
 .../ftrace/test.d/trigger/trigger-hist.tc          |   12 ------------
 .../ftrace/test.d/trigger/trigger-multihist.tc     |   16 ----------------
 .../ftrace/test.d/trigger/trigger-snapshot.tc      |   12 ------------
 .../ftrace/test.d/trigger/trigger-stacktrace.tc    |   12 ------------
 .../test.d/trigger/trigger-trace-marker-hist.tc    |   11 -----------
 .../trigger/trigger-trace-marker-snapshot.tc       |   12 ------------
 .../trigger-trace-marker-synthetic-kernel.tc       |   12 ------------
 .../trigger/trigger-trace-marker-synthetic.tc      |   12 ------------
 .../ftrace/test.d/trigger/trigger-traceonoff.tc    |   12 ------------
 44 files changed, 1 insertion(+), 378 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index 9daf034186f5..386dbddbdc11 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -9,7 +9,6 @@ do_reset() {
 }
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,9 +22,6 @@ if [ ! -f set_event -o ! -d events/sched ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo 'sched:sched_switch' > set_event
 
 yield
@@ -57,6 +53,4 @@ if [ $count -ne 0 ]; then
     fail "sched_switch events should not be recorded"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index 132478b305c2..6dbf67544fde 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -30,8 +30,7 @@ if [ ! -f set_event_pid ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
+echo 0 > options/event-fork
 
 echo 1 > events/sched/sched_switch/enable
 
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index 6a37a8642ee6..10eb17f161b7 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -9,7 +9,6 @@ do_reset() {
 }
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,9 +22,6 @@ if [ ! -f set_event -o ! -d events/sched ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo 'sched:*' > set_event
 
 yield
@@ -57,6 +53,4 @@ if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 4e9b6e2c0219..8d55a233c1a4 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -8,7 +8,6 @@ do_reset() {
 }
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -22,9 +21,6 @@ if [ ! -f available_events -o ! -f set_event -o ! -d events ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo '*:*' > set_event
 
 yield
@@ -60,6 +56,4 @@ if [ $count -ne 0 ]; then
     fail "any of events should not be recorded"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index 1aec99d108eb..aefab0c66d54 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -16,13 +16,9 @@ if [ ! -f set_ftrace_filter ]; then
 fi
 
 do_reset() {
-    reset_tracer
     if [ -e /proc/sys/kernel/stack_tracer_enabled ]; then
 	    echo 0 > /proc/sys/kernel/stack_tracer_enabled
     fi
-    enable_tracing
-    clear_trace
-    echo > set_ftrace_filter
 }
 
 fail() { # msg
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index 9f8d27ca39cf..c8a5209f2119 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -9,14 +9,7 @@ if ! grep -q function_graph available_tracers; then
     exit_unsupported
 fi
 
-do_reset() {
-    reset_tracer
-    enable_tracing
-    clear_trace
-}
-
 fail() { # msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -48,6 +41,4 @@ if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 524ce24b3c22..970903cb7834 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -35,12 +35,6 @@ if [ $do_function_fork -eq 1 ]; then
 fi
 
 do_reset() {
-    reset_tracer
-    clear_trace
-    enable_tracing
-    echo > set_ftrace_filter
-    echo > set_ftrace_pid
-
     if [ $do_function_fork -eq 0 ]; then
 	return
     fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
index 6fed4cf2db81..ca2ffd7957f9 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
@@ -25,15 +25,12 @@ do_reset() {
 }
 
 fail() { # mesg
-    do_reset
     echo $1
     exit_fail
 }
 
 SLEEP_TIME=".1"
 
-do_reset
-
 echo "Testing function probes with events:"
 
 EVENT="sched:sched_switch"
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index b2d5a8febfe8..dfbae637c60c 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -29,8 +29,6 @@ if [ ! -f function_profile_enabled ]; then
 fi
 
 fail() { # mesg
-    reset_tracer
-    echo > set_ftrace_filter
     echo $1
     exit_fail
 }
@@ -76,6 +74,4 @@ if ! grep -v -e '^#' -e 'schedule' trace > /dev/null; then
 	fail "no other functions besides schedule was found"
 fi
 
-reset_tracer
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 68e7a48f5828..51f6e6146bd9 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -15,22 +15,11 @@ if [ ! -f set_ftrace_filter ]; then
     exit_unsupported
 fi
 
-do_reset() {
-    reset_tracer
-    reset_ftrace_filter
-    disable_events
-    clear_trace
-    enable_tracing
-}
-
 fail() { # mesg
-    do_reset
     echo $1
     exit_fail
 }
 
-do_reset
-
 FILTER=set_ftrace_filter
 FUNC1="schedule"
 FUNC2="do_softirq"
@@ -165,6 +154,4 @@ test_actual
 rm $TMPDIR/expected
 rm $TMPDIR/actual
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
index f6d9ac73268a..0c04282d33dd 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
@@ -16,24 +16,13 @@ if [ ! -f set_ftrace_filter ]; then
     exit_unsupported
 fi
 
-do_reset() {
-    reset_ftrace_filter
-    reset_tracer
-    disable_events
-    clear_trace
-    enable_tracing
-}
-
 fail() { # mesg
-    do_reset
     echo $1
     exit_fail
 }
 
 SLEEP_TIME=".1"
 
-do_reset
-
 echo "Testing function probes with enabling disabling tracing:"
 
 cnt_trace() {
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
index 4604d2103c89..bb1eb5a7c64e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/add_and_remove.tc
@@ -4,10 +4,7 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-echo 0 > events/enable
-echo > kprobe_events
 echo p:myevent _do_fork > kprobe_events
 grep myevent kprobe_events
 test -d events/kprobes/myevent
 echo > kprobe_events
-clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
index bbc443a9190c..442c1a8c5edf 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/busy_check.tc
@@ -4,12 +4,9 @@
 
 [ -f kprobe_events ] || exit_unsupported
 
-echo 0 > events/enable
-echo > kprobe_events
 echo p:myevent _do_fork > kprobe_events
 test -d events/kprobes/myevent
 echo 1 > events/kprobes/myevent/enable
 echo > kprobe_events && exit_fail # this must fail
 echo 0 > events/kprobes/myevent/enable
 echo > kprobe_events # this must succeed
-clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
index 8b43c6804fc3..9578535ccd67 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -4,8 +4,6 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-echo 0 > events/enable
-echo > kprobe_events
 echo 'p:testprobe _do_fork $stack $stack0 +0($stack)' > kprobe_events
 grep testprobe kprobe_events
 test -d events/kprobes/testprobe
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 1ad70cdaf442..46e7744f8358 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -4,9 +4,6 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-echo 0 > events/enable
-echo > kprobe_events
-
 case `uname -m` in
 x86_64)
   ARG1=%di
@@ -44,5 +41,3 @@ echo 1 > events/kprobes/testprobe/enable
 echo "p:test _do_fork" >> kprobe_events
 grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
-echo 0 > events/enable
-echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index d026ff4e562f..d783a8ce0692 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -6,9 +6,6 @@
 
 grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
 
-echo 0 > events/enable
-echo > kprobe_events
-
 PROBEFUNC="vfs_read"
 GOODREG=
 BADREG=
@@ -100,5 +97,3 @@ test_badarg "${GOODREG}::${GOODTYPE}" "${GOODREG}:${BADTYPE}" \
 
 test_goodarg "\$comm:string" "+0(\$stack):string"
 test_badarg "\$comm:x64" "\$stack:string" "${GOODREG}:string"
-
-echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 2a1755bfc290..37443dd23d15 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -6,10 +6,6 @@
 
 grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
 
-echo 0 > events/enable
-echo > kprobe_events
-enable_tracing
-
 echo 'p:testprobe _do_fork $stack0:s32 $stack0:u32 $stack0:x32 $stack0:b8@4/32' > kprobe_events
 grep testprobe kprobe_events
 test -d events/kprobes/testprobe
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 2724a1068cb1..3fb70e01b1fe 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -4,9 +4,6 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-disable_events
-echo > kprobe_events
-
 :;: "Add an event on function without name" ;:
 
 FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
@@ -33,5 +30,3 @@ echo "p $FUNC" > kprobe_events
 EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
 [ "x" != "x$EVENT" ] || exit_failure
 test -d events/$EVENT || exit_failure
-
-echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index cc4cac0e60f2..492426e95e09 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -8,8 +8,6 @@ grep function available_tracers || exit_unsupported # this is configurable
 # prepare
 echo nop > current_tracer
 echo _do_fork > set_ftrace_filter
-echo 0 > events/enable
-echo > kprobe_events
 echo 'p:testprobe _do_fork' > kprobe_events
 
 # kprobe on / ftrace off
@@ -47,10 +45,3 @@ echo > trace
 ( echo "forked")
 grep testprobe trace
 ! grep '_do_fork <-' trace
-
-# cleanup
-echo nop > current_tracer
-echo > set_ftrace_filter
-echo 0 > events/kprobes/testprobe/enable
-echo > kprobe_events
-echo > trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index 1e9f75f7a30f..ec6c5fffef1e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -4,9 +4,6 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-disable_events
-echo > kprobe_events
-
 :;: "Add an event on a module function without specifying event name" ;:
 
 MOD=`lsmod | head -n 2 | tail -n 1 | cut -f1 -d" "`
@@ -25,5 +22,3 @@ test -d events/kprobes/event1 || exit_failure
 
 echo "p:kprobes1/event1 $MOD:$FUNC" > kprobe_events
 test -d events/kprobes1/event1 || exit_failure
-
-echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index 321954683aaa..4c6b21e30b02 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -4,8 +4,6 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-echo 0 > events/enable
-echo > kprobe_events
 echo 'r:testprobe2 _do_fork $retval' > kprobe_events
 grep testprobe2 kprobe_events
 test -d events/kprobes/testprobe2
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
index 7c0290684c43..8e05b178519a 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
@@ -5,8 +5,6 @@
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 grep -q 'r\[maxactive\]' README || exit_unsupported # this is older version
 
-echo > kprobe_events
-
 # Test if we successfully reject unknown messages
 if echo 'a:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
 
@@ -37,5 +35,3 @@ echo > kprobe_events
 echo 'r10 inet_csk_accept' > kprobe_events
 grep inet_csk_accept kprobe_events
 echo > kprobe_events
-
-clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index ce361b9d62cf..5862eee91e1d 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,11 +12,6 @@ case `uname -m` in
   *) OFFS=0;;
 esac
 
-if [ -d events/kprobes ]; then
-  echo 0 > events/kprobes/enable
-  echo > kprobe_events
-fi
-
 N=0
 echo "Setup up kprobes on first available 256 text symbols"
 grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index 519d2763f5d2..a902aa0aaabc 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -30,8 +30,6 @@ if [ `printf "%x" -1 | wc -c` != 9 ]; then
   UINT_TEST=yes
 fi
 
-echo 0 > events/enable
-echo > kprobe_events
 echo "p:testprobe ${TARGET_FUNC}" > kprobe_events
 echo "p:testprobe ${TARGET}" > kprobe_events
 echo "p:testprobe ${TARGET_FUNC}${NEXT}" > kprobe_events
@@ -39,5 +37,3 @@ echo "p:testprobe ${TARGET_FUNC}${NEXT}" > kprobe_events
 if [ "${UINT_TEST}" = yes ]; then
 ! echo "p:testprobe ${TARGET_FUNC}${OVERFLOW}" > kprobe_events
 fi
-echo > kprobe_events
-clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
index 2aabab363cfb..401104344593 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
@@ -2,14 +2,7 @@
 # description: event trigger - test extended error support
 
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -24,9 +17,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo "Test extended error support"
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
 ! echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger 2> /dev/null
@@ -34,6 +24,4 @@ if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
     fail "Failed to generate extended error in histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 7fd5b4a8f060..575af23df04e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -1,14 +1,7 @@
 #!/bin/sh
 # description: event trigger - test field variable support
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-clear_synthetic_events
-reset_tracer
-do_reset
-
 echo "Test field variable support"
 
 echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
@@ -49,6 +38,4 @@ if grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
     fail "Failed to remove histogram with field variable"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index c93dbe38b5df..92aef26e2631 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,14 +1,7 @@
 #!/bin/sh
 # description: event trigger - test inter-event combined histogram trigger
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-clear_synthetic_events
-
 echo "Test create synthetic event"
 
 echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
@@ -53,6 +42,4 @@ if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
     fail "Failed to create combined histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
index c193dce611a2..4ddc546771b5 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -1,15 +1,7 @@
 #!/bin/sh
 # description: event trigger - test multiple actions on hist trigger
 
-
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -24,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-clear_synthetic_events
-reset_tracer
-do_reset
-
 echo "Test multiple actions on hist trigger"
 echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 TRIGGER1=events/sched/sched_wakeup/trigger
@@ -39,6 +27,4 @@ echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_
 echo 'hist:keys=next_pid:onmatch(sched.sched_wakeup).wakeup_latency(sched.sched_switch.$wakeup_lat,prev_pid) if next_comm=="cyclictest"' >> $TRIGGER2
 echo 'hist:keys=next_pid if next_comm=="cyclictest"' >> $TRIGGER2
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index e84e7d048566..1ef5dd4521f0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -1,14 +1,7 @@
 #!/bin/sh
 # description: event trigger - test inter-event histogram trigger onmatch action
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-clear_synthetic_events
-reset_tracer
-do_reset
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
@@ -45,6 +34,4 @@ if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
     fail "Failed to create onmatch action inter-event histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index 7907d8aacde3..7234683ee5e5 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -1,14 +1,7 @@
 #!/bin/sh
 # description: event trigger - test inter-event histogram trigger onmatch-onmax action
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-clear_synthetic_events
-reset_tracer
-do_reset
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
@@ -45,6 +34,4 @@ if [ ! grep -q "ping" events/synthetic/wakeup_latency/hist -o ! grep -q "max:" e
     fail "Failed to create onmatch-onmax action inter-event histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 38b7ed6242b2..55b9630a1d70 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -1,14 +1,7 @@
 #!/bin/sh
 # description: event trigger - test inter-event histogram trigger onmax action
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -23,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-clear_synthetic_events
-reset_tracer
-do_reset
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
@@ -43,6 +32,4 @@ if ! grep -q "max:" events/sched/sched_switch/hist; then
     fail "Failed to create onmax action inter-event histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
index cef11377dcbd..8d647fb572dd 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc
@@ -1,13 +1,7 @@
 #!/bin/sh
 # description: event trigger - test synthetic event create remove
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -22,10 +16,6 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
-clear_synthetic_events
-reset_tracer
-do_reset
-
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
@@ -49,6 +39,4 @@ if [ -d events/synthetic/wakeup_latency ]; then
     fail "Failed to delete wakeup_latency synthetic event"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
index 28cc355a3a7b..eddb51e1fbf7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-eventonoff.tc
@@ -3,14 +3,7 @@
 # description: event trigger - test event enable/disable trigger
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -25,9 +18,6 @@ if [ ! -f events/sched/sched_process_fork/trigger ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 FEATURE=`grep enable_event events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "event enable/disable trigger is not supported"
@@ -61,6 +51,4 @@ echo 'enable_event:sched:sched_switch' > events/sched/sched_process_fork/trigger
 ! echo 'enable_event:sched:sched_switch' > events/sched/sched_process_fork/trigger
 ! echo 'disable_event:sched:sched_switch' > events/sched/sched_process_fork/trigger
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
index a48e23eb8a8b..2dcc2296ebdd 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-filter.tc
@@ -3,14 +3,7 @@
 # description: event trigger - test trigger filter
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -25,9 +18,6 @@ if [ ! -f events/sched/sched_process_fork/trigger ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo "Test trigger filter"
 echo 1 > tracing_on
 echo 'traceoff if child_pid == 0' > events/sched/sched_process_fork/trigger
@@ -54,8 +44,4 @@ echo '!traceoff' > events/sched/sched_process_fork/trigger
 echo 'traceoff if parent_pid >= 0 || child_pid >= 0' > events/sched/sched_process_fork/trigger
 echo '!traceoff' > events/sched/sched_process_fork/trigger
 
-
-
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
index 8da80efc44d8..fab4431639d3 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-mod.tc
@@ -3,14 +3,7 @@
 # description: event trigger - test histogram modifiers
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -30,9 +23,6 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo "Test histogram with execname modifier"
 
 echo 'hist:keys=common_pid.execname' > events/sched/sched_process_fork/trigger
@@ -71,6 +61,4 @@ for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
 grep 'bytes_req: ~ 2^[0-9]*' events/kmem/kmalloc/hist > /dev/null || \
     fail "log2 modifier on kmem/kmalloc did not work"
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
index 449fe9ff91a2..177e8d4c4744 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
@@ -3,14 +3,7 @@
 # description: event trigger - test histogram trigger
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -30,9 +23,6 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo "Test histogram basic tigger"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
@@ -79,6 +69,4 @@ check_inc `grep -o "child_pid:[[:space:]]*[[:digit:]]*" \
     events/sched/sched_process_fork/hist | cut -d: -f2 ` ||
     fail "sort param on sched_process_fork did not work"
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
index c5ef8b9d02b3..18fdaab9f570 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
@@ -3,14 +3,7 @@
 # description: event trigger - test multiple histogram triggers
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -30,11 +23,6 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
-reset_trigger
-
 echo "Test histogram multiple tiggers"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
@@ -67,8 +55,4 @@ grep test_hist events/sched/sched_process_exit/hist > /dev/null || \
 diffs=`diff events/sched/sched_process_exit/hist events/sched/sched_process_fork/hist | wc -l`
 test $diffs -eq 0 || fail "Same name histograms are not same"
 
-reset_trigger
-
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
index ed38f0050d77..7717c0a09686 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
@@ -2,14 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test snapshot-trigger
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -29,9 +22,6 @@ if [ ! -f snapshot ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 FEATURE=`grep snapshot events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "snapshot trigger is not supported"
@@ -57,6 +47,4 @@ echo "Test snapshot semantic errors"
 echo "snapshot" > events/sched/sched_process_fork/trigger
 ! echo "snapshot" > events/sched/sched_process_fork/trigger
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
index 3121d795a868..398c05c4d2a7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-stacktrace.tc
@@ -2,14 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test stacktrace-trigger
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -24,9 +17,6 @@ if [ ! -f events/sched/sched_process_fork/trigger ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 FEATURE=`grep stacktrace events/sched/sched_process_fork/trigger`
 if [ -z "$FEATURE" ]; then
     echo "stacktrace trigger is not supported"
@@ -49,6 +39,4 @@ echo "Test stacktrace semantic errors"
 echo "stacktrace" > events/sched/sched_process_fork/trigger
 ! echo "stacktrace" > events/sched/sched_process_fork/trigger
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index 2acbfe2c0c0c..ab6bedb25736 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -3,14 +3,7 @@
 # description: trace_marker trigger - test histogram trigger
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -35,8 +28,6 @@ if [ ! -f events/ftrace/print/hist ]; then
     exit_unsupported
 fi
 
-do_reset
-
 echo "Test histogram trace_marker tigger"
 
 echo 'hist:keys=common_pid' > events/ftrace/print/trigger
@@ -44,6 +35,4 @@ for i in `seq 1 10` ; do echo "hello" > trace_marker; done
 grep 'hitcount: *10$' events/ftrace/print/hist > /dev/null || \
     fail "hist trigger did not trigger correct times on trace_marker"
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
index 6748e8cb42d0..79ce7d51350b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-snapshot.tc
@@ -3,15 +3,7 @@
 # description: trace_marker trigger - test snapshot trigger
 # flags: instance
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    echo 0 > snapshot
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -54,8 +46,6 @@ test_trace() {
     done
 }
 
-do_reset
-
 echo "Test snapshot trace_marker tigger"
 
 echo 'snapshot' > events/ftrace/print/trigger
@@ -69,6 +59,4 @@ for i in `seq 1 10` ; do echo "hello >$i<" > trace_marker; done
 test_trace trace 1
 test_trace snapshot 2
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
index 0a69c5d1cda8..18b4d1c2807e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
@@ -3,15 +3,7 @@
 # description: trace_marker trigger - test histogram with synthetic event against kernel event
 # flags:
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    echo > synthetic_events
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -46,8 +38,6 @@ if [ ! -f events/ftrace/print/hist ]; then
     exit_unsupported
 fi
 
-do_reset
-
 echo "Test histogram kernel event to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
@@ -63,6 +53,4 @@ grep 'hitcount: *1$' events/ftrace/print/hist > /dev/null || \
 grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
     fail "hist trigger did not trigger "
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index 3666dd6ab02a..dd262d6d0db6 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -3,15 +3,7 @@
 # description: trace_marker trigger - test histogram with synthetic event
 # flags:
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    echo > synthetic_events
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -41,8 +33,6 @@ if [ ! -f events/ftrace/print/hist ]; then
     exit_unsupported
 fi
 
-do_reset
-
 echo "Test histogram trace_marker to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
@@ -61,6 +51,4 @@ fi
 grep 'hitcount: *1$' events/synthetic/latency/hist > /dev/null || \
     fail "hist trigger did not trigger "
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
index c59d9eb546da..d5d2dcbc9cab 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-traceonoff.tc
@@ -2,14 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test traceon/off trigger
 
-do_reset() {
-    reset_trigger
-    echo > set_event
-    clear_trace
-}
-
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
@@ -24,9 +17,6 @@ if [ ! -f events/sched/sched_process_fork/trigger ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo "Test traceoff trigger"
 echo 1 > tracing_on
 echo 'traceoff' > events/sched/sched_process_fork/trigger
@@ -54,6 +44,4 @@ echo 'traceon' > events/sched/sched_process_fork/trigger
 ! echo 'traceon' > events/sched/sched_process_fork/trigger
 ! echo 'traceoff' > events/sched/sched_process_fork/trigger
 
-do_reset
-
 exit 0

