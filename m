Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524650558-2-2732694134908666904
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524650558; b=uJ97PKjmuDgCGFXHiJleZvv99SF4MHs5srRyvosP9KKh5kNYve
    3z1jOtmNCAD/1NpLJmm9+9Z4IlOWlUlu1f7SbU6XTC3E+G3ozgr2DkyWJEJOj/ry
    4zxrHgjBOoqj2Nn/ag2e997MBRrLZCJL19mtzsmKpRvrINDowjbtMRrjPLc/HaPo
    13sQzxJw/IL4gcxW2od1NP1Rawe8IO9iYJQNkHQN+f8QBgfqwO91UNad/bzUIakA
    ATj/ER60Q3zyoXX91MAmmKg8a8nWoyCsvQFSYLt+KIL2DePFuq+ZyDDkATY5obc/
    pc0qERyqzhSp6lIfJJAO5Cl1wyd9JWsOpkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524650558; bh=kaT78sl/bDF3
    BfuvxA1fQWk8bOrDzm6RjcLa48cMjts=; b=h91c1tIm/+dstwq2Q63olh61fE0V
    Ytliiol5PdWuFlGVtCXxq2q2subPkWg0X56OMs73y0+vwb1cWwT3hjV5GSbSZe/P
    ECFpS4VQ2GaGjiHprzWUowOELK+4G7H4hARWfZOYmISKszyLwERRXlTKZCKzsACw
    /DS/SOjEWirXjoiPBq8RzYyntgSJooVXUcjJAm+ip7OPCK8BnQkva7xbghWbUpWZ
    uXcHYMJoMZuc4cW/1eDcUiqvbP7rrN2ZPhAHgjFhlkcILV6Tzi0SXgyV0YOfCI2I
    VWA1ZLS4KzgPhW9iCmhn3+MJfnQGK3Y5d3S5ALpVC+32lLCV42fFWVGsNA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfE69la9nBVpBMNddaPPFTdoKqZwoNOBjikLO2i8PLvKzq4MVjXq8G4l3ufzECDApxbC8NEPh6hQud9IPkV+wnpU2GC95iDBpMQMQ06hDRQNmWXhvetjp
    Z3aTPS4urirWGb/9wV7UokoTKYx1D/qCCqe8y9UNl2GL3PuHiXP69EsmJgo9MjH/CPmftmAgOY6f69d8vcG0U1s92xciRXtXs7ySyrxOvdkRpw8B/LSdDnKr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=hpfX4-KMHhAuDNqorbwA:9
    a=pILNOxqGKmIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeDYKCf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:02:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751350AbeDYKCe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:02:34 -0400
Subject: Re: [PATCH V2] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1524646968-526-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180425091701.kxxslgalw3sdpiym@vireshk-i7>
Cc: rjw@rjwysocki.net, npiggin@gmail.com, linux-pm@vger.kernel.org,
        ppaidipe@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
        stable@vger.kernel.org
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2018 15:32:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180425091701.kxxslgalw3sdpiym@vireshk-i7>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042510-0040-0000-0000-00000432AA30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042510-0041-0000-0000-00002636DE5C
Message-Id: <a827bf62-efd6-fb8b-86d7-e6b37bcf4a9a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 04/25/2018 02:47 PM, Viresh Kumar wrote:
> On 25-04-18, 14:32, Shilpasri G Bhat wrote:
>> gpstate_timer_handler() uses synchronous smp_call to set the pstate
>> on the requested core. This causes the below hard lockup:
>>
>> [c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
>> [c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
>> [c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
>> [c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
>> [c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
>> [c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
>> [c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
>> [c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
>> [c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
>> [c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
>> -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
>> LR = arch_send_call_function_ipi_mask+0x120/0x130
>> [c000003fe566ba50] [c00000000004876c]
>> arch_send_call_function_ipi_mask+0x4c/0x130
>> [c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
>> [c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
>> [c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
>> [c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
>> [c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
>> [c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
>> [c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c
>>
>> One way to avoid this is removing the smp-call. We can ensure that the timer
>> always runs on one of the policy-cpus. If the timer gets migrated to a
>> cpu outside the policy then re-queue it back on the policy->cpus. This way
>> we can get rid of the smp-call which was being used to set the pstate
>> on the policy->cpus.
>>
>> Fixes: 7bc54b652f13 (timers, cpufreq/powernv: Initialize the gpstate timer as pinned)
>> Cc: <stable@vger.kernel.org>        [4.8+]
>> Reported-by: Nicholas Piggin <npiggin@gmail.com>
>> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>> Changes from V1:
>> - Remove smp_call in the pstate handler.
>>
>>  drivers/cpufreq/powernv-cpufreq.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 71f8682..dc8ffb5 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -679,6 +679,25 @@ void gpstate_timer_handler(struct timer_list *t)
>>  
>>  	if (!spin_trylock(&gpstates->gpstate_lock))
>>  		return;
>> +	/*
>> +	 * If the timer has migrated to the different cpu then bring
>> +	 * it back to one of the policy->cpus
>> +	 */
>> +	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
>> +		/*
>> +		 * Timer should be deleted if policy is inactive.
>> +		 * If policy is active then re-queue on one of the
>> +		 * policy->cpus.
>> +		 */
> 
> This looks racy. Shouldn't you guarantee that the timer is already
> removed in a synchronous way before de-activating the policy ?
> 

The timer is deleted in driver->stop_cpu(). So we ensure to remove the timer
before de-activating the policy.


>> +		if (!cpumask_empty(policy->cpus)) {

So are you suggesting to remove ^^ the check for active policy here?
(I put that as a safety check.)

Thanks and Regards,
Shilpa

>> +			gpstates->timer.expires = jiffies +
>> +						msecs_to_jiffies(1);
>> +			add_timer_on(&gpstates->timer,
>> +					cpumask_first(policy->cpus));
>> +		}
>> +		spin_unlock(&gpstates->gpstate_lock);
>> +		return;
>> +	}
>>  
>>  	/*
>>  	 * If PMCR was last updated was using fast_swtich then
>> @@ -718,10 +737,8 @@ void gpstate_timer_handler(struct timer_list *t)
>>  	if (gpstate_idx != gpstates->last_lpstate_idx)
>>  		queue_gpstate_timer(gpstates);
>>  
>> +	set_pstate(&freq_data);
>>  	spin_unlock(&gpstates->gpstate_lock);
>> -
>> -	/* Timer may get migrated to a different cpu on cpu hot unplug */
>> -	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
>>  }
>>  
>>  /*
>> -- 
>> 1.8.3.1
> 
