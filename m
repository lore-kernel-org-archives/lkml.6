Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1759335-1523430530-2-2763666260581456574
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523430530; b=pPls/lD7nUfCqJ99boxlwQUPpVaexUBtWCFA94Ird5RlNBxGEf
    moaOjBRQdmkBkcRwFwRvMzWM6fzyrpG7I8E1VEOjIF36HLnuDV3KTBXQzDAfBH7V
    U/FNUvN2QtFUB8/BefheJ/Kj0nevnyYCKHglLeCTRJa5rx5KTJeTWoLYXR0+uMn2
    Ea/WrOiDQ2eBD8eOUfqwaePK4CT2AHSe5yiEgwR38HD4AiKre975gisObXVJ61J0
    12Quxte/KkcJvchm6mo4TGZa11W6dJHV+0oynn5qLOIVZG6ytNLDOsd2on+TaizV
    Yc2wxphH8+5JHKZNv9pXo+4UPk5HHwFeFDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523430530;
    bh=4o0U3+PJbGa5yXKayepNe2Oa/NgWK+zGn6rZJD4MIVY=; b=n2QuoXmRnTi8
    aGdQQ0WXlj1HQVFnyKBuSlUjgHlTRLhDUBLs5EtpUr6kXDsheyxEPP2GkT6YSrcm
    67ifo9y2TM4rXbF0+uxVd0yN3cLuOYcAo2wbSoTqAAemur2M+2TiEsm3T94I684b
    GQnpIdZDUQOAlWXkIt2Jbu2MOQv9uBzHDI+Rv/dBiZ2euPpf3wBCYcRLKBH+74K6
    ojyw/CwAeVnwiu2UpB41OQ1Nbl0lHgiv0EOFLy4NkY6CuBTaM2ZQBy/3TXz5keIv
    KtQ9X+WhRFytb2bMrdDJlFfWpskWOo4HCtiDX1t4JrhGqcN+72DhAiGbLfXgEpPF
    UKl1H+5Bag==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfENyQtHUdDcu3+plV8RPo1zFtIDth1xGauEabq1IzWeNaLG2IsEF7uiCy41tqEMbz/eBdiHonjnmPkZydDXKmMMuyF0EKMTiuPXFOXqpyH9n8J+iCF6W
    4YwDPF0aVKLVBx6wm+LVbgGSGD0vN9VWNorl3TMePNvM7arSjfZyRSCm0KGSSpves1Ymd4OMi8F0ezUAmOBhGGCeSUZoeGQ+F6yZicvC/wQbnXxjYRFZegF6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=N4JGzcuXHaGaDQ9-q-EA:9
    a=pOPVjPZvEb-TnH-g:21 a=Gr5wp24HszOoyxBO:21 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeDKHIR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 03:08:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:47270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752706AbeDKHIQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 11 Apr 2018 03:08:16 -0400
Subject: Re: [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before suspend
To: Jan Beulich <JBeulich@suse.com>
Cc: x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org, hpa@zytor.com
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
Date: Wed, 11 Apr 2018 09:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5AA8F00302000078001B15EE@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 09:48, Jan Beulich wrote:
>>>> On 26.02.18 at 15:08, <jgross@suse.com> wrote:
>> @@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled)
>>  
>>  static void xen_vcpu_notify_restore(void *data)
>>  {
>> +	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
>> +		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
>> +
>>  	/* Boot processor notified via generic timekeeping_resume() */
>>  	if (smp_processor_id() == 0)
>>  		return;
>> @@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void *data)
>>  
>>  static void xen_vcpu_notify_suspend(void *data)
>>  {
>> +	u64 tmp;
>> +
>>  	tick_suspend_local();
>> +
>> +	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
>> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>> +		this_cpu_write(spec_ctrl, tmp);
>> +		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>> +	}
>>  }
> 
> While investigating ways how to do something similar on our old,
> non-pvops kernels I've started wondering if this solution is actually
> correct in all cases. Of course discussing this is complicated by the
> fact that the change there might be a conflict with hasn't landed
> in Linus'es tree yet (see e.g.
> https://patchwork.kernel.org/patch/10153843/ for an upstream
> submission; I haven't been able to find any discussion on that
> patch or why it isn't upstream yet), but we have it in our various
> branches. The potential problem I'm seeing is with the clearing
> and re-setting of SPEC_CTRL around CPUs going idle. While the
> active CPU could have preemption disabled (if that isn't the case
> already), the passive CPUs are - afaict - neither under full control
> of drivers/xen/manage.c:do_suspend() nor excluded yet from
> any further scheduling activity. Hence with code like this (taken
> from one of our branches)
> 
> static void mwait_idle(void)
> {
> 	if (!current_set_polling_and_test()) {
> 		trace_cpu_idle_rcuidle(1, smp_processor_id());
> 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
> 			smp_mb(); /* quirk */
> 			clflush((void *)&current_thread_info()->flags);
> 			smp_mb(); /* quirk */
> 		}
> 
> 		x86_disable_ibrs();
> 
> 		__monitor((void *)&current_thread_info()->flags, 0, 0);
> 		if (!need_resched())
> 			__sti_mwait(0, 0);
> 		else
> 			local_irq_enable();
> 
> 		x86_enable_ibrs();
> 		...
> 
> the MSR might get set to non-zero again after having been
> cleared by the code your patch adds. I therefore think that the
> only race free solution would be to do the clearing from
> stop-machine context. But maybe I'm overlooking something.

Currently and with the above mentioned patch there is no problem: Xen pv
guests always use default_idle(), so mwait_idle() eventually playing
with MSR_IA32_SPEC_CTRL won't affect us.

In order to ensure that won't change in future default_idle() should
never modify MSR_IA32_SPEC_CTRL. In case something like that would be
required we should rather add another idle function doing that.


Juergen
