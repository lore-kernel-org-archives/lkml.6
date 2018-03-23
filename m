Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804994-2-7354614039823888486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804993; b=g31aC3YZuDJ6QyT2jrrixp8cte9xdzZv6nffWJUA2yETfLO
    riVadxhT2R7XIPYmhfuEoxuQR3SnIQO+w71lCtt8ONEX+zV6jXJHl5ok9sz5HMQZ
    +jGxK79fM7bhhHe+YyEOVggIzsLSVj/WpYHY7z7JdmKTAOE6u8euk2NR6+l1yo1V
    6uRFnWRaTybaZSFDYdRlmKo0ac5BYdigZFx1Ozu+dN6qAnb28UVB/dWOaD67nrk7
    J4khCFWJD8z69/BGif5m5CbJdLDROupeysCpXgzdpVfmYFpkTPamR7dRY6uckMb7
    rL48ywnB4q9DRZtZP0hdDCkMiVbpoYxqi797HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804993; bh=ncFvSbi9/gQUpVnmsBfCa6wF/X
    cSKYfKGaz42yKj7/Q=; b=jsuhkKF7gcFJ7zH19AVNjs6IHuHi9ZSOh/MX3H+Ce+
    mGP8HfCG356Lvg3flE5IJbNtnjlwEdCztMklW710fxghtqGK5viEP4ihr3IroPph
    DTnmsUzyBXpZKxDGzIyzr/ujLZUJdLbyOaaeBzeSsSTrWMXP+W8M1eipORWo+wts
    D703IUnvSmnZ4fPwEt3/inU+iWUtnbCkLDCCpQg6WbEjXwqKenQyaUaQwuvR13jI
    o6VxJzI2VJOsr3R5ZRAfT5BiSDYyZikekoI7JiVw2eliHvOxfz6w7sDgC5wzLFdb
    HUD0DmjtWHwkNMgiicEGpHKHtdo7/DlHdnA/Kudk8UZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeCWKFG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754854AbeCWKFD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        arnd@arndb.de, y2038@lists.linaro.org, netdev@vger.kernel.org,
        Richard Cochran <richardcochran@gmail.com>,
        john.stultz@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 015/177] time: Change posix clocks ops interfaces to use timespec64
Date: Fri, 23 Mar 2018 10:52:23 +0100
Message-Id: <20180323094205.878895184@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepa Dinamani <deepa.kernel@gmail.com>


[ Upstream commit d340266e19ddb70dbd608f9deedcfb35fdb9d419 ]

struct timespec is not y2038 safe on 32 bit machines.

The posix clocks apis use struct timespec directly and through struct
itimerspec.

Replace the posix clock interfaces to use struct timespec64 and struct
itimerspec64 instead.  Also fix up their implementations accordingly.

Note that the clock_getres() interface has also been changed to use
timespec64 even though this particular interface is not affected by the
y2038 problem. This helps verification for internal kernel code for y2038
readiness by getting rid of time_t/ timeval/ timespec.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: arnd@arndb.de
Cc: y2038@lists.linaro.org
Cc: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: john.stultz@linaro.org
Link: http://lkml.kernel.org/r/1490555058-4603-3-git-send-email-deepa.kernel@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ptp/ptp_clock.c     |   18 +++++++-----------
 include/linux/posix-clock.h |   10 +++++-----
 kernel/time/posix-clock.c   |   34 ++++++++++++++++++++++++----------
 3 files changed, 36 insertions(+), 26 deletions(-)

--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -97,30 +97,26 @@ static s32 scaled_ppm_to_ppb(long ppm)
 
 /* posix clock implementation */
 
-static int ptp_clock_getres(struct posix_clock *pc, struct timespec *tp)
+static int ptp_clock_getres(struct posix_clock *pc, struct timespec64 *tp)
 {
 	tp->tv_sec = 0;
 	tp->tv_nsec = 1;
 	return 0;
 }
 
-static int ptp_clock_settime(struct posix_clock *pc, const struct timespec *tp)
+static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
-	struct timespec64 ts = timespec_to_timespec64(*tp);
 
-	return  ptp->info->settime64(ptp->info, &ts);
+	return  ptp->info->settime64(ptp->info, tp);
 }
 
-static int ptp_clock_gettime(struct posix_clock *pc, struct timespec *tp)
+static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *tp)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
-	struct timespec64 ts;
 	int err;
 
-	err = ptp->info->gettime64(ptp->info, &ts);
-	if (!err)
-		*tp = timespec64_to_timespec(ts);
+	err = ptp->info->gettime64(ptp->info, tp);
 	return err;
 }
 
@@ -133,7 +129,7 @@ static int ptp_clock_adjtime(struct posi
 	ops = ptp->info;
 
 	if (tx->modes & ADJ_SETOFFSET) {
-		struct timespec ts;
+		struct timespec64 ts;
 		ktime_t kt;
 		s64 delta;
 
@@ -146,7 +142,7 @@ static int ptp_clock_adjtime(struct posi
 		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
 			return -EINVAL;
 
-		kt = timespec_to_ktime(ts);
+		kt = timespec64_to_ktime(ts);
 		delta = ktime_to_ns(kt);
 		err = ops->adjtime(ops, delta);
 	} else if (tx->modes & ADJ_FREQUENCY) {
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -59,23 +59,23 @@ struct posix_clock_operations {
 
 	int  (*clock_adjtime)(struct posix_clock *pc, struct timex *tx);
 
-	int  (*clock_gettime)(struct posix_clock *pc, struct timespec *ts);
+	int  (*clock_gettime)(struct posix_clock *pc, struct timespec64 *ts);
 
-	int  (*clock_getres) (struct posix_clock *pc, struct timespec *ts);
+	int  (*clock_getres) (struct posix_clock *pc, struct timespec64 *ts);
 
 	int  (*clock_settime)(struct posix_clock *pc,
-			      const struct timespec *ts);
+			      const struct timespec64 *ts);
 
 	int  (*timer_create) (struct posix_clock *pc, struct k_itimer *kit);
 
 	int  (*timer_delete) (struct posix_clock *pc, struct k_itimer *kit);
 
 	void (*timer_gettime)(struct posix_clock *pc,
-			      struct k_itimer *kit, struct itimerspec *tsp);
+			      struct k_itimer *kit, struct itimerspec64 *tsp);
 
 	int  (*timer_settime)(struct posix_clock *pc,
 			      struct k_itimer *kit, int flags,
-			      struct itimerspec *tsp, struct itimerspec *old);
+			      struct itimerspec64 *tsp, struct itimerspec64 *old);
 	/*
 	 * Optional character device methods:
 	 */
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -300,14 +300,17 @@ out:
 static int pc_clock_gettime(clockid_t id, struct timespec *ts)
 {
 	struct posix_clock_desc cd;
+	struct timespec64 ts64;
 	int err;
 
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
 
-	if (cd.clk->ops.clock_gettime)
-		err = cd.clk->ops.clock_gettime(cd.clk, ts);
+	if (cd.clk->ops.clock_gettime) {
+		err = cd.clk->ops.clock_gettime(cd.clk, &ts64);
+		*ts = timespec64_to_timespec(ts64);
+	}
 	else
 		err = -EOPNOTSUPP;
 
@@ -319,14 +322,17 @@ static int pc_clock_gettime(clockid_t id
 static int pc_clock_getres(clockid_t id, struct timespec *ts)
 {
 	struct posix_clock_desc cd;
+	struct timespec64 ts64;
 	int err;
 
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
 
-	if (cd.clk->ops.clock_getres)
-		err = cd.clk->ops.clock_getres(cd.clk, ts);
+	if (cd.clk->ops.clock_getres) {
+		err = cd.clk->ops.clock_getres(cd.clk, &ts64);
+		*ts = timespec64_to_timespec(ts64);
+	}
 	else
 		err = -EOPNOTSUPP;
 
@@ -337,6 +343,7 @@ static int pc_clock_getres(clockid_t id,
 
 static int pc_clock_settime(clockid_t id, const struct timespec *ts)
 {
+	struct timespec64 ts64 = timespec_to_timespec64(*ts);
 	struct posix_clock_desc cd;
 	int err;
 
@@ -350,7 +357,7 @@ static int pc_clock_settime(clockid_t id
 	}
 
 	if (cd.clk->ops.clock_settime)
-		err = cd.clk->ops.clock_settime(cd.clk, ts);
+		err = cd.clk->ops.clock_settime(cd.clk, &ts64);
 	else
 		err = -EOPNOTSUPP;
 out:
@@ -403,29 +410,36 @@ static void pc_timer_gettime(struct k_it
 {
 	clockid_t id = kit->it_clock;
 	struct posix_clock_desc cd;
+	struct itimerspec64 ts64;
 
 	if (get_clock_desc(id, &cd))
 		return;
 
-	if (cd.clk->ops.timer_gettime)
-		cd.clk->ops.timer_gettime(cd.clk, kit, ts);
-
+	if (cd.clk->ops.timer_gettime) {
+		cd.clk->ops.timer_gettime(cd.clk, kit, &ts64);
+		*ts = itimerspec64_to_itimerspec(&ts64);
+	}
 	put_clock_desc(&cd);
 }
 
 static int pc_timer_settime(struct k_itimer *kit, int flags,
 			    struct itimerspec *ts, struct itimerspec *old)
 {
+	struct itimerspec64 ts64 = itimerspec_to_itimerspec64(ts);
 	clockid_t id = kit->it_clock;
 	struct posix_clock_desc cd;
+	struct itimerspec64 old64;
 	int err;
 
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
 
-	if (cd.clk->ops.timer_settime)
-		err = cd.clk->ops.timer_settime(cd.clk, kit, flags, ts, old);
+	if (cd.clk->ops.timer_settime) {
+		err = cd.clk->ops.timer_settime(cd.clk, kit, flags, &ts64, &old64);
+		if (old)
+			*old = itimerspec64_to_itimerspec(&old64);
+	}
 	else
 		err = -EOPNOTSUPP;
 
