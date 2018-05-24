Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162762-2-14874953365543713803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162761; b=DzzNfJBP+43WUtWAe/PBlkZREVMC9wcNEVmkmPSPt6akCKgx8K
    Eeujiq1MazsA38W3vGpc8rBsVlDDSP0GJXgfU38OhM7ocGVwCubMFdD/3N+RENez
    nE/CnoCFR0rF92t42Fnd8IMN76EKYwfj8utfYcfblj1GGx63aKYmpV6ambjd2ZkS
    CWcv1KHU/NWrNTX/XIw2qye59Lg78W2vXhfbwNaS29cPG+Sm9bqmCiWHzaQ2nqfU
    6YLysY0ueWWc+pXbooABtcbQ7BAVKl/cPCt/Wgx/MyXbpgKaFltc0NgO1FrIPRlx
    o6UigA4tiy6ifby3Khmy1oLCoKM8bDNNS6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162761; bh=g7kI4CtDtP/4kEJYNuUgCYT9OrE2zs
    wz2qvdhn1cl1Q=; b=BZZe58Vf/5gXUUJexReal0XIsU4ZpFLQ6glPVYE6ZBewt0
    0upFbKBBJvyiJR98mmcENF2Nme93p0uIQ2I88w1KlFv+cU45L35g+7WyhSitKO2n
    iEU2jAF9r8ZP1DzT4Fyn8XFv+pd0DbA1jLhu663805iAKQgCwVRKZF6qrqRPBnuW
    n7Ho91c5xWRzPpzULL98eaiYltwN9hyTdniEBZl0SQ2RpXvrSfpgFa1JRyURBBhM
    t/iyQGIdPH6rfvheaVMQWenJSlxW+dX19tdbtqCkUF3zBMUw7U3CZAA9u3FCIbwL
    edqzWR1w/bRb3EBaN5T8n2SniX9YpbNqductF/2w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FKh+SM2d x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FKh+SM2d x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNaCHcmJhOW55eEEdxBOwxMdcElpCObm79gyLca1uSrxnZAJWWCDdoI05x7XA1NMfNuDeh7MKLdNyiPHbRVFigrjoIAQNtUZwhYJRkhT0SwZ8VO/XOkG
    0Q1FJ/MrA/2hZMNvIB8q/gjMEZIwWXdz2NKiKPeiDTxtSCS2yx66Oj+gHkcs06jxyK61kD57EGK36TRrtdSVjPWz5O5Z6+LM54hnk859kO4D+tdiD6ZDDBrz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yC-0_ovQAAAA:8 a=ag1SF4gXAAAA:8
    a=hOO4_OUE9rlRsaYWugwA:9 a=VIZvrZIpojMaeOEe:21 a=6KOgs6F8zKPoB8xB:21
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=AjGcO6oz07-iQ99wixmX:22 a=QsnFDINu91a9xkgZirup:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966926AbeEXJqd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966606AbeEXJq3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Daniel Mentz <danielmentz@google.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 4.4 88/92] time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting
Date: Thu, 24 May 2018 11:39:05 +0200
Message-Id: <20180524093207.696336684@linuxfoundation.org>
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

From: John Stultz <john.stultz@linaro.org>

commit 3d88d56c5873f6eebe23e05c3da701960146b801 upstream.

Due to how the MONOTONIC_RAW accumulation logic was handled,
there is the potential for a 1ns discontinuity when we do
accumulations. This small discontinuity has for the most part
gone un-noticed, but since ARM64 enabled CLOCK_MONOTONIC_RAW
in their vDSO clock_gettime implementation, we've seen failures
with the inconsistency-check test in kselftest.

This patch addresses the issue by using the same sub-ns
accumulation handling that CLOCK_MONOTONIC uses, which avoids
the issue for in-kernel users.

Since the ARM64 vDSO implementation has its own clock_gettime
calculation logic, this patch reduces the frequency of errors,
but failures are still seen. The ARM64 vDSO will need to be
updated to include the sub-nanosecond xtime_nsec values in its
calculation for this issue to be completely fixed.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Tested-by: Daniel Mentz <danielmentz@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "stable #4 . 8+" <stable@vger.kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Link: http://lkml.kernel.org/r/1496965462-20003-3-git-send-email-john.stultz@linaro.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[fabrizio: cherry-pick to 4.4. Kept cycle_t type for function
logarithmic_accumulation local variable "interval". Dropped
casting of "interval" variable]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/timekeeper_internal.h |    4 ++--
 kernel/time/timekeeping.c           |   20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -56,7 +56,7 @@ struct tk_read_base {
  *			interval.
  * @xtime_remainder:	Shifted nano seconds left over when rounding
  *			@cycle_interval
- * @raw_interval:	Raw nano seconds accumulated per NTP interval.
+ * @raw_interval:	Shifted raw nano seconds accumulated per NTP interval.
  * @ntp_error:		Difference between accumulated time and NTP time in ntp
  *			shifted nano seconds.
  * @ntp_error_shift:	Shift conversion between clock shifted nano seconds and
@@ -97,7 +97,7 @@ struct timekeeper {
 	cycle_t			cycle_interval;
 	u64			xtime_interval;
 	s64			xtime_remainder;
-	u32			raw_interval;
+	u64			raw_interval;
 	/* The ntp_tick_length() value currently being used.
 	 * This cached copy ensures we consistently apply the tick
 	 * length for an entire tick, as ntp_tick_length may change
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -277,8 +277,7 @@ static void tk_setup_internals(struct ti
 	/* Go back from cycles -> shifted ns */
 	tk->xtime_interval = (u64) interval * clock->mult;
 	tk->xtime_remainder = ntpinterval - tk->xtime_interval;
-	tk->raw_interval =
-		((u64) interval * clock->mult) >> clock->shift;
+	tk->raw_interval = interval * clock->mult;
 
 	 /* if changing clocks, convert xtime_nsec shift units */
 	if (old_clock) {
@@ -1767,7 +1766,7 @@ static cycle_t logarithmic_accumulation(
 						unsigned int *clock_set)
 {
 	cycle_t interval = tk->cycle_interval << shift;
-	u64 raw_nsecs;
+	u64 snsec_per_sec;
 
 	/* If the offset is smaller than a shifted interval, do nothing */
 	if (offset < interval)
@@ -1782,14 +1781,15 @@ static cycle_t logarithmic_accumulation(
 	*clock_set |= accumulate_nsecs_to_secs(tk);
 
 	/* Accumulate raw time */
-	raw_nsecs = (u64)tk->raw_interval << shift;
-	raw_nsecs += tk->raw_time.tv_nsec;
-	if (raw_nsecs >= NSEC_PER_SEC) {
-		u64 raw_secs = raw_nsecs;
-		raw_nsecs = do_div(raw_secs, NSEC_PER_SEC);
-		tk->raw_time.tv_sec += raw_secs;
+	tk->tkr_raw.xtime_nsec += (u64)tk->raw_time.tv_nsec << tk->tkr_raw.shift;
+	tk->tkr_raw.xtime_nsec += tk->raw_interval << shift;
+	snsec_per_sec = (u64)NSEC_PER_SEC << tk->tkr_raw.shift;
+	while (tk->tkr_raw.xtime_nsec >= snsec_per_sec) {
+		tk->tkr_raw.xtime_nsec -= snsec_per_sec;
+		tk->raw_time.tv_sec++;
 	}
-	tk->raw_time.tv_nsec = raw_nsecs;
+	tk->raw_time.tv_nsec = tk->tkr_raw.xtime_nsec >> tk->tkr_raw.shift;
+	tk->tkr_raw.xtime_nsec -= (u64)tk->raw_time.tv_nsec << tk->tkr_raw.shift;
 
 	/* Accumulate error between NTP and clock interval */
 	tk->ntp_error += tk->ntp_tick << shift;
