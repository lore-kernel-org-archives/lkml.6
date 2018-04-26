Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756954AbeDZRcG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754556AbeDZRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F75F217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173201.618146136@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Todd Poynor <toddpoynor@google.com>,
        Ahbong Chang <cwahbong@google.com>
Subject: [PATCH 1/7] tracing: Add missing forward declaration
References: <20180426173039.426131207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-tracing-Add-missing-forward-declaration.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahbong Chang <cwahbong@google.com>

Without this forward declaration compile may fail if this header is
included only for registering other probe event without struct
pool_workqueue.

Link: http://lkml.kernel.org/r/20180416023626.139915-1-cwahbong@google.com

Reviewed-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Ahbong Chang <cwahbong@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/workqueue.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 2f057a494d93..9a761bc6a251 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -25,6 +25,8 @@ DECLARE_EVENT_CLASS(workqueue_work,
 	TP_printk("work struct %p", __entry->work)
 );
 
+struct pool_workqueue;
+
 /**
  * workqueue_queue_work - called when a work gets queued
  * @req_cpu:	the requested cpu
-- 
2.16.3
