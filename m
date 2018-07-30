Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C716256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4526420881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do+TpDi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG3T3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:29:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37239 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbeG3T3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:29:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so13823413wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3X4dsPQ5E4pxgp8GNYp02T00bBOwHn+3RpQTn1xs9Rk=;
        b=do+TpDi7hypXl2T4lnbQBnMZAy01jCWBmoX4CtmT+EYkWPCUNJIOJUkUxKez5YWzl4
         How1O3AbU+3Ee+PJVwpW70U/Sv4W5ZVG85H+DvNkgE5TpCGa7z9BkkPiEXgMMqHSOrhy
         w46Meq78ssxznYMupkn3OA0Hjec3/yXjC/HFF7iTn84jTEDRcw2q2uzZsJVaUSH9knqu
         j9dVl59ZQaHm4UCGh+d2goHnCBFHvpldyTbC5hINiI34nH/TbsLdi0pE4IL9mjUCSFXA
         Z86YRtYhe1m2pjqVoy907mu8ie+J7Ut/wwp5yhwZYTvVdcyP2nzd9Xky63W6ZakqZmAn
         GAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3X4dsPQ5E4pxgp8GNYp02T00bBOwHn+3RpQTn1xs9Rk=;
        b=iDYRRiQZIgP2VvmbK8TqghQ/fmsjnmYRZnDFjCagCZF3WQTiXMpegQ2f2EX9RJP2Ql
         haPBvpjUJjDlT/yxEI8LheMWqaop3YB5jWuILnqrqRISYv/Jnt36GiPzH5ebGW2ztjKw
         zINTDs+Llw0JkLc6MKr22/iUMayNBnnhfMBKS/IUvFsij8S24fivxTut82iLYOwfinJy
         Skq/PRICHrrpbDmv/aZe4WvMX2o5E2rmmUFr4w8QVLNa9CxVlrD7l4+J9zVjvmq4JXWD
         DMm5KjYqISM5u3aafK71nMuqg5ZLIkFDPCES3vPtGG7BYJl81h47XmVFJSLimZRe8wNj
         9ANQ==
X-Gm-Message-State: AOUpUlEABAjVVlnyNHnZ8Lg+ikTwHwqKGDoerX1qxPVfHl15elzM08f3
        ER1qc+1rIw7hUU3fzKe1pEg=
X-Google-Smtp-Source: AAOMgpe8YoA0DddvFxOjjz4+LrzVKI9oA1XbGtXmtbTUd1arzpwAkQ2PmEVTkRgVzEtser5h3CClDg==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr12861112wri.221.1532973201755;
        Mon, 30 Jul 2018 10:53:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v5-v6sm24898748wrp.87.2018.07.30.10.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:53:21 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:53:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20180730175318.GA2557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 7f635ff187ab6be0b350b3ec06791e376af238ab perf/core: Fix crash when using HW tracing kernel filters

Misc fixes:

 - AMD IBS data corruptor fix (uncovered by UBSAN)
 - an Intel PEBS entry unwind error fix
 - a HW-tracing crash fix
 - a MAINTAINERS update

 Thanks,

	Ingo

------------------>
Ananth N Mavinakayanahalli (1):
      MAINTAINERS: Add Naveen N. Rao as kprobes co-maintainer

Mathieu Poirier (1):
      perf/core: Fix crash when using HW tracing kernel filters

Peter Zijlstra (1):
      perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)

Thomas Gleixner (1):
      perf/x86/amd/ibs: Don't access non-started event


 MAINTAINERS                     |  2 +-
 arch/x86/events/amd/ibs.c       |  6 +++++-
 arch/x86/events/intel/core.c    |  3 +++
 arch/x86/events/intel/ds.c      | 25 +++++++++++--------------
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  2 ++
 kernel/events/core.c            | 10 ++++++++--
 7 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228f78cb..42a884c1b0f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7984,7 +7984,7 @@ F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
 KPROBES
-M:	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
+M:	Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 4b98101209a1..d50bb4dc0650 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -579,7 +579,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
 	struct perf_event *event = pcpu->event;
-	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event *hwc;
 	struct perf_sample_data data;
 	struct perf_raw_record raw;
 	struct pt_regs regs;
@@ -602,6 +602,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		return 0;
 	}
 
+	if (WARN_ON_ONCE(!event))
+		goto fail;
+
+	hwc = &event->hw;
 	msr = hwc->config_base;
 	buf = ibs_data.regs;
 	rdmsrl(msr, *buf);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 707b2a96e516..86f0c15dcc2d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2997,6 +2997,9 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+			event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8cf03f101938..8dbba77e0518 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1185,17 +1185,21 @@ static void setup_pebs_sample_data(struct perf_event *event,
 		data->data_src.val = val;
 	}
 
+	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happend between the record and
+	 * PMI.
+	 */
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		data->callchain = perf_callchain(event, iregs);
+
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
 	 * contain a full regs set, specifically it seems to lack segment
 	 * descriptors, which get used by things like user_mode().
 	 *
 	 * In the simple case fix up only the IP for PERF_SAMPLE_IP.
-	 *
-	 * We must however always use BP,SP from iregs for the unwinder to stay
-	 * sane; the record BP,SP can point into thin air when the record is
-	 * from a previous PMI context or an (I)RET happend between the record
-	 * and PMI.
 	 */
 	*regs = *iregs;
 
@@ -1214,15 +1218,8 @@ static void setup_pebs_sample_data(struct perf_event *event,
 		regs->si = pebs->si;
 		regs->di = pebs->di;
 
-		/*
-		 * Per the above; only set BP,SP if we don't need callchains.
-		 *
-		 * XXX: does this make sense?
-		 */
-		if (!(sample_type & PERF_SAMPLE_CALLCHAIN)) {
-			regs->bp = pebs->bp;
-			regs->sp = pebs->sp;
-		}
+		regs->bp = pebs->bp;
+		regs->sp = pebs->sp;
 
 #ifndef CONFIG_X86_32
 		regs->r8 = pebs->r8;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1fa12887ec02..87f6db437e4a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1130,6 +1130,7 @@ extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
+extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b8e288a1f740..eeb787b1c53c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..eec2d5fb676b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6343,7 +6343,7 @@ static u64 perf_virt_to_phys(u64 virt)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
-static struct perf_callchain_entry *
+struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
@@ -6382,7 +6382,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		data->callchain = perf_callchain(event, regs);
+		if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+			data->callchain = perf_callchain(event, regs);
+
 		size += data->callchain->nr;
 
 		header->size += size * sizeof(u64);
@@ -7335,6 +7337,10 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 				     struct file *file, unsigned long offset,
 				     unsigned long size)
 {
+	/* d_inode(NULL) won't be equal to any mapped user-space file */
+	if (!filter->path.dentry)
+		return false;
+
 	if (d_inode(filter->path.dentry) != file_inode(file))
 		return false;
 
