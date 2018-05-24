Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163793-2-11462841302037363070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163792; b=CBGR073DnCyllm3PZAYPFPAvPYIjaYUvKJNsidZa/KVPPI7I4b
    4Dy5Wwo0UE1k2C6p9AcFl0pvMyg3U6K6Vgy0jP70PuazCINQDn9+bKzVcV4UYXUl
    dDuVyoTK5Lzs9RDlkMexmx3zxLzfPRPQW+RJG7wFTbenUjUp4OztsnUal0eGADTD
    uWz1AzjAijkV5dUiD0KpJ727JZTHrrJptoEkp3iXch9VWLeix6c/wnw4lciUyemv
    3xXVgurTBLjpYcNJOuKr5sivokv0jYgeX3Z75xsJTTUdCSymEa4wR2ruvMO94s3e
    bnNH86zk8hK8RxEjWm3Ss1Rb+N2g9pOqnslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163792; bh=iOYworVGMnVd29U8cCmbg8AT13zTNL
    KpHxa6pPcEpjE=; b=dOOYSSKoAFQIQlnHM7atJjEd65kmpAd0rspmr9HkuWdyxp
    1NxFLegkJSmySnxfnhVg2M5pgCT1GVebwAs40uXqWTX2K0R/1iNXp0ri5aQ1RlWi
    PF76ROWjQN2FEwnsbnN4v9B8W3OrwE9UhlQfOcx3kgJmEhqxtdgtVc8h+oyERaRb
    2qLd1zLnQnZFRuHMgJNyP7NbYaq39mV6JMgNou2nhW2W7tgDfsxjor3bU2ITnMCr
    BPMSQNC8ybajhWntNxHUsKt9nQ1CMXqCDXvGLlG71IwOxb6YoJijQK60Vklevs80
    A1b0NHvUS6Oh+VJaEmnhGzWxSZOMpJUS7OcnJfcg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=iEaUO67c x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=iEaUO67c x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBhI2oLhDC+lsPlkaNohAQkY2HEF9uJn4VMDgl7EntCSIIEfdR94U1YJwPu++7QcPLIJRtoKqz47zpkzF3qPVwBuDOgWtN1tzIZl7bXkTYETQWQm1GSq
    ec4uao+cXuxKrLWbKeOrTqt+JGleNdTrtrXDROR3NrhI7NhBcGfQbUBKS9BcmcQSQoMkn77MYVm4mNjLWPtuF51xGU+Mk7zo5eMpHc8c2YKtbNvlLlI+qFKM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1EsaE_6oAAAA:8 a=ag1SF4gXAAAA:8 a=HPPF1rX262DLC8tHIVwA:9
    a=Dxj_QEggxP3A6dkP:21 a=LBhBs1tRF_w2Wzf6:21 a=QEXdDO2ut3YA:10
    a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966534AbeEXMJh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966474AbeEXJnX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 20/92] ALSA: timer: Call notifier in the same spinlock
Date: Thu, 24 May 2018 11:37:57 +0200
Message-Id: <20180524093200.986204525@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f65e0d299807d8a11812845c972493c3f9a18e10 upstream.

snd_timer_notify1() is called outside the spinlock and it retakes the
lock after the unlock.  This is rather racy, and it's safer to move
snd_timer_notify() call inside the main spinlock.

The patch also contains a slight refactoring / cleanup of the code.
Now all start/stop/continue/pause look more symmetric and a bit better
readable.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/timer.c |  220 ++++++++++++++++++++++++-----------------------------
 1 file changed, 102 insertions(+), 118 deletions(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -318,8 +318,6 @@ int snd_timer_open(struct snd_timer_inst
 	return 0;
 }
 
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event);
-
 /*
  * close a timer instance
  */
@@ -408,7 +406,6 @@ unsigned long snd_timer_resolution(struc
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
 	struct snd_timer *timer;
-	unsigned long flags;
 	unsigned long resolution = 0;
 	struct snd_timer_instance *ts;
 	struct timespec tstamp;
@@ -432,34 +429,66 @@ static void snd_timer_notify1(struct snd
 		return;
 	if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 		return;
-	spin_lock_irqsave(&timer->lock, flags);
 	list_for_each_entry(ts, &ti->slave_active_head, active_list)
 		if (ts->ccallback)
 			ts->ccallback(ts, event + 100, &tstamp, resolution);
-	spin_unlock_irqrestore(&timer->lock, flags);
 }
 
-static int snd_timer_start1(struct snd_timer *timer, struct snd_timer_instance *timeri,
-			    unsigned long sticks)
+/* start/continue a master timer */
+static int snd_timer_start1(struct snd_timer_instance *timeri,
+			    bool start, unsigned long ticks)
 {
+	struct snd_timer *timer;
+	int result;
+	unsigned long flags;
+
+	timer = timeri->timer;
+	if (!timer)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer->lock, flags);
+	if (timer->card && timer->card->shutdown) {
+		result = -ENODEV;
+		goto unlock;
+	}
+	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
+			     SNDRV_TIMER_IFLG_START)) {
+		result = -EBUSY;
+		goto unlock;
+	}
+
+	if (start)
+		timeri->ticks = timeri->cticks = ticks;
+	else if (!timeri->cticks)
+		timeri->cticks = 1;
+	timeri->pticks = 0;
+
 	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			goto __start_now;
 		timer->flags |= SNDRV_TIMER_FLG_RESCHED;
 		timeri->flags |= SNDRV_TIMER_IFLG_START;
-		return 1;	/* delayed start */
+		result = 1; /* delayed start */
 	} else {
-		timer->sticks = sticks;
+		if (start)
+			timer->sticks = ticks;
 		timer->hw.start(timer);
 	      __start_now:
 		timer->running++;
 		timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
-		return 0;
+		result = 0;
 	}
+	snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
+	spin_unlock_irqrestore(&timer->lock, flags);
+	return result;
 }
 
-static int snd_timer_start_slave(struct snd_timer_instance *timeri)
+/* start/continue a slave timer */
+static int snd_timer_start_slave(struct snd_timer_instance *timeri,
+				 bool start)
 {
 	unsigned long flags;
 
@@ -473,88 +502,37 @@ static int snd_timer_start_slave(struct
 		spin_lock(&timeri->timer->lock);
 		list_add_tail(&timeri->active_list,
 			      &timeri->master->slave_active_head);
+		snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+				  SNDRV_TIMER_EVENT_CONTINUE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 1; /* delayed start */
 }
 
-/*
- *  start the timer instance
- */
-int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
-{
-	struct snd_timer *timer;
-	int result = -EINVAL;
-	unsigned long flags;
-
-	if (timeri == NULL || ticks < 1)
-		return -EINVAL;
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		result = snd_timer_start_slave(timeri);
-		if (result >= 0)
-			snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-		return result;
-	}
-	timer = timeri->timer;
-	if (timer == NULL)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
-			     SNDRV_TIMER_IFLG_START)) {
-		result = -EBUSY;
-		goto unlock;
-	}
-	timeri->ticks = timeri->cticks = ticks;
-	timeri->pticks = 0;
-	result = snd_timer_start1(timer, timeri, ticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	if (result >= 0)
-		snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-	return result;
-}
-
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event)
+/* stop/pause a master timer */
+static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 {
 	struct snd_timer *timer;
+	int result = 0;
 	unsigned long flags;
 
-	if (snd_BUG_ON(!timeri))
-		return -ENXIO;
-
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		spin_lock_irqsave(&slave_active_lock, flags);
-		if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
-			spin_unlock_irqrestore(&slave_active_lock, flags);
-			return -EBUSY;
-		}
-		if (timeri->timer)
-			spin_lock(&timeri->timer->lock);
-		timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
-		list_del_init(&timeri->ack_list);
-		list_del_init(&timeri->active_list);
-		if (timeri->timer)
-			spin_unlock(&timeri->timer->lock);
-		spin_unlock_irqrestore(&slave_active_lock, flags);
-		goto __end;
-	}
 	timer = timeri->timer;
 	if (!timer)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
 			       SNDRV_TIMER_IFLG_START))) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return -EBUSY;
+		result = -EBUSY;
+		goto unlock;
 	}
 	list_del_init(&timeri->ack_list);
 	list_del_init(&timeri->active_list);
-	if (timer->card && timer->card->shutdown) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return 0;
+	if (timer->card && timer->card->shutdown)
+		goto unlock;
+	if (stop) {
+		timeri->cticks = timeri->ticks;
+		timeri->pticks = 0;
 	}
 	if ((timeri->flags & SNDRV_TIMER_IFLG_RUNNING) &&
 	    !(--timer->running)) {
@@ -569,35 +547,60 @@ static int _snd_timer_stop(struct snd_ti
 		}
 	}
 	timeri->flags &= ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
+	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
 	spin_unlock_irqrestore(&timer->lock, flags);
-      __end:
-	if (event != SNDRV_TIMER_EVENT_RESOLUTION)
-		snd_timer_notify1(timeri, event);
+	return result;
+}
+
+/* stop/pause a slave timer */
+static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&slave_active_lock, flags);
+	if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
+		spin_unlock_irqrestore(&slave_active_lock, flags);
+		return -EBUSY;
+	}
+	timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
+	if (timeri->timer) {
+		spin_lock(&timeri->timer->lock);
+		list_del_init(&timeri->ack_list);
+		list_del_init(&timeri->active_list);
+		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+				  SNDRV_TIMER_EVENT_CONTINUE);
+		spin_unlock(&timeri->timer->lock);
+	}
+	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 0;
 }
 
 /*
+ *  start the timer instance
+ */
+int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
+{
+	if (timeri == NULL || ticks < 1)
+		return -EINVAL;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_start_slave(timeri, true);
+	else
+		return snd_timer_start1(timeri, true, ticks);
+}
+
+/*
  * stop the timer instance.
  *
  * do not call this from the timer callback!
  */
 int snd_timer_stop(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	unsigned long flags;
-	int err;
-
-	err = _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_STOP);
-	if (err < 0)
-		return err;
-	timer = timeri->timer;
-	if (!timer)
-		return -EINVAL;
-	spin_lock_irqsave(&timer->lock, flags);
-	timeri->cticks = timeri->ticks;
-	timeri->pticks = 0;
-	spin_unlock_irqrestore(&timer->lock, flags);
-	return 0;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, true);
+	else
+		return snd_timer_stop1(timeri, true);
 }
 
 /*
@@ -605,32 +608,10 @@ int snd_timer_stop(struct snd_timer_inst
  */
 int snd_timer_continue(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	int result = -EINVAL;
-	unsigned long flags;
-
-	if (timeri == NULL)
-		return result;
 	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
-		return snd_timer_start_slave(timeri);
-	timer = timeri->timer;
-	if (! timer)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & SNDRV_TIMER_IFLG_RUNNING) {
-		result = -EBUSY;
-		goto unlock;
-	}
-	if (!timeri->cticks)
-		timeri->cticks = 1;
-	timeri->pticks = 0;
-	result = snd_timer_start1(timer, timeri, timer->sticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_CONTINUE);
-	return result;
+		return snd_timer_start_slave(timeri, false);
+	else
+		return snd_timer_start1(timeri, false, 0);
 }
 
 /*
@@ -638,7 +619,10 @@ int snd_timer_continue(struct snd_timer_
  */
 int snd_timer_pause(struct snd_timer_instance * timeri)
 {
-	return _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_PAUSE);
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, false);
+	else
+		return snd_timer_stop1(timeri, false);
 }
 
 /*
