Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965045AbeE2P11 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935533AbeE2PXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:31 -0400
Message-Id: <20180529152327.515727542@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 11/19] tracing: Allow histogram triggers to access ftrace internal events
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0011-tracing-Allow-histogram-triggers-to-access-ftrace-in.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that trace_marker can have triggers, including a histogram triggers, the
onmatch() and onmax() access the trace event. To do so, the search routine
to find the event file needs to use the raw __find_event_file() that does
not filter out ftrace events.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b9061ed59bbd..046c716a6536 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2865,7 +2865,7 @@ static struct trace_event_file *event_file(struct trace_array *tr,
 {
 	struct trace_event_file *file;
 
-	file = find_event_file(tr, system, event_name);
+	file = __find_event_file(tr, system, event_name);
 	if (!file)
 		return ERR_PTR(-EINVAL);
 
-- 
2.17.0
