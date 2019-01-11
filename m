Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162DC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7C72173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfAKHPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:15:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfAKHP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:15:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B0F4AF70;
        Fri, 11 Jan 2019 07:15:27 +0000 (UTC)
Subject: Re: [PATCH] xen: Fix x86 sched_clock() interface for xen
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hans@knorrie.org,
        stable@vger.kernel.org
References: <20190110100722.11216-1-jgross@suse.com>
 <e7ea12ca-93f1-2421-702b-b55806eb20bd@oracle.com>
 <e98d244f-1257-ed23-26f4-8909900590b4@suse.com>
 <21d24fe0-f9bd-c312-7773-b43a8ff39ef1@oracle.com>
 <d8cc08b1-0ec1-6d12-f0df-a41845a69ea0@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2325af4f-ec68-d775-e5d5-eb0b76bc72fe@suse.com>
Date:   Fri, 11 Jan 2019 08:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d8cc08b1-0ec1-6d12-f0df-a41845a69ea0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2019 00:10, Boris Ostrovsky wrote:
> On 1/10/19 12:17 PM, Boris Ostrovsky wrote:
>> On 1/10/19 11:14 AM, Juergen Gross wrote:
>>> On 10/01/2019 16:34, Boris Ostrovsky wrote:
>>>> On 1/10/19 5:07 AM, Juergen Gross wrote:
>>>>>  
>>>>> +void xen_clocksource_suspend(void)
>>>>> +{
>>>>> +	xen_clock_value_saved = xen_clocksource_read() - xen_sched_clock_offset;
>>>> xen_clock_value_saved = xen_sched_clock() maybe? 
>>> I wanted xen_clocksource_suspend() and xen_clocksource_resume() to
>>> be symmetrical to each other.
>> OK.
>>
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>
>>> In case you are feeling strong about that, I'm not. :-) So in case
>>> you insist on it I can change it. Or you can do so while committing.
> 
> 
> I did some basic testing and noticed this (at loglevel=8):
> 
> [   64.336488] Freezing user space processes ... (elapsed 0.001 seconds)
> done.
> [   64.337805] OOM killer disabled.
> [   64.337814] Freezing remaining freezable tasks ... (elapsed 0.000
> seconds) done.
> [   64.339066] suspending xenstore...
> [   85.888340] xen:grant_table: Grant tables using version 1 layout
> [   64.359729] OOM killer enabled.
> [   64.359736] Restarting tasks ... done.
> 
> 
> Which made me think that perhaps we should do suspend/restore of the
> clocksource as close as possible to HYPERVISOR_suspend() call, e.g. in
> xen_arch_pre_suspend()/xen_arch_post_suspend():
> 
> diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
> index 45fc9caf3880..80ecba3fcc8c 100644
> --- a/arch/x86/xen/suspend.c
> +++ b/arch/x86/xen/suspend.c
> @@ -22,6 +22,7 @@ static DEFINE_PER_CPU(u64, spec_ctrl);
>  
>  void xen_arch_pre_suspend(void)
>  {
> +       xen_clocksource_suspend();
>         xen_save_time_memory_area();
>  
>         if (xen_pv_domain())
> @@ -36,6 +37,7 @@ void xen_arch_post_suspend(int cancelled)
>                 xen_hvm_post_suspend(cancelled);
>  
>         xen_restore_time_memory_area();
> +       xen_clocksource_resume();
>  }
>  
>  static void xen_vcpu_notify_restore(void *data)
> 
> 
> This still has a window of incorrect clock value (you can see it, for
> example, when xen_hvm_post_suspend() does pr_info("Xen HVM callback
> vector for event delivery is enabled\n")), but it's smaller than before.
> In particular, we will make time right before dpm_resume_start() call.

You are right, this is better.

Sending out V2 soon.


Juergen

