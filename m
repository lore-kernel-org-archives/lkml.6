Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95568C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0F2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="X+dNQ91T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E0F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeGYKQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:16:00 -0400
Received: from mail.blih.net ([212.83.177.182]:61455 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbeGYKQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:16:00 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id 4e33ceb6;
        Wed, 25 Jul 2018 11:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=8MQEnb0psQc2U5Xpk2jD5cQmU6E=; b=X+dNQ91TNESZ/i7VNtHRwEQQ6fBt
        YpNszKK5oNuhM6k90Hj2N399ZG4VEQ/qHl3hrcbxtaqU3e+r/6tgyK8hfgnnFjlV
        bBf72oMiXIAWekZiv/XmCpIG13EeR/RDbdBC7TXHFJFEaY5jrc3XSejXssovVdZ6
        SoJETf5Nwm15Dgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=gQXuXHg7LQiyfPZnfrZVJjW6P/D39HdbNISp+yoIJVz2MmV+hmOxlZ1D
        RGkOZm2AWhlxY/nskBg3lv8eB3Avkc3Wxe7zkuTroKdo1yEzsDLg0td9rDF7F/dL
        Zpi50y46QFSnZ9oDdTk9CGh6izhrAYuCcbLEHQaozo0EbqQF02g=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id a496a339
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Wed, 25 Jul 2018 11:05:12 +0200 (CEST)
Date:   Wed, 25 Jul 2018 11:05:12 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     embed3d@gmail.com, Kyle Evans <kevans@freebsd.org>,
        icenowy@aosc.io, Mark Rutland <mark.rutland@arm.com>,
        sean@mess.org, linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        clabbe.montjoie@gmail.com, pmeerw@pmeerw.net, lee.jones@linaro.org,
        lars@metafoo.de, edu.molinas@gmail.com,
        Russell King <linux@armlinux.org.uk>, krzk@kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
        rask@formelder.dk, devicetree <devicetree@vger.kernel.org>,
        mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        singhalsimran0@gmail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        quentin.schulz@free-electrons.com, knaack.h@gmx.de,
        davem@davemloft.net, jic23@kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable
 H3 sid controller
Message-Id: <20180725110512.b6fb81be76f66b07942e5af0@bidouilliste.com>
In-Reply-To: <39b1eef01c2ed32f09ef30439c4f4297de009898.camel@paulk.fr>
References: <20180128232919.12639-1-embed3d@gmail.com>
        <20180128232919.12639-15-embed3d@gmail.com>
        <20180129095200.attg7cgvpifpchtn@flea.lan>
        <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
        <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
        <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
        <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
        <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
        <39b1eef01c2ed32f09ef30439c4f4297de009898.camel@paulk.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 19:19:54 +0200
Paul Kocialkowski <contact@paulk.fr> wrote:

> Hi,
>=20
> Le vendredi 20 avril 2018 =E0 11:35 +0200, Philipp Rossak a =E9crit :
> > Hi Kyle,
> >=20
> > I'm already working on a Version 3 of this patch series. Right now this=
=20
> > slowed down since I'm very busy and the ToDo-List is still very long.
> >=20
> > My plan is to send out a version during this release cycle.
> >=20
> > If you need it right now feel free to submit patches!
>=20
> I just came around this patch while testing SID support for H3, that is
> not enabled in the dts at this point despite driver support.
>=20
> Maxime, would it make sense to merge this patch as-is, without support
> for the thermal calibration section, since the two aspects seem rather
> independent (and some other SoCs also have a SID node without linkage
> for thermal support anyway)?
>=20
> Cheers,
>=20
> Paul

 Hello Paul,

 I've sent a serie yesterday for SID on A64/H3/H5.
 https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D761

 Cheers,

> > Philipp
> >=20
> > On 19.04.2018 17:19, Kyle Evans wrote:
> > > On Thu, Apr 19, 2018 at 10:13 AM, Icenowy Zheng <icenowy@aosc.io> wro=
te:
> > > >=20
> > > >=20
> > > > ? 2018?4?19? GMT+08:00 ??11:11:22, Kyle Evans <kevans@freebsd.org> =
??:
> > > > > On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.co=
m>
> > > > > wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 29.01.2018 10:52, Maxime Ripard wrote:
> > > > > > >=20
> > > > > > > On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrot=
e:
> > > > > > > >=20
> > > > > > > > This patch enables the the sid controller in the H3. It can=
 be used
> > > > > > > > for thermal calibration data.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > > > > > > ---
> > > > > > > >    arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> > > > > > > >    1 file changed, 7 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > index 3f83f6a27c74..9bb5cc29fec5 100644
> > > > > > > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > @@ -72,6 +72,13 @@
> > > > > > > >                  };
> > > > > > > >          };
> > > > > > > >    +     soc {
> > > > > > > > +               sid: eeprom@1c14000 {
> > > > > > > > +                       compatible =3D "allwinner,sun8i-h3-=
sid";
> > > > > > > > +                       reg =3D <0x01c14000 0x400>;
> > > > > > > > +               };
> > > > > > > > +       };
> > > > > > > > +
> > > > > > >=20
> > > > > > >=20
> > > > > > > Shouldn't you also use a nvmem-cells property to the THS node?
> > > > > > >=20
> > > > > > > Maxime
> > > > > > >=20
> > > > > >=20
> > > > > > Oh seems like I forgot that.
> > > > > > As related to the wiki [1] this should be 64 bit wide at the ad=
dress
> > > > >=20
> > > > > 0x34. I
> > > > > > will add that in the next version.
> > > > > >=20
> > > > > >=20
> > > > > > [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
> > > > > >=20
> > > > > > Thanks,
> > > > > > Philipp
> > > > > >=20
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > Any chance this will see a v3 soon? I'm kind of interested in sid=
 node
> > > > > for h3. =3D)
> > > >=20
> > > > This patch is independent and can be easily sent out
> > > > by its own.
> > > >=20
> > >=20
> > > Right- I had considered doing so, but wanted to make sure I wasn't
> > > going to collide with this series if a v3 is imminent.
> > >=20
> >=20
> >=20
> --=20
> Developer of free digital technology and hardware support.
>=20
> Website: https://www.paulk.fr/
> Coding blog: https://code.paulk.fr/
> Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/


--=20
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
