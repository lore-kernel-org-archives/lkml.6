Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2782356-1520539283-2-1078457050034456546
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520539282; b=idJ9wOOfaa39xTTuFMm/6xRe1ufBKEbRlx7i9tKkBKxG//v
    qdZ9VJ8jBhTIZgltSMg4M4XS4fEw6TNvVXsXwfXWLqw5pP0g1CjD3SO/5pM1Iexv
    ZbW6sHIdPCJfyKUBEJVzMimswzh1btPs/2dP1HHERehAYLq5PZxdKTY8H0i1ywjb
    WoewL1ZLpf0LkTJTihU5jCu9UTeT/w/Cp8WLrtFDYIOKYi6FnzQEFVUffdHlCVxQ
    9f6F779iebj4vTW5xN3r+JCZ+CvUlJRSqptwWkuV2bLYGgu0bH205lkJAWy1ILkK
    0phJ3D8DnafWZkHiYFQtwSiq4ek/u5wXML9I8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520539282;
    bh=W40xy8yoa8SsCMRK2HAsa2zGePEXNwGmDgqP3BQ4kXU=; b=t9xvL01bamj/
    VZOT+HcohYhJCEhjWNgHM3muqtwAtR3BqSMzqTjylXAFgbAg3IRNJtKx6GEEWS3U
    k8ZWZ4OHcRC4aTynoM4eGMl6yjcLxCKb7ZDDIh29twDtBLvHtJr4tqLPrSqgtF6m
    RbUbYofo0pmIRF+2m/S4hIQ0/gJ/eNWqdHQGdU6cx8GXyQpX6iRT5X+0jMLwOq68
    szxIpXQ9hKV1NKKkJl2Pyy5xk+mmiD6o8XnQJB1271HeQvpHThbX0TRiA4l7hISL
    EL+rrqPsBcIv1FFjCDsTnRyo2Pc76j3+xBqHZbqV7ffiWfrthSGRUCWuku0Gueiq
    yY7XfUzG0A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeCHUBJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 15:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeCHTwI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1AE2177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/54] perf intel-pt: Fix sync_switch
Date: Thu,  8 Mar 2018 16:50:06 -0300
Message-Id: <20180308195029.14991-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

The flag when sync_switch is enabled was global to the decoding, whereas
it is really specific to the CPU.

The trace data for different CPUs is put on different queues, so add
sync_switch to the intel_pt_queue structure and use that in preference
to the global setting in the intel_pt structure.

That fixes problems decoding one CPU's trace because sync_switch was
disabled on a different CPU's queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4a7746249999..0979a6e8b2b7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -143,6 +143,7 @@ struct intel_pt_queue {
 	bool stop;
 	bool step_through_buffers;
 	bool use_buffer_pid_tid;
+	bool sync_switch;
 	pid_t pid, tid;
 	int cpu;
 	int switch_state;
@@ -963,10 +964,12 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			if (pt->timeless_decoding || !pt->have_sched_switch)
 				ptq->use_buffer_pid_tid = true;
 		}
+
+		ptq->sync_switch = pt->sync_switch;
 	}
 
 	if (!ptq->on_heap &&
-	    (!pt->sync_switch ||
+	    (!ptq->sync_switch ||
 	     ptq->switch_state != INTEL_PT_SS_EXPECTING_SWITCH_EVENT)) {
 		const struct intel_pt_state *state;
 		int ret;
@@ -1549,7 +1552,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (pt->synth_opts.last_branch)
 		intel_pt_update_last_branch_rb(ptq);
 
-	if (!pt->sync_switch)
+	if (!ptq->sync_switch)
 		return 0;
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
@@ -1630,6 +1633,21 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	return switch_ip;
 }
 
+static void intel_pt_enable_sync_switch(struct intel_pt *pt)
+{
+	unsigned int i;
+
+	pt->sync_switch = true;
+
+	for (i = 0; i < pt->queues.nr_queues; i++) {
+		struct auxtrace_queue *queue = &pt->queues.queue_array[i];
+		struct intel_pt_queue *ptq = queue->priv;
+
+		if (ptq)
+			ptq->sync_switch = true;
+	}
+}
+
 static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 {
 	const struct intel_pt_state *state = ptq->state;
@@ -1646,7 +1664,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 			if (pt->switch_ip) {
 				intel_pt_log("switch_ip: %"PRIx64" ptss_ip: %"PRIx64"\n",
 					     pt->switch_ip, pt->ptss_ip);
-				pt->sync_switch = true;
+				intel_pt_enable_sync_switch(pt);
 			}
 		}
 	}
@@ -1662,9 +1680,9 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 		if (state->err) {
 			if (state->err == INTEL_PT_ERR_NODATA)
 				return 1;
-			if (pt->sync_switch &&
+			if (ptq->sync_switch &&
 			    state->from_ip >= pt->kernel_start) {
-				pt->sync_switch = false;
+				ptq->sync_switch = false;
 				intel_pt_next_tid(pt, ptq);
 			}
 			if (pt->synth_opts.errors) {
@@ -1690,7 +1708,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 				     state->timestamp, state->est_timestamp);
 			ptq->timestamp = state->est_timestamp;
 		/* Use estimated TSC in unknown switch state */
-		} else if (pt->sync_switch &&
+		} else if (ptq->sync_switch &&
 			   ptq->switch_state == INTEL_PT_SS_UNKNOWN &&
 			   intel_pt_is_switch_ip(ptq, state->to_ip) &&
 			   ptq->next_tid == -1) {
@@ -1837,7 +1855,7 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 		return 1;
 
 	ptq = intel_pt_cpu_to_ptq(pt, cpu);
-	if (!ptq)
+	if (!ptq || !ptq->sync_switch)
 		return 1;
 
 	switch (ptq->switch_state) {
-- 
2.14.3
