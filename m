Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-700495-1526494757-2-7695129825139036622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526494756; b=jr/aeAv7noySENGaXUf5QLrETVrSaIE04mqPvt+wDQvp3X8XlG
    3Jq92AoZMuEGFV1XvjUAJNmLZQspzxhlfbVSP+q39PLgGYFcZMmkDPkVHPuwm0TF
    EhMKIZ2hhSUN2QFAhVqFsV3cEAPxcS36HCxKNfI6sdFfj7q42IBMlRQe3OQ24ewu
    uyCjCB43CMRRDYwwHa53hbE8kZvYwVRzzp7inrCymaJWfRPATjH6R1eN1knaEVKL
    g1h3fsSkLSI8Vtj+IBVyS7dmzTfoREWWLN6O7RSu/4rwwYFwDHygxy4jGBCNrgox
    kIBCIKBM9aSfbTM12+J/ESpx5CX670hJQ8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526494756; bh=vcVhkBFx2J6KPYpgkHAk8R/hUTdSn4
    eyrJHk3UDvHU0=; b=Aza9kdpHoWd+2RaYq9lA+8qkiA09kCjKUIsaNQFBaTH8Ck
    5gMIEmE6+wuTYROEIqJ9v08Fq3PP3SsaZIcAjlV8pVwOK3bNrM7EU4tp5H9kNJs/
    5wJSZWhUjmbHNbtYABAGlfoYJtrFBI3rI3tyOeSexffSAekHPnlIZJWbj3NNvGWu
    /xN+47hwM0inYUoPDOjHtZuX+Jgm58Av1rMsuDL/i41TvkduxxLSWoJPrutUnR0K
    hHOQqDcKoRNUHJXLiJ1kJIs+NaYU6/3ywkeKQdp8T0Zm/W5krcDC8ZRBvhxDFPDe
    0h327lnBBpA5L7rfBXClAQKHtG7KaQ7wTsFGbXYw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=CQf6cWk4 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=uf4Bax5x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=CQf6cWk4 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=uf4Bax5x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOl0y44UipvVbygLBbGbcNFi4HxSKkpTEAb/7vn7ugbNkB0ey7lXM76qHvX9huEw5kxguX4F0rwBmRU+v9yl2U2Qh06H0Aos4+CD8+yjSi6NuaJYsl59
    4pjKvtGzOYe3LgNnf1dz3hmHgtS+3psEPk14bwKiGugcdlQv3oSGX4B2Ifc1Tz5kSzE5ezWVZMeLEaWKANTuU/8+LIWcRL+fuxZDp4MwZDRna0R5u0PX9rXw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yZIbUncRJc3hp2jZsaMA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750775AbeEPSTB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 14:19:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44126 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEPSS5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 14:18:57 -0400
X-Google-Smtp-Source: AB8JxZr9WwQdAdVYvxnsmmlbuwu/SZvXXFy396Gdi8RcLUz+PJDkax9yH758nGgK9zTErzmlUx3tyg==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: patrick.bellasi@arm.com, viresh.kumar@linaro.org,
        tglx@linutronix.de, efault@gmx.de, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: [PATCH] sched/rt: fix call to cpufreq_update_util
Date: Wed, 16 May 2018 20:18:39 +0200
Message-Id: <1526494719-23361-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
schedutil governor uses rq->rt.rt_nr_running to detect whether a RT task is
currently running on the CPU and to set frequency to max if necessary.
cpufreq_update_util() is called in enqueue/dequeue_top_rt_rq() but
rq->rt.rt_nr_running as not been updated yet when dequeue_top_rt_rq() is
called so schedutil still considers that a RT task is running when the
last task is dequeued. The update of rq->rt.rt_nr_running happens later
in dequeue_rt_stack()

Fixes: 8f111bc357aa ('cpufreq/schedutil: Rewrite CPUFREQ_RT support')
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/rt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4..6e74d3d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1001,8 +1001,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
 
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1288,6 +1286,9 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
+
+	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_util(rq_of_rt_rq(rt_rq_of_se(back)), 0);
 }
 
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
-- 
2.7.4
