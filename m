Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5F3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD33520877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHgvngSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD33520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbeIUCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:11:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40147 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeIUCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:11:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so9545008lfi.7;
        Thu, 20 Sep 2018 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7m4fgNUFUZcU6rD+5/h3g+cP9IV1XVtOYpRE7l2Y/kM=;
        b=NHgvngSaJpDYpNamXlWovVh5aA16iDGw2kJ97HVf7gFzquIQEdz0s877qJM1kl9m3C
         EMfcQi+7N8iWNQBI59w4cVU5E3Qo7JkKY8YCh1737SwN7uMbx5ZYCI71A6IuFJF7tjyH
         +9hBofpWhDQJilMvgIjyD84Wze1PHLOzus6+IF2E+4BHH5MmjkLCHsTv5UgOo7cb/wAW
         mA/XwEkEfAnaz6a5vsIUPtN/Z8TGAOpo5S2VhtzO45nx2y0znpH2nmfODi8h/ku9jqIB
         J3wYfxXQIF7VOAiOqviN9tEjjdJLwfGdqQt9ixpYEGCPgtgiBtpn9H33130G+/38ApmG
         /jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7m4fgNUFUZcU6rD+5/h3g+cP9IV1XVtOYpRE7l2Y/kM=;
        b=kyIuPfn4d4RJm95AwWvhyQlgO1TXVXRl0s0SpHIoiCrqUSuv1o+chDAdbkEsi00ttD
         +8vQNHsjIZ0y02Be3IcK/uRyIpSW4pKlGEc0WoCI3JHlhLyfqQY1ZzAD6qjWd84OtTu9
         xnsiMfqGpvEazCvkfg91fr2PS8hSuerYf908mEzaVAUpSXY03zCIL8hidA057orPqZDg
         EbkSncgFcHH9pAICys/VRyEKTcu657exOymu3meaEQbyjA7Bor/d7GUmpSX/GNPZbM7l
         wNGass008JXL+T3yhAYcP5tvkB8tnTuakm2NOLqe51or7xm7tHXwY6bxYVVX0t14uHAY
         iF4g==
X-Gm-Message-State: APzg51BgfbruTdXshZXsaGcTWflZzHXyZj+Mj9cHPgPxyPBe2Uw1Aidi
        mjzrawKJlzxGd8JBscqm5Wp4S+vFF0R+mHhv7cs=
X-Google-Smtp-Source: ANB0VdbLehSAiNm4+NU71bOtujj3gayRqTKXi82kDYui6+1IxfM3PFfwbhPc7HbzcvZg2DFoUGXGSVpCcXGjfOwla0U=
X-Received: by 2002:a19:4e51:: with SMTP id c78-v6mr13539648lfb.79.1537475171206;
 Thu, 20 Sep 2018 13:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
 <20180920161912.17063-3-ricardo.ribalda@gmail.com> <1939782.bRt5jKDIiS@avalon>
 <2983018.WjSXnZMEY4@avalon>
In-Reply-To: <2983018.WjSXnZMEY4@avalon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 22:25:54 +0200
Message-ID: <CAPybu_2Ke7qAx=3LRX6aEbGSD56Z+RhWKX=gEXR6WCgyOegxEw@mail.gmail.com>
Subject: Re: [PATCH 3/4] [media] ad5820: DT new optional field enable-gpios
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Thu, Sep 20, 2018 at 10:23 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thursday, 20 September 2018 23:21:28 EEST Laurent Pinchart wrote:
> > Hi Ricardo,
> >
> > Thank you for the patch.
> >
> > On Thursday, 20 September 2018 19:19:11 EEST Ricardo Ribalda Delgado wrote:
> > > Document new enable-gpio field. It can be used to disable the part
> > > without turning down its regulator.
> > >
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > > ---
> > >
> > >  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> > > 5940ca11c021..07d577bb37f7 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > >
> > > @@ -8,6 +8,11 @@ Required Properties:
> > >    - VANA-supply: supply of voltage for VANA pin
> > >
> > > +Optional properties:
> > > +
> > > +   - enable-gpios : GPIO spec for the XSHUTDOWN pin.
> >
> > xshutdown is active-low, so enable is active-high. Should this be documented
> > explicitly, to avoid polarity errors ? Maybe something along the lines of
> >
> > - enable-gpios: GPIO spec for the XSHUTDOWN pin. Note that the polarity of
> > the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable
> > GPIO deasserts the XSHUTDOWN signal and vice versa).

Agreed

>
> Or alternatively you could name the property xshutdown-gpios, as explained in
> my (incorrect) review of 2/4.

I have double negatives :). If there is no other option I will rename
it xshutdown, but I want to give it a try to enable.

>
> > > If specified, it will be
> > > +     asserted when VANA-supply is enabled.
> >
> > That documents a driver behaviour, is it needed in DT ?
> >
> > >  Example:
> > >         ad5820: coil@c {
> > >
> > > @@ -15,5 +20,6 @@ Example:
> > >                 reg = <0x0c>;
> > >                 VANA-supply = <&vaux4>;
> > >
> > > +               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> > >         };
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>


-- 
Ricardo Ribalda
