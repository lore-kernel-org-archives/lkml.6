Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D230820854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpaPGBll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D230820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJZDKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbeJZDKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:10:13 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12CE20665;
        Thu, 25 Oct 2018 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540492577;
        bh=ANhUaOo1ABrkiyAqoFBF5shN/ij/i48KC0RNrzGYbyM=;
        h=To:Cc:From:Subject:Date:From;
        b=LpaPGBllgMCXgnn3QNsNspfBx9VQ7eDNslMP3dTh2Qn3SAKDZH/TcftgrE9n7vT8y
         +X5TdhKiggC4j06ptqCIOEqMzOTO7bp2TWHpilW8kKyefpI5rwyJoIp3TD6x99Rov+
         fP1UaPGgtCUv9dt5SyrxQuxuCSUDZJU6YUypgccI=
To:     torvalds@linux-foundation.org
Cc:     Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest update for Linux 4.20-rc1
Message-ID: <407e4b9c-36eb-d533-331c-2396460c6f67@kernel.org>
Date:   Thu, 25 Oct 2018 12:36:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B2E9FF504FE4223AE9D1B8AC"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B2E9FF504FE4223AE9D1B8AC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following kselftest update for Linux 4.20-rc1

This Kselftest update for Linux 4.20-rc1 consists of:

- Improvements to ftrace test suite from Masami Hiramatsu.
- Color coded ftrace PASS / FAIL results from Steven Rostedt (VMware)
  to improve readability of reports.
- watchdog Fixes and enhancement to add gettimeout and get|set pretimeout
  options from Jerry Hoemann.
- Several fixes to warnings and spelling etc.

Please note that these patches have been in linux-next for a while and I did
a rebase to Linux 4.19 just to make sure there are no conflicts.

diff is attached.

Also, there  is a conflict in tools/testing/selftests/kvm/dirty_log_test.c

between commit:

  fff8dcd7b4a2 ("kvm: selftests: port dirty_log_test to aarch64")

from the kvm tree and commit:

  cda94d9ffa0e ("selftests: kvm: Fix -Wformat warnings")

Stephen Rothwell fixed this up.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.20-rc1

for you to fetch changes up to f73581f8d9a367459f36e6a4ef0065997ab14c75:

  selftests/ftrace: Strip escape sequences for log file (2018-10-24 14:49:37 -0600)

----------------------------------------------------------------
linux-kselftest-4.20-rc1

This Kselftest update for Linux 4.20-rc1 consists of:

- Improvements to ftrace test suite from Masami Hiramatsu.
- Color coded ftrace PASS / FAIL results from Steven Rostedt (VMware)
  to improve readability of reports.
- watchdog Fixes and enhancement to add gettimeout and get|set pretimeout
  options from Jerry Hoemann.
- Several fixes to warnings and spelling etc.

----------------------------------------------------------------
Andrea Parri (1):
      selftests: kvm: Fix -Wformat warnings

Colin Ian King (1):
      kvm: selftests: fix spelling mistake "Insufficent" -> "Insufficient"

Daniel Díaz (2):
      selftests: gpio: Fix OUTPUT directory in Makefile
      selftests/ftrace: Use colored output when available

Fathi Boudra (1):
      selftests: gpio: restructure Makefile

Jerry Hoemann (2):
      selftests: watchdog: Fix error message.
      selftests: watchdog: Add gettimeout and get|set pretimeout

Masami Hiramatsu (29):
      selftests/ftrace: Add --stop-fail hidden option for debug
      selftests/ftrace: Add --console hidden option
      selftests/ftrace: Add case number prefix to logfile
      selftests/ftrace: More initialize features in initialize_ftrace
      selftests/ftrace: Add SPDX License Identifier to template
      selftests/ftrace: Cleanup ftrace after running test
      selftests/ftrace: Remove unneeded per-test init/cleanup ftrace
      selftests/ftrace: Fix to test kprobe $comm arg only if available
      selftests/ftrace: Fix checkbashisms errors
      selftests/ftrace: Use loopback address instead of localhost
      selftests/ftrace: Improve kprobe on module testcase to load/unload module
      selftests/ftrace: Improve kprobe testcase to check log data
      selftests/ftrace: Improve kretprobe testcase to check log data
      selftests/ftrace: Test kprobe-event argument with various bitsize
      selftests/ftrace: Check set_event_pid result
      selftests/ftrace: Add kprobe event with $comm argument testcase
      selftests/ftrace: Add kprobe profile testcase
      selftests/ftrace: Add kprobe-event with symbol argument test
      selftests/ftrace: Add trace_printk sample module test
      selftests/ftrace: Add ringbuffer size changing testcase
      selftests/ftrace: Add function profiling stat testcase
      selftests/ftrace: Add max stack tracer testcase
      selftests/ftrace: Add function filter on module testcase
      selftests/ftrace: Add trace_pipe testcase
      selftests/ftrace: Add stacktrace ftrace filter command testcase
      selftests/ftrace: Add wakeup tracer testcase
      selftests/ftrace: Add wakeup_rt tracer testcase
      selftests/ftrace: Add ftrace cpumask testcase
      selftests/ftrace: Strip escape sequences for log file

Peng Hao (1):
      selftests: fix warning: "_GNU_SOURCE" redefined

Shuah Khan (Samsung OSG) (2):
      selftests: watchdog: fix message when /dev/watchdog open fails
      selftests: watchdog: Fix ioctl SET* error paths to take oneshot exit path

Steven Rostedt (VMware) (1):
      selftests/ftrace: Add color to the PASS / FAIL results

 tools/testing/selftests/ftrace/config              |  6 ++
 tools/testing/selftests/ftrace/ftracetest          | 72 ++++++++++++++++++----
 .../ftrace/test.d/00basic/ringbuffer_size.tc       | 22 +++++++
 .../selftests/ftrace/test.d/00basic/trace_pipe.tc  | 16 +++++
 .../selftests/ftrace/test.d/event/event-enable.tc  | 10 ---
 .../selftests/ftrace/test.d/event/event-pid.tc     |  8 +--
 .../ftrace/test.d/event/subsystem-enable.tc        | 10 ---
 .../ftrace/test.d/event/toplevel-enable.tc         | 10 ---
 .../selftests/ftrace/test.d/event/trace_printk.tc  | 27 ++++++++
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |  4 --
 .../ftrace/test.d/ftrace/fgraph-filter.tc          |  9 ---
 .../ftrace/test.d/ftrace/func-filter-pid.tc        | 10 ---
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc | 12 ++++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc | 42 +++++++++++++
 .../ftrace/test.d/ftrace/func_event_triggers.tc    |  3 -
 .../ftrace/test.d/ftrace/func_mod_trace.tc         | 24 ++++++++
 .../ftrace/test.d/ftrace/func_profile_stat.tc      | 22 +++++++
 .../ftrace/test.d/ftrace/func_profiler.tc          |  4 --
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   | 13 ----
 .../ftrace/test.d/ftrace/func_stack_tracer.tc      | 39 ++++++++++++
 .../test.d/ftrace/func_traceonoff_triggers.tc      | 11 ----
 tools/testing/selftests/ftrace/test.d/functions    | 11 ++++
 .../ftrace/test.d/kprobe/add_and_remove.tc         |  3 -
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |  3 -
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  8 ++-
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       | 17 +++++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  5 --
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     | 39 ++++++++++++
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |  8 +--
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       | 52 ++++++++++------
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |  5 --
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |  9 ---
 .../ftrace/test.d/kprobe/kprobe_module.tc          | 36 +++++++++--
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |  9 ++-
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |  4 --
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |  5 --
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |  4 --
 .../selftests/ftrace/test.d/kprobe/profile.tc      | 15 +++++
 tools/testing/selftests/ftrace/test.d/template     |  1 +
 .../selftests/ftrace/test.d/tracer/wakeup.tc       | 25 ++++++++
 .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    | 25 ++++++++
 .../inter-event/trigger-extended-error-support.tc  | 12 ----
 .../inter-event/trigger-field-variable-support.tc  | 15 +----
 .../trigger-inter-event-combined-hist.tc           | 15 +----
 .../inter-event/trigger-multi-actions-accept.tc    | 14 -----
 .../inter-event/trigger-onmatch-action-hist.tc     | 16 +----
 .../trigger-onmatch-onmax-action-hist.tc           | 16 +----
 .../inter-event/trigger-onmax-action-hist.tc       | 16 +----
 .../trigger-synthetic-event-createremove.tc        | 12 ----
 .../ftrace/test.d/trigger/trigger-eventonoff.tc    | 12 ----
 .../ftrace/test.d/trigger/trigger-filter.tc        | 14 -----
 .../ftrace/test.d/trigger/trigger-hist-mod.tc      | 12 ----
 .../ftrace/test.d/trigger/trigger-hist.tc          | 12 ----
 .../ftrace/test.d/trigger/trigger-multihist.tc     | 16 -----
 .../ftrace/test.d/trigger/trigger-snapshot.tc      | 12 ----
 .../ftrace/test.d/trigger/trigger-stacktrace.tc    | 12 ----
 .../test.d/trigger/trigger-trace-marker-hist.tc    | 11 ----
 .../trigger/trigger-trace-marker-snapshot.tc       | 16 +----
 .../trigger-trace-marker-synthetic-kernel.tc       | 12 ----
 .../trigger/trigger-trace-marker-synthetic.tc      | 12 ----
 .../ftrace/test.d/trigger/trigger-traceonoff.tc    | 12 ----
 tools/testing/selftests/gpio/Makefile              | 32 +++++-----
 tools/testing/selftests/kvm/dirty_log_test.c       |  4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  2 +-
 tools/testing/selftests/proc/fd-001-lookup.c       |  2 +-
 tools/testing/selftests/proc/fd-003-kthread.c      |  2 +-
 tools/testing/selftests/watchdog/watchdog-test.c   | 61 +++++++++++++++---
 67 files changed, 564 insertions(+), 466 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc

----------------------------------------------------------------


--------------B2E9FF504FE4223AE9D1B8AC
Content-Type: text/x-patch;
 name="linux-kselftest-4.20-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.20-rc1.diff"

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 07db5ab09cc7..c2c8de4fafff 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,6 +4,12 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_SCHED_TRACER=y
 CONFIG_PREEMPT_TRACER=y
 CONFIG_IRQSOFF_TRACER=y
 CONFIG_PREEMPTIRQ_DELAY_TEST=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_SAMPLES=y
+CONFIG_SAMPLE_TRACE_PRINTK=m
+CONFIG_KALLSYMS_ALL=y
diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index f9a9d424c980..75244db70331 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -60,15 +60,29 @@ parse_opts() { # opts
       shift 1
     ;;
     --verbose|-v|-vv|-vvv)
+      if [ $VERBOSE -eq -1 ]; then
+	usage "--console can not use with --verbose"
+      fi
       VERBOSE=$((VERBOSE + 1))
       [ $1 = '-vv' ] && VERBOSE=$((VERBOSE + 1))
       [ $1 = '-vvv' ] && VERBOSE=$((VERBOSE + 2))
       shift 1
     ;;
+    --console)
+      if [ $VERBOSE -ne 0 ]; then
+	usage "--console can not use with --verbose"
+      fi
+      VERBOSE=-1
+      shift 1
+    ;;
     --debug|-d)
       DEBUG=1
       shift 1
     ;;
+    --stop-fail)
+      STOP_FAILURE=1
+      shift 1
+    ;;
     --fail-unsupported)
       UNSUPPORTED_RESULT=1
       shift 1
@@ -117,6 +131,7 @@ KEEP_LOG=0
 DEBUG=0
 VERBOSE=0
 UNSUPPORTED_RESULT=0
+STOP_FAILURE=0
 # Parse command-line options
 parse_opts $*
 
@@ -137,11 +152,33 @@ else
   date > $LOG_FILE
 fi
 
+# Define text colors
+# Check available colors on the terminal, if any
+ncolors=`tput colors 2>/dev/null`
+color_reset=
+color_red=
+color_green=
+color_blue=
+# If stdout exists and number of colors is eight or more, use them
+if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
+  color_reset="\e[0m"
+  color_red="\e[31m"
+  color_green="\e[32m"
+  color_blue="\e[34m"
+fi
+
+strip_esc() {
+  # busybox sed implementation doesn't accept "\x1B", so use [:cntrl:] instead.
+  sed -E "s/[[:cntrl:]]\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
+}
+
 prlog() { # messages
-  [ -z "$LOG_FILE" ] && echo "$@" || echo "$@" | tee -a $LOG_FILE
+  echo -e "$@"
+  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
-  [ -z "$LOG_FILE" ] && cat $1 || cat $1 | tee -a $LOG_FILE
+  cat $1
+  [ "$LOG_FILE" ] && cat $1 | strip_esc >> $LOG_FILE
 }
 prlog "=== Ftrace unit tests ==="
 
@@ -180,37 +217,37 @@ test_on_instance() { # testfile
 eval_result() { # sigval
   case $1 in
     $PASS)
-      prlog "	[PASS]"
+      prlog "	[${color_green}PASS${color_reset}]"
       PASSED_CASES="$PASSED_CASES $CASENO"
       return 0
     ;;
     $FAIL)
-      prlog "	[FAIL]"
+      prlog "	[${color_red}FAIL${color_reset}]"
       FAILED_CASES="$FAILED_CASES $CASENO"
       return 1 # this is a bug.
     ;;
     $UNRESOLVED)
-      prlog "	[UNRESOLVED]"
+      prlog "	[${color_blue}UNRESOLVED${color_reset}]"
       UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
       return 1 # this is a kind of bug.. something happened.
     ;;
     $UNTESTED)
-      prlog "	[UNTESTED]"
+      prlog "	[${color_blue}UNTESTED${color_reset}]"
       UNTESTED_CASES="$UNTESTED_CASES $CASENO"
       return 0
     ;;
     $UNSUPPORTED)
-      prlog "	[UNSUPPORTED]"
+      prlog "	[${color_blue}UNSUPPORTED${color_reset}]"
       UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
       return $UNSUPPORTED_RESULT # depends on use case
     ;;
     $XFAIL)
-      prlog "	[XFAIL]"
+      prlog "	[${color_red}XFAIL${color_reset}]"
       XFAILED_CASES="$XFAILED_CASES $CASENO"
       return 0
     ;;
     *)
-      prlog "	[UNDEFINED]"
+      prlog "	[${color_blue}UNDEFINED${color_reset}]"
       UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
       return 1 # this must be a test bug
     ;;
@@ -269,16 +306,18 @@ __run_test() { # testfile
 # Run one test case
 run_test() { # testfile
   local testname=`basename $1`
+  testcase $1
   if [ ! -z "$LOG_FILE" ] ; then
-    local testlog=`mktemp $LOG_DIR/${testname}-log.XXXXXX`
+    local testlog=`mktemp $LOG_DIR/${CASENO}-${testname}-log.XXXXXX`
   else
     local testlog=/proc/self/fd/1
   fi
   export TMPDIR=`mktemp -d /tmp/ftracetest-dir.XXXXXX`
-  testcase $1
   echo "execute$INSTANCE: "$1 > $testlog
   SIG_RESULT=0
-  if [ -z "$LOG_FILE" ]; then
+  if [ $VERBOSE -eq -1 ]; then
+    __run_test $1
+  elif [ -z "$LOG_FILE" ]; then
     __run_test $1 2>&1
   elif [ $VERBOSE -ge 3 ]; then
     __run_test $1 | tee -a $testlog 2>&1
@@ -304,6 +343,10 @@ run_test() { # testfile
 # Main loop
 for t in $TEST_CASES; do
   run_test $t
+  if [ $STOP_FAILURE -ne 0 -a $TOTAL_RESULT -ne 0 ]; then
+    echo "A failure detected. Stop test."
+    exit 1
+  fi
 done
 
 # Test on instance loop
@@ -315,7 +358,12 @@ for t in $TEST_CASES; do
   run_test $t
   rmdir $TRACING_DIR
   TRACING_DIR=$SAVED_TRACING_DIR
+  if [ $STOP_FAILURE -ne 0 -a $TOTAL_RESULT -ne 0 ]; then
+    echo "A failure detected. Stop test."
+    exit 1
+  fi
 done
+(cd $TRACING_DIR; initialize_ftrace) # for cleanup
 
 prlog ""
 prlog "# of passed: " `echo $PASSED_CASES | wc -w`
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
new file mode 100644
index 000000000000..ab70f0077c35
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Change the ringbuffer size
+# flags: instance
+
+rb_size_test() {
+ORIG=`cat buffer_size_kb`
+
+expr $ORIG / 2 > buffer_size_kb
+
+expr $ORIG \* 2 > buffer_size_kb
+
+echo $ORIG > buffer_size_kb
+}
+
+rb_size_test
+
+: "If per-cpu buffer is supported, imbalance it"
+if [ -d per_cpu/cpu0 ]; then
+  cd per_cpu/cpu0
+  rb_size_test
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
new file mode 100644
index 000000000000..5058fbcfd90f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_pipe.tc
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: trace_pipe and trace_marker
+# flags: instance
+
+[ ! -f trace_marker ] && exit_unsupported
+
+echo "test input 1" > trace_marker
+
+: "trace interface never consume the ring buffer"
+grep -q "test input 1" trace
+grep -q "test input 1" trace
+
+: "trace interface never consume the ring buffer"
+head -n 1 trace_pipe | grep -q "test input 1"
+! grep -q "test input 1" trace
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index 9daf034186f5..dfb0d5122f7b 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -9,23 +9,15 @@ do_reset() {
 }
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
 
-yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
-}
-
 if [ ! -f set_event -o ! -d events/sched ]; then
     echo "event tracing is not supported"
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo 'sched:sched_switch' > set_event
 
 yield
@@ -57,6 +49,4 @@ if [ $count -ne 0 ]; then
     fail "sched_switch events should not be recorded"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index 132478b305c2..f9cb214220b1 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -16,10 +16,6 @@ fail() { #msg
     exit_fail
 }
 
-yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
-}
-
 if [ ! -f set_event -o ! -d events/sched ]; then
     echo "event tracing is not supported"
     exit_unsupported
@@ -30,8 +26,7 @@ if [ ! -f set_event_pid ]; then
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
+echo 0 > options/event-fork
 
 echo 1 > events/sched/sched_switch/enable
 
@@ -47,6 +42,7 @@ do_reset
 read mypid rest < /proc/self/stat
 
 echo $mypid > set_event_pid
+grep -q $mypid set_event_pid
 echo 'sched:sched_switch' > set_event
 
 yield
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index 6a37a8642ee6..83a8c571e93a 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -9,23 +9,15 @@ do_reset() {
 }
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
 
-yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
-}
-
 if [ ! -f set_event -o ! -d events/sched ]; then
     echo "event tracing is not supported"
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo 'sched:*' > set_event
 
 yield
@@ -57,6 +49,4 @@ if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 4e9b6e2c0219..84d7bda08d2a 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -8,23 +8,15 @@ do_reset() {
 }
 
 fail() { #msg
-    do_reset
     echo $1
     exit_fail
 }
 
-yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
-}
-
 if [ ! -f available_events -o ! -f set_event -o ! -d events ]; then
     echo "event tracing is not supported"
     exit_unsupported
 fi
 
-reset_tracer
-do_reset
-
 echo '*:*' > set_event
 
 yield
@@ -60,6 +52,4 @@ if [ $count -ne 0 ]; then
     fail "any of events should not be recorded"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
new file mode 100644
index 000000000000..b02550b42be9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace_printk from module
+
+rmmod trace-printk ||:
+if ! modprobe trace-printk ; then
+  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
+  exit_unresolved;
+fi
+
+echo "Waiting for irq work"
+sleep 1
+
+grep -q ": This .* trace_bputs" trace
+grep -q ": This .* trace_puts" trace
+grep -q ": This .* trace_bprintk" trace
+grep -q ": This .* trace_printk" trace
+
+grep -q ": (irq) .* trace_bputs" trace
+grep -q ": (irq) .* trace_puts" trace
+grep -q ": (irq) .* trace_bprintk" trace
+grep -q ": (irq) .* trace_printk" trace
+
+grep -q "This is a %s that will use trace_bprintk" printk_formats
+grep -q "(irq) This is a static string that will use trace_bputs" printk_formats
+
+rmmod trace-printk ||:
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
index 524ce24b3c22..64cfcc75e3c1 100644
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
@@ -54,10 +48,6 @@ fail() { # msg
     exit_fail
 }
 
-yield() {
-    ping localhost -c 1 || sleep .001 || usleep 1 || sleep 1
-}
-
 do_test() {
     disable_tracing
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
new file mode 100644
index 000000000000..bf72e783d014
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: ftrace - stacktrace filter command
+# flags: instance
+
+echo _do_fork:stacktrace >> set_ftrace_filter
+
+grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
+
+(echo "forked"; sleep 1)
+
+grep -q "<stack trace>" trace
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
new file mode 100644
index 000000000000..0e6810743576
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: ftrace - function trace with cpumask
+
+if ! which nproc ; then
+  nproc() {
+    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
+  }
+fi
+
+NP=`nproc`
+
+if [ $NP -eq 1 ] ;then
+  echo "We can not test cpumask on UP environment"
+  exit_unresolved
+fi
+
+ORIG_CPUMASK=`cat tracing_cpumask`
+
+do_reset() {
+  echo $ORIG_CPUMASK > tracing_cpumask
+}
+
+echo 0 > tracing_on
+echo > trace
+: "Bitmask only record on CPU1"
+echo 2 > tracing_cpumask
+MASK=0x`cat tracing_cpumask`
+test `printf "%d" $MASK` -eq 2 || do_reset
+
+echo function > current_tracer
+echo 1 > tracing_on
+(echo "forked")
+echo 0 > tracing_on
+
+: "Check CPU1 events are recorded"
+grep -q -e "\[001\]" trace || do_reset
+
+: "There should be No other cpu events"
+! grep -qv -e "\[001\]" -e "^#" trace || do_reset
+
+do_reset
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
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
new file mode 100644
index 000000000000..9330c873f9fe
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function trace on module
+
+[ ! -f set_ftrace_filter ] && exit_unsupported
+
+: "mod: allows to filter a non exist function"
+echo 'non_exist_func:mod:non_exist_module' > set_ftrace_filter
+grep -q "non_exist_func" set_ftrace_filter
+
+: "mod: on exist module"
+echo '*:mod:trace_printk' > set_ftrace_filter
+if ! modprobe trace-printk ; then
+  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
+m"
+  exit_unresolved;
+fi
+
+: "Wildcard should be resolved after loading module"
+grep -q "trace_printk_irq_work" set_ftrace_filter
+
+: "After removing the filter becomes empty"
+rmmod trace_printk
+test `cat set_ftrace_filter | wc -l` -eq 0
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
new file mode 100644
index 000000000000..0d501058aa75
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profile_stat.tc
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function profiling
+
+[ ! -f function_profile_enabled ] && exit_unsupported
+
+: "Enable function profile"
+echo 1 > function_profile_enabled
+
+: "Profile must be updated"
+cp trace_stat/function0 $TMPDIR/
+( echo "forked"; sleep 1 )
+: "diff returns 0 if there is no difference"
+! diff trace_stat/function0 $TMPDIR/function0
+
+echo 0 > function_profile_enabled
+
+: "Profile must NOT be updated"
+cp trace_stat/function0 $TMPDIR/
+( echo "forked"; sleep 1 )
+: "diff returns 0 if there is no difference"
+diff trace_stat/function0 $TMPDIR/function0
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
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
new file mode 100644
index 000000000000..b414f0e3c646
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - Max stack tracer
+# Test the basic function of max-stack usage tracing
+
+if [ ! -f stack_trace ]; then
+  echo "Max stack tracer is not supported - please make CONFIG_STACK_TRACER=y"
+  exit_unsupported
+fi
+
+echo > stack_trace_filter
+echo 0 > stack_max_size
+echo 1 > /proc/sys/kernel/stack_tracer_enabled
+
+: "Fork and wait for the first entry become !lock"
+timeout=10
+while [ $timeout -ne 0 ]; do
+  ( echo "forked" )
+  FL=`grep " 0)" stack_trace`
+  echo $FL | grep -q "lock" || break;
+  timeout=$((timeout - 1))
+done
+echo 0 > /proc/sys/kernel/stack_tracer_enabled
+
+echo '*lock*' > stack_trace_filter
+test `cat stack_trace_filter | wc -l` -eq `grep lock stack_trace_filter | wc -l`
+
+echo 0 > stack_max_size
+echo 1 > /proc/sys/kernel/stack_tracer_enabled
+
+: "Fork and always the first entry including lock"
+timeout=10
+while [ $timeout -ne 0 ]; do
+  ( echo "forked" )
+  FL=`grep " 0)" stack_trace`
+  echo $FL | grep -q "lock"
+  timeout=$((timeout - 1))
+done
+echo 0 > /proc/sys/kernel/stack_tracer_enabled
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
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index e4645d5e3126..7b96e80e6b8a 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -89,12 +89,23 @@ initialize_ftrace() { # Reset ftrace to initial-state
     reset_tracer
     reset_trigger
     reset_events_filter
+    reset_ftrace_filter
     disable_events
     echo > set_event_pid	# event tracer is always on
+    echo > set_ftrace_pid
     [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
     [ -f kprobe_events ] && echo > kprobe_events
     [ -f uprobe_events ] && echo > uprobe_events
+    [ -f synthetic_events ] && echo > synthetic_events
+    [ -f snapshot ] && echo 0 > snapshot
+    clear_trace
     enable_tracing
 }
+
+LOCALHOST=127.0.0.1
+
+yield() {
+    ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
+}
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
index 8b43c6804fc3..bcdecf80a8f1 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -4,13 +4,15 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-echo 0 > events/enable
-echo > kprobe_events
 echo 'p:testprobe _do_fork $stack $stack0 +0($stack)' > kprobe_events
-grep testprobe kprobe_events
+grep testprobe kprobe_events | grep -q 'arg1=\$stack arg2=\$stack0 arg3=+0(\$stack)'
 test -d events/kprobes/testprobe
+
 echo 1 > events/kprobes/testprobe/enable
 ( echo "forked")
+grep testprobe trace | grep '_do_fork' | \
+  grep -q 'arg1=0x[[:xdigit:]]* arg2=0x[[:xdigit:]]* arg3=0x[[:xdigit:]]*$'
+
 echo 0 > events/kprobes/testprobe/enable
 echo "-:testprobe" >> kprobe_events
 clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
new file mode 100644
index 000000000000..15c1f70fcaf9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event with comm arguments
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -A1 "fetcharg:" README | grep -q "\$comm" || exit_unsupported # this is too old
+
+echo 'p:testprobe _do_fork comm=$comm ' > kprobe_events
+grep testprobe kprobe_events | grep -q 'comm=$comm'
+test -d events/kprobes/testprobe
+
+echo 1 > events/kprobes/testprobe/enable
+( echo "forked")
+grep testprobe trace | grep -q 'comm=".*"'
+
+exit 0
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
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
new file mode 100644
index 000000000000..2b6dd33f9076
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event symbol argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+SYMBOL="linux_proc_banner"
+
+if [ ! -f /proc/kallsyms ]; then
+  echo "Can not check the target symbol - please enable CONFIG_KALLSYMS"
+  exit_unresolved
+elif ! grep "$SYMBOL\$" /proc/kallsyms; then
+  echo "Linux banner is not exported - please enable CONFIG_KALLSYMS_ALL"
+  exit_unresolved
+fi
+
+: "Test get basic types symbol argument"
+echo "p:testprobe_u _do_fork arg1=@linux_proc_banner:u64 arg2=@linux_proc_banner:u32 arg3=@linux_proc_banner:u16 arg4=@linux_proc_banner:u8" > kprobe_events
+echo "p:testprobe_s _do_fork arg1=@linux_proc_banner:s64 arg2=@linux_proc_banner:s32 arg3=@linux_proc_banner:s16 arg4=@linux_proc_banner:s8" >> kprobe_events
+if grep -q "x8/16/32/64" README; then
+  echo "p:testprobe_x _do_fork arg1=@linux_proc_banner:x64 arg2=@linux_proc_banner:x32 arg3=@linux_proc_banner:x16 arg4=@linux_proc_banner:x8" >> kprobe_events
+fi
+echo "p:testprobe_bf _do_fork arg1=@linux_proc_banner:b8@4/32" >> kprobe_events
+echo 1 > events/kprobes/enable
+(echo "forked")
+echo 0 > events/kprobes/enable
+grep "testprobe_[usx]:.* arg1=.* arg2=.* arg3=.* arg4=.*" trace
+grep "testprobe_bf:.* arg1=.*" trace
+
+: "Test get string symbol argument"
+echo "p:testprobe_str _do_fork arg1=@linux_proc_banner:string" > kprobe_events
+echo 1 > events/kprobes/enable
+(echo "forked")
+echo 0 > events/kprobes/enable
+RESULT=`grep "testprobe_str" trace | sed -e 's/.* arg1=\(.*\)/\1/'`
+
+RESULT=`echo $RESULT | sed -e 's/.* \((.*)\) \((.*)\) .*/\1 \2/'`
+ORIG=`cat /proc/version | sed -e 's/.* \((.*)\) \((.*)\) .*/\1 \2/'`
+test "$RESULT" = "$ORIG"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index d026ff4e562f..6f0f19953193 100644
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
@@ -78,8 +75,11 @@ test_badarg "\$stackp" "\$stack0+10" "\$stack1-10"
 echo "r ${PROBEFUNC} \$retval" > kprobe_events
 ! echo "p ${PROBEFUNC} \$retval" > kprobe_events
 
+# $comm was introduced in 4.8, older kernels reject it.
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
 : "Comm access"
 test_goodarg "\$comm"
+fi
 
 : "Indirect memory access"
 test_goodarg "+0(${GOODREG})" "-0(${GOODREG})" "+10(\$stack)" \
@@ -100,5 +100,3 @@ test_badarg "${GOODREG}::${GOODTYPE}" "${GOODREG}:${BADTYPE}" \
 
 test_goodarg "\$comm:string" "+0(\$stack):string"
 test_badarg "\$comm:x64" "\$stack:string" "${GOODREG}:string"
-
-echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 2a1755bfc290..1bcb67dcae26 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -6,33 +6,45 @@
 
 grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
 
-echo 0 > events/enable
-echo > kprobe_events
-enable_tracing
-
-echo 'p:testprobe _do_fork $stack0:s32 $stack0:u32 $stack0:x32 $stack0:b8@4/32' > kprobe_events
-grep testprobe kprobe_events
-test -d events/kprobes/testprobe
-
-echo 1 > events/kprobes/testprobe/enable
-( echo "forked")
-echo 0 > events/kprobes/testprobe/enable
-ARGS=`tail -n 1 trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+gen_event() { # Bitsize
+  echo "p:testprobe _do_fork \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
+}
 
-check_types() {
-  X1=`printf "%x" $1 | tail -c 8`
+check_types() { # s-type u-type x-type bf-type width
+  test $# -eq 5
+  CW=$5
+  CW=$((CW / 4))
+  X1=`printf "%x" $1 | tail -c ${CW}`
   X2=`printf "%x" $2`
   X3=`printf "%x" $3`
   test $X1 = $X2
   test $X2 = $X3
   test 0x$X3 = $3
 
-  B4=`printf "%02x" $4`
-  B3=`echo -n $X3 | tail -c 3 | head -c 2`
+  B4=`printf "%1x" $4`
+  B3=`printf "%03x" 0x$X3 | tail -c 2 | head -c 1`
   test $B3 = $B4
 }
-check_types $ARGS
 
-echo "-:testprobe" >> kprobe_events
-clear_trace
-test -d events/kprobes/testprobe && exit_fail || exit_pass
+for width in 64 32 16 8; do
+  : "Add new event with basic types"
+  gen_event $width > kprobe_events
+  grep testprobe kprobe_events
+  test -d events/kprobes/testprobe
+
+  : "Trace the event"
+  echo 1 > events/kprobes/testprobe/enable
+  ( echo "forked")
+  echo 0 > events/kprobes/testprobe/enable
+
+  : "Confirm the arguments is recorded in given types correctly"
+  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+  check_types $ARGS $width
+
+  : "Clear event for next loop"
+  echo "-:testprobe" >> kprobe_events
+  clear_trace
+
+done
+
+exit_pass
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
index 1e9f75f7a30f..d861bd776c5e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -4,14 +4,18 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-disable_events
-echo > kprobe_events
+rmmod trace-printk ||:
+if ! modprobe trace-printk ; then
+  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
+m"
+  exit_unresolved;
+fi
+
+MOD=trace_printk
+FUNC=trace_printk_irq_work
 
 :;: "Add an event on a module function without specifying event name" ;:
 
-MOD=`lsmod | head -n 2 | tail -n 1 | cut -f1 -d" "`
-FUNC=`grep -m 1 ".* t .*\\[$MOD\\]" /proc/kallsyms | xargs | cut -f3 -d" "`
-[ "x" != "x$MOD" -a "y" != "y$FUNC" ] || exit_unresolved
 echo "p $MOD:$FUNC" > kprobe_events
 PROBE_NAME=`echo $MOD:$FUNC | tr ".:" "_"`
 test -d events/kprobes/p_${PROBE_NAME}_0 || exit_failure
@@ -26,4 +30,24 @@ test -d events/kprobes/event1 || exit_failure
 echo "p:kprobes1/event1 $MOD:$FUNC" > kprobe_events
 test -d events/kprobes1/event1 || exit_failure
 
-echo > kprobe_events
+:;: "Remove target module, but event still be there" ;:
+if ! rmmod trace-printk ; then
+  echo "Failed to unload module - please enable CONFIG_MODULE_UNLOAD"
+  exit_unresolved;
+fi
+test -d events/kprobes1/event1
+
+:;: "Check posibility to defining events on unloaded module";:
+echo "p:event2 $MOD:$FUNC" >> kprobe_events
+
+:;: "Target is gone, but we can prepare for next time";:
+echo 1 > events/kprobes1/event1/enable
+
+:;: "Load module again, which means the event1 should be recorded";:
+modprobe trace-printk
+grep "event1:" trace
+
+:;: "Remove the module again and check the event is not locked"
+rmmod trace-printk
+echo 0 > events/kprobes1/event1/enable
+echo "-:kprobes1/event1" >> kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index 321954683aaa..ac9ab4a12e53 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -4,13 +4,16 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-echo 0 > events/enable
-echo > kprobe_events
+# Add new kretprobe event
 echo 'r:testprobe2 _do_fork $retval' > kprobe_events
-grep testprobe2 kprobe_events
+grep testprobe2 kprobe_events | grep -q 'arg1=\$retval'
 test -d events/kprobes/testprobe2
+
 echo 1 > events/kprobes/testprobe2/enable
 ( echo "forked")
+
+cat trace | grep testprobe2 | grep -q '<- _do_fork'
+
 echo 0 > events/kprobes/testprobe2/enable
 echo '-:testprobe2' >> kprobe_events
 clear_trace
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
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
new file mode 100644
index 000000000000..0384b525cdee
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe dynamic event - adding and removing
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+! grep -q 'myevent' kprobe_profile
+echo p:myevent _do_fork > kprobe_events
+grep -q 'myevent[[:space:]]*0[[:space:]]*0$' kprobe_profile
+echo 1 > events/kprobes/myevent/enable
+( echo "forked" )
+grep -q 'myevent[[:space:]]*[[:digit:]]*[[:space:]]*0$' kprobe_profile
+echo 0 > events/kprobes/myevent/enable
+echo > kprobe_events
+! grep -q 'myevent' kprobe_profile
diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
index 5c39ceb18a0d..799da7e0b3c9 100644
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL2.0
 # description: %HERE DESCRIBE WHAT THIS DOES%
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
new file mode 100644
index 000000000000..e3005fa785f0
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Test wakeup tracer
+
+if ! which chrt ; then
+  echo "chrt is not found. This test requires nice command."
+  exit_unresolved
+fi
+
+if ! grep -wq "wakeup" available_tracers ; then
+  echo "wakeup tracer is not supported"
+  exit_unsupported
+fi
+
+echo wakeup > current_tracer
+echo 1 > tracing_on
+echo 0 > tracing_max_latency
+
+: "Wakeup higher priority task"
+chrt -f 5 sleep 1
+
+echo 0 > tracing_on
+grep '+ \[[[:digit:]]*\]' trace
+grep '==> \[[[:digit:]]*\]' trace
+
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
new file mode 100644
index 000000000000..f99b5178e00a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Test wakeup RT tracer
+
+if ! which chrt ; then
+  echo "chrt is not found. This test requires chrt command."
+  exit_unresolved
+fi
+
+if ! grep -wq "wakeup_rt" available_tracers ; then
+  echo "wakeup_rt tracer is not supported"
+  exit_unsupported
+fi
+
+echo wakeup_rt > current_tracer
+echo 1 > tracing_on
+echo 0 > tracing_max_latency
+
+: "Wakeup a realtime task"
+chrt -f 5 sleep 1
+
+echo 0 > tracing_on
+grep "+ \[[[:digit:]]*\]" trace
+grep "==> \[[[:digit:]]*\]" trace
+
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
index 7fd5b4a8f060..f59b2a9a1f22 100644
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
@@ -34,7 +23,7 @@ echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/
 echo 'hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
 echo 'hist:keys=pid,prio,comm:vals=lat:sort=pid,prio' > events/synthetic/wakeup_latency/trigger
 
-ping localhost -c 3
+ping $LOCALHOST -c 3
 if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
     fail "Failed to create inter-event histogram"
 fi
@@ -49,6 +38,4 @@ if grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
     fail "Failed to remove histogram with field variable"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index c93dbe38b5df..524d9ce361e2 100644
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
@@ -48,11 +37,9 @@ echo 'waking+wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking+wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
 echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking+wakeup_latency/trigger
 
-ping localhost -c 3
+ping $LOCALHOST -c 3
 if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
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
index e84e7d048566..39fb65b0cd9f 100644
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
@@ -40,11 +29,10 @@ echo "Test histogram variables,simple expression support and onmatch action"
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
 echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
-ping localhost -c 5
+
+ping $LOCALHOST -c 5
 if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
     fail "Failed to create onmatch action inter-event histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index 7907d8aacde3..81ab3939c96a 100644
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
@@ -40,11 +29,10 @@ echo "Test histogram variables,simple expression support and onmatch-onmax actio
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_comm):onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
 echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
-ping localhost -c 5
+
+ping $LOCALHOST -c 5
 if [ ! grep -q "ping" events/synthetic/wakeup_latency/hist -o ! grep -q "max:" events/sched/sched_switch/hist]; then
     fail "Failed to create onmatch-onmax action inter-event histogram"
 fi
 
-do_reset
-
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 38b7ed6242b2..1180ab5f0845 100644
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
@@ -38,11 +27,10 @@ echo "Test onmax action"
 
 echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_waking/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
-ping localhost -c 3
+
+ping $LOCALHOST -c 3
 if ! grep -q "max:" events/sched/sched_switch/hist; then
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
index 6748e8cb42d0..df246e505af7 100644
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
@@ -47,15 +39,13 @@ test_trace() {
 	fi
 	echo "testing $line for >$x<"
 	match=`echo $line | sed -e "s/>$x<//"`
-	if [ "$line" == "$match" ]; then
+	if [ "$line" = "$match" ]; then
 	    fail "$line does not have >$x< in it"
 	fi
-	let x=$x+2
+	x=$((x+2))
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
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 4665cdbf1a8d..46648427d537 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,28 +1,26 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
+LDLIBS += -lmount -I/usr/include/libmount
+
 TEST_PROGS := gpio-mockup.sh
-TEST_FILES := gpio-mockup-sysfs.sh $(BINARIES)
-BINARIES := gpio-mockup-chardev
-EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
-EXTRA_DIRS := ../gpioinclude/
-EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
-EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
-EXTRA_OBJS += ../gpiolsgpio.o
+TEST_FILES := gpio-mockup-sysfs.sh
+TEST_PROGS_EXTENDED := gpio-mockup-chardev
+
+GPIODIR := $(realpath ../../../gpio)
+GPIOOBJ := gpio-utils.o
 
 include ../lib.mk
 
-all: $(BINARIES)
+all: $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
-	$(RM) $(BINARIES) $(EXTRA_PROGS) $(EXTRA_OBJS)
-	$(RM) -r $(EXTRA_DIRS)
+	$(RM) $(TEST_PROGS_EXTENDED)
+	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
 endef
 
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
-LDLIBS += -lmount -I/usr/include/libmount
-
-$(BINARIES):| khdr
-$(BINARIES): ../../../gpio/gpio-utils.o
+$(TEST_PROGS_EXTENDED):| khdr
+$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
-../../../gpio/gpio-utils.o:
-	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+$(GPIODIR)/$(GPIOOBJ):
+	$(MAKE) OUTPUT=$(GPIODIR)/ -C $(GPIODIR)
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 0c2cdc105f96..a9c4b5e21d7e 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -31,9 +31,9 @@
 /* How many pages to dirty for each guest loop */
 #define  TEST_PAGES_PER_LOOP            1024
 /* How many host loops to run (one KVM_GET_DIRTY_LOG for each loop) */
-#define  TEST_HOST_LOOP_N               32
+#define  TEST_HOST_LOOP_N               32UL
 /* Interval for each host loop (ms) */
-#define  TEST_HOST_LOOP_INTERVAL        10
+#define  TEST_HOST_LOOP_INTERVAL        10UL
 
 /*
  * Guest variables.  We use these variables to share data between host
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6fd8c089cafc..a56ef6b187bb 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -123,7 +123,7 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 
 	/* Allocate memory. */
 	vm = calloc(1, sizeof(*vm));
-	TEST_ASSERT(vm != NULL, "Insufficent Memory");
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
 	vm->mode = mode;
 	vm_open(vm, perm);
diff --git a/tools/testing/selftests/proc/fd-001-lookup.c b/tools/testing/selftests/proc/fd-001-lookup.c
index a2010dfb2110..60d7948e7124 100644
--- a/tools/testing/selftests/proc/fd-001-lookup.c
+++ b/tools/testing/selftests/proc/fd-001-lookup.c
@@ -14,7 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 // Test /proc/*/fd lookup.
-#define _GNU_SOURCE
+
 #undef NDEBUG
 #include <assert.h>
 #include <dirent.h>
diff --git a/tools/testing/selftests/proc/fd-003-kthread.c b/tools/testing/selftests/proc/fd-003-kthread.c
index 1d659d55368c..dc591f97b63d 100644
--- a/tools/testing/selftests/proc/fd-003-kthread.c
+++ b/tools/testing/selftests/proc/fd-003-kthread.c
@@ -14,7 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 // Test that /proc/$KERNEL_THREAD/fd/ is empty.
-#define _GNU_SOURCE
+
 #undef NDEBUG
 #include <sys/syscall.h>
 #include <assert.h>
diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 6e290874b70e..c6bd9a68306b 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:";
+static const char sopts[] = "bdehp:t:Tn:N";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -27,6 +27,9 @@ static const struct option lopts[] = {
 	{"help",                no_argument, NULL, 'h'},
 	{"pingrate",      required_argument, NULL, 'p'},
 	{"timeout",       required_argument, NULL, 't'},
+	{"gettimeout",          no_argument, NULL, 'T'},
+	{"pretimeout",    required_argument, NULL, 'n'},
+	{"getpretimeout",       no_argument, NULL, 'N'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -71,9 +74,13 @@ static void usage(char *progname)
 	printf(" -h, --help          Print the help message\n");
 	printf(" -p, --pingrate=P    Set ping rate to P seconds (default %d)\n", DEFAULT_PING_RATE);
 	printf(" -t, --timeout=T     Set timeout to T seconds\n");
+	printf(" -T, --gettimeout    Get the timeout\n");
+	printf(" -n, --pretimeout=T  Set the pretimeout to T seconds\n");
+	printf(" -N, --getpretimeout Get the pretimeout\n");
 	printf("\n");
 	printf("Parameters are parsed left-to-right in real-time.\n");
 	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
+	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
 }
 
 int main(int argc, char *argv[])
@@ -89,7 +96,13 @@ int main(int argc, char *argv[])
 	fd = open("/dev/watchdog", O_WRONLY);
 
 	if (fd == -1) {
-		printf("Watchdog device not enabled.\n");
+		if (errno == ENOENT)
+			printf("Watchdog device not enabled.\n");
+		else if (errno == EACCES)
+			printf("Run watchdog as root.\n");
+		else
+			printf("Watchdog device open failed %s\n",
+				strerror(errno));
 		exit(-1);
 	}
 
@@ -103,23 +116,27 @@ int main(int argc, char *argv[])
 				printf("Last boot is caused by: %s.\n", (flags != 0) ?
 					"Watchdog" : "Power-On-Reset");
 			else
-				printf("WDIOC_GETBOOTSTATUS errno '%s'\n", strerror(errno));
+				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
 			break;
 		case 'd':
 			flags = WDIOS_DISABLECARD;
 			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
 			if (!ret)
 				printf("Watchdog card disabled.\n");
-			else
-				printf("WDIOS_DISABLECARD errno '%s'\n", strerror(errno));
+			else {
+				printf("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
 			break;
 		case 'e':
 			flags = WDIOS_ENABLECARD;
 			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
 			if (!ret)
 				printf("Watchdog card enabled.\n");
-			else
-				printf("WDIOS_ENABLECARD errno '%s'\n", strerror(errno));
+			else {
+				printf("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
 			break;
 		case 'p':
 			ping_rate = strtoul(optarg, NULL, 0);
@@ -132,8 +149,36 @@ int main(int argc, char *argv[])
 			ret = ioctl(fd, WDIOC_SETTIMEOUT, &flags);
 			if (!ret)
 				printf("Watchdog timeout set to %u seconds.\n", flags);
+			else {
+				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
+			break;
+		case 'T':
+			oneshot = 1;
+			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
+			if (!ret)
+				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
+			else
+				printf("WDIOC_GETTIMEOUT error '%s'\n", strerror(errno));
+			break;
+		case 'n':
+			flags = strtoul(optarg, NULL, 0);
+			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
+			if (!ret)
+				printf("Watchdog pretimeout set to %u seconds.\n", flags);
+			else {
+				printf("WDIOC_SETPRETIMEOUT error '%s'\n", strerror(errno));
+				oneshot = 1;
+			}
+			break;
+		case 'N':
+			oneshot = 1;
+			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
+			if (!ret)
+				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
 			else
-				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
+				printf("WDIOC_GETPRETIMEOUT error '%s'\n", strerror(errno));
 			break;
 		default:
 			usage(argv[0]);

--------------B2E9FF504FE4223AE9D1B8AC--
