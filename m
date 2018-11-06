Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E6AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8DD2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBd5QYPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8DD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbeKFW1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:27:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34363 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388153AbeKFW1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:27:13 -0500
Received: by mail-io1-f66.google.com with SMTP id d80-v6so9154955iof.1;
        Tue, 06 Nov 2018 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J/D1PUOQDZ72q8TeXxDFz0ny/uPyTI6yIErVUyOAiDc=;
        b=tBd5QYPNy0f+m67visIwMdTmsfnGQ5KZCXlbo8R3iAPZGH/3iWXGbTL+gK4vNbj/nv
         x7/qByOV5NzmVrIHaFdryQtiJ9zJQPSF78lADm7sk2fesZ+fThT6NibUrR46l2HPAmKF
         ja5rbJUlEl5+xh2V5J4no8zI0kDMyL5vX3RFZH3C9gwTXbym2Cbd6zDiW0O37J3GRPaN
         Je/8z+o8eOvu+/ZnS/kcOGj8kaNBQRUemF5wXZVtdXvExJ6zqbRZLuAJQC26gSb9F5sA
         BhrWGtiGrQjAUukjcDoqeSHrqwHvutgtVdGKSodHkPZfVPJVeTVOmilTrGZ0T0mcGxUE
         Qrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J/D1PUOQDZ72q8TeXxDFz0ny/uPyTI6yIErVUyOAiDc=;
        b=GIStki/eAuGUntSb/nYDsN3xlPSZCfXbW8Zt3+F2AhtHUkOVP2i8/VvA0KFPizzxef
         eRwcrZ094vECqLFUecj8OPvZCuerGiuVvdvv3K3+KY+YSkhnYLzxBqeHw3Jf7jnJekWf
         bJkBNBAkacLWlkY+/RZpxOyBN1uSC1TkoVYcg/eZ+wdmeskXndIqVoNF7XDmJGSkrcY3
         7rHuDPS1Y3mRD/Ypw3AWvSf3WFl3t7PMWFRqe0Lwx1BrdoQTgsfsEiwNZyTg7fzWspfY
         1nGd7TdFKDShGCtlfi7zbhYm6LWQmY2PbNjBPQYjVPPPWJtX+gNYbOIe9a8uvdDwWU+T
         FS5A==
X-Gm-Message-State: AGRZ1gLAJ86Ls0FToPgrbahVPXmv8jXrabUlZwRvLhcFJ3OkQfM20wtU
        uk5gxu4WGaBTXu4LN5SE6WUxtkolQ5bb8PMKb/w=
X-Google-Smtp-Source: AJdET5dV7lYtl8Sg+pSenlpY/5f+5eyoy37qhLJ167dlqhSlP8CyXv+K2/PfYs6oRhh7Hz7xMfDrLm8qPwZ62pco3zM=
X-Received: by 2002:a6b:bf44:: with SMTP id p65-v6mr19226333iof.225.1541509325560;
 Tue, 06 Nov 2018 05:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20181102124535.24331-1-tiny.windzz@gmail.com> <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
 <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com> <12637568.SqdzpTGmKQ@phil>
In-Reply-To: <12637568.SqdzpTGmKQ@phil>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 6 Nov 2018 21:01:51 +0800
Message-ID: <CAEExFWuP2yX9cFSjStosRZZ2aZOKGtekCg-u8UwqeM1909-Hwg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     peda@axentia.se, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko=EF=BC=9A

please=EF=BC=8Ccorrect it in the cimmit message.

--Yangtao
On Tue, Nov 6, 2018 at 8:01 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Yangtao, Peter,
>
> Am Montag, 5. November 2018, 16:59:58 CET schrieb Frank Lee:
> > I am sorry.
> > -- Yangtao
>
> If anything, it is me that should be sorry, as I did suggest the
> patch description, including the new spelling error.
>
> And it took me like the whole weekend to actually realize where the
> Calculated / Calculates error was hiding ;-) .
>
>
> Heiko
>
> > On Fri, Nov 2, 2018 at 8:58 PM Peter Rosin <peda@axentia.se> wrote:
> > >
> > > On 2018-11-02 13:45, Yangtao Li wrote:
> > > > Fix multiple instances of a misspelled "Calculates".
> > >
> > > Yes, it sure is hard to spell "Calcluated," it's almost impossible to
> > > get it completely right and not introduce another typo somewhere... :=
-)
> > >
> > > Cheers,
> > > Peter
> > >
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > > Changes in v2:
> > > > -add commit message
> > > > ---
> > > >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c=
-rk3x.c
> > > > index b8a2728dd4b6..fe347e8e2a23 100644
> > > > --- a/drivers/i2c/busses/i2c-rk3x.c
> > > > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > > > @@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_g=
et_spec(unsigned int speed)
> > > >   *
> > > >   * @clk_rate: I2C input clock rate
> > > >   * @t: Known I2C timing information
> > > > - * @t_calc: Caculated rk3x private timings that would be written i=
nto regs
> > > > + * @t_calc: Calculated rk3x private timings that would be written =
into regs
> > > >   *
> > > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow=
. In that case
> > > >   * a best-effort divider value is returned in divs. If the target =
rate is
> > > > @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned lo=
ng clk_rate,
> > > >   *
> > > >   * @clk_rate: I2C input clock rate
> > > >   * @t: Known I2C timing information
> > > > - * @t_calc: Caculated rk3x private timings that would be written i=
nto regs
> > > > + * @t_calc: Calculated rk3x private timings that would be written =
into regs
> > > >   *
> > > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow=
. In that case
> > > >   * a best-effort divider value is returned in divs. If the target =
rate is
> > > >
> > >
> >
>
>
>
>
