Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2844860-1517588635-2-7667132467361779119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517588634; b=cFvpsTCPzXbu+rboso45I5b1sn5IgUSO4FPh0Nollzj1Gud
    qohyqeAchHAnoo4YTDS8ZfyjnT/Ydt17iZMIlTl0X6gQz+D9+yyi7ppUnC1+n65a
    O/pdd5gZ9WzjY3BEUidkL2bS1rJXcYJoEo17/lTY+iK3H0wgyti7eW8HVrgAqd+y
    pcsfGh5CM1tTL4qzB52j4Tbp2RujOqdJoCVgxHeSvM02SSezGp/YZHVxYFgvECeP
    RSZsSFJqxnqhT58YqWADcRHEXvVjRZibq3vAdrWltrmo2LEyz0rgjTaHUAcpbSgy
    ziMz5ocpL1vjHypmitzI35+Td78n9/GIkK5Or6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517588634; bh=ThWjFzffiYX9qoJbS1PGNWUuj2ionyQb6mxFu7+bOKo=; b=j
    fx0cBH7aIGm9tw9mCPi4yQ9jakkcCK5sJ5iMIfGRy5qOS0Srsj8KL4oPCTuOpnQM
    nyZw5QmnIFZTrYgSIvBEm2yDVmatn63yIKz6R3yGc/ixG8aVNzpOPowC0ObvwIFK
    Lnmmoo9yDpeEmyi2dtcXgT4bku62Uf06u5rSw8Q0LoAwXZWdia1l4u418tBGcq6p
    a/JFn6j7d7FC54qqXeir6kf6Plf5vw23L4Fz6apGtlIIet+L8d7Ax23Cwkcqdyis
    bfoCB+l/EW2s3hLX1YwiQl7t8bpPrEfISzAriT1Wue5kOAbxKd6BktXW3DghmydT
    hvwFZ3WSeToJQjTk7ekig==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeBBQXx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:23:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33124 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbeBBQXw (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 11:23:52 -0500
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
From: Robin Murphy <robin.murphy@arm.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: Andi Kleen <ak@linux.intel.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20180202150756.420422-1-arnd@arndb.de>
 <2cff070a-357d-c5f5-9ec6-036d93112ce4@arm.com>
Message-ID: <e5afa875-56a5-fca4-1fdd-2c0968b35790@arm.com>
Date: Fri, 2 Feb 2018 16:23:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2cff070a-357d-c5f5-9ec6-036d93112ce4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 15:55, Robin Murphy wrote:
> On 02/02/18 15:07, Arnd Bergmann wrote:
>> In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
>> statement to allow compilation of a multi-CPU kernel for ARMv6
>> and older ARMv7-A that don't normally support access to the banked
>> registers.
>>
>> This is considered to be a programming error by the gcc developers
>> and will no longer work in gcc-8, where we now get a build error:
>>
>> /tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with 
>> this architecture. -- `mrs r3,SP_usr'
>> /tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with 
>> this architecture. -- `mrs r3,ELR_hyp'
>> /tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with 
>> this architecture. -- `mrs r3,SP_svc'
>> /tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with 
>> this architecture. -- `mrs r3,LR_svc'
>> /tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with 
>> this architecture. -- `mrs r3,SPSR_svc'
>> /tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with 
>> this architecture. -- `mrs r3,SP_abt'
>>
>> Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
>> we know the functions won't ever be called on pre-ARMv7VE machines.
>> Unfortunately, older compiler versions (4.8 and earlier) do not 
>> understand
>> that flag, so we still need to keep the asm around.
>>
>> Backporting to stable kernels (4.6+) is needed to allow those to be built
>> with future compilers as well.
> 
> Is "-Wa,arch=armv7-a+virt" (as we appear to do for a couple of files 
> already) viable as a possibly cleaner alternative, or is GCC itself now 
> policing the contents of inline asms?

In fact, looking at the binutils history, any version capable of 
assembling this file should understand that (modulo my typo), so 
hopefully it ought to be feasible to replace these global asms with 
assembler flags entirely.

Robin.

>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
>> Fixes: 33280b4cd1dc ("ARM: KVM: Add banked registers save/restore")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   arch/arm/kvm/hyp/Makefile    | 5 +++++
>>   arch/arm/kvm/hyp/banked-sr.c | 4 ++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
>> index 5638ce0c9524..63d6b404d88e 100644
>> --- a/arch/arm/kvm/hyp/Makefile
>> +++ b/arch/arm/kvm/hyp/Makefile
>> @@ -7,6 +7,8 @@ ccflags-y += -fno-stack-protector 
>> -DDISABLE_BRANCH_PROFILING
>>   KVM=../../../../virt/kvm
>> +CFLAGS_ARMV7VE           :=$(call cc-option, -march=armv7ve)
>> +
>>   obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
>> @@ -15,7 +17,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += cp15-sr.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += vfp.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += banked-sr.o
>> +CFLAGS_banked-sr.o       += $(CFLAGS_ARMV7VE)
>> +
>>   obj-$(CONFIG_KVM_ARM_HOST) += entry.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
>>   obj-$(CONFIG_KVM_ARM_HOST) += switch.o
>> +CFLAGS_switch.o           += $(CFLAGS_ARMV7VE)
>>   obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
>> diff --git a/arch/arm/kvm/hyp/banked-sr.c b/arch/arm/kvm/hyp/banked-sr.c
>> index 111bda8cdebd..be4b8b0a40ad 100644
>> --- a/arch/arm/kvm/hyp/banked-sr.c
>> +++ b/arch/arm/kvm/hyp/banked-sr.c
>> @@ -20,6 +20,10 @@
>>   #include <asm/kvm_hyp.h>
>> +/*
>> + * gcc before 4.9 doesn't understand -march=armv7ve, so we have to
>> + * trick the assembler.
>> + */
>>   __asm__(".arch_extension     virt");
> 
> Would it be worth wrapping this in a preprocessor check for compilers 
> that won't understand the command-line flag? I believe LLVM tends to 
> choke on these global asm statements entirely, so minimising exposure 
> might be a good thing to do in general.
> 
> Robin.
> 
>>   void __hyp_text __banked_save_state(struct kvm_cpu_context *ctxt)
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
