Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D9BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB5B2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahW0WsR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfA2JK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:10:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34751 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfA2JK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:10:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so17277937otk.1;
        Tue, 29 Jan 2019 01:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y+gbl4XAbjxC+xEtAEEdUUUi3y94Kpx9B6/DnGdEXio=;
        b=ahW0WsR25FK3F6uzmrm0SDqmkB46FwyDWFkuVqPgJc/uhF8jF5mIgkM5JztTPgIond
         zt2Esr/05wFtGaqTBG6b2iaWBAGg+8M/I6ajG1raexEL720HXDL5Qfff17dzuDGNw1Wd
         il/12pkIUdmtEw5fmrJgZno38r4Waj76OALJBOvAcobm5faWQWA0w+jcncILKrohualc
         H+ByKhsR2SSIycD/r6Nsy29/QyylmC6BSFC+MHeQT7vf3qiNBf3xsdlRbzeiujZMJtMC
         ZtkUxTNnOneX6roP02FPjlbVhCReO3IAn+Si7H9EUD648wEANd2HK+iE6drDPwRFfStP
         1VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+gbl4XAbjxC+xEtAEEdUUUi3y94Kpx9B6/DnGdEXio=;
        b=CiJ8ElK7/wW6NCOwXv3yM0dkmtGbN78l4dNHS8WwQhh0e1mWhNumR7fvQ3p9hIrqhD
         7jdIASzGotAXuoYqxK0JGO+wJlP7u1uHl9/JaJKqgrxtZEAasgmrv7Mw6Uvu1grePodc
         LgvHQBxPLjace1kU8pCeHnLVt6d8sDD85hRraEY+9+Cpw5MGBpOYfaTdjGNcb2WD7xmF
         rMB4KUsUUv0wiHGuADI9pasSY5TOD+OgJoInvhnZi7DR0lt6QcKmE5RXrdX0GkMUKsSo
         oqxKTqffq/Ow2ZGSxB/0choPd8ozf8uYi/vUkZ7I0Ge4cUKYZ96k79ZdyP+UQolBZgbW
         6/zA==
X-Gm-Message-State: AJcUukeSkOT/8xdme4fe9ykz7qdhCXAuHJj3Mu+Z9YrAhGCJy38Ep/Xc
        AvICrO6RPw+hMwkc1ielS2F69kVQ9J81I/mwZ/U=
X-Google-Smtp-Source: ALg8bN70nyUOnPM7P0Xumgz3FkLZ2RFploc+bR/RWsGAb7HSFx6LbCHfP+Uy4lIDwvFMbpsR8TuMhXLDEm6rsPri5vc=
X-Received: by 2002:a9d:7059:: with SMTP id x25mr19637398otj.35.1548753024905;
 Tue, 29 Jan 2019 01:10:24 -0800 (PST)
MIME-Version: 1.0
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
 <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
 <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
 <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com> <20190126181321.1439e485@archlinux>
In-Reply-To: <20190126181321.1439e485@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 29 Jan 2019 11:10:12 +0200
Message-ID: <CA+U=DsqwVsXyaDiBa1VLUjWmEcGLCYfk3iVZ5h5xEAcqyrXgQw@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>,
        alexandru.ardelean@analog.com, stefan.popa@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 8:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 25 Jan 2019 22:14:32 -0200
> Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
>
> > Em sex, 25 de jan de 2019 =C3=A0s 21:46, Rodrigo Ribeiro
> > <rodrigorsdc@gmail.com> escreveu:
> > >
> > > Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> > > <ardeleanalex@gmail.com> escreveu:
> > > >
> > > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.=
com> wrote:
> > > > >
> > > > > Remove the checkpatch.pl check:
> > > > >
> > > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> > > >
> > > > Hey,
> > >
> > > Hi,
> > >
> > > Thanks for answering.
> > >
> > > > A bit curios about this one.
> > > > Are you using this chip/driver ?
> > >
> > > No, I am just a student at USP (University of S=C3=A3o Paulo) startin=
g in Linux
> > > Kernel and a new member of the USP Linux Kernel group that has contri=
buted
> > > for a few months.
> > >
> > > > Thing is: the part is nearing EOL, and it could be an idea to be
> > > > marked for removal (since it's still in staging).
> > > > But if there are users for this driver, it could be left around for=
 a while.
> > >
> > > This is my first patch in Linux Kernel, but if the driver will be rem=
oved, I
> > > can send a patch for another driver. Is there any driver that I can
> > > fix a style warning?
> >
> > Maybe, one checkstyle patch is enough, right? Which drivers can I truly
> > contribute to?
>
> How about the ad7150?  That one is still listed as production.
> What do you think Alex, you probably have better visibility on the
> status of these parts and their drivers than I do!
>
> (note I haven't even opened that one for a few years so no idea
> what state the driver is in!)
>

ad7150 is a good alternative.
At a first glance over the driver it looks like it could do with some
polish/conversions to newer IIO constructs (like IIO triggers, maybe
some newer event handling mechanisms?).
I'll sync with Stefan [Popa] to see about this stuff at a later point in ti=
me.

I'd also add here the adxl345 driver.
This is mostly informational for anyone who'd find this interesting.
There are 2 drivers for this chip, one in IIO
[drivers/iio/accel/adxl345] and another one in
"drivers/misc/adxl34x.c" as part of the input sub-system.
What would be interesting here is to finalize the IIO driver [ I think
some features are lacking behind the input driver], and make the input
driver a consumer of the IIO driver.

From my side, both these variants are fine to take on.
The ad7150 is a good idea as a starter project, and the adxl one is
more of a long-term medium-level project.

Thanks
Alex

> Jonathan
>
> >
> > > Thanks
> > >
> > >
> > > Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> > > <ardeleanalex@gmail.com> escreveu:
> > > >
> > > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.=
com> wrote:
> > > > >
> > > > > Remove the checkpatch.pl check:
> > > > >
> > > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> > > >
> > > > Hey,
> > > >
> > > > A bit curios about this one.
> > > > Are you using this chip/driver ?
> > > >
> > > > Thing is: the part is nearing EOL, and it could be an idea to be
> > > > marked for removal (since it's still in staging).
> > > > But if there are users for this driver, it could be left around for=
 a while.
> > > >
> > > > Thanks
> > > > Alex
> > > >
> > > > >
> > > > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > > > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > > > > ---
> > > > > This macro is not used anywhere. Should we just correct the
> > > > > spelling or remove the macro?
> > > > >
> > > > >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/i=
io/cdc/ad7152.c
> > > > > index 25f51db..c9da6d4 100644
> > > > > --- a/drivers/staging/iio/cdc/ad7152.c
> > > > > +++ b/drivers/staging/iio/cdc/ad7152.c
> > > > > @@ -35,7 +35,7 @@
> > > > >  #define AD7152_REG_CH2_GAIN_HIGH       12
> > > > >  #define AD7152_REG_CH2_SETUP           14
> > > > >  #define AD7152_REG_CFG                 15
> > > > > -#define AD7152_REG_RESEVERD            16
> > > > > +#define AD7152_REG_RESERVED            16
> > > > >  #define AD7152_REG_CAPDAC_POS          17
> > > > >  #define AD7152_REG_CAPDAC_NEG          18
> > > > >  #define AD7152_REG_CFG2                        26
> > > > > --
> > > > > 2.7.4
> > > > >
>
