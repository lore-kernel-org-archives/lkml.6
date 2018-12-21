Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F05C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C838F21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545395699;
	bh=8ksbPy8VtJSKJL9RdPz7bzaM8lOXst3bWkTceIfIz+Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FCfH5jWdOvXYrpQjiq3gAxnQvpX78w+l3CrBRkNVT40lC4MvtPprU3kX3vQvb2lXY
	 BzEzyJmAsq3yFmFYstihmnHLACgy+e1Dy71AkgN49AJ+fDNnprlDlQKAGOJ6SFF0Tp
	 SfyNCGp4a56XaFdBaMhfGxukDOElcz0nEU/BWLqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbeLUMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:34:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39903 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390338AbeLUMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:34:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so5095194wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 04:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v73THrGTH48rWXzaWbNFlPMjEaysh2khjnluEZfOoi8=;
        b=ZEm/C0EnY6G3B7sm+9yLEq1FLtdHin0ARgdLzy1VyG51HHFwprRnPmQK7J9kEvo2z0
         uv34Aj3LnN+hsPsbsCs5j7uIt7BjIX0cCB0pk7ii99x5q47DIKnEoWETgfGXpZxpaYFC
         iCCpF3O0xVov8QVs2S3UJ5TsBMr+hedDpAbkpv17Ep2s8cfmz1GXJRQEPDCdPuRGV7U0
         pdb60krpjT7JqQk/lOZ75ekSkXPRcYz5p2jksL15/0EeBqr+ByvgyFg7Pa2TQXuDvqPn
         FssOcQIqUTDLG2fQHPqO6gGFguV4dSp2I7Bye9tsG0vgyk8WsSV7nYeDHeq1CrrzSOeB
         KXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=v73THrGTH48rWXzaWbNFlPMjEaysh2khjnluEZfOoi8=;
        b=KqdpvEIwcWxBBGoJolqdy4hWvriNwHbeAc9Qy/u3w/1y/TOdZXcQwIdYgovC4zF2hQ
         4gBuZsNCLz8l40xnKapWJcGINPwuICc2AkEopSwyg5Sc1xNUtB1kBDbeuOyDYVkDwc9u
         YT5fDCMk21JsJ7LYmCIJsiQ+T/koH+v7q7rU/dAiVTDCsi2bSm+h/rofHcv2bfLSfjMP
         vV8RDPgcOOw9TYOJ5rHR2MOkkuqjufjVr8tsw12aDvYBfJdt8MzKISlKD9EfyYj2irtB
         WstXVIqu4uZgWEr3sY4IJRw9XXRMpaBYbTrnzxWXA8/a9k0EjJnTRu4lqFzcDSCRqRrU
         1mHQ==
X-Gm-Message-State: AJcUukcm2ouKELN73EDgezXbkZ7RsHTBjDnbs6rcWuee/LCMjPD/cDwI
        u8NU0bzB1KWEdp+XctO4Kl4WJur6
X-Google-Smtp-Source: ALg8bN4OWk2YaX5kpcjM5rWXZ23LRg3pc5eoNoSFjviiIDxnXPuzaJ1NaEygiNUuzgweX0UCtCA67A==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr2602336wrn.142.1545395695891;
        Fri, 21 Dec 2018 04:34:55 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y13sm12400033wme.2.2018.12.21.04.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 04:34:55 -0800 (PST)
Date:   Fri, 21 Dec 2018 13:34:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20181221123453.GA102366@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 posix-timers: Fix division by zero bug

Fix a division by zero crash in the posix-timers code.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      posix-timers: Fix division by zero bug


 kernel/time/posix-timers.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bd62b5eeb5a0..31f49ae80f43 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,9 +289,6 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	if (!timr->it_interval)
-		return;
-
 	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
 					    timr->it_interval);
 	hrtimer_restart(timer);
@@ -317,7 +314,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 	if (!timr)
 		return;
 
-	if (timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;
