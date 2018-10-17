Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9ADECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A2321523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="envR4Imv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A2321523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJQQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:16:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23171 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeJQQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:16:25 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9H8LcFA028359;
        Wed, 17 Oct 2018 17:21:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9H8LcFA028359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539764499;
        bh=VQ7DNcwGQ4f+sJ08vqiT3mXYi94gyDIUN8MHYj6lU4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=envR4Imv+x7Ypver6PEJJWReUhQuPEXl12XabC7Pmt4wUtJrmp9XrZuLygKHtZgjb
         mbxOb/9Pxksfx/ESUnlamgEed93Y7eAOHClTvrqjL1ep5YUEivnUFKQ7qWSCTfCN7G
         WZp7qmfIwVWzrPW0iuorDWztmJwRbPAwDaALP1efSR6ukMjILpkeqxl+yKhrnZbJ83
         TFNjE2EQUQsLLzWkg5CPb1j/DCbj2fIIpiJVMaCwKYRxy6ke+oIvlQ0uT6wmGLzXBb
         2DtZCS2r0h3k/mqlBSR6rDE9bRlXWalJexphduyW1+TsTDDaw+ifoQ6kmrEtLrTm2H
         b3hLYs4g3iqJA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id y195so4452941vsc.7;
        Wed, 17 Oct 2018 01:21:38 -0700 (PDT)
X-Gm-Message-State: ABuFfojrueMckXLU+t8gQdJJYB/R26AgCkvXaPzJq7c1dxWnEF19Fe1g
        xY4z/faOn7X/I4/+z7ZMy0YSItF8tODuHJ9myQE=
X-Google-Smtp-Source: ACcGV61t0O7LUjlhfMtrCO2E2d2CGWmy/4R6mtWyr0GTQX0Dtv4NBDQsot3x+++Ooi+ZUFRZpUjNEofnpGzJ99dHCcE=
X-Received: by 2002:a67:65c3:: with SMTP id z186mr10393250vsb.54.1539764497518;
 Wed, 17 Oct 2018 01:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
In-Reply-To: <20181017081115.GA22535@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Oct 2018 17:21:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
Message-ID: <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org, willy6545@gmail.com,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:11 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 16, 2018 at 09:08:09PM -0300, Leonardo Br=C3=A1s wrote:
> > Adds -Wshadow=3Dlocal on KBUILD_HOSTCFLAGS to show shadow warnings
> > on tools built for HOST.
> >
> > Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index e8b599b4dcde..fb0a9ac195e7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -360,7 +360,7 @@ HOST_LFS_LIBS :=3D $(shell getconf LFS_LIBS 2>/dev/=
null)
> >
> >  HOSTCC       =3D gcc
> >  HOSTCXX      =3D g++
> > -KBUILD_HOSTCFLAGS   :=3D -Wall -Wmissing-prototypes -Wstrict-prototype=
s -O2 \
> > +KBUILD_HOSTCFLAGS   :=3D -Wall -Wshadow=3Dlocal -Wmissing-prototypes -=
Wstrict-prototypes -O2 \
> >               -fomit-frame-pointer -std=3Dgnu89 $(HOST_LFS_CFLAGS) \
> >               $(HOSTCFLAGS)
> >  KBUILD_HOSTCXXFLAGS :=3D -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> > --
>
> You might wanna take a look at scripts/Makefile.extrawarn which already
> has -Wshadow.


scripts/Makefile.extrawarn provides options for the target compiler (CC),
whereas this patch adds -Wshadow=3Dlocal for the host compiler (HOSTCC).



--=20
Best Regards
Masahiro Yamada
