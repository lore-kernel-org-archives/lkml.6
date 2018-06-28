Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8419DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31651274C6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxEaNkWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31651274C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966373AbeF1OF2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:05:28 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45479 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeF1OFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:05:25 -0400
Received: by mail-ot0-f193.google.com with SMTP id k3-v6so6241979otl.12;
        Thu, 28 Jun 2018 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mGSyksSryvxihQ24cqtvNQH/E3ButK5y/CI9sq7uiIQ=;
        b=WxEaNkWtPfNBXqiJ2VTkni9fJQXSPqCiVaXK+vmJhfRRsvesVltUXloHeidWD/mLwy
         MmZSCihTbNZOEsojwJL2CYtqqX3S9IyJr0fIiTVmJyibgTtSbeHNWSmnqRAgR2cZwg6w
         MB2dFWYZYlTQgDo0Ahly3ljY4FVVe5tSl18c6YEUpfU+TuXy66neQhZvBRC9oF1wpF3n
         bfOlE3rxYLjrFuRwTmzKYcMf2g5Lqe8Dzu2z/BuCXcUMNRNKJeqLWqYqQiQRNDRPC8/V
         fYI+kE8KTVQiJiOFIoFK3HDlrnKx7YJ9webIrbRhG4oFCL92D1iZf+ISjrRzcRzh+Fdx
         xkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mGSyksSryvxihQ24cqtvNQH/E3ButK5y/CI9sq7uiIQ=;
        b=Y5tPp+DIoMfuAL/Q5Kpri4VHXIpZx2pH3k8SqJj6M3h1Glrn7jAhN9BcPNqFh/tMD7
         Vv2fWZuZ8FBZ5EY1gaISfSL6MgDZA5aLMh6ETAjfgFJvTTXha8wDnXFGqVnCNs3hSJu5
         r+xgxRh4PsBTW7R9FFwnAelN4pxJRA4JgLppexj8/bIZiFw+VWpIFOxslcelxY3Ln7Zv
         PF1gnmk/VwwINVFy01tRZ8gfMvDTrs6yNgTFumRufXIdCZqGgFl5mlUch/5BVlFy4eSG
         oJnxIMFW6/ToOMsuBDepZnQb4AtT4j2LuV81gf9QJk0kT1Rcs3VUHOKZWuJR3rAfU2Zk
         mLiQ==
X-Gm-Message-State: APt69E1CZydWs+ohekx/ZdtEiGZzIDw5UIyZYxwYUsubQalX7f18Z/Q6
        t2EewjEwrUqT+kIWQeazNDf33GZUTRZ1ic7dJrk=
X-Google-Smtp-Source: AAOMgpeIZVfdRXuO4iYeExx4pTC4h47y46KUUBtRlg8GlDO+eGCGp4VeWEE9SDcrbZQ1/Zek4kRUiEShkDzlZsS1p+c=
X-Received: by 2002:a9d:419c:: with SMTP id p28-v6mr6558939ote.2.1530194724162;
 Thu, 28 Jun 2018 07:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180622145616.5851-1-vkuznets@redhat.com> <20180622145616.5851-4-vkuznets@redhat.com>
 <20180622191333.GC2377@flask>
In-Reply-To: <20180622191333.GC2377@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 28 Jun 2018 22:05:13 +0800
Message-ID: <CANRm+Cyj_Bw1nx=K9KDv7MDDdB--DxNAyRwFwCff_twXk1tPPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send hypercalls
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 at 03:14, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.c=
om> wrote:
>
> 2018-06-22 16:56+0200, Vitaly Kuznetsov:
> > Using hypercall for sending IPIs is faster because this allows to speci=
fy
> > any number of vCPUs (even > 64 with sparse CPU set), the whole procedur=
e
> > will take only one VMEXIT.
> >
> > Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
> > hypercall can't be 'fast' (passing parameters through registers) but
> > apparently this is not true, Windows always uses it as 'fast' so we nee=
d
> > to support that.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > @@ -1357,6 +1357,108 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *cu=
rrent_vcpu, u64 ingpa,
> >               ((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
> >  }
> >
> > +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u=
64 outgpa,
> > +                        bool ex, bool fast)
> > +{
> > +     struct kvm *kvm =3D current_vcpu->kvm;
> > +     struct hv_send_ipi_ex send_ipi_ex;
> > +     struct hv_send_ipi send_ipi;
> > +     struct kvm_vcpu *vcpu;
> > +     unsigned long valid_bank_mask =3D 0;
> > +     u64 sparse_banks[64];
> > +     int sparse_banks_len, i;
> > +     struct kvm_lapic_irq irq =3D {0};
> > +     bool all_cpus;
> > +
> > +     if (!ex) {
> > +             if (!fast) {
> > +                     if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi=
,
> > +                                                 sizeof(send_ipi))))
> > +                             return HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +                     sparse_banks[0] =3D send_ipi.cpu_mask;
> > +                     irq.vector =3D send_ipi.vector;
> > +             } else {
> > +                     /* 'reserved' part of hv_send_ipi should be 0 */
> > +                     if (unlikely(ingpa >> 32 !=3D 0))
> > +                             return HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +                     sparse_banks[0] =3D outgpa;
> > +                     irq.vector =3D (u32)ingpa;
> > +             }
> > +             all_cpus =3D false;
> > +
> > +             trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
> > +     } else {
> > +             if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
> > +                                         sizeof(send_ipi_ex))))
> > +                     return HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +
> > +             trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
> > +                                      send_ipi_ex.vp_set.format,
> > +                                      send_ipi_ex.vp_set.valid_bank_ma=
sk);
> > +
> > +             irq.vector =3D send_ipi_ex.vector;
> > +             valid_bank_mask =3D send_ipi_ex.vp_set.valid_bank_mask;
> > +             sparse_banks_len =3D bitmap_weight(&valid_bank_mask, 64) =
*
> > +                     sizeof(sparse_banks[0]);
> > +             all_cpus =3D send_ipi_ex.vp_set.format !=3D
> > +                     HV_GENERIC_SET_SPARSE_4K;
>
> This would be much better readable as
>
>   send_ipi_ex.vp_set.format =3D=3D HV_GENERIC_SET_ALL
>
> And if Microsoft ever adds more formats, they won't be all VCPUs, so
> we're future-proofing as well.
>
> > +
> > +             if (!sparse_banks_len)
> > +                     goto ret_success;
> > +
> > +             if (!all_cpus &&
> > +                 kvm_read_guest(kvm,
> > +                                ingpa + offsetof(struct hv_send_ipi_ex=
,
> > +                                                 vp_set.bank_contents)=
,
> > +                                sparse_banks,
> > +                                sparse_banks_len))
> > +                     return HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +     }
> > +
> > +     if ((irq.vector < HV_IPI_LOW_VECTOR) ||
> > +         (irq.vector > HV_IPI_HIGH_VECTOR))
> > +             return HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +
> > +     irq.delivery_mode =3D APIC_DM_FIXED;
>
> I'd set this during variable definition.
>
> APIC_DM_FIXED is 0 anyway and the compiler probably won't optimize it
> here due to function with side effects since definition.
>
> > +
> > +     kvm_for_each_vcpu(i, vcpu, kvm) {
> > +             struct kvm_vcpu_hv *hv =3D &vcpu->arch.hyperv;
> > +             int bank =3D hv->vp_index / 64, sbank =3D 0;
> > +
> > +             if (!all_cpus) {
> > +                     /* Banks >64 can't be represented */
> > +                     if (bank >=3D 64)
> > +                             continue;
> > +
> > +                     /* Non-ex hypercalls can only address first 64 vC=
PUs */
> > +                     if (!ex && bank)
> > +                             continue;
> > +
> > +                     if (ex) {
> > +                             /*
> > +                              * Check is the bank of this vCPU is in s=
parse
> > +                              * set and get the sparse bank number.
> > +                              */
> > +                             sbank =3D get_sparse_bank_no(valid_bank_m=
ask,
> > +                                                        bank);
> > +
> > +                             if (sbank < 0)
> > +                                     continue;
> > +                     }
> > +
> > +                     if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index =
% 64)))
> > +                             continue;
> > +             }
> > +
> > +             /* We fail only when APIC is disabled */
> > +             if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> > +                     return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
> Does Windows use this even for 1 VCPU IPI?
>
> I'm thinking we could apply the same optimization we do for LAPIC -- RCU
> protected array that maps vp_index to vcpu.
>
> Thanks.
>
> > +     }
> > +
> > +ret_success:
> > +     return HV_STATUS_SUCCESS;
> > +}
> > +
> >  bool kvm_hv_hypercall_enabled(struct kvm *kvm)
> >  {
> >       return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPE=
RCALL_ENABLE;
> > @@ -1526,6 +1628,20 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >               }
> >               ret =3D kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, true);
> >               break;
> > +     case HVCALL_SEND_IPI:
> > +             if (unlikely(rep)) {
> > +                     ret =3D HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +                     break;
> > +             }
> > +             ret =3D kvm_hv_send_ipi(vcpu, ingpa, outgpa, false, fast)=
;
> > +             break;
> > +     case HVCALL_SEND_IPI_EX:

Hi Paolo and Radim,

I have already completed the patches for linux guest/kvm/qemu w/ vCPUs
<=3D 64, however, extra complication as the ex in hyperv should be
introduced for vCPUs > 64, so do you think vCPU <=3D64 is enough for
linux guest or should me introduce two hypercall as what hyperv does
w/ ex logic?

Regards,
Wanpeng Li
