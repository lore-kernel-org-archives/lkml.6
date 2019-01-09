Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2D2146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfAIAEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:04:34 -0500
Received: from ms.lwn.net ([45.79.88.28]:60778 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfAIAEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:04:33 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B722286;
        Wed,  9 Jan 2019 00:04:33 +0000 (UTC)
Date:   Tue, 8 Jan 2019 17:04:32 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douliyangs@gmail.com>
Subject: [PATCH] genirq: fix the kerneldoc comment for struct
 irq_affinity_desc
Message-ID: <20190108170432.59bae8a6@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c410abbbacb9 ("genirq/affinity: Add is_managed to struct
irq_affinity_desc") added a new field but did not update the kerneldoc
comment, leading to this build warning:

  ./include/linux/interrupt.h:268: warning: Function parameter or member 'is_managed' not described in 'irq_affinity_desc'

Add the missing information, making the docs build 0.001% quieter.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..4a728dba02e2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -260,6 +260,7 @@ struct irq_affinity {
 /**
  * struct irq_affinity_desc - Interrupt affinity descriptor
  * @mask:	cpumask to hold the affinity assignment
+ * @is_managed: 1 if the interrupt is managed internally
  */
 struct irq_affinity_desc {
 	struct cpumask	mask;
-- 
2.20.1

