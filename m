Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207BDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C253E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck4hro/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C253E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeGTGpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:45:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38153 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeGTGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:45:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so19337735oie.5;
        Thu, 19 Jul 2018 22:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RZYh1IIqxT2q5AqFPmdtcIfEMnYXoAxabC7YvLSzIso=;
        b=Ck4hro/N9mg0DhgvILV7SmujVCsKZybPKzEOB38fsHXlaOKhu31HYfxwnMQQinlV8B
         LPH9C3e0yYUSoxU5Z+58Am6ItdGWaYRB9MxrKTAwGpXBoP5reEztLxrLTSLKgbskpKCE
         epTrjouZDw3wr0YILqEPGKHEg8rbjHUU0p0N6aBLETSeDi3Mo7LFZyyi4gTW4N3ZZgH1
         SjfSjammwUAlG0A753GjdnbJInqIBoS5bjGVfKc8vpu+jpf7DFIAcQBjmhga8prvo6Rf
         w8BzTrqzs9br//5ogzb88qf6ooH9/SgH5nLmEdKOkws39uPZko5RkCPMWDE4T9xR+U8C
         RnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RZYh1IIqxT2q5AqFPmdtcIfEMnYXoAxabC7YvLSzIso=;
        b=osqsGZLTjUiv50qsYJwUsw7wh8Mgc3qMg3PtgiEjfj5LkMDTkTwbNebjrh5TVAl6uH
         VF6MVEqCDcos4CWAlHbmakISgGL0CD8zX0GWT+Zv75wd6PtsOGm8iLln8suBJKfB6d5S
         /VB2LB9f0LKFZa3vE52bkNbjgtqltSjU+ef3cKIueLglhcZLr8fe7mUHsWxsIgVo4Adi
         Yw4HjcHq9fCDmzS/eQCzxRXqkKghttR9EDUD7rjzqkVicDNYWDKpANnpmhKNngUlM7hF
         QhmA8M8RMEH63t25V0vAn7jtTGKm5IHjvporP4u5pRbd0/6oFEMz1ylSaSeG8dRPwdJl
         q1Iw==
X-Gm-Message-State: AOUpUlHw+z4IUB2QYlGXT6+VDL74pI2YPgttCE7vrwf8Rc7trmOdTYN+
        SPJaFSIvdR/ts1BkvzTs8fzjc9UCHiqz3OU35y8=
X-Google-Smtp-Source: AAOMgpfg+/ZWGcftUUdtadsQVONIA/fwscjpdAvnP5o+IdqJtTwjC3170T8IJOrzfQvDe7GIiecXmkTrS9HJGxI08q0=
X-Received: by 2002:aca:4ec6:: with SMTP id c189-v6mr762582oib.186.1532066325134;
 Thu, 19 Jul 2018 22:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com> <20180719162826.GB11749@flask>
 <1357a0b5-0cd8-8cb5-6c61-c9662219bed0@redhat.com>
In-Reply-To: <1357a0b5-0cd8-8cb5-6c61-c9662219bed0@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 13:58:49 +0800
Message-ID: <CANRm+CxFy_R9VpxhBDuJNwZxp6Sh6wKkemaosDJ436cESk5s8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim Krcmar <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 00:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/07/2018 18:28, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> >> +
> >> +    kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, =
vector);
> > and
> >
> >       kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap[0], ipi_bitmap[1], vec=
tor);
> >
> > Still, the main problem is that we can only address 128 APICs.
> >
> > A simple improvement would reuse the vector field (as we need only 8
> > bits) and put a 'offset' in the rest.  The offset would say which
> > cluster of 128 are we addressing.  24 bits of offset results in 2^31
> > total addressable CPUs (we probably should even use that many bits).
> > The downside of this is that we can only address 128 at a time.
> >
> > It's basically the same as x2apic cluster mode, only with 128 cluster
> > size instead of 16, so the code should be a straightforward port.
> > And because x2apic code doesn't seem to use any division by the cluster
> > size, we could even try to use kvm_hypercall4, add ipi_bitmap[2], and
> > make the cluster size 192. :)
>
> I did suggest an offset earlier in the discussion.
>
> The main problem is that consecutive CPU ids do not map to consecutive
> APIC ids.  But still, we could do an hypercall whenever the total range
> exceeds 64.  Something like
>
> u64 ipi_bitmap =3D 0;
> for_each_cpu(cpu, mask)
>         if (!ipi_bitmap) {
>                 min =3D max =3D cpu;
>         } else if (cpu < min && max - cpu < 64) {
>                 ipi_bitmap <<=3D min - cpu;
>                 min =3D cpu;
>         } else if (id < min + 64) {
>                 max =3D cpu < max ? max : cpu;
>         } else {
>                 /* ... send hypercall... */
>                 min =3D max =3D cpu;
>                 ipi_bitmap =3D 0;
>         }
>         __set_bit(ipi_bitmap, cpu - min);
> }
> if (ipi_bitmap) {
>         /* ... send hypercall... */
> }
>
> We could keep the cluster size of 128, but it would be more complicated
> to do the left shift in the first "else if".  If the limit is 64, you
> can keep the two arguments in the hypercall, and just pass 0 as the
> "high" bitmap on 64-bit kernels.

As David pointed out, we need to scale to higher APIC IDs. I will add
the cpu id to apic id transfer in the for loop. How about:
kvm_hypercall2(KVM_HC_SEND_IPI, ipi_bitmap, vector); directly. In
addition, why need to pass the 0 as the "high" bitmap even if for 128
vCPUs case?

Regards,
Wanpeng Li
