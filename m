Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511C620857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fh+22t4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511C620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeG3UsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:48:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45355 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbeG3UsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:48:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so23309730oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cv6MspFUiS+fEy9Zcd0wyNst58ypRF956AI+eUI5hpo=;
        b=fh+22t4BgQ44VtgZihHKW2bsC3eaClUwKMIu345rLO3O2KihupuTKZRkmHlIS31bOL
         nxYTISg27pZYv5KLmv3omRzFxEj4z3S1JIKpRjRjgA09dG51sS0BuMf8g5+TX/Ftzeyu
         vHgVtB3sgzesz1e+nzmbDIkSTAg+EFBaq8Nhhh7pNfxuNJdg/pvfuA0J5OQPFEcQOhoN
         xA+pOf5BuxglveNGeZlmMT+3nUuDF3oHZicVD3DdLTs98sNfBt04JO2OPsrysdOVmFLN
         a+84ZZYPJuesArqd97XkHYTmvNNIa6NV6RpLRiHRAKu6LxM5XUx1MbZ0m7BzQCcnuHEb
         Zxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cv6MspFUiS+fEy9Zcd0wyNst58ypRF956AI+eUI5hpo=;
        b=Y+WmOLofw0XErSGoyCH0sTG5yEwSztlg2sHCii3ineMLwavxNaaSaxjbCSw6jF5UUM
         kJbht4HONaECw4Kmfr4sY5XIFMVHE4TJ3NcV0j272/FG8idpa3slS5j03IefLXnvhyOY
         Zbuvpsil81dUpjdfxjSX3TrH8KOxgAVsUqVdYeFEw2xdIHwztX2cBsfU/rZjydKzEJPR
         VRy1Xy7Q1RZqQL5Pe/seRXhCyb+tTq5SQDEED7UDqtBtMIN8DcIPB4qYbh9x9fvGdXt3
         x6/CIqQAoV//ZbJqhL8bBWQR9JetK8xOeCuC3TZutQClOCVBA6d/ilvDyeIQMNmlhpz+
         041g==
X-Gm-Message-State: AOUpUlE9w74Yetyg9bv8jy8KcLt7ZesZ3b5kJv6Q3/hWE0ZrRptdsfmD
        Fs6ci5SyhPCTgP5mC4FPlub+tUE98mAKuKT94fpUpcGe
X-Google-Smtp-Source: AAOMgpdN1pkWyhj1rLlLXt6xbar5LfdnYwLexnCvxDk/PArO4Ync/cxw+zyUMRPmSaBh1vQthlxuAIrUmGK1Z+Bt7QE=
X-Received: by 2002:aca:f189:: with SMTP id p131-v6mr18266162oih.14.1532977912628;
 Mon, 30 Jul 2018 12:11:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3408:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 12:11:52
 -0700 (PDT)
In-Reply-To: <1532819412-51357-10-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com> <1532819412-51357-10-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 30 Jul 2018 12:11:52 -0700
Message-ID: <CALMp9eSj+rmgvcEb8=W1M+Z0S4m5hKYjXvxTd6DhQe+SLCi=Kw@mail.gmail.com>
Subject: Re: [PATCH 09/10] KVM: nVMX: include shadow vmcs12 in nested state
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 4:10 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The shadow vmcs12 cannot be flushed on KVM_GET_NESTED_STATE,
> because at that point guest memory is assumed by userspace to
> be immutable.  Capture the cache in vmx_get_nested_state, adding
> another page at the end if there is an active shadow vmcs12.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b5ee9e08bb48..ce8c0c759a19 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -13167,9 +13167,15 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
>                 kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
>                 kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
>
> -               if (vmx->nested.current_vmptr != -1ull)
> +               if (vmx->nested.current_vmptr != -1ull) {
>                         kvm_state.size += VMCS12_SIZE;
>
> +                       if (is_guest_mode(vcpu) &&
> +                           nested_cpu_has_shadow_vmcs(vmcs12) &&
> +                           vmcs12->vmcs_link_pointer != -1ull)
> +                               kvm_state.size += VMCS12_SIZE;
> +               }
> +
>                 if (vmx->nested.smm.vmxon)
>                         kvm_state.vmx.smm.flags |= KVM_STATE_NESTED_SMM_VMXON;
>
> @@ -13208,6 +13214,13 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
>         if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
>                 return -EFAULT;
>
> +       if (nested_cpu_has_shadow_vmcs(vmcs12) &&
> +           vmcs12->vmcs_link_pointer != -1ull) {
> +               if (copy_to_user(user_kvm_nested_state->data + VMCS12_SIZE,
> +                                get_shadow_vmcs12(vcpu), sizeof(*vmcs12)))

Does this work with CONFIG_HARDENED_USERCOPY?

Is VMCS12_SIZE better than sizeof(*vmcs12)? What if we are migrating
to a destination where sizeof(*vmcs12) is larger than it is on the
source? If userspace doesn't zero the buffer before calling the ioctl,
then the destination may interpret nonsense as actual VMCS field
values. However, if we copy the entire page from the kernel, then we
know that anything beyond the source's sizeof(*vmcs12) will be zero.

> +                       return -EFAULT;
> +       }
> +
>  out:
>         return kvm_state.size;
>  }
> @@ -13288,6 +13301,22 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>         vmx->nested.nested_run_pending =
>                 !!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
>
> +       if (nested_cpu_has_shadow_vmcs(vmcs12) &&
> +           vmcs12->vmcs_link_pointer != -1ull) {
> +               struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
> +               if (kvm_state->size < sizeof(kvm_state) + 2 * sizeof(*vmcs12))
> +                       return -EINVAL;
> +
> +               if (copy_from_user(shadow_vmcs12,
> +                                  user_kvm_nested_state->data + VMCS12_SIZE,
> +                                  sizeof(*vmcs12)))
> +                       return -EFAULT;
> +
> +               if (shadow_vmcs12->hdr.revision_id != VMCS12_REVISION ||
> +                   !shadow_vmcs12->hdr.shadow_vmcs)
> +                       return -EINVAL;
> +       }
> +
>         if (check_vmentry_prereqs(vcpu, vmcs12) ||
>             check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
>                 return -EINVAL;
> --
> 1.8.3.1
>
