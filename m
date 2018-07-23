Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69BE20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJeKtyKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69BE20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbeGWHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:10:42 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46512 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeGWHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:10:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so31229201oie.13;
        Sun, 22 Jul 2018 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6A5l6LJEOFut8eq2uqQ86VByLjugLwtjF4aMLtUM7w=;
        b=UJeKtyKsTdtIXoEYF8bmTtYynZ4ZZzxpZPaEtJBHRPvygIInA6nPLIdga4bZnhDekQ
         /VSryy+9q7jrjawSEVv2AuuNppIdOFk7i8QpCJKsxbYUG7WYC83k7NPJA2HX9NUKNam8
         1zXjhVA3q/YARB9+yeV5htPBj2jciR1sIwNye8mzAkHn7/cXubatvbo5Y8tz1mfrCVJT
         dlN5CjKE8p/glK9ZsDwYnnrcj1bOceYhkl5ZC42pgyg6i2DQ/o48sTLDeUWbvBxP2dEB
         K1jh57vLvTp5FEgJ53go0F5hWVHazHEao3qF28rm1qZMk0fmaHr1bGjasLeWFRQor41D
         2oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6A5l6LJEOFut8eq2uqQ86VByLjugLwtjF4aMLtUM7w=;
        b=JHvCpJy2NvH4GYdsPfP2wUIYzdeWIw2Imx8HxHPi9KeRk0jWyAjvzGgv+uMDbMeete
         pR1Mx8yJ8Uiv/oo1cwkdHMYOQ3jnip9RK3PAWZFzCuE/z9+HkOwC/HgiIAcmDCb8B1x7
         YUrMMRFBu2TnGSV9DvUUjP+mKkHVulXHCe1naFkPpiCTi/3b9MwmDnuqTt00EJefj9E/
         mMMCUhOgzbVwJtEXvkNk7DDVOA9YAwCViZ+p+PG2/GIOPRf6ir66foEtx+y6w6zuLQIM
         WO1Zk0PwzvIYPI5GYxh7cMG8Gwg9IBylggoRqKxANWt5CpN9ArvUTrggWUzmBsuL8kbI
         2hMA==
X-Gm-Message-State: AOUpUlES1lxVRtJmTOUU8X1j2mpzLs/30O19fKu5UguWNrhsqbtmK9V1
        TAQ/D4K8CbDuClflT4dbZWaJ3w0MLr9H6BtLVg4=
X-Google-Smtp-Source: AAOMgpemzzakrbhAJzUoZZfWzb2+LMHtfjY099xEBD4WxX06H30EQxRRDxMZeSPER0pqZIoKShPNeXHHaPWxQ3CFTKU=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr7796170oix.74.1532326268162;
 Sun, 22 Jul 2018 23:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <1532104133-15777-1-git-send-email-wanpengli@tencent.com>
 <ea83d8dd-2c9b-c3fb-c88b-f48ad1d06240@redhat.com> <CANRm+CydLkevz4MNi6rzWo8CD4NE6sGv+qREFoPPadqg3V11Eg@mail.gmail.com>
In-Reply-To: <CANRm+CydLkevz4MNi6rzWo8CD4NE6sGv+qREFoPPadqg3V11Eg@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 23 Jul 2018 14:10:59 +0800
Message-ID: <CANRm+Cwt=eUcfu7oZr8U5JT9rKS9wMFoHe+hwfzF88xqrFKD0g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] KVM: X86: Implement PV IPIs send hypercall
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 at 14:00, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> On Mon, 23 Jul 2018 at 13:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 20/07/2018 18:28, Wanpeng Li wrote:
> > > +a0: ipi_bitmap low 64 bits
> > > +a1: ipi_bitmap high 64 bits
> > > +a2: the lowest APIC ID in bitmap
> > > +a3: APIC ICR
> > > +
> > > +The hypercall lets a guest send multicast IPIs at most can handle
> > > +128 vCPUs per hypercall on 64-bit machines and 64 vCPUs per hypercall
> > > +on 32-bit machines.
> > > +
> > > +Returns 0 if successfully delivery the IPIs and 1 if discarded.
> >
> > This description does not mention what happens in 32-bit mode.

Sorry, I think I mentioned "64 vCPUs per hypercall on 32-bit machines" above.

Regards,
Wanpeng Li

>
> Will do in next version.
>
> >
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 2b812b3..016c7e2 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -6691,6 +6691,41 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
> > >       kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
> > >  }
> > >
> > > +/*
> > > + * Return 0 if successfully added and 1 if discarded.
> > > + */
> > > +static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > > +             unsigned long ipi_bitmap_high, int min, int vector, int op_64_bit)
> > > +{
> > > +     int i;
> > > +     struct kvm_apic_map *map;
> > > +     struct kvm_vcpu *vcpu;
> > > +     struct kvm_lapic_irq irq = {
> > > +             .delivery_mode = APIC_DM_FIXED,
> > > +             .vector = vector,
> > > +     };
> > > +
> > > +     rcu_read_lock();
> > > +     map = rcu_dereference(kvm->arch.apic_map);
> > > +
> > > +     for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> > > +             vcpu = map->phys_map[min + i]->vcpu;
> > > +             if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > > +                     return 1;
> > > +     }
> > > +
> > > +     if (op_64_bit) {
> > > +             for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
> > > +                     vcpu = map->phys_map[min + i + BITS_PER_LONG]->vcpu;
> > > +                     if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > > +                             return 1;
> > > +             }
> > > +     }
> >
> > The second loop processes the second argument, and it should always run,
> > even in 32-bit mode.  However, the phys_map index should be min + i + 32
> > in 32-bit mode and min + i + 64 in 64-bit mode.  (Using BITS_PER_LONG in
> > the for_each_set_bit length is not a bug instead; you could write it
> > explicitly as 32 in 32-bit mode, and 64 in 64-bit mode, but I think it's
> > a little bit more efficient if it's constant).
>
> Good catch, below should fix it.
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c9dbc2c..c118040 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6701,6 +6701,7 @@ static int kvm_pv_send_ipi(struct kvm *kvm,
> unsigned long ipi_bitmap_low,
>      struct kvm_apic_map *map;
>      struct kvm_vcpu *vcpu;
>      struct kvm_lapic_irq irq = {0};
> +    int cluster_size = op_64_bit ? 64 : 32;
>
>      switch (icr & APIC_VECTOR_MASK) {
>      default:
> @@ -6714,18 +6715,16 @@ static int kvm_pv_send_ipi(struct kvm *kvm,
> unsigned long ipi_bitmap_low,
>      rcu_read_lock();
>      map = rcu_dereference(kvm->arch.apic_map);
>
> -    for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> +    for_each_set_bit(i, &ipi_bitmap_low, cluster_size) {
>          vcpu = map->phys_map[min + i]->vcpu;
>          if (!kvm_apic_set_irq(vcpu, &irq, NULL))
>              return 1;
>      }
>
> -    if (op_64_bit) {
> -        for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
> -            vcpu = map->phys_map[min + i + BITS_PER_LONG]->vcpu;
> -            if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> -                return 1;
> -        }
> +    for_each_set_bit(i, &ipi_bitmap_high, cluster_size) {
> +        vcpu = map->phys_map[min + i + cluster_size]->vcpu;
> +        if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> +            return 1;
>      }
>
>      rcu_read_unlock();
