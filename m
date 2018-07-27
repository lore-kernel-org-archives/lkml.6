Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3078AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A0420671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A0420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeG0Hf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:35:56 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:42064 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeG0Hf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:35:56 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 3868B4CA73FA06F6B8FD;
        Fri, 27 Jul 2018 14:15:35 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6R6FAJI034208;
        Fri, 27 Jul 2018 14:15:10 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072714151885-2117033 ;
          Fri, 27 Jul 2018 14:15:18 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, jgross@suse.com, rostedt@goodmis.org,
        ville.syrjala@linux.intel.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jiang.biao2@zte.com.cn, wang.yi59@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] x86/apic: fix two slight indenting
Date:   Fri, 27 Jul 2018 14:15:03 +0800
Message-Id: <1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-27 14:15:18,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-27 14:14:54,
        Serialize complete at 2018-07-27 14:14:54
X-MAIL: mse01.zte.com.cn w6R6FAJI034208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two inconsistent indenting in calibrate_APIC_clock()
and activate_managed(). Remove the surplus TAB.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/kernel/apic/apic.c   | 2 +-
 arch/x86/kernel/apic/vector.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5071cc7..f222ebc 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -937,7 +937,7 @@ static int __init calibrate_APIC_clock(void)
 
 	if (levt->features & CLOCK_EVT_FEAT_DUMMY) {
 		pr_warning("APIC timer disabled due to verification failure\n");
-			return -1;
+		return -1;
 	}
 
 	return 0;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index b708f59..19e0b2f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -433,7 +433,7 @@ static int activate_managed(struct irq_data *irqd)
 		pr_err("Managed startup irq %u, no vector available\n",
 		       irqd->irq);
 	}
-       return ret;
+	return ret;
 }
 
 static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
-- 
1.8.3.1

