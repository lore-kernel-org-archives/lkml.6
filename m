Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78320833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB65w3QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B78320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeGTEjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:39:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38767 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeGTEjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:39:12 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so18946620oie.5;
        Thu, 19 Jul 2018 20:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iQJ2v1VcvfRskDsOmblVQ/8125dz0NV4YPdiNwUJl0g=;
        b=kB65w3QB+j1vIjCItCJ36YhLjE3U66bt5aj/nLzoDyJfx5sSEy2gAYvjOeov5zbeAJ
         Wp9PBqPnkD9aFQPafmrs9dlAiPRydrF60TBbJW962tY/sUSaZIfofLZsq5LQdxxAGSSc
         thWAktI6P8Z5JdSUpZ6XvVPe4THJ+/toIUzySHJRPqWp3SLAPlpzdBABrgdJhXK6b4X8
         whni825nQV5xbmfI6KslrZpvT5tFc936IF4Q6dAlfelmGAhSF88c4F2Yig7OadmrK4GZ
         h49EHeCdbU5bM0DUOTCFFNzPFVQfE1V7xYGsnsR+6m5do5G7u9mE9cnKEJr1gPG/30Cz
         6yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQJ2v1VcvfRskDsOmblVQ/8125dz0NV4YPdiNwUJl0g=;
        b=d28ypP8qsSFZIMnHkhhel+LJMVe5lw1DVsNWSjb1ytM6z2m4kTiRiJop6rBRMB/S2T
         KqVqBw4oJ16yS01q6BeJqff+W1ZyIegzooDq5oE9sr1RHeY8DQruHuK2Cva4UZaEO6r+
         FLKsXfwW9IVdoy9OICFe0sFUGeekV/PbAjyTGiUVuVk/HuqcpBdO0ydp/kcJ81kIwxlh
         yXNT/4ZlY1Rr8WkLWO4fOMUfBT8w+vHrXuPzin1I9wEWqr0qe3BJHtF1CzPP50JuRxYp
         24QijFZ39D6t01+vBUnU4/yYYc5DTjVe2MYPPJoPKw/BrYP/5Z5daNyMEE5FlX157T9w
         WWAg==
X-Gm-Message-State: AOUpUlEdmjk4eKxwsR/vsymbhb+phG9JuP7JgefVqEZ9ZpE5j2A6ILox
        dOJp9fZtjQEBFZnKrZaQqqZ8/N0ywiIKRmprBeQ=
X-Google-Smtp-Source: AAOMgpd5mBHKne2OFhmsNDt75ceLOZilKwrVHuFejcuJout4ccIrwqANkoEHeqPjrKlC46INL4EH/7ccQW1jTJpkkic=
X-Received: by 2002:aca:4ec6:: with SMTP id c189-v6mr432202oib.186.1532058780740;
 Thu, 19 Jul 2018 20:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-6-git-send-email-wanpengli@tencent.com> <20180719163138.GC11749@flask>
In-Reply-To: <20180719163138.GC11749@flask>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 11:53:05 +0800
Message-ID: <CANRm+CwzG8jcsVhhGa2w55KcCTpwm-yokFR2Oi6LYaoS0ameqQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] KVM: X86: Add NMI support to PV IPIs
To:     Radim Krcmar <rkrcmar@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 00:31, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.c=
om> wrote:
>
> 2018-07-03 14:21+0800, Wanpeng Li:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > The NMI delivery mode of ICR is used to deliver an NMI to the processor=
,
> > and the vector information is ignored.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > @@ -479,7 +479,16 @@ static int __send_ipi_mask(const struct cpumask *m=
ask, int vector)
> >               }
> >       }
> >
> > -     ret =3D kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitma=
p_high, vector);
> > +     switch (vector) {
> > +     default:
> > +             icr =3D APIC_DM_FIXED | vector;
> > +             break;
> > +     case NMI_VECTOR:
> > +             icr =3D APIC_DM_NMI;
>
> I think it would be better to say that KVM interprets NMI_VECTOR and
> sends the interrupt as APIC_DM_NMI.

Yeah, in addition, SDM 10.6.1 also mentioned that:
Delivery mode:
    100 (NMI) Delivers an NMI interrupt to the target processor or
processors. The vector information is ignored.

Regards,
Wanpeng Li
