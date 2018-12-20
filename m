Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2776CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D453720869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHqIg6Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbeLTGQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:16:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42822 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLTGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:16:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so528931otk.9;
        Wed, 19 Dec 2018 22:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DX9TonpDXOTAw99zf1iXPkf/nxAZGH5dpGvLKmPc3wM=;
        b=MHqIg6IyTEnxExu70r6JmOd6ECtmJyvXjYCZOZvRCLzvlC3EJO9sbXZwe9VeOF760Z
         xneC0RFFVbm3m0Ycm/vIX4pabNBb9bhURovdkgI4o+zkvbNy1Fbg0fPknnMqpNwZqU2A
         biAI8G8EJ9ZQWxAkl5Hn2F+YruD+8fAXgRi7d4f8kowvCfo8HbF5JuossLpBbEioNNpF
         P49TKkYoC04lK6wn/FnGWc/K9+3I42PZcJfjfKLbI0rH9d+suw9rbB8ZSWrb5hkBRqGS
         nHcicA2NzDDehR5DYqAWEKc3ydquiyarbbzdg38scNsQAwbhnK6JizpI26q+mMo5ts34
         OQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DX9TonpDXOTAw99zf1iXPkf/nxAZGH5dpGvLKmPc3wM=;
        b=jtNf2YdaQRgJX5hl0GVPHmzkVMXbi3b+T7/b5O3VHtl387E5Cu8G1EDyuDtU0PnmI+
         8hr3mCWt1dEi4fY8BaXzZhENDdO1PGgXhUAnlbYfoSgYT2rTBQ6LP1r2qq0pSF4HRQDc
         NtDyCYldzeebX4t6k+tx4Md1brk31o5DZ6DjqJe1iLus2w9fiFiHBjbTEhCiAG71hx+m
         8EU/LWdfnHi8ZsK3hQ8K36zuIUMoMOGlfe+7NIirG8t0Vlm6bugHYA9nxeisPijTAivM
         A6IleoCRThdmt7sLwCWIkYC4m6CbNgw9bBDPjRZdehQLlOa+/EpSvN+ZxkmsqlmhQEAJ
         sqNg==
X-Gm-Message-State: AA+aEWbmCDzv/ZRuvESixvDmDCXgHh8aYYppSmzJj0Dr9YHXVywa6aqP
        DDwwJbCsY3OhJhedY1WI6uRKIZ48so0S0c4yxHfZAg==
X-Google-Smtp-Source: AFSGD/W2TWid6OwR7bCAyD7GY1JfSgFl2rjY8vHa5eZRSlY8HHjn3HWr7lH9QeKc3VB0WJIbT2UYxkKvSu2mmXkXnoY=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr17730649oti.258.1545286569641;
 Wed, 19 Dec 2018 22:16:09 -0800 (PST)
MIME-Version: 1.0
References: <1544083089-13000-1-git-send-email-wanpengli@tencent.com> <CANRm+CxRDyQvnGSGWubbYymjvwiU5DjRwhUHsCsWdWPfY7nDnw@mail.gmail.com>
In-Reply-To: <CANRm+CxRDyQvnGSGWubbYymjvwiU5DjRwhUHsCsWdWPfY7nDnw@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 20 Dec 2018 14:16:14 +0800
Message-ID: <CANRm+Czpq2kzF-QH17bt9k=V7p9fFTe-Vr+ij37mewubvMm4GA@mail.gmail.com>
Subject: Re: [PATCH] KVM: MMU: Introduce single thread to zap collapsible sptes
To:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping,
On Fri, 14 Dec 2018 at 15:24, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> ping,
> On Thu, 6 Dec 2018 at 15:58, Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Last year guys from huawei reported that the call of memory_global_dirt=
y_log_start/stop()
> > takes 13s for 4T memory and cause guest freeze too long which increases=
 the unacceptable
> > migration downtime. [1] [2]
> >
> > Guangrong pointed out:
> >
> > | collapsible_sptes zaps 4k mappings to make memory-read happy, it is n=
ot
> > | required by the semanteme of KVM_SET_USER_MEMORY_REGION and it is not
> > | urgent for vCPU's running, it could be done in a separate thread and =
use
> > | lock-break technology.
> >
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05249.html
> > [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg449994.html
> >
> > Several TB memory guest is common now after NVDIMM is deployed in cloud=
 environment.
> > This patch utilizes worker thread to zap collapsible sptes in order to =
lazy collapse
> > small sptes into large sptes during roll-back after live migration fail=
s.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  3 +++
> >  arch/x86/kvm/mmu.c              | 37 ++++++++++++++++++++++++++++++++-=
----
> >  arch/x86/kvm/x86.c              |  4 ++++
> >  3 files changed, 39 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index fbda5a9..dde32f9 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -892,6 +892,8 @@ struct kvm_arch {
> >         u64 master_cycle_now;
> >         struct delayed_work kvmclock_update_work;
> >         struct delayed_work kvmclock_sync_work;
> > +       struct delayed_work kvm_mmu_zap_collapsible_sptes_work;
> > +       bool zap_in_progress;
> >
> >         struct kvm_xen_hvm_config xen_hvm_config;
> >
> > @@ -1247,6 +1249,7 @@ void kvm_mmu_zap_all(struct kvm *kvm);
> >  void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslot=
s *slots);
> >  unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
> >  void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned int kvm_nr_mmu=
_pages);
> > +void zap_collapsible_sptes_fn(struct work_struct *work);
> >
> >  int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned l=
ong cr3);
> >  bool pdptrs_changed(struct kvm_vcpu *vcpu);
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index 7c03c0f..fe87dd3 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -5679,14 +5679,41 @@ static bool kvm_mmu_zap_collapsible_spte(struct=
 kvm *kvm,
> >         return need_tlb_flush;
> >  }
> >
> > +void zap_collapsible_sptes_fn(struct work_struct *work)
> > +{
> > +       struct kvm_memory_slot *memslot;
> > +       struct kvm_memslots *slots;
> > +       struct delayed_work *dwork =3D to_delayed_work(work);
> > +       struct kvm_arch *ka =3D container_of(dwork, struct kvm_arch,
> > +                                          kvm_mmu_zap_collapsible_spte=
s_work);
> > +       struct kvm *kvm =3D container_of(ka, struct kvm, arch);
> > +       int i;
> > +
> > +       mutex_lock(&kvm->slots_lock);
> > +       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> > +               spin_lock(&kvm->mmu_lock);
> > +               slots =3D __kvm_memslots(kvm, i);
> > +               kvm_for_each_memslot(memslot, slots) {
> > +                       slot_handle_leaf(kvm, (struct kvm_memory_slot *=
)memslot,
> > +                               kvm_mmu_zap_collapsible_spte, true);
> > +                       if (need_resched() || spin_needbreak(&kvm->mmu_=
lock))
> > +                               cond_resched_lock(&kvm->mmu_lock);
> > +               }
> > +               spin_unlock(&kvm->mmu_lock);
> > +       }
> > +       kvm->arch.zap_in_progress =3D false;
> > +       mutex_unlock(&kvm->slots_lock);
> > +}
> > +
> > +#define KVM_MMU_ZAP_DELAYED (60 * HZ)
> >  void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
> >                                    const struct kvm_memory_slot *memslo=
t)
> >  {
> > -       /* FIXME: const-ify all uses of struct kvm_memory_slot.  */
> > -       spin_lock(&kvm->mmu_lock);
> > -       slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
> > -                        kvm_mmu_zap_collapsible_spte, true);
> > -       spin_unlock(&kvm->mmu_lock);
> > +       if (!kvm->arch.zap_in_progress) {
> > +               kvm->arch.zap_in_progress =3D true;
> > +               schedule_delayed_work(&kvm->arch.kvm_mmu_zap_collapsibl=
e_sptes_work,
> > +                       KVM_MMU_ZAP_DELAYED);
> > +       }
> >  }
> >
> >  void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index d029377..c2af289 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9019,6 +9019,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
> >
> >         INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_upd=
ate_fn);
> >         INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_=
fn);
> > +       INIT_DELAYED_WORK(&kvm->arch.kvm_mmu_zap_collapsible_sptes_work=
,
> > +                       zap_collapsible_sptes_fn);
> > +       kvm->arch.zap_in_progress =3D false;
> >
> >         kvm_hv_init_vm(kvm);
> >         kvm_page_track_init(kvm);
> > @@ -9064,6 +9067,7 @@ void kvm_arch_sync_events(struct kvm *kvm)
> >  {
> >         cancel_delayed_work_sync(&kvm->arch.kvmclock_sync_work);
> >         cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
> > +       cancel_delayed_work_sync(&kvm->arch.kvm_mmu_zap_collapsible_spt=
es_work);
> >         kvm_free_pit(kvm);
> >  }
> >
> > --
> > 2.7.4
> >
