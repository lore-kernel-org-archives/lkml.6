Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9041ECDE2C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778332151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778332151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJQOp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:45:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbeJQOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:45:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D1D3AD3C;
        Wed, 17 Oct 2018 06:51:46 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] tracing: Export trace_dump_stack to modules
Date:   Wed, 17 Oct 2018 09:51:43 +0300
Message-Id: <1539759103-5923-1-git-send-email-nborisov@suse.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for this function to be unexprted and it's a useful
debugging aid.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bf6f1d70484d..15c7a7d01505 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2727,6 +2727,7 @@ void trace_dump_stack(int skip)
 	__ftrace_trace_stack(global_trace.trace_buffer.buffer,
 			     flags, skip, preempt_count(), NULL);
 }
+EXPORT_SYMBOL_GPL(trace_dump_stack);
 
 static DEFINE_PER_CPU(int, user_stack_count);
 
-- 
2.7.4

