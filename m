Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C7C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30A7218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjeE2ENw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfAAPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 10:47:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46894 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfAAPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 10:47:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so13557481ply.13;
        Tue, 01 Jan 2019 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L2UqHaQcHB3jJg5m5medN000xUlZ4oCMNEmDX29sj3c=;
        b=sjeE2ENwjMr9+TeArMw+DqfFRmVbTvdH02DzAKkCsSsF6MlLUZAIlADNCpX3hT4TDj
         KpnIZ2ARlpDKC2EH1HbgWDYCrgebW3cvi654WWP1PTvTolFRxa4fkivhvtPd6xTPley1
         1zTC+H+vCPmFaITxLFFEFIhA4hvqdhU1enYpkdmrx+txZGl7TM9MOO3dmXZA8Yn5zhAt
         pK5rd+0en+p+Dyv9IeYTFt39RrfcFFXiKBgJHdMsCfl1DD4hd4K4fmXRq6iiMmH/Jl0a
         hmdQmunAwwFbkxeWvOccJBJAU25ePEdEOpYBKQYd9Cupq31Ivt9Yqb9P8x+JyHUC93Lx
         oUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L2UqHaQcHB3jJg5m5medN000xUlZ4oCMNEmDX29sj3c=;
        b=KSZWXqy7UG2sZgU3JJ4tLpWOS7nKOo+GFMAGSJMj/8Z9zHR8z45d6DOEqG0i1gKWmE
         DR9siWR6yOlLYjYRuLVId/3DrztyQKt3K+/zhOz88fLfwGgb4mhtKrq/A2sRlsr95U1c
         q7sdWuH7KEpIZRmYvgam3/ikFI6quz2HKQCFkcl+3VGxuQLhxbhDtr+orpLHA+xzE7Fs
         7etyKDmtIUOM6JBTNJVGk88K7urTJfUlM3IjEx1eonYYqU0olw+qOX54giaQ7WT/4+wS
         rGIA+3BbW9hAtH+HHtbnY3pPVMwEjNkxIOlW+X4AGDcs6xYj5+1dfcz0IdXMkNSDK2vF
         Sm2w==
X-Gm-Message-State: AJcUukfeFeeBSI+UIjAzaIjz9qhlsBIkNb3hNtqIwtwJeklmd7+L/Y+V
        zbw+NqZutyFc/fFE3IX48No=
X-Google-Smtp-Source: ALg8bN5N3KiHESm2K3oPkL6yZlXCGXcpRLegf/EomrByuLuvHIIZ3xi/I1pgBfb77efyoAzrObyy6A==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr40814896plr.153.1546357664195;
        Tue, 01 Jan 2019 07:47:44 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id m3sm84122386pff.173.2019.01.01.07.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 07:47:43 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 2/5] sched/tracing: Show more info for funcgraph wakeup tracers
Date:   Tue,  1 Jan 2019 23:46:11 +0800
Message-Id: <20190101154614.8887-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101154614.8887-1-changbin.du@gmail.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add these info fields to funcgraph wakeup tracers:
  o Show CPU info since the waker could be on a different CPU.
  o Show function duration and overhead.
  o Show IRQ markers.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_sched_wakeup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index b6c5fa10347e..da5b6e012840 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -180,8 +180,11 @@ static void wakeup_trace_close(struct trace_iterator *iter)
 }
 
 #define GRAPH_TRACER_FLAGS (TRACE_GRAPH_PRINT_PROC | \
+			    TRACE_GRAPH_PRINT_CPU |  \
 			    TRACE_GRAPH_PRINT_REL_TIME | \
-			    TRACE_GRAPH_PRINT_DURATION)
+			    TRACE_GRAPH_PRINT_DURATION | \
+			    TRACE_GRAPH_PRINT_OVERHEAD | \
+			    TRACE_GRAPH_PRINT_IRQS)
 
 static enum print_line_t wakeup_print_line(struct trace_iterator *iter)
 {
-- 
2.17.1

