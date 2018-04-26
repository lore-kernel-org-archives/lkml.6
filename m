Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1849447-1524720741-2-2626512069575018323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524720740; b=S93dBL1norKOW+GSRq9vgtLKpSAjhsBT5WIyVmRRMtmb0JTZpO
    fJ1wyM6gVsBRvj1GU+NxH3dAZIMeccpogSwatRvJCPpgvnVqRlHwS7uSZ3PRy+6E
    EGlyIRzlX8C3DruQzTmvAnRIrkIioJRYFjLAfHiO6++VXmyYAOGS2u30wRFERO7g
    p4NBXIG2ZyAH6htiW6hRs9nDZVsNJff/HXrNqBYA85CeILZAV4VST1EG0PXLMbw8
    yeYCSOvLlK+yqzUmJvMV7oZwecDOoKJGz1n9F7LDiwdKzEpmiea9InGADMYGVN67
    91am8waXx5zFtpxDL1a0voRWaRaOYGpk3qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1524720740; bh=VxnS2Idh4aj/moexw9dvcPm
    E0Q22nZdTooyt8UJ1qTs=; b=PtpHg+AMlife2gv0cfq+CLmUrVFfm+Oi8h7E5jV
    N5eINXxpsNSYxwaWG6IviwmegbxeS7uXRJu8Iq+lwH4Gq5/mdbRtTdbHLxdeV5OV
    kgeK/mSRV5zrr2M5p72l1V0PpFOoLQNUeKvMYzo6CHR4PYo+9havOVuUOSnhn/AK
    LCgSEL4vVYb3G1ugpEYMIKngDqQ7zdtdjysGe5qTDAIi8ijcGbilDAU8ntHVpxlT
    oVtrVMw+zL88Nv0BQ+/lx4AIJzU3InZfwSBySXCkO2EGq9VsSTMT22nbxGg+X9M/
    0A8hABEFTmrx63XJRWPoUt9DmpIHIRIY3TME4rjeItm284g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFx2IGSaeVUJkThvg4F3Dv/eeyxkwzrYtTBrt7U46GZXLKGzsk2NbVuKwirpD6ERJJ01uJ6vkwiNOnybML8cw4EZCw94/6dyQRSzHHqXBA30EbAWUCfJ
    JK2D50LrS2zQ3REXpWGwv8eJ0xfDb3tjsPjqap1QHxAE1TwDX8+PPuJcJboPwtCK9NDlCFgYvoOSzuwaYMyLkFFBWuBMwItv2JZnzlPQ1zsurknSChTWS0uZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=rai-cAetSdCn4RMDmb8A:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeDZFcR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 01:32:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750775AbeDZFcQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 01:32:16 -0400
Date: Thu, 26 Apr 2018 11:02:03 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, npiggin@gmail.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ppaidipe@linux.vnet.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
Reply-To: svaidy@linux.vnet.ibm.com
References: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 18042605-0044-0000-0000-0000054C315B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042605-0045-0000-0000-0000288D34D0
Message-Id: <20180426053203.GA13662@drishya.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804260052
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Shilpa Bhat <shilpa.bhat@linux.vnet.ibm.com> [2018-04-25 16:29:31]:

> gpstate_timer_handler() uses synchronous smp_call to set the pstate
> on the requested core. This causes the below hard lockup:
> 
> [c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
> [c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
> [c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
> [c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
> [c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
> [c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
> [c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
> [c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
> [c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
> [c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
> -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
> LR = arch_send_call_function_ipi_mask+0x120/0x130
> [c000003fe566ba50] [c00000000004876c]
> arch_send_call_function_ipi_mask+0x4c/0x130
> [c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
> [c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
> [c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
> [c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
> [c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
> [c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
> [c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c
> 
> One way to avoid this is removing the smp-call. We can ensure that the timer
> always runs on one of the policy-cpus. If the timer gets migrated to a
> cpu outside the policy then re-queue it back on the policy->cpus. This way
> we can get rid of the smp-call which was being used to set the pstate
> on the policy->cpus.
> 
> Fixes: 7bc54b652f13 (timers, cpufreq/powernv: Initialize the gpstate timer as pinned)
> Cc: <stable@vger.kernel.org>        [4.8+]
> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from V2:
> - Remove the check for active policy while requeing the migrated timer
> Changes from V1:
> - Remove smp_call in the pstate handler.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 71f8682..e368e1f 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -679,6 +679,16 @@ void gpstate_timer_handler(struct timer_list *t)
> 
>  	if (!spin_trylock(&gpstates->gpstate_lock))
>  		return;
> +	/*
> +	 * If the timer has migrated to the different cpu then bring
> +	 * it back to one of the policy->cpus
> +	 */
> +	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
> +		gpstates->timer.expires = jiffies + msecs_to_jiffies(1);
> +		add_timer_on(&gpstates->timer, cpumask_first(policy->cpus));
> +		spin_unlock(&gpstates->gpstate_lock);
> +		return;
> +	}
> 
>  	/*
>  	 * If PMCR was last updated was using fast_swtich then
> @@ -718,10 +728,8 @@ void gpstate_timer_handler(struct timer_list *t)
>  	if (gpstate_idx != gpstates->last_lpstate_idx)
>  		queue_gpstate_timer(gpstates);
> 
> +	set_pstate(&freq_data);
>  	spin_unlock(&gpstates->gpstate_lock);
> -
> -	/* Timer may get migrated to a different cpu on cpu hot unplug */
> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>  }

Fix looks good. 

Acked-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
