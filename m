Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524651330-2-8777798846483769116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524651329; b=dwTB2TDWTWvEYFwa1P1lgNKtZGF+4XBEGGqphT8Fu+7XTJGagf
    GZoGSt+4yGsB0K18LHt2TQ2HFq9MKx4+RYR7OkeEo73GTMe3PxaMufu1oiyBePBn
    uK0BMan83ja4ckO0y9E90g8jYIEP9PmZbsc2rCNhsVg3U9uM5/5V/hS+0sFEu/mr
    dw1JUpzYNlCiHZdWit1nNDJyCMyVMDy1ndL9MetB90pKCewRTIr+vxzehUnRQpcD
    btmH5s5G2N8At3E3dIMYEX2YK0yp04BE2Ofg+YyecbjBBuhZ/P4WJS/jVrXOjDhv
    htxafaNcX7sakcJq8owjH3YGU0cLRLtZLj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524651329; bh=6AbNWJeqk+eE486FMVvORgG1F7Mxhy
    4MBg/C0fXgU8E=; b=QhdjM22mM33nHg6Qp9jYNswueRsa8u8eBQVkKHSKqvI4wJ
    5qoqu5Kr1UNf1DTwTj4XeU2LegrGWd3RyqGzXs7Ch87PQO418Q0c7UgcdAv52ryt
    NrPMved+cctDivxxWQmb3tEDjGxJ2YqX9gFPmY3EwpY/DAvoyNFAJQWURTE4/YDO
    0fofCO8cF4rdd5YnMCUgUQ9Of/jXHYrPP0PJlMelGed4Fd6RDDKAtE1XAVehO+xA
    zGbyMHuwCZ/Ltnf0ppEi8ZOgodSq9y1fbX2lHk58Pq2lYJ6FfaM9roQVfTns4bYH
    f4QlzQacP3UH0uk3Tx+mWoRBAVGYHPDf2DwPBAlg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Sv6S6gZx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hzCMzB18;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Sv6S6gZx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hzCMzB18;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZIuJFpyuPA8VUsJmIG7jSiOi2g+Bq1A4IbG8z6NxE8L3xpaJrXzP7F0AUGGo2jE9Av3N1JDXb6kmoWFp8uLRwslHsO8tatOdwwBkH947m1X3ZQAMsY
    Zt/+mxQsQBaO2aPnxWbQ5phSlK55CEX6/NP0ki2p5lMh5IaqfzN/aQh1iJqZYe9sTXWJhL6bqvShVjxHQ+6oJuf64FFCQuxfRCAbwMzgmcVlCeO/e0N+vmOl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=NxCq5HQFKwa6ujBiczwA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeDYKOv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:14:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38570 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeDYKOu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:14:50 -0400
X-Google-Smtp-Source: AIpwx49Swx18KfE3uA3oc2RTENdNCm/UjJCec0xLKa6rCiVUvaoO6ixAn1Ng55FukqE91oL5XlfDAg==
Date: Wed, 25 Apr 2018 15:44:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, npiggin@gmail.com, linux-pm@vger.kernel.org,
        ppaidipe@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
Message-ID: <20180425101447.eynrhpyait2emzoa@vireshk-i7>
References: <1524646968-526-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180425091701.kxxslgalw3sdpiym@vireshk-i7>
 <a827bf62-efd6-fb8b-86d7-e6b37bcf4a9a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a827bf62-efd6-fb8b-86d7-e6b37bcf4a9a@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25-04-18, 15:32, Shilpasri G Bhat wrote:
> Hi,
> 
> On 04/25/2018 02:47 PM, Viresh Kumar wrote:
> > On 25-04-18, 14:32, Shilpasri G Bhat wrote:
> >> gpstate_timer_handler() uses synchronous smp_call to set the pstate
> >> on the requested core. This causes the below hard lockup:
> >>
> >> [c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
> >> [c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
> >> [c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
> >> [c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
> >> [c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
> >> [c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
> >> [c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
> >> [c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
> >> [c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
> >> [c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
> >> -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
> >> LR = arch_send_call_function_ipi_mask+0x120/0x130
> >> [c000003fe566ba50] [c00000000004876c]
> >> arch_send_call_function_ipi_mask+0x4c/0x130
> >> [c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
> >> [c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
> >> [c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
> >> [c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
> >> [c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
> >> [c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
> >> [c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c
> >>
> >> One way to avoid this is removing the smp-call. We can ensure that the timer
> >> always runs on one of the policy-cpus. If the timer gets migrated to a
> >> cpu outside the policy then re-queue it back on the policy->cpus. This way
> >> we can get rid of the smp-call which was being used to set the pstate
> >> on the policy->cpus.
> >>
> >> Fixes: 7bc54b652f13 (timers, cpufreq/powernv: Initialize the gpstate timer as pinned)
> >> Cc: <stable@vger.kernel.org>        [4.8+]
> >> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> >> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> >> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> >> ---
> >> Changes from V1:
> >> - Remove smp_call in the pstate handler.
> >>
> >>  drivers/cpufreq/powernv-cpufreq.c | 23 ++++++++++++++++++++---
> >>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> >> index 71f8682..dc8ffb5 100644
> >> --- a/drivers/cpufreq/powernv-cpufreq.c
> >> +++ b/drivers/cpufreq/powernv-cpufreq.c
> >> @@ -679,6 +679,25 @@ void gpstate_timer_handler(struct timer_list *t)
> >>  
> >>  	if (!spin_trylock(&gpstates->gpstate_lock))
> >>  		return;
> >> +	/*
> >> +	 * If the timer has migrated to the different cpu then bring
> >> +	 * it back to one of the policy->cpus
> >> +	 */
> >> +	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
> >> +		/*
> >> +		 * Timer should be deleted if policy is inactive.
> >> +		 * If policy is active then re-queue on one of the
> >> +		 * policy->cpus.
> >> +		 */
> > 
> > This looks racy. Shouldn't you guarantee that the timer is already
> > removed in a synchronous way before de-activating the policy ?
> > 
> 
> The timer is deleted in driver->stop_cpu(). So we ensure to remove the timer
> before de-activating the policy.
> 
> 
> >> +		if (!cpumask_empty(policy->cpus)) {
> 
> So are you suggesting to remove ^^ the check for active policy here?
> (I put that as a safety check.)

Either you are sure or you are not, and you don't need a safety check
if you are sure :)

-- 
viresh
