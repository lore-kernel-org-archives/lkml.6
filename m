Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C91C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C3A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB6PR2Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfAYXrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:47:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56304 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfAYXrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:47:11 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so13107143ith.5;
        Fri, 25 Jan 2019 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0YgK5L1z0BuGqJVSt87p+qQmdsVCGZ2vh5acRVjkM5Q=;
        b=KB6PR2Yy8dALNRcAZZqE1S+bsgwksVwPEhbB0cmnwgLWRQSbAaoa3lCwK/0T03SI8n
         +CLs3aiA98FrRi0xa871U5YpfPw/BlApN8ZnpXhHGJ5vkLwi7hrUrmDlMWDaN45xh5le
         XUBZ88QIH8EPz9KGr8gyA+cq8ZjU0R/1RoHAGo+h4B/WzfBC98X0XbhUWebMIjk4kdmf
         lbnZsZa5Xp1p36sFl807g26zqUEcqgBkPg0IbUkNzIXYQzvi6nJuTKVpPtNjaDp5QzY7
         hqQDE4TsetCMYh/WFxToTHN115kZjO4CfeI265CfJFkqGwN+2p44ARHvHKGPBnAQbAW9
         CpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0YgK5L1z0BuGqJVSt87p+qQmdsVCGZ2vh5acRVjkM5Q=;
        b=FmiVXrhSbZiYOJWrCuQcaBF2cMBmgZXz4v7LtXzdaJCZcHu6ZCYTfhpH2ThgX3/4p0
         OdaWaKR8n5TPZl9bN5/JNpBXzeG8TeMEUH4DD8UnkDWDQ0qqs+c5GdwH/pyAbcLe1K1K
         zu+AMEzU+ztbUxteRTlpZwYDajXvIGnPmCgO3GrKC9uLgrZp1aOHiX5VlPhl5KnBvACP
         ph46hQ69aZLFyl6Nc0JSatQ87kLOtBVmR2+Q6N4PrR1UddG1CdM+VotG+zckVzh17FwJ
         9FHjQ0eOfgTAfCsMK8msMOgk8MPZtI/LTOCtrV2WyW6R3ALjGvHpXhrj/KZP5e9f74+R
         VSsg==
X-Gm-Message-State: AJcUukeoSy+ZPrQHXh8BY2FWxAXXbTjEiSpv6YpctN7BnG89bBcHX2c7
        Q51mExr0f5bqrhXtpWeWszlVx63YQ+D05a8X6q4=
X-Google-Smtp-Source: ALg8bN74Da3VA9uB5wewYIZjTJo89WLpZ/0DNSrUrBxNmmXr8HtxOSTd2aBwbLHbTNcV6jj+Gwv97n37DlSZuXpMV7c=
X-Received: by 2002:a24:9e87:: with SMTP id p129mr5185791itd.148.1548460030776;
 Fri, 25 Jan 2019 15:47:10 -0800 (PST)
MIME-Version: 1.0
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com> <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
In-Reply-To: <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Date:   Fri, 25 Jan 2019 21:46:58 -0200
Message-ID: <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
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

Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
<ardeleanalex@gmail.com> escreveu:
>
> On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com> w=
rote:
> >
> > Remove the checkpatch.pl check:
> >
> > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
>
> Hey,

Hi,

Thanks for answering.

> A bit curios about this one.
> Are you using this chip/driver ?

No, I am just a student at USP (University of S=C3=A3o Paulo) starting in L=
inux
Kernel and a new member of the USP Linux Kernel group that has contributed
for a few months.

> Thing is: the part is nearing EOL, and it could be an idea to be
> marked for removal (since it's still in staging).
> But if there are users for this driver, it could be left around for a whi=
le.

This is my first patch in Linux Kernel, but if the driver will be removed, =
I
can send a patch for another driver. Is there any driver that I can
fix a style warning?

Thanks


Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
<ardeleanalex@gmail.com> escreveu:
>
> On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.com> w=
rote:
> >
> > Remove the checkpatch.pl check:
> >
> > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
>
> Hey,
>
> A bit curios about this one.
> Are you using this chip/driver ?
>
> Thing is: the part is nearing EOL, and it could be an idea to be
> marked for removal (since it's still in staging).
> But if there are users for this driver, it could be left around for a whi=
le.
>
> Thanks
> Alex
>
> >
> > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > ---
> > This macro is not used anywhere. Should we just correct the
> > spelling or remove the macro?
> >
> >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc=
/ad7152.c
> > index 25f51db..c9da6d4 100644
> > --- a/drivers/staging/iio/cdc/ad7152.c
> > +++ b/drivers/staging/iio/cdc/ad7152.c
> > @@ -35,7 +35,7 @@
> >  #define AD7152_REG_CH2_GAIN_HIGH       12
> >  #define AD7152_REG_CH2_SETUP           14
> >  #define AD7152_REG_CFG                 15
> > -#define AD7152_REG_RESEVERD            16
> > +#define AD7152_REG_RESERVED            16
> >  #define AD7152_REG_CAPDAC_POS          17
> >  #define AD7152_REG_CAPDAC_NEG          18
> >  #define AD7152_REG_CFG2                        26
> > --
> > 2.7.4
> >
