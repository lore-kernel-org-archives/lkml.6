Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6C921534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6C921534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbeIUCN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:13:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53712 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:13:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1BED180642; Thu, 20 Sep 2018 22:28:41 +0200 (CEST)
Date:   Thu, 20 Sep 2018 22:28:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] [media] ad5820: DT new optional field enable-gpios
Message-ID: <20180920202840.GA31044@amd>
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
 <20180920161912.17063-3-ricardo.ribalda@gmail.com>
 <1939782.bRt5jKDIiS@avalon>
 <2983018.WjSXnZMEY4@avalon>
 <CAPybu_2Ke7qAx=3LRX6aEbGSD56Z+RhWKX=gEXR6WCgyOegxEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <CAPybu_2Ke7qAx=3LRX6aEbGSD56Z+RhWKX=gEXR6WCgyOegxEw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-09-20 22:25:54, Ricardo Ribalda Delgado wrote:
> Hi
> On Thu, Sep 20, 2018 at 10:23 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Thursday, 20 September 2018 23:21:28 EEST Laurent Pinchart wrote:
> > > Hi Ricardo,
> > >
> > > Thank you for the patch.
> > >
> > > On Thursday, 20 September 2018 19:19:11 EEST Ricardo Ribalda Delgado =
wrote:
> > > > Document new enable-gpio field. It can be used to disable the part
> > > > without turning down its regulator.
> > > >
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > > > ---
> > > >
> > > >  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > > b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> > > > 5940ca11c021..07d577bb37f7 100644
> > > > --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > > +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> > > >
> > > > @@ -8,6 +8,11 @@ Required Properties:
> > > >    - VANA-supply: supply of voltage for VANA pin
> > > >
> > > > +Optional properties:
> > > > +
> > > > +   - enable-gpios : GPIO spec for the XSHUTDOWN pin.
> > >
> > > xshutdown is active-low, so enable is active-high. Should this be doc=
umented
> > > explicitly, to avoid polarity errors ? Maybe something along the line=
s of
> > >
> > > - enable-gpios: GPIO spec for the XSHUTDOWN pin. Note that the polari=
ty of
> > > the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the e=
nable
> > > GPIO deasserts the XSHUTDOWN signal and vice versa).
>=20
> Agreed
>=20
> >
> > Or alternatively you could name the property xshutdown-gpios, as explai=
ned in
> > my (incorrect) review of 2/4.
>=20
> I have double negatives :). If there is no other option I will rename
> it xshutdown, but I want to give it a try to enable.

I think enable is fine.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlukAvgACgkQMOfwapXb+vKwZgCeM/O6ef+EQUJCEEyJ6OnPsaC+
3p4AniB7FLELDJ+pEh3iebiI5PzkLqwc
=+ulO
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
