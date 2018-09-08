Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378FAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E0420645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eQxGqXy3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="URaZCK1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E0420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIIBPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:15:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:15:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C1FF60B7E; Sat,  8 Sep 2018 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438502;
        bh=AiSXsPqgnxBl1egXl/tp3X3Wzh3/ubPlMcQVEh4lyNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQxGqXy3aN9v9BDyV1hNUMnCecllfWEK0KzM9Y6QuUUtQiAX1wIgJfIzdmyGQXROJ
         snsgJdEQl+iptnHGOicuxXi35hJ2oholZqlMd4dTE1DAhQl96p+s4Qp92gqZtbQQcR
         qwlb/DcUa8ybR1ESnRfbHEAnTnE3SXUcCidbVQCQ=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFF8760B1E;
        Sat,  8 Sep 2018 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438499;
        bh=AiSXsPqgnxBl1egXl/tp3X3Wzh3/ubPlMcQVEh4lyNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URaZCK1J+o6uXRiuqyC65hLBXkGlkRc+8xDI8Hp3qHR+PiBaD8/8ruJR03ziFft7l
         vmCfWRXcujze2gx3Y2kfS7MqABb98muk0s1eypur0MSiT7/qvzHRG5Z7bYtT+PM9ns
         EXFINMuETD1m/kJp4NK2rJFuznM55j0jP+MMdLAg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFF8760B1E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints go to pstore
Date:   Sun,  9 Sep 2018 01:57:04 +0530
Message-Id: <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the kernel command line tp_pstore option that will have
tracepoints go to persistent ram buffer as well as to the
trace buffer for further debugging. This is similar to tp_printk
cmdline option of ftrace.

Pstore support for event tracing is already added and we enable
logging to pstore only if cmdline is specified.

Passing "tp_pstore" will activate logging to pstore. To turn it
off, the sysctl /proc/sys/kernel/tracepoint_pstore can have '0'
echoed into it. Note, this only works if the cmdline option is
used. Echoing 1 into the sysctl file without the cmdline option
will have no affect.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../admin-guide/kernel-parameters.txt         | 21 ++++++++
 include/linux/ftrace.h                        |  6 ++-
 kernel/sysctl.c                               |  7 +++
 kernel/trace/Kconfig                          | 22 +++++++-
 kernel/trace/trace.c                          | 51 +++++++++++++++++++
 kernel/trace/trace.h                          |  7 +++
 6 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..622cf64d4e5b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4519,6 +4519,27 @@
 			frequency tracepoints such as irq or sched, can cause
 			the system to live lock.
 
+	tp_pstore[FTRACE]
+			Have the tracepoints sent to persistent ram buffer for
+			debugging. This is useful for debugging early boot up
+			and other kernel issues where the system hangs or
+			reboots due to some unclocked access or some buggy
+			driver. Instead of spamming the console with unwanted
+			logs, we can send the logs to pstore buffer for further
+			debugging.
+
+			Last occurred events in the pstore log will be helpful
+			in identifying the reset cause.
+
+			For example, to trace sched event, add to the command
+			line:
+				trace_event=sched tp_pstore
+
+			To turn off having tracepoints sent to pstore,
+				echo 0 > /proc/sys/kernel/tracepoint_pstore
+			Note, echoing 1 into this file without the
+			tracepoint_pstore kernel cmdline option has no effect.
+
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a397907e8d72..7c3074e7ec6b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -900,6 +900,7 @@ enum ftrace_dump_mode;
 
 extern enum ftrace_dump_mode ftrace_dump_on_oops;
 extern int tracepoint_printk;
+extern int tracepoint_pstore;
 
 extern void disable_trace_on_warning(void);
 extern int __disable_trace_on_warning;
@@ -907,9 +908,12 @@ extern int __disable_trace_on_warning;
 int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos);
+int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp,
+			     loff_t *ppos);
 
 #else /* CONFIG_TRACING */
-static inline void  disable_trace_on_warning(void) { }
+static inline void disable_trace_on_warning(void) { }
 #endif /* CONFIG_TRACING */
 
 #ifdef CONFIG_FTRACE_SYSCALLS
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..3cc1223b8955 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -653,6 +653,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= tracepoint_printk_sysctl,
 	},
+	{
+		.procname	= "tracepoint_pstore",
+		.data		= &tracepoint_pstore,
+		.maxlen		= sizeof(tracepoint_pstore),
+		.mode		= 0644,
+		.proc_handler	= tracepoint_pstore_sysctl,
+	},
 #endif
 #ifdef CONFIG_KEXEC_CORE
 	{
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5e3de28c7677..d0eed268ee85 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,27 @@ config TRACING_EVENTS_GPIO
 	help
 	  Enable tracing events for gpio subsystem
 
+config TRACING_EVENTS_IO
+	bool "Trace IO read/write events"
+	help
+	  Enable tracing events for IO read/write operations.
+	  This is useful for debugging random hangs or resets
+	  caused due to unclocked access or some buggy driver.
+
+	  Output of this trace event can be overwhelming and hence
+	  dynamic filtering option based on dynamic debug library
+	  is provided to narrow down the issues.
+
+	  Eg: Trace all register read/write of mmc subsystem with
+	  below command line:
+
+	    dyndbg="file drivers/mmc/* +p" trace_event=io
+
+	  See Documentation/admin-guide/dynamic-debug-howto.rst for
+	  more info on using dynamic debug.
+
+	  If unsure, say N.
+
 config GCOV_PROFILE_FTRACE
 	bool "Enable GCOV profiling on ftrace subsystem"
 	depends on GCOV_KERNEL
@@ -789,4 +810,3 @@ config GCOV_PROFILE_FTRACE
 endif # FTRACE
 
 endif # TRACING_SUPPORT
-
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bf6f1d70484d..018cbbefb769 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -73,6 +73,11 @@ struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
+/* Pipe tracepoints to pstore */
+struct trace_iterator *tracepoint_pstore_iter;
+int tracepoint_pstore;
+static DEFINE_STATIC_KEY_FALSE(tracepoint_pstore_key);
+
 /* For tracers that don't implement custom flags */
 static struct tracer_opt dummy_tracer_opt[] = {
 	{ }
@@ -238,6 +243,14 @@ static int __init set_tracepoint_printk(char *str)
 }
 __setup("tp_printk", set_tracepoint_printk);
 
+static int __init set_tracepoint_pstore(char *str)
+{
+	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
+		tracepoint_pstore = 1;
+	return 1;
+}
+__setup("tp_pstore", set_tracepoint_pstore);
+
 unsigned long long ns2usecs(u64 nsec)
 {
 	nsec += 500;
@@ -2376,11 +2389,45 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
+static DEFINE_MUTEX(tracepoint_pstore_mutex);
+
+int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp,
+			     loff_t *ppos)
+{
+	int save_tracepoint_pstore;
+	int ret;
+
+	mutex_lock(&tracepoint_pstore_mutex);
+	save_tracepoint_pstore = tracepoint_pstore;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (!tracepoint_pstore_iter)
+		tracepoint_pstore = 0;
+
+	if (save_tracepoint_pstore == tracepoint_pstore)
+		goto out;
+
+	if (tracepoint_pstore)
+		static_key_enable(&tracepoint_pstore_key.key);
+	else
+		static_key_disable(&tracepoint_pstore_key.key);
+
+ out:
+	mutex_unlock(&tracepoint_pstore_mutex);
+
+	return ret;
+}
+
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 {
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
+	if (static_key_false(&tracepoint_pstore_key.key))
+		pstore_event_call(fbuffer);
+
 	event_trigger_unlock_commit(fbuffer->trace_file, fbuffer->buffer,
 				    fbuffer->event, fbuffer->entry,
 				    fbuffer->flags, fbuffer->pc);
@@ -8596,6 +8643,10 @@ void __init early_trace_init(void)
 		else
 			static_key_enable(&tracepoint_printk_key.key);
 	}
+
+	if (tracepoint_pstore)
+		static_key_enable(&tracepoint_pstore_key.key);
+
 	tracer_alloc_buffers();
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3b8c0e24ab30..edc28d0c27eb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1843,5 +1843,12 @@ static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 #endif
 
 extern struct trace_iterator *tracepoint_print_iter;
+extern struct trace_iterator *tracepoint_pstore_iter;
+
+#ifdef CONFIG_PSTORE_FTRACE
+extern void pstore_event_call(struct trace_event_buffer *fbuffer);
+#else
+static inline void pstore_event_call(struct trace_event_buffer *fbuffer) { }
+#endif
 
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

