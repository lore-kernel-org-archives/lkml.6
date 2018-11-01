Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7F20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf/DoG7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKBFHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:07:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40605 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeKBFHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:07:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9-v6so9446377pls.7;
        Thu, 01 Nov 2018 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=985vxdhp9iqo8AvoARmsosW7hU6Uu1BYycftAKPx+nA=;
        b=Zf/DoG7dHYUjPEdbm3iYzZb000JY+0eRUcK5RMsIgh+f0u8QTjxtjtd8eQPLIDzCaW
         Y81P3x4y8JdTCSCdmWkPigc1YSEkhMkBIIpunRnY021ruvGI3NAl//o6XYPYEq91Gd2I
         TWZHrBAxgvIrRVkLTHOqTAJqituM1m6i6oyaDxX+ouPaS2EkD98verCMwxP7N2in1FfY
         koFR+SfcGW5XnCtQMnxW+inJHpZ7uiqE2hQgnwb0DOMgXwcFJyrtFY67oQzSH8IxjiIq
         OMrv1+9TFJQvQ5Rkd/Sy0whstzTPBMS0NmGB1+lANAAsDjQCi5wa8U9IuS7N2bG78L0h
         fM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=985vxdhp9iqo8AvoARmsosW7hU6Uu1BYycftAKPx+nA=;
        b=Zyd6/hii5iTlRS9/Sh6RUxeGalH4ZLieNTPm8WaGRLaDvq0cHbLIzxT08BTNSEH4Wm
         71SIKN0SowylVshUM9WEbVgX78hvBYv2FCNJ/s4bORjPOnQiTVqbRuXdSDkKpez/wdX/
         TdR9AetaPz9z3ZP9aatQYILAr4qZvxXrwLJatxX79vkLhzGUeqG6WpqLdOaqSFgZ8CES
         /D20mVuVBh8D/2bdd5dAfBAYZ4qnQ9wU7UrnXFBYjGYUZ93f/37CkSCDzfOeU3TPtXNX
         gPBQQhSjkg5K9wCGGaLNaeSp6GVx8A+DKFFchBQvupGa2YRyMS/9iXPrRMREObi4UM9k
         d2Dg==
X-Gm-Message-State: AGRZ1gLWPzmsmM8sE0eqPPo3O3zZpYNNrPrpiZbYzOM6yZdX/+/CX1Wz
        IZrh3P68fGthwVAW+vXnuLUpT1lA
X-Google-Smtp-Source: AJdET5dLgWvi5vYscNO7W2NpWw4DwOWQDvvF3KNQEREZZHtkMKxK8WWRw4+1BX0ura/zkAErFESVrQ==
X-Received: by 2002:a17:902:7c0b:: with SMTP id x11-v6mr8816523pll.60.1541102566560;
        Thu, 01 Nov 2018 13:02:46 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 3-v6sm33975631pga.12.2018.11.01.13.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 13:02:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH stable 4.9] posix-timers: Sanitize overrun handling
Date:   Thu,  1 Nov 2018 13:02:38 -0700
Message-Id: <1541102558-14839-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]

The posix timer overrun handling is broken because the forwarding functions
can return a huge number of overruns which does not fit in an int. As a
consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
random number generators.

The k_clock::timer_forward() callbacks return a 64 bit value now. Make
k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
accounting is correct. 3Remove the temporary (int) casts.

Add a helper function which clamps the overrun value returned to user space
via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
between 0 and INT_MAX. INT_MAX is an indicator for user space that the
overrun value has been clamped.

Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de
[florian: Make patch apply to v4.9.135]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Thomas, can you review for correctness? Thanks!

 include/linux/posix-timers.h   |  4 ++--
 kernel/time/posix-cpu-timers.c |  2 +-
 kernel/time/posix-timers.c     | 29 +++++++++++++++++++----------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 62d44c176071..e4b8678183f5 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,8 +65,8 @@ struct k_itimer {
 	spinlock_t it_lock;
 	clockid_t it_clock;		/* which timer type */
 	timer_t it_id;			/* timer id */
-	int it_overrun;			/* overrun on pending signal  */
-	int it_overrun_last;		/* overrun on last delivered signal */
+	s64 it_overrun;			/* overrun on pending signal  */
+	s64 it_overrun_last;		/* overrun on last delivered signal */
 	int it_requeue_pending;		/* waiting to requeue this timer */
 #define REQUEUE_PENDING 1
 	int it_sigev_notify;		/* notify word of sigevent struct */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 39008d78927a..21a27bb73587 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -103,7 +103,7 @@ static void bump_cpu_timer(struct k_itimer *timer,
 			continue;
 
 		timer->it.cpu.expires += incr;
-		timer->it_overrun += 1 << i;
+		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fc7c37ad90a0..0e6ed2e7d066 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -355,6 +355,17 @@ static __init int init_posix_timers(void)
 
 __initcall(init_posix_timers);
 
+/*
+ * The siginfo si_overrun field and the return value of timer_getoverrun(2)
+ * are of type int. Clamp the overrun value to INT_MAX
+ */
+static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+{
+	s64 sum = timr->it_overrun_last + (s64)baseval;
+
+	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+}
+
 static void schedule_next_timer(struct k_itimer *timr)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
@@ -362,12 +373,11 @@ static void schedule_next_timer(struct k_itimer *timr)
 	if (timr->it.real.interval.tv64 == 0)
 		return;
 
-	timr->it_overrun += (unsigned int) hrtimer_forward(timer,
-						timer->base->get_time(),
-						timr->it.real.interval);
+	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
+					    timr->it.real.interval);
 
 	timr->it_overrun_last = timr->it_overrun;
-	timr->it_overrun = -1;
+	timr->it_overrun = -1LL;
 	++timr->it_requeue_pending;
 	hrtimer_restart(timer);
 }
@@ -396,7 +406,7 @@ void do_schedule_next_timer(struct siginfo *info)
 		else
 			schedule_next_timer(timr);
 
-		info->si_overrun += timr->it_overrun_last;
+		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
 
 	if (timr)
@@ -491,8 +501,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 					now = ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun += (unsigned int)
-				hrtimer_forward(timer, now,
+			timr->it_overrun += hrtimer_forward(timer, now,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
@@ -633,7 +642,7 @@ SYSCALL_DEFINE3(timer_create, const clockid_t, which_clock,
 	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
-	new_timer->it_overrun = -1;
+	new_timer->it_overrun = -1LL;
 
 	if (timer_event_spec) {
 		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
@@ -762,7 +771,7 @@ common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
 			timr->it_sigev_notify == SIGEV_NONE))
-		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
+		timr->it_overrun += hrtimer_forward(timer, now, iv);
 
 	remaining = __hrtimer_expires_remaining_adjusted(timer, now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -824,7 +833,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timr->it_overrun_last;
+	overrun = timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
 
 	return overrun;
-- 
2.7.4

