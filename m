Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC6AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068932184A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeJdjmNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfAJJGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:06:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35307 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfAJJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:06:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so6188751qka.2;
        Thu, 10 Jan 2019 01:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jfs+rzTidtMyumH+OS/GBx8nnTMoGUK7aMVU9LHarpA=;
        b=LeJdjmNa6q+yoc0QT3O2fniRN9nWkd/9+xhSmEBOu5Y2ySK8t4iXdOsWNnyohJD2lO
         HqvLsbyiU7RTf5pgjyiJD84xBsJk8p0/t0vCdJtPg5/SfMCeZCjgWHQtX4yWSqSajSZu
         WjPlXYTCwcF41Eync8xqwS1vuCNIKyyjNY4g7cmMM48kRJFT/KnXZh4f4adlvPFjteb7
         6vUy8BLn0fqDqR4pIQ/gHHcmDug6z7rUgynPGnCugrZ6oW/A3uwUnrajt+z/8sT6Lnz2
         0Msswb6wtVG1tN2Znwyv4tNNjxGazcl/u45k12iESJFhRn9cH+yLG0gMNTmv/snXydhE
         x/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jfs+rzTidtMyumH+OS/GBx8nnTMoGUK7aMVU9LHarpA=;
        b=qn3NAYU1U7ivLtd8Tk+V79TTzyiVrvZjcGjrjWxUvpe6+YYF7+pFvWHokiaEyN51tN
         cDTDcum4V/YFWwiS9Kw4JLl0YRXhjL3x//DWPk6Eu9yGYLMdvd73igAEKmoO0FK/tPLP
         Jh9XWS1IL3pHpNzu7WfloKemsUYlps2c5Vdgj/c5xYvmq1KY/08z2928kwawSEq3k4I8
         XjCPPOoTRFAyFqEg31SLyf1vuEeZzhc2JtBBwJ2zXv3zUo+uoi5AcyFOCYZEh1jQI9bz
         kZrrpxr8i5sO6o219eSuACmI8k6XJsqLwU9rIefmWBIpqLi8S/gWxc4K22YwUAIVnky2
         SiYw==
X-Gm-Message-State: AJcUuke01LRjRLv8GIohT0ezY3utVbxvSP0QnejwLUV2pFKcLyB/jYMS
        7HPAwLrQflJvNur3MS5pGaKFixGcFZYVDIQPj+c=
X-Google-Smtp-Source: ALg8bN4wPzkGRJo/RPu6BUHRdkfm08vznK2rgdxrrMbEOrPG6TEdVwGUkMs1koW5LyVy/quhuxTBHgrxIpJ7WAqyRJs=
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr8282533qkl.160.1547111209372;
 Thu, 10 Jan 2019 01:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-5-enric.balletbo@collabora.com> <20180815222604.GB8193@rob-hp-laptop>
In-Reply-To: <20180815222604.GB8193@rob-hp-laptop>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 10 Jan 2019 10:06:38 +0100
Message-ID: <CAFqH_538JF7gmpQzgyShw-8nhUEtkVrGQ6vjkdc5neJd8JCAOQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new
 rockchip,force-bvalid property.
To:     Rob Herring <robh@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Wang <frank.wang@rock-chips.com>,
        kieran.bingham@ideasonboard.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Missatge de Rob Herring <robh@kernel.org> del dia dj., 16 d=E2=80=99ag. 201=
8 a les 0:26:
>
> On Wed, Aug 15, 2018 at 11:59:34AM +0200, Enric Balletbo i Serra wrote:
> > This property is used when the otg-id pin is not connected. When this
> > property is set it forces to set the B-Device Session Valid bit when th=
e
> > port works as device and clears that bit when the port works as host.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt       | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-us=
b2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> > index 2d4808d3920b..55761f466c41 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> > @@ -48,6 +48,11 @@ Optional properties:
> >               See ./phy-bindings.txt for details.
> >   - rockchip,utmi-avalid : boolean, use the avalid register to get vbus=
 status.
> >                         Otherwise, use the bvalid register.
> > + - rockchip,force-bvalid : boolean, set this to force the B-Device Ses=
sion
> > +                       Valid bit when the usb port is in device mode. =
This
> > +                       is used when the otg-id pin is not connected.
> > +                       Only supported in case of compatible being:
> > +                       * "rockchip,rk3399-usb2phy"
>
> Shouldn't you describe the property of the h/w that ID pin is not
> connected, rather than what you do with that information.
>

What about "rockchip, otg-id-not-connected"?

> Is the pin not connected because it's a connector without ID pin? If so,
> that should be a property of the connector (or inferred from the
> connector compatible string).
>

No, it's not the connector. it is not wired on the phy and the cable
detection is done via an extcon.

Thanks,
 Enric

> Rob
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
