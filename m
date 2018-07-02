Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B6CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B474225CC2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgbddhDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B474225CC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeGBLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:32:40 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46146 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGBLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:32:35 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so15684084oie.13;
        Mon, 02 Jul 2018 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kTjXJNqwV0L6AVwZRH8K5/XvD+1aLLT1+rxicjytnlI=;
        b=EgbddhDRDC34AMmfs22YbRemxEfPjYQlOCmU5Rc1Mwf/+eeN2ohrVnf2ioD520BQBg
         SVXBQFjxazg514C0BAR5I6XysG28xfHCv1NM9SS/DKztnjopnBQYExh03jGUaRtbg3Wp
         x9rC7L17qkWXJzt49aTjeAF5Y3wEst4r9ceGF1YOdUITR2Zn3jkpSxSyYSCgnR7vO2t1
         zr9KdAwYCrRvv7UFmBC2niirw9e6F9LINRFCtKnEZ2QuB2bU28ftAUImRYZGdOcgLjZE
         77ZyK3OteAtEvGuWs0Sx86EMnQr+Sa2mExnAmdeGQfxA7TlnfwdHHu1e+D4lrx/TRG2t
         VwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kTjXJNqwV0L6AVwZRH8K5/XvD+1aLLT1+rxicjytnlI=;
        b=LwjcK8LR0U2+ZjWsaYvevhu3WVk8idtErYcB1/LdOZEcZRHJbmCIV2gdRc8wPwzFxG
         LRs44mfGkiirJJ1GZCOmEA2/+RFugPFv2rWwNJEEWHJC0SdOogjZv+6gm+eS8DxFvdCP
         uxVaeK6MUjGhe+GNiedPn+WTCRrYdzCgTSo0ktMYv1c41WQwqg0juGa1+j7Yo4JUCK1h
         hHGhhyBo81S2BWR2feYtgZ7MeVfVIcu6xiJz3/fMsLQvINZH2doZ1Agf7leIzY28PImE
         Y5PBcqJBNtis5nSuieQ532NJ1ipq3+Oy9WBYy14buTF5IKHv+t8KcgXqpTNZpZBlYWUU
         MpHw==
X-Gm-Message-State: APt69E1stOWMZxb9AdFGZ6aN5PmQS6IYMt51hKOwTxO6Ss7LyTQFsFDa
        tpHkoDWkG+6hM+3PNuYNwlYy1bsfE9WS8955Etg=
X-Google-Smtp-Source: AAOMgpevJn+kRuNONH55oSxGjSoRRUnug4WD0T7xJAHzpRvo/qDrkORR7+u7/+EB6EgID8/9baqoB4ds5wVp/4oNtcc=
X-Received: by 2002:aca:b782:: with SMTP id h124-v6mr16110671oif.7.1530531155293;
 Mon, 02 Jul 2018 04:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
 <1530526462-920-2-git-send-email-wanpengli@tencent.com> <87sh52aq7g.fsf@vitty.brq.redhat.com>
In-Reply-To: <87sh52aq7g.fsf@vitty.brq.redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 2 Jul 2018 19:32:25 +0800
Message-ID: <CANRm+CyNVatPLZm3i1_xumma5jMj-PSEbASZ6ovWfv2U0zspuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: X86: Implement PV IPI in linux guest
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

On Mon, 2 Jul 2018 at 18:26, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
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
> >  arch/x86/kernel/kvm.c         | 99 +++++++++++++++++++++++++++++++++++=
++++++++
> >  include/uapi/linux/kvm_para.h |  1 +
> >  2 files changed, 100 insertions(+)
> >
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 5b2300b..7e3ee25 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -47,6 +47,7 @@
> >  #include <asm/hypervisor.h>
> >  #include <asm/kvm_guest.h>
> >
> > +static struct apic orig_apic;
> >  static int kvmapf =3D 1;
> >
> >  static int __init parse_no_kvmapf(char *arg)
> > @@ -454,6 +455,89 @@ static void __init sev_map_percpu_data(void)
> >  }
> >
> >  #ifdef CONFIG_SMP
> > +
> > +#ifdef CONFIG_X86_64
> > +static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +     unsigned long flags, ipi_bitmap_low =3D 0, ipi_bitmap_high =3D 0,=
 icr =3D 0;
> > +     int cpu, apic_id, ret =3D 1;
> > +
> > +     if (cpumask_empty(mask))
> > +             return true;
> > +
> > +     local_irq_save(flags);
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             apic_id =3D per_cpu(x86_cpu_to_apicid, cpu);
> > +             if (apic_id < BITS_PER_LONG)
> > +                     __set_bit(apic_id, &ipi_bitmap_low);
> > +             else if (apic_id < 2 * BITS_PER_LONG)
> > +                     __set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_hi=
gh);
> > +             else
> > +                     goto ipi_mask_done;
>
> Nit:
>
> Both the fact that we don't set 'ret' here and the fact that the label
> is named 'ipi_mask_done' -- which sounds like 'all OK' at least to me --
> contribute to the feeling that we just skip sending IPIs in some cases.
>
> I would prefer to see something like
>
> else {
>    ret =3D -EFAULT;
>    goto irq_restore_exit;
> }
>
> > +     }
> > +
> > +     switch (vector) {
> > +     default:
> > +             icr =3D APIC_DM_FIXED | vector;
> > +             break;
> > +     case NMI_VECTOR:
> > +             icr =3D APIC_DM_NMI;
> > +             break;
> > +     }
> > +
> > +     ret =3D kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitma=
p_high, icr);
> > +
> > +ipi_mask_done:
> > +     local_irq_restore(flags);
> > +     return ((ret =3D=3D 0) ? true : false);
>
> ... and why in the first place do we need to make this function return
> 'bool' then? Let's just make it return 'int'.

Thanks for the comments, will do in v3. Btw, on my haswell desktop(i7
8 HT), there is a 2.5 times performance boot for the IPI
microbenchmark(https://lkml.org/lkml/2017/12/19/141). (8 vCPUs guest,
x2apic physical mode, I will retest on Skylake server w/ 64 vCPUs
x2apic cluster mode guest tomorrow):

Before:
 Dry-run:                         0,            1885493 ns
 Self-IPI:                  7071403,           14711151 ns
 Normal IPI:              204453899,          219896346 ns
 Broadcast IPI:                   0,         2213679722 ns
 Broadcast lock:                  0,         2241226307 ns

After:
 Dry-run:                         0,            1752903 ns
 Self-IPI:                  4944737,           10434149 ns
 Normal IPI:              202351280,          220807969 ns
 Broadcast IPI:                   0,          872991742 ns
=3D> 2.5 times boost
 Broadcast lock:                  0,          879995113 ns

Regards,
Wanpeng Li
