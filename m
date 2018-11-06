Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847542083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO42Mc3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847542083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbeKFW2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:28:03 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40387 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387905AbeKFW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:28:02 -0500
Received: by mail-it1-f193.google.com with SMTP id e11so14174589itl.5;
        Tue, 06 Nov 2018 05:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aJa39uslkDUb6ZlKvjy0YiDSq1Jj5i1R4upEVx6rLvA=;
        b=bO42Mc3/JMhj226qbuO2s0rsF/I8c4j587reeHxGqUs2TceQxbiQu8QyrBbb4NW9mj
         ljWSrvU8CQxDXeDX08KQogG/+UHOlV0hEl55G/mR1G2v7yIjcVHTZkEM3dsMnX4vS6Tt
         MC2mVDSQceqePNPJXVMVNGKxK+c/dj8OtkT6VORbQuSKHqJ8rSSza9W+kJ7QkMuSkZr2
         c79adG/JOume2MCK4unUp0qNc79cjkwLHSoRBY99ezo51EKR4w0igxXc1QEZO2N/Ll3Q
         TqAleMWYVrqcZ73h5ct8h5NGEA35Ju9lW7UgJD3lJQ/EBl+9U87PUPx9BWmlnObeIMa/
         T8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aJa39uslkDUb6ZlKvjy0YiDSq1Jj5i1R4upEVx6rLvA=;
        b=i4qINjDDOoqKzysF/lTmBcJ38P9/WP2A9CASOCf/UCXT/WQ7QSiHoUtRhKw5Hh+8UO
         /KgWDdr9x0PEVwSuWXXmBhuZuCq11PyJwwbJI69mw0KqZPApAlmS9ypWold5LmuzqUWg
         KLSNnBvWQUj2Mts8vfD66SO64Lp01zx8EQbSP1OQoF7bzWVfcrFlNHtQbqhYvFd6oBvK
         tHHZ8/pJ+qPR6gbcUQwP3bjgiBz2REvq7TCVGg+GsaGoDOyZAIku2mvB7+gCaQcX+tPr
         kyBbDjLeND/XY8Ad/ECFRRTOCF+6i1rPZJR2seJCFYE/c6UwcaTnxeBnyHPCZVNmUcDO
         KFQQ==
X-Gm-Message-State: AGRZ1gKlsseemKyYa4XvwCm0MILSU4SCDN9fnjtYs8IGgDYI8LSoC9l3
        RHgu86u2HJYWHcNZ1vdP104AnSAF8Q+Um/HCEaU=
X-Google-Smtp-Source: AJdET5di1nSimjeQ6Fb5qmyaxobjAND4yhx4uvN61J7iEtOQXzWsoZCBBDtbWufGU+HLSnebJjHx9sIG7D+sJ2xGhG4=
X-Received: by 2002:a02:9b46:: with SMTP id g6-v6mr24262914jal.60.1541509375208;
 Tue, 06 Nov 2018 05:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20181102124535.24331-1-tiny.windzz@gmail.com> <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
 <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
 <12637568.SqdzpTGmKQ@phil> <CAEExFWuP2yX9cFSjStosRZZ2aZOKGtekCg-u8UwqeM1909-Hwg@mail.gmail.com>
In-Reply-To: <CAEExFWuP2yX9cFSjStosRZZ2aZOKGtekCg-u8UwqeM1909-Hwg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 6 Nov 2018 21:02:40 +0800
Message-ID: <CAEExFWuCVzKdvu6VjDxabANV7WqirspBfLSGSVN95LczZfJwCA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     peda@axentia.se, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add myself.
On Tue, Nov 6, 2018 at 9:01 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> Hi Heiko=EF=BC=9A
>
> please=EF=BC=8Ccorrect it in the cimmit message.
>
> --Yangtao
> On Tue, Nov 6, 2018 at 8:01 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Hi Yangtao, Peter,
> >
> > Am Montag, 5. November 2018, 16:59:58 CET schrieb Frank Lee:
> > > I am sorry.
> > > -- Yangtao
> >
> > If anything, it is me that should be sorry, as I did suggest the
> > patch description, including the new spelling error.
> >
> > And it took me like the whole weekend to actually realize where the
> > Calculated / Calculates error was hiding ;-) .
> >
> >
> > Heiko
> >
> > > On Fri, Nov 2, 2018 at 8:58 PM Peter Rosin <peda@axentia.se> wrote:
> > > >
> > > > On 2018-11-02 13:45, Yangtao Li wrote:
> > > > > Fix multiple instances of a misspelled "Calculates".
> > > >
> > > > Yes, it sure is hard to spell "Calcluated," it's almost impossible =
to
> > > > get it completely right and not introduce another typo somewhere...=
 :-)
> > > >
> > > > Cheers,
> > > > Peter
> > > >
> > > > >
> > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > > ---
> > > > > Changes in v2:
> > > > > -add commit message
> > > > > ---
> > > > >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i=
2c-rk3x.c
> > > > > index b8a2728dd4b6..fe347e8e2a23 100644
> > > > > --- a/drivers/i2c/busses/i2c-rk3x.c
> > > > > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > > > > @@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c=
_get_spec(unsigned int speed)
> > > > >   *
> > > > >   * @clk_rate: I2C input clock rate
> > > > >   * @t: Known I2C timing information
> > > > > - * @t_calc: Caculated rk3x private timings that would be written=
 into regs
> > > > > + * @t_calc: Calculated rk3x private timings that would be writte=
n into regs
> > > > >   *
> > > > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too sl=
ow. In that case
> > > > >   * a best-effort divider value is returned in divs. If the targe=
t rate is
> > > > > @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned =
long clk_rate,
> > > > >   *
> > > > >   * @clk_rate: I2C input clock rate
> > > > >   * @t: Known I2C timing information
> > > > > - * @t_calc: Caculated rk3x private timings that would be written=
 into regs
> > > > > + * @t_calc: Calculated rk3x private timings that would be writte=
n into regs
> > > > >   *
> > > > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too sl=
ow. In that case
> > > > >   * a best-effort divider value is returned in divs. If the targe=
t rate is
> > > > >
> > > >
> > >
> >
> >
> >
> >
