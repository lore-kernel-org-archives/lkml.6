Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A1FC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9503E2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="us1SjQ4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfBETyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:54:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54551 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfBETyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:54:22 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so528822ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEs6j4wAqBBuONrdeiF9MFQLXTSsR5o6oHHKATeUrkM=;
        b=us1SjQ4qAzHmyF6weSi5zB9OW5xc901K5JsrX3dxxorSS0H10Lm56nyuf5uiwhmGRy
         qAr3zRmi7q/QMCYpkwbKukUSMws4zmLeU9jdLMJ8FOQn0AycS9AM1UHhxypIfihfqV8M
         DugthkDCPLSXK0e984V+3Sw/tNgFGfbxI5Olhd4N4KyORU3zJuYIrFxe8IszoC5Jc80f
         5FB3ftorAoC+IfaPPIZKbQAm6Zfh9aAZ9ptH9bVGrM+VcKUfoX0/+uJt275BDkmJ/CJT
         8PRmkkBJo/ycwTTqt7niegwC+i+e5jbTgUQeEJ1w6nDD6q9I0+LZgkPJGpRDfECldhFC
         iz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEs6j4wAqBBuONrdeiF9MFQLXTSsR5o6oHHKATeUrkM=;
        b=kZWP2QYcva0W3ZraNot4JWsUebVNVyfV+EGFut1i5021aigS/Q2xoN2Iz0Xp3Tv8fI
         Kcgd5SaYjP2L37IOxSwiIhyzoi93w1C7Ib2+rrvk26I4UN+FZdtT6F6JDcivmFpa2hCB
         kh7Nd7ExAc1Ri5TETgmmg8IlQZhsFJ+bxREx2Jn/kPq8zPjgK6kHCGJLWlKskCvQ4E/q
         IKxYVrcSdMAdGDzjJ1n1wwa3/K8d6hlP97EbAtFNWehpPUnJvWw1pk+NzBcsEgJkjIGn
         UyyH9IdE9ZVnRf8KGVPz89JP2LcWlQ+NuKiB0uPJ1Lb1zRR3LQPGxTDDF5D1Czdklq00
         qR0w==
X-Gm-Message-State: AHQUAuZG2RdTrg6DUCs2PJ7Yxc+6je/XabO6azUN7NUuZOk9bULNnMrZ
        PomEYLrQ+xwhcj7ePsMc049v/e1/jy9mxnK5UMuzfh5Wqco=
X-Google-Smtp-Source: AHgI3IZYXy6DniwkOwzNXgxmI8Hzor4TjYCetDQuBs+m6DSXTdc0zJU2P0K7n1kmJ+OEftknMjZaq96KpaGvMoyHDfE=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr243855itb.77.1549396460531;
 Tue, 05 Feb 2019 11:54:20 -0800 (PST)
MIME-Version: 1.0
References: <1502987818-24065-1-git-send-email-pbonzini@redhat.com> <1502987818-24065-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1502987818-24065-4-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 5 Feb 2019 11:54:09 -0800
Message-ID: <CALMp9eQXNxwiyYs=EqOAG9i7E-HwVLzs3N9v4rod4w-peewMdQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: fix use of L1 MMIO areas in nested guests
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2017 at 9:37 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> There is currently some confusion between nested and L1 GPAs.  The
> assignment to "direct" in kvm_mmu_page_fault tries to fix that, but
> it is not enough.  What this patch does is fence off the MMIO cache
> completely when using shadow nested page tables, since we have neither
> a GVA nor an L1 GPA to put in the cache.  This also allows some
> simplifications in kvm_mmu_page_fault and FNAME(page_fault).
>
> The EPT misconfig likewise does not have an L1 GPA to pass to
> kvm_io_bus_write, so that must be skipped for guest mode.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: standardize on "nGPA" moniker, replace nested ifs with &&
>
>  arch/x86/kvm/mmu.c         | 10 +++++++++-
>  arch/x86/kvm/paging_tmpl.h |  3 +--
>  arch/x86/kvm/vmx.c         |  7 ++++++-
>  arch/x86/kvm/x86.h         |  6 +++++-
>  4 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index a2c592b14617..02f8c507b160 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3596,6 +3596,14 @@ static bool is_shadow_zero_bits_set(struct kvm_mmu *mmu, u64 spte, int level)
>
>  static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
>  {
> +       /*
> +        * A nested guest cannot use the MMIO cache if it is using nested
> +        * page tables, because cr2 is a nGPA while the cache stores L1's
> +        * physical addresses.
> +        */
> +       if (mmu_is_nested(vcpu))
> +               return false;
> +
>         if (direct)
>                 return vcpu_match_mmio_gpa(vcpu, addr);
>
> @@ -4841,7 +4849,7 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
>  {
>         int r, emulation_type = EMULTYPE_RETRY;
>         enum emulation_result er;
> -       bool direct = vcpu->arch.mmu.direct_map || mmu_is_nested(vcpu);
> +       bool direct = vcpu->arch.mmu.direct_map;
>
>         /* With shadow page tables, fault_address contains a GVA or nGPA.  */
>         if (vcpu->arch.mmu.direct_map) {
> diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> index 3bb90ceeb52d..86b68dc5a649 100644
> --- a/arch/x86/kvm/paging_tmpl.h
> +++ b/arch/x86/kvm/paging_tmpl.h
> @@ -790,8 +790,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gva_t addr, u32 error_code,
>                          &map_writable))
>                 return 0;
>
> -       if (handle_abnormal_pfn(vcpu, mmu_is_nested(vcpu) ? 0 : addr,
> -                               walker.gfn, pfn, walker.pte_access, &r))
> +       if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
>                 return r;
>
>         /*
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index e2c8b33c35d1..61389ad784e4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -6402,8 +6402,13 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
>         int ret;
>         gpa_t gpa;
>
> +       /*
> +        * A nested guest cannot optimize MMIO vmexits, because we have an
> +        * nGPA here instead of the required GPA.
> +        */
>         gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> -       if (!kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
> +       if (!is_guest_mode(vcpu) &&
> +           !kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
>                 trace_kvm_fast_mmio(gpa);
>                 return kvm_skip_emulated_instruction(vcpu);
>         }
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 612067074905..113460370a7f 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -90,7 +90,11 @@ static inline u32 bit(int bitno)
>  static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
>                                         gva_t gva, gfn_t gfn, unsigned access)
>  {
> -       vcpu->arch.mmio_gva = gva & PAGE_MASK;
> +       /*
> +        * If this is a shadow nested page table, the "GVA" is
> +        * actually a nGPA.
> +        */
> +       vcpu->arch.mmio_gva = mmu_is_nested(vcpu) ? 0 : gva & PAGE_MASK;
>         vcpu->arch.access = access;
>         vcpu->arch.mmio_gfn = gfn;
>         vcpu->arch.mmio_gen = kvm_memslots(vcpu->kvm)->generation;
> --
> 1.8.3.1

Should this patch be considered for the stable branches?
