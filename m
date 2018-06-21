Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6876620836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qb8N2aV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6876620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFUKNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:13:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34045 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeFUKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:13:14 -0400
Received: by mail-it0-f67.google.com with SMTP id y127-v6so2103829itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kqCgPCsa0HG7RmZUH4jCmhbwu+AkPIWWRKPET7vjdws=;
        b=qb8N2aV7i/S2NlmR6H4ippfwq0HoyNV807sM08aauGeptDg5Q1NG2wcMNzUaiANoRb
         0bIqxrbj3ZXlysO1S9HpHDWg2gs8R/dK1Cuvx+UgT88o2s8MMK+1lB7sSsIJ2QVmDVob
         00sLeFsmJJeYGVbqxYvd0Q+DPUNpwYRqBCtadXQsMI/lbzzg5XAMsCVqGwpmcokD9ecm
         3oX+E+nG9doHpiu6vyEB9n/6FgJt8bX+jfAY5p1XEo6saxlTPtmLmwwNk1ttJn+nRRpY
         7YlFONtpCWsdd3FeMaqDITEn3uInQhwnIhvB9o/ZxBVYBC4UdTsqIdH5dzgHBuK59R9s
         GM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kqCgPCsa0HG7RmZUH4jCmhbwu+AkPIWWRKPET7vjdws=;
        b=W5TWzBYbjdyyTMBNIO1DdSEEeDgF/rBO8Rrs46Ngb4UbOey89Qx8FkhMYuOQmNmvWE
         agSHLPsGBUijAHRLdnH92MSl8ODmGSzmCoVpWKoyASa2d65R+do5CvJfwWK6EbBvjkNC
         MmICQ+CH1oYjzi7HIZuugPNGLoRINlzqF5IIgcWHNMLT8IE09ogXYlQB8BmRhC7ParE+
         ddF9a8kTHqWCncbODom4qSH9lRDLdmkpMFNcz0OmJMnVMdDhUJXTMf6smk4Yq6G6Vszy
         qnl7EQ1RUF6nFkA64qJHlHNAiWQtZIpS23d6mkxxFV4xb39ZxjDPmtzYVRje9At8G7CW
         SXgg==
X-Gm-Message-State: APt69E12yyaZHexFwP1FbCJV8TTDQNu7yjK3/1zUqpMZjlCOgZ+bmiBp
        xX0SCu+6z4+Pw0uUz67heyyeHa3H/ErEFe3sTNc=
X-Google-Smtp-Source: ADUXVKJyGwwR8M/NFebKkWb0QHGxlUOYENPdRD8qe9m80zkqWS9825bsao928K0WxofhWeAz6OPnwCqGMqkqrhsUlHo=
X-Received: by 2002:a24:e306:: with SMTP id d6-v6mr4500376ith.103.1529575993342;
 Thu, 21 Jun 2018 03:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529506497.git.zong@andestech.com> <37a6523947397cd72320676030b96926e373d05a.1529506497.git.zong@andestech.com>
 <20180621064322.GE19319@infradead.org>
In-Reply-To: <20180621064322.GE19319@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 21 Jun 2018 18:13:02 +0800
Message-ID: <CA+ZOyagYq0Kbsbxe20MwjeArxRP-fZtQNLZUbCdM3JSPssQuvg@mail.gmail.com>
Subject: Re: [PATCH 5/5] RISC-V: Use fixed width integer types for 32-bit compatible
To:     hch@infradead.org
Cc:     Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aou@eecs.berkeley.edu, greentime@adnestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B46=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, Jun 21, 2018 at 09:41:46AM +0800, Zong Li wrote:
> > Use fixed width integer types for print format on 32/64 bit
> > to fix warning about format compatible.
> >
> > Like inttypes.h, but more simpler for RISC-V usage.
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
> > ---
> >  arch/riscv/include/asm/format.h | 20 ++++++++++++++++++++
> >  arch/riscv/kernel/module.c      | 13 +++++++------
> >  2 files changed, 27 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/format.h
> >
> > diff --git a/arch/riscv/include/asm/format.h b/arch/riscv/include/asm/f=
ormat.h
> > new file mode 100644
> > index 000000000000..9b68ca7fac46
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/format.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2018 Andes Technology Corporation */
> > +
> > +#ifndef _ASM_RISCV_FORMAT_H
> > +#define _ASM_RISCV_FORMAT_H
> > +
> > +#if __riscv_xlen =3D=3D 64
> > +#define __PRI_PREFIX "ll"
> > +#else
> > +#define __PRI_PREFIX
> > +#endif
> > +
> > +#define PRIdX        __PRI_PREFIX "d"
> > +#define PRIiX        __PRI_PREFIX "i"
> > +#define PRIuX        __PRI_PREFIX "u"
> > +#define PRIoX        __PRI_PREFIX "o"
> > +#define PRIxX        __PRI_PREFIX "x"
> > +#define PRIXX        __PRI_PREFIX "X"
> > +
> > +#endif /* _ASM_RISCV_FORMAT_H */
>
> If you want these prefixed submit them to the core kernel, not
> under asm/ for RISC-V.
>

Maybe I can move to core kernel after this patch?
And I think I can rename the "PRIdX" to "PRIdXELF" to avoid ambiguous
in C definition.


> >
> >  static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf=
_Addr v)
> >  {
> >       if (v !=3D (u32)v) {
> > -             pr_err("%s: value %016llx out of range for 32-bit field\n=
",
> > +             pr_err("%s: value %016" PRIxX "out of range for 32-bit fi=
eld\n",
> >                      me->name, v);
> >               return -EINVAL;
>
> But in general Linux uXX and sXX values are always the same underlying
> fundamental C type.  What is the mismatch here?
>

This relocation type was added by  Andreas, and there is some
discussions on the mail list
(ref: http://lists.infradead.org/pipermail/linux-riscv/2018-June/000706.htm=
l)

As I see it, there is truncate situation on 64-bit system, or maybe
there is no R_RISCV_32 relocation
type on 64-bit system?
