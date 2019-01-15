Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27704C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EBB20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="M5m/R2Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfAOQyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:54:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34372 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbfAOQyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:54:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so3753799qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4omA6+o1yu7/H48n0luRmetqpsByfRL5ZZw4P55JWIo=;
        b=M5m/R2NezGfYZgKnpRsjXNFlQRflY9vIFoyf1R7q8+3C/9+x83y9HEprtU0Nx/qM4b
         UdGWPLTE0e/kTJfXy5gfJjMlbnatG3206Znv34ENc/3NWmwk/SMBMNpn1Qx6w7vL9GbF
         yEetzsE/RiCB+HCY3Ae2cyyqhepaq8TFc23Fd89qhGi/2B4/Tn5Wkfi+L+0sK+Kzirfv
         vt0r7hWrrTRQfaSHDIAyV0rA+sXAn0Giroe5Owh9tUUK4/e9l6yfnGTkC2955ZK0A6Ba
         hksvP0ckVOgesbxS4I4zCsIsvp24S8g0G+JrFH8q9n0c3VtYccMi8lrR4NqjWT1ZX13A
         2BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4omA6+o1yu7/H48n0luRmetqpsByfRL5ZZw4P55JWIo=;
        b=gyBxVh9uUlsHhSlKtsO9LAFJKMsOGPf7jox9Ua9OWSEpZxDfpn+Owf7v4hzp+LD6hm
         2TNsuC/ksk9nBAimJ0vQK/idNMMfEOKOrxsWCkH//a7HI/hiFpfwiaT6R4HfiRLdwlSz
         WKpjlRpDnP7rVo3JnfuLKeG2XWIK/yoaUXJtZ5eQwQKUBDrpRYzFwqzFUs6mZyyWDoGC
         /Ry8p4MN1FSEWtDY80Wsruw2ah6n7lDdweBb61qUkJTAISSYSnNl0PIXy8byKWatP0SS
         f6XNES0ElvLYh25m3SYS76Dcs/ymoWf9PXsGqXA5jfgZ3el5WwyNFaXHVqb2N5UONe5G
         ObHw==
X-Gm-Message-State: AJcUukcGkZLx0xRTW2DFaZBGNJ2H/79SqQ1qsH4CGsDYNLWS8KKOJ/US
        x6hcpDdsgvOP1JHPzONKFX8wVYCkeCIkKQ==
X-Google-Smtp-Source: ALg8bN5PzT9pUzXWHqKXZmfIT2lSUbzooqJI8HvV201W9N+LUl1tH/qTW83A66uUzjOtsWbhGAcK7Q==
X-Received: by 2002:ac8:2b42:: with SMTP id 2mr3512211qtv.255.1547571280224;
        Tue, 15 Jan 2019 08:54:40 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r47sm50204686qtc.77.2019.01.15.08.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:54:39 -0800 (PST)
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
 <20190115163416.GA21622@linux.intel.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <9f1a99a9-a3c0-be89-8501-966e8f45ad8d@lca.pw>
Date:   Tue, 15 Jan 2019 11:54:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190115163416.GA21622@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 11:34 AM, Sean Christopherson wrote:
> On Tue, Jan 15, 2019 at 08:13:22AM +0100, Paolo Bonzini wrote:
>> On 15/01/19 08:04, Qian Cai wrote:
>>>
>>>
>>> On 1/15/19 1:44 AM, Qian Cai wrote:
>>>> compilation warning since v5.0-rc1,
>>>>
>>>> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.17()+0x3171:
>>>> call without frame pointer save/setup
> 
> The warning is complaining about vmx_vcpu_run() in vmx.c, not vmenter.S.
> The rule being "broken" is that a call is made without creating a stack
> frame, and vmx_vmenter() obviously makes no calls.
> 
> E.g., manually running objtool check:
> 
>     $ tools/objtool/objtool check arch/x86/kvm/vmx/vmenter.o
>     $ tools/objtool/objtool check arch/x86/kvm/vmx/vmx.o
>     arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.19()+0x83e: call without frame pointer save/setup
> 
> I put "broken" in quotes because AFAICT we're not actually violating the
> rule.  From tools/objtool/Documentation/stack-validation.txt:
> 
>    If it's a GCC-compiled .c file, the error may be because the function
>    uses an inline asm() statement which has a "call" instruction.  An
>    asm() statement with a call instruction must declare the use of the
>    stack pointer in its output operand.  On x86_64, this means adding
>    the ASM_CALL_CONSTRAINT as an output constraint:
> 
>      asm volatile("call func" : ASM_CALL_CONSTRAINT);
> 
>    Otherwise the stack frame may not get created before the call.
> 
> 
> The asm() blob that calls vmx_vmenter() uses ASM_CALL_CONSTRAINT, and
> the resulting asm output generates a frame pointer, e.g. this is from
> the vmx.o that objtool warns on:
> 
> Dump of assembler code for function vmx_vcpu_run:
>    0x0000000000007440 <+0>:     e8 00 00 00 00  callq  0x7445 <vmx_vcpu_run+5>
>    0x0000000000007445 <+5>:     55      push   %rbp
>    0x0000000000007446 <+6>:     48 89 e5        mov    %rsp,%rbp
> 
> 
> The warning only shows up in certain configs, e.g. I was only able to
> reproduce this using the .config provided by lkp.  Even explicitly
> enabling CONFIG_FRAME_POINTERS and CONFIG_STACK_VALIDATION didn't
> trigger the warning using my usual config.
> 
> And all that being said, I'm pretty sure this isn't related to the call
> to vmx_vmenter() at all, but rather is something that was exposed by
> removing __noclone from vmx_vcpu_run().
> 
> E.g. I still get the warning if I comment out the call to vmx_vmenter,
> it just shifts to something else (and continues to shift I comment out
> more calls).  The warning goes away if I re-add __noclone, regardless
> of whether or not commit 2bcbd406715d ("Revert "compiler-gcc: disable
> -ftracer for __noclone functions"") is applied.

It complained the call right here at the end of vmx_vcpu_run().

"callq 19eb6" in __read_once_size() via atomic_read()

and then jump back to vmx_vcpu_run() again.

/root/linux-debug/arch/x86/kvm/vmx/vmx.c:6650
}
   19e94:       e8 00 00 00 00          callq  19e99 <vmx_vcpu_run.part.21+0x3159>

__read_once_size():
/root/linux-debug/./include/linux/compiler.h:191
   19e99:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
   19ea0:       e8 00 00 00 00          callq  19ea5 <vmx_vcpu_run.part.21+0x3165>
   19ea5:       e9 8b dd ff ff          jmpq   17c35 <vmx_vcpu_run.part.21+0xef5>
   19eaa:       48 8b bd 48 ff ff ff    mov    -0xb8(%rbp),%rdi
   19eb1:       e8 00 00 00 00          callq  19eb6 <vmx_vcpu_run.part.21+0x3176>
   19eb6:       e9 b8 df ff ff          jmpq   17e73 <vmx_vcpu_run.part.21+0x1133>

vmx_vcpu_run():
/root/linux-debug/arch/x86/kvm/vmx/vmx.c:6621
        vcpu->arch.regs_dirty = 0;
   19ebb:       48 89 f7                mov    %rsi,%rdi
   19ebe:       e8 00 00 00 00          callq  19ec3 <vmx_vcpu_run.part.21+0x3183>
   19ec3:       e9 f1 e0 ff ff          jmpq   17fb9 <vmx_vcpu_run.part.21+0x1279>
