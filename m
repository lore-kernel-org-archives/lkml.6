Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F58ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DFA20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzS97atw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DFA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeGTEVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:21:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39643 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeGTEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:21:11 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so18893834oib.6;
        Thu, 19 Jul 2018 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hBiUyMzEt935O9OT+YKPhS4xVJTMRpPhveQnYjrUU5s=;
        b=AzS97atwCVCHQjknQ59FZYZW6JkeG/chfa9cum3303HNw3oIjAVyv3CQ9idHEvX9gW
         SWjhosof0Ehc+x3DVLydBpg4vH/j1WizzAOC+O3EXtnCEhxHFjdC+zgkmUGIsW79463A
         DVSGcJk5WDnvHZgCRo4uy3TjUpIp8114IkJBGkVggONAxJv/gxv5H2+rz58eqFBDDZN7
         gY4zs4A+znN53wwDUZjqOGlt5RdANPt7w3P0e6J0x3GNF+kCO5bs5KJpOox5n+2rD96C
         vvL8SFWp8ZIfYn1Qm/SvUWoqSPmgZj4qXv4tSYhrc2Zv3HZngKB4DcYoT+6b7/ium3x1
         07TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hBiUyMzEt935O9OT+YKPhS4xVJTMRpPhveQnYjrUU5s=;
        b=ovQ/012xyZEBiXBokZAbYXUUi9tewCaJKyTXJ4P41Ypx3lNkXMhTQFcvv/xBVtdOez
         34n26Hgj1muHz07IeD9vVDEJ5nKXR+0qapIufdijm1nWMi7qIGHRW787fW/8WkvekeHN
         q/Q046uggxAxdpWJrtnb7s3dVT18SlFViQdrM7WUQtUcg+3z/ndG98h0L1PUBvoMrtzm
         fBGYuA0jS7cGhNVz3HRJsYAc4H9FgN2Sdkjs/xFAY+XjjTEmt1W95gkcnn802UFn8AYv
         bhoqiXIe1t+2V1dSD5/qbFUUESREn5v4CUQOzBlJpVZ8bfjay3qOhl7i3lEtYqCQUQx2
         GBIw==
X-Gm-Message-State: AOUpUlHhcMyUxMgIK6ggQPOfgH+IA4o/LMnloQbS5FJP/ed1LDOtNRu1
        Woa86pkSFTFMChXbtPo2qBMqcJxk/+mI65fgysE=
X-Google-Smtp-Source: AAOMgpdKG6tProIWkj1F0SnmEzgyCexA7ABb557QqIogf3mEMsWmJ8h5w/Vsxv50Srnvu6mnBRIIcQjMZfFK+N0qAvg=
X-Received: by 2002:aca:b585:: with SMTP id e127-v6mr358075oif.119.1532057703352;
 Thu, 19 Jul 2018 20:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com> <20180719162826.GB11749@flask>
 <1357a0b5-0cd8-8cb5-6c61-c9662219bed0@redhat.com>
In-Reply-To: <1357a0b5-0cd8-8cb5-6c61-c9662219bed0@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 20 Jul 2018 11:35:07 +0800
Message-ID: <CANRm+CzH93DMX5iK6OpRyB8FNdE5Ery9qzEdpJj+61A5kHq_xw@mail.gmail.com>
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

Cool, i will try the offset method in next version. Thanks for your
review, Paolo! :)

Regards,
Wanpeng Li
