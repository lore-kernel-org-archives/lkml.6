Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA6C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39D22084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39D22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeLLSc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:32:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59186 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbeLLSc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:32:57 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4CBA180809; Wed, 12 Dec 2018 19:32:50 +0100 (CET)
Date:   Wed, 12 Dec 2018 19:32:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
Message-ID: <20181212183253.GA16578@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
 <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
 <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181212095929.GA13437@amd>
 <CAL_JsqJPMzwU9h2RSXeCfNTO5+zs7xTOb9jYcGivj+v_2RkG2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJPMzwU9h2RSXeCfNTO5+zs7xTOb9jYcGivj+v_2RkG2A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-12-12 07:56:20, Rob Herring wrote:
> On Wed, Dec 12, 2018 at 3:59 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > > We would also probably need different DT properties for different
> > > > types of devices, since e.g. for network case the network interface
> > > > name would fit better for the LED name, than the phy name,
> > > > and we would need to know what type of device name we're going
> > > > to look for.
> > > >
> > > > Pavel gave following examples:
> > > >
> > > > eth0:green:link
> > > > adsl0:green:link
> > > > adsl0:red:error
> > > >
> > > > So we would have e.g.:
> > > >
> > > > associated-vl42-device =3D <&camera1>;
> > > > associated-network-device =3D <&phy1>;
> > > > associated-block-device =3D <&phy1>;
> > >
> > > Variable property names are kind of a pain to parse.
> > >
> > > Perhaps when LEDs are associated with a device, we shouldn't care
> > > within the context of the LED subsystem what the name is. The
> > > association is more important and if you have that exposed, then you
> > > don't really need to care what the name is. You still have to deal
> > > with a device with more than 1 LED, but that becomes a problem local
> > > to that device.
> > >
> > > What I'm getting at is following a more standard binding pattern of
> > > providers and consumers like we have for gpios, clocks, etc. So we'd
> > > have something like this:
> > >
> > > ethernet {
> > >   ...
> > >   leds =3D <&green_led>, <&red_led>;
> > >   led-names =3D "link", "err";
> > > };
> > >
> > > We can still support defining LED names as we've done, but we don't
> > > have to come up with some elaborate naming convention that covers
> > > every single case.
> >
> > I see that it would be more consistent with how gpios work, but I'm
> > afraid this does not fit LEDs properly.
> >
> > With power LED, you want to be able to say "this is just on". Some
> > poeple like heartbeat, and have LED for that. There may be LED for
> > "disk activity", meaning activity on any harddrive. And there may be
> > activity LED for specific disk.
> >
> > Only in the last case it would be suitable to have LED reference as a
> > child of an device...
>=20
> Right. For all the other cases, why do you need any link with a
> device? What we have today is sufficient and can continue to be
> supported. A link to a device is only used if the led is associated
> with a particular device.

Right, so the link is only needed in some cases. So unlike your
example, we would have:

led1 { led-meaning =3D "heartbeat"; }
led2 { led-meaning =3D "link"; }
led3 { led-meaning =3D "err"; }
led4 { led-meaning =3D "activity"; what-activity =3D "all_harddisks"; }
ethernet { leds =3D < &led2, &led3 >; }

Dunno. I'd expect all the LED description in the LED node, not part of
the description there and back link from the device...
									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwRVFUACgkQMOfwapXb+vIbZQCgt8YLRx2eloWKWKDuVk/pqwFO
GFoAoLMT7OmBoasj+A1EwR1sG3/tNr/z
=Qbpj
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
