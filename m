Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC2620894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzUEQuGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC2620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeHBDPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:15:36 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35477 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbeHBDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:15:36 -0400
Received: by mail-it0-f68.google.com with SMTP id q20-v6so952902ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 18:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b8A0ckAJ1UG2dxFvIQcO2rO80hW+pi8gmkc2LYMvrLc=;
        b=uzUEQuGO4h7MYFMEv0feA8dUFzjwxCuvoWrS71bBf/tYRb+ZURormVzbFLlsmsulbu
         mrUxoWMQT2SpUM9c2h19ez3zqRQUSnYPR9gSIJcN5BHmVz7Vqbilt5fT8miqT1aITo3k
         NvyCP5toDQ7O4zCgMkDtskWJpNRQ1d06bXQCP2L4UodBhidN2PFyU22NE1TXS9mrKy4R
         rXuImG7BF09VPjNLFtTjZEJmndEFTQhrWSPL5cvgcSlkETF6UGbgl3GRFvINRMExXAjv
         OoDttCCgHmu3xhs0lYAAo0MF710KkDPRpVnuxp3bS9d48/pMPs0Azj/m/l7QizGqeG+I
         vbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b8A0ckAJ1UG2dxFvIQcO2rO80hW+pi8gmkc2LYMvrLc=;
        b=ILNzs5aX1qEoyDqvrSBUufLG/NnJef4Rbf/qVqn7eGL04TnHouJU/cp5F352La7wQ9
         x3Rje0l5OEviiSqWcpfj+ioBahpr78PfhRGqVdjGzzr0r+pVF2va3602O8XdJWPGHiFl
         e+LWCwjWUQl7C8p8hjPBTeGEmJ0fjXkQZ4YWAnrKnaStTFBwMsqt3/Qi/0Fo3FYDVWgE
         z6Kpuk1DDh0velA1auEHFSaC+uFEQfYj7RyNJ/5SRZXqM1N3WKAqb09Q1HETv/pU+u+p
         Ubgj/NNCFwTr+gvZ7ANH337I9FQungcpgnHGmYKJsCgQ513U5Bb3WbuGNs00JA9OJhzN
         EvIg==
X-Gm-Message-State: AOUpUlFDCLdiSXcVOAxMBdqyFqC3o91hAKktX+JvFxjTT/8Y4Jp7s5CY
        Mi3FNPEdhiSDBFbhQ+1F+YZaFilC3flw0xtDxto=
X-Google-Smtp-Source: AAOMgpfvUEgui9kWzKgFalELvHT7iQlxTZOQmEbSQYxPK5nRWLOCWZCRsTEpgLX5oe/+QwVxM+HG0latOZ2aNnOHiYU=
X-Received: by 2002:a02:ba85:: with SMTP id g5-v6mr660159jao.6.1533173218923;
 Wed, 01 Aug 2018 18:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <1529545207-26999-1-git-send-email-zong@andestech.com> <mhng-38cc8366-10dd-4ea1-993f-bd453640aa66@palmer-si-x1c4>
In-Reply-To: <mhng-38cc8366-10dd-4ea1-993f-bd453640aa66@palmer-si-x1c4>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 2 Aug 2018 09:26:48 +0800
Message-ID: <CA+ZOyag=bAB6p_mah+g2DzffsABV3uig0qxMvTWZjunYAtrfkg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add the directive for alignment of stvec's value
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@adnestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=882=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 20 Jun 2018 18:40:07 PDT (-0700), zong@andestech.com wrote:
> > The stvec's value must be 4 byte alignment by specification definition.
> > This directive avoids to stvec be set the non-alignment value by the
> > following code in head.S
> >
> >  /* Point stvec to virtual address of intruction after satp write */
> > la a0, 1f
> > add a0, a0, a1
> > csrw stvec, a0
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
> > ---
> >  arch/riscv/kernel/head.S | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 396ec7b349ce..ae7b204f531c 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -94,6 +94,7 @@ relocate:
> >       or a0, a0, a1
> >       sfence.vma
> >       csrw sptbr, a0
> > +.align 2
> >  1:
> >       /* Set trap vector to spin forever to help debug */
> >       la a0, .Lsecondary_park
>
> I don't think this is actually correct: you shouldn't be aligning the add=
ress
> at which stvec is set, but the address that stvec is set to.  If this is =
fixing
> anything then it's probably just by coincidence as it's causing
> .Lsecondary_park to be aligned.
>
> I think this patch is the correct fix
>
>     diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>     index 6e07ed37bbff..d1beecf1d060 100644
>     --- a/arch/riscv/kernel/head.S
>     +++ b/arch/riscv/kernel/head.S
>     @@ -143,6 +143,7 @@ relocate:
>         tail smp_callin
>      #endif
>
>     +.align 2
>      .Lsecondary_park:
>         /* We lack SMP support or have too many harts, so park this hart =
*/
>         wfi
>
> Thanks for pointing this out!
>
The position which I set in this patch is also be set to stvec for jumping =
to
correct VA at satp enabling. The label .Lsecondary_park is also be set to s=
tvec,
I don't notice it because as you said, this label address is correct
just by coincidence.
I think there are two places need to be aligned.

The first setting as following:
relocate:
        ...
        /* Point stvec to virtual address of intruction after satp write */
        la a0, 1f
        add a0, a0, a1
        csrw stvec, a0    <-----------  first set
        ...
        sfence.vma
        csrw sptbr, a0
1:
        /* Set trap vector to spin forever to help debug */
        la a0, .Lsecondary_park
        csrw stvec, a0
