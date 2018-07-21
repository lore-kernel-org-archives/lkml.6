Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEADEECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A9320856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld1qfBAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A9320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbeGUNmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:42:17 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43344 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeGUNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:42:17 -0400
Received: by mail-wr1-f48.google.com with SMTP id b15-v6so13610553wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Wdp6TLA+DaT6ZUV3qrfdTfWouyIgbFeipRRegR5xXS4=;
        b=Ld1qfBATf8RITEDp26/SyIAErbebUo9T5JQGtxWdqJ8cP7gb7Wgb3qBk/EuDb/Ejmv
         faZy+w19CktNm2hyLB01boSPWA0h6XSTowOVriaekMF3td2pKajIpA0ON8R06lhussAd
         bMSYsBAo7NqAp1gGlFAuFspvORY0A+owb2gw+ccLC1Eu4MN2V9hNgQH7P+aNDqhlU6x1
         dTqDpeVW6UtDB/MKwItzB5Zcd/d+vMIgepJDPxl7PNDrz8unuKTSoT9JToZnQAPNwZq/
         BDx1iGUfxhLBEvtTFEhKqe/b8R+lBP7gbwpMhUHVEkIkiwUg6u1iJcs8zVWeSuVdg+9k
         2qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Wdp6TLA+DaT6ZUV3qrfdTfWouyIgbFeipRRegR5xXS4=;
        b=Ar96gqMC5yF9K1yh6TW44MSAmT7cA85H7OnG2hOnUFk1EaVy2mt88zx2JfUyfZOTZ0
         MOoC5GsQvsWRYdQYXRz0m90uFDaHPQ8MGse/E1uG25jQXvgqCweAM3Jr7fOCV57RM6Tt
         ato8pO/W3s6A4l/1yIS0USafTA5pVtHAJj+M1Blq9XwypYN2pRot2zpA/MIeYSkuY9Ly
         MrRXcLm631OXb6K5FqDHqLb01U9rHWI10GUPNT7KQDcorzaCrN9Op2MKQb7FKuNyM4Jh
         dkPGM3oY2TLfmk1sWqKPZnJpTTXePCiy/CGVq4y1ChMezBdD3jvfvp9zzBB6O3G3pEem
         p+0w==
X-Gm-Message-State: AOUpUlE0HZbsXFcslsN+bc9/QpB54CQWbDVJ+wg3hh90gwPmO4Heg588
        WrTJGaY3Mu71ux5UB0VtQqw=
X-Google-Smtp-Source: AAOMgpctco9OXOyY8Z/IfZp3kUsh01XbIyJUSLmokHCGVG2ZpId4JbjDYvmantJfD/3fHx3VKYiv/A==
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr3862513wrj.166.1532177378822;
        Sat, 21 Jul 2018 05:49:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c124-v6sm4493149wma.47.2018.07.21.05.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 05:49:38 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:49:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20180721124936.GA18668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e117cb52bdb4d376b711bee34af6434c9e314b3b sched/deadline: Fix switched_from_dl() warning

Two fixes: a stop-machine preemption fix and a SCHED_DEADLINE fix.

 Thanks,

	Ingo

------------------>
Isaac J. Manjarres (1):
      stop_machine: Disable preemption when waking two stopper threads

Juri Lelli (1):
      sched/deadline: Fix switched_from_dl() warning


 kernel/sched/deadline.c | 11 ++++++++++-
 kernel/stop_machine.c   |  6 +++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..10c7b51c0d1f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2290,8 +2290,17 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
-	if (!task_on_rq_queued(p))
+	if (!task_on_rq_queued(p)) {
+		/*
+		 * Inactive timer is armed. However, p is leaving DEADLINE and
+		 * might migrate away from this rq while continuing to run on
+		 * some other class. We need to remove its contribution from
+		 * this rq running_bw now, or sub_rq_bw (below) will complain.
+		 */
+		if (p->dl.dl_non_contending)
+			sub_running_bw(&p->dl, &rq->dl);
 		sub_rq_bw(&p->dl, &rq->dl);
+	}
 
 	/*
 	 * We cannot use inactive_task_timer() to invoke sub_running_bw()
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a2c238..1ff523dae6e2 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -270,7 +270,11 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 		goto retry;
 	}
 
-	wake_up_q(&wakeq);
+	if (!err) {
+		preempt_disable();
+		wake_up_q(&wakeq);
+		preempt_enable();
+	}
 
 	return err;
 }
