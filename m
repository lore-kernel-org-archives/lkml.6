Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9796FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71286214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfAJMbt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:31:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54834 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfAJMbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:31:49 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ghZUs-00035U-Mx; Thu, 10 Jan 2019 13:31:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new rockchip,force-bvalid property.
Date:   Thu, 10 Jan 2019 13:31:41 +0100
Message-ID: <4750582.8aBUlXA8d6@phil>
In-Reply-To: <CAFqH_538JF7gmpQzgyShw-8nhUEtkVrGQ6vjkdc5neJd8JCAOQ@mail.gmail.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <20180815222604.GB8193@rob-hp-laptop> <CAFqH_538JF7gmpQzgyShw-8nhUEtkVrGQ6vjkdc5neJd8JCAOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,
Am Donnerstag, 10. Januar 2019, 10:06:38 CET schrieb Enric Balletbo Serra:
> Missatge de Rob Herring <robh@kernel.org> del dia dj., 16 d’ag. 2018 a les 0:26:
> >
> > On Wed, Aug 15, 2018 at 11:59:34AM +0200, Enric Balletbo i Serra wrote:
> > > This property is used when the otg-id pin is not connected. When this
> > > property is set it forces to set the B-Device Session Valid bit when the
> > > port works as device and clears that bit when the port works as host.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > >  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt       | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> > > index 2d4808d3920b..55761f466c41 100644
> > > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> > > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> > > @@ -48,6 +48,11 @@ Optional properties:
> > >               See ./phy-bindings.txt for details.
> > >   - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
> > >                         Otherwise, use the bvalid register.
> > > + - rockchip,force-bvalid : boolean, set this to force the B-Device Session
> > > +                       Valid bit when the usb port is in device mode. This
> > > +                       is used when the otg-id pin is not connected.
> > > +                       Only supported in case of compatible being:
> > > +                       * "rockchip,rk3399-usb2phy"
> >
> > Shouldn't you describe the property of the h/w that ID pin is not
> > connected, rather than what you do with that information.
> >
> 
> What about "rockchip, otg-id-not-connected"?

just pointing back to our discussion in patch3 about simply assuming
id-not-connected in the case of the extcon missing

I still think that might be the cleaner variant? But I guess you're
probably already looking into doing that as so far you only resend the
cleanup patches :-) .


Heiko


