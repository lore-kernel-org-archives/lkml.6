Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720285-2-9873847124842886079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720284; b=jHsAtDLWcLulgka3G5oBGjlnZQkYZxJSiYdJIR/Vy1jlTrS
    7nCPP2d44Sf2jVVcdsKlfyUYT1UNovYuI7oGH3rDYgo2GLJCqhV6meMO3xmycNIb
    +QiSnoYGgnh//ZCNn6R1jcRSGzK7XLkzFD+eSg2qGg9wzXPrCKCzdCrPhmifC5Yo
    O1yidz+TjGhQ7dVdcRSTiVG2SHhgurhx5Sd8ncYBZl48WX6/u4uYcury/57Ofd1y
    0YqDI8diFqH9lHigitVADuEETb9TfcIbMwBHi6YyRPQOOCbmd1jneRG/rQUv4fl1
    jdAqdKuDMSxNIGTySWfbmquCLFVIM/QaScGYfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720284; bh=nbvXrHZLfDnT1HlWxz1U1Qq6rp
    EGbd0bG/9ZpkjQb84=; b=nAWyMmCQWMmXnSXn9NbYiaB+hYIhu9DIOqfpdE8JDF
    9yVfxNO3PmBpFxaSAOFhyJlx8EoIpY20NNvZOw+ZT0Z8cE9xxIRBkN33gFzK3S4s
    QjpGzMIjJM/5VtWjz7OugHoO7U/leHv9VkFAt5b2EP9w5yMpwvZ7KnwPvDzUSTeD
    pidtwI4pzWxQRofbMlj4eCb2urFSqyyhiTn51FDC0doMUoUtYOGp2IXS1C/yqG4a
    DIbo1LH0WyNMQ7xOCKSzzP5Aj/c758zKioqnSy3oG7oqZKuoLKnAhNYOdMdU1CYt
    xS+eeZrppeXDrjNRuKM7xZd7kfEtVJRAy7jCmvSmDtNA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162555AbeBOPXG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4.4 047/108] posix-timer: Properly check sigevent->sigev_notify
Date: Thu, 15 Feb 2018 16:16:44 +0100
Message-Id: <20180215151228.997834157@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit cef31d9af908243421258f1df35a4a644604efbe upstream.

timer_create() specifies via sigevent->sigev_notify the signal delivery for
the new timer. The valid modes are SIGEV_NONE, SIGEV_SIGNAL, SIGEV_THREAD
and (SIGEV_SIGNAL | SIGEV_THREAD_ID).

The sanity check in good_sigevent() is only checking the valid combination
for the SIGEV_THREAD_ID bit, i.e. SIGEV_SIGNAL, but if SIGEV_THREAD_ID is
not set it accepts any random value.

This has no real effects on the posix timer and signal delivery code, but
it affects show_timer() which handles the output of /proc/$PID/timers. That
function uses a string array to pretty print sigev_notify. The access to
that array has no bound checks, so random sigev_notify cause access beyond
the array bounds.

Add proper checks for the valid notify modes and remove the SIGEV_THREAD_ID
masking from various code pathes as SIGEV_NONE can never be set in
combination with SIGEV_THREAD_ID.

Reported-by: Eric Biggers <ebiggers3@gmail.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/posix-timers.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -507,17 +507,22 @@ static struct pid *good_sigevent(sigeven
 {
 	struct task_struct *rtn = current->group_leader;
 
-	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
-		(!(rtn = find_task_by_vpid(event->sigev_notify_thread_id)) ||
-		 !same_thread_group(rtn, current) ||
-		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
+	switch (event->sigev_notify) {
+	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
+		rtn = find_task_by_vpid(event->sigev_notify_thread_id);
+		if (!rtn || !same_thread_group(rtn, current))
+			return NULL;
+		/* FALLTHRU */
+	case SIGEV_SIGNAL:
+	case SIGEV_THREAD:
+		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
+			return NULL;
+		/* FALLTHRU */
+	case SIGEV_NONE:
+		return task_pid(rtn);
+	default:
 		return NULL;
-
-	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
-	    ((event->sigev_signo <= 0) || (event->sigev_signo > SIGRTMAX)))
-		return NULL;
-
-	return task_pid(rtn);
+	}
 }
 
 void posix_timers_register_clock(const clockid_t clock_id,
@@ -745,8 +750,7 @@ common_timer_get(struct k_itimer *timr,
 	/* interval timer ? */
 	if (iv.tv64)
 		cur_setting->it_interval = ktime_to_timespec(iv);
-	else if (!hrtimer_active(timer) &&
-		 (timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+	else if (!hrtimer_active(timer) && timr->it_sigev_notify != SIGEV_NONE)
 		return;
 
 	now = timer->base->get_time();
@@ -757,7 +761,7 @@ common_timer_get(struct k_itimer *timr,
 	 * expiry is > now.
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
-	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
+			timr->it_sigev_notify == SIGEV_NONE))
 		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
 
 	remaining = __hrtimer_expires_remaining_adjusted(timer, now);
@@ -767,7 +771,7 @@ common_timer_get(struct k_itimer *timr,
 		 * A single shot SIGEV_NONE timer must return 0, when
 		 * it is expired !
 		 */
-		if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+		if (timr->it_sigev_notify != SIGEV_NONE)
 			cur_setting->it_value.tv_nsec = 1;
 	} else
 		cur_setting->it_value = ktime_to_timespec(remaining);
@@ -865,7 +869,7 @@ common_timer_set(struct k_itimer *timr,
 	timr->it.real.interval = timespec_to_ktime(new_setting->it_interval);
 
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
+	if (timr->it_sigev_notify == SIGEV_NONE) {
 		/* Setup correct expiry time for relative timers */
 		if (mode == HRTIMER_MODE_REL) {
 			hrtimer_add_expires(timer, timer->base->get_time());
