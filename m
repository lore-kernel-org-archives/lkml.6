Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD554ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0EA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QocN/lVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0EA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbeGRDgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:36:21 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36141 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbeGRDgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:36:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so6008572oie.3;
        Tue, 17 Jul 2018 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cnefx7irmJ3TS12NaPO0aEpVKLaNVbb1qmdRU1dTkIU=;
        b=QocN/lVF7mBUiNgfjIdDgxwzCG/m5TajItpw1LNy/l3V3zUMiP6EtrM8NwHU9R/0bV
         dhOAeiedna96ii6yrhrikWSUyGu7VYpc83EaaoWh5/HZ99b4pqt9CHpJIXgu35BlTWE5
         11k8eoGNiIjTuHOiHVkk97xpxHu37+MX3xifIAZoC+GicHUQemxv63nil325n2sd0SiI
         fK8KBJmfLr1pHQXR4In2THCxfvKk0qDXy6oBasNIp5YwAhumqFSoy9OqFospUWzZcxqI
         TKMkKwHkJQlF/JaEn14Jv4tW3DpaGwamE/GDWF3h5qDCKT8OwpMC0hwI/AhgjlTBoEdd
         YLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cnefx7irmJ3TS12NaPO0aEpVKLaNVbb1qmdRU1dTkIU=;
        b=VZVcLyQ7nBj8OM+SdkhpZ/CvyBZnWW1OpeR6lIMiaqn8/6cFn80RJgVI13PYesV8te
         ZmT6rqZPNVDRHd3O4S/JUHzgUS9KUh+U89J/zUKOdRHQZYwkERfGon388PP42+9rtMPZ
         +CR6ojxL3QvJPMsXu7a/UJTJj9eRX12AfWnspbU6Yq2EwtZ2gA3lflHP7PxbuatUdQOa
         YNskUBoLvcRpMVY3CKLjPmFHntXrbu6bUIeecrK8PqCIh5rv5uPoyzApZMQx1GZqBaZ6
         Jj54ge8vTVrfyupo8iEKyGOQAH1Daow6e8jE99ozximEMI8L0DYev5J6FBy5+K+7wtOo
         xSsA==
X-Gm-Message-State: AOUpUlET2WWuZ50grRRfWQxYOGXsaFGggrPyTwnwvNSV7TI3xm7n64su
        diIuK36tfxg9QbV/a21FxPWFVGLUr4qZrjYpoHA=
X-Google-Smtp-Source: AAOMgpfYHWwVCgw7AkUSgtprEzXyHCfNhF/YmeJP6NY6oTptMdnzMHvjS2yyGEI83ed4vctH4DXOUmkKxV+nopO1k3M=
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr4775127oih.58.1531882842837;
 Tue, 17 Jul 2018 20:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 18 Jul 2018 11:00:39 +0800
Message-ID: <CANRm+CxQAsKaGQwfvS6P9f7U1PwTrBF2UJom4Wnqj0nybMAzZw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] KVM: X86: Implement PV IPIs support
To:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping, hope this series can catch up with the next merge window. :)
On Tue, 3 Jul 2018 at 14:21, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> Using hypercall to send IPIs by one vmexit instead of one by one for
> xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluster
> mode. Intel guest can enter x2apic cluster mode when interrupt remmaping
> is enabled in qemu, however, latest AMD EPYC still just supports xapic
> mode which can get great improvement by PV IPIs. This patchset supports
> PV IPIs for maximal 128 vCPUs VM, it is big enough for cloud environment
> currently, supporting more vCPUs needs to introduce more complex logic,
> in the future this might be extended if needed.
>
> Hardware: Xeon Skylake 2.5GHz, 2 sockets, 40 cores, 80 threads, the VM
> is 80 vCPUs, IPI microbenchmark(https://lkml.org/lkml/2017/12/19/141):
>
> x2apic cluster mode, vanilla
>
>  Dry-run:                         0,            2392199 ns
>  Self-IPI:                  6907514,           15027589 ns
>  Normal IPI:              223910476,          251301666 ns
>  Broadcast IPI:                   0,         9282161150 ns
>  Broadcast lock:                  0,         8812934104 ns
>
> x2apic cluster mode, pv-ipi
>
>  Dry-run:                         0,            2449341 ns
>  Self-IPI:                  6720360,           15028732 ns
>  Normal IPI:              228643307,          255708477 ns
>  Broadcast IPI:                   0,         7572293590 ns  =3D> 22% perf=
ormance boost
>  Broadcast lock:                  0,         8316124651 ns
>
> x2apic physical mode, vanilla
>
>  Dry-run:                         0,            3135933 ns
>  Self-IPI:                  8572670,           17901757 ns
>  Normal IPI:              226444334,          255421709 ns
>  Broadcast IPI:                   0,        19845070887 ns
>  Broadcast lock:                  0,        19827383656 ns
>
> x2apic physical mode, pv-ipi
>
>  Dry-run:                         0,            2446381 ns
>  Self-IPI:                  6788217,           15021056 ns
>  Normal IPI:              219454441,          249583458 ns
>  Broadcast IPI:                   0,         7806540019 ns  =3D> 154% per=
formance boost
>  Broadcast lock:                  0,         9143618799 ns
>
> v2 -> v3:
>  * rename ipi_mask_done to irq_restore_exit, __send_ipi_mask return int
>    instead of bool
>  * fix build errors reported by 0day
>  * split patches, nothing change
>
> v1 -> v2:
>  * sparse apic id > 128, or any other errors, fallback to original apic h=
ooks
>  * have two bitmask arguments so that one hypercall handles 128 vCPUs
>  * fix KVM_FEATURE_PV_SEND_IPI doc
>  * document hypercall
>  * fix NMI selftest fails
>  * fix build errors reported by 0day
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Wanpeng Li (6):
>   KVM: X86: Add kvm hypervisor init time platform setup callback
>   KVM: X86: Implement PV IPIs in linux guest
>   KVM: X86: Fallback to original apic hooks when bad happens
>   KVM: X86: Implement PV IPIs send hypercall
>   KVM: X86: Add NMI support to PV IPIs
>   KVM: X86: Expose PV_SEND_IPI CPUID feature bit to guest
>
>  Documentation/virtual/kvm/cpuid.txt      |   4 ++
>  Documentation/virtual/kvm/hypercalls.txt |   6 ++
>  arch/x86/include/uapi/asm/kvm_para.h     |   1 +
>  arch/x86/kernel/kvm.c                    | 101 +++++++++++++++++++++++++=
++++++
>  arch/x86/kvm/cpuid.c                     |   3 +-
>  arch/x86/kvm/x86.c                       |  42 +++++++++++++
>  include/uapi/linux/kvm_para.h            |   1 +
>  7 files changed, 157 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>
