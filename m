Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AA8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866520657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2I146kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405067AbfAPQDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:03:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46174 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404786AbfAPQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:03:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so2991802pgp.13;
        Wed, 16 Jan 2019 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7tvUhaOMr6fMd4OHfKBrsZQZNY2iWRK7ENGLWPCFLt0=;
        b=V2I146kWq5TINmXj0tIRTIFNm0UI+2nMgzKLlX9KbU91Ld4NVFKSlkYQpnrd6qKkZd
         xmzcJpddBIdS9N6rZcEvd0px6IeTusvomWgtHWZk8r2/dXLjQgf36P+3ZhJjTt+n3SST
         jUxI0W2xzXy3lvBSUninHJ1xBbG8OQOjR6pRMoJCbrTwg4qe5DgzaSu1izfTjQd0ilLj
         LgyLa9nwhYSK/Xw+xjHJmRKuImuz35v1J7qhTnv7lqF6RK4xxECf6D2prsbiYN7qmtou
         0BZ+0w0SWKdzBW/bI3oNyIDiQQSmrgH8fC9ETVSvwsDXIOkwnKwh5MN1v8QThPWwD4DJ
         H/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7tvUhaOMr6fMd4OHfKBrsZQZNY2iWRK7ENGLWPCFLt0=;
        b=czLsH4o2qGbF4fOGWT4mMB2Rp3azAlGotjk2qeKKPcvdULyR/V2CtzlxJ1YuvTLB+8
         8T9W+1Vt6O2MwwuYYWMSha4ktoixbpowtPBkfuiZ9DaSO7GtjAvTrVWbXIYuisvkG/Jn
         pxKjS/tmspyj20etTb5EtRTH4/dvme9MiPKWtgEOgBin2XUmrfzmj0YrOxev9sDhuIiI
         ZgBiLUL8qrKF2e7E3deyBMiOvvyJ9flSsmmop7kpIfIlswPOhYZveET01RbfhbRiCA4q
         n4nA66HPTWOmEUOByTtdwrvhH9EAg/ed2IVO3dEdmjq1br86wqsE7sDcEc3Uj6kgDcZ1
         Zr8g==
X-Gm-Message-State: AJcUukeGkZEiq/SRc4uLUmXFJ+g6xwziVfnTOtd3MbfBgbheOmexs4UC
        XZ17+sntUfMl5j+9xHhGbCE=
X-Google-Smtp-Source: ALg8bN7UHhfC1Y6iel0WKoAul95Y3GKO2dbCrd3hQ/vZSSeh6SfX4Q2buhhbbOxyknc4gVbp2NJ/vw==
X-Received: by 2002:a63:4819:: with SMTP id v25mr9456809pga.308.1547654589959;
        Wed, 16 Jan 2019 08:03:09 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id 184sm8714938pfe.106.2019.01.16.08.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:03:09 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] sched/tracing: Show stacktrace for wakeup tracers
Date:   Thu, 17 Jan 2019 00:02:49 +0800
Message-Id: <20190116160249.7554-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This align the behavior of wakeup tracers with irqsoff latency tracer
that we record stacktrace at the beginning and end of waking up. The
stacktrace shows us what is happening in the kernel.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_sched_wakeup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index da5b6e012840..f4fe7d1781e9 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -475,6 +475,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 
 	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
 	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
+	__trace_stack(wakeup_trace, flags, 0, pc);
 
 	T0 = data->preempt_timestamp;
 	T1 = ftrace_now(cpu);
@@ -586,6 +587,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	data = per_cpu_ptr(wakeup_trace->trace_buffer.data, wakeup_cpu);
 	data->preempt_timestamp = ftrace_now(cpu);
 	tracing_sched_wakeup_trace(wakeup_trace, p, current, flags, pc);
+	__trace_stack(wakeup_trace, flags, 0, pc);
 
 	/*
 	 * We must be careful in using CALLER_ADDR2. But since wake_up
-- 
2.17.1

