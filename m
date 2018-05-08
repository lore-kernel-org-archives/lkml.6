Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2323227-1525761784-2-15806626034064258440
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525761783; b=EpaWlaXzusGbPmJ3ZwgDTQ2f3w4hAPsumCVaOL8Agc4NnN0wmU
    e7ES6SpoE5uBFt+IAJlvQsfOJuZi9w2XO96/4mcsg35wo/Ef5q8I9eypUadEEGJ7
    4i0EQ6wHxPGDTWM+dQQrQuPXABQIdFgPq3rDLkdR/Qy5+I52NxgMavTQo71aIsPL
    pNfCrzCItZwTVsPm3qIDx6ZplEfAzTAGkpM0nffhQXftNzEK/SmBlgI4yqq7EoqP
    b8+dqNKzPRK4wTFFLca6Yv8t5RCnEkLvqvwngaTOXn9oCZQjbF1lE08h1brsVLJ6
    +fxFmtAupqtTWsgUv3B+MUi7wvtaEQFc6WGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525761783; bh=cFk8+Txqjy55E/0Vaan3cj9rftBNqA
    /0H2Tiw/dYhiw=; b=JFnPGZampD+7p+h8hK/GjbSHBxFf5jWWkw0p/Hhyy+Sw7B
    GiG0NqcUTJqHS7/Y0ahMNOGLklvS6XSa4fokarW28FbhIY30O6aGy1Ya8bsjO0HK
    mTIXRxv9cGlYhmP28fmziqfwXMNpb59+SVlF4lZ4ZFMA4dxVK73GX1z6Fy+MZtYP
    UacrFnTb1layxuOpjMKmImh7ilQLov8hsCyYXvhNRYjFlGHbLsESfm8Q7strgZRm
    EbZNopDYC21ZSACMK8DMp2OFUOxIOKeJO9cdDi3Pcy44Yh38DK0SQlNfGJhMBTM7
    RmHyY6IsPNhs89k6tmSJpblMziH0wfisaMfFAt0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=W+dsX5sE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=DBKBM3av;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=W+dsX5sE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=DBKBM3av;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBCzuol5PFWjJNungJdiyCe4yAjny5DEbrrrhwTqEjWUFFnARfM+3jm/vQydIDgGvGOdxSU+LdBVIj4xsj/B15j4Q7hkQiG7kcnjilpF0wQXLR5wopHv
    yKPG4C+hMQECAltMPKN7YNkV/MES7c5I1wDGXWopTvAZ5pt5Sbv7vQ+kGofokPzTuuXud7RRTRm/o7VDbvoePOPc8jDb0FO07NlLYnN9vBqmi267ZcYB8yLH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=KKAkSRfTAAAA:8 a=6yPDNPjGMXjLbBui9nMA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754225AbeEHGmu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 02:42:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37426 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeEHGms (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 02:42:48 -0400
X-Google-Smtp-Source: AB8JxZoeJlQDoiVydAKqt0jCqhEsW215lw8Uzz8WHq96i4/OsiOcVL3UeETBheHRFbiEmKYguEnfOA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        claudio@evidence.eu.com, patrick.bellasi@arm.com,
        juri.lelli@redhat.com, joelaf@google.com,
        "4 . 12+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
Date: Tue,  8 May 2018 12:12:42 +0530
Message-Id: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
occasions:
- In sugov_start(), when the schedutil governor is started for a group
  of CPUs.
- And whenever we need to force a freq update before rate-limit
  duration, which happens when:
  - there is an update in cpufreq policy limits.
  - Or when the utilization of DL scheduling class increases.

In return, get_next_freq() doesn't return a cached next_freq value but
instead recalculates the next frequency. This has some side effects
though and may significantly delay a required increase in frequency.

In sugov_update_single() we try to avoid decreasing frequency if the CPU
has not been idle recently. Consider this scenario, the available range
of frequencies for a CPU are from 800 MHz to 2.5 GHz and current
frequency is 800 MHz. From one of the call paths
sg_policy->need_freq_update is set to true and hence
sg_policy->next_freq is set to UINT_MAX. Now if the CPU had been busy,
next_f will always be less than UINT_MAX, whatever the value of next_f
is. And so even when we wanted to increase the frequency, we will
overwrite next_f with UINT_MAX and will not change the frequency
eventually. This will continue until the time CPU stays busy. This isn't
cross checked with any specific test cases, but rather based on general
code review.

Fix that by not resetting the sg_policy->need_freq_update flag from
sugov_should_update_freq() but get_next_freq() and we wouldn't need to
overwrite sg_policy->next_freq anymore.

Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d2c6083304b4..daaca23697dc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -95,15 +95,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (sg_policy->work_in_progress)
 		return false;
 
-	if (unlikely(sg_policy->need_freq_update)) {
-		sg_policy->need_freq_update = false;
-		/*
-		 * This happens when limits change, so forget the previous
-		 * next_freq value and force an update.
-		 */
-		sg_policy->next_freq = UINT_MAX;
+	if (unlikely(sg_policy->need_freq_update))
 		return true;
-	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -165,8 +158,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = (freq + (freq >> 2)) * util / max;
 
-	if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
+
+	sg_policy->need_freq_update = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
@@ -670,7 +665,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
-	sg_policy->next_freq			= UINT_MAX;
+	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
-- 
2.15.0.194.g9af6a3dea062
