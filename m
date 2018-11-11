Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC28C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D94223D8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzlS04p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D94223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbeKLIWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390666AbeKLIWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:31 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974842245E;
        Sun, 11 Nov 2018 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975553;
        bh=HnB4iA+mtS2j/i+pMHRMn6Ln8siEqpV/j/Aq80X4yls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzlS04p17+PsmvZEBM05rDmz1O8VK5Jki5rLBgry0+uGcrLG+wj7r6zPWwkZGu10V
         GfeaNZ5705hJ3fEZ2UwJonp0xrDin7QOlmSrij0vn20gNrH2bsKzky43G8cnTACsZK
         gFrT2be7Gsvp1Qgk48ONoDHkgSho43kRrK3dZRd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/222] kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()
Date:   Sun, 11 Nov 2018 14:22:43 -0800
Message-Id: <20181111221653.865026982@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 819319fc93461c07b9cdb3064f154bd8cfd48172 ]

Make reuse_unused_kprobe() to return error code if
it fails to reuse unused kprobe for optprobe instead
of calling BUG_ON().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N . Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/153666124040.21306.14150398706331307654.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kprobes.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -700,9 +700,10 @@ static void unoptimize_kprobe(struct kpr
 }
 
 /* Cancel unoptimizing for reusing */
-static void reuse_unused_kprobe(struct kprobe *ap)
+static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
+	int ret;
 
 	BUG_ON(!kprobe_unused(ap));
 	/*
@@ -716,8 +717,12 @@ static void reuse_unused_kprobe(struct k
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
-	BUG_ON(!kprobe_optready(ap));
+	ret = kprobe_optready(ap);
+	if (ret)
+		return ret;
+
 	optimize_kprobe(ap);
+	return 0;
 }
 
 /* Remove optimized instructions */
@@ -942,11 +947,16 @@ static void __disarm_kprobe(struct kprob
 #define kprobe_disarmed(p)			kprobe_disabled(p)
 #define wait_for_kprobe_optimizer()		do {} while (0)
 
-/* There should be no unused kprobes can be reused without optimization */
-static void reuse_unused_kprobe(struct kprobe *ap)
+static int reuse_unused_kprobe(struct kprobe *ap)
 {
+	/*
+	 * If the optimized kprobe is NOT supported, the aggr kprobe is
+	 * released at the same time that the last aggregated kprobe is
+	 * unregistered.
+	 * Thus there should be no chance to reuse unused kprobe.
+	 */
 	printk(KERN_ERR "Error: There should be no unused kprobe here.\n");
-	BUG_ON(kprobe_unused(ap));
+	return -EINVAL;
 }
 
 static void free_aggr_kprobe(struct kprobe *p)
@@ -1320,9 +1330,12 @@ static int register_aggr_kprobe(struct k
 			goto out;
 		}
 		init_aggr_kprobe(ap, orig_p);
-	} else if (kprobe_unused(ap))
+	} else if (kprobe_unused(ap)) {
 		/* This probe is going to die. Rescue it */
-		reuse_unused_kprobe(ap);
+		ret = reuse_unused_kprobe(ap);
+		if (ret)
+			goto out;
+	}
 
 	if (kprobe_gone(ap)) {
 		/*


