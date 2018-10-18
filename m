Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CF7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792252145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7cy1afi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792252145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeJRV7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbeJRV7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:59:47 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BBAD2145D;
        Thu, 18 Oct 2018 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539871117;
        bh=QLku2HIGRmxv2Wi3kRTowLIAtGtizSiKdklzJGHrY3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a7cy1afie8qKUW9RhQdCv4dGG333UH0gn6bvSNf4LEsEJK0RfT5XEq/hrDx9d+Zgj
         gyfvTD5hLbWZl+X9xoHJaZfZkb2cT0r/wygcKvtRPNYeUGZBpcJnzPAvFIdofu5840
         wE1xE3oi1cBAfwZqxoWvqB6/0zQR5JnX5/0zc14w=
Received: by mail-qk1-f181.google.com with SMTP id p6-v6so18834581qkg.1;
        Thu, 18 Oct 2018 06:58:37 -0700 (PDT)
X-Gm-Message-State: ABuFfohzQ2qjvYLTCKRQZ9K6q/thlyT7IhYEabx6lxd/u4OpJyGZcfb0
        cPoPyfgXOvGXUqjAmtCWZ1mXSwCVfn1Jq+JL4Q==
X-Google-Smtp-Source: ACcGV62JVfsdVPUrw8RapY6W7WZgi6V7VSTv1sZxbAjH6TTlp9MHlzZ+GeoE89LdlsqPosdVRoi4/ZSQ599pKxl9NIg=
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr27808063qku.184.1539871116514;
 Thu, 18 Oct 2018 06:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181004122855.22981-1-icenowy@aosc.io> <20181004122855.22981-8-icenowy@aosc.io>
 <20181005205855.GA2458@bogus> <92e92f817d4df753d654124514e89c62f40d52eb.camel@aosc.io>
In-Reply-To: <92e92f817d4df753d654124514e89c62f40d52eb.camel@aosc.io>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Oct 2018 08:58:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=YY2K0KPK-fN1O-a3R4o5GwYUZr9wyA2DOaXc29Hh3g@mail.gmail.com>
Message-ID: <CAL_JsqL=YY2K0KPK-fN1O-a3R4o5GwYUZr9wyA2DOaXc29Hh3g@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] dt-bindings: phy: add binding for Allwinner USB3 PHY
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 9:42 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> =E5=9C=A8 2018-10-05=E4=BA=94=E7=9A=84 15:58 -0500=EF=BC=8CRob Herring=E5=
=86=99=E9=81=93=EF=BC=9A
> > On Thu, Oct 04, 2018 at 08:28:52PM +0800, Icenowy Zheng wrote:
> > > The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> > > external USB3 pins of the SoC.
> > >
> > > Add a device tree binding for the PHY.
> > >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > > Changes in v4:
> > > - Changed Vbus regulator property to vbus-supply.
> > >
> > > Changes in v3:
> > > - Added Chen-Yu's Review tag.
> > >
> > > No changes in v2, v1.
> > >
> > >  .../bindings/phy/sun50i-usb3-phy.txt          | 23
> > > +++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-
> > > usb3-phy.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-
> > > phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> > > new file mode 100644
> > > index 000000000000..9f49c6b8c7e7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> > > @@ -0,0 +1,23 @@
> > > +Allwinner sun50i USB3 PHY
> > > +-----------------------
> > > +
> > > +Required properties:
> > > +- compatible : should be one of
> > > +  * allwinner,sun60i-h6-usb3-phy
> > > +- reg : a list of offset + length pairs
> > > +- #phy-cells : from the generic phy bindings, must be 0
> > > +- clocks : phandle + clock specifier for the phy clock
> > > +- resets : phandle + reset specifier for the phy reset
> > > +
> > > +Optional Properties:
> > > +- vbus-supply : a phandle to a regulator that provides power to
> > > VBUS.
> >
> > This belongs in a connector node as it is part of the connector
> > unless
> > the phy physically needs Vbus for power.
> >
> > But others have done this, so all the phys can just be wrong...
>
> How should we reference the connector?
>
> Via OF graph or simply a property in PHY node?

The connector is either a child of the controller or an OF graph from
the controller to the connector. The phy driver needs the controller
node and then it can walk the tree or graph to get the connector node.

Rob
