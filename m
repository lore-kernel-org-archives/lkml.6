Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C04120874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWAEYfD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C04120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbeGWHAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:00:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43232 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeGWHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:00:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so31159274oib.10;
        Sun, 22 Jul 2018 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kf3pR+Aa4Fa1bVI7pxeuEmiU30pweXtXXN2bIr2GSPc=;
        b=VWAEYfD1lT0n/29J6Ztn23jTkyvMOCg8n4zWIX52IFUHvOKbod+LK5nrFFU2+RC5jb
         VxYp7cYMqB+HHpE5ObIZ2fjWFMnl+TKTMHa1Ugk1ByNeAyUmxSOISdewju+eT5O9PdGh
         Fjt68Pyez7frtUaeTb5o9fheFD8Edl4FXUMrpWpyuPlfZsvpEBh2qH8MNY+N7TrqAUcR
         2olmgemJy7SX66SKSSJOVSfkDayQkMvgchOua/+AaVsADdyPTjNtTEyCzwC3BTjPa3Z7
         xfKvHJKrmSYPBVBrim8S30D4+YWFZFNvABuXt8bfikI4Nj8a8WFsrm997zEXQiS07kJk
         vxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kf3pR+Aa4Fa1bVI7pxeuEmiU30pweXtXXN2bIr2GSPc=;
        b=Ov5wk6uruS8VVQwnKXUS1csh4IoVm02va9qONOyPIXlC/ipgQvtZhGhTqDvq2RDaX/
         GNF65RVI7uBms52YKvFXjUL8PXC/wNCqmTQQq7VmPjqOqTtJAVNsm6q81NEcb0rwXiMp
         zLSDVdxnWExydpnOCB2LruTkQVHyjD6V+psVLMpfPy0vDiYru/X8ypkG+6H5qj9qfB0Y
         gvSvIG3m7JxpfmA/7NXlY4mM7jrU8CYg/mG93Dc19VlKmc6StMAZHLJVjYHz0tdy8zqU
         zwkX7PIHPLb19O43rnhpsPGUru+yWAAofTaiCUwvAsUsVxeTLzhFZM2amfpRHm3GWAFp
         zxww==
X-Gm-Message-State: AOUpUlFJ+6l6DFmF5jk7ofIDWQgCdXWVbJsDPT7NLpj8sAWr+NOQFN2n
        vefez1sfP5Z8n5AGwLoHLdTECIsTkRNho+sI3dw=
X-Google-Smtp-Source: AAOMgpf+Ibvs44B6+3uH9wxsRXt2RY2CKiTbVpnsHa7txcujv88Mi54o3GcLLSfoX1OTqkEQxTywA+qIdc8SvqU5DfU=
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr7698035oif.119.1532325641322;
 Sun, 22 Jul 2018 23:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <1532104133-15777-1-git-send-email-wanpengli@tencent.com> <ea83d8dd-2c9b-c3fb-c88b-f48ad1d06240@redhat.com>
In-Reply-To: <ea83d8dd-2c9b-c3fb-c88b-f48ad1d06240@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 23 Jul 2018 14:00:32 +0800
Message-ID: <CANRm+CydLkevz4MNi6rzWo8CD4NE6sGv+qREFoPPadqg3V11Eg@mail.gmail.com>
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

On Mon, 23 Jul 2018 at 13:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/07/2018 18:28, Wanpeng Li wrote:
> > +a0: ipi_bitmap low 64 bits
> > +a1: ipi_bitmap high 64 bits
> > +a2: the lowest APIC ID in bitmap
> > +a3: APIC ICR
> > +
> > +The hypercall lets a guest send multicast IPIs at most can handle
> > +128 vCPUs per hypercall on 64-bit machines and 64 vCPUs per hypercall
> > +on 32-bit machines.
> > +
> > +Returns 0 if successfully delivery the IPIs and 1 if discarded.
>
> This description does not mention what happens in 32-bit mode.

Will do in next version.

>
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 2b812b3..016c7e2 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6691,6 +6691,41 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
> >       kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
> >  }
> >
> > +/*
> > + * Return 0 if successfully added and 1 if discarded.
> > + */
> > +static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > +             unsigned long ipi_bitmap_high, int min, int vector, int op_64_bit)
> > +{
> > +     int i;
> > +     struct kvm_apic_map *map;
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_lapic_irq irq = {
> > +             .delivery_mode = APIC_DM_FIXED,
> > +             .vector = vector,
> > +     };
> > +
> > +     rcu_read_lock();
> > +     map = rcu_dereference(kvm->arch.apic_map);
> > +
> > +     for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> > +             vcpu = map->phys_map[min + i]->vcpu;
> > +             if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > +                     return 1;
> > +     }
> > +
> > +     if (op_64_bit) {
> > +             for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
> > +                     vcpu = map->phys_map[min + i + BITS_PER_LONG]->vcpu;
> > +                     if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > +                             return 1;
> > +             }
> > +     }
>
> The second loop processes the second argument, and it should always run,
> even in 32-bit mode.  However, the phys_map index should be min + i + 32
> in 32-bit mode and min + i + 64 in 64-bit mode.  (Using BITS_PER_LONG in
> the for_each_set_bit length is not a bug instead; you could write it
> explicitly as 32 in 32-bit mode, and 64 in 64-bit mode, but I think it's
> a little bit more efficient if it's constant).

Good catch, below should fix it.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9dbc2c..c118040 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6701,6 +6701,7 @@ static int kvm_pv_send_ipi(struct kvm *kvm,
unsigned long ipi_bitmap_low,
     struct kvm_apic_map *map;
     struct kvm_vcpu *vcpu;
     struct kvm_lapic_irq irq = {0};
+    int cluster_size = op_64_bit ? 64 : 32;

     switch (icr & APIC_VECTOR_MASK) {
     default:
@@ -6714,18 +6715,16 @@ static int kvm_pv_send_ipi(struct kvm *kvm,
unsigned long ipi_bitmap_low,
     rcu_read_lock();
     map = rcu_dereference(kvm->arch.apic_map);

-    for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
+    for_each_set_bit(i, &ipi_bitmap_low, cluster_size) {
         vcpu = map->phys_map[min + i]->vcpu;
         if (!kvm_apic_set_irq(vcpu, &irq, NULL))
             return 1;
     }

-    if (op_64_bit) {
-        for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
-            vcpu = map->phys_map[min + i + BITS_PER_LONG]->vcpu;
-            if (!kvm_apic_set_irq(vcpu, &irq, NULL))
-                return 1;
-        }
+    for_each_set_bit(i, &ipi_bitmap_high, cluster_size) {
+        vcpu = map->phys_map[min + i + cluster_size]->vcpu;
+        if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+            return 1;
     }

     rcu_read_unlock();
