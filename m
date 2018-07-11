Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59946C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073D0208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ViCpbgm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073D0208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeGKGie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:38:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34475 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeGKGid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:38:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so17750737pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BdfWhrjr9wKw3yNm4cu6HOnRLkZAvO/Axt7JM6VJCtc=;
        b=ViCpbgm0x+ej7RxQRO9NaFiFBTWKGpUPVGwbRix1eCFAlTZDxSMoQaQmaYiGaYMjo+
         aGeoTyRN6eFeFe06PdIBC5DIE54NuAs139OFQ+GIJOHcbZ8x8momoRFfbXAZ495CdPxn
         YdYuuS3Hr098sglHF6rYmOyaOPHL+vPCDLHQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BdfWhrjr9wKw3yNm4cu6HOnRLkZAvO/Axt7JM6VJCtc=;
        b=NhHQiiJBaejJPlL5qvKUM9lG5Da+VdkXWmHSmVhm2hYm6bqpUVnKUD1cZ3Ve4uv1RX
         WhUVmN5Vwv9/zMmfDuI0I4hGpfcK50KwTdVn6cNHSUCr1EsPOvTmmeT9rSj/gfaI7n+j
         Ep/T/pJrTN+nb2qRmQsS09w8TlqtnlPEDqEMtaKmO4nFjI0Ul+pgz/BtCYZUrWaaqHqE
         2DtF75z231j7KKxUFUWoOBlsk9UyMbR0WTCt44d3diFtQTfcMNAfhqtcyupC1VAzExId
         GPTCgwzPiyOWMd3vYXHzZ/jjF/GTf3OxTy8scS6Rlnam5KccsVIkjPwL5zmY7jMf6I0+
         sx5g==
X-Gm-Message-State: APt69E3ocw+MMpMx7FIwtDycDnFTAeXF29hEcYidsdgU3gFQq9GnVPkz
        vNaCdI89/u4acZ085+Kc+rDrf+py2qE=
X-Google-Smtp-Source: AAOMgpfg+EynEwsyUEFeJrYRBgSF43lw65VmaDAT58QtbBiHzHLAMekUnZmZWK2qwIvTfzqlfqKihQ==
X-Received: by 2002:aa7:8118:: with SMTP id b24-v6mr1673242pfi.78.1531290950170;
        Tue, 10 Jul 2018 23:35:50 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h190-v6sm24731891pge.85.2018.07.10.23.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 23:35:49 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH 1/2] lib: Add module for testing preemptoff/irqsoff latency tracers
Date:   Tue, 10 Jul 2018 23:35:39 -0700
Message-Id: <20180711063540.91101-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180711063540.91101-1-joel@joelfernandes.org>
References: <20180711063540.91101-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Here we introduce a test module for introducing a long preempt or irq
disable delay in the kernel which the preemptoff or irqsoff tracers can
detect. This module is to be used only for test purposes and is default
disabled.

Following is the expected output (only briefly shown) that can be parsed
to verify that the tracers are working correctly. We will use this from
the kselftests in future patches.

For the preemptoff tracer:

echo preemptoff > /d/tracing/current_tracer
sleep 1
insmod ./preemptirq_delay_test.ko test_mode=preempt delay=500000
sleep 1
bash-4.3# cat /d/tracing/trace
preempt -1066    2...2    0us@: preemptirq_delay_run <-preemptirq_delay_run
preempt -1066    2...2 500002us : preemptirq_delay_run <-preemptirq_delay_run
preempt -1066    2...2 500004us : tracer_preempt_on <-preemptirq_delay_run
preempt -1066    2...2 500012us : <stack trace>
 => kthread
 => ret_from_fork

For the irqsoff tracer:

echo irqsoff > /d/tracing/current_tracer
sleep 1
insmod ./preemptirq_delay_test.ko test_mode=irq delay=500000
sleep 1
bash-4.3# cat /d/tracing/trace
irq dis -1069    1d..1    0us@: preemptirq_delay_run
irq dis -1069    1d..1 500001us : preemptirq_delay_run
irq dis -1069    1d..1 500002us : tracer_hardirqs_on <-preemptirq_delay_run
irq dis -1069    1d..1 500005us : <stack trace>
 => ret_from_fork

Co-developed-by: Erick Reyes <erickreyes@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/Kconfig                 | 15 ++++++
 kernel/trace/Makefile                |  1 +
 kernel/trace/preemptirq_delay_test.c | 72 ++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 kernel/trace/preemptirq_delay_test.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8d51351e3149..eb5ab6b511e2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -699,6 +699,21 @@ config RING_BUFFER_STARTUP_TEST
 
 	 If unsure, say N
 
+config PREEMPTIRQ_DELAY_TEST
+	tristate "Preempt / IRQ disable delay thread to test latency tracers"
+	depends on m
+	help
+	  Select this option to build a test module that can help test latency
+	  tracers by executing a preempt or irq disable section with a user
+	  configurable delay. The module busy waits for the duration of the
+	  critical section.
+
+	  For example, the following invocation forces a one-time irq-disabled
+	  critical section for 500us:
+	  modprobe preemptirq_delay_test test_mode=irq delay=500000
+
+	  If unsure, say N
+
 config TRACE_EVAL_MAP_FILE
        bool "Show eval mappings for trace events"
        depends on TRACING
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 84a0cb222f20..677540bb1b62 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
+obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
new file mode 100644
index 000000000000..c97a026c0720
--- /dev/null
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Preempt / IRQ disable delay thread to test latency tracers
+ *
+ * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+static ulong delay = 100;
+static char test_mode[10] = "irq";
+
+module_param_named(delay, delay, ulong, S_IRUGO);
+module_param_string(test_mode, test_mode, 10, S_IRUGO);
+MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
+MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
+
+static void busy_wait(ulong time)
+{
+	ktime_t start, end;
+	start = ktime_get();
+	do {
+		end = ktime_get();
+		if (kthread_should_stop())
+			break;
+	} while (ktime_to_ns(ktime_sub(end, start)) < (time * 1000));
+}
+
+int preemptirq_delay_run(void *data)
+{
+	unsigned long flags;
+
+	if (!strcmp(test_mode, "irq")) {
+		local_irq_save(flags);
+		busy_wait(delay);
+		local_irq_restore(flags);
+	} else if (!strcmp(test_mode, "preempt")) {
+		preempt_disable();
+		busy_wait(delay);
+		preempt_enable();
+	}
+
+	return 0;
+}
+
+static int __init preemptirq_delay_init(void)
+{
+	char task_name[50];
+	struct task_struct *test_task;
+
+	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
+
+	test_task = kthread_run(preemptirq_delay_run, NULL, task_name);
+	return PTR_ERR_OR_ZERO(test_task);
+}
+
+static void __exit preemptirq_delay_exit(void)
+{
+	return;
+}
+
+module_init(preemptirq_delay_init)
+module_exit(preemptirq_delay_exit)
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.203.gfac676dfb9-goog

