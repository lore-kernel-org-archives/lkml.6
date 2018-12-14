Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDF42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdB1k+SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDF42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeLNHYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:24:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39185 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:24:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so4515414otl.6;
        Thu, 13 Dec 2018 23:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1IjR+hljDHa0CWj5h3p77xH8cWm9v6joLzico1hRFmM=;
        b=EdB1k+SGm+tarv9YCo3kEyY175rXtCnpSamLxcFTu8BClMEpOD9saXsAUHxHrDHvQe
         s0I44pxEsBTnlYvHuaEp0H8sqmqNc9mWCklxf9Xr3q8Y/IiRxXnxs+6oQ8w/YZh4q5vK
         GX4FRzekitR42iV6Z4kZ7LppXmo+ytwygCJDVX3NkZjcTeUyb+C+UFLTwUFlJHu5l0rU
         P3jIxiJW+aoIM59rpRZX2PKmr3Z6nr7/hHZPqQGN77mQoa3AJHzC8LUtaW2Ne5cvpqqZ
         6iyXNUmvQWCVDMc1KDy5ag8aWJhkEaQGp0xB/joJejtGG1PpvfmKnK/XqakI+rprVbwb
         IdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1IjR+hljDHa0CWj5h3p77xH8cWm9v6joLzico1hRFmM=;
        b=gmyMewmCpnCzSH9Mosfpge0PXn3N6rNxfo+xxRI3vIapgHzau65XOTQPrEDRk5SiCS
         ciQnZBudQXOIF6lz2GTRxXBscq9vIDlJ4f7G3BpYt3YIlwOQXuQw8MB+s6GkEIKoN5+c
         rfYxiX2uQZ2i8Dld6zq9xwG9aS64YjrHXX5xmyJJ3SGuxOCYrLrol/Np8ek195J6t4W2
         m8gUD9xzR4I/zjkt3oykiUMI/pcIElNsA5kbxZQdtrQJ9cLvC0vc8X+mMcKOOMHJkLoK
         XZT7AKbTqWrZz17oiaVrA0X1XRjQzURrei4JMJo4S9ld0qhVDFtg5QvqGJu2VksZA9I9
         Au9Q==
X-Gm-Message-State: AA+aEWbHD4N0m2s9HARiJeuj5nIWreawuz+mORvwW8ENYQlO5aS7g/wA
        BBFbkGwlPa8N3RMVNmlWOZhQTGBOIrRC8d+5xRmviA==
X-Google-Smtp-Source: AFSGD/Vm5HXVYJT+Gei58uaSVw4u856gcJt1T+RPOcXFR6ib9fn9m6Vnc2BaaaYuF45UF6wTkgyArq/+Wk7qS/KWbvU=
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr1253168otk.209.1544772241288;
 Thu, 13 Dec 2018 23:24:01 -0800 (PST)
MIME-Version: 1.0
References: <1544083089-13000-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1544083089-13000-1-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 14 Dec 2018 15:24:01 +0800
Message-ID: <CANRm+CxRDyQvnGSGWubbYymjvwiU5DjRwhUHsCsWdWPfY7nDnw@mail.gmail.com>
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

ping,
On Thu, 6 Dec 2018 at 15:58, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Last year guys from huawei reported that the call of memory_global_dirty_=
log_start/stop()
> takes 13s for 4T memory and cause guest freeze too long which increases t=
he unacceptable
> migration downtime. [1] [2]
>
> Guangrong pointed out:
>
> | collapsible_sptes zaps 4k mappings to make memory-read happy, it is not
> | required by the semanteme of KVM_SET_USER_MEMORY_REGION and it is not
> | urgent for vCPU's running, it could be done in a separate thread and us=
e
> | lock-break technology.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05249.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg449994.html
>
> Several TB memory guest is common now after NVDIMM is deployed in cloud e=
nvironment.
> This patch utilizes worker thread to zap collapsible sptes in order to la=
zy collapse
> small sptes into large sptes during roll-back after live migration fails.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/mmu.c              | 37 ++++++++++++++++++++++++++++++++---=
--
>  arch/x86/kvm/x86.c              |  4 ++++
>  3 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index fbda5a9..dde32f9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -892,6 +892,8 @@ struct kvm_arch {
>         u64 master_cycle_now;
>         struct delayed_work kvmclock_update_work;
>         struct delayed_work kvmclock_sync_work;
> +       struct delayed_work kvm_mmu_zap_collapsible_sptes_work;
> +       bool zap_in_progress;
>
>         struct kvm_xen_hvm_config xen_hvm_config;
>
> @@ -1247,6 +1249,7 @@ void kvm_mmu_zap_all(struct kvm *kvm);
>  void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots =
*slots);
>  unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
>  void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned int kvm_nr_mmu_p=
ages);
> +void zap_collapsible_sptes_fn(struct work_struct *work);
>
>  int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned lon=
g cr3);
>  bool pdptrs_changed(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 7c03c0f..fe87dd3 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -5679,14 +5679,41 @@ static bool kvm_mmu_zap_collapsible_spte(struct k=
vm *kvm,
>         return need_tlb_flush;
>  }
>
> +void zap_collapsible_sptes_fn(struct work_struct *work)
> +{
> +       struct kvm_memory_slot *memslot;
> +       struct kvm_memslots *slots;
> +       struct delayed_work *dwork =3D to_delayed_work(work);
> +       struct kvm_arch *ka =3D container_of(dwork, struct kvm_arch,
> +                                          kvm_mmu_zap_collapsible_sptes_=
work);
> +       struct kvm *kvm =3D container_of(ka, struct kvm, arch);
> +       int i;
> +
> +       mutex_lock(&kvm->slots_lock);
> +       for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +               spin_lock(&kvm->mmu_lock);
> +               slots =3D __kvm_memslots(kvm, i);
> +               kvm_for_each_memslot(memslot, slots) {
> +                       slot_handle_leaf(kvm, (struct kvm_memory_slot *)m=
emslot,
> +                               kvm_mmu_zap_collapsible_spte, true);
> +                       if (need_resched() || spin_needbreak(&kvm->mmu_lo=
ck))
> +                               cond_resched_lock(&kvm->mmu_lock);
> +               }
> +               spin_unlock(&kvm->mmu_lock);
> +       }
> +       kvm->arch.zap_in_progress =3D false;
> +       mutex_unlock(&kvm->slots_lock);
> +}
> +
> +#define KVM_MMU_ZAP_DELAYED (60 * HZ)
>  void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
>                                    const struct kvm_memory_slot *memslot)
>  {
> -       /* FIXME: const-ify all uses of struct kvm_memory_slot.  */
> -       spin_lock(&kvm->mmu_lock);
> -       slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
> -                        kvm_mmu_zap_collapsible_spte, true);
> -       spin_unlock(&kvm->mmu_lock);
> +       if (!kvm->arch.zap_in_progress) {
> +               kvm->arch.zap_in_progress =3D true;
> +               schedule_delayed_work(&kvm->arch.kvm_mmu_zap_collapsible_=
sptes_work,
> +                       KVM_MMU_ZAP_DELAYED);
> +       }
>  }
>
>  void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d029377..c2af289 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9019,6 +9019,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
>
>         INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_updat=
e_fn);
>         INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn=
);
> +       INIT_DELAYED_WORK(&kvm->arch.kvm_mmu_zap_collapsible_sptes_work,
> +                       zap_collapsible_sptes_fn);
> +       kvm->arch.zap_in_progress =3D false;
>
>         kvm_hv_init_vm(kvm);
>         kvm_page_track_init(kvm);
> @@ -9064,6 +9067,7 @@ void kvm_arch_sync_events(struct kvm *kvm)
>  {
>         cancel_delayed_work_sync(&kvm->arch.kvmclock_sync_work);
>         cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
> +       cancel_delayed_work_sync(&kvm->arch.kvm_mmu_zap_collapsible_sptes=
_work);
>         kvm_free_pit(kvm);
>  }
>
> --
> 2.7.4
>
