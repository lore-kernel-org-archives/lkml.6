Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D160120673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoFL6Cmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D160120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeGTETL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:19:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41280 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeGTETL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:19:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so18879732oiw.8;
        Thu, 19 Jul 2018 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7W1HzVVFQ48fXhWL9ZZiEzy16uZ4PjriF76NuVuWPo=;
        b=VoFL6Cmy4CrH/1+qfQLULvSUwokFBPkBFlSmkB0Xrkr5bHH/XXINTfl5/oXNJ0Lmih
         5Zaz0buRatnRymeftujxMGSOHXg4oOC51kFfnZYyo8nOI6r6x1yeHpsmXnR92egGd/QL
         eobZ8HKZvP6cdAvlA+D68BDMXHXzgSBqFpFOvsWUxAl4XwsEbTndSqqlxSzvv1Q4NGip
         dCIW2nIKViyyP7ragu6oeCUel1bwfhC0z88bFtkR9aNcV+21NfLxM7q0zBZxcuHjE2iX
         Oz+tx0Slkz5JmmR+yHRySxeTykQLEDwtg+hQdcB0b7jK1pHvd/jU3+ZBHEYUCsT19tLJ
         /5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7W1HzVVFQ48fXhWL9ZZiEzy16uZ4PjriF76NuVuWPo=;
        b=L0PYygifXc61EsxajfDGa9kNbGH18Cy1gwFq+T5qXrG3NkdGRC8NbU/7u/f0t3xI6m
         7fhoMxZs0CVvK7j5sOMDNHKhmDWp73VWU4/FbRMIfQCFvqX0LQPwhfAbuuVourQUpsA9
         5GkM+cbWmmBAI/6tvpkYMFjPD6DYqNTmzzzkqbfmllhzZO+az6hjBazbIb3+rVI/wMSS
         nNmAXNaE9o8OtVrtNnNmb5rIKIex4PmLfXP0FW4v5vzIBq6ggN6tZ0Z5e9wHPDMK1S23
         gJRSP/WGZgMO3nuplI03f+EUuKoOobteGyRH7nPe5+dKuYh77EFTC6L6Z3RRvSelN8LE
         aEQw==
X-Gm-Message-State: AOUpUlGvJlSaCcQ0bb4dL6+GWUAKKD8AZcsj7v35BwYKfQB8hZU3Q8yL
        mtWvwFbVN7VF9TYoI2efXYrWLKW70w1jOZbCT4g=
X-Google-Smtp-Source: AAOMgpfLMsGUiJSn+qqP9pyG1sK9Bsf5yp/dOBYDRiqYGEzT30QYDNAWz11KrdXQfwPWSyL8bQiFD/jO7xYLj4P5L3A=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr348801oie.233.1532057583082;
 Thu, 19 Jul 2018 20:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com> <20180719162826.GB11749@flask>
In-Reply-To: <20180719162826.GB11749@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 11:33:07 +0800
Message-ID: <CANRm+CxztUxixUNtsfZC3D1Zeo8QJsTefc565CkMBqWyXVfuzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 00:28, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.c=
om> wrote:
>
> 2018-07-03 14:21+0800, Wanpeng Li:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Implement paravirtual apic hooks to enable PV IPIs.
> >
> > apic->send_IPI_mask
> > apic->send_IPI_mask_allbutself
> > apic->send_IPI_allbutself
> > apic->send_IPI_all
> >
> > The PV IPIs supports maximal 128 vCPUs VM, it is big enough for cloud
> > environment currently, supporting more vCPUs needs to introduce more
> > complex logic, in the future this might be extended if needed.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > @@ -454,6 +454,71 @@ static void __init sev_map_percpu_data(void)
> >  }
> >
> >  #ifdef CONFIG_SMP
> > +
> > +#ifdef CONFIG_X86_64
> > +static void __send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +     unsigned long flags, ipi_bitmap_low =3D 0, ipi_bitmap_high =3D 0;
> > +     int cpu, apic_id;
> > +
> > +     if (cpumask_empty(mask))
> > +             return;
> > +
> > +     local_irq_save(flags);
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             apic_id =3D per_cpu(x86_cpu_to_apicid, cpu);
> > +             if (apic_id < BITS_PER_LONG)
> > +                     __set_bit(apic_id, &ipi_bitmap_low);
> > +             else if (apic_id < 2 * BITS_PER_LONG)
> > +                     __set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_hi=
gh);
>
> It'd be nicer with 'unsigned long ipi_bitmap[2]' and a single
>
>         __set_bit(apic_id, ipi_bitmap);
>
> > +     }
> > +
> > +     kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, =
vector);
>
> and
>
>         kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap[0], ipi_bitmap[1], vec=
tor);
>
> Still, the main problem is that we can only address 128 APICs.
>
> A simple improvement would reuse the vector field (as we need only 8
> bits) and put a 'offset' in the rest.  The offset would say which
> cluster of 128 are we addressing.  24 bits of offset results in 2^31
> total addressable CPUs (we probably should even use that many bits).
> The downside of this is that we can only address 128 at a time.
>
> It's basically the same as x2apic cluster mode, only with 128 cluster
> size instead of 16, so the code should be a straightforward port.
> And because x2apic code doesn't seem to use any division by the cluster
> size, we could even try to use kvm_hypercall4, add ipi_bitmap[2], and
> make the cluster size 192. :)
>
> But because it is very similar to x2apic, I'd really need some real
> performance data to see if this benefits a real workload.

Thanks for your review, Radim! :) I will find another real benchmark
instead of the micro one to evaluate the performance.

> Hardware could further optimize LAPIC (apicv, vapic) in the future,
> which we'd lose by using paravirt.
>
> e.g. AMD's acceleration should be superior to this when using < 8 VCPUs
> as they can use logical xAPIC and send without VM exits (when all VCPUs
> are running).
>
> > +
> > +     local_irq_restore(flags);
> > +}
> > +
> > +static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +     __send_ipi_mask(mask, vector);
> > +}
> > +
> > +static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, i=
nt vector)
> > +{
> > +     unsigned int this_cpu =3D smp_processor_id();
> > +     struct cpumask new_mask;
> > +     const struct cpumask *local_mask;
> > +
> > +     cpumask_copy(&new_mask, mask);
> > +     cpumask_clear_cpu(this_cpu, &new_mask);
> > +     local_mask =3D &new_mask;
> > +     __send_ipi_mask(local_mask, vector);
> > +}
> > +
> > +static void kvm_send_ipi_allbutself(int vector)
> > +{
> > +     kvm_send_ipi_mask_allbutself(cpu_online_mask, vector);
> > +}
> > +
> > +static void kvm_send_ipi_all(int vector)
> > +{
> > +     __send_ipi_mask(cpu_online_mask, vector);
>
> These should be faster when using the native APIC shorthand -- is this
> the "Broadcast" in your tests?

Not true, .send_IPI_all almost no callers though linux apic drivers
implement this hook, in addition, shortcut is not used for x2apic
mode(__x2apic_send_IPI_dest()), and very limited using in other
scenarios according to linux apic drivers.

>
> > +}
> > +
> > +/*
> > + * Set the IPI entry points
> > + */
> > +static void kvm_setup_pv_ipi(void)
> > +{
> > +     apic->send_IPI_mask =3D kvm_send_ipi_mask;
> > +     apic->send_IPI_mask_allbutself =3D kvm_send_ipi_mask_allbutself;
> > +     apic->send_IPI_allbutself =3D kvm_send_ipi_allbutself;
> > +     apic->send_IPI_all =3D kvm_send_ipi_all;
> > +     pr_info("KVM setup pv IPIs\n");
> > +}
> > +#endif
> > +
> >  static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
> >  {
> >       native_smp_prepare_cpus(max_cpus);
> > @@ -626,6 +691,11 @@ static uint32_t __init kvm_detect(void)
> >
> >  static void __init kvm_apic_init(void)
> >  {
> > +#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
> > +     if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
> > +             num_possible_cpus() <=3D 2 * BITS_PER_LONG)
>
> It looks that num_possible_cpus() is actually NR_CPUS, so the feature
> would never be used on a standard Linux distro.
> And we're using APIC_ID, which can be higher even if maximum CPU the
> number is lower.  Just remove it.

Will do.

Regards,
Wanpeng Li
