Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816600-1525939405-2-796484705193275610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525939405; b=a7DIHDTOzXM2XAEvNJE1cfdD6BLMoX3SV/ZIMxBvk3JEOAljrM
    B15yI8W9ZWsVMVEqSdzVh77+YhHBf8dMYeqQm6FsyvbUFrJrcgNCvn6LH+dyWWiX
    PNJH4f+BSPYFkt269fqK1/5W/Byd+XcAAjrNRPMyUswITV4HBN7JR8/jHYLDP3HP
    2bY47xB4lJMKt5vAIvkFiBSK3hYLuNc9Q0/xjdUjhtJLMs5HEj4lzhp6+7wlNQzW
    9QATbLr03mvGE/sihCNb2aKfvdRLIx4jNvJob8ljTkMNDrzj60DlTOvJ74XfnLU6
    N+Zjc/+elDP/a9EWit16oJOPoVpa2Qz9pOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525939405;
    bh=ns1LkFwmgIN9PqQxhb8E3xiDbglTB7NEUxT792msWj4=; b=SQCmYcEceYPB
    BeKDJ6sOKCff/jwTvLBg/V2CJkNxRdld9jBMGe8peMv444yUl/gdgy3IznXoyUAw
    LXctZgGk2i1SfZbNKJQo3gw8Mi5HF+dfmaCbzf3Olhm35XNxTCOdDHYcgVXqzJg5
    Mw4qlbQNn+WsaHzGgSRNKsiR6IheKRRID7ydhh8IgkxPsqHPoiAja0JSh2OxZExu
    hiy1ylmBLYPIT3CxyyhYxBWkUflLuhPu9p4hVdT98rjHUVwRjROdDUUs7ndSE2DG
    7CTLE2DXZ70hfKZDAI5UutgiLTFiKkU985947g3sEtYoWrgSuxYyKjO5bidzU9ib
    Se2Mc39FLQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMnqojx2kYfyhp/GaJCuKWhu+OWbsmCBnq04NScBn+4mEb33rtvL7sFCobgCrRi4/PpfP9SsbhEFxRXrhGCJyUEUWYhAP+AEJm9VdvBFz1m/GNPVugGC
    RZugQ3oHfyf4QFc+kzIdWrz6U6JpvvPjKlDeYOcyUE12V+IHCrPDkZdNCDnFoWIYL/eykOHZIY6/FRSviVLFuimWfJ/D5w7F8zXsPdb0iBQhoqzP61agS+Xm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=gPJu0pBYAAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=PtDNVHqPAAAA:8 a=U0zfkUukAAAA:8 a=VlWI9Dtt_4AkVPwu7f4A:9 a=QEXdDO2ut3YA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22
    a=BpimnaHY1jUKGyF_4-AF:22 a=rXRU1dkEVDZ1dOovDhQH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756543AbeEJIDX (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 04:03:23 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:53274 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753696AbeEJIDU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2018 04:03:20 -0400
Subject: Re: [REVIEW][PATCH 08/22] signal/mips: Use force_sig_fault where
 appropriate
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-8-ebiederm@xmission.com>
 <e0a5bde2-7817-3e05-1c8d-c8fa8f6aa5f2@mips.com> <8736z0s087.fsf@xmission.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <6811e06d-ac0d-35a6-7d86-57838d5d7f8e@mips.com>
Date: Thu, 10 May 2018 08:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8736z0s087.fsf@xmission.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1525939142-637137-8295-345664-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192870
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

On 10/05/18 03:39, Eric W. Biederman wrote:
> Matt Redfearn <matt.redfearn@mips.com> writes:
> 
>> Hi Eric,
>>
>> On 20/04/18 15:37, Eric W. Biederman wrote:
>>> Filling in struct siginfo before calling force_sig_info a tedious and
>>> error prone process, where once in a great while the wrong fields
>>> are filled out, and siginfo has been inconsistently cleared.
>>>
>>> Simplify this process by using the helper force_sig_fault.  Which
>>> takes as a parameters all of the information it needs, ensures
>>> all of the fiddly bits of filling in struct siginfo are done properly
>>> and then calls force_sig_info.
>>>
>>> In short about a 5 line reduction in code for every time force_sig_info
>>> is called, which makes the calling function clearer.
>>>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: James Hogan <jhogan@kernel.org>
>>> Cc: linux-mips@linux-mips.org
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>    arch/mips/kernel/traps.c | 65 ++++++++++++++----------------------------------
>>>    arch/mips/mm/fault.c     | 19 ++++----------
>>>    2 files changed, 23 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>>> index 967e9e4e795e..66ec4b0b484d 100644
>>> --- a/arch/mips/kernel/traps.c
>>> +++ b/arch/mips/kernel/traps.c
>>> @@ -699,17 +699,11 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
>>>    asmlinkage void do_ov(struct pt_regs *regs)
>>>    {
>>>    	enum ctx_state prev_state;
>>> -	siginfo_t info;
>>> -
>>> -	clear_siginfo(&info);
>>> -	info.si_signo = SIGFPE;
>>> -	info.si_code = FPE_INTOVF;
>>> -	info.si_addr = (void __user *)regs->cp0_epc;
>>>      	prev_state = exception_enter();
>>>    	die_if_kernel("Integer overflow", regs);
>>>    -	force_sig_info(SIGFPE, &info, current);
>>> +	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
>>>    	exception_exit(prev_state);
>>>    }
>>>    @@ -722,32 +716,27 @@ asmlinkage void do_ov(struct pt_regs *regs)
>>>    void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
>>>    		     struct task_struct *tsk)
>>>    {
>>> -	struct siginfo si;
>>> -
>>> -	clear_siginfo(&si);
>>> -	si.si_addr = fault_addr;
>>> -	si.si_signo = SIGFPE;
>>> +	int si_code;
>>
>> This is giving build errors in Linux next
>> (https://storage.kernelci.org/next/master/next-20180509/mips/defconfig+kselftest/build.log)
>>
>> si_code would have ended up as 0 before from the clear_siginfo(), but perhaps
> 
> And si_code 0 is not a valid si_code to use with a floating point
> siginfo layout.
> 
>> int si_code = FPE_FLTUNK;
>>
>> Would make a more sensible default?
> 
> FPE_FLTUNK would make a more sensible default.
> 
> I seem to remember someone telling me that case can never happen in
> practice so I have simply not worried about it.  Perhaps I am
> misremembering this.

It probably can't happen in practise - but the issue is that the kernel 
doesn't even compile because -Werror=maybe-uninitialized results in a 
build error since the compiler can't know that one of the branches will 
definitely be taken to set si_code.

Thanks,
Matt

> 
> Eric
> 
