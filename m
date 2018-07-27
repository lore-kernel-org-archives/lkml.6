Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111FF208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYX51ACK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111FF208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbeG0SL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:11:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33223 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbeG0SL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:11:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so10196130oii.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H4AVs7yQK3Fje4Idjghzuyqnxdj6ef5yWWZM+MGxAtE=;
        b=SYX51ACKbKomoA+agiTLHjJaou0WXf9PrQQi/pFLGBTK31jmOcPX4RALlEFfa05x7O
         wNnfTtdgUnb+/WaX4aZrEoBW0xzV4dQjdxuMDdtlEkQI92K33dLyG92GR5BD4UkMICqf
         OK9hccnUWCKSiXUWyNcSobNneVC6J1m0SRvOXVpeDwPN6Tw/sTycKPcCqevLn19/4Edf
         PC+XsrRnbTyyc/uepzXx1wz6Z0rLhrJ8zK0PHWGddwN1j8kj3548yyFDTNqvrlvl1dAX
         FfPOnf10yJJW4FGKWtyknhO8y6LqFO7uHsabTjREV49JUmGbjivJe+hF0qYO0AKq0dOE
         rGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H4AVs7yQK3Fje4Idjghzuyqnxdj6ef5yWWZM+MGxAtE=;
        b=NRevVHyzglDvhR/vfdmhyJuQd8jzCazt4BVk3KIe4xKjsbnLT8lir8UOBe712bLV0j
         B/kfgibwC5AzE2jjGL8JanalbF+uPAjQx3hfvxq0JRwPqVdcKQOR+q0rfFY/l7oQ9j+i
         3K7bqxdTrsHgczRGpFSe8AWaDt3JSwXWjPLXgZRtPUaXD+OGsecOhEJ8+74aMTyaYtXk
         lRzFBwRLnFIF9fJBzw/ZCu2IwBPttJyqqb+OgO+1JFWvmY5n60t7HJ3IYooyFiaHhfvD
         BkxtlB+50wDeyc+175gfmUe/H5JkyG9ywoQD6dujlyDPFPQlToWCrj4O47I8/mkpRKHD
         1cTA==
X-Gm-Message-State: AOUpUlFs0G6xL7poyhTtOasSvTqyeDYDOzco1MJ/peEtNsyjpMK2Qj4i
        4gEMcBoEE83YnB4LYk8q89c7njBQX4pd2Ak2vsIKeQ==
X-Google-Smtp-Source: AAOMgpffAUdfYD3iiqMlMK0a3hIwB/ikZi/CFM2evNZC3olynfNkbpLgKMFz2ROZeoAx2qq1h3UhWlDyh0wL/N7pq9c=
X-Received: by 2002:aca:efd7:: with SMTP id n206-v6mr7970033oih.70.1532710122930;
 Fri, 27 Jul 2018 09:48:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3404:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 09:48:42
 -0700 (PDT)
In-Reply-To: <20180727144448.9606-1-vkuznets@redhat.com>
References: <20180727144448.9606-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 27 Jul 2018 09:48:42 -0700
Message-ID: <CALMp9eSaiw7wMMhzKZQpM141h6zEz=shu5P++BerbQBTVyFdYA@mail.gmail.com>
Subject: Re: [PATCH RFC] x86/kvm/lapic: always disable MMIO interface in
 x2APIC mode
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a physical machine, I would expect the default local APIC page to
fall in the PCI hole, so it would be correct to sink writes and to
return all ones for reads. Does qemu implement a PCI hole, and does
this address fall into it?

On Fri, Jul 27, 2018 at 7:44 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> When VMX is used with flexpriority disabled (because of no support or
> if disabled with module parameter) MMIO interface to lAPIC is still
> available in x2APIC mode while it shouldn't be (kvm-unit-tests):
>
> PASS: apic_disable: Local apic enabled in x2APIC mode
> PASS: apic_disable: CPUID.1H:EDX.APIC[bit 9] is set
> FAIL: apic_disable: *0xfee00030: 50014
>
> The issue appears because we basically do nothing while switching to
> x2APIC mode when APIC access page is not used. apic_mmio_{read,write}
> only check if lAPIC is disabled before proceeding to actual write.
>
> When APIC access is virtualized we correctly manipulate with VMX controls
> in vmx_set_virtual_apic_mode() and we don't get vmexits from memory writes
> in x2APIC mode so there's no issue.
>
> Disabling MMIO interface seems to be easy. The question is: what do we
> do with these reads and writes? If we add apic_x2apic_mode() check to
> apic_mmio_in_range() and return -EOPNOTSUPP these reads and writes will
> go to userspace. When lAPIC is in kernel, Qemu uses this interface to
> inject MSIs only (see kvm_apic_mem_write() in hw/i386/kvm/apic.c). This
> somehow works with disabled lAPIC but when we're in xAPIC mode we will
> get a real injected MSI from every write to lAPIC. Not good.
>
> The simplest solution seems to be to just ignore writes to the region
> and return ~0 for all reads when we're in x2APIC mode. This is what this
> patch does. However, this approach is inconsistent with what currently
> happens when flexpriority is enabled: we allocate APIC access page and
> create KVM memory region so in x2APIC modes all reads and writes go to
> this pre-allocated page which is, btw, the same for all vCPUs.
>
> The other solution would be to pre-allocate a 'shadow' page for lAPICs
> in disabled/x2APIC mode and re-direct all reads and writes there. I'm,
> however, not convinced this is a good thing to do.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index b5cd8465d44f..89b59d6410ae 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1291,9 +1291,8 @@ EXPORT_SYMBOL_GPL(kvm_lapic_reg_read);
>
>  static int apic_mmio_in_range(struct kvm_lapic *apic, gpa_t addr)
>  {
> -       return kvm_apic_hw_enabled(apic) &&
> -           addr >= apic->base_address &&
> -           addr < apic->base_address + LAPIC_MMIO_LENGTH;
> +       return addr >= apic->base_address &&
> +               addr < apic->base_address + LAPIC_MMIO_LENGTH;
>  }
>
>  static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
> @@ -1305,6 +1304,11 @@ static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>         if (!apic_mmio_in_range(apic, address))
>                 return -EOPNOTSUPP;
>
> +       if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
> +               memset(data, 0xff, len);
> +               return 0;
> +       }
> +
>         kvm_lapic_reg_read(apic, offset, len, data);
>
>         return 0;
> @@ -1864,6 +1868,9 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
>         if (!apic_mmio_in_range(apic, address))
>                 return -EOPNOTSUPP;
>
> +       if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic))
> +               return 0;
> +
>         /*
>          * APIC register must be aligned on 128-bits boundary.
>          * 32/64/128 bits registers must be accessed thru 32 bits.
> --
> 2.14.4
>
