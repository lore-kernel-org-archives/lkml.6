Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x22706QEkKttP+Bkz9Sj4yeA+pGfIKvUJEyJh1IdnRhl3/OjiTLGF8Vn0Efxf3XQuVO7LVpu1
ARC-Seal: i=1; a=rsa-sha256; t=1519450187; cv=none;
        d=google.com; s=arc-20160816;
        b=cZFgWovZX2hLOqjDqw7Esi8tl0fFyiVwRC6m3iCn561YJ8ENjIxjSGbjf87hdCW0QM
         9xqayOmKh17lLz6PbARrTCmdnfmSPYtPdl+syBPfbUdtNe9OlEXSKdQL/uK3nepKRg7X
         cqxag5TVHj2OGIHLBcFFneJvY0f5BDkenbCMzv2fBY8wdeT6BnxvGO+O07GAGJUjnAg9
         BEDYrXz9xOotGI2UOe5S/8rpIUx2M0bhFFLBQcNTIoMlUsfhQRJZExMHai1M/HcEAxnE
         fSECH/GrW1SIatHG4y7AOz0nvkMnpF3lgwaflHOAVqusRRXChMs2drmzDju9xnENjs8L
         iHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=My0Y7cjct5gMcofuRdT/TMuxdaCuuwcOCok22TdhQvA=;
        b=f+c0+2uHT9Urvo4dIDRCINlpUp98AL9LpbkNlIuLZXSN5Q3vk9vvtWXm3S7fHg7Ubm
         l9rJThSQYgiW18nqa3JbDUmJZ02prMoW06g8E4B/6ViVUNXFk0u+BYmbjKsGWXaG9hly
         1YvQwiI76uJscMESZvCllsyLG27VkwheSZmguao+RUO6x0+e6PjwSvM+Z39yG9mxQdQH
         3PO36A9bYStouJ6BEOjSCGr0TvGU2FGGmYH3rrGIqRPb3reN9T+h2gCGndVNglFnT6yW
         l+iM8Zl/SJfjnPuFfsQmfC89I5FN3PJmb/I+QldfxB9cZWCkM4ahVi6NnEla36AGVwhz
         4ysw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeBXF3q (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbeBXF3p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:29:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BCF21741
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
Subject: [PATCH v3 02/18] selftests: ftrace: Add probe event argument syntax testcase
Date: Sat, 24 Feb 2018 14:29:21 +0900
Message-Id: <151945016181.27508.3999524130112838660.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151945010287.27508.6226184958678620828.stgit@devbox>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593258999265547236?=
X-GMAIL-MSGID: =?utf-8?q?1593258999265547236?=
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

