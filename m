Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652553-2-123443471492569628
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
    1524652552; b=TMka200J2uIvv4pfNbT7c7KTwrlebWsUVNWG1j0wD94imRTeXP
    1x8pTEJmxS3JEiuYNDUI4HQ0ssNPgNmPh5+9UPRlYF7r/eMUcZMHAdJf1j4eQgYR
    uhHm8YqCqxq0Id2+ujTgae4Uh/aWCVZxSbH9pDtV+EFy9X41s4xRRU7H82e5VhOI
    p2403EKzuhukfhBwo/acdzYu8+Y+lY3xIn9S+zlXmyZihYcH1eatUeEkVrxQ87zF
    JiNU6ppNIJTJ40xl6Ap4r8ux3vrRm8iabOIHV29z1C+7n8AdyQf03KJiwAW/rV7c
    xs1b5Rt5Sw6XlumKWazmSZihjoaXGl34O8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652552; bh=PWNOQUuyOfK7mRSjXe/UBqmu2XYWe7
    awAF0rvnn61TQ=; b=tCD82Ph/DoJubjheRl0UMrLIpNMoEIl6JBgoDChZpVXggI
    Kh/DfuWVlhaB12+cBpD1Z0zKmIQp7XFLJ2Ji4B9CkH3ARkjyAFO7WFcVlfrNzVg8
    WjPdkKoMpjeh6BOxZVhseSwEQoK15gh30B57q1Wq4f4SnKm2UlKieRuP7gxtM+qc
    9afAfOMvqSAE4psB8XhqeGNuMv7joZQ53Ot6z79eqA/mN6J0cyF1kEVexuA/AlHH
    8HSWbelx7LebwzJGZU5xcdIGYWue0fSnM0Nc27dSO1dVJlE+K4i9q8lVxLufQQ0+
    Pt1lVwL+lbweh1Hp66WS5tZnZJXLCKgabh5AOztg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFBCZ0HpN6jYvk86R553AbIdAexTehXPTPi9zQvnMs28dp8ofGVw2Bj3rMHBJ63hpdQSqZzkJdXiVMERuZ9Hrb8MJ8IXySrQzP0Ax+XWOpwQ3HOkpMNS
    P1319VmWKd57i3697fi3SQcNyujhP8Bb1FxWfG0+cuud1eQiPGZMrc3g2j/1I6oE0vPkz+sBrpUhYCt/K7DM3FCs6/9kaggIaoYZ5XEGoeQXmU9i1XoxjCVn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8
    a=sVFe0RnccWI9uLUoR-gA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeDYKfi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:35:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeDYKez (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Max R . P . Grossmann" <m@max.pm>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4.16 07/26] posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated
Date: Wed, 25 Apr 2018 12:33:16 +0200
Message-Id: <20180425103315.145805470@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

From: Laura Abbott <labbott@redhat.com>

commit c3bca5d450b620dd3d36e14b5e1f43639fd47d6b upstream.

Commit a9445e47d897 ("posix-cpu-timers: Make set_process_cpu_timer()
more robust") moved the check into the 'if' statement. Unfortunately,
it did so on the right side of an && which means that it may get short
circuited and never evaluated. This is easily reproduced with:

$ cat loop.c
void main() {
  struct rlimit res;
  /* set the CPU time limit */
  getrlimit(RLIMIT_CPU,&res);
  res.rlim_cur = 2;
  res.rlim_max = 2;
  setrlimit(RLIMIT_CPU,&res);

  while (1);
}

Which will hang forever instead of being killed. Fix this by pulling the
evaluation out of the if statement but checking the return value instead.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1568337
Fixes: a9445e47d897 ("posix-cpu-timers: Make set_process_cpu_timer() more robust")
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: "Max R . P . Grossmann" <m@max.pm>
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180417215742.2521-1-labbott@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/posix-cpu-timers.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1205,10 +1205,12 @@ void set_process_cpu_timer(struct task_s
 			   u64 *newval, u64 *oldval)
 {
 	u64 now;
+	int ret;
 
 	WARN_ON_ONCE(clock_idx == CPUCLOCK_SCHED);
+	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
 
-	if (oldval && cpu_timer_sample_group(clock_idx, tsk, &now) != -EINVAL) {
+	if (oldval && ret != -EINVAL) {
 		/*
 		 * We are setting itimer. The *oldval is absolute and we update
 		 * it to be relative, *newval argument is relative and we update
