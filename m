Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kMizGd+XGVvPfAAAmS7hNA
	; Thu, 07 Jun 2018 20:39:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 271526074D; Thu,  7 Jun 2018 20:39:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHAJiPOk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 61CCD60452;
	Thu,  7 Jun 2018 20:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61CCD60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeFGUjH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:39:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35371 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932609AbeFGUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:39:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id i5-v6so6860337plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=441C7lwFc1IlCq9sxMR+Pf6T5lduVGISOUsJh5XbCc4=;
        b=WHAJiPOkTvFkFRKr+Ww6OnubbGHxnmgYilTbBomKCI/Jh0pHyA5mPnF8YSLwsyypAw
         JYWhXQulkwTREmqYImG0+OLzZMUlONAIqBKpv7snM6K89M4cZarGviHumV4l+AJGnZWe
         lqd7iJF8XJ/Lcgv3l7TDHz4pOtXMxLxLEF5Iqu2za8SCWMrAbmo8ocsAeMJxGF+0H5IH
         m/GfX58RHHsgCBhl0qYrM2RijjUe3Fahm9hsQeANZeLxbOQdZ12hXsxLlVh7b3i5Qr3H
         1v7Jo4sFh6w8teZ7x8O7lqrldH3UoXVpEOuNMykB62lf3mnc8OHu/6r5axCMEVNDkGdT
         nEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=441C7lwFc1IlCq9sxMR+Pf6T5lduVGISOUsJh5XbCc4=;
        b=Z7ORjegZdMi+dp/a7cw7ynGy4W83qu0HeMKBMl/UwfKbyr7DZ2ZHLLZEN4UT/n8Jjn
         cAHKG1RqtHmPAthcZiCPeueXAWb90qhWrc2BpYsVbHsxc4L0TYnZOstkAJdcvVu3jZBO
         q/A2aZ6ResCdGmepcBNsJG3t9+bL0a4g9bK6hM/FdKQEHxEU1ppzSICJDYhoeyrS4LD3
         X6OtYBD+bLVoIx6048kv3Li7/OuJcUe+7gSETY8vwkBK+obFAWPjwfqWy8xP2/36EPbh
         MGbolGOzA1X6qdpg8uShygEBKm0XslCpbDFPPicnZV5fOKVBtxrObmCfsaB9djYV/5Jg
         OQ/Q==
X-Gm-Message-State: APt69E2rMEzbCUbPNznI9WVRt1LqSQ0QlNjrIPSJdFN+HjfaPT0QjlDI
        Oq3FWHuu1zFJ1SYM+LPNFsopdbxG6jw=
X-Google-Smtp-Source: ADUXVKLwt1oz9Go8sOFkH39wGl+4A3C6DppxaZFVhv0xT+ov1DO7tED7ZcLVO4dnHTDEe+3NvFycUw==
X-Received: by 2002:a17:902:d697:: with SMTP id v23-v6mr3501608ply.193.1528403939191;
        Thu, 07 Jun 2018 13:38:59 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v27-v6sm10324174pfi.23.2018.06.07.13.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:38:58 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 7/7] kselftests: Add tests for the preemptoff and irqsoff tracers
Date: Thu,  7 Jun 2018 13:38:15 -0700
Message-Id: <20180607203815.255845-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607203815.255845-1-joel@joelfernandes.org>
References: <20180607203815.255845-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Here we add unit tests for the preemptoff and irqsoff tracer by using a
kernel module introduced previously to trigger atomic sections in the
kernel.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index b01924c71c09..29588b328345 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_IRQSOFF_TRACER=y
+CONFIG_TEST_ATOMIC_SECTIONS=m
diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
new file mode 100644
index 000000000000..1764ff22c02b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
@@ -0,0 +1,74 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: test for the preemptirqsoff tracer
+
+MOD=test_atomic_sections
+
+fail() {
+    reset_tracer
+    rmmod $MOD || true
+    exit_fail
+}
+
+unsup() { #msg
+    reset_tracer
+    rmmod $MOD || true
+    echo $1
+    exit_unsupported
+}
+
+modprobe $MOD || unsup "$MOD module not available"
+rmmod $MOD
+
+grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
+grep -q "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
+
+reset_tracer
+
+# Simulate preemptoff section for half a second couple of times
+echo preemptoff > current_tracer
+sleep 1
+modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: preemptoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+
+# Simulate irqsoff section for half a second couple of times
+echo irqsoff > current_tracer
+sleep 1
+modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
+rmmod test_atomic_sections || fail
+
+cat trace
+
+# Confirm which tracer
+grep -q "tracer: irqsoff" trace || fail
+
+# Check the end of the section
+egrep -q "5.....us : <stack trace>" trace || fail
+
+# Check for 500ms of latency
+egrep -q "latency: 5..... us" trace || fail
+
+reset_tracer
+exit 0
+
-- 
2.17.1.1185.g55be947832-goog
