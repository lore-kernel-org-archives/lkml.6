Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E95C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E3124400
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmdJbKxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E3124400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030282AbeF3KE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:04:28 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40295 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934077AbeF3KEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:04:24 -0400
Received: by mail-ot0-f195.google.com with SMTP id f17-v6so12520856otl.7;
        Sat, 30 Jun 2018 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uixBXpDrTavno4xCA72W1tyqkgX52QZV5ghh4IqiwL0=;
        b=pmdJbKxJqMcJklHctVmoQ6NJCUGz/RBUh9kFzkwl3ezVKQryChF2zTXI2pZdqvCvER
         5omLZsqutgwgzZCz3twFkOOAMClNDD6JPADYY50dDVqTxWC6IjrnUbM9pDhsShR3ubOP
         z0LIX/f56fqr+QL2MScQ80TbrEtKF7KI/5lcQ9092KZUO9dIss2lYQFnmuod7B2LLGB5
         rR80pbaARIx3HX7CR/TSgPl0mAdMuwvzDQTYFbByrtEjiFGk9cyh1j8UZ/MXYsE/IW58
         f38mNLQkJ0phW+F/0GNJrAOgw8gGt/uelK4l62lb0eawiz9eyMLLSA2GE2BYUoJbyKbx
         8/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uixBXpDrTavno4xCA72W1tyqkgX52QZV5ghh4IqiwL0=;
        b=QkyZp022Igf0MOfh4rRroAazyycW1wxJiNxoR40sPNLdT8JOckfit+WfrJLnLU5ziL
         Duw75DH4t8F2Bsz6feKcxUIbDHp1mL+bL6HbiAx4RPKBl0d9cZOghEhgIPDOEa8B3GU0
         ora5eMaGEjsvW1UKP9IdkLyD7jPek1pfbWuoey+TAsLey3huXqWmAitSSZKwG+JAHB3b
         3zr2itm7NiHsCw4J/CXblo4RyXaML/Gg5gmeFh9Ku/IHHUjgGOzKZQmDDYEzGBHFP0KB
         QB7IulWnDywH+8W3UjmJX1eaiLVcXkyrW0TR1MudfXUKcccwHsDjNuTOdLvdTTCnk9gG
         NE7g==
X-Gm-Message-State: APt69E2Coo9AD1DH2BYkALV5biBm9/vccPSs8di5J05RagKB/WWLukhp
        HbC0hb0ZaHG02EkdurFDW57WPvjw7tX1ga+C8WM=
X-Google-Smtp-Source: AAOMgpdAQ3MhhPeYa9+yIMCAhqxFJZRnasSQAGqp8pdcULAE8ND8I8cDb8DWb0dpCKnzxLNRgKWcxV/zPXPt217bcHY=
X-Received: by 2002:a9d:5223:: with SMTP id e35-v6mr11470658oth.250.1530353064119;
 Sat, 30 Jun 2018 03:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
 <1530265876-18136-2-git-send-email-wanpengli@tencent.com> <877emhewdx.fsf@vitty.brq.redhat.com>
In-Reply-To: <877emhewdx.fsf@vitty.brq.redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Sat, 30 Jun 2018 18:04:12 +0800
Message-ID: <CANRm+CwhWegEmDzkYJ3kNo2P5ybDAGdH-sS2b3fDsbJO+PyEKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Implement PV IPI in linux guest
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 at 18:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Wanpeng Li <kernellwp@gmail.com> writes:
>
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Implement PV IPIs in guest kernel.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  arch/x86/include/uapi/asm/kvm_para.h |  1 +
> >  arch/x86/kernel/kvm.c                | 63 ++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/ua=
pi/asm/kvm_para.h
> > index 0ede697..19980ec 100644
> > --- a/arch/x86/include/uapi/asm/kvm_para.h
> > +++ b/arch/x86/include/uapi/asm/kvm_para.h
> > @@ -28,6 +28,7 @@
> >  #define KVM_FEATURE_PV_UNHALT                7
> >  #define KVM_FEATURE_PV_TLB_FLUSH     9
> >  #define KVM_FEATURE_ASYNC_PF_VMEXIT  10
> > +#define KVM_FEATURE_PV_SEND_IPI      11
> >
> >  #define KVM_HINTS_REALTIME      0
> >
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 5b2300b..b4f8dc3 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -454,6 +454,57 @@ static void __init sev_map_percpu_data(void)
> >  }
> >
> >  #ifdef CONFIG_SMP
> > +
> > +static void __send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +     unsigned long flags, ipi_bitmap =3D 0;
> > +     int cpu;
> > +
> > +     local_irq_save(flags);
> > +
> > +     for_each_cpu(cpu, mask)
> > +             __set_bit(per_cpu(x86_cpu_to_apicid, cpu), &ipi_bitmap);
>
> We need a protection against per_cpu(x86_cpu_to_apicid, cpu) > here.

Will do in v2.

Regards,
Wanpeng Li
