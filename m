Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296D3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8DB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFnT1had"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8DB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeGJLm2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:42:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeGJLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SvuSTnNEePDhX5KkxhGMjfZ3Nx5qNa6UkTikew9K8uo=; b=kFnT1hadasu5zxccHMMoBHNpA
        a4P+kBeOoD8nZkpIrXTn7vcLc0jYuJ9g7dFHmRucq6vvs+ZcFE9/apsnixzb6eMQi6B5rF2htS8tD
        SGFYNESW46lmqAem1l0PuqQjUTrCOTBCISrXI+rbVUJN5lf62q5s/QgmIpnLZRRQgByzxZxX3s5eK
        UgUF6PQzExxjv7HHEjg2ObIoCUPEsquWZrYyVSh92Fl2MD1OjuwYcSuLgseZ6Za8v1651uT6TElIY
        c61voeo/boQSsON9F1EWilzeL9XrGfRkyg6xnz5U4VLUanMS5qD7mVb09/bDCX9JWql6YVW764EL/
        NdKmJS9NA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcr24-0004FU-Qp; Tue, 10 Jul 2018 11:42:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DA9920289331; Tue, 10 Jul 2018 13:42:10 +0200 (CEST)
Date:   Tue, 10 Jul 2018 13:42:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next <linux-next@vger.kernel.org>,
        stephen Rothwell <sfr@canb.auug.org.au>,
        mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog/softlockup: Fix SOFTLOCKUP_DETECTOR=n build
Message-ID: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
 <20180709114716.GN2476@hirez.programming.kicks-ass.net>
 <1531159814.6480.11.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531159814.6480.11.camel@abdul.in.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:40:14PM +0530, Abdul Haleem wrote:

> Thanks Peter for the patch, build and boot is fine.
> 
> Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Excellent, Ingo can you stick this in?

---
Subject: watchdog/softlockup: Fix SOFTLOCKUP_DETECTOR=n build
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 9 Jul 2018 13:47:16 +0200

I got confused by all the various CONFIG options here about and
conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR. This
results in a build failure for:

   CONFIG_LOCKUP_DETECTOR=y && CONFIG_SOFTLOCKUP_DETECTOR=n

As reported by Abdul.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>
Cc: mpe <mpe@ellerman.id.au>
Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180709114716.GN2476@hirez.programming.kicks-ass.net
---
 include/linux/nmi.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_bac
 #define sysctl_hardlockup_all_cpu_backtrace 0
 #endif /* !CONFIG_SMP */
 
-extern int lockup_detector_online_cpu(unsigned int cpu);
-extern int lockup_detector_offline_cpu(unsigned int cpu);
-
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
-#define lockup_detector_online_cpu	NULL
-#define lockup_detector_offline_cpu	NULL
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(vo
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
 extern unsigned int  softlockup_panic;
-#else
+
+extern int lockup_detector_online_cpu(unsigned int cpu);
+extern int lockup_detector_offline_cpu(unsigned int cpu);
+#else /* CONFIG_SOFTLOCKUP_DETECTOR */
 static inline void touch_softlockup_watchdog_sched(void) { }
 static inline void touch_softlockup_watchdog(void) { }
 static inline void touch_softlockup_watchdog_sync(void) { }
 static inline void touch_all_softlockup_watchdogs(void) { }
-#endif
+
+#define lockup_detector_online_cpu	NULL
+#define lockup_detector_offline_cpu	NULL
+#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
 
 #ifdef CONFIG_DETECT_HUNG_TASK
 void reset_hung_task_detector(void);
