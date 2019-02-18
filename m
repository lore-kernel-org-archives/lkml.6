Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1345C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C2A20700
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amDh8h8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbfBRRBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:01:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43051 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731758AbfBRRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:01:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so29369156ota.10;
        Mon, 18 Feb 2019 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9J7QJcU6fOyq9yjKKoN2UUPB2x5QmZ5tmFHf9bJrFHg=;
        b=amDh8h8/MLf/6XxJN9GDT/fGhBe6U/+qMDs9yPFl453I7ZRfh5QnLLnLD3T35m9e3k
         yFwTaWc3e1Xo6EwQCM2bRt+aPe6IFnJFqrD2E6q7XQFKqAjccU75Xc8VLTk1YVdqcOk6
         bjCzkhExNZiCNGZrNh6W0sEnArjcuLLv9vJI7rEdJVSjQpmdsgHlyvXdDXAd7BuBqxfk
         lwREwzNv8mXwiz9mGZPUakEjgdq3+4u2YAs/kdSzjISedt4mOaJE47liah8oBt3mdrW9
         UWEq1m5h2lzDrtFgRJoSrJ9awn05buYKR37KlDs1QaO9o/hWKHfwqUa2h8WBJJ1FgBf9
         pbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9J7QJcU6fOyq9yjKKoN2UUPB2x5QmZ5tmFHf9bJrFHg=;
        b=iveah23zqWt+etbRKvW1zwWVH7sEggkXR7ThmpHRtHjrOe0kdvSpHwcU1QmQ20EWe7
         H5Yu7NXhTsYjCUk8/IAsa3bkm78HdmpXtBWeNK30mW5KISMMtqXR5pA7tVJRO1Bb1fXI
         6Y/JEqYD5mQCwPHugXGlaVCnyNNbctQVaLAh0/LlJUyNtZH7XtPlpbjc9JL/Zjfp8v4/
         fvMo7FwhS4rEewMeh/1Ogl31w6LV1HyRhUQkOSEUk1PUIWpm65aORDfCESbtR/5KbEMi
         ZqXQlXLCXdVGVSqB6EjbPMs4GYX9CRoonRMutCjjSUvxf+oMQluth4WjbzwdvPG5gXc7
         i9Gg==
X-Gm-Message-State: AHQUAubFIJi4TOBmQ/E5DqgVU8i60LSeo2yQMWXY+8mUuHPU2oFeH4eR
        KPd4w1ATc+CUqkkjph7yCdyjSjuBOfYjag6/YTM=
X-Google-Smtp-Source: AHgI3IY9Wnq/+W0QKRQd+nsYeldxdODRQCbjP/3H7VJ2EpdvIptYOWZ8XcO5f8sFQmHa+YwAr/nO0fUjZgs5OkFkLb8=
X-Received: by 2002:aca:3345:: with SMTP id z66mr15293587oiz.91.1550509270173;
 Mon, 18 Feb 2019 09:01:10 -0800 (PST)
MIME-Version: 1.0
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
 <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
 <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
 <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
 <20190126181321.1439e485@archlinux> <CA+U=DsqwVsXyaDiBa1VLUjWmEcGLCYfk3iVZ5h5xEAcqyrXgQw@mail.gmail.com>
 <CAOeBkLok_PJ-ZbHcTN-yc6+p-qb5RMMmALp4fOpfAr2cqRO5Ug@mail.gmail.com>
 <1550141494.9460.51.camel@analog.com> <20190218144634.00001d74@huawei.com>
In-Reply-To: <20190218144634.00001d74@huawei.com>
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Date:   Mon, 18 Feb 2019 14:00:58 -0300
Message-ID: <CAOeBkLqaqZJJCrN3D6tq7S3P=yhJs+V5grnaC+FmSeg4bRxfvg@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael.tsuha@usp.br" <rafael.tsuha@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em seg, 18 de fev de 2019 =C3=A0s 11:46, Jonathan Cameron
<jonathan.cameron@huawei.com> escreveu:
>
> On Thu, 14 Feb 2019 10:51:49 +0000
> "Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:
>
> > On Mi, 2019-02-13 at 22:25 -0200, Rodrigo Ribeiro wrote:
> > > [External]
> > >
> > >
> > > Em ter, 29 de jan de 2019 =C3=A0s 07:10, Alexandru Ardelean <ardelean=
alex@gmai
> > > l.com> escreveu:
> > > >
> > > > On Sat, Jan 26, 2019 at 8:13 PM Jonathan Cameron <jic23@kernel.org>
> > > wrote:
> > > > >
> > > > > On Fri, 25 Jan 2019 22:14:32 -0200
> > > > > Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:
> > > > >
> > > > > > Em sex, 25 de jan de 2019 =C3=A0s 21:46, Rodrigo Ribeiro
> > > > > > <rodrigorsdc@gmail.com> escreveu:
> > > > > > >
> > > > > > > Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> > > > > > > <ardeleanalex@gmail.com> escreveu:
> > > > > > > >
> > > > > > > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsd=
c@gm
> > > ail.com> wrote:
> > > > > > > > >
> > > > > > > > > Remove the checkpatch.pl check:
> > > > > > > > >
> > > > > > > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> > > > > > > >
> > > > > > > > Hey,
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Thanks for answering.
> > > > > > >
> > > > > > > > A bit curios about this one.
> > > > > > > > Are you using this chip/driver ?
> > > > > > >
> > > > > > > No, I am just a student at USP (University of S=C3=A3o Paulo)=
 starting
> > > in Linux
> > > > > > > Kernel and a new member of the USP Linux Kernel group that ha=
s
> > > contributed
> > > > > > > for a few months.
> > > > > > >
> > > > > > > > Thing is: the part is nearing EOL, and it could be an idea =
to
> > > be
> > > > > > > > marked for removal (since it's still in staging).
> > > > > > > > But if there are users for this driver, it could be left ar=
ound
> > > for a while.
> > > > > > >
> > > > > > > This is my first patch in Linux Kernel, but if the driver wil=
l be
> > > removed, I
> > > > > > > can send a patch for another driver. Is there any driver that=
 I
> > > can
> > > > > > > fix a style warning?
> > > > > >
> > > > > > Maybe, one checkstyle patch is enough, right? Which drivers can=
 I
> > > truly
> > > > > > contribute to?
> > > > >
> > > > > How about the ad7150?  That one is still listed as production.
> > > > > What do you think Alex, you probably have better visibility on th=
e
> > > > > status of these parts and their drivers than I do!
> > > > >
> > > > > (note I haven't even opened that one for a few years so no idea
> > > > > what state the driver is in!)
> > > > >
> > > >
> > > > ad7150 is a good alternative.
> > > > At a first glance over the driver it looks like it could do with so=
me
> > > > polish/conversions to newer IIO constructs (like IIO triggers, mayb=
e
> > > > some newer event handling mechanisms?).
> > > > I'll sync with Stefan [Popa] to see about this stuff at a later poi=
nt
> > > in time.
> > > >
> > > > I'd also add here the adxl345 driver.
> > > > This is mostly informational for anyone who'd find this interesting=
.
> > > > There are 2 drivers for this chip, one in IIO
> > > > [drivers/iio/accel/adxl345] and another one in
> > > > "drivers/misc/adxl34x.c" as part of the input sub-system.
> > > > What would be interesting here is to finalize the IIO driver [ I th=
ink
> > > > some features are lacking behind the input driver], and make the in=
put
> > > > driver a consumer of the IIO driver.
> > > >
> > > > From my side, both these variants are fine to take on.
> > > > The ad7150 is a good idea as a starter project, and the adxl one is
> > > > more of a long-term medium-level project.
> > > >
> > > > Thanks
> > > > Alex
> > > >
> > >
> > > Hi Alex, thanks for suggestions.
> > >
> > > I read the IIO trigger documentation
> > > (https://www.kernel.org/doc/html/v4.12/driver-api/iio/triggers.html) =
and
> > > ask one question: What is the difference between events and triggers?
> > > They are sounds me same things.
> > >
> > > I am trying to understand how to implement a IIO trigger by reading
> > > the IIO Simple Dummy code but this driver does not implements IIO
> > > triggers
> > > but only IIO events. Is there a didactic example like IIO Simple Dumm=
y
> > > that implements IIO triggers?
> > >
> > > Thanks
> > > Rodrigo
> > >
> >
> > Hi Rodrigo,
> >
> > From what I know, IIO Events are not used for passing readings from dev=
ices
> > to userspace, but rather out of bounds information such as crossing of
> > voltage thresholds, proximity detection, motion detection, etc.
> > Triggers are typically used to determine when valid data can be read fr=
om a
> > device which is then stored in the buffer.
> >
> > After a quick look over the AD7150, I think that using IIO events, migh=
t be
> > the correct approach, since it is a proximity sensing device.
>
> To answer the question on generic triggers (agreed, probably not relevant=
 here
> from what Stefan has said), there are several software triggers under
> drivers/iio/triggers.
>
> Wasn't a lot of point in adding another one to the dummy driver given you
> can use the hrtimer, or sysfs triggers directly.
> (loop will result in craziness given the near zero read time of the
> dummy driver ;)
>
> Jonathan
>
> >
> > -Stefan
> >
> > > > > Jonathan
> > > > >
> > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> > > > > > > <ardeleanalex@gmail.com> escreveu:
> > > > > > > >
> > > > > > > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsd=
c@gm
> > > ail.com> wrote:
> > > > > > > > >
> > > > > > > > > Remove the checkpatch.pl check:
> > > > > > > > >
> > > > > > > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?
> > > > > > > >
> > > > > > > > Hey,
> > > > > > > >
> > > > > > > > A bit curios about this one.
> > > > > > > > Are you using this chip/driver ?
> > > > > > > >
> > > > > > > > Thing is: the part is nearing EOL, and it could be an idea =
to
> > > be
> > > > > > > > marked for removal (since it's still in staging).
> > > > > > > > But if there are users for this driver, it could be left ar=
ound
> > > for a while.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > Alex
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > > > > > > > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > > > > > > > > ---
> > > > > > > > > This macro is not used anywhere. Should we just correct t=
he
> > > > > > > > > spelling or remove the macro?
> > > > > > > > >
> > > > > > > > >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/staging/iio/cdc/ad7152.c
> > > b/drivers/staging/iio/cdc/ad7152.c
> > > > > > > > > index 25f51db..c9da6d4 100644
> > > > > > > > > --- a/drivers/staging/iio/cdc/ad7152.c
> > > > > > > > > +++ b/drivers/staging/iio/cdc/ad7152.c
> > > > > > > > > @@ -35,7 +35,7 @@
> > > > > > > > >  #define AD7152_REG_CH2_GAIN_HIGH       12
> > > > > > > > >  #define AD7152_REG_CH2_SETUP           14
> > > > > > > > >  #define AD7152_REG_CFG                 15
> > > > > > > > > -#define AD7152_REG_RESEVERD            16
> > > > > > > > > +#define AD7152_REG_RESERVED            16
> > > > > > > > >  #define AD7152_REG_CAPDAC_POS          17
> > > > > > > > >  #define AD7152_REG_CAPDAC_NEG          18
> > > > > > > > >  #define AD7152_REG_CFG2                        26
> > > > > > > > > --
> > > > > > > > > 2.7.4
> > > > > > > > >
> > > >
>
>

Thanks for answering Jonathan and Stefan.

I would like to contribute with the ad7150 driver. Could you please
give me some hints on what can I do to move this driver
out of staging?

I note that device registration (devm_iio_device_register) is not
the last function called at probe function. Should I change order
to call dev_info before the device registration?

Also did not see any device tree documentation at
Documentation/devicetree/bindings/iio for AD7150 driver.
