Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF5C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CFE20645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JtyqalJH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VpkYCZam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CFE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIIBPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:15:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIIBPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:15:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9506560AD9; Sat,  8 Sep 2018 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438497;
        bh=2qCdT0/E8JuJRbEQWvnqn8ufJsjPu9ZXXqIzW2bPtEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtyqalJHzihFCfc6uJStnw3X91qfvUvMvzb5C/jD6OpYiji7NQGsGHiBKTolSS5h0
         qwd2/ICVnun7ExWG7tAEY5vkIwj03zmWMg8hA0WHALVwEwTYM+XfVh/WvTlBTd3Xql
         3CPvn5UHYSZyQIiFJ1CqIUi9eSA63+RFgP1M0IM0=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 399C3608BF;
        Sat,  8 Sep 2018 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438487;
        bh=2qCdT0/E8JuJRbEQWvnqn8ufJsjPu9ZXXqIzW2bPtEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpkYCZamDN1XQrI+xiOlgEPNbXWdOjNnEi3PG/hJbDKjlBGzmevd+BG+LcIpdh+Lb
         ezEjTCFRI0yhP0ahkel97KYx6RoHaVVvBRBAejMvT1vdQzzdDwS7wPgIr5E8fklOUU
         n5ztiPLJ05ui+Wue+NHZUMpKdSZG6Y4Oez4bkYz8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 399C3608BF
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
Subject: [PATCH 2/6] pstore: Add event tracing support
Date:   Sun,  9 Sep 2018 01:57:03 +0530
Message-Id: <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pstore has function trace support which can be
used to get the function call chain with limited data.
Event tracing has extra data which is useful to debug wide
variety of issues and is heavily used across the kernel.

Adding this support to pstore can be very helpful to debug
different subsystems since almost all of them have trace
events already available. And also it is useful to debug
unknown resets or crashes since we can get lot more info
from event tracing by viewing the last occurred events.

High frequency tracepoints such as sched and irq has also
been tested. This implementation is similar to "tp_printk"
command line feature of ftrace by Steven.

For example, sample pstore output of tracing sched events
after reboot:

  # mount -t pstore pstore /sys/fs/pstore/
  # tail /sys/fs/pstore/event-ramoops-0
  sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_preempt next_pid=10 next_prio=120
  sched_switch: prev_comm=rcu_preempt prev_pid=10 prev_prio=120 prev_state=R+ ==> next_comm=swapper/1 next_pid=0 next_prio=120
  sched_waking: comm=rcu_sched pid=11 prio=120 target_cpu=002
  sched_wakeup: comm=rcu_sched pid=11 prio=120 target_cpu=002
  sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=11 next_prio=120
  sched_switch: prev_comm=rcu_sched prev_pid=11 prev_prio=120 prev_state=R+ ==> next_comm=swapper/2 next_pid=0 next_prio=120
  sched_waking: comm=reboot pid=1867 prio=120 target_cpu=000
  sched_wakeup: comm=reboot pid=1867 prio=120 target_cpu=000
  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=reboot next_pid=1867 next_prio=120

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 fs/pstore/Kconfig          |  2 +-
 fs/pstore/ftrace.c         | 55 ++++++++++++++++++++++++++++++++++++++
 fs/pstore/inode.c          |  4 +++
 fs/pstore/ram.c            | 44 +++++++++++++++++++++++++++---
 include/linux/pstore.h     |  2 ++
 include/linux/pstore_ram.h |  1 +
 6 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 503086f7f7c1..6fe087b13a51 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -126,7 +126,7 @@ config PSTORE_PMSG
 
 config PSTORE_FTRACE
 	bool "Persistent function tracer"
-	depends on PSTORE
+	depends on PSTORE && PSTORE!=m
 	depends on FUNCTION_TRACER
 	depends on DEBUG_FS
 	help
diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 06aab07b6bb7..d47dc93ac098 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -24,6 +24,8 @@
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/cache.h>
+#include <linux/slab.h>
+#include <linux/trace_events.h>
 #include <asm/barrier.h>
 #include "internal.h"
 
@@ -62,6 +64,59 @@ static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
 	.func	= pstore_ftrace_call,
 };
 
+void notrace pstore_event_call(struct trace_event_buffer *fbuffer)
+{
+	struct trace_iterator *iter;
+	struct trace_seq *s;
+	struct trace_event_call *event_call;
+	struct pstore_record record;
+	struct trace_event *event;
+	struct seq_buf *seq;
+	unsigned long flags;
+
+	if (!psinfo)
+		return;
+
+	if (unlikely(oops_in_progress))
+		return;
+
+	pstore_record_init(&record, psinfo);
+	record.type = PSTORE_TYPE_EVENT;
+
+	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+	if (!iter)
+		return;
+
+	event_call = fbuffer->trace_file->event_call;
+	if (!event_call || !event_call->event.funcs ||
+	    !event_call->event.funcs->trace)
+		goto fail_event;
+
+	event = &fbuffer->trace_file->event_call->event;
+
+	spin_lock_irqsave(&psinfo->buf_lock, flags);
+
+	trace_seq_init(&iter->seq);
+	iter->ent = fbuffer->entry;
+	event_call->event.funcs->trace(iter, 0, event);
+	trace_seq_putc(&iter->seq, 0);
+
+	if (seq->size > psinfo->bufsize)
+		seq->size = psinfo->bufsize;
+
+	s = &iter->seq;
+	seq = &s->seq;
+
+	record.buf = (char *)(seq->buffer);
+	record.size = seq->len;
+	psinfo->write(&record);
+
+	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
+
+fail_event:
+	kfree(iter);
+}
+
 static DEFINE_MUTEX(pstore_ftrace_lock);
 static bool pstore_ftrace_enabled;
 
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..f099152abbbd 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -345,6 +345,10 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		scnprintf(name, sizeof(name), "console-%s-%llu",
 			  record->psi->name, record->id);
 		break;
+	case PSTORE_TYPE_EVENT:
+		scnprintf(name, sizeof(name), "event-%s-%llu",
+			  record->psi->name, record->id);
+		break;
 	case PSTORE_TYPE_FTRACE:
 		scnprintf(name, sizeof(name), "ftrace-%s-%llu",
 			  record->psi->name, record->id);
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bbd1e357c23d..f60d41c0309e 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -48,6 +48,10 @@ static ulong ramoops_console_size = MIN_MEM_SIZE;
 module_param_named(console_size, ramoops_console_size, ulong, 0400);
 MODULE_PARM_DESC(console_size, "size of kernel console log");
 
+static ulong ramoops_event_size = MIN_MEM_SIZE;
+module_param_named(event_size, ramoops_event_size, ulong, 0400);
+MODULE_PARM_DESC(event_size, "size of event log");
+
 static ulong ramoops_ftrace_size = MIN_MEM_SIZE;
 module_param_named(ftrace_size, ramoops_ftrace_size, ulong, 0400);
 MODULE_PARM_DESC(ftrace_size, "size of ftrace log");
@@ -86,6 +90,7 @@ MODULE_PARM_DESC(ramoops_ecc,
 struct ramoops_context {
 	struct persistent_ram_zone **dprzs;	/* Oops dump zones */
 	struct persistent_ram_zone *cprz;	/* Console zone */
+	struct persistent_ram_zone *eprz;       /* Event zone */
 	struct persistent_ram_zone **fprzs;	/* Ftrace zones */
 	struct persistent_ram_zone *mprz;	/* PMSG zone */
 	phys_addr_t phys_addr;
@@ -93,6 +98,7 @@ struct ramoops_context {
 	unsigned int memtype;
 	size_t record_size;
 	size_t console_size;
+	size_t event_size;
 	size_t ftrace_size;
 	size_t pmsg_size;
 	int dump_oops;
@@ -103,6 +109,7 @@ struct ramoops_context {
 	/* _read_cnt need clear on ramoops_pstore_open */
 	unsigned int dump_read_cnt;
 	unsigned int console_read_cnt;
+	unsigned int event_read_cnt;
 	unsigned int max_ftrace_cnt;
 	unsigned int ftrace_read_cnt;
 	unsigned int pmsg_read_cnt;
@@ -118,6 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
 
 	cxt->dump_read_cnt = 0;
 	cxt->console_read_cnt = 0;
+	cxt->event_read_cnt = 0;
 	cxt->ftrace_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
 	return 0;
@@ -277,6 +285,11 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 					   1, &record->id, &record->type,
 					   PSTORE_TYPE_CONSOLE, 0);
 
+	if (!prz_ok(prz))
+		prz = ramoops_get_next_prz(&cxt->eprz, &cxt->event_read_cnt,
+					   1, &record->id, &record->type,
+					   PSTORE_TYPE_EVENT, 0);
+
 	if (!prz_ok(prz))
 		prz = ramoops_get_next_prz(&cxt->mprz, &cxt->pmsg_read_cnt,
 					   1, &record->id, &record->type,
@@ -385,6 +398,11 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 			return -ENOMEM;
 		persistent_ram_write(cxt->cprz, record->buf, record->size);
 		return 0;
+	} else if (record->type == PSTORE_TYPE_EVENT) {
+		if (!cxt->eprz)
+			return -ENOMEM;
+		persistent_ram_write(cxt->eprz, record->buf, record->size);
+		return 0;
 	} else if (record->type == PSTORE_TYPE_FTRACE) {
 		int zonenum;
 
@@ -475,6 +493,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 	case PSTORE_TYPE_CONSOLE:
 		prz = cxt->cprz;
 		break;
+	case PSTORE_TYPE_EVENT:
+		prz = cxt->eprz;
+		break;
 	case PSTORE_TYPE_FTRACE:
 		if (record->id >= cxt->max_ftrace_cnt)
 			return -EINVAL;
@@ -699,6 +720,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	parse_size("record-size", pdata->record_size);
 	parse_size("console-size", pdata->console_size);
+	parse_size("event-size", pdata->event_size);
 	parse_size("ftrace-size", pdata->ftrace_size);
 	parse_size("pmsg-size", pdata->pmsg_size);
 	parse_size("ecc-size", pdata->ecc_info.ecc_size);
@@ -747,7 +769,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	}
 
 	if (!pdata->mem_size || (!pdata->record_size && !pdata->console_size &&
-			!pdata->ftrace_size && !pdata->pmsg_size)) {
+			!pdata->event_size && !pdata->ftrace_size &&
+			!pdata->pmsg_size)) {
 		pr_err("The memory size and the record/console size must be "
 			"non-zero\n");
 		goto fail_out;
@@ -757,6 +780,8 @@ static int ramoops_probe(struct platform_device *pdev)
 		pdata->record_size = rounddown_pow_of_two(pdata->record_size);
 	if (pdata->console_size && !is_power_of_2(pdata->console_size))
 		pdata->console_size = rounddown_pow_of_two(pdata->console_size);
+	if (pdata->event_size && !is_power_of_2(pdata->event_size))
+		pdata->event_size = rounddown_pow_of_two(pdata->event_size);
 	if (pdata->ftrace_size && !is_power_of_2(pdata->ftrace_size))
 		pdata->ftrace_size = rounddown_pow_of_two(pdata->ftrace_size);
 	if (pdata->pmsg_size && !is_power_of_2(pdata->pmsg_size))
@@ -767,6 +792,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->memtype = pdata->mem_type;
 	cxt->record_size = pdata->record_size;
 	cxt->console_size = pdata->console_size;
+	cxt->event_size = pdata->event_size;
 	cxt->ftrace_size = pdata->ftrace_size;
 	cxt->pmsg_size = pdata->pmsg_size;
 	cxt->dump_oops = pdata->dump_oops;
@@ -775,8 +801,8 @@ static int ramoops_probe(struct platform_device *pdev)
 
 	paddr = cxt->phys_addr;
 
-	dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
-			- cxt->pmsg_size;
+	dump_mem_sz = cxt->size - cxt->console_size - cxt->event_size
+			- cxt->ftrace_size - cxt->pmsg_size;
 	err = ramoops_init_przs("dump", dev, cxt, &cxt->dprzs, &paddr,
 				dump_mem_sz, cxt->record_size,
 				&cxt->max_dump_cnt, 0, 0);
@@ -788,6 +814,11 @@ static int ramoops_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_init_cprz;
 
+	err = ramoops_init_prz("event", dev, cxt, &cxt->eprz, &paddr,
+			       cxt->event_size, 0);
+	if (err)
+		goto fail_init_eprz;
+
 	cxt->max_ftrace_cnt = (cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
 				? nr_cpu_ids
 				: 1;
@@ -825,6 +856,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	cxt->pstore.flags = PSTORE_FLAGS_DMESG;
 	if (cxt->console_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
+	if (cxt->event_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_EVENT;
 	if (cxt->ftrace_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
 	if (cxt->pmsg_size)
@@ -845,6 +878,7 @@ static int ramoops_probe(struct platform_device *pdev)
 	record_size = pdata->record_size;
 	dump_oops = pdata->dump_oops;
 	ramoops_console_size = pdata->console_size;
+	ramoops_event_size = pdata->event_size;
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
@@ -858,6 +892,8 @@ static int ramoops_probe(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 fail_clear:
 	cxt->pstore.bufsize = 0;
+	persistent_ram_free(cxt->eprz);
+fail_init_eprz:
 	persistent_ram_free(cxt->mprz);
 fail_init_mprz:
 fail_init_fprz:
@@ -877,6 +913,7 @@ static int ramoops_remove(struct platform_device *pdev)
 	kfree(cxt->pstore.buf);
 	cxt->pstore.bufsize = 0;
 
+	persistent_ram_free(cxt->eprz);
 	persistent_ram_free(cxt->mprz);
 	persistent_ram_free(cxt->cprz);
 	ramoops_free_przs(cxt);
@@ -916,6 +953,7 @@ static void ramoops_register_dummy(void)
 	dummy_data->mem_type = mem_type;
 	dummy_data->record_size = record_size;
 	dummy_data->console_size = ramoops_console_size;
+	dummy_data->event_size = ramoops_event_size;
 	dummy_data->ftrace_size = ramoops_ftrace_size;
 	dummy_data->pmsg_size = ramoops_pmsg_size;
 	dummy_data->dump_oops = dump_oops;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index a15bc4d48752..c31bb9567b4a 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -44,6 +44,7 @@ enum pstore_type_id {
 	PSTORE_TYPE_PPC_COMMON	= 6,
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
+	PSTORE_TYPE_EVENT	= 9,
 	PSTORE_TYPE_UNKNOWN	= 255
 };
 
@@ -193,6 +194,7 @@ struct pstore_info {
 #define PSTORE_FLAGS_CONSOLE	(1 << 1)
 #define PSTORE_FLAGS_FTRACE	(1 << 2)
 #define PSTORE_FLAGS_PMSG	(1 << 3)
+#define PSTORE_FLAGS_EVENT	(1 << 4)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index e6d226464838..f01055c6cc40 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -95,6 +95,7 @@ struct ramoops_platform_data {
 	unsigned int	mem_type;
 	unsigned long	record_size;
 	unsigned long	console_size;
+	unsigned long	event_size;
 	unsigned long	ftrace_size;
 	unsigned long	pmsg_size;
 	int		dump_oops;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

