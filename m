Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F445ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E193A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7XGXzSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E193A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJYCOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:14:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53517 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYCOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:14:10 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so7242659itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=erCXCTu9lB9F6AX4sseScuPY1Z8Ds0WqfLYpPNdd1tE=;
        b=o7XGXzSIFfn8Rt9eatPYaK3N4HVrJ1wAWRRodYCM75O1eKM6FA6aUUFdjVYBO3EXfe
         SwLtoz4lhnLMdbiWCswsddQqsFkYefnt0+y9qkWSq/G9+Zx4pqVU28b6Ajqe6/x7JmyY
         OQ/m0S+GLeqErfNyDQY01+hbC26Mhzbh/GeJ6reCmHc9AvGZ1T7dwYxaQgvCleV9HC0N
         1/++MwT1LAb/v4vfA9EdL5mTSaI+v7rMjLRuHfAXZTcpzH2nRfnO9GUm9x7v7OFcvCD1
         qJUPIrTZTg7b8gJVgDIrCLQ/KGNmOqXaFU0Nll7YPoiAy9IigzRGMYbToVfLFqZSfYYy
         cnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=erCXCTu9lB9F6AX4sseScuPY1Z8Ds0WqfLYpPNdd1tE=;
        b=rUWtegXWsEU5C21jbVTMCTrebztFOLdNWR+Zry1WCFj/JNKGvQt6lnIMFpcSN/+Fkz
         Y/4qUA87miDnq2sNUEBXFKtvJHzVnm4z8Oq5dy0ZJKkhm8/izaknmPaf7ywLomRcGBCI
         DG43V3uwcoGxrms+aIIQhn/iRzOmwwiMjrWhw+p+09BosApYDMKqEWq5i5Tm/GxQEFwx
         XqVcRYg981OZGm6UdqI5YxyARdqmkvd9EnDqPvpWGo0mAwRDo0Rg20c4q9nhBONSAr3D
         Uz+yzDOw8XNgTp/+uyJsFMdV/s5MYR/ASbxryF+eks13nXUMSmNLhs+p76r9KEbxhQ91
         gtyw==
X-Gm-Message-State: AGRZ1gILgbZmZh/Y/R4BSVPo2zp5E7AMdM2S+s1BvwkkPyqhth8W+n6X
        ABFd962BO4phEYiticuWKV3EaqLcr/Cs5zos97FgGw==
X-Google-Smtp-Source: AJdET5dGEPHDiRupp7aeXxUeJlGjDfXlxNsyC0jiIhKoFBylXbZP+uSDZ3rAb5snVur+x31tIxlPsGhcv0za/yHZP1k=
X-Received: by 2002:a24:6c14:: with SMTP id w20-v6mr2124807itb.103.1540403110526;
 Wed, 24 Oct 2018 10:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
 <ba8f4a02e90f1dc95a900f6a34caddce40a358d4.1540369608.git.jsteckli@amazon.de>
In-Reply-To: <ba8f4a02e90f1dc95a900f6a34caddce40a358d4.1540369608.git.jsteckli@amazon.de>
From:   Eric Northup <digitaleric@google.com>
Date:   Wed, 24 Oct 2018 10:44:59 -0700
Message-ID: <CAG7+5M39QBY1dkBjkJ9N4_9f1b1B6Hfqzg1Oh1mMp8N=dk7ZgQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kvm, vmx: remove manually coded vmx instructions
To:     jsteckli@amazon.de
Cc:     KVM <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        js@alien8.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:30 AM Julian Stecklina <jsteckli@amazon.de> wrote=
:
>
> So far the VMX code relied on manually assembled VMX instructions. This
> was apparently done to ensure compatibility with old binutils. VMX
> instructions were introduced with binutils 2.19 and the kernel currently
> requires binutils 2.20.
>
> Remove the manually assembled versions and replace them with the proper
> inline assembly. This improves code generation (and source code
> readability).
>
> According to the bloat-o-meter this change removes ~1300 bytes from the
> text segment.

This loses the exception handling from __ex* ->
____kvm_handle_fault_on_reboot.

If deliberate, this should be called out in changelog.  Has the race
which commit 4ecac3fd fixed been mitigated otherwise?



>
> Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
> Reviewed-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
> Reviewed-by: Konrad Jan Miller <kjm@amazon.de>
> Reviewed-by: Razvan-Alin Ghitulete <rga@amazon.de>
> ---
>  arch/x86/include/asm/virtext.h |  2 +-
>  arch/x86/include/asm/vmx.h     | 13 -------------
>  arch/x86/kvm/vmx.c             | 39 ++++++++++++++++++------------------=
---
>  3 files changed, 19 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtex=
t.h
> index 0116b2e..c5395b3 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -40,7 +40,7 @@ static inline int cpu_has_vmx(void)
>   */
>  static inline void cpu_vmxoff(void)
>  {
> -       asm volatile (ASM_VMX_VMXOFF : : : "cc");
> +       asm volatile ("vmxoff" : : : "cc");
>         cr4_clear_bits(X86_CR4_VMXE);
>  }
>
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 9527ba5..ade0f15 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -503,19 +503,6 @@ enum vmcs_field {
>
>  #define VMX_EPT_IDENTITY_PAGETABLE_ADDR                0xfffbc000ul
>
> -
> -#define ASM_VMX_VMCLEAR_RAX       ".byte 0x66, 0x0f, 0xc7, 0x30"
> -#define ASM_VMX_VMLAUNCH          ".byte 0x0f, 0x01, 0xc2"
> -#define ASM_VMX_VMRESUME          ".byte 0x0f, 0x01, 0xc3"
> -#define ASM_VMX_VMPTRLD_RAX       ".byte 0x0f, 0xc7, 0x30"
> -#define ASM_VMX_VMREAD_RDX_RAX    ".byte 0x0f, 0x78, 0xd0"
> -#define ASM_VMX_VMWRITE_RAX_RDX   ".byte 0x0f, 0x79, 0xd0"
> -#define ASM_VMX_VMWRITE_RSP_RDX   ".byte 0x0f, 0x79, 0xd4"
> -#define ASM_VMX_VMXOFF            ".byte 0x0f, 0x01, 0xc4"
> -#define ASM_VMX_VMXON_RAX         ".byte 0xf3, 0x0f, 0xc7, 0x30"
> -#define ASM_VMX_INVEPT           ".byte 0x66, 0x0f, 0x38, 0x80, 0x08"
> -#define ASM_VMX_INVVPID                  ".byte 0x66, 0x0f, 0x38, 0x81, =
0x08"
> -
>  struct vmx_msr_entry {
>         u32 index;
>         u32 reserved;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 82cfb909..bbbdccb 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2077,7 +2077,7 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u=
32 msr)
>         return -1;
>  }
>
> -static inline void __invvpid(int ext, u16 vpid, gva_t gva)
> +static inline void __invvpid(long ext, u16 vpid, gva_t gva)
>  {
>         struct {
>                 u64 vpid : 16;
> @@ -2086,21 +2086,21 @@ static inline void __invvpid(int ext, u16 vpid, g=
va_t gva)
>         } operand =3D { vpid, 0, gva };
>         bool error;
>
> -       asm volatile (__ex(ASM_VMX_INVVPID) CC_SET(na)
> -                     : CC_OUT(na) (error) : "a"(&operand), "c"(ext)
> +       asm volatile ("invvpid %1, %2" CC_SET(na)
> +                     : CC_OUT(na) (error) : "m"(operand), "r"(ext)
>                       : "memory");
>         BUG_ON(error);
>  }
>
> -static inline void __invept(int ext, u64 eptp, gpa_t gpa)
> +static inline void __invept(long ext, u64 eptp, gpa_t gpa)
>  {
>         struct {
>                 u64 eptp, gpa;
>         } operand =3D {eptp, gpa};
>         bool error;
>
> -       asm volatile (__ex(ASM_VMX_INVEPT) CC_SET(na)
> -                     : CC_OUT(na) (error) : "a" (&operand), "c" (ext)
> +       asm volatile ("invept %1, %2" CC_SET(na)
> +                     : CC_OUT(na) (error) : "m" (operand), "r" (ext)
>                       : "memory");
>         BUG_ON(error);
>  }
> @@ -2120,8 +2120,8 @@ static void vmcs_clear(struct vmcs *vmcs)
>         u64 phys_addr =3D __pa(vmcs);
>         bool error;
>
> -       asm volatile (__ex(ASM_VMX_VMCLEAR_RAX) CC_SET(na)
> -                     : CC_OUT(na) (error) : "a"(&phys_addr), "m"(phys_ad=
dr)
> +       asm volatile ("vmclear %1" CC_SET(na)
> +                     : CC_OUT(na) (error) : "m"(phys_addr)
>                       : "memory");
>         if (unlikely(error))
>                 printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
> @@ -2145,8 +2145,8 @@ static void vmcs_load(struct vmcs *vmcs)
>         if (static_branch_unlikely(&enable_evmcs))
>                 return evmcs_load(phys_addr);
>
> -       asm volatile (__ex(ASM_VMX_VMPTRLD_RAX) CC_SET(na)
> -                     : CC_OUT(na) (error) : "a"(&phys_addr), "m"(phys_ad=
dr)
> +       asm volatile ("vmptrld %1" CC_SET(na)
> +                     : CC_OUT(na) (error) : "m"(phys_addr)
>                       : "memory");
>         if (unlikely(error))
>                 printk(KERN_ERR "kvm: vmptrld %p/%llx failed\n",
> @@ -2323,8 +2323,7 @@ static __always_inline unsigned long __vmcs_readl(u=
nsigned long field)
>  {
>         unsigned long value;
>
> -       asm volatile (__ex_clear(ASM_VMX_VMREAD_RDX_RAX, "%0")
> -                     : "=3Da"(value) : "d"(field) : "cc");
> +       asm volatile ("vmread %1, %0" : "=3Drm"(value) : "r"(field) : "cc=
");
>         return value;
>  }
>
> @@ -2375,8 +2374,8 @@ static __always_inline void __vmcs_writel(unsigned =
long field, unsigned long val
>  {
>         bool error;
>
> -       asm volatile (__ex(ASM_VMX_VMWRITE_RAX_RDX) CC_SET(na)
> -                     : CC_OUT(na) (error) : "a"(value), "d"(field));
> +       asm volatile ("vmwrite %1, %2" CC_SET(na)
> +                     : CC_OUT(na) (error) : "rm"(value), "r"(field));
>         if (unlikely(error))
>                 vmwrite_error(field, value);
>  }
> @@ -4397,9 +4396,7 @@ static void kvm_cpu_vmxon(u64 addr)
>         cr4_set_bits(X86_CR4_VMXE);
>         intel_pt_handle_vmx(1);
>
> -       asm volatile (ASM_VMX_VMXON_RAX
> -                       : : "a"(&addr), "m"(addr)
> -                       : "memory", "cc");
> +       asm volatile ("vmxon %0" : : "m"(addr) : "memory", "cc");
>  }
>
>  static int hardware_enable(void)
> @@ -4468,7 +4465,7 @@ static void vmclear_local_loaded_vmcss(void)
>   */
>  static void kvm_cpu_vmxoff(void)
>  {
> -       asm volatile (__ex(ASM_VMX_VMXOFF) : : : "cc");
> +       asm volatile ("vmxoff" : : : "cc");
>
>         intel_pt_handle_vmx(0);
>         cr4_clear_bits(X86_CR4_VMXE);
> @@ -10748,7 +10745,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcp=
u *vcpu)
>                 "mov %%" _ASM_SP ", (%%" _ASM_SI ") \n\t"
>                 "jmp 1f \n\t"
>                 "2: \n\t"
> -               __ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
> +               "vmwrite %%" _ASM_SP ", %%" _ASM_DX "\n\t"
>                 "1: \n\t"
>                 /* Check if vmlaunch of vmresume is needed */
>                 "cmpl $0, %c[launched](%0) \n\t"
> @@ -10773,9 +10770,9 @@ static void __noclone vmx_vcpu_run(struct kvm_vcp=
u *vcpu)
>
>                 /* Enter guest mode */
>                 "jne 1f \n\t"
> -               __ex(ASM_VMX_VMLAUNCH) "\n\t"
> +               "vmlaunch \n\t"
>                 "jmp 2f \n\t"
> -               "1: " __ex(ASM_VMX_VMRESUME) "\n\t"
> +               "1: vmresume \n\t"
>                 "2: "
>                 /* Save guest registers, load host registers, keep flags =
*/
>                 "mov %0, %c[wordsize](%%" _ASM_SP ") \n\t"
> --
> 2.7.4
>
