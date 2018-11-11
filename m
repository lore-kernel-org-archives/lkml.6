Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9FEC4161B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22EB2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22EB2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeKKR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 12:59:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeKKR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 12:59:02 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gLkpo-000739-IT; Sun, 11 Nov 2018 09:11:08 +0100
Subject: [GIT pull] timer fixes for 4.20
Message-ID: <154192381794.5458.9955754602232301156.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de>
Date:   Sun, 11 Nov 2018 09:11:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

Just the removal of a redundant call into the sched deadline overrun check. 

Thanks,

	tglx

------------------>
Juri Lelli (1):
      posix-cpu-timers: Remove useless call to check_dl_overrun()


 kernel/time/posix-cpu-timers.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ce32cf741b25..8f0644af40be 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
 	struct task_cputime cputime;
 	unsigned long soft;
 
-	if (dl_task(tsk))
-		check_dl_overrun(tsk);
-
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).

