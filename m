Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2701262-1517586945-2-16274314952499630880
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
    t=1517586944; b=KsOZN2dNnw5d16fy/JrfrdDRDZBeuJC+2EiB+kRkhlsxYvT
    z675L6mchX7mZvwNp/8ImNRpKiLnwrChMOTQHssVEdNHb3KNuFfVqJD1l19gtPJF
    KE3MiDaEMfdQfLHmhZLTGDefQT/x7qSJ9EBgJKhanZRI+O/eyEOe6RfHwLF3ENi0
    eGQvTjGkxyeffKH53FZIPNSbnmVMmgZt/6e84m0+4bHFCU4EP5Qr5s56S0dAERdY
    qG/MSks33fIC9fIIbEkofjPelBSbYyoCkvT2B2vGJoBZa/bAuYGm+cXxcHoyA6cs
    zsN80MVxtksIZhgQSrHiYSwLCSHkUcwV3n+qGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517586944; bh=jAjTPNypcNENV9Gn4HhzDvFvDKpJ9F2jzzJ4sG/Xe24=; b=k
    TDKbwnVVb7QhrsVFGNVdNnPNDOtTt0eJxQOMfx7masKmIJQ7uzY5zKYbKikRumJb
    LTk7stJTpZcwKbMzM1bXRdEcHTnj0n5uJBquqJRdJQP+aDaRjoHa0u+o6SQsQH9u
    RGk7uwyKivC0XKiZcfHD8QVPdJUijm/AqvZ9X6MMprRQ535PJAsTyMbyZwDM92Aj
    sD8ARTN07seubgMP6zA8dUOqdskQiNX/y1WY+Inx5k9AMTsJett/sTiEn7VPWY2E
    jFHXRCB/hbHaYlJYnvcIieazHkKrsEdy37B/99K8QF3dxpH2Wr2d3hmP+jPJRowI
    K+qeVBWZhEmvI1+bvQCCQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBBPzl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 10:55:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeBBPzl (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 10:55:41 -0500
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
To: Arnd Bergmann <arnd@arndb.de>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: Andi Kleen <ak@linux.intel.com>, Nicolas Pitre <nico@linaro.org>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>
References: <20180202150756.420422-1-arnd@arndb.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2cff070a-357d-c5f5-9ec6-036d93112ce4@arm.com>
Date: Fri, 2 Feb 2018 15:55:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202150756.420422-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 15:07, Arnd Bergmann wrote:
> In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
> statement to allow compilation of a multi-CPU kernel for ARMv6
> and older ARMv7-A that don't normally support access to the banked
> registers.
> 
> This is considered to be a programming error by the gcc developers
> and will no longer work in gcc-8, where we now get a build error:
> 
> /tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_usr'
> /tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this architecture. -- `mrs r3,ELR_hyp'
> /tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_svc'
> /tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this architecture. -- `mrs r3,LR_svc'
> /tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this architecture. -- `mrs r3,SPSR_svc'
> /tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_abt'
> 
> Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
> we know the functions won't ever be called on pre-ARMv7VE machines.
> Unfortunately, older compiler versions (4.8 and earlier) do not understand
> that flag, so we still need to keep the asm around.
> 
> Backporting to stable kernels (4.6+) is needed to allow those to be built
> with future compilers as well.

Is "-Wa,arch=armv7-a+virt" (as we appear to do for a couple of files 
already) viable as a possibly cleaner alternative, or is GCC itself now 
policing the contents of inline asms?

> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
> Fixes: 33280b4cd1dc ("ARM: KVM: Add banked registers save/restore")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/kvm/hyp/Makefile    | 5 +++++
>   arch/arm/kvm/hyp/banked-sr.c | 4 ++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
> index 5638ce0c9524..63d6b404d88e 100644
> --- a/arch/arm/kvm/hyp/Makefile
> +++ b/arch/arm/kvm/hyp/Makefile
> @@ -7,6 +7,8 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
>   
>   KVM=../../../../virt/kvm
>   
> +CFLAGS_ARMV7VE		   :=$(call cc-option, -march=armv7ve)
> +
>   obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
>   obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
>   obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
> @@ -15,7 +17,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
>   obj-$(CONFIG_KVM_ARM_HOST) += cp15-sr.o
>   obj-$(CONFIG_KVM_ARM_HOST) += vfp.o
>   obj-$(CONFIG_KVM_ARM_HOST) += banked-sr.o
> +CFLAGS_banked-sr.o	   += $(CFLAGS_ARMV7VE)
> +
>   obj-$(CONFIG_KVM_ARM_HOST) += entry.o
>   obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
>   obj-$(CONFIG_KVM_ARM_HOST) += switch.o
> +CFLAGS_switch.o		   += $(CFLAGS_ARMV7VE)
>   obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
> diff --git a/arch/arm/kvm/hyp/banked-sr.c b/arch/arm/kvm/hyp/banked-sr.c
> index 111bda8cdebd..be4b8b0a40ad 100644
> --- a/arch/arm/kvm/hyp/banked-sr.c
> +++ b/arch/arm/kvm/hyp/banked-sr.c
> @@ -20,6 +20,10 @@
>   
>   #include <asm/kvm_hyp.h>
>   
> +/*
> + * gcc before 4.9 doesn't understand -march=armv7ve, so we have to
> + * trick the assembler.
> + */
>   __asm__(".arch_extension     virt");

Would it be worth wrapping this in a preprocessor check for compilers 
that won't understand the command-line flag? I believe LLVM tends to 
choke on these global asm statements entirely, so minimising exposure 
might be a good thing to do in general.

Robin.

>   
>   void __hyp_text __banked_save_state(struct kvm_cpu_context *ctxt)
> 
