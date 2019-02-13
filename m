Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC5C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702202147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfBMKJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:09:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfBMKJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:09:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2193A78;
        Wed, 13 Feb 2019 02:09:25 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7205A3F575;
        Wed, 13 Feb 2019 02:09:24 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] genirq: Fix wrong name in request_percpu_nmi() description
Date:   Wed, 13 Feb 2019 10:09:19 +0000
Message-Id: <1550052559-41250-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ready_percpu_nmi() was the previous name of prepare_percpu_nmi(). Update
request_percpu_nmi() comment with the correct function name.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reported-by: Li Wei <liwei391@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Note: This issue is in next, not yet in mainline. Should apply cleanly
on top of next.

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index aea87ec..9ec34a2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2431,8 +2431,8 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
  *	@dev_id: A percpu cookie passed back to the handler function
  *
  *	This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
- *	have to be setup on each CPU by calling ready_percpu_nmi() before being
- *	enabled on the same CPU by using enable_percpu_nmi().
+ *	have to be setup on each CPU by calling prepare_percpu_nmi() before
+ *	being enabled on the same CPU by using enable_percpu_nmi().
  *
  *	Dev_id must be globally unique. It is a per-cpu variable, and
  *	the handler gets called with the interrupted CPU's instance of
--
1.9.1
