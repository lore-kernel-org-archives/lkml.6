Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02877C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1F92087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="146DKhzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1F92087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeLDLMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbeLDLIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610B52082D;
        Tue,  4 Dec 2018 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921700;
        bh=snLAOq7VQpJ4+O0SVCyRqsne3iLAS2S6WoNJKUQwY6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=146DKhzVGmlEeaJ6JXgTnCGumgKSundrR3MXDH24IY5C/RqoTp7FVun/OuMEqRKxw
         0zJ8Ls4HxDT5Y8JHHfCe/giIyO/jeij7dv0ijbJxtUUO+SwoyCoE3oKnFktZsZn1Cw
         yPvkILRBAIzwKeDYP+BjTeom+Hl3ySI+o1uTVVM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 25/50] perf/x86/intel: Move branch tracing setup to the Intel-specific source file
Date:   Tue,  4 Dec 2018 11:50:20 +0100
Message-Id: <20181204103715.788186980@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit ed6101bbf6266ee83e620b19faa7c6ad56bb41ab upstream.

Moving branch tracing setup to Intel core object into separate
intel_pmu_bts_config function, because it's Intel specific.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20181121101612.16272-1-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/core.c       |   20 --------------------
 arch/x86/events/intel/core.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 21 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -437,26 +437,6 @@ int x86_setup_perfctr(struct perf_event
 	if (config == -1LL)
 		return -EINVAL;
 
-	/*
-	 * Branch tracing:
-	 */
-	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !attr->freq && hwc->sample_period == 1) {
-		/* BTS is not supported by this architecture. */
-		if (!x86_pmu.bts_active)
-			return -EOPNOTSUPP;
-
-		/* BTS is currently only allowed for user-mode. */
-		if (!attr->exclude_kernel)
-			return -EOPNOTSUPP;
-
-		/* disallow bts if conflicting events are present */
-		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
-			return -EBUSY;
-
-		event->destroy = hw_perf_lbr_event_destroy;
-	}
-
 	hwc->config |= config;
 
 	return 0;
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,6 +2822,41 @@ static unsigned long intel_pmu_free_runn
 	return flags;
 }
 
+static int intel_pmu_bts_config(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
+	    !attr->freq && hwc->sample_period == 1) {
+		/* BTS is not supported by this architecture. */
+		if (!x86_pmu.bts_active)
+			return -EOPNOTSUPP;
+
+		/* BTS is currently only allowed for user-mode. */
+		if (!attr->exclude_kernel)
+			return -EOPNOTSUPP;
+
+		/* disallow bts if conflicting events are present */
+		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
+			return -EBUSY;
+
+		event->destroy = hw_perf_lbr_event_destroy;
+	}
+
+	return 0;
+}
+
+static int core_pmu_hw_config(struct perf_event *event)
+{
+	int ret = x86_pmu_hw_config(event);
+
+	if (ret)
+		return ret;
+
+	return intel_pmu_bts_config(event);
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -2829,6 +2864,10 @@ static int intel_pmu_hw_config(struct pe
 	if (ret)
 		return ret;
 
+	ret = intel_pmu_bts_config(event);
+	if (ret)
+		return ret;
+
 	if (event->attr.precise_ip) {
 		if (!event->attr.freq) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
@@ -3265,7 +3304,7 @@ static __initconst const struct x86_pmu
 	.enable_all		= core_pmu_enable_all,
 	.enable			= core_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
-	.hw_config		= x86_pmu_hw_config,
+	.hw_config		= core_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,


