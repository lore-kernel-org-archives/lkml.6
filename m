Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DPAFMfCXGVvNfAAAmS7hNA
	; Thu, 07 Jun 2018 20:40:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 02C456074D; Thu,  7 Jun 2018 20:40:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqemjn9/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68FE56063F;
	Thu,  7 Jun 2018 20:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68FE56063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeFGUkX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:40:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:45303 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeFGUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:38:54 -0400
Received: by mail-pg0-f44.google.com with SMTP id z1-v6so5296177pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fi93txyBJuSbbuA4LWs7xEzmwM3+MRU8AcVuu0hgxwo=;
        b=rqemjn9/KET2gmB/O1WM7DI+x25cow5HMiPgq/lzVtKD0fBtAFWG8Oi0TK9ppNhzw5
         0GFRci8e0XqlWnLDj/HZuM2w3amRhZ1eMRleZBUmKqLHyCAzLTsKlwih/DPVjwefHWJq
         OJG/pHozHkYGuWMSedtxlNGShuIoeN6nj49LMaa8Xwv7CxG2+BIXD3m9IwWgGj4zxt+W
         wMma10Sc9QxMRWOlUyJl+WVrukod2M/+QwWwA5YnTqTC992q7YHBKsFicasdhbU7j7Qh
         WXShXi8LmYVa0xYCLClZ5nXGkKc1ShtGftvQs/Q5AyTPA39EoEYyvk3s2f8OFBqDE9mE
         a0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fi93txyBJuSbbuA4LWs7xEzmwM3+MRU8AcVuu0hgxwo=;
        b=VCt1qJ6rwDWnfRZ9XfZ/b78aMOUJq1PwGBM3izZOVAhb0uXzMEVAQfRXOL7c9p96Wj
         D9bNefzeHM8cIuknaBPsLniUK5vpFEYT4qo3uhhKoodlCxCVvVOcPK63vKa81G+p5fsM
         sf5kYj67ZijrYG8Tivpu6qdrp+/xNPrCuYTW2fCUBxB++fob2sPGAbe7mfp565TJPiLQ
         Ybn9q5F8BPRUHsfbGnJJmjrhY7NXJQBulfbeJvjEX62XxfXMBpUW8H5/9GPzjDYhYrdq
         GDyI/GzQH8zQMYIrsgLDkGfJ4JummkwGfmbwt0ol9Lr+kp2W72xD5Nhz/N/or63nrN2h
         lT9A==
X-Gm-Message-State: APt69E03k2qV3GZ1pG5FotMq7Sv9nhQScDYBIDXYGYIRCXNK9o3opLQQ
        kXj5LGHz7TCSVi6zdw90FKZv7JW7m74=
X-Google-Smtp-Source: ADUXVKJEYBLV9ljr/qHlyfSCEhCYZc3VunDQpgKwqkvIYJayT94SCbJqQ9TwK5n0UYrv0kaB8tQ3MA==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr3133840pfi.100.1528403933238;
        Thu, 07 Jun 2018 13:38:53 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v27-v6sm10324174pfi.23.2018.06.07.13.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:38:52 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 3/7] trace/irqsoff: Split reset into separate functions
Date: Thu,  7 Jun 2018 13:38:11 -0700
Message-Id: <20180607203815.255845-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607203815.255845-1-joel@joelfernandes.org>
References: <20180607203815.255845-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Split reset functions into seperate functions in preparation
of future patches that need to do tracer specific reset.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace_irqsoff.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 03ecb4465ee4..f8daa754cce2 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -634,7 +634,7 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	return 0;
 }
 
-static void irqsoff_tracer_reset(struct trace_array *tr)
+static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
 	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
 	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
@@ -665,6 +665,12 @@ static int irqsoff_tracer_init(struct trace_array *tr)
 
 	return __irqsoff_tracer_init(tr);
 }
+
+static void irqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer irqsoff_tracer __read_mostly =
 {
 	.name		= "irqsoff",
@@ -697,11 +703,16 @@ static int preemptoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptoff_tracer __read_mostly =
 {
 	.name		= "preemptoff",
 	.init		= preemptoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
@@ -731,11 +742,16 @@ static int preemptirqsoff_tracer_init(struct trace_array *tr)
 	return __irqsoff_tracer_init(tr);
 }
 
+static void preemptirqsoff_tracer_reset(struct trace_array *tr)
+{
+	__irqsoff_tracer_reset(tr);
+}
+
 static struct tracer preemptirqsoff_tracer __read_mostly =
 {
 	.name		= "preemptirqsoff",
 	.init		= preemptirqsoff_tracer_init,
-	.reset		= irqsoff_tracer_reset,
+	.reset		= preemptirqsoff_tracer_reset,
 	.start		= irqsoff_tracer_start,
 	.stop		= irqsoff_tracer_stop,
 	.print_max	= true,
-- 
2.17.1.1185.g55be947832-goog
