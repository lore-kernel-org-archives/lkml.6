Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A932ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D634F20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHcU4HRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D634F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGSXu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:50:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43890 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbeGSXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:50:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id m12-v6so496837lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GNDXFinDuqjRE/pBPRFb1LMrWIfFGzOYlNzCBu0aQ6M=;
        b=XHcU4HRvU0othR0WoD+9hFqHY+US/7KzIT+UR1p/cKdo8tPWFOQET8nI/Ak3/7akLT
         k9kMo9YnJLIq4pA7KWjvQXiacrxHmLFlRUiy1MFnKBNMAo5+HZBk5gynv4GtZQuILVF0
         vQ+h62RX8EtAo0pQYMk82y5tkf0Ig04b9Ut7NJijOup/858Tb01slmv/BqOJ2y18iaaa
         m0wDJyDaN6ak5kTsyTLUP+sROqBePyLXuoY025+eTLbniHakCWch2yKsbg+t+CcyM/v/
         va2UiCz5aFhDzYyutt3UomxrZGPzO4xRQRqp7MBsHYaEYSVYoGbvSwBGri1WHjy6cW+F
         EVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GNDXFinDuqjRE/pBPRFb1LMrWIfFGzOYlNzCBu0aQ6M=;
        b=A2yW8gZ3VO8Qhxxlzfyvr0iLkyjKcjC5Rjf15ObQeDhaQ1BniJNKoM23fGEq3FWplZ
         gCX1mw+Dh9onjyoAUlXmCXWjxDW7JRv7R0x9uPrXn4GzUbi6pQ6GdouEQlpZ+ui1pR6F
         dVLjWTPcZhLuviYumrzRwwNYHfOiewgU6VQedySuprF3MBZmiOPJFUb3Z6waGYZevr0w
         GIKeM0OZXO6S32l0PLBV3x/YLcn6OO37vtGuzlXtKXUYhaN8EtGazhS/ygMRR2z7MmiH
         iH8HQLIX+mClZTZBbEb5aY8pcCV8fqV5CH2lpg6WPGhmeM3yguoovC/QcFvuOnvxMMm7
         jsjQ==
X-Gm-Message-State: AOUpUlF45h7AkE5uvyALg25qwqU02gIR0E8aAInJN2f13clkNWf6/EpT
        d2mkWNmr7M2WahTE98labROArMnO8Vt6fBg3tamRryZX
X-Google-Smtp-Source: AAOMgpfA9kNJNHvdMkdqKp2odZ5UCQFxibVjal+yVl2tNsIQHVz9illnb0UR8lL5eNkBqvMOABMRCmxo2Va18XpwTE8=
X-Received: by 2002:a19:9d92:: with SMTP id g140-v6mr8193506lfe.85.1532041540279;
 Thu, 19 Jul 2018 16:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com> <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 19 Jul 2018 16:05:14 -0700
Message-ID: <CALzav=fUmJZSvDgTvsB-7nyv1KiAMHgVcq-N+k0WCn3OsrVpNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:23 PM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Implement paravirtual apic hooks to enable PV IPIs.

Very cool. Thanks for working on this!

>
> apic->send_IPI_mask
> apic->send_IPI_mask_allbutself
> apic->send_IPI_allbutself
> apic->send_IPI_all
>
> The PV IPIs supports maximal 128 vCPUs VM, it is big enough for cloud
> environment currently,

From the Cloud perspective, 128 vCPUs is already obsolete. GCE's
n1-utlramem-160 VMs have 160 vCPUs where the maximum APIC ID is 231.
I'd definitely prefer an approach that scales to higher APIC IDs, like
Paolo's offset idea.

To Radim's point of real world performance testing, do you know what
is the primary source of multi-target IPIs? If it's TLB shootdowns we
might get a bigger bang for our buck with a PV TLB Shootdown.

> supporting more vCPUs needs to introduce more
> complex logic, in the future this might be extended if needed.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/include/uapi/asm/kvm_para.h |  1 +
>  arch/x86/kernel/kvm.c                | 70 ++++++++++++++++++++++++++++++=
++++++
>  include/uapi/linux/kvm_para.h        |  1 +
>  3 files changed, 72 insertions(+)
>
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi=
/asm/kvm_para.h
> index 0ede697..19980ec 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -28,6 +28,7 @@
>  #define KVM_FEATURE_PV_UNHALT          7
>  #define KVM_FEATURE_PV_TLB_FLUSH       9
>  #define KVM_FEATURE_ASYNC_PF_VMEXIT    10
> +#define KVM_FEATURE_PV_SEND_IPI        11
>
>  #define KVM_HINTS_REALTIME      0
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 591bcf2..2fe1420 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -454,6 +454,71 @@ static void __init sev_map_percpu_data(void)
>  }
>
>  #ifdef CONFIG_SMP
> +
> +#ifdef CONFIG_X86_64
> +static void __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +       unsigned long flags, ipi_bitmap_low =3D 0, ipi_bitmap_high =3D 0;
> +       int cpu, apic_id;
> +
> +       if (cpumask_empty(mask))
> +               return;
> +
> +       local_irq_save(flags);
> +
> +       for_each_cpu(cpu, mask) {
> +               apic_id =3D per_cpu(x86_cpu_to_apicid, cpu);
> +               if (apic_id < BITS_PER_LONG)
> +                       __set_bit(apic_id, &ipi_bitmap_low);
> +               else if (apic_id < 2 * BITS_PER_LONG)
> +                       __set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_hi=
gh);
> +       }
> +
> +       kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, =
vector);
> +
> +       local_irq_restore(flags);
> +}
> +
> +static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +       __send_ipi_mask(mask, vector);
> +}
> +
> +static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int=
 vector)
> +{
> +       unsigned int this_cpu =3D smp_processor_id();
> +       struct cpumask new_mask;
> +       const struct cpumask *local_mask;
> +
> +       cpumask_copy(&new_mask, mask);
> +       cpumask_clear_cpu(this_cpu, &new_mask);
> +       local_mask =3D &new_mask;
> +       __send_ipi_mask(local_mask, vector);
> +}
> +
> +static void kvm_send_ipi_allbutself(int vector)
> +{
> +       kvm_send_ipi_mask_allbutself(cpu_online_mask, vector);
> +}
> +
> +static void kvm_send_ipi_all(int vector)
> +{
> +       __send_ipi_mask(cpu_online_mask, vector);
> +}
> +
> +/*
> + * Set the IPI entry points
> + */
> +static void kvm_setup_pv_ipi(void)
> +{
> +       apic->send_IPI_mask =3D kvm_send_ipi_mask;
> +       apic->send_IPI_mask_allbutself =3D kvm_send_ipi_mask_allbutself;
> +       apic->send_IPI_allbutself =3D kvm_send_ipi_allbutself;
> +       apic->send_IPI_all =3D kvm_send_ipi_all;
> +       pr_info("KVM setup pv IPIs\n");
> +}
> +#endif
> +
>  static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
>  {
>         native_smp_prepare_cpus(max_cpus);
> @@ -626,6 +691,11 @@ static uint32_t __init kvm_detect(void)
>
>  static void __init kvm_apic_init(void)
>  {
> +#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
> +       if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
> +               num_possible_cpus() <=3D 2 * BITS_PER_LONG)
> +               kvm_setup_pv_ipi();
> +#endif
>  }
>
>  static void __init kvm_init_platform(void)
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.=
h
> index dcf629d..84f8fe3 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -26,6 +26,7 @@
>  #define KVM_HC_MIPS_EXIT_VM            7
>  #define KVM_HC_MIPS_CONSOLE_OUTPUT     8
>  #define KVM_HC_CLOCK_PAIRING           9
> +#define KVM_HC_SEND_IPI                10
>
>  /*
>   * hypercalls use architecture specific
> --
> 2.7.4
>
