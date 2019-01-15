Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A22B20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oAWd5c0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbfAOS31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:29:27 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46277 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfAOS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:29:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so4038532qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q3uiCH9uxYo4TJEXEoywBwSuDq52vJPxVCXOYjOcZ8g=;
        b=oAWd5c0byF3fHiJS1JbyjU0TIsDhh3R2k2PrtxuGh1qlXrAheSTRxLua6KyYQ1z0V3
         1K36dnWw9NzkPN/qDY2o1WchAjwOwSH5v5jtyJ52PFT18zPOUrK3GjO4gPMWbn/N7OrN
         jhhHPplm9dcBWqDqE1z/2HRTcbFo5OUqViDJG0TcbA1AMiDYdSX7dxMDLAfv26+3ag0A
         bwUCbec3JuQfR2JIgG3mAD1XIRUeu9FDcIVnsUpfj4r82KeUZowLvN6XD3EONUvCrLUD
         +ZDArxQC94tMGdeOpv/nwrr2FEp8x0YJOe0rgQnsTBTyEcIimGtlmLD6DUN2dmiIjVcF
         2wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3uiCH9uxYo4TJEXEoywBwSuDq52vJPxVCXOYjOcZ8g=;
        b=J1m2KlyBOOb+puI8mZGkSTa8LOvOedASyxA0o8S/TOgOXE284oN2zIEy4B2UzbtQod
         38U7fCNoBXyDp41QKi3MMy8bRxQf+/Qyrg98psf9IZ+JOFcqTYQy4tpJWNY8BJq4DaAH
         frXHDRaEtSFwNNYiNgQ8kaeAxLdd8nZUnu632oYF6JqN9fdEoHvS5Z4vQvZJ9Nw6iR3+
         +4UAdYu0l6z6RrwinPE65yXL+ebNybFPUCuO0035jaulEdsxwAdXzCVl6Gd3fQ88e8QW
         JMDNh2Y81yjE9KhGfE9vPbJRhoDpFvlitOxd24GCxqMCUHM/grzOo2f3yxh8zWfunwpw
         rTEw==
X-Gm-Message-State: AJcUukeplMkPcnMeXmeZ7VvdS1urGrqF5kD2JJOEHSq/flohtqANj5lI
        HBjOsS5X4yKokL/py7HERFsHnkC5PhaAyA==
X-Google-Smtp-Source: ALg8bN7Egs2OCAqEdecPiEABuD2CG9ZKQF8rVI5TGmc3GTk2RPWxN0ySYIwpeMiyQOKuoxgdIQHJHw==
X-Received: by 2002:a0c:e40a:: with SMTP id o10mr3876534qvl.197.1547576964263;
        Tue, 15 Jan 2019 10:29:24 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 128sm26360164qkn.77.2019.01.15.10.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:29:23 -0800 (PST)
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
 <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
 <20190115174845.GB21622@linux.intel.com>
 <20190115174953.GC21622@linux.intel.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <0d8d7e5a-193a-393e-6c43-899135252164@lca.pw>
Date:   Tue, 15 Jan 2019 13:29:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190115174953.GC21622@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 12:49 PM, Sean Christopherson wrote:
> On Tue, Jan 15, 2019 at 09:48:45AM -0800, Sean Christopherson wrote:
>> On Tue, Jan 15, 2019 at 11:43:20AM -0500, Qian Cai wrote:
>>>
>>>
>>> On 1/15/19 2:13 AM, Paolo Bonzini wrote:
>>>> Hmm, maybe like this:
>>>>
>>>> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
>>>> index bcef2c7e9bc4..33122fa9d4bd 100644
>>>> --- a/arch/x86/kvm/vmx/vmenter.S
>>>> +++ b/arch/x86/kvm/vmx/vmenter.S
>>>> @@ -26,19 +26,17 @@ ENTRY(vmx_vmenter)
>>>>  	ret
>>>>
>>>>  2:	vmlaunch
>>>> +3:
>>>>  	ret
>>>>
>>>> -3:	cmpb $0, kvm_rebooting
>>>> -	jne 4f
>>>> -	call kvm_spurious_fault
>>>> -4:	ret
>>>> -
>>>>  	.pushsection .fixup, "ax"
>>>> -5:	jmp 3b
>>>> +4:	cmpb $0, kvm_rebooting
>>>> +	jne 3b
>>>> +	jmp kvm_spurious_fault
>>>>  	.popsection
>>>>
>>>> -	_ASM_EXTABLE(1b, 5b)
>>>> -	_ASM_EXTABLE(2b, 5b)
>>>> +	_ASM_EXTABLE(1b, 4b)
>>>> +	_ASM_EXTABLE(2b, 4b)
>>>>
>>>>  ENDPROC(vmx_vmenter)
>>>
>>> No, that will not work. The problem is in vmx.o where I just sent another patch
>>> for it.
>>>
>>> I can see there are five options to solve it.
>>>
>>> 1) always inline vmx_vcpu_run()
>>> 2) always noinline vmx_vcpu_run()
>>> 3) add -fdiable-ipa-fnsplit option to Makefile for vmx.o
>>> 4) let STACK_FRAME_NON_STANDARD support part.* syntax.
>>
>> What is ".part." and where does it come from?  Searching for information
>> is futile, the term is too generic.
> 
> And never mind, my eyes glazed over -fdiable-ipa-fnsplit.

For example, this works too,

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 69b3a7c30013..990dfc254e71 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -4,7 +4,7 @@ ccflags-y += -Iarch/x86/kvm

 CFLAGS_x86.o := -I.
 CFLAGS_svm.o := -I.
-CFLAGS_vmx.o := -I.
+CFLAGS_vmx.o := -I. -fdisable-tree-fnsplit

 KVM := ../../../virt/kvm

