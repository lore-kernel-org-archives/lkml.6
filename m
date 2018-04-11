Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2024894-1523439355-2-11456425618538733830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523439352; b=hixCqTNe5Vsoi8GKBuMwIj7Y1J0ojrKKmj18eGfwrKi+to/elI
    YNKpYwWeghONlG+hDLCRMd3BJa+BN1bMjxqO/x5NccnjrmgGGJRFKaxCz15pNoG0
    PvrsMnEJ3q02dT10n/uDLSI2Czpok9139yQH9etKo7SiYw5p/jYk1lKbycHcZhDs
    WTrz4TzE7fC/+JMApVVzXhw9koseczEsf5PYekOiCOKw/PC29qps740N0JRqf/UU
    EQjAJ9Zi8ImcdSk4FZACRSpqGQxo9osFkPGljO0DdIvrUfP7jq9OZ5P0m4268hcs
    mWTfjqw18tAfnqbSRbLrGqYyfpJVEHnEkG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523439352;
    bh=zf98w4y7Qe1Tvr5gK5BMwYiuHTkdV64478RomIoKkL4=; b=b8CGltb1bm5P
    5mpa9Z0uQRa+axnET5SnCkQBwA8sunEZUqopsBBvIYYwUBrgLZMKPXLdne4qdkNt
    w7IfIxVjy41rLobIOSd1Tpr7RSiD3RwKEhfIeYBlPtTFHD6o14nfthvBsDNSqv62
    BWP2Q7x1rMzyDS9Omdcqr9GgNJtP5uVdHUMFjRF9M+GEB9XFPbV3jnCcqnqfv76E
    oEZfWFRae2B9hotx9jBbghHGognT+GRJogJGu2o3L57kYfGmG07bkbD0r0s83NJG
    oE33NkcTs6ykze1EZL9X7ygCX4zv/xvp4kpLvDVPsNijrr50xjeceH4q4huFiG9L
    Tcb3SbzZVw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEi/qEpzCdgZe+Drgx7cDc9/ulhHYGY59NqmhQeAro3j73IcTJdInv3+YSOpvXKxPKkFqXY0geLaV9d7WIz5aSMzgNNtsLLoFSrfa3r4RFzEMatKHpFX
    pqLsM0qXlOyt3N9QLWZvF5BrE4vNHb0aLC/nmJKHR5l4y26XqihSAbevivtoMHwheqLqVWip6T9VyuTzwHggdiKrvjwCN649KI6DctL8oW0CNo4PNoogJTWZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=PsP4k47zWWuUdRxqlKwA:9
    a=-0pF2RHAvEGB6dfv:21 a=B_2I-GCP0j3xU6E0:21 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeDKJfv convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 11 Apr 2018 05:35:51 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:58706 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeDKJfu (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:7:2>);
        Wed, 11 Apr 2018 05:35:50 -0400
Message-Id: <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 11 Apr 2018 03:15:39 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>,
        "Juergen Gross" <jgross@suse.com>, <hpa@zytor.com>
Cc: <x86@kernel.org>, <xen-devel@lists.xenproject.org>,
        <boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before suspend
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
 <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
In-Reply-To: <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 11.04.18 at 09:08, <jgross@suse.com> wrote:
> On 14/03/18 09:48, Jan Beulich wrote:
>>>>> On 26.02.18 at 15:08, <jgross@suse.com> wrote:
>>> @@ -35,6 +40,9 @@ void xen_arch_post_suspend(int cancelled)
>>>  
>>>  static void xen_vcpu_notify_restore(void *data)
>>>  {
>>> +	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL))
>>> +		wrmsrl(MSR_IA32_SPEC_CTRL, this_cpu_read(spec_ctrl));
>>> +
>>>  	/* Boot processor notified via generic timekeeping_resume() */
>>>  	if (smp_processor_id() == 0)
>>>  		return;
>>> @@ -44,7 +52,15 @@ static void xen_vcpu_notify_restore(void *data)
>>>  
>>>  static void xen_vcpu_notify_suspend(void *data)
>>>  {
>>> +	u64 tmp;
>>> +
>>>  	tick_suspend_local();
>>> +
>>> +	if (xen_pv_domain() && boot_cpu_has(X86_FEATURE_SPEC_CTRL)) {
>>> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
>>> +		this_cpu_write(spec_ctrl, tmp);
>>> +		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>>> +	}
>>>  }
>> 
>> While investigating ways how to do something similar on our old,
>> non-pvops kernels I've started wondering if this solution is actually
>> correct in all cases. Of course discussing this is complicated by the
>> fact that the change there might be a conflict with hasn't landed
>> in Linus'es tree yet (see e.g.
>> https://patchwork.kernel.org/patch/10153843/ for an upstream
>> submission; I haven't been able to find any discussion on that
>> patch or why it isn't upstream yet), but we have it in our various
>> branches. The potential problem I'm seeing is with the clearing
>> and re-setting of SPEC_CTRL around CPUs going idle. While the
>> active CPU could have preemption disabled (if that isn't the case
>> already), the passive CPUs are - afaict - neither under full control
>> of drivers/xen/manage.c:do_suspend() nor excluded yet from
>> any further scheduling activity. Hence with code like this (taken
>> from one of our branches)
>> 
>> static void mwait_idle(void)
>> {
>> 	if (!current_set_polling_and_test()) {
>> 		trace_cpu_idle_rcuidle(1, smp_processor_id());
>> 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
>> 			smp_mb(); /* quirk */
>> 			clflush((void *)&current_thread_info()->flags);
>> 			smp_mb(); /* quirk */
>> 		}
>> 
>> 		x86_disable_ibrs();
>> 
>> 		__monitor((void *)&current_thread_info()->flags, 0, 0);
>> 		if (!need_resched())
>> 			__sti_mwait(0, 0);
>> 		else
>> 			local_irq_enable();
>> 
>> 		x86_enable_ibrs();
>> 		...
>> 
>> the MSR might get set to non-zero again after having been
>> cleared by the code your patch adds. I therefore think that the
>> only race free solution would be to do the clearing from
>> stop-machine context. But maybe I'm overlooking something.
> 
> Currently and with the above mentioned patch there is no problem: Xen pv
> guests always use default_idle(), so mwait_idle() eventually playing
> with MSR_IA32_SPEC_CTRL won't affect us.

It's pretty unclear to me why default_idle() doesn't have this - in
Xen we do it for all idle routines.

> In order to ensure that won't change in future default_idle() should
> never modify MSR_IA32_SPEC_CTRL. In case something like that would be
> required we should rather add another idle function doing that.

This looks like a pretty strange/non-obvious requirement, which I
don't think anyone would remember.

Additionally, x86 maintainers: is there a particular reason this (or
any functionally equivalent patch) isn't upstream yet? As indicated
before, I had not been able to find any discussion, and hence I
see no reason why this is a patch we effectively carry privately in
our distro branches (and likely other distros do so too).

Jan
