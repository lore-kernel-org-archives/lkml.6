Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELt4S5Z1TjfLYkxfrvWMwWo65fzDBB5SzvBXFv1Q5dk10lzlQIeU2VuK6A2Acn7pNWwfjQvu
ARC-Seal: i=1; a=rsa-sha256; t=1521290384; cv=none;
        d=google.com; s=arc-20160816;
        b=GizAvICwA4ZyvDuwGxCcFrpNzYxFdMCOb6OrRpAbzpN1/Ml2ku32i1cAlqB5l1vZsX
         aWmSybeBIkDvDEz/JUDJoQ0867gvISZThOezcq2CCQXceqzRB+9MXtaSBIWI+1l3Qw9H
         56hGXcSF7wrbHVbmPa8IvDzUWKdocPclpLxkPz7zO7oWndjYORaPjmmUHpXUFlFItWYJ
         KHVkPiCOJ9Gku35JLLL6MMhe18VMcfSaSLlLI2iE3akzKlZiqkJ0vYU3JNFqn7UiFuWK
         3lm76NzmXO0tAy6TisAdnxPksVPpCATxrru4t14uYC6//4nC8MQ4aAnuc0EZvWKd6az/
         E5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=My0Y7cjct5gMcofuRdT/TMuxdaCuuwcOCok22TdhQvA=;
        b=U05xu/Ddl3gXEaUxws9jE0lLs2vHIXrOvRLIjvHNuHZQHp3s9nCdhT48ly3XR36Z3M
         Q4HCwGo/tmOdeQn/n3OVw+6Lo1hR3ELH8i4F205fDHy9xjXD7YA7JM/b+PJUjx9o6dfV
         JNvTn4FX/ZzA9MzDCt6zYqxJfu3TuyGBrLzi3CxNvXoBmzM9f4GLlWNtarvOJm7mmupK
         kxDiAQ2riWKzlBrzuUtLG/jTUHC2lAjeMrlCJW7z8WH2pMw5BPqmtUhUjypCo7Uhpzx1
         UcB+5sFims/mKdHmv+qBUhogOt+KEKZERooX4eGBzA8bzwmBlLNe1ddwuW0Tq1Hx1UkV
         Vm5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeCQMjn (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752170AbeCQMjn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:39:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73FF204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 02/21] selftests: ftrace: Add probe event argument syntax testcase
Date: Sat, 17 Mar 2018 21:38:56 +0900
Message-Id: <152129033679.31874.12705519603869152799.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152129024033.31874.15800253385376959274.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188586323914745?=
X-GMAIL-MSGID: =?utf-8?q?1595188586323914745?=
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

