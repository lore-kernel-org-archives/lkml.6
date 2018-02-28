Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835444-2-5715360070684873091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835443; b=WEn2b6et/9eXoWvv5Bk+krPSWH5FEvB3WJDluEPAtaasb7d
    RNWfm5Przz7Znw/k0YklGno7nhXaxTVznwefuNrICBS6srVfRm3jlF5KoK4LDPKV
    CYOfQj7YmRc1vdXvSayHaLohY39cxVivmz8ulKy70lH9ggklC8ZeDO+ZwVn4suBF
    k5KvA0Cz7AVLh3gLpF2t73sGmwuyO84I6dhzMf3NfR9gsTVDEcjfo5tnT9f//0Da
    aBQ6/+9yJDA4dYTsqsJnEojFjYllTaAj4oLV0v3C3FKZPAqgR2AEYbscaRVz1K3E
    9lo+dyCMBF5ZiDTO18ybs3E6wtG4fu12rgqWkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835443; bh=SpcvM7+QXrPRo7sNcIX
    4M2vkB9ELa0Ky08I8femJifE=; b=YpO6UXByNFi7U5wRu8ht2XaEOxAVbMzk4Uk
    WArowGFRHKIqr+aHBz7CAfyZHWrVMrTPIPyfpRLABfXvkSJ+rUZ2rkhmvJD2kySH
    Uaf8QttJvdsBL/+ZdFB83DZmthX/ySJDCvkd3Ci9CSgkaWTXmPXT0n3Ca+BNp4Sr
    PScPcHeHfLYL3IBAHFyGSM6PQmKusemHioR2BwbBxAf3s9BFYEMuzoD/I0PaSusm
    +FHK9OFfjQzaQiY/9en+jDx8YutqyAfcVFU9QYI28zwUPoIR5nKvcKddT7GhZNkd
    AcJdCPM3KThWlbxqzChsp6zNAW1p1GN9zoJbN+9DhOOzw1T9qMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeB1Qa1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:30:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35158 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934625AbeB1QPK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:10 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "John Stultz" <john.stultz@linaro.org>,
        "Eric Biggers" <ebiggers3@gmail.com>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dmitry Vyukov" <dvyukov@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.766409617@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 117/254] posix-timer: Properly check sigevent->sigev_notify
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Add sig_none variable in common_timer_get(), added earlier upstream
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/posix-timers.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -498,17 +498,22 @@ static struct pid *good_sigevent(sigeven
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
@@ -728,16 +733,17 @@ common_timer_get(struct k_itimer *timr,
 {
 	ktime_t now, remaining, iv;
 	struct hrtimer *timer = &timr->it.real.timer;
+	bool sig_none;
 
 	memset(cur_setting, 0, sizeof(struct itimerspec));
 
+	sig_none = timr->it_sigev_notify == SIGEV_NONE;
 	iv = timr->it.real.interval;
 
 	/* interval timer ? */
 	if (iv.tv64)
 		cur_setting->it_interval = ktime_to_timespec(iv);
-	else if (!hrtimer_active(timer) &&
-		 (timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+	else if (!hrtimer_active(timer) && !sig_none)
 		return;
 
 	now = timer->base->get_time();
@@ -747,8 +753,7 @@ common_timer_get(struct k_itimer *timr,
 	 * timer move the expiry time forward by intervals, so
 	 * expiry is > now.
 	 */
-	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
-	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
+	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
 
 	remaining = ktime_sub(hrtimer_get_expires(timer), now);
@@ -758,7 +763,7 @@ common_timer_get(struct k_itimer *timr,
 		 * A single shot SIGEV_NONE timer must return 0, when
 		 * it is expired !
 		 */
-		if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
+		if (!sig_none)
 			cur_setting->it_value.tv_nsec = 1;
 	} else
 		cur_setting->it_value = ktime_to_timespec(remaining);
@@ -856,7 +861,7 @@ common_timer_set(struct k_itimer *timr,
 	timr->it.real.interval = timespec_to_ktime(new_setting->it_interval);
 
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
+	if (timr->it_sigev_notify == SIGEV_NONE) {
 		/* Setup correct expiry time for relative timers */
 		if (mode == HRTIMER_MODE_REL) {
 			hrtimer_add_expires(timer, timer->base->get_time());
