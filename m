Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A306ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E25C2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E25C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeGOUlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:41:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47108 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOUlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:41:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8631280288; Sun, 15 Jul 2018 22:17:30 +0200 (CEST)
Date:   Sun, 15 Jul 2018 22:17:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180715201729.GB19675@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20180711132739.GL99251@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-07-11 06:27:39, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180711 08:05]:
> > Hi!
> >=20
> > > > Its parent is gpio@4805d000 , and that one seems to be present.
> > > >=20
> > > > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > > > driver				       driver_override  gpio
> > > > gpiochip5  modalias  of_node  power  subsystem  uevent
> > >=20
> > > Sorry, something went wrong with merging this. The parent
> > > of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> > > not gpio6.
> >=20
> > Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
> > driver.
> ..
> > --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > @@ -159,13 +159,7 @@
> > =20
> >  		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
> >  	};
> > -};
> > -
> > -&dss {
> > -	status =3D "okay";
> > -};
> > =20
> > -&gpio6 {
> >  	pwm8: dmtimer-pwm-8 {
> >  		pinctrl-names =3D "default";
> >  		pinctrl-0 =3D <&vibrator_direction_pin>;
> > @@ -192,7 +186,10 @@
> >  		pwm-names =3D "enable", "direction";
> >  		direction-duty-cycle-ns =3D <10000000>;
> >  	};
> > +};
> > =20
> > +&dss {
> > +	status =3D "okay";
> >  };
> > =20
> >  &dsi1 {
>=20
> Hmm sorry if I did a mismerge on the above. A note to
> myself to stop applying patches that apply with fuzz,
> that is clearly dangerous with dts files with lots
> of similar named properties.

Yep, so I have two patches that make the device appear, but vibrations
still do not work for me.

a) any ideas how to debug that / get them to work?

b) do you want the patches anyway?

Regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltLq9kACgkQMOfwapXb+vImRwCgpccOZdn3aiVOwbbDd9pgzxkE
KpAAoJXA5B2v9flnKShBMWyr8DEpALqx
=eoy2
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
