Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C8B216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmCr9lPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8B216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeKLSVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:21:37 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51123 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeKLSVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:21:37 -0500
Received: by mail-it1-f195.google.com with SMTP id k206-v6so11448095ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vWwgY24tNZCmJOla7YZMR1NXSyj4vVK1UI+xPsr+gdI=;
        b=fmCr9lPebYBgYwuy1FyJfU8E4Hcwk0Ky83FtvvWlAOHptc26nOfVGRmE0//yJZ6iat
         tNf3+syo0nr8UZVd6fADJwNGiF4ZI1bKzq8EeAsH1UWf/WRyZ82Ic1IbNY16EMr8M3XW
         LU2Z/AgKdwT5iGon/Ok1EVKJgitK+Ud2g3G25aRYof2MYkHvXir6ror9p7vvvPoQ6Xtk
         2J/ALQCa9ngCWx5DREU2RNXBiYG1NR7ZQVXRLvi5lVU4lAbmMdVdhqwZNkwxVlJ/voXi
         QXimZGMBen2PJdC7KjlH9Nm5yRFys97yr4WKbCywvXM/gRGk7lsEbWdxWXs/A4UlMdmj
         5hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vWwgY24tNZCmJOla7YZMR1NXSyj4vVK1UI+xPsr+gdI=;
        b=smcB0D2OTIrZTWYVnTnFykToH5vhOy4NMkmmjkvV1OxuNySG6zXjqQe2mWjWpEuuii
         ILHd1d/EExwRzTbi2cMBZoJIjL0ObHJbBBNltepUNZzezHttgOELoHVSs5WQRv99L+Z0
         5hhBQFQ27oY89jkku+DGK5CRyMonf1p7VOTqTOqZ03yOceExh/cfqxX31BaN8vfRduJJ
         h0yQZ6Qq98xkAPoGNnH3rUzSRrdhASme9LieZTJXPAEjgtqD6YOj4Vn0KTv7SS5kdo58
         meEzVOdBhNee2ZSGDzlQNnVf5dRoZJ0G+t+RF4D4LHvHfQrpmd5uEiGjV3Y/adsznNmI
         oWHg==
X-Gm-Message-State: AGRZ1gJwUBFIMfeBDJqTxdprEKqj3capOMcoxO9uQJVfoZIkzMP6kwkV
        QPnmR03xMkkjOuuJzwsLeV7RTU4C6iGXKb/PDTc=
X-Google-Smtp-Source: AJdET5dHXRV9SYyOgZmzgAPq4r7rjt81X3FpXad+g87yG4jooczDeUXZ++E4T2t+RJF8vzYu0xancG2GcRP1Tew9iko=
X-Received: by 2002:a24:1458:: with SMTP id 85-v6mr9748709itg.40.1542011368945;
 Mon, 12 Nov 2018 00:29:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541995312.git.zongbox@gmail.com> <41e8cb18d321244ab7000f7dc0467b6ebc5cab8f.1541995312.git.zongbox@gmail.com>
 <CAEn-LTpXnzSG-rVVvv_2cbxqY2vTchOKn6M0isRBovoq4jpZGw@mail.gmail.com>
In-Reply-To: <CAEn-LTpXnzSG-rVVvv_2cbxqY2vTchOKn6M0isRBovoq4jpZGw@mail.gmail.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Mon, 12 Nov 2018 16:29:17 +0800
Message-ID: <CA+ZOyahQ-6biJazXCYr539-rCQHuJOz6QFuVB_Jv5EpfYuPrwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Request stat64 on RV32
To:     david.abdurachmanov@gmail.com
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zong Li <zong@andestech.com>, marcin.juszkiewicz@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Abdurachmanov <david.abdurachmanov@gmail.com> =E6=96=BC 2018=E5=B9=B4=
11=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:19=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Mon, Nov 12, 2018 at 5:10 AM Zong Li <zongbox@gmail.com> wrote:
> >
> > The stat64 family that is used on 32-bit architectures to replace
> > newstat.
> >
> > Since commit 67314ec7b0250290cc85eaa7a2f88a8ddb9e8547 ("RISC-V: Request
> > newstat syscalls"), the RV32 build fail with undeclared 'sys_fstatat64'
> >
> > Signed-off-by: Zong Li <zong@andestech.com>
> > ---
> >  arch/riscv/include/asm/unistd.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/u=
nistd.h
> > index eff7aa9..a4aade9 100644
> > --- a/arch/riscv/include/asm/unistd.h
> > +++ b/arch/riscv/include/asm/unistd.h
> > @@ -18,5 +18,6 @@
> >
> >  #define __ARCH_WANT_NEW_STAT
> >  #define __ARCH_WANT_SYS_CLONE
> > +#define __ARCH_WANT_STAT64
> >  #include <uapi/asm/unistd.h>
> >  #include <uapi/asm/syscalls.h>
> > --
>
> See: http://lists.infradead.org/pipermail/linux-riscv/2018-November/00208=
7.html
>
> The plan is not to have old stat syscalls and support statx on
> riscv32, which is y2038 safe.
>
> The issue you see is a bug in include/uapi/asm-generic/unistd.h.
> Marcin (CC) already sent a patch to Arnd (CC) IIRC. Basically without
> __ARCH_WANT_NEW_STAT or __ARCH_WANT_STAT64 two macros are not defined:
> __NR3264_fstatat and __NR3264_fstat. Which is later used (without any
> guards):
>
> 763 #define __NR_newfstatat __NR3264_fstatat
> 764 #define __NR_fstat __NR3264_fstat

Nice. Thank you.
