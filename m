Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E9D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC+sV6vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E9D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbeGMI2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:28:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46524 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbeGMI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:28:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so10902815qtn.13;
        Fri, 13 Jul 2018 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3h9/vTeBonAFp2MiOshzOvIQ4qO3rvlbvosXXHdiyNY=;
        b=eC+sV6vkjkIFzr+IqXvtx/gF/G+1iO4y0kLUOTtP8cq5Pb3VucG9W26TKQHsn+cZEI
         C6t566/2v/VaOyAw/I6q+1yhJyCoUjFx1NxD3O/hUvtwFDYpRnRlD11nH+fMMCZv4NB0
         Rj0Jm6DDfqxqv3/7STHQhECt80oygAJMLl4oylrxf+Kg2qjyZSvdRsM/fqIA/kiTUZGy
         Zx8Sx88Rjv938kcQJxDsl9FCuIocv+s04zMpmw8keO5VWLvfc72L9ySS/E9RHO10uGbG
         2MDX3v2krHpcb/HPWCdxz3JWVljLkCFkFiLmUklSWtuxxgdbWqWnjmwH07FmKdZ700rV
         JmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3h9/vTeBonAFp2MiOshzOvIQ4qO3rvlbvosXXHdiyNY=;
        b=BViMrl8zywLEChReAOv/w8bINxAn1DzW/cg+AEiUzEDtB3c0/h+wcSkjPcq6LhHzGk
         APP9f+fK1oZFhpkTrfGrFNb+iKHUg1/k26IMNXZYXDDr6bIUCFIZ2owgy8TdCOVv/YHr
         Fd7qliUsi3rDKnkpEij5E0nh3NN+mwy42AOIo5AWlr76GGTzkSx6db1cERW8vp7J/Qda
         cyiUQENOD0ep+H7oCzpIuCi7iibrSLOuwu3P7IOepww+ttnXKazJEPIZhcc/scjJRz9H
         Q3uWrdb8mu1vAAQobqbUeSs7rop5FoMy33DtaY703IZF6M8wr5LLoSFUeuDcHBRkNucR
         Xvng==
X-Gm-Message-State: AOUpUlFQ3Wxb3hqSfWt26D2k7ZBYADnFpYbly8w+ROvECDWK/yfENkPP
        jhdFbb5654U5KZNwz1Ik8WDYT00QbBExhzrDiOo=
X-Google-Smtp-Source: AAOMgpdhokyxtCz3x5K5CCfKja+FOCBGA8PKamV0KFsY0ITgchCcPBl3aind55K1m4gp4xDthWWI1quMUSPrLgpdtn4=
X-Received: by 2002:ac8:3579:: with SMTP id z54-v6mr4632963qtb.161.1531469711056;
 Fri, 13 Jul 2018 01:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180709150844.32505-1-enric.balletbo@collabora.com>
 <536642654ca55f08877497c86a5cb106d5458384.camel@collabora.com> <d9ea42a39a80c12b9d5730376d2f8e5a953771ef.camel@collabora.com>
In-Reply-To: <d9ea42a39a80c12b9d5730376d2f8e5a953771ef.camel@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 13 Jul 2018 10:14:59 +0200
Message-ID: <CAFqH_51EvuJmU2rxcndWdyYj6CAhzDv_o6YPnUHJb6ctM+k8VQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: of-simple: reset host controller at suspend/resume
To:     ezequiel@collabora.com
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>, kernel@collabora.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Missatge de Ezequiel Garcia <ezequiel@collabora.com> del dia dt., 10
de jul. 2018 a les 0:10:
>
> Sigh, now actually Cc devicetree folks
>
> On Mon, 2018-07-09 at 19:04 -0300, Ezequiel Garcia wrote:
> > (Cc devicetree folks)
> >
> > Hi Enric,
> >
> > Thanks for the patch.
> >
> > On Mon, 2018-07-09 at 17:08 +0200, Enric Balletbo i Serra wrote:
> > > If we power off the SoC logic rail in S3, we can find that the
> > > Type-C
> > > PHY can't initialize correctly after system resume. We need to
> > > toggle
> > > the USB3-OTG reset before trying to initialize the PHY, or else it
> > > times out.
> > >
> > >     phy phy-ff800000.phy.9: phy poweron failed --> -110
> > >     dwc3 fe900000.dwc3: failed to initialize core
> > >     dwc3: probe of fe900000.dwc3 failed with error -110
> > >
> > > Note that the RK3399 TRM suggests that we should keep the whole
> > > usb3
> > > controller in reset for the duration of the Type-C PHY
> > > initialization.
> > > However, it's hard to assert the reset in the current framework of
> > > reset. We're still skeptical about that, and we haven't yet found a
> > > case where this seems to have mattered. This approach is much
> > > easier,
> > > it
> > > simply holds the USB3-OTG reset while device is supended.
> > >
> > > The dwc3 core is going to reinitialize the controller at
> > > suspend/resume
> > > anyway (including a "soft reset"), so it should be safe to do this.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
> > > >
> > > ---
> > > Dear all,
> > >
> > > Now that the usb3-phy otg port support for rk3399 has been merged
> > > [1]
> > > we
> > > found that suspend/resume is broken. The problem is well known for
> > > ChromeOS kernels, they solved it in a similar way adding a reset
> > > pulse on
> > > resume in the specific usb glue layer (dwc3-rockchip). In mainline,
> > > though, we use the dwc3-of-simple glue layer instead of a specific
> > > layer
> > > for rockchip. The patch is based on the Brian Norris work but
> > > slightly
> > > different, it holds the reset while device is suspended. It was
> > > tested
> > > on a Samsung Chromebook Plus with usbc docking station attached by
> > > doing
> > > different suspend/resume cycles and checking no usb devices has
> > > been
> > > lost.
> > >
> > > I am not sure this is the better way to solve this but I did not
> > > find
> > > any other way, and, as I am not sure this can be generic, the reset
> > > is only
> > > done on rockchip platforms.
> > >
> >
> > I don't really understand why there are per-platform hacks in glue
> > drivers, instead of having per-platform glue drivers, or some other
> > pluggable hooks.
> >
> > > Best regards,
> > >  Enric
> > >
> > > [1] bfdca1736ea76345071bbc5607d18928e54909ac ('arm64: dts:
> > > rockchip:
> > > add
> > >     usb3-phy otg-port support for rk3399')
> > >
> > >  drivers/usb/dwc3/dwc3-of-simple.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c
> > > b/drivers/usb/dwc3/dwc3-of-simple.c
> > > index dbeff5e6ad14..1d1ece99ed94 100644
> > > --- a/drivers/usb/dwc3/dwc3-of-simple.c
> > > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> > > @@ -201,9 +201,30 @@ static int
> > > dwc3_of_simple_runtime_resume(struct
> > > device *dev)
> > >
> > >     return 0;
> > >  }
> > > +
> > > +static int dwc3_of_simple_suspend(struct device *dev)
> > > +{
> > > +   struct dwc3_of_simple *simple = dev_get_drvdata(dev);
> > > +
> > > +   if (of_device_is_compatible(dev->of_node,
> > > "rockchip,rk3399-
> > > dwc3"))
> > >
> >
> > Instead of calling of_device_is_compatible in each suspend/resume,
> > which seems quite expensive, how about having a per-device boolean
> > 'needs_reset' or something like that?
> >
Yep, not sure how much, but probably use a boolean will be faster. I
am also wondering if we can remove the of_device_is_compatible call
and do the reset on all platforms. This will need lots of tests on
different platforms, of course. i'd like to hear maintainers feedback
here.

> > Or maybe just have a boolean devicetree property for this?

I don't think moving the "hack" to the devicetree will be acceptable
for the DT maintainers, this is not really a hardware property.

Thanks,
  Enric.

> >
> > Regards,
> > Eze
> >
