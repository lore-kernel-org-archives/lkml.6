Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA490ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8D2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="nt8Lt0QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD8D2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbeISSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34801 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so5621183wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqKCgu/jW3Jks7xXMY74YRJ4aD2Uozs5QdRDMkceTlg=;
        b=nt8Lt0QPtnRP7sKN0gepGoCSru5VmtxHfBvs9D/T8TA+4rsVb055on6kOBrWeB9qxi
         ERA1ou+D3Cy6bLmIMwg4hvuUKzeN5A1aU36smQH+AcWb+oINzDEA+qsG62IxSfy0yzyO
         ql6IJSyVDiyUA34HtKGn4SM7AvPA1gRvVI0eUrUFL78bY38k8Uzpo0P+JWuyxNkRxCeT
         mIdV0WuepfS0me2s0s9gzjijIKcdaQhedHVwwwdjWIUaO2qJwBS9rBOWJSiUsKcXuHm/
         ZKNa/wXmPw7CJc/gerqrjbFqZ8HUoCKdee/J1MXVrIXTS3QWIFUz0S6aKe68T4D0MdYV
         sFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqKCgu/jW3Jks7xXMY74YRJ4aD2Uozs5QdRDMkceTlg=;
        b=kqQLwsxNPUKMN7DPxWF+0ChpWhLCBKU5kHWlMIAhKFV/FmY1uesdC+3e7kiZKHOkD/
         vVr4hylvghqNsg+OTsXBzSLxwGaUgrmZkZKEBpXpjfp3Bu6lRhehR0E9dFXd1M1p47Xj
         Uwu+cpoOezQstpUfaR8dORHQ5BcacUhqqO/3LOoRToBmgV2eCfbc5So6vbhCVZjoRWzB
         cAiUjZ34VjEsoAW6imn9yywj7ubk7gut9NL7NNfA/9Kp8HiC/xWEDz1oIj7fepD5JGDF
         0B6jFVePtXywwVUa3DST5P3CGq9sfXxAVGvbd/Ex0Hh3fuMZM6nrIATsNYeJFETjR49N
         zq0g==
X-Gm-Message-State: APzg51CHHR1HUwRpmuON/gmr7Cp+uGjJIP/utjXyzNKaAwBCrMTe/9bM
        kZgmRnkiF6whM2boaKEAtC64au/rTGU=
X-Google-Smtp-Source: ANB0VdabaGYwfoZ9Qpmw261uCzN2oi82u5ltboEiizHWlIKfyz+xXjnYTv4d6zJf0phTBErxrvgU8Q==
X-Received: by 2002:adf:e8c1:: with SMTP id k1-v6mr27430509wrn.43.1537360078593;
        Wed, 19 Sep 2018 05:27:58 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id l18-v6sm19412403wru.75.2018.09.19.05.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 05:27:58 -0700 (PDT)
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
Subject: [RFC 1/5] perf: Move some access checks later in perf_event_open
Date:   Wed, 19 Sep 2018 13:27:47 +0100
Message-Id: <20180919122751.12439-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

To enable per-PMU access controls in a following patch first move all call
sites of perf_paranoid_kernel() to after the event has been created.

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
 kernel/events/core.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bccce538f51d..adcd9eae13fb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10194,10 +10194,6 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			 */
 			attr->branch_sample_type = mask;
 		}
-		/* privileged levels capture (kernel, hv): check permissions */
-		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
-		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
@@ -10414,11 +10410,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
-		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
-	}
-
 	if (attr.namespaces) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -10432,11 +10423,6 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
-	/* Only privileged users can get physical addresses */
-	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
@@ -10506,6 +10492,28 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_cred;
 	}
 
+	if (!attr.exclude_kernel) {
+		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+			err = -EACCES;
+			goto err_alloc;
+		}
+	}
+
+	/* Only privileged users can get physical addresses */
+	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
+	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+		err = -EACCES;
+		goto err_alloc;
+	}
+
+	/* privileged levels capture (kernel, hv): check permissions */
+	if ((attr.sample_type & PERF_SAMPLE_BRANCH_STACK) &&
+	    (attr.branch_sample_type & PERF_SAMPLE_BRANCH_PERM_PLM) &&
+	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+		err = -EACCES;
+		goto err_alloc;
+	}
+
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
-- 
2.17.1

