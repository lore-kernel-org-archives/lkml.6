Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585387-1524655614-2-8850946451039804857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524655613; b=WIlA3fsFb5GK15i9J5Z6J0oyLfuaatQDoh+pV2z9HlsVsTNJcr
    FEu58SJAVysLqsJ93VQGolPLJflNyYuMVfBicadKEfeg48cVL/Hmi3S7GiN8EZw9
    p8/R96XA06MWxrGfHV+67CjiyNb7i5kTxLn59mGPOmFXqrDXRayFluIOM6xUHlkz
    DpFfb5zDde+6Fr3ZS8MdbwVDqKD5ROEvNfdoRdHUSkLMJbCEaORU9Me7H+GdPBAI
    Tph9HJFSDGM6cFAw8A4i87VotJFm5AScBtTmFcySILC0jinETJRT3+CC9BCGWgJt
    Vj3Y0/pCpRDbQzFCOlWN0+K76du+Dia254Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524655613;
    bh=A28nSBMoA+TxMsW/RVxKESXCP2raCtwjGUJbfkMs1Hs=; b=OLDskrAY4Xfo
    zCH9G/pPhGHXqdn+CM+8A+phNoDHjO27dfa0wzhFXfrOeem23ggu62yqbSUFgEmN
    n264dQoXsSd6HSjFf7zh4gP1AoarML+UaXM5Yyrr+aZfR0ZhpFwKvqI5gtDyN6SN
    N6YPCSCZ+UJTVRH65u6tjHfO+EreFsdKlmNsDd9oQaNQjV6KW8zWPo2VsveGaEOc
    BD4v5fIoQuSpCK3b8O0wmHCui43+GIZMjkKZmI8lr7bD1pJaaJAfPdfcDOLi5VLd
    /8wVQrPSAzCMD325mU+3YGvrZJiQbWq0oBL+gTj/bo0oFrJgOyOyRbZO2Ia1tmEs
    hHZwFQpTpQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LgjgujKk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ja+11ui7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LgjgujKk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ja+11ui7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCA+Zp+gRLb9CZFEKpel81yGDg5pzj0CF7+079eruOOxZbCD3TM1bTxwfLfbXsm/OVCWhT/bXhT1cXVnioVyHcFRwLyUOnFsQvJ2O+1Ykug+Mrr9ezRp
    +kn0AFm3HfHPcXkSiwKNsf+OzAP50J8LIE9L7gx4XGVUlFi5Z2YDYwyAWY6GPBUQWCqNV8y5523SQNIrpA6kr2ZP+qIgKzdP7bPyB4KMXQzUjVLSafRx0P0i
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=mXOwmpu4K-kA:10 a=Kd1tUaAdevIA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
    a=pGLkceISAAAA:8 a=yDcbQmbxFT0WilZeeYwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDYL0f (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:26:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39678 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeDYL0b (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 07:26:31 -0400
X-Google-Smtp-Source: AIpwx4/IqKYXrycsv4fSjMK0A+6KRSIXoKv0YL1N1KzxOdcRUrE7ZE43jfRW78luEA4Mit9ewQT43A==
Date: Wed, 25 Apr 2018 21:26:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ppaidipe@linux.vnet.ibm.com,
        svaidy@linux.vnet.ibm.com, <stable@vger.kernel.org>
Subject: Re: [PATCH V3] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
Message-ID: <20180425212613.1fc2c468@roar.ozlabs.ibm.com>
In-Reply-To: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018 16:29:31 +0530
Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> wrote:

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

Thanks, this looks good to me. I don't know the code though, so

Acked-by: Nicholas Piggin <npiggin@gmail.com>

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

I still think it would be good to do something about the trylock failure.
It may be rare, but if it happens it could stop the timer and lead to
some rare unpredictable behaviour? Not for this patch, but while you're
looking at the code it would be good to consider it. Just queueing up
another timer seems like it should be enough.

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

Really small nitpick, but you could use cpumask_any there.

Thanks,
Nick


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
