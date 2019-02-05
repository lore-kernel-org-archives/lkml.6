Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A22DC282E1
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200062175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549406567;
	bh=ZrMDhspZRqsHQCgIRprU3Q2jciZ8eMIG6Ar+7cGmCjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=nVRALf17fqfdWtHszVueCGzoaUzqnsBAXzL1sPUZr1BaQ1emiIq6u36mhHbmJU/e0
	 qDKnnQTSRfwt/nmcEb4UnqUrcqg+B65J4tqacOEET/b8ngeAkmLdN3QYHbbRzbqhop
	 HF0MZASaCj7UQp8uG2yOJ9stEm4FhApuj60w7+ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfBEWmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbfBEWm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:42:29 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6807C218D9;
        Tue,  5 Feb 2019 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549406548;
        bh=ZrMDhspZRqsHQCgIRprU3Q2jciZ8eMIG6Ar+7cGmCjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IOSLq/xIO6vBoyBWcV71Xfqoh97RBgvkOSCFCAIfrtoAQhpGyPXolVv6Jti2xx5kp
         5GL9psdiPgRoYKWvz0uakoLwXIoeKGaj3pheY5u7Q0XcwXTz1NWqWrTh0KclHsopya
         v+nKyaCP0VXBZeSvg8Uj/g40ddo0bSCoYtOAsDm8=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v14 14/15] tracing: Add alternative synthetic event trace action test case
Date:   Tue,  5 Feb 2019 16:42:00 -0600
Message-Id: <07c0d1acc5b49b814347575ed78d8c6cd51535d2.1549403369.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case for the alternative trace(<synthetic_event, params)
synthetic event generation syntax.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../inter-event/trigger-trace-action-hist.tc       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
new file mode 100644
index 000000000000..8021d60aafec
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger trace action
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+if [ ! -f set_event ]; then
+    echo "event tracing is not supported"
+    exit_unsupported
+fi
+
+if [ ! -f synthetic_events ]; then
+    echo "synthetic event is not supported"
+    exit_unsupported
+fi
+
+grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
+
+echo "Test create synthetic event"
+
+echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+if [ ! -d events/synthetic/wakeup_latency ]; then
+    fail "Failed to create wakeup_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event using trace action"
+echo "Test histogram variables,simple expression support and trace action"
+
+echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_wakeup).trace(wakeup_latency,$wakeup_lat,next_pid,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=comm,pid,lat:wakeup_lat=lat:sort=lat' > events/synthetic/wakeup_latency/trigger
+
+ping $LOCALHOST -c 5
+
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create trace action inter-event histogram"
+fi
+
+exit 0
-- 
2.14.1

