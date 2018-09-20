Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E70ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39221534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQgA1Cr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD39221534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbeIUCR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:17:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39258 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:17:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id v77-v6so9549544lfa.6;
        Thu, 20 Sep 2018 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yT5h2jAUVnEA0Ph8YFEQuTsu8rDVljJ0Qg3iIqhGBmE=;
        b=dQgA1Cr9rZwWUloguA6afQFgjXNGKsy2Hgbgt8ecTn/cx+JLIejpXGM/PoMtzqKMeQ
         wXBlm6HT/8VEeNNB/SwlQCQtdLzVYsY6a3K9y6Aq/UjXg/SAqdSRsXpBM9Z+mh/EdA0a
         t1RPGkOJReMP/kx13H9hfjdhBEfRh69gzJ6FyKX6aV4PZdAgUdv8oGEKnbho8Yu6fbhl
         mae+4aIK7uXPG5krynePbZzcSV9JUNYT2MI+TWL2LfxoAdpROLj2Qknt+nS4T68YR1yy
         0gAvNcucKqoBGP8CmbTt++gWrRvxcyFh3rUo1Z1CWPo21kA8GreP7b5/ZCKcBbzRX+U0
         Vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yT5h2jAUVnEA0Ph8YFEQuTsu8rDVljJ0Qg3iIqhGBmE=;
        b=kuYlw4lkIHk88T9Pu2w7YhPmjC3SQA7jZ9dyAUOwh21Wf4M1IEaMq7z3kOM1CANPf1
         SlVhm+sdjKGM+hrhEuXXD7/EVpjixXFnv61dp9LalzdKXvnuuki7xEYhWYg2/xHUMW+z
         0KGLI7LQvK2s8sr2ecJIfWjiLZ1GGWOHWRgbvVZJ1yUuBNxWXhHd06TqfrRIUmMM9M36
         5kEWverz70EVSI2NQU7GvKYXq9+yvNqrRlLabuO80nPsnyb1NleNkdXzR8FYH30feZr7
         paP8GyjYtODcdmCBJ0cjC4FAW0RsfPqbN7ouvAseY/S5QP0CfJEGLhyh+OkuyM+D7WS0
         bDlw==
X-Gm-Message-State: APzg51AJChsrReD9Wu5WSmwHKI+fZVmupX8tbHliAEbyKsLNezaQRWcB
        OYsmy2WEIoaCUwNn7WMKJJ2Q/5EVj1pGsRdOjMDLqYR4
X-Google-Smtp-Source: ANB0VdbjRUI+gw2TfJYlmFGy6BCBRHTxepBIZ4Wa5ZSkti3lGBH8wAZGDzNGBifbMdMUHjkL1Pmo7cXCMA9VNHGPv9Q=
X-Received: by 2002:a19:d189:: with SMTP id i131-v6mr156211lfg.20.1537475560478;
 Thu, 20 Sep 2018 13:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
 <20180920184552.4919-1-ricardo.ribalda@gmail.com> <20180920185405.GA26589@amd>
 <CAPybu_2hjrq=r+kpAHKxX59gOXfbqGf9CUPh9CNqv7WGqJsrQQ@mail.gmail.com>
 <20180920190855.GC26589@amd> <CAPybu_2mNE7Jmfm2n60Z9Hk_iO+-zLgtu4xn72pJUSXBitVg=g@mail.gmail.com>
 <20180920201420.GA28766@amd> <20180920202122.GA30748@amd>
In-Reply-To: <20180920202122.GA30748@amd>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 22:32:23 +0200
Message-ID: <CAPybu_1w+VWkOZDKSyEBHvcdGAF1wzoFDunUgDLTn7tqP8Dhbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] [media] ad5820: Add support for enable pin
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Thu, Sep 20, 2018 at 10:21 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > > ad5820: dac@0c {
> > > > >    compatible = "adi,ad5820";
> > > > >    reg = <0x0c>;
> > > > >
> > > > >    VANA-supply = <&pm8994_l23>;
> > > > >    enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> > > > > };
> > > >
> > > > Well, I'm sure you could have gpio-based regulator powered from
> > > > pm8994_l23, and outputting to ad5820.
> > > >
> > > > Does ad5820 chip have a gpio input for enable?
> > >
> > > xshutdown pin:
> > > http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf
> > >
> > > (AD5820,AD5821, and AD5823 are compatibles, or at least that is waht
> > > the module manufacturer says :)
> >
> > Aha, sorry for the noise.
> >
> > 2,3: Acked-by: Pavel Machek <pavel@ucw.cz>
>
> And I forgot to mention. If ad5821 and ad5823 are compatible, it would
> be good to mention it somewhere where it is easy to find... That can
> save quite a bit of work to someone.
>

For the ad5821 I have the datasheet and I would not mind adding it
For the ad5823 I have no datasheet, just a schematic from a camera
module saying: you can replace ad5823 with ad5821.

I think I will add this as an extra patch

> Thanks,
>                                                                 Pavel
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Ricardo Ribalda
