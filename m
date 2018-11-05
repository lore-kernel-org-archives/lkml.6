Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79781C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE5E20868
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zQIiFrK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE5E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeKESXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:23:33 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9136E2082A;
        Mon,  5 Nov 2018 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408692;
        bh=Btueh1B269AJS1dsvHd0mnWJ1hTMy7pUZg/NG7ISutk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQIiFrK56Y0FUJjpUuSwbI+KL4ZNRI4rRJEG408WNao3fHdD9R/xf+xsPGeR+Zf9D
         LlirRkqBKb2Rkpicdt5ZGOrklDjEjDPsu32gq5bXKvlgOvh4M4iEItPWj+Jzit06Km
         kRuZCxbF9r0vII/dlXJNU4uxtqaeDGWSwWAYlVRE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 10/12] tracing: Remove orphaned trace_add/remove_event_call functions
Date:   Mon,  5 Nov 2018 18:04:29 +0900
Message-Id: <154140866955.17322.2081425494660638846.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154140838606.17322.15294184388075458777.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trace_add_event_call() and trace_remove_event_call()
functions since those are not used anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/trace_events.h |    2 --
 kernel/trace/trace_events.c  |   26 ++------------------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3aa05593a53f..7a3147ead6bf 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -531,8 +531,6 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 			      int is_signed, int filter_type);
 extern int trace_add_event_call_nolock(struct trace_event_call *call);
 extern int trace_remove_event_call_nolock(struct trace_event_call *call);
-extern int trace_add_event_call(struct trace_event_call *call);
-extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a3b157f689ee..16cff7c0fd40 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2305,6 +2305,7 @@ __trace_early_add_new_event(struct trace_event_call *call,
 struct ftrace_module_file_ops;
 static void __add_event_to_tracers(struct trace_event_call *call);
 
+/* Add an additional event_call dynamically */
 int trace_add_event_call_nolock(struct trace_event_call *call)
 {
 	int ret;
@@ -2320,17 +2321,6 @@ int trace_add_event_call_nolock(struct trace_event_call *call)
 	return ret;
 }
 
-/* Add an additional event_call dynamically */
-int trace_add_event_call(struct trace_event_call *call)
-{
-	int ret;
-
-	mutex_lock(&event_mutex);
-	ret = trace_add_event_call_nolock(call);
-	mutex_unlock(&event_mutex);
-	return ret;
-}
-
 /*
  * Must be called under locking of trace_types_lock, event_mutex and
  * trace_event_sem.
@@ -2376,7 +2366,7 @@ static int probe_remove_event_call(struct trace_event_call *call)
 	return 0;
 }
 
-/* no event_mutex version */
+/* Remove an event_call */
 int trace_remove_event_call_nolock(struct trace_event_call *call)
 {
 	int ret;
@@ -2392,18 +2382,6 @@ int trace_remove_event_call_nolock(struct trace_event_call *call)
 	return ret;
 }
 
-/* Remove an event_call */
-int trace_remove_event_call(struct trace_event_call *call)
-{
-	int ret;
-
-	mutex_lock(&event_mutex);
-	ret = trace_remove_event_call_nolock(call);
-	mutex_unlock(&event_mutex);
-
-	return ret;
-}
-
 #define for_each_event(event, start, end)			\
 	for (event = start;					\
 	     (unsigned long)event < (unsigned long)end;		\

