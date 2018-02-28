Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226rkDayBi2a9Z6br8s9zznKcr1TO94ZBvJerZ8khHxPRop+/01D4Lj1A0EC/k4X+rEPwxa6
ARC-Seal: i=1; a=rsa-sha256; t=1519788053; cv=none;
        d=google.com; s=arc-20160816;
        b=M1Dx3mujbQrqJ2KxG+0SPN8L5byKl8f8lmuu36Ww16I5ms0eQF0eIK8La9shYpWrWA
         0mXZQHDlC4BVFXTWRANIoBRA/VJSPwOG95L7mid7vDAzuMtmBLBL1e0ZrCSWyJw+xvTX
         /Gn+X7ARTl+KcZ6vpnAfu7SgFQeNoBrdSuPYrbtrvkH84FTYOfEtZh+Y7mRWpOA+hTW4
         +rV9/OYDe3skWlf+7IW6mkt+6g35kqsRELwEam6qmOuZiSJzz987nz43e70ZkP/arh3P
         /8M7GnnZVWLNSRena4DBlX30u9vWjgDf6K2j0WqztbkjqISOPUKDmCuPrAEcC6mIAdHQ
         fe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=My0Y7cjct5gMcofuRdT/TMuxdaCuuwcOCok22TdhQvA=;
        b=w8zTCxmu/fR5tF7dXzZKkdxMVQ4DWChJYPTQ6cx4izr+51ssSUCrYfiOsbXP4UHfle
         MxcqceLCv6BbtUVlA+g82yclDErPwtpOfMXUYAEpAdMON3nQiiSPj1ISOxDahZW6aMGB
         95Jmyd5EgsiwMXscOCm/Ka/Flpyk0PapR6F+uoQRNn4FGkgIngfxNL+DseWG4d8AAuUm
         aIDlPU+NXfyAo6rBT4Wzis0GL99y2hKjcLsVg91q6mXo4N0tcxFQ5V0GraWhOihA0wD5
         S9OC2Of1uwiaTbf2M8/aOD49Jbs4+ZclhamLU5bQrz8S9xrK4m2T1j0dVpb92hg8EU0V
         hcFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeB1DUw (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeB1DUv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:20:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D212168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v4 02/19] selftests: ftrace: Add probe event argument syntax testcase
Date: Wed, 28 Feb 2018 12:20:27 +0900
Message-Id: <151978802778.2577.5286123406668496097.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151978796240.2577.6531711990653677529.stgit@devbox>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613277805544078?=
X-GMAIL-MSGID: =?utf-8?q?1593613277805544078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a testcase for probe event argument syntax which
ensures the kprobe_events interface correctly parses
given event arguments.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   97 ++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
new file mode 100644
index 000000000000..231bcd2c4eb5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -0,0 +1,97 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event argument syntax
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
+
+echo 0 > events/enable
+echo > kprobe_events
+
+PROBEFUNC="vfs_read"
+GOODREG=
+BADREG=
+GOODSYM="_sdata"
+if ! grep -qw ${GOODSYM} /proc/kallsyms ; then
+  GOODSYM=$PROBEFUNC
+fi
+BADSYM="deaqswdefr"
+SYMADDR=0x`grep -w ${GOODSYM} /proc/kallsyms | cut -f 1 -d " "`
+GOODTYPE="x16"
+BADTYPE="y16"
+
+case `uname -m` in
+x86_64|i[3456]86)
+  GOODREG=%ax
+  BADREG=%ex
+;;
+aarch64)
+  GOODREG=%x0
+  BADREG=%ax
+;;
+arm*)
+  GOODREG=%r0
+  BADREG=%ax
+;;
+esac
+
+test_goodarg() # Good-args
+{
+  while [ "$1" ]; do
+    echo "p ${PROBEFUNC} $1" > kprobe_events
+    shift 1
+  done;
+}
+
+test_badarg() # Bad-args
+{
+  while [ "$1" ]; do
+    ! echo "p ${PROBEFUNC} $1" > kprobe_events
+    shift 1
+  done;
+}
+
+echo > kprobe_events
+
+: "Register access"
+test_goodarg ${GOODREG}
+test_badarg ${BADREG}
+
+: "Symbol access"
+test_goodarg "@${GOODSYM}" "@${SYMADDR}" "@${GOODSYM}+10" "@${GOODSYM}-10"
+test_badarg "@" "@${BADSYM}" "@${GOODSYM}*10" "@${GOODSYM}/10" \
+	    "@${GOODSYM}%10" "@${GOODSYM}&10" "@${GOODSYM}|10"
+
+: "Stack access"
+test_goodarg "\$stack" "\$stack0" "\$stack1"
+test_badarg "\$stackp" "\$stack0+10" "\$stack1-10"
+
+: "Retval access"
+echo "r ${PROBEFUNC} \$retval" > kprobe_events
+! echo "p ${PROBEFUNC} \$retval" > kprobe_events
+
+: "Comm access"
+test_goodarg "\$comm"
+
+: "Indirect memory access"
+test_goodarg "+0(${GOODREG})" "-0(${GOODREG})" "+10(\$stack)" \
+	"+0(\$stack1)" "+10(@${GOODSYM}-10)" "+0(+10(+20(\$stack)))"
+test_badarg "+(${GOODREG})" "(${GOODREG}+10)" "-(${GOODREG})" "(${GOODREG})" \
+	"+10(\$comm)" "+0(${GOODREG})+10"
+
+: "Name assignment"
+test_goodarg "varname=${GOODREG}"
+test_badarg "varname=varname2=${GOODREG}"
+
+: "Type syntax"
+test_goodarg "${GOODREG}:${GOODTYPE}"
+test_badarg "${GOODREG}::${GOODTYPE}" "${GOODREG}:${BADTYPE}" \
+	"${GOODTYPE}:${GOODREG}"
+
+: "Combination check"
+
+test_goodarg "\$comm:string" "+0(\$stack):string"
+test_badarg "\$comm:x64" "\$stack:string" "${GOODREG}:string"
+
+echo > kprobe_events

