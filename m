Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1711EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D140E2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409793;
	bh=wNXpEvHfF8L0Pgc8OIMtZCLN2O99PXMpLp2xLuYBUGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=oMO81RZH9lp6Vy91qxDVxlSGvSOsbzZf/zcFGBKQiMf98fFEMEN/QSf/Uy6Sq+3oS
	 aAc47N7ZIdbWYy7F/9ZgtPnv3AQ4yIDI7/mN6kasapIiBeZg+K0niTvEiCSrZ/UgVh
	 NKYQbjJzOWkvVQTxBwQmZVJAlKftzrpGj/rcXt9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbeLUQ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:29:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404290AbeLUQ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:29:46 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C299821928;
        Fri, 21 Dec 2018 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409785;
        bh=wNXpEvHfF8L0Pgc8OIMtZCLN2O99PXMpLp2xLuYBUGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MrBEYyMB1yNw5+BcH8cnD23ZFvau6ISlPy/A/pmUzvvyjrK4WM/2I/ZJpty/oywU/
         DI7udohJBvIqZHkibwMUIc0HyEj72OaI6IOblBfGpbG8Q3GKP5mKoQ4DfyUaSKMyiW
         pkXDO6w+mxRqEAexhcDQC8zwi3x7xY4Na6ljszto=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v10 15/15] tracing: Add hist trigger action 'expected fail' test case
Date:   Fri, 21 Dec 2018 10:29:14 -0600
Message-Id: <b4a712716b1b94d487cf9811475a3b8702ed4cb5.1545408962.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545408962.git.tom.zanussi@linux.intel.com>
References: <cover.1545408962.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545408962.git.tom.zanussi@linux.intel.com>
References: <cover.1545408962.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a test case verifying that basic action combinations fail as
expected.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../inter-event/trigger-action-hist-xfail.tc       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
new file mode 100644
index 000000000000..1221240f8cf6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger expected fail actions
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
+if [ ! -f snapshot ]; then
+    echo "snapshot is not supported"
+    exit_unsupported
+fi
+
+grep -q "snapshot()" README || exit_unsupported # version issue
+
+echo "Test expected snapshot action failure"
+
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+
+echo "Test expected save action failure"
+
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+
+exit_xfail
-- 
2.14.1

