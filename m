Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD3BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4F3217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFZuH6s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfBEXZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:25:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36238 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbfBEXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:25:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so2232014pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDOVaEZRoG9B5WvSdx3N1/m5BAdIo/VwcdxFaAGLjXA=;
        b=sFZuH6s62wkacLSmL+otHVeLsf4wAAhazCHXWztFzulVk6Fr679+y0mrmqAcKjDc+T
         jrqx9THnVoUf5LY5Otv50SCSa/6PIWeoFAIMKqt1ng0ZnMrpeWOTySPi4IC3s0+wwk+Y
         c9tKH9ggKN/VFhFi2cmhNdzEGBboNq1dynPV4XVNLPSfBS/X9MC7uFJaVyP+QZPqrBFh
         LKrg0iuL1NHEd103kb4qtPKP9mX8ZPTJMH2pnFFw4s/H6dWjvl9CJMl5+WCO6WSK5g4y
         vgSxIgaqoMMfiOnra59Kaecf2Ic8MtV329JmFSAsOsPPaDbYgo7DWopGbWOisxOTDB0t
         jf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDOVaEZRoG9B5WvSdx3N1/m5BAdIo/VwcdxFaAGLjXA=;
        b=l4qCFaILDNRf5nkX2d4mGhz1ovGi/cOPLRfmQjqMtFBZdwdDyh2ksyCcKiAaY3FEul
         bNBUllr0a4Z4Go6hImPh7zOo2dwVG03fqG1ufysyzUJiM+TR99Ankw0f4Scr9xgqa7l5
         Ys64+UL4roCMxF8iDbIeY7SA7E1oCthYdzCB72CGoNKNnbiY4GmNMo7AezvFJzVnB73v
         cHyeh/x0ZA5g2fOQ6noRI6TQKqXwH5KmNhd0zRfkyQsaWGLiGz/X0vtXypssjAHEa8vu
         0J+0HuMuGI+v7U1KW+P1iEF6qhQSle5iBRBhhbIfS/laQLChysMwz8EDh12uG4cN6YST
         4BoQ==
X-Gm-Message-State: AHQUAuZ9I1lUELZNrS/iI5+VjD2VjydS9PouGbAjl8fXbEQu8MlwKyQH
        pYBGvpMWG+nDe/jQtcxU+WySJKB5my3BMQ==
X-Google-Smtp-Source: AHgI3IbcExpgk/yqEr4YKTRxtPKcMitI0LEdWaiTK7WYzz5Na6KhUxx0I1HxD2jNqzxHjQ+lqkxtYQ==
X-Received: by 2002:a63:da14:: with SMTP id c20mr6570563pgh.233.1549409104768;
        Tue, 05 Feb 2019 15:25:04 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:25:04 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
Date:   Tue,  5 Feb 2019 16:24:56 -0700
Message-Id: <20190205232458.7074-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pmu::setup_aux() is called the coresight PMU needs to know which
sink to use for the session by looking up the information in the
event's attr::config2 field.

As such simply replace the cpu information by the complete perf_event
structure and change all affected customers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/kernel/perf_cpum_sf.c                  | 6 +++---
 arch/x86/events/intel/bts.c                      | 4 +++-
 arch/x86/events/intel/pt.c                       | 5 +++--
 drivers/hwtracing/coresight/coresight-etm-perf.c | 6 +++---
 drivers/perf/arm_spe_pmu.c                       | 6 +++---
 include/linux/perf_event.h                       | 2 +-
 kernel/events/ring_buffer.c                      | 2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index bfabeb1889cc..1266194afb02 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1600,7 +1600,7 @@ static void aux_sdb_init(unsigned long sdb)
 
 /*
  * aux_buffer_setup() - Setup AUX buffer for diagnostic mode sampling
- * @cpu:	On which to allocate, -1 means current
+ * @event:	Event the buffer is setup for, event->cpu == -1 means current
  * @pages:	Array of pointers to buffer pages passed from perf core
  * @nr_pages:	Total pages
  * @snapshot:	Flag for snapshot mode
@@ -1612,8 +1612,8 @@ static void aux_sdb_init(unsigned long sdb)
  *
  * Return the private AUX buffer structure if success or NULL if fails.
  */
-static void *aux_buffer_setup(int cpu, void **pages, int nr_pages,
-			      bool snapshot)
+static void *aux_buffer_setup(struct perf_event *event, void **pages,
+			      int nr_pages, bool snapshot)
 {
 	struct sf_buffer *sfb;
 	struct aux_buffer *aux;
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index a01ef1b0f883..7cdd7b13bbda 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -77,10 +77,12 @@ static size_t buf_size(struct page *page)
 }
 
 static void *
-bts_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool overwrite)
+bts_buffer_setup_aux(struct perf_event *event, void **pages,
+		     int nr_pages, bool overwrite)
 {
 	struct bts_buffer *buf;
 	struct page *page;
+	int cpu = event->cpu;
 	int node = (cpu == -1) ? cpu : cpu_to_node(cpu);
 	unsigned long offset;
 	size_t size = nr_pages << PAGE_SHIFT;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9494ca68fd9d..c0e86ff21f81 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1114,10 +1114,11 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
  * Return:	Our private PT buffer structure.
  */
 static void *
-pt_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool snapshot)
+pt_buffer_setup_aux(struct perf_event *event, void **pages,
+		    int nr_pages, bool snapshot)
 {
 	struct pt_buffer *buf;
-	int node, ret;
+	int node, ret, cpu = event->cpu;
 
 	if (!nr_pages)
 		return NULL;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index abe8249b893b..f21eb28b6782 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -177,15 +177,15 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
-static void *etm_setup_aux(int event_cpu, void **pages,
+static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	int cpu;
+	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
 
-	event_data = alloc_event_data(event_cpu);
+	event_data = alloc_event_data(cpu);
 	if (!event_data)
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8e46a9dad2fa..7cb766dafe85 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -824,10 +824,10 @@ static void arm_spe_pmu_read(struct perf_event *event)
 {
 }
 
-static void *arm_spe_pmu_setup_aux(int cpu, void **pages, int nr_pages,
-				   bool snapshot)
+static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
+				   int nr_pages, bool snapshot)
 {
-	int i;
+	int i, cpu = event->cpu;
 	struct page **pglist;
 	struct arm_spe_pmu_buf *buf;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551a5add..3e49b2144808 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -409,7 +409,7 @@ struct pmu {
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
-	void *(*setup_aux)		(int cpu, void **pages,
+	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
 					/* optional */
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4a9937076331..857308295f63 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -658,7 +658,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.17.1

