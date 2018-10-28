Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E922ECDE47
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0829C20880
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0829C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeJ1QP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeJ1QPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640B22145D;
        Sun, 28 Oct 2018 07:31:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXs-0008AB-Ea; Sun, 28 Oct 2018 03:31:36 -0400
Message-Id: <20181028073136.354179382@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:30:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [for-next][PATCH 17/18] tracing: Export trace_dump_stack to modules
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

There is no reason for this function to be unexprted and it's a useful
debugging aid.

Link: http://lkml.kernel.org/r/1539759103-5923-1-git-send-email-nborisov@suse.com

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec5b21778806..ff1c4b20cd0a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2727,6 +2727,7 @@ void trace_dump_stack(int skip)
 	__ftrace_trace_stack(global_trace.trace_buffer.buffer,
 			     flags, skip, preempt_count(), NULL);
 }
+EXPORT_SYMBOL_GPL(trace_dump_stack);
 
 static DEFINE_PER_CPU(int, user_stack_count);
 
-- 
2.19.0


