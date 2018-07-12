Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D84C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060F820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6vmfyln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060F820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390978AbeGLBqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:46:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40900 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388023AbeGLBqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:46:12 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so52842732oie.7;
        Wed, 11 Jul 2018 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sL9Soz18EmckLEMHhIi/Cu+Je8gx5W6Mkv4mKrTp+M=;
        b=e6vmfylnEa4f/N1zOq2qMeTANeBgG87ognFQZI03wDJKsNSXXG5bxr9I5X0Y29xApS
         MzyjFHmt1ipDKDn2pwfU+D7+kPiwhx1R1mXnX+OmOFzvJQIUuEtMORA8vzuGf5zw+uYe
         xwwU8C+Fb1HgeRTScxf1bqV1j6KmybVh2v2bYKl6BmLoFK9mV2xDLTaRiemSFukP8WxO
         SOtpde+ZaCdu07moc6yl8MzHHlrDcs0CEJELYqNQuXVqqPqb9vTF132Rp7zqZXpaq6GY
         /fW39v1wJUgGX4ZVKldJCt7Vb08V3KMDXsyebmXccIWR8CaYrQcpKcjdXq1MQ9PhkXUM
         1j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sL9Soz18EmckLEMHhIi/Cu+Je8gx5W6Mkv4mKrTp+M=;
        b=oyuI/MJBYJM8sRKu8HaL9qFkfq55FuFJQvQ626J/ApIZbABVrjaLqW59iqkHmukF3Y
         web5UIf6mRut0wK1c/YLYZtFnMU9WYCOy4WNY4spVQjf9DnzPY6UmmrfPtA2SVYUr6Kt
         CABYxt7IcdUOO90yDJhjzLyvDXnS9CuUXWMcAKubOiSiqdyuEdghZbjwdf29wQ3O6aXI
         2Zd/ZSeZYoaAx3Rip/p+/uOSaBYMDhBFFlB5Ngu52lFjNbw8qwWIOHvTt1/aNoY7IrAj
         WnJNUeOhTqbAjRu0Lr9efY7dSwMc4kmVxSZn62i5wF5UMRIaonYX7g1ZzcEN6SqWe0PE
         hkAg==
X-Gm-Message-State: AOUpUlHO/mfJo4agxqojFQQXPc/g7t84bwyfSyvm7p3iwha1/CAP/tzA
        HJQnAgRvTdwXxZtxpNhrb/8o3K8Tuih8F45b/P4QKw==
X-Google-Smtp-Source: AAOMgpcVmBugAi79A8qJLdsJ1Ews+VpOw5+fJBPUbAmJEJNGqis749NJpIi9oK9bF4JBIgdD/p1OAU+CdgbuyEKc7nQ=
X-Received: by 2002:aca:cc46:: with SMTP id c67-v6mr254967oig.197.1531359548020;
 Wed, 11 Jul 2018 18:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180711173718.8850-1-vkuznets@redhat.com>
In-Reply-To: <20180711173718.8850-1-vkuznets@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 12 Jul 2018 09:39:09 +0800
Message-ID: <CANRm+CxKWuuzyu4Yi-phUR3RpVb0bx_=r3FoJvZMm1ii-8-wKw@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/vmx: don't read current->thread.{fs,gs}base of
 legacy tasks
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, ldv@altlinux.org,
        yamato@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 at 08:07, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> When we switched from doing rdmsr() to reading FS/GS base values from
> current->thread we completely forgot about legacy 32-bit userspaces which
> we still support in KVM (why?). task->thread.{fsbase,gsbase} are only
> synced for 64-bit processes, calling save_fsgs_for_kvm() and using
> its result from current is illegal for legacy processes.
>
> There's no ARCH_SET_FS/GS prctls for legacy applications. Base MSRs are,
> however, not always equal to zero. Intel's manual says (3.4.4 Segment
> Loading Instructions in IA-32e Mode):
>
> "In order to set up compatibility mode for an application, segment-load
> instructions (MOV to Sreg, POP Sreg) work normally in 64-bit mode. An
> entry is read from the system descriptor table (GDT or LDT) and is loaded
> in the hidden portion of the segment register.
> ...
> The hidden descriptor register fields for FS.base and GS.base are
> physically mapped to MSRs in order to load all address bits supported by
> a 64-bit implementation.
> "
>
> The issue was found by strace test suite where 32-bit ioctl_kvm_run test
> started segfaulting.

Test suite: MSR switch
PASS: VM entry MSR load
PASS: VM exit MSR store
PASS: VM exit MSR load
FAIL: VM entry MSR load: try to load FS_BASE
SUMMARY: 4 tests, 1 unexpected failures

kvm-unit-tests fails w/ and w/o the patch, maybe it is another issue,
i didn't dig further, you can have a look if you are interested in. :)

Regards,
Wanpeng Li

>
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Bisected-by: Masatake YAMATO <yamato@redhat.com>
> Fixes: 42b933b59721 ("x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 559a12b6184d..65968649b365 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2560,6 +2560,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>  #ifdef CONFIG_X86_64
>         int cpu = raw_smp_processor_id();
> +       unsigned long fsbase, kernel_gsbase;
>  #endif
>         int i;
>
> @@ -2575,12 +2576,20 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>         vmx->host_state.gs_ldt_reload_needed = vmx->host_state.ldt_sel;
>
>  #ifdef CONFIG_X86_64
> -       save_fsgs_for_kvm();
> -       vmx->host_state.fs_sel = current->thread.fsindex;
> -       vmx->host_state.gs_sel = current->thread.gsindex;
> -#else
> -       savesegment(fs, vmx->host_state.fs_sel);
> -       savesegment(gs, vmx->host_state.gs_sel);
> +       if (likely(is_64bit_mm(current->mm))) {
> +               save_fsgs_for_kvm();
> +               vmx->host_state.fs_sel = current->thread.fsindex;
> +               vmx->host_state.gs_sel = current->thread.gsindex;
> +               fsbase = current->thread.fsbase;
> +               kernel_gsbase = current->thread.gsbase;
> +       } else {
> +#endif
> +               savesegment(fs, vmx->host_state.fs_sel);
> +               savesegment(gs, vmx->host_state.gs_sel);
> +#ifdef CONFIG_X86_64
> +               fsbase = read_msr(MSR_FS_BASE);
> +               kernel_gsbase = read_msr(MSR_KERNEL_GS_BASE);
> +       }
>  #endif
>         if (!(vmx->host_state.fs_sel & 7)) {
>                 vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
> @@ -2600,10 +2609,10 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>         savesegment(ds, vmx->host_state.ds_sel);
>         savesegment(es, vmx->host_state.es_sel);
>
> -       vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
> +       vmcs_writel(HOST_FS_BASE, fsbase);
>         vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
>
> -       vmx->msr_host_kernel_gs_base = current->thread.gsbase;
> +       vmx->msr_host_kernel_gs_base = kernel_gsbase;
>         if (is_long_mode(&vmx->vcpu))
>                 wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
>  #else
> --
> 2.14.4
>
