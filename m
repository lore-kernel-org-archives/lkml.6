Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163B8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EF0218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQZRDhFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfAAPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 10:47:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46756 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfAAPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 10:47:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so14164999pfe.13;
        Tue, 01 Jan 2019 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nuCVJ/9FRKM73Wwlsp/YZ3g94ydYvMBaX8LRNO6g3d8=;
        b=BQZRDhFUKAG0AXxIhKodg+DSUGhTL1Htv1Wme2bqT75KZ+jL24qgNfFZsAqZHsP6oS
         f5X0rvFUBa3FuR9TFYA2DertGSp6E6Kxny3jY15ewuzK1b5M/Lknbp7scUtuP8AeljLt
         N3pwV/6V8NdegrgSoP154U9dJ64GBH7XfkSxIYl1n8dw71OUYCY4fRINj8E006CxE7SQ
         v1cD5SXxZ6bOWYnVqn7uFSBAQYL306FierbjmRdFfqAF6yBrYy/ddV6rPqotLoAiJd9d
         J42VCITHHcb/tcVPmkLyC1aTnfMbBnMyDGFPqde/Ziv8MNjh01sX+S9GUeH/QxFvmv3z
         qpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nuCVJ/9FRKM73Wwlsp/YZ3g94ydYvMBaX8LRNO6g3d8=;
        b=Yh5ZDoVpAoAxDdKtELv7b2hBY17rpqjeIcVSxyp3efsgRz38zADlzBaI9HZgBFC8B6
         1h8j/JIVKO3Y8dX7K+OvehdY+hxz+0Iejo+KJeIpVi2u14tz2bkYDoM8VQD+S8GdCspo
         71nbiXPRoXjUsSutTBTtpu76Nons3U5OCIf49YZLvbfs0Boyfi2lBOMH0wwGiGj5XfNR
         u6ZLQPsMfUQx+Gl59X/3h4x+0OwHuB+RS/7CEIb/1wQScTsPQfFBrR1AntTdxnBhxTSK
         Y/MJ920zRtXyxKu6ecCoA+OVj/TpNV9jv1BzpWueX3a4VDJNHpGFmWPjJPDwmJ8derIL
         ggTw==
X-Gm-Message-State: AJcUuke+IOorWQqxzDdw6MF3wROJrSO0CZcdb/52jB8B6YYLy7wiR0PT
        ozS1nfwuLK9tCQzgHREuF7w=
X-Google-Smtp-Source: ALg8bN5ZTIA1V/FX/MwxBtbFwftHjuGxhbFgJNlYNySbyIBLjemKYrW5RNNTwDZ+jhSxlLhu1HuKjg==
X-Received: by 2002:a63:b4c:: with SMTP id a12mr11035056pgl.131.1546357672624;
        Tue, 01 Jan 2019 07:47:52 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id m3sm84122386pff.173.2019.01.01.07.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 07:47:52 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 4/5] sched/tracing: Show stacktrace for wakeup tracers
Date:   Tue,  1 Jan 2019 23:46:13 +0800
Message-Id: <20190101154614.8887-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101154614.8887-1-changbin.du@gmail.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This align the behavior of wakeup tracers with irqsoff latency tracer
that we record stacktrace at the beginning and end of waking up. The
stacktrace shows us what is happening in the kernel.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_sched_wakeup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index da5b6e012840..0ec136d408ff 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -474,6 +474,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 	data = per_cpu_ptr(wakeup_trace->trace_buffer.data, wakeup_cpu);
 
 	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
+	/* Skip 2 functions to get to the task switch function */
+	__trace_stack(wakeup_trace, flags, 2, pc);
 	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
 
 	T0 = data->preempt_timestamp;
@@ -593,6 +595,8 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	 * it should be safe to use it here.
 	 */
 	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, flags, pc);
+	/* Skip 2 functions to get to the task wakeup function */
+	__trace_stack(wakeup_trace, flags, 2, pc);
 
 out_locked:
 	arch_spin_unlock(&wakeup_lock);
-- 
2.17.1

