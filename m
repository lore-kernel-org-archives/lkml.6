Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5BC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BDB218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMbq7xLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfAZAOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:14:46 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34925 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAZAOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 19:14:45 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so12227261itp.0;
        Fri, 25 Jan 2019 16:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PAsA5oaNC5v3V4hNn9ia29FXNhL0AmQg8w27/YvO9VE=;
        b=gMbq7xLTHMbeqnc+g9iivdqEbvItToDV2KjmXtM8JDVrEyn02hIL9YmEL3CKjEA2xi
         2/hBrP5nJzltXApGzewXaelRX9Zf+yWm705vF8iIjIc2TiyY5f+V+/cIbmHKvmxm+Vga
         Xek+g6kuOTezN4D54P0A+ygMcCs/q65Fl4rRtWkzTAwTchb/Usf0BuAY9dbRq8YM6njB
         EO7Tj+GGr59y6oxWwf60daTh+0v8fypTWqL7g7cmvm+lasvppVBADUrWmoH1Wyh0EO16
         xJ1U+xo/JljDk8OqNi2a1uW60pPGB1TfUpq360IRjdZAZHHI7cM0UhZ15powPsjiFRK9
         Eudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PAsA5oaNC5v3V4hNn9ia29FXNhL0AmQg8w27/YvO9VE=;
        b=bh3namxTibIBDbTEGjBlLNn7aAlrDlxX4SC5zBt7T5XVzfPgx1Gre6HmaUBymnjh79
         U0FT5rreIgKQJ9xrTluFhlSwX47lxFlTiXTcpUnlB+q6lBXbJgTLfREs+8uw9q3BZEqD
         ctfB8JRGAlao6RRnWlC0mK/fSGR7kO+Xbm2zABy7n5zx8Xn+1lMnuQleinURi4Twj8Kk
         3SctpdPn3zNJ+2jNn8B6Z+mJARlLKa6Qzv+3po47MbaZ2tPCWSdIJugUWXs3it8QvZUg
         kg0HzyzKpZRM6pcB+GN5plgIPYRj24+aH4f3G82AcJG3aBd4hRKUh+LcuDAfbxy4XAef
         6wbQ==
X-Gm-Message-State: AJcUukcvzBtfEMfpVOMZUO2FlTmCp2DgFBUmbhN6myX7QiAv3BDGu7OG
        HnGjpcIdGcszliX0IqPlMSc0+AKaZ5x/9Bfj7BM=
X-Google-Smtp-Source: ALg8bN5cLj55r2AFJJCGiONdbE07c0uw1elbFiCp+l/w6yxJzYEkgTdlBuJnTufJX6rKGDaimmssdVhHEjZlazmqx0s=
X-Received: by 2002:a02:b424:: with SMTP id i33mr9151384jaj.37.1548461684454;
 Fri, 25 Jan 2019 16:14:44 -0800 (PST)
MIME-Version: 1.0
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
 <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com> <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
In-Reply-To: <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Date:   Fri, 25 Jan 2019 22:14:32 -0200
Message-ID: <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em sex, 25 de jan de 2019 =C3=A0s 21:46, Rodrigo Ribeiro
<rodrigorsdc@gmail.com> escreveu:
>
> Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> <ardeleanalex@gmail.com> escreveu:
> >
> > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com>=
 wrote:
> > >
> > > Remove the checkpatch.pl check:
> > >
> > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> >
> > Hey,
>
> Hi,
>
> Thanks for answering.
>
> > A bit curios about this one.
> > Are you using this chip/driver ?
>
> No, I am just a student at USP (University of S=C3=A3o Paulo) starting in=
 Linux
> Kernel and a new member of the USP Linux Kernel group that has contribute=
d
> for a few months.
>
> > Thing is: the part is nearing EOL, and it could be an idea to be
> > marked for removal (since it's still in staging).
> > But if there are users for this driver, it could be left around for a w=
hile.
>
> This is my first patch in Linux Kernel, but if the driver will be removed=
, I
> can send a patch for another driver. Is there any driver that I can
> fix a style warning?

Maybe, one checkstyle patch is enough, right? Which drivers can I truly
contribute to?

> Thanks
>
>
> Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> <ardeleanalex@gmail.com> escreveu:
> >
> > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com>=
 wrote:
> > >
> > > Remove the checkpatch.pl check:
> > >
> > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> >
> > Hey,
> >
> > A bit curios about this one.
> > Are you using this chip/driver ?
> >
> > Thing is: the part is nearing EOL, and it could be an idea to be
> > marked for removal (since it's still in staging).
> > But if there are users for this driver, it could be left around for a w=
hile.
> >
> > Thanks
> > Alex
> >
> > >
> > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > > ---
> > > This macro is not used anywhere. Should we just correct the
> > > spelling or remove the macro?
> > >
> > >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/c=
dc/ad7152.c
> > > index 25f51db..c9da6d4 100644
> > > --- a/drivers/staging/iio/cdc/ad7152.c
> > > +++ b/drivers/staging/iio/cdc/ad7152.c
> > > @@ -35,7 +35,7 @@
> > >  #define AD7152_REG_CH2_GAIN_HIGH       12
> > >  #define AD7152_REG_CH2_SETUP           14
> > >  #define AD7152_REG_CFG                 15
> > > -#define AD7152_REG_RESEVERD            16
> > > +#define AD7152_REG_RESERVED            16
> > >  #define AD7152_REG_CAPDAC_POS          17
> > >  #define AD7152_REG_CAPDAC_NEG          18
> > >  #define AD7152_REG_CFG2                        26
> > > --
> > > 2.7.4
> > >
