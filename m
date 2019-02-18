Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E982085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0Zfensk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbfBRRk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47752 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389178AbfBRRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MZZrwwkT8NdmnqQQiTa9QSaLA6Wn2m6fre47vOP6Xk8=; b=A0ZfenskOiscMsLWInjYPgi3IH
        CaD0kYSA6VtrRVmzA+br8dCJj0uYDl7vj9uVGUHwypcfJ71ZSxbGbv4JP66JnZiKHaHd+Rtbf85eP
        rXZeHjfIdakSGPvLUlLN4ueVp90nOdiBRy+2bOF6yrNzyab6PKjVk44RzvIdj6qLdMdtmmhlfEfzE
        KB/zECMS+RUzw2khYcT8PqoT+mTCNPSAxLFjpXVwsPvPNbIFBIM/58hA0IFFKfTU3TsvfQya4HvCv
        P1+uTO5ZKH2j1DJwgIXPHCFKlOvZvCuWcHakbazPZqTrF66vgR/Gs+8l16WLN6LhCRwYps0deWLIi
        TCVyjIMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu1-0001Eo-A9; Mon, 18 Feb 2019 17:40:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1952A2848B873; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.005018444@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 02/16] sched: Fix kerneldoc comment for ia64_set_curr_task
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6256,7 +6256,7 @@ struct task_struct *curr_task(int cpu)
 
 #ifdef CONFIG_IA64
 /**
- * set_curr_task - set the current task for a given CPU.
+ * ia64_set_curr_task - set the current task for a given CPU.
  * @cpu: the processor in question.
  * @p: the task pointer to set.
  *


