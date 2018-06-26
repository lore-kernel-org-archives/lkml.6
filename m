Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21ABC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA926D4A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="iGwve+Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AA926D4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeFZPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:37:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44251 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeFZPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:37:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id p12-v6so16088182wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5tcfLx0xi3PDdpIUWtJ4i3RUXH3rng78vOaEle6+ojY=;
        b=iGwve+MkUPU5fpQDJ+NXjxhbU5Tx9LsHz8qSyTSBR03KnoOFfhp3HslA9gn+dXHUhD
         gWHOL37DrKNhJBXF+995Zw8mtUe2J1o6aIt86XxQaFabQsiBwGBNk2+EteoC8iLj4Bxe
         F9jZDP7hHeieXq3hcq5itXg/f+RjvQwJH8a5PYKMVM3npSca96gBuNXMx35z8cY7pt3j
         oO63FdYykf/dIPkOuLziqll5g4RTF9TH56rh9t1tq4nVDSsuXSsOcvXTvBPyIzOBTXyn
         9n2xJuX5+4x9GTFKokaR0A033hgcSPdBM1Npy6p5ZwwyLL1G4G8Hak3VzeZqkIP8mIcQ
         9myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5tcfLx0xi3PDdpIUWtJ4i3RUXH3rng78vOaEle6+ojY=;
        b=dgi4VNerZWdzcdHuAO5gLoF/gXhuqqshhTAJqOdkwzP7RMqatKtVam+vGoX0m957a+
         0P20lMlcEgIa2aYzUs8ayXevoJ/hl3gSF3BMCdFC3a4jVvCSkn92ZAUkAGvqi1Sy2fYY
         6ULDzctLuhV7uAdeBznBZTqMTvNWHQBXj5UNIuT5cqqTZod8BULqw+OhtO3Z6U5aGpLd
         7ThnW3SpD6iHIHW2/CyMZFC1cuFUehIkqDy1GST8wYenY1tfDJRT23fMKAvtC39/kR1A
         O/aNqJ04Ck/sykyWxfQrgL+nOYg+SBEBK6wppfW+hehjFvd0KJkppo/a5GwquJl48VGq
         j4nA==
X-Gm-Message-State: APt69E2sx+C9q2sZwMXz5fOmLyNEGcAuQa/ext4prununagBjbGgvOzj
        fqKi3dGOA9AVVo78zZwnfOM3xWSn
X-Google-Smtp-Source: AAOMgpesVLlwL2hR8haCAyS1k5eqh9ghf/BtUqrN2iqY9HNq8q865mffJXFw8h3mMc9lDa6z2dmQHg==
X-Received: by 2002:adf:9487:: with SMTP id 7-v6mr2041642wrr.82.1530027436930;
        Tue, 26 Jun 2018 08:37:16 -0700 (PDT)
Received: from localhost.localdomain ([95.146.151.144])
        by smtp.gmail.com with ESMTPSA id l84-v6sm3411176wmi.3.2018.06.26.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:37:16 -0700 (PDT)
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
Subject: [RFC 1/4] perf: Move some access checks later in perf_event_open
Date:   Tue, 26 Jun 2018 16:36:39 +0100
Message-Id: <20180626153642.5587-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
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
index f490caca9aa4..12de95b0472e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10189,10 +10189,6 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			 */
 			attr->branch_sample_type = mask;
 		}
-		/* privileged levels capture (kernel, hv): check permissions */
-		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
-		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
@@ -10409,11 +10405,6 @@ SYSCALL_DEFINE5(perf_event_open,
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
@@ -10427,11 +10418,6 @@ SYSCALL_DEFINE5(perf_event_open,
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
@@ -10501,6 +10487,28 @@ SYSCALL_DEFINE5(perf_event_open,
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

