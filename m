Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1878097-1525116681-2-1923761374210697507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116680; b=USjX/Ht0p/C+dW+4hjQXkT4HDFOFiyxDXS1RBWOeyvJCqrPcqE
    YzPYYpKFUH4/d5zfJlZZi/C7bJYl3IWfWX7zgRORGpXrj7SSAEqGGPEA3aE74f0C
    Bxuy0vfoHYeteMAlbied4dcsDM8BHYjCynkowr0RQAUfnMzMb5uKW44s6ZyknGRN
    QM1XGqC+T9+YYKoqHKQaR8ZpAdqSlzr9Mm87mtaNbbwicz8pcCu+jvxczU7tKFdW
    gYZBskHWRLuVL6Oihu01T5EAwmtDhLVNi4oYXQUy2/MwgAe3h1ucoajLlsoB2TcR
    5JWd94BWHDTZfQQHOt61nKrmY8AT8Q3dj2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116680; bh=uO2AL9Yk/MsCuhSVB1nFqMQ9bmYh9Y
    GCreAmxKoWQxE=; b=HZEw8D7Bnne759Q1ERFWb4Ec+FGocq+Itdd9u7pUnIBl8V
    mumtN6pxUXGKaWggx4HZpJM5TYAGN6boCOybTUqygm/6O1vxaTz47qXOOe5bpCk5
    T0+/WTjh6e6a8YCexHjtYTLZl244yy1Zn/hIyzuimU76SDQobSZS4Sr8Xg5DZBOD
    E3ZUEcw+DhcZOhI8ryV8t5KZ9lkjyjd6YGqLDzUbPAkNxmJ72Wt/gPSQ9bCf/Tqd
    fxJJQt+lkweo/T8DD7+tbq5VEHfMB4w+ax0kld25WLELzA37AXKKAY2Sq2J63Cd7
    aghec1Cq6vTn4N40Ua9EvxlvEh4C99FdJffRTLCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFgjjPWMQApfftOQvSHpqVtp/Pl4TcVBRAYAWjFCsnfYBwvaoMHB2aauslYKwL8RfCJfw5/MU2mWc9ShQAvP6/qDaS6dg9pt2OGOKREtFwSXGyLluZln
    uyVFG7XFclub6u/3LHCvFi2CofoGe79AsAu/A58vLIf2rfeAETZIt/npzAwWLDnAemzb+Mor5O7MC3Q/xvIyCcIUg6Paq5QXawTy81JwgzkNGkztDfBGKWes
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
    a=ag1SF4gXAAAA:8 a=ltTupQoCc_Z_9e4zf-QA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeD3T3d (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbeD3T3C (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:29:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338E722DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Wan Kaike" <kaike.wan@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Marciniszyn Mike" <mike.marciniszyn@intel.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-rdma@vger.kernel.org,
        "Dalessandro Dennis" <dennis.dalessandro@intel.com>,
        "Fleck John" <john.fleck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Weiny Ira" <ira.weiny@intel.com>
Subject: [PATCH 4.16 111/113] tick/sched: Do not mess with an enqueued hrtimer
Date: Mon, 30 Apr 2018 12:25:22 -0700
Message-Id: <20180430184019.880363152@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 1f71addd34f4c442bec7d7c749acc1beb58126f2 upstream.

Kaike reported that in tests rdma hrtimers occasionaly stopped working. He
did great debugging, which provided enough context to decode the problem.

CPU 3			     	      	     CPU 2

idle
start sched_timer expires = 712171000000
 queue->next = sched_timer
					    start rdmavt timer. expires = 712172915662
					    lock(baseof(CPU3))
tick_nohz_stop_tick()
tick = 716767000000			    timerqueue_add(tmr)

hrtimer_set_expires(sched_timer, tick);
  sched_timer->expires = 716767000000  <---- FAIL
					     if (tmr->expires < queue->next->expires)
hrtimer_start(sched_timer)		          queue->next = tmr;
lock(baseof(CPU3))
					     unlock(baseof(CPU3))
timerqueue_remove()
timerqueue_add()

ts->sched_timer is queued and queue->next is pointing to it, but then
ts->sched_timer.expires is modified.

This not only corrupts the ordering of the timerqueue RB tree, it also
makes CPU2 see the new expiry time of timerqueue->next->expires when
checking whether timerqueue->next needs to be updated. So CPU2 sees that
the rdma timer is earlier than timerqueue->next and sets the rdma timer as
new next.

Depending on whether it had also seen the new time at RB tree enqueue, it
might have queued the rdma timer at the wrong place and then after removing
the sched_timer the RB tree is completely hosed.

The problem was introduced with a commit which tried to solve inconsistency
between the hrtimer in the tick_sched data and the underlying hardware
clockevent. It split out hrtimer_set_expires() to store the new tick time
in both the NOHZ and the NOHZ + HIGHRES case, but missed the fact that in
the NOHZ + HIGHRES case the hrtimer might still be queued.

Use hrtimer_start(timer, tick...) for the NOHZ + HIGHRES case which sets
timer->expires after canceling the timer and move the hrtimer_set_expires()
invocation into the NOHZ only code path which is not affected as it merily
uses the hrtimer as next event storage so code pathes can be shared with
the NOHZ + HIGHRES case.

Fixes: d4af6d933ccf ("nohz: Fix spurious warning when hrtimer and clockevent get out of sync")
Reported-by: "Wan Kaike" <kaike.wan@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Cc: "Marciniszyn Mike" <mike.marciniszyn@intel.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-rdma@vger.kernel.org
Cc: "Dalessandro Dennis" <dennis.dalessandro@intel.com>
Cc: "Fleck John" <john.fleck@intel.com>
Cc: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: "Weiny Ira" <ira.weiny@intel.com>
Cc: "linux-rdma@vger.kernel.org"
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1804241637390.1679@nanos.tec.linutronix.de
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1804242119210.1597@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/tick-sched.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -797,12 +797,13 @@ static ktime_t tick_nohz_stop_sched_tick
 		goto out;
 	}
 
-	hrtimer_set_expires(&ts->sched_timer, tick);
-
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
-		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
-	else
+	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
+	} else {
+		hrtimer_set_expires(&ts->sched_timer, tick);
 		tick_program_event(tick, 1);
+	}
+
 out:
 	/*
 	 * Update the estimated sleep length until the next timer
