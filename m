Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19772C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2A218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ7q3f8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbeLUAqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:46:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33207 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbeLUAqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:46:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so3703355otl.0;
        Thu, 20 Dec 2018 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3jpjGwfi+rSF7Gc7fLV7zYp5ruLZVpA2cEJfcBl2cII=;
        b=QQ7q3f8b06inK2seFbjLnx/9mSOpFt3QYEpM2RWt4OkasvWFplrqwrVW8DeLyCyqOz
         mZ/VNmcBRgc/VVh3exL3cyecDvGmmwmmFpeBbAM3fcFIGZJ07Cv49LjR1ROiAHIaQRtq
         JSEgpO+k8jTh7y9IHHvvRoQwfRmfy+w0Z+kFNuTTfxR+3mi2dUSlC45hlft27pzE4Dw4
         Z2UzQN28jKZGbvuf/GFaBBtoqcMLI+50KVv3fOddvyd29+3K9MsYjAdDUHmWOkEcy/Al
         HgNUMPIvPDNS3F4UNd2pAlpGOs/cDvwK6GwVbOLcoaczv2NVT9KTh62939M+nIpCg81/
         eWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jpjGwfi+rSF7Gc7fLV7zYp5ruLZVpA2cEJfcBl2cII=;
        b=dbbicUtjy7/QiY4PwLeDK19uPDNSb8BwzGRLFiVVl+DeKnID+MdfxbpO4nas2GoUMD
         I+CrbU9MQhgFKrjnDO6/SEuimUGUQGz2mXcmY22MAJU2qLudNVn07Dzt2YnexPueY9er
         pMNU+vAMPbxRChpykTdy+HU9Gtp0V/fJ4O0mxN6ith1kvLIjol4xW461OiO2q3Hz3DLl
         CmHR/bQwf8uVHhzmEl3jYlfLqcm2azrEYHSGtyKXTgGVl9k8csFEpXn4WLzA1O1Qa/SK
         kZe/h8LJSY2obWpVleFVfAbIJ0aCv477AwOu/nWbx9JASdnrc1OPokXbe8pPYdk7nMVi
         dU7g==
X-Gm-Message-State: AJcUukeaNDlr7ahUk+pJeiEglAWKm4pREiobmJSqfVS1/T3FmOeutjMy
        gQBVhJMjwhJ0v/+++nTfuVGwkBCqvrsuEUriHbDSgAY2
X-Google-Smtp-Source: ALg8bN79FcBNRPQ7gnuJzXlTTgZoB05F1brZirVbJ29wXzhHmLSRVqOF2vi+fFueZZG+Q915+HhkzNaS0f+ic6RzFeU=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr254898oti.258.1545353189048;
 Thu, 20 Dec 2018 16:46:29 -0800 (PST)
MIME-Version: 1.0
References: <1544083089-13000-1-git-send-email-wanpengli@tencent.com> <20181220144345.GB19579@flask>
In-Reply-To: <20181220144345.GB19579@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 21 Dec 2018 08:46:32 +0800
Message-ID: <CANRm+Cx4HKfXDpCUtkScjQ-wzCBCpx91twBodkqDRD7U1rZBHg@mail.gmail.com>
Subject: Re: [PATCH] KVM: MMU: Introduce single thread to zap collapsible sptes
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 at 22:43, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.c=
om> wrote:
>
> 2018-12-06 15:58+0800, Wanpeng Li:
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
> > @@ -5679,14 +5679,41 @@ static bool kvm_mmu_zap_collapsible_spte(struct=
 kvm *kvm,
> >       return need_tlb_flush;
> >  }
> >
> > +void zap_collapsible_sptes_fn(struct work_struct *work)
> > +{
> > +     struct kvm_memory_slot *memslot;
> > +     struct kvm_memslots *slots;
> > +     struct delayed_work *dwork =3D to_delayed_work(work);
> > +     struct kvm_arch *ka =3D container_of(dwork, struct kvm_arch,
> > +                                        kvm_mmu_zap_collapsible_sptes_=
work);
> > +     struct kvm *kvm =3D container_of(ka, struct kvm, arch);
> > +     int i;
> > +
> > +     mutex_lock(&kvm->slots_lock);
> > +     for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> > +             spin_lock(&kvm->mmu_lock);
> > +             slots =3D __kvm_memslots(kvm, i);
> > +             kvm_for_each_memslot(memslot, slots) {
> > +                     slot_handle_leaf(kvm, (struct kvm_memory_slot *)m=
emslot,
> > +                             kvm_mmu_zap_collapsible_spte, true);
> > +                     if (need_resched() || spin_needbreak(&kvm->mmu_lo=
ck))
> > +                             cond_resched_lock(&kvm->mmu_lock);
>
> I think we shouldn't zap all memslots when kvm_mmu_zap_collapsible_sptes
> only wanted to zap a specific one.
> Please add a list of memslots to be zapped; delete from the list here
> and add in kvm_mmu_zap_collapsible_sptes().

Yeah, that's my original plan, however, i observe a lot of races here,
the memslot can disappear/modify underneath before the worker thread
start to zap even if i introduce lock to protect the list. This patch
delays the worker thread by 60s(to assume memory_global_dirty_log_stop
can absolutely complete) to coalesce all the zap requirements after
live migration fails.

Regards,
Wanpeng Li

>
> > +             }
> > +             spin_unlock(&kvm->mmu_lock);
> > +     }
> > +     kvm->arch.zap_in_progress =3D false;
> > +     mutex_unlock(&kvm->slots_lock);
> > +}
> > +
> > +#define KVM_MMU_ZAP_DELAYED (60 * HZ)
> >  void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
> >                                  const struct kvm_memory_slot *memslot)
> >  {
> > -     /* FIXME: const-ify all uses of struct kvm_memory_slot.  */
> > -     spin_lock(&kvm->mmu_lock);
> > -     slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
> > -                      kvm_mmu_zap_collapsible_spte, true);
> > -     spin_unlock(&kvm->mmu_lock);
> > +     if (!kvm->arch.zap_in_progress) {
>
> The list can also serve in place of zap_in_progress -- if there were any
> elements in it, then there is no need to schedule the work again.
>
> Thanks.
