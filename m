Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0576AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE1120846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE1120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbeGWHI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:08:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728188AbeGWHI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA5118790F;
        Mon, 23 Jul 2018 06:09:24 +0000 (UTC)
Received: from [10.36.116.129] (ovpn-116-129.ams2.redhat.com [10.36.116.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF462156897;
        Mon, 23 Jul 2018 06:09:22 +0000 (UTC)
Subject: Re: [PATCH v4 4/6] KVM: X86: Implement PV IPIs send hypercall
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <1532104133-15777-1-git-send-email-wanpengli@tencent.com>
 <ea83d8dd-2c9b-c3fb-c88b-f48ad1d06240@redhat.com>
 <CANRm+CydLkevz4MNi6rzWo8CD4NE6sGv+qREFoPPadqg3V11Eg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e9037977-b6e6-b807-f9e5-8acaacb00f26@redhat.com>
Date:   Mon, 23 Jul 2018 08:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CydLkevz4MNi6rzWo8CD4NE6sGv+qREFoPPadqg3V11Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 06:09:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 06:09:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pbonzini@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2018 08:00, Wanpeng Li wrote:
> On Mon, 23 Jul 2018 at 13:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 20/07/2018 18:28, Wanpeng Li wrote:
>>> +a0: ipi_bitmap low 64 bits
>>> +a1: ipi_bitmap high 64 bits
>>> +a2: the lowest APIC ID in bitmap
>>> +a3: APIC ICR
>>> +
>>> +The hypercall lets a guest send multicast IPIs at most can handle
>>> +128 vCPUs per hypercall on 64-bit machines and 64 vCPUs per hypercall
>>> +on 32-bit machines.
>>> +
>>> +Returns 0 if successfully delivery the IPIs and 1 if discarded.
>>
>> This description does not mention what happens in 32-bit mode.
> 
> Will do in next version.
> 
>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 2b812b3..016c7e2 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -6691,6 +6691,41 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
>>>       kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
>>>  }
>>>
>>> +/*
>>> + * Return 0 if successfully added and 1 if discarded.
>>> + */
>>> +static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
>>> +             unsigned long ipi_bitmap_high, int min, int vector, int op_64_bit)
>>> +{
>>> +     int i;
>>> +     struct kvm_apic_map *map;
>>> +     struct kvm_vcpu *vcpu;
>>> +     struct kvm_lapic_irq irq = {
>>> +             .delivery_mode = APIC_DM_FIXED,
>>> +             .vector = vector,
>>> +     };
>>> +
>>> +     rcu_read_lock();
>>> +     map = rcu_dereference(kvm->arch.apic_map);
>>> +
>>> +     for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
>>> +             vcpu = map->phys_map[min + i]->vcpu;
>>> +             if (!kvm_apic_set_irq(vcpu, &irq, NULL))
>>> +                     return 1;
>>> +     }
>>> +
>>> +     if (op_64_bit) {
>>> +             for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
>>> +                     vcpu = map->phys_map[min + i + BITS_PER_LONG]->vcpu;
>>> +                     if (!kvm_apic_set_irq(vcpu, &irq, NULL))
>>> +                             return 1;
>>> +             }
>>> +     }
>>
>> The second loop processes the second argument, and it should always run,
>> even in 32-bit mode.  However, the phys_map index should be min + i + 32
>> in 32-bit mode and min + i + 64 in 64-bit mode.  (Using BITS_PER_LONG in
>> the for_each_set_bit length is not a bug instead; you could write it
>> explicitly as 32 in 32-bit mode, and 64 in 64-bit mode, but I think it's
>> a little bit more efficient if it's constant).
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
> 

Yes, that should work.  Thanks!

Paolo
