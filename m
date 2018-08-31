Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52079C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE6B2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff1JxQ5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE6B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHaEnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:43:33 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36807 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeHaEnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:43:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so18812140oie.3;
        Thu, 30 Aug 2018 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PlDAzwU1qaaQZfiyP0Sifb0zPhG2R0v+GgoqNEMhtaU=;
        b=ff1JxQ5MPGDlzrHag2XTdI0pYzuXoCyGrN7rAmr5yCFyvMBYJpbwd7L1OWbhDjcIpA
         QASFGEK/NcC0gIlQp4KDChR1v9djBJekeQTvxKfJwkZpcBpF2n3dQjpmqhdw2ERb5Oes
         QXxX/duizasI3nFScPmBKN0tvorDZiJyiTMliF388NiMSQFVqE3atCAiHsB/Q+yt0IBC
         hgJxg4FULW43FFJgMhNfdwo4xc+1o7IIClKjtmWovl9V9u0e5j5UdsUnypxEUXnOkF6c
         Xc0XJO6fi+r7li3pr9qin71pqC+kBIvVFfAX5OQ+F3C7cbRkFTWsCCWpoGDExrcQkwEJ
         Lc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PlDAzwU1qaaQZfiyP0Sifb0zPhG2R0v+GgoqNEMhtaU=;
        b=Incc6tHpqY8oUKYQW+c0ATIzJgGHkAWJXHmRRnQw6njKhZtKAJsr1Nh50aDI7HpaPJ
         uq/385nx+3fEh9bZ46dxv3ip4LCN6sGS5B7AN0aav7xuzbXdMs+6XyvugIJQ7NCSWogz
         sqGu5d0EEp1rnBVhaBwGE/8ewsixTHsD2lzDfiJ1v6dcBwbgYVXD/Ms1owjA4KBS6n4U
         peQ5K236OA2TlnTtApIsTbNJ566uTh7qMb8KpaHP4RYaWJZ5rEG5pk1WyzyjBfAACJX1
         UN8QuQbWXza5KeU2Cspe63xslGMAqpNmVCwtRg8WDnm8ebdqIer3LWMKkEEhu1F1TNiJ
         A7sg==
X-Gm-Message-State: APzg51BYbzCDKElXoNuy9OwQvh4HeZ/birHU28r6fFE56ntv/9VFKGFY
        Ya5BxCt7Zj8YJBfydYbDqu+XPdX4qB1a5E6GZuM=
X-Google-Smtp-Source: ANB0Vda5o857DrI8sc1rEikyvgBh/pJPYLZENSpeiskbO/OzgQZVuCfbKYNpxaekz+qmt8MHVlzWOhbvJF0XVQY1eUs=
X-Received: by 2002:aca:34d6:: with SMTP id b205-v6mr4705707oia.77.1535675926244;
 Thu, 30 Aug 2018 17:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <1535594610-9095-1-git-send-email-wanpengli@tencent.com> <20180830110121.GB19438@flask>
In-Reply-To: <20180830110121.GB19438@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 31 Aug 2018 08:38:52 +0800
Message-ID: <CANRm+Cw8ebLxtXu_2g2SvZm8T1Hvzhgm4CXapxu80udX9wkMfg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: LAPIC: Fix pv ipis out-of-bounds access
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 at 19:01, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.c=
om> wrote:
>
> 2018-08-30 10:03+0800, Wanpeng Li:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Dan Carpenter reported that the untrusted data returns from kvm_registe=
r_read()
> > results in the following static checker warning:
> >   arch/x86/kvm/lapic.c:576 kvm_pv_send_ipi()
> >   error: buffer underflow 'map->phys_map' 's32min-s32max'
> >
> > KVM guest can easily trigger this by executing the following assembly s=
equence
> > in Ring0:
> >
> > mov $10, %rax
> > mov $0xFFFFFFFF, %rbx
> > mov $0xFFFFFFFF, %rdx
> > mov $0, %rsi
> > vmcall
> >
> > As this will cause KVM to execute the following code-path:
> > vmx_handle_exit() -> handle_vmcall() -> kvm_emulate_hypercall() -> kvm_=
pv_send_ipi()
> > which will reach out-of-bounds access.
> >
> > This patch fixes it by adding a check to kvm_pv_send_ipi() against map-=
>max_apic_id,
> > ignoring destinations that are not present and delivering the rest. We =
also check
> > whether or not map->phys_map[min + i] is NULL since the max_apic_id is =
set to the
> > max apic id, some phys_map maybe NULL when apic id is sparse, especiall=
y kvm
> > unconditionally set max_apic_id to 255 to reserve enough space for any =
xAPIC ID.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Liran Alon <liran.alon@oracle.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Cc: Liran Alon <liran.alon@oracle.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> > v1 -> v2:
> >  * add min > map->max_apic_id check
> >  * change min to u32
> >  * add min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))
> >
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > @@ -548,7 +548,7 @@ int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct =
kvm_lapic_irq *irq,
> >  }
> >
> >  int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> > -                 unsigned long ipi_bitmap_high, int min,
> > +                 unsigned long ipi_bitmap_high, u32 min,
> >                   unsigned long icr, int op_64_bit)
> >  {
> >       int i;
> > @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned lon=
g ipi_bitmap_low,
> >       rcu_read_lock();
> >       map =3D rcu_dereference(kvm->arch.apic_map);
> >
> > +     if (min > map->max_apic_id)
> > +             goto out;
> >       /* Bits above cluster_size are masked in the caller.  */
> > -     for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> > -             vcpu =3D map->phys_map[min + i]->vcpu;
> > -             count +=3D kvm_apic_set_irq(vcpu, &irq, NULL);
> > +     for_each_set_bit(i, &ipi_bitmap_low,
> > +             min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
> > +             if (map->phys_map[min + i]) {
> > +                     vcpu =3D map->phys_map[min + i]->vcpu;
> > +                     count +=3D kvm_apic_set_irq(vcpu, &irq, NULL);
> > +             }
> >       }
> >
> >       min +=3D cluster_size;
>
> We need a second
>
>   if (min > map->max_apic_id)
>         goto out;
>
> here.  I will add it while applying if there are no other change
> requests.

Thanks Radim. :)

Regards,
Wanpeng Li
