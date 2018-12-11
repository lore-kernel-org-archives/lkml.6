Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B059FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7800A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544541528;
	bh=zk88PNm93vOrQRJuhmKV7k46NfJeGzn5XGA9gnCTq4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xz+hOTswCECNWmv24crw2MF+o4TngjUvYrI0c6j3Q0K1AiRI+EIfmOxZX13vPbhZA
	 eogNT6wxa0YXush37dVEKfcEj8VDZsH2ZGW7kOWWNSAAZ5UpjsRlXoiR1KJpZqJ5Uy
	 7WI0bZoJ2U637rtk6/t25I0YxXSSpPf9hNmhDfd4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7800A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeLKPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeLKPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:18:47 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E395520851;
        Tue, 11 Dec 2018 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544541526;
        bh=zk88PNm93vOrQRJuhmKV7k46NfJeGzn5XGA9gnCTq4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f35GcSP7stgx6SclvEjSCP7hqZtcJ42c6FDpL0JQynd4kPGOhKeXAnGpDxd0pNxyH
         DMfBk0oqt1/akgssgYSTdol3q+7kCsqCu7qxMhqoucV2wbdN/ZE06oR6E7PdITOo/k
         K+NuppVrDlB4egh8qo6IQS+eHx7heP/mG7iZ+kFQ=
Received: by mail-qk1-f173.google.com with SMTP id y16so8777279qki.7;
        Tue, 11 Dec 2018 07:18:45 -0800 (PST)
X-Gm-Message-State: AA+aEWZc8fz3w7miI2oT4thGCsAcnI/5jipzOKLpmlUXAPZipc6a6m1U
        dJ2B57EkqPNzrIts1DVnU/yDXmJcSlpKH/Y36g==
X-Google-Smtp-Source: AFSGD/WI5yD91yt9GqhL/iY1sQifQIMa4uTENA3yixv9s43AO6E7k4c6tCBxQPLbW02djjfpX1UAq7QNSXWnqNSDOa8=
X-Received: by 2002:a37:7682:: with SMTP id r124mr15036944qkc.79.1544541525112;
 Tue, 11 Dec 2018 07:18:45 -0800 (PST)
MIME-Version: 1.0
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
 <20181210232358.GA11621@bogus> <DB3PR0402MB3916E1651ABC07F6F788B265F5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E1651ABC07F6F788B265F5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Dec 2018 09:18:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sP_fsQaoT6FpZNRxjhPAhCcE8e-0xffUUxShcC2LuHw@mail.gmail.com>
Message-ID: <CAL_Jsq+sP_fsQaoT6FpZNRxjhPAhCcE8e-0xffUUxShcC2LuHw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 7:40 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rob
>
> Best Regards!
> Anson Huang
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 2018=E5=B9=B412=E6=9C=8811=E6=97=A5 7:24
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: jic23@kernel.org; knaack.h@gmx.de; lars@metafoo.de;
> > pmeerw@pmeerw.net; mark.rutland@arm.com; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update p=
ower
> > supply name
> >
> > On Mon, Dec 10, 2018 at 07:11:19AM +0000, Anson Huang wrote:
> > > According to datasheet, the isl29018 has "vddd/vdda" power supply, an=
d
> > > isl29023/isl29035 ONLY has "vdd" power supply, update the power suppl=
y
> > > name with "vdd" and "vdda" according to datasheet to cover all device=
s
> > > and avoid confusion.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/light/isl29018.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.txt
> > > b/Documentation/devicetree/bindings/iio/light/isl29018.txt
> > > index b9bbde3..36f737d 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/isl29018.txt
> > > +++ b/Documentation/devicetree/bindings/iio/light/isl29018.txt
> > > @@ -15,7 +15,9 @@ Optional properties:
> > >    Refer to interrupt-controller/interrupts.txt for generic interrupt=
 client
> > >    node bindings.
> > >
> > > -  - vcc-supply: phandle to the regulator that provides power to the =
sensor.
> > > +  - vdd-supply: phandle to the regulator that provides vdd power to =
the
> > sensor.
> > > +
> > > +  - vdda-supply: phandle to the regulator that provides vdda power t=
o the
> > sensor.
> >
> > Is this in use? You can't just change things if it is.
>
> I did NOT see any "vcc" in folder drivers/iio/light/, so I think it is NO=
T used at all,
> so I take this chance to update it according to datasheet. Thanks.

arch/arm/boot/dts/exynos5420-peach-pit.dts-629- light-sensor@44 {
arch/arm/boot/dts/exynos5420-peach-pit.dts:630:         compatible =3D
"isil,isl29018";
arch/arm/boot/dts/exynos5420-peach-pit.dts-631-         reg =3D <0x44>;
arch/arm/boot/dts/exynos5420-peach-pit.dts-632-         vcc-supply =3D
<&tps65090_fet5>;
arch/arm/boot/dts/exynos5420-peach-pit.dts-633- };

arch/arm/boot/dts/exynos5800-peach-pi.dts-629-  light-sensor@44 {
arch/arm/boot/dts/exynos5800-peach-pi.dts:630:          compatible =3D
"isil,isl29018";
arch/arm/boot/dts/exynos5800-peach-pi.dts-631-          reg =3D <0x44>;
arch/arm/boot/dts/exynos5800-peach-pi.dts-632-          vcc-supply =3D
<&tps65090_fet5>;
arch/arm/boot/dts/exynos5800-peach-pi.dts-633-  };

The rest of the dts files using this don't have a supply it seems. So
you need permission from the Exynos folks if you want to just drop
this. And also update their dts files.

Rob
