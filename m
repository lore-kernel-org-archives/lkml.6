Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526282363-2-8414619415508329612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526282362; b=f46D9XiQMp+w7cqazqxU32WrEq5gWiuGw/kMJgFLEzpou7v74x
    SXbFnCEtax3Vw+CGmREIwHnQ4gn3P6qAI7ARc927M9FdY/bBi0Ugg6BXSZJsH9IB
    AoqRTyqZDJSmVjMX9kRQj7rXYu1mTg22DVumyLLwkvVE3TR9qKrZC6oqn4zfVPDy
    DqOjXHcnYfVaQGpGwjNNzbWRq74t05t447B9xqKovFZTzjYNbeK9auv2WtXGGjdV
    y3YGLrF2ezU+q6L8UXkqiBYvLPSGi3x5sYzIHEaG79pTeoziD6oLBe4gfqsbRpgf
    yykyzyTHOyU3UjD8cQr7Vtu4q9TEkQSAKs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526282362; bh=vXH4AXPo8mDf134Xm5NUrzL9eJ+WbU
    cQiZrvWWF5MsU=; b=G5dcmU4H8ADW4G/yBcq+VQGSDofDy82WZ1Em4RZ/fq4AEV
    DS+8qVYx3wRpWdSE088cL7dCi1FVzmM5nJTIoQOdUemcWo133+RV6R7IYaw1wRXE
    30z0lEKodF/auyAYIgi5DHHSQwid6GTso3I3XxQaYSkgkdnajuipk4fQiXZ+si86
    YM1Aa3LvEH11RA+1ejwvzoE77GGX+XAWBfDWQLJ65qzSCi+t4eFKHpbRCJNRxSPB
    MrTQxSbwQbueAcBVfZNeYgInNTrOudKjxJdddiA0NsOuq3Z3O7TlNF5GKUXTif3e
    omtNWtAOsTZV//QHemP7qbVr+YOtCxwS1IcQCWPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=C2OJcZnm x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=C2OJcZnm x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPUBPYfufzbRpFQ4FLX1hL5fSdrhMhp5wf9y75LbvdzXv7cd5xz3+tFF63ZG6Mxd7GKRAG4ZKdfTuhOAlO2Wf6nwa1JCQLo+EI5BZ3M8UQgjclOWbzm/
    oCy0ZLsHjY6snqMRb41tBOHsaDpGH7WgxI/Rtrz19PXE+whyRZKwBWit2lfaWARgEmK8NR3n1ERh/BNnIJweRmiodLC4ga47VeJNv4i/BsH6EnKU4yN5GKwP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=ag1SF4gXAAAA:8 a=raSMeMotBYRQczLOL5AA:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeENHSP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbeENHSN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:18:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 65/72] sched/core: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
Date: Mon, 14 May 2018 08:49:22 +0200
Message-Id: <20180514064827.681254660@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 7281c8dec8a87685cb54d503d8cceef5a0fc2fdd upstream.

> kernel/sched/core.c:6921 cpu_weight_nice_write_s64() warn: potential spectre issue 'sched_prio_to_weight'

Userspace controls @nice, so sanitize the value before using it to
index an array.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -23,6 +23,7 @@
 #include <linux/mmu_context.h>
 #include <linux/module.h>
 #include <linux/nmi.h>
+#include <linux/nospec.h>
 #include <linux/prefetch.h>
 #include <linux/profile.h>
 #include <linux/security.h>
@@ -6873,11 +6874,15 @@ static int cpu_weight_nice_write_s64(str
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
+	int idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
 
-	weight = sched_prio_to_weight[NICE_TO_PRIO(nice) - MAX_RT_PRIO];
+	idx = NICE_TO_PRIO(nice) - MAX_RT_PRIO;
+	idx = array_index_nospec(idx, 40);
+	weight = sched_prio_to_weight[idx];
+
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
 #endif
