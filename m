Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3151962-1526005877-2-18380674898516889466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526005877; b=CJShL5Y39qWY2MMPHDzjhDmXywCIgZ+zUCiX6TlERBPJQgnCC4
    PloQeiebwXy68im1bGBtk+Ngy5CYnB5loH/iVpE8VxxCo9uT329V8A9M+TXmtvLQ
    b2doCW5hljAohTVCrAyRwg/GzSgcstxJ2oph4TOQDjvfxhI810tn/9wHrWnPXFHZ
    d4jbS2mKXQDFiBmTUy+j/E9KzmH011neCgtCPI0LfzNXQf1MTtmMVp/z5gJUiIH9
    24y99uEkgym5Ihk2G2RVvuI0QO6Kc9oc8SJVJEsK35gfp0C2sVxqstCQ5zsyGJyn
    Rzi1MD/lONnFLqtLGm6qLm11HHZQ9dYqFv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1526005877; bh=vG3nvoAZGSxJatQd8VSztA/P9N1l+a9dIOa1IdpXTg
    I=; b=XHY1m4ULcSj2O+2PbbX+mCaAp5hggvYAD1obdVdA9rXoR001TT/DE6PJaU
    M9hMY4329KXDnq0ig8HlvcLl/htmCx3rFbSOGOOR1DB0XDB5JYC7J08Dn92IoJTV
    4SCME4DtSNFck0zVDPWR9R8OkEoyn9ZFzV3mIkAJn2uivoSeKemStV9ptn9ZkUlp
    sqlsuACapHVQd2X8z3AMZNQbGxHl0rFG6EhB24YbaMPhbuQARZq5y0n1EmQjTpb8
    jn24FZMpldLaR97EkP0c90Fnozt/ZH6S3NEncrFPvYg2PuGyVowcQqQcbkArvOh1
    PSf8Dh/MBrD3RmSc0IFsjFu1UOeg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJPYN7fANmvRtdSFD2blLgjiAWNefLQTnSLYi3T6yO1wo51LFuCkbt8qHQuKYjORnnSkbB3+uSb0VwwRLPSaMWsUB54QSGBNy6XuJ7X5PgNyfhh/qPdM
    U4v7AIi+eVyGGRfxiKmTTS5/NKUqFC8sPwzvcy8M/VbaMzkKF3Vq7q2IZYp61Ib9qZ8bWGEUu5pAmJKSqu625NVhNXKGY0T83RMEEVyqldNaqL5k8AujJ3BS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=gPJu0pBYAAAA:8
    a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8 a=U0zfkUukAAAA:8
    a=LFS2ODTSTCrfohXJAcoA:9 a=AlIIF0cMT2hfDT4axODj:22 a=S-HzPIwwDS8t1QcwSuWs:22
    a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22 a=rXRU1dkEVDZ1dOovDhQH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeEKCbP (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 22:31:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36442 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeEKCbO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2018 22:31:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-8-ebiederm@xmission.com>
        <e0a5bde2-7817-3e05-1c8d-c8fa8f6aa5f2@mips.com>
        <8736z0s087.fsf@xmission.com>
        <6811e06d-ac0d-35a6-7d86-57838d5d7f8e@mips.com>
Date: Thu, 10 May 2018 21:31:06 -0500
In-Reply-To: <6811e06d-ac0d-35a6-7d86-57838d5d7f8e@mips.com> (Matt Redfearn's
        message of "Thu, 10 May 2018 08:59:26 +0100")
Message-ID: <87603uordh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGxpv-00043G-LM;;;mid=<87603uordh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/G3kHU/VtO4wj28jvOhsdLgSc3TS+8TqY=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Matt Redfearn <matt.redfearn@mips.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1179 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.5 (0.2%), b_tie_ro: 1.69 (0.1%), parse: 1.01 (0.1%),
        extract_message_metadata: 19 (1.7%), get_uri_detail_list: 2.9 (0.2%),
        tests_pri_-1000: 9 (0.7%), tests_pri_-950: 1.24 (0.1%), tests_pri_-900: 0.97
        (0.1%), tests_pri_-400: 26 (2.2%), check_bayes: 25 (2.1%), b_tokenize: 9
        (0.8%), b_tok_get_all: 9 (0.7%), b_comp_prob: 2.6 (0.2%), b_tok_touch_all:
        3.1 (0.3%), b_finish: 0.54 (0.0%), tests_pri_0: 252 (21.4%),
        check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 3.0 (0.3%),
        tests_pri_500: 864 (73.3%), poll_dns_idle: 851 (72.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [REVIEW][PATCH 08/22] signal/mips: Use force_sig_fault where appropriate
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Matt Redfearn <matt.redfearn@mips.com> writes:

> Hi Eric,
>
> On 10/05/18 03:39, Eric W. Biederman wrote:
>> Matt Redfearn <matt.redfearn@mips.com> writes:
>>
>>> Hi Eric,
>>>
>>> On 20/04/18 15:37, Eric W. Biederman wrote:
>>>> Filling in struct siginfo before calling force_sig_info a tedious and
>>>> error prone process, where once in a great while the wrong fields
>>>> are filled out, and siginfo has been inconsistently cleared.
>>>>
>>>> Simplify this process by using the helper force_sig_fault.  Which
>>>> takes as a parameters all of the information it needs, ensures
>>>> all of the fiddly bits of filling in struct siginfo are done properly
>>>> and then calls force_sig_info.
>>>>
>>>> In short about a 5 line reduction in code for every time force_sig_info
>>>> is called, which makes the calling function clearer.
>>>>
>>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>>> Cc: James Hogan <jhogan@kernel.org>
>>>> Cc: linux-mips@linux-mips.org
>>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>> ---
>>>>    arch/mips/kernel/traps.c | 65 ++++++++++++++----------------------------------
>>>>    arch/mips/mm/fault.c     | 19 ++++----------
>>>>    2 files changed, 23 insertions(+), 61 deletions(-)
>>>>
>>>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>>>> index 967e9e4e795e..66ec4b0b484d 100644
>>>> --- a/arch/mips/kernel/traps.c
>>>> +++ b/arch/mips/kernel/traps.c
>>>> @@ -699,17 +699,11 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
>>>>    asmlinkage void do_ov(struct pt_regs *regs)
>>>>    {
>>>>    	enum ctx_state prev_state;
>>>> -	siginfo_t info;
>>>> -
>>>> -	clear_siginfo(&info);
>>>> -	info.si_signo = SIGFPE;
>>>> -	info.si_code = FPE_INTOVF;
>>>> -	info.si_addr = (void __user *)regs->cp0_epc;
>>>>      	prev_state = exception_enter();
>>>>    	die_if_kernel("Integer overflow", regs);
>>>>    -	force_sig_info(SIGFPE, &info, current);
>>>> +	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
>>>>    	exception_exit(prev_state);
>>>>    }
>>>>    @@ -722,32 +716,27 @@ asmlinkage void do_ov(struct pt_regs *regs)
>>>>    void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
>>>>    		     struct task_struct *tsk)
>>>>    {
>>>> -	struct siginfo si;
>>>> -
>>>> -	clear_siginfo(&si);
>>>> -	si.si_addr = fault_addr;
>>>> -	si.si_signo = SIGFPE;
>>>> +	int si_code;
>>>
>>> This is giving build errors in Linux next
>>> (https://storage.kernelci.org/next/master/next-20180509/mips/defconfig+kselftest/build.log)
>>>
>>> si_code would have ended up as 0 before from the clear_siginfo(), but perhaps
>>
>> And si_code 0 is not a valid si_code to use with a floating point
>> siginfo layout.
>>
>>> int si_code = FPE_FLTUNK;
>>>
>>> Would make a more sensible default?
>>
>> FPE_FLTUNK would make a more sensible default.
>>
>> I seem to remember someone telling me that case can never happen in
>> practice so I have simply not worried about it.  Perhaps I am
>> misremembering this.
>
> It probably can't happen in practise - but the issue is that the
> kernel doesn't even compile because -Werror=maybe-uninitialized
> results in a build error since the compiler can't know that one of the
> branches will definitely be taken to set si_code.

My cross compile work.  So I don't know where that
-Werror=maybe-unitialized comes from.

I agree it is an issue.   I agree that FPE_FLTUNK is one of the good
solutions.  Another is to add a final else where you return without
doing anything.

Right now this looks like mips people issue that I have unearthed.
I could appreciate some guidance on which way mips folks would like to
handle this.

If you can point me to where the fatal error is coming from I will
definitely do something in my tree so that this is not a harmful issue.

Eric
