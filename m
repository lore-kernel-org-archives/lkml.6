Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED975C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A351520844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzfWBx3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A351520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbeGZOAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeGZOAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:00:40 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FE52083F;
        Thu, 26 Jul 2018 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532609039;
        bh=X66FmPTPYJDPEKW52jWzhIo9km+WW/w2YsrxfmLx4O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzfWBx3byqxn3pjQwqp8A9g9DKFrrOYcSKYcS8CxNrMwtNS4gKrthvDTyJXVToNEv
         dl+a1S27wLfKWD+KnlFNkRKMqX7fs6Q5GURUBRoYa02T/2QQ/7DGZdsQdCXts/OS+U
         H3UMdxwzT2ijU0O5EbYBQ/9KrfHKFISjZSo9KqtI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/3] doc: tracing: Fix a typo of trace_stat
Date:   Thu, 26 Jul 2018 21:43:36 +0900
Message-Id: <153260901588.12474.13361141902967649729.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153260898648.12474.8316095450186108842.stgit@devbox>
References: <153260898648.12474.8316095450186108842.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the directory for per-cpu function statistics
is trace_stat, not trace_stats.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 0 files changed

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index a20d34955333..7ea16a0ceffc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -329,9 +329,9 @@ of ftrace. Here is a list of some of the key files:
 	track of the time spent in those functions. The histogram
 	content can be displayed in the files:
 
-	trace_stats/function<cpu> ( function0, function1, etc).
+	trace_stat/function<cpu> ( function0, function1, etc).
 
-  trace_stats:
+  trace_stat:
 
 	A directory that holds different tracing stats.
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..a47f77d27673 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -521,7 +521,7 @@ config FUNCTION_PROFILER
 	  in debugfs called function_profile_enabled which defaults to zero.
 	  When a 1 is echoed into this file profiling begins, and when a
 	  zero is entered, profiling stops. A "functions" file is created in
-	  the trace_stats directory; this file shows the list of functions that
+	  the trace_stat directory; this file shows the list of functions that
 	  have been hit and their counters.
 
 	  If in doubt, say N.

