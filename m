Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122356-1517769925-2-2414714429877740032
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517769924; b=F7OoQ30jDydsJ7lSZWv9+LxoFuUqNrKsHrIz8Haa39gZORl
    U6II3MJMCudr8T/FHLC3P2sHdEFtTF/RpQ7LV/VLmLGmAEZQ2dZqdJPpDapRZzYD
    kJPEVLNnuyBadehOeg93SK1d5uuiXETBkZsJsxCNt/dZCth+EZ2Fat2yzNKWiK5T
    9Yet9z+gsHmP+KqXIE9BwnLXsyFlESmSKKiKO+B9oksw2azz6wHAqPgJqiBdVOZU
    EDClpA1ub3TIQUJ2UVkfqtlm2khZkW0cl+ZeKqt9LXzQVEOXGJyAzBMBUJPYYUlt
    uq8CumYcBeyQLMUFebuIpaA2SaDeE3bC5kJuVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517769924; bh=ruG+A70LLloOqZ9q92C8l54X6x
    pRUfuKTLa2xjqPLgs=; b=jDCJhgeBX0jhK0wnlGEjMVP4odXSjvKsgRre5bL8Cq
    cYF2h1ExeSXlHaCGDr8+ew3Hke9PbyrqScVG1j5GxCj/9SGpdvNO7ESSXpWqxmXt
    sgMJV5tn2Pf4cBj7O6yr92ypU9Jr9LKyIHRoMNaisMfyLQHyuMx2t+KVrntNmGKa
    keZ9o7pXU+8chy64kw6BV1Fs+jhmBh65dZp21e3uDH/uJKgfu4PtnBs2EKOJHIz7
    fbzVjE86eJYP60DFA6hk0AQc/SDW4MChmej3/4dFY6Zd/yY2yCsFb5cDbTqZ96sm
    wS92OTeVxFqS+kve3lyFpIABOq2uj+cb+OhMaYg2F4Uw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=aYOYmzZW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ktPNj2bI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=aYOYmzZW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ktPNj2bI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBDSpV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 13:45:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53329 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBDSpU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Feb 2018 13:45:20 -0500
X-Google-Smtp-Source: AH8x225rUsRLtmZezTJ5KAD/lVLGFz+QepcE97hqrTGrW0GHPjrodlnywl42ekNmInzoKnB0JGt9bg==
Date: Sun, 4 Feb 2018 19:45:17 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>, stable@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
Message-ID: <20180204184517.GQ21802@cbox>
References: <20180202150756.420422-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202150756.420422-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

On Fri, Feb 02, 2018 at 04:07:34PM +0100, Arnd Bergmann wrote:
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

Does "not understand" mean "ignores" or do we get an error?

> 
> Backporting to stable kernels (4.6+) is needed to allow those to be built
> with future compilers as well.

This builds on the toolchains I have on my machine, so:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Are you applying this via a tree with other fixes or would you like me
to carry it in the kvmarm tree?

Thanks,
-Christoffer

> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
> Fixes: 33280b4cd1dc ("ARM: KVM: Add banked registers save/restore")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/kvm/hyp/Makefile    | 5 +++++
>  arch/arm/kvm/hyp/banked-sr.c | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
> index 5638ce0c9524..63d6b404d88e 100644
> --- a/arch/arm/kvm/hyp/Makefile
> +++ b/arch/arm/kvm/hyp/Makefile
> @@ -7,6 +7,8 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
>  
>  KVM=../../../../virt/kvm
>  
> +CFLAGS_ARMV7VE		   :=$(call cc-option, -march=armv7ve)
> +
>  obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
>  obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
>  obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
> @@ -15,7 +17,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
>  obj-$(CONFIG_KVM_ARM_HOST) += cp15-sr.o
>  obj-$(CONFIG_KVM_ARM_HOST) += vfp.o
>  obj-$(CONFIG_KVM_ARM_HOST) += banked-sr.o
> +CFLAGS_banked-sr.o	   += $(CFLAGS_ARMV7VE)
> +
>  obj-$(CONFIG_KVM_ARM_HOST) += entry.o
>  obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
>  obj-$(CONFIG_KVM_ARM_HOST) += switch.o
> +CFLAGS_switch.o		   += $(CFLAGS_ARMV7VE)
>  obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
> diff --git a/arch/arm/kvm/hyp/banked-sr.c b/arch/arm/kvm/hyp/banked-sr.c
> index 111bda8cdebd..be4b8b0a40ad 100644
> --- a/arch/arm/kvm/hyp/banked-sr.c
> +++ b/arch/arm/kvm/hyp/banked-sr.c
> @@ -20,6 +20,10 @@
>  
>  #include <asm/kvm_hyp.h>
>  
> +/*
> + * gcc before 4.9 doesn't understand -march=armv7ve, so we have to
> + * trick the assembler.
> + */
>  __asm__(".arch_extension     virt");
>  
>  void __hyp_text __banked_save_state(struct kvm_cpu_context *ctxt)
> -- 
> 2.9.0
> 
