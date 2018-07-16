Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FE6208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ke1pWS3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FE6208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeGPRho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:37:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33414 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeGPRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:37:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so23760222wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHmTSgJGMW6+Aea3LS0oYDPiwMyOh7Wj9dVmxbaM6DU=;
        b=ke1pWS3yfTHM5aYfw4r0rp1/aYe+21/T8eKJ36/2CuNleXGVLkQIBkpz3LXBuJ3jH5
         skHat2SkhaQUuRNwqtfoUAPSoZMqqr8PmASMPQldfKx9qusGqM0uBfxrmxDNX2Wd93nR
         87dvHYiHElI+vxAqg5ok+anAyeFJR3RiJF40ayphfo/zRHZLFNuEhkn5ZMZJh4wVd98R
         5pLzGP+2gwIO76Neud4WO8+ktj/Z6Fw/QTGh5l7qqg9dKJ7XCuXQzGDRcQzOJI06OsK+
         HkfI+vj61ism/BxhCFsU4+puDzAIghJBmNr+YJvhSxq+HT28iYufRy5MQVo9+hyyRGb/
         9o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHmTSgJGMW6+Aea3LS0oYDPiwMyOh7Wj9dVmxbaM6DU=;
        b=OUYzDgL5xFYPyaPvK2gg1rmdA+CepK51DPKx6X1z3P4BTiaF4KhCWrDeplUVsSCIQh
         s1xdCdfRlO5urGsDkQjOwFndNLqg/2w+tXRVPNIHnvoqW5WdcXn+O5wLLCdFyVUMFlkz
         qWjDIu0XP2ytgKiW3wNjuiBxchoqAJfnvI+KSSqOEEOXtQg9K8Sq4UKQ7BA81PckiJoC
         q2oEfWG/K0PIucL0XqoLESpCJyiHeA3Nmlv6oMrJ4Oz5DEBXLLq98BEHnUPt+fngCNVH
         FpkfYvzDIEfpYvMH5Y8wUjzcNiYj8sIfzlrVirhYj61bM1d6fJFReQ8jalkDXXe0uPrq
         Phlg==
X-Gm-Message-State: AOUpUlE5KwU2x179k0xQ+CcGGVhS8XjP9V3l1MMdzatFjN9J0Qn2w7yt
        7WdvcXBKGjUhAp7o7FJSc/ReWEImECAoK4TxGl5tWJh3dG8=
X-Google-Smtp-Source: AAOMgpfIHbqJP4FdkjWZSB+FZ1SqnL8ZscDolQrygek/BwC/ZdFl+rrd3uQtwAQOgk8SAFQ2wUO5kvLGmDlwYSjXwNI=
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr13554024wri.139.1531760964582;
 Mon, 16 Jul 2018 10:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180716073443.294323458@linuxfoundation.org> <20180716073453.739013579@linuxfoundation.org>
In-Reply-To: <20180716073453.739013579@linuxfoundation.org>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 16 Jul 2018 10:09:12 -0700
Message-ID: <CAA03e5FJiZZSutcAk=RvfSjmuiRv2d5b9gLKbFbjDqMWcA5=zA@mail.gmail.com>
Subject: Re: [PATCH 4.17 62/67] kvm: vmx: Nested VM-entry prereqs for event inj.
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzkaller@googlegroups.com, rkrcmar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:39 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.17-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Marc Orr <marcorr@google.com>
>
> commit 0447378a4a793da008451fad50bc0f93e9675ae6 upstream.
>
> This patch extends the checks done prior to a nested VM entry.
> Specifically, it extends the check_vmentry_prereqs function with checks
> for fields relevant to the VM-entry event injection information, as
> described in the Intel SDM, volume 3.
>
> This patch is motivated by a syzkaller bug, where a bad VM-entry
> interruption information field is generated in the VMCS02, which causes
> the nested VM launch to fail. Then, KVM fails to resume L1.
>
> While KVM should be improved to correctly resume L1 execution after a
> failed nested launch, this change is justified because the existing code
> to resume L1 is flaky/ad-hoc and the test coverage for resuming L1 is
> sparse.
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Marc Orr <marcorr@google.com>
> [Removed comment whose parts were describing previous revisions and the
>  rest was obvious from function/variable naming. - Radim]
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/x86/include/asm/vmx.h |    3 ++
>  arch/x86/kvm/vmx.c         |   67 ++++++++++++++++++++++++++++++++++++++=
+++++++
>  arch/x86/kvm/x86.h         |    9 ++++++
>  3 files changed, 79 insertions(+)
>
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -114,6 +114,7 @@
>  #define VMX_MISC_PREEMPTION_TIMER_RATE_MASK    0x0000001f
>  #define VMX_MISC_SAVE_EFER_LMA                 0x00000020
>  #define VMX_MISC_ACTIVITY_HLT                  0x00000040
> +#define VMX_MISC_ZERO_LEN_INS                  0x40000000
>
>  /* VMFUNC functions */
>  #define VMX_VMFUNC_EPTP_SWITCHING               0x00000001
> @@ -349,11 +350,13 @@ enum vmcs_field {
>  #define VECTORING_INFO_VALID_MASK              INTR_INFO_VALID_MASK
>
>  #define INTR_TYPE_EXT_INTR              (0 << 8) /* external interrupt *=
/
> +#define INTR_TYPE_RESERVED              (1 << 8) /* reserved */
>  #define INTR_TYPE_NMI_INTR             (2 << 8) /* NMI */
>  #define INTR_TYPE_HARD_EXCEPTION       (3 << 8) /* processor exception *=
/
>  #define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt *=
/
>  #define INTR_TYPE_PRIV_SW_EXCEPTION    (5 << 8) /* ICE breakpoint - undo=
cumented */
>  #define INTR_TYPE_SOFT_EXCEPTION       (6 << 8) /* software exception */
> +#define INTR_TYPE_OTHER_EVENT           (7 << 8) /* other event */
>
>  /* GUEST_INTERRUPTIBILITY_INFO flags. */
>  #define GUEST_INTR_STATE_STI           0x00000001
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1510,6 +1510,17 @@ static inline unsigned nested_cpu_vmx_mi
>         return vmx_misc_cr3_count(to_vmx(vcpu)->nested.msrs.misc_low);
>  }
>
> +static inline bool nested_cpu_has_zero_length_injection(struct kvm_vcpu =
*vcpu)
> +{
> +       return to_vmx(vcpu)->nested.msrs.misc_low & VMX_MISC_ZERO_LEN_INS=
;
> +}
> +
> +static inline bool nested_cpu_supports_monitor_trap_flag(struct kvm_vcpu=
 *vcpu)
> +{
> +       return to_vmx(vcpu)->nested.msrs.procbased_ctls_high &
> +                       CPU_BASED_MONITOR_TRAP_FLAG;
> +}
> +
>  static inline bool nested_cpu_has(struct vmcs12 *vmcs12, u32 bit)
>  {
>         return vmcs12->cpu_based_vm_exec_control & bit;
> @@ -11364,6 +11375,62 @@ static int check_vmentry_prereqs(struct
>             !nested_cr3_valid(vcpu, vmcs12->host_cr3))
>                 return VMXERR_ENTRY_INVALID_HOST_STATE_FIELD;
>
> +       /*
> +        * From the Intel SDM, volume 3:
> +        * Fields relevant to VM-entry event injection must be set proper=
ly.
> +        * These fields are the VM-entry interruption-information field, =
the
> +        * VM-entry exception error code, and the VM-entry instruction le=
ngth.
> +        */
> +       if (vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK) {
> +               u32 intr_info =3D vmcs12->vm_entry_intr_info_field;
> +               u8 vector =3D intr_info & INTR_INFO_VECTOR_MASK;
> +               u32 intr_type =3D intr_info & INTR_INFO_INTR_TYPE_MASK;
> +               bool has_error_code =3D intr_info & INTR_INFO_DELIVER_COD=
E_MASK;
> +               bool should_have_error_code;
> +               bool urg =3D nested_cpu_has2(vmcs12,
> +                                          SECONDARY_EXEC_UNRESTRICTED_GU=
EST);
> +               bool prot_mode =3D !urg || vmcs12->guest_cr0 & X86_CR0_PE=
;
> +
> +               /* VM-entry interruption-info field: interruption type */
> +               if (intr_type =3D=3D INTR_TYPE_RESERVED ||
> +                   (intr_type =3D=3D INTR_TYPE_OTHER_EVENT &&
> +                    !nested_cpu_supports_monitor_trap_flag(vcpu)))
> +                       return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
> +
> +               /* VM-entry interruption-info field: vector */
> +               if ((intr_type =3D=3D INTR_TYPE_NMI_INTR && vector !=3D N=
MI_VECTOR) ||
> +                   (intr_type =3D=3D INTR_TYPE_HARD_EXCEPTION && vector =
> 31) ||
> +                   (intr_type =3D=3D INTR_TYPE_OTHER_EVENT && vector !=
=3D 0))
> +                       return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
> +
> +               /* VM-entry interruption-info field: deliver error code *=
/
> +               should_have_error_code =3D
> +                       intr_type =3D=3D INTR_TYPE_HARD_EXCEPTION && prot=
_mode &&
> +                       x86_exception_has_error_code(vector);
> +               if (has_error_code !=3D should_have_error_code)
> +                       return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
> +
> +               /* VM-entry exception error code */
> +               if (has_error_code &&
> +                   vmcs12->vm_entry_exception_error_code & GENMASK(31, 1=
5))
> +                       return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
> +
> +               /* VM-entry interruption-info field: reserved bits */
> +               if (intr_info & INTR_INFO_RESVD_BITS_MASK)
> +                       return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
> +
> +               /* VM-entry instruction length */
> +               switch (intr_type) {
> +               case INTR_TYPE_SOFT_EXCEPTION:
> +               case INTR_TYPE_SOFT_INTR:
> +               case INTR_TYPE_PRIV_SW_EXCEPTION:
> +                       if ((vmcs12->vm_entry_instruction_len > 15) ||
> +                           (vmcs12->vm_entry_instruction_len =3D=3D 0 &&
> +                            !nested_cpu_has_zero_length_injection(vcpu))=
)
> +                               return VMXERR_ENTRY_INVALID_CONTROL_FIELD=
;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -110,6 +110,15 @@ static inline bool is_la57_mode(struct k
>  #endif
>  }
>
> +static inline bool x86_exception_has_error_code(unsigned int vector)
> +{
> +       static u32 exception_has_error_code =3D BIT(DF_VECTOR) | BIT(TS_V=
ECTOR) |
> +                       BIT(NP_VECTOR) | BIT(SS_VECTOR) | BIT(GP_VECTOR) =
|
> +                       BIT(PF_VECTOR) | BIT(AC_VECTOR);
> +
> +       return (1U << vector) & exception_has_error_code;
> +}
> +
>  static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
>  {
>         return vcpu->arch.walk_mmu =3D=3D &vcpu->arch.nested_mmu;
>
>

Reviewed-by: Marc Orr <marcorr@google.com>
