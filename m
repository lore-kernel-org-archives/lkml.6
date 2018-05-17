Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1724550-1526541413-2-8548061929090076174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526541412; b=YTxJ3hlJswFItJhErGa2uJxJ/oDmm9jK2apyv87Z5xevPOaMp/
    RibqQx7iJvisxDIaOr+OXIYIQ3x9f5tHkZyCppAgYBJf9suMbUy/AZumP6BWUjJA
    sni22ABYZ6PtwKMwkgUtsWDHJBwLy1pB5qy82UzE2PkENiYPLHQ3tFhxmdu4lj0x
    UrXnQTbHm/4Au2CutvAVD0hkayPT1LekxM6tRfXm5XAeH8DH1pFG3FzhsOY8MRvj
    jzvp9ePDORLmN2KHNw8wNBOeicXSpk4rMFBYQJbwuqgSp4qcHJaLm5y1sG6gyLlO
    oZKDNa1tQ+8gRt4KZTUVzOF7YOIwUF5CNpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526541412; bh=CSkKLVTdxlSa3Cw3FnP5t9YpbHa3SO
    sFzZ2PlgCXSL8=; b=bMiNWSqEhq8wfIgu8/QeAcYJbC7dfsr2TAlmZQ8HaafYUE
    21enDqXbt+0zPaRPbyaYk2EqF67AEFsnf5NytV70NpRWDHmdwjqF0+C6nke0GVXR
    U3nbS1W1rR92anjdQB/i2AjK7MFXqRcYK/HVKawnUdzjznerhRw/lyfKAuUFeP7d
    YteP3FKs+7EMfmO175H7a50dk6Xsp9fqBSXIRzOauiceduIeBXOW+1sSl9+/lrhM
    g0JrLJhnvkPoqE0Bd+TSIInmhRmFcE6xxOoO3sh/YLmiDlCU4airecz1h9X8tGsd
    0jBPkUfa22auP+/XreVOyw9AQJcmogoWbHN+8BkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=FjceO5g7 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=jiVJ0mmf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=FjceO5g7 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=jiVJ0mmf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLLWQxyItw9+ij0pm8eGzPkaEuBm9ndAtlCjF7+61nP0nKc+hpGfFYPDXGunD3ina9Ir4mSu5jfaE790Z9kkYEHD1mCZu7BefhqSkqfzI7/PjBgacib3
    VQmIpxletoMfgG/n3TZjNvJGL/FK+dLrfQJwkV6Se0QbBwfkJikqBmA/n+DpICU94E1OtvUWfdovu/PrulfLNmYHnZjTGSL/nApSnHgdRWZunbxvIbm1Fklh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yZIbUncRJc3hp2jZsaMA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeEQHQv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 03:16:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38007 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeEQHQu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 03:16:50 -0400
X-Google-Smtp-Source: AB8JxZrYWI1/RgeC3tW4s3fa8otHriXuYQIX7FJiTZNDXrKg/DDEiIWIJtu7XT3jlPXpuoLO4oPGQw==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: patrick.bellasi@arm.com, viresh.kumar@linaro.org,
        tglx@linutronix.de, efault@gmx.de, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: [PATCH v2] sched/rt: fix call to cpufreq_update_util
Date: Thu, 17 May 2018 09:16:43 +0200
Message-Id: <1526541403-16380-1-git-send-email-vincent.guittot@linaro.org>
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
- v2:
  - remove blank line

 kernel/sched/rt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4..a9f1119 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1000,9 +1000,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1288,6 +1285,9 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
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
