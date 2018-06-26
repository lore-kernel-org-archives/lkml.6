Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB6CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFD026D50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="uiHekP31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFD026D50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeFZPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:37:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36034 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeFZPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:37:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so17740116wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8DJ0Ia4ZI93oW7tSsaINkQPsSrcYt8IkwP65HuIpIoA=;
        b=uiHekP31fpJdf8578rIkPUni+cu/4FGCEYac7O5DhEGIvIUwMNxRPs1RrfxUo3dkqO
         jv6JdkvtZYIE78AHzRC/yHNFkwHFSK3T+8KyFKht0XDqcnVMIB473VVJOdRH0nnwsIqU
         rRATVccIRkAVIEOrXXhfGFOcTrwjwyWXfR2WCPMrbH6D+jOzV3Blf1BAZZFsU0jxIdqH
         wbKz5iNh9pDJs6wR1MQ5qPkd7lf3Q4CBRds7NOg7MkpxUux2BUAdVyY9Zpy+7uUyj3fx
         UXpu80BUbQGIfW6nvgUn2v2SDFFhmDmvHqK1qVk9xQ8+hAdGTafNX2hy+OBq+ysvdWWm
         /lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8DJ0Ia4ZI93oW7tSsaINkQPsSrcYt8IkwP65HuIpIoA=;
        b=obAYp0DSXaYcjAsrclgdk2Asvt1iQEmzwOUcoQNBrWg6mi4bZRjmVg/DzvtZkXP6jm
         5PVz8ZaWKMISNbU3Yp3qexFtVMpj98b9FPoj/06MW+OtpnAU2ObUDOg9aV63M+RrTNTB
         PH5FVMP4Uv+v3whYeDK1gR4hyAPosjQuhWvv5fSPBAHAyQQfA2NslI5IAvwmLHwjuwbY
         DTJTzKR5IMsZ92/7O8MSgM1MMW/wHK5HXIZ5U2k5+8pMyW5eY4jDXXOi6L0yjRSnqE4z
         c7vxatrlAHP6ypglQ3IfbvR2Fg+GqoHmPmWtRdFq38NcDmzlrF7T0zX2yGGJRqJLHpOd
         bK3w==
X-Gm-Message-State: APt69E26rigO1bbGj6DF4R8kn2bPJovkyNRG+pks/bJrbT6jKygKAKum
        rISsTar0DoUtWRWli0jFDC2IUIDV
X-Google-Smtp-Source: AAOMgpdrMLXJMvYE30C7+uXBRcvkAkLJ7Oe87iHhgjTB6G5sFMemDAWQW6GZwn7WFgqAGGZE7ICGyQ==
X-Received: by 2002:adf:c546:: with SMTP id s6-v6mr2053454wrf.46.1530027439472;
        Tue, 26 Jun 2018 08:37:19 -0700 (PDT)
Received: from localhost.localdomain ([95.146.151.144])
        by smtp.gmail.com with ESMTPSA id l84-v6sm3411176wmi.3.2018.06.26.08.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:37:18 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
Subject: [RFC 3/4] perf: Allow per PMU access control
Date:   Tue, 26 Jun 2018 16:36:41 +0100
Message-Id: <20180626153642.5587-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

For situations where sysadmins might want to allow different level of
access control for different PMUs, we start creating per-PMU
perf_event_paranoid controls in sysfs.

These work in equivalent fashion as the existing perf_event_paranoid
sysctl, which now becomes the parent control for each PMU.

On PMU registration the global/parent value will be inherited by each PMU,
as it will be propagated to all registered PMUs when the sysctl is
updated.

At any later point individual PMU access controls, located in
<sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
fine grained access control.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 include/linux/perf_event.h | 12 ++++++--
 kernel/events/core.c       | 59 ++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c            |  4 ++-
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d7938d88c028..22e91cc2d9e1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -271,6 +271,9 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	/* per PMU access control */
+	int				perf_event_paranoid;
+
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
@@ -1168,6 +1171,9 @@ extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
+extern int perf_proc_paranoid_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp,
+		loff_t *ppos);
 extern int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
@@ -1180,17 +1186,17 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
 
 static inline bool perf_paranoid_tracepoint_raw(const struct pmu *pmu)
 {
-	return sysctl_perf_event_paranoid > -1;
+	return pmu->perf_event_paranoid > -1;
 }
 
 static inline bool perf_paranoid_cpu(const struct pmu *pmu)
 {
-	return sysctl_perf_event_paranoid > 0;
+	return pmu->perf_event_paranoid > 0;
 }
 
 static inline bool perf_paranoid_kernel(const struct pmu *pmu)
 {
-	return sysctl_perf_event_paranoid > 1;
+	return pmu->perf_event_paranoid > 1;
 }
 
 extern void perf_event_init(void);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 370c89e81722..da36317dc8dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -432,6 +432,24 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_context *cpuctx);
 
+int perf_proc_paranoid_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp,
+		loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	struct pmu *pmu;
+
+	if (ret || !write)
+		return ret;
+
+	mutex_lock(&pmus_lock);
+	list_for_each_entry(pmu, &pmus, entry)
+		pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
+	mutex_unlock(&pmus_lock);
+
+	return 0;
+}
+
 int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
@@ -9425,6 +9443,41 @@ static void free_pmu_context(struct pmu *pmu)
 	mutex_unlock(&pmus_lock);
 }
 
+/*
+ * Fine-grained access control:
+ */
+static ssize_t
+perf_event_paranoid_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *page)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->perf_event_paranoid);
+}
+
+static ssize_t
+perf_event_paranoid_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	int ret, val;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < -1 || val > 2)
+		return -EINVAL;
+
+	pmu->perf_event_paranoid = val;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(perf_event_paranoid);
+
 /*
  * Let userspace know that this PMU supports address range filtering:
  */
@@ -9539,6 +9592,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
+	/* Add fine-grained access control attribute. */
+	ret = device_create_file(pmu->dev, &dev_attr_perf_event_paranoid);
+	if (ret)
+		goto del_dev;
+
 	/* For PMUs with address filters, throw in an extra attribute: */
 	if (pmu->nr_addr_filters)
 		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -9570,6 +9628,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->pmu_disable_count)
 		goto unlock;
 
+	pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
 	pmu->type = -1;
 	if (!name)
 		goto skip_type;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2d9837c0aff4..7f6fccb64a30 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1142,7 +1142,9 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_perf_event_paranoid,
 		.maxlen		= sizeof(sysctl_perf_event_paranoid),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler   = perf_proc_paranoid_handler,
+		.extra1         = &neg_one,
+		.extra2         = &two,
 	},
 	{
 		.procname	= "perf_event_mlock_kb",
-- 
2.17.1

