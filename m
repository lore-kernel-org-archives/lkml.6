Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F9CECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5F2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="DCMi2/+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5F2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbeISSFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32859 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id r1-v6so9338862wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFvlMohcPzspbDDBdb4rgjCv3SoY193E5YYJkgAejB0=;
        b=DCMi2/+IIaU/ihvC1YyfV2/TP+wkpia7OvXW3cMQFst9j3iKjb/hqdL/O0RIfWI+f/
         i1qO6uMzDxtJd9ur/cWH8yveVzPXpAyPW2rb+6TLHG4KhOCxGqYB+4iv07k75RjIIT56
         ub5MpzBov+WTV4p9y7VMQCrPcv0pErIEAXeH2v3FyIkqCc2nQnJwTaA1wxKpZyJl+w8Y
         7VN2i1KMKx7JsP+E+krmZg0h2fhwNSnFNfhI8LSHNfYci5PDyScZBzq1ylmFgy4mUk4R
         c2/b356YEEKwBo8Tja7k6FvtiozSFJUdjCc65i8gjt4v1XVy3plFRLHzY/LplJweb9LP
         tG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFvlMohcPzspbDDBdb4rgjCv3SoY193E5YYJkgAejB0=;
        b=q2IEiLfv65b7vQ1q0m6qfcTx3oO9pcp40nWmG+6QOgsBgMg0TEjdPIO7qlgicLGfb8
         8X2EMqWDLM6bgXd2SgKXdYSuz8ESBs8ZKyUJvhWCtkEmfx4xC3ZgIroeZSfolPEBquVh
         bNeO+9p4TVr7hllR0rY0gbeQmXsCc1i0IuBwxVU+JEpF98o1CUyK/iOKfNSIL8WOJihT
         AD9F/BDQdwLP394xFU387hyNWY8nbh6sHgEBXgUYnKBPs+gbyX1wDYSFj/0rz4mSdKjP
         nrQjowYlwDNUFchnMWtsGEiR4e4DztIMCXJ2Y/5uQy/ri04y+Y6n8w70ZP3w9qOC5ebR
         JqGw==
X-Gm-Message-State: APzg51AtlLowzhibb5ibJJmMRiUoEkduTt2ZZo93q4q95pipFFTsFGqO
        XqstVrKXgmfrnW3GRmGzkLfrnv5hUNU=
X-Google-Smtp-Source: ANB0VdYdq1vVT2LJ4uCUA615C/PXBGcM6N1mXA520rPnVcrGWBpOo1oy4O79UPrniJ5y/wxBpd+REA==
X-Received: by 2002:a1c:c7c1:: with SMTP id x184-v6mr20649505wmf.134.1537360081070;
        Wed, 19 Sep 2018 05:28:01 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id l18-v6sm19412403wru.75.2018.09.19.05.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 05:28:00 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
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
Subject: [RFC 3/5] perf: Allow per PMU access control
Date:   Wed, 19 Sep 2018 13:27:49 +0100
Message-Id: <20180919122751.12439-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
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
index 22906bcc1bcd..bb82e47f5343 100644
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
@@ -1169,6 +1172,9 @@ extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
+extern int perf_proc_paranoid_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp,
+		loff_t *ppos);
 extern int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
@@ -1181,17 +1187,17 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
 
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
index f556144bc0c5..35f122349508 100644
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
@@ -9430,6 +9448,41 @@ static void free_pmu_context(struct pmu *pmu)
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
@@ -9544,6 +9597,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
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
@@ -9575,6 +9633,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->pmu_disable_count)
 		goto unlock;
 
+	pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
 	pmu->type = -1;
 	if (!name)
 		goto skip_type;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..83179c443c89 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1145,7 +1145,9 @@ static struct ctl_table kern_table[] = {
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

