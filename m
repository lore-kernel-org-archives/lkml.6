Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0596DC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9909E224EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRK5zBi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9909E224EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeFUWgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:36:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44396 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933734AbeFUWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:36:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id g26-v6so2042955pgn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oOwfsnfdGEy+0Zi8MBTxiZIiiqfuLjViesbmC0Apsaw=;
        b=vRK5zBi7y98CJqh7EbIDF6xL+FFZz8JzSd9QebpK9GrOF+5sd/g78bt5/e6mLdnPUd
         dNl7wLxAPa4IERH70gKKJmyxeyf2tPUbIEx1C8Sa1LiV1gtG3CW54C8zw+erONnxZ9Tc
         VXvXhdjZQMk0LL9OoeGPonMlQF4Js9y27Es4lkm60Pc/7H0xCzpWOBStPRVVyFsuX0Cm
         /f1mJpMyPMiJXUkcY4AY6kE3e0Kmmve2bKtJswFBF/CND555lZ9zue0mpUnmu9xuTEVO
         Rb0T+jnEq0wJDv+f8tFPQQkzCwyMeIKhs9k43+b1xIjJq4eVNwoPa5ZZ+MUPj6MY3KPw
         V7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oOwfsnfdGEy+0Zi8MBTxiZIiiqfuLjViesbmC0Apsaw=;
        b=OGTqY1Kh/yKy4n8C68WsV23LFoeOAmNuejU4WoU6q7dkZPg7JGA90hmeyufsyi1hfq
         pftMGUNTPTZBQfNJqOWXIfztUL438rjkHNx2HkM/AHu3G9q58wKPdFA2aBz0ni4kiAH7
         AH+Uuj8o83oZwW5U2KfcYC/YVaMRMd9dZNJw2mhRFtbjBo0sbIxbRh0EgsQvXR4/JZHp
         YjlXYX2Wy0xZRQokOqYgIZO8rdPZOCdiwtcu1LfgPBEGff/jaQTFUmi3tWoVubgnglir
         qjTKIfOJY8wRRHpqmVb86kECJMbKdBEtqGpionv9GT+5NB6nG0D1NISQ+6Lg2Ynkyr1G
         v5Ww==
X-Gm-Message-State: APt69E3QQfc+2sNtjDbqPBbxLK45HAxjqMcN6BrBSQNCXHN5Cg3rE5TY
        9W6rxKOYz36p9DrvNksFKy1N3DiyBP8=
X-Google-Smtp-Source: ADUXVKJdPMec4dtslopAYLtv+S96+DKyD2EPnXTEw4b+ccHPNTUFbGEzPKNOniiCTfzlLPcOIgMC8g==
X-Received: by 2002:a62:fc8d:: with SMTP id e135-v6mr29303816pfh.208.1529620608788;
        Thu, 21 Jun 2018 15:36:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id l11-v6sm8638758pff.50.2018.06.21.15.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 15:36:48 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:36:47 -0700
From:   Joel Fernandes <joelaf@google.com>
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
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v9 6/7] lib: Add module to simulate atomic sections for
 testing preemptoff tracers
Message-ID: <20180621223647.GA212425@joelaf.mtv.corp.google.com>
References: <20180621223236.211495-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621223236.211495-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In this patch we introduce a test module for simulating a long atomic
section in the kernel which the preemptoff or irqsoff tracers can
detect. This module is to be used only for test purposes and is default
disabled.

Following is the expected output (only briefly shown) that can be parsed
to verify that the tracers are working correctly. We will use this from
the kselftests in future patches.

For the preemptoff tracer:

echo preemptoff > /d/tracing/current_tracer
sleep 1
insmod ./test_atomic_sections.ko atomic_mode=preempt atomic_time=500000
sleep 1
bash-4.3# cat /d/tracing/trace
preempt -1066    2...2    0us@: atomic_sect_run <-atomic_sect_run
preempt -1066    2...2 500002us : atomic_sect_run <-atomic_sect_run
preempt -1066    2...2 500004us : tracer_preempt_on <-atomic_sect_run
preempt -1066    2...2 500012us : <stack trace>
 => kthread
 => ret_from_fork

For the irqsoff tracer:

echo irqsoff > /d/tracing/current_tracer
sleep 1
insmod ./test_atomic_sections.ko atomic_mode=irq atomic_time=500000
sleep 1
bash-4.3# cat /d/tracing/trace
irq dis -1069    1d..1    0us@: atomic_sect_run
irq dis -1069    1d..1 500001us : atomic_sect_run
irq dis -1069    1d..1 500002us : tracer_hardirqs_on <-atomic_sect_run
irq dis -1069    1d..1 500005us : <stack trace>
 => ret_from_fork

Co-developed-by: Erick Reyes <erickreyes@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/Kconfig.debug          |  8 ++++
 lib/Makefile               |  1 +
 lib/test_atomic_sections.c | 77 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 lib/test_atomic_sections.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..622c90e1e066 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1956,6 +1956,14 @@ config TEST_KMOD
 
 	  If unsure, say N.
 
+config TEST_ATOMIC_SECTIONS
+	tristate "Simulate atomic sections for tracers to detect"
+	depends on m
+	help
+	  Select this option to build a test module that can help test atomic
+	  sections by simulating them with a duration supplied as a module
+	  parameter. Preempt disable and irq disable modes can be requested.
+
 config TEST_DEBUG_VIRTUAL
 	tristate "Test CONFIG_DEBUG_VIRTUAL feature"
 	depends on DEBUG_VIRTUAL
diff --git a/lib/Makefile b/lib/Makefile
index 8153fdab287f..0c155c2d5db9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,6 +44,7 @@ obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
+obj-$(CONFIG_TEST_ATOMIC_SECTIONS) += test_atomic_sections.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
diff --git a/lib/test_atomic_sections.c b/lib/test_atomic_sections.c
new file mode 100644
index 000000000000..1eef518f0974
--- /dev/null
+++ b/lib/test_atomic_sections.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Atomic section emulation test module
+ *
+ * Emulates atomic sections by disabling IRQs or preemption
+ * and doing a busy wait for a specified amount of time.
+ * This can be used for testing of different atomic section
+ * tracers such as irqsoff tracers.
+ *
+ * (c) 2018. Google LLC
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
+static ulong atomic_time = 100;
+static char atomic_mode[10] = "irq";
+
+module_param_named(atomic_time, atomic_time, ulong, S_IRUGO);
+module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
+MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");
+MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");
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
+int atomic_sect_run(void *data)
+{
+	unsigned long flags;
+
+	if (!strcmp(atomic_mode, "irq")) {
+		local_irq_save(flags);
+		busy_wait(atomic_time);
+		local_irq_restore(flags);
+	} else if (!strcmp(atomic_mode, "preempt")) {
+		preempt_disable();
+		busy_wait(atomic_time);
+		preempt_enable();
+	}
+
+	return 0;
+}
+
+static int __init atomic_sect_init(void)
+{
+	char task_name[50];
+	struct task_struct *test_task;
+
+	snprintf(task_name, sizeof(task_name), "%s_test", atomic_mode);
+
+	test_task = kthread_run(atomic_sect_run, NULL, task_name);
+	return PTR_ERR_OR_ZERO(test_task);
+}
+
+static void __exit atomic_sect_exit(void)
+{
+	return;
+}
+
+module_init(atomic_sect_init)
+module_exit(atomic_sect_exit)
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.rc2.346.g013aa6912e-goog

