Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F02C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D320645
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuOlYnDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0D320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeLLXUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:20:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47040 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeLLXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:20:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so113966otm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6iJu6y4M0WOt5PU1EDhJkC4+HR3/BXBZzq4HJfVoa8=;
        b=fuOlYnDmNNgDl5nC0ZyoCZAyRSqdqKvTteSJ3zTcVgF74L8on4nh1q2nw6Yki5QVvh
         EChmVIGCeVPu9DLJnTbKPjW5EnRkW3HZ66RkhvtQWI+wuxq68+dvUDo2xx3AH4nbyaO2
         OZspSpk4M62WZImXkIQ/5qy8xQ+KFK2YxCZ2xoEIOMDxwU7eRPipoQ4ezVjk/Ta2OzqG
         K3mPR484UTJ7Rk0mPRNlMPo3QbZEFcKQ1zxPjQeQx97WE5gEQa7rLKMnDpbcx7XZ+nwS
         AjH128ggC4lLRrJcckknoTsGgwU86xuU9Un1jePYAAw20KhYSGeyKVGuM/hSVzrzZiAN
         3zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6iJu6y4M0WOt5PU1EDhJkC4+HR3/BXBZzq4HJfVoa8=;
        b=GLhky+c4V1qIip/AqB0tG2c9/eXNbwKQILjrRKjZS0XLFXB0f5SeYXffPkBudr7KtL
         bR7cGolRSVO/pzN3HhiQQEz0p2n0WucUCVfNnhrvT8qjZNmXe2FfqeiW8xhCD5tOZziP
         ZTlxkPYHoNuDiZ3Ju8LodSGAn2WvXlb8F4Xwy8BGDaSQR44CMWVKW53uVNJqUawdS8BN
         nNEjGR11XQNuZRGktZxZ7HDXtzUKRxumN+4tbldf1HpN7awQBBuPOUfcpqKH7U8helMF
         iVKWrlCX6KZQSPhmSgVDm0eL0w2zollcXZcQuBl9QLtICmeJ0XJF+/DJK0+e+QzBInif
         jLpA==
X-Gm-Message-State: AA+aEWbdKHyYF0KpbzxbJUpEdLSCcJeBc7MOMsewZHABAjsCghJVpzOz
        oiiOsl9XVTQ7089STCjkrHfGQUCLtxeNeR6V4BbpfA==
X-Google-Smtp-Source: AFSGD/VnTqkZqfQP1z9+U5S+0bIzzBWshO1ouzXprMIz4Zxxw5Syh3K26bKmxCPAAj1aN6/5lB+xOynVB71p8SwGcxI=
X-Received: by 2002:a9d:6297:: with SMTP id x23mr14469017otk.63.1544656804541;
 Wed, 12 Dec 2018 15:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20181016165011.6607-1-vkuznets@redhat.com> <20181016165011.6607-6-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-6-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 12 Dec 2018 15:19:53 -0800
Message-ID: <CALMp9eTqBJsZ0L36CGeRy20BVTryJgQtmqAUs0Lg_+NJnbyxzw@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 9:50 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Per Hyper-V TLFS 5.0b:
>
> "The L1 hypervisor may choose to use enlightened VMCSs by writing 1 to
> the corresponding field in the VP assist page (see section 7.8.7).
> Another field in the VP assist page controls the currently active
> enlightened VMCS. Each enlightened VMCS is exactly one page (4 KB) in
> size and must be initially zeroed. No VMPTRLD instruction must be
> executed to make an enlightened VMCS active or current.
>
> After the L1 hypervisor performs a VM entry with an enlightened VMCS,
> the VMCS is considered active on the processor. An enlightened VMCS
> can only be active on a single processor at the same time. The L1
> hypervisor can execute a VMCLEAR instruction to transition an
> enlightened VMCS from the active to the non-active state. Any VMREAD
> or VMWRITE instructions while an enlightened VMCS is active is
> unsupported and can result in unexpected behavior."
>
> Keep Enlightened VMCS structure for the current L2 guest permanently mapped
> from struct nested_vmx instead of mapping it every time.
>
> Suggested-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 115 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 108 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index aebd008ccccb..cfb44acd4291 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -20,6 +20,7 @@
>  #include "mmu.h"
>  #include "cpuid.h"
>  #include "lapic.h"
> +#include "hyperv.h"
>
>  #include <linux/kvm_host.h>
>  #include <linux/module.h>
> @@ -889,6 +890,8 @@ struct nested_vmx {
>                 bool guest_mode;
>         } smm;
>
> +       gpa_t hv_evmcs_vmptr;
> +       struct page *hv_evmcs_page;
>         struct hv_enlightened_vmcs *hv_evmcs;
>  };
>
> @@ -8111,11 +8114,13 @@ static int nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
>  static int nested_vmx_failValid(struct kvm_vcpu *vcpu,
>                                 u32 vm_instruction_error)
>  {
> +       struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
>         /*
>          * failValid writes the error number to the current VMCS, which
>          * can't be done if there isn't a current VMCS.
>          */
> -       if (to_vmx(vcpu)->nested.current_vmptr == -1ull)
> +       if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs)
>                 return nested_vmx_failInvalid(vcpu);
>
>         vmx_set_rflags(vcpu, (vmx_get_rflags(vcpu)
> @@ -8441,6 +8446,20 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
>         vmcs_write64(VMCS_LINK_POINTER, -1ull);
>  }
>
> +static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +       if (!vmx->nested.hv_evmcs)
> +               return;
> +
> +       kunmap(vmx->nested.hv_evmcs_page);
> +       kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
> +       vmx->nested.hv_evmcs_vmptr = -1ull;
> +       vmx->nested.hv_evmcs_page = NULL;
> +       vmx->nested.hv_evmcs = NULL;
> +}
> +
>  static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -8509,6 +8528,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
>
>         kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
>
> +       nested_release_evmcs(vcpu);
> +
>         free_loaded_vmcs(&vmx->nested.vmcs02);
>  }
>
> @@ -8542,12 +8563,18 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>                 return nested_vmx_failValid(vcpu,
>                         VMXERR_VMCLEAR_VMXON_POINTER);
>
> -       if (vmptr == vmx->nested.current_vmptr)
> -               nested_release_vmcs12(vcpu);
> +       if (vmx->nested.hv_evmcs_page) {
> +               if (vmptr == vmx->nested.hv_evmcs_vmptr)
> +                       nested_release_evmcs(vcpu);
> +       } else {
> +               if (vmptr == vmx->nested.current_vmptr)
> +                       nested_release_vmcs12(vcpu);
>
> -       kvm_vcpu_write_guest(vcpu,
> -                       vmptr + offsetof(struct vmcs12, launch_state),
> -                       &zero, sizeof(zero));
> +               kvm_vcpu_write_guest(vcpu,
> +                                    vmptr + offsetof(struct vmcs12,
> +                                                     launch_state),
> +                                    &zero, sizeof(zero));
> +       }
>
>         return nested_vmx_succeed(vcpu);
>  }
> @@ -8637,6 +8664,8 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
>         struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
>         struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
>
> +       vmcs12->hdr.revision_id = evmcs->revision_id;
> +
>         /* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
>         vmcs12->tpr_threshold = evmcs->tpr_threshold;
>         vmcs12->guest_rip = evmcs->guest_rip;
> @@ -9268,6 +9297,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>                 return nested_vmx_failValid(vcpu,
>                         VMXERR_VMPTRLD_VMXON_POINTER);
>
> +       /* Forbid normal VMPTRLD if Enlightened version was used */
> +       if (vmx->nested.hv_evmcs)
> +               return 1;
> +
>         if (vmx->nested.current_vmptr != vmptr) {
>                 struct vmcs12 *new_vmcs12;
>                 struct page *page;
> @@ -9301,6 +9334,68 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>         return nested_vmx_succeed(vcpu);
>  }
>
> +/*
> + * This is an equivalent of the nested hypervisor executing the vmptrld
> + * instruction.
> + */
> +static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_vmx *vmx = to_vmx(vcpu);
> +       struct hv_vp_assist_page assist_page;
> +
> +       if (likely(!vmx->nested.enlightened_vmcs_enabled))
> +               return 1;
> +
> +       if (unlikely(!kvm_hv_get_assist_page(vcpu, &assist_page)))
> +               return 1;
> +
> +       if (unlikely(!assist_page.enlighten_vmentry))
> +               return 1;
> +
> +       if (unlikely(assist_page.current_nested_vmcs !=
> +                    vmx->nested.hv_evmcs_vmptr)) {
> +
> +               if (!vmx->nested.hv_evmcs)
> +                       vmx->nested.current_vmptr = -1ull;
> +
> +               nested_release_evmcs(vcpu);
> +
> +               vmx->nested.hv_evmcs_page = kvm_vcpu_gpa_to_page(
> +                       vcpu, assist_page.current_nested_vmcs);
> +
> +               if (unlikely(is_error_page(vmx->nested.hv_evmcs_page)))
> +                       return 0;
> +
> +               vmx->nested.hv_evmcs = kmap(vmx->nested.hv_evmcs_page);

Are you sure that directly mapping guest memory isn't going to lead to
time-of-check vs. time-of-use bugs? This is a very hard programming
model to get right.
