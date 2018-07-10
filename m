Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD31C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB22720843
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB22720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeGJMgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:36:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54875 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeGJMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:36:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7FEB48049C; Tue, 10 Jul 2018 14:36:49 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:36:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] driver core: add a debugfs entry to show deferred
 devices
Message-ID: <20180710123648.GA4227@amd>
References: <20180708133459.24883-1-javierm@redhat.com>
 <20180710100152.bb562zgbv7yimb7r@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20180710100152.bb562zgbv7yimb7r@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > With Device Trees (DT), the dependencies of the devices are defined in =
the
> > DT, then the drivers parse that information to lookup the needed resour=
ces
> > that have as dependencies.
> >=20
> > Since drivers and devices are registered in a non-deterministic way, it=
 is
> > possible that a device that is a dependency has not been registered yet=
 by
> > the time that is looked up.
> >=20
> > In this case the driver that requires this dependency cannot probe and =
has
> > to defer it. So the driver core adds it to a list of deferred devices t=
hat
> > is iterated again every time that a new driver is probed successfully.
> >=20
> > For debugging purposes it may be useful to know what are the devices wh=
ose
> > probe function was deferred. Add a debugfs entry showing that informati=
on.
> >=20
> >   $ cat /sys/kernel/debug/devices_deferred
> >   48070000.i2c:twl@48:bci
> >   musb-hdrc.0.auto
> >   omapdrm.0
> >=20
> > This information could be obtained partially by enabling debugging, but=
 it
> > means that the kernel log has to be parsed and the probe deferral balan=
ced
> > with the successes. This can be error probe and has to be done in a ad-=
hoc
> > manner by everyone who needs to debug these kind of issues.
> >=20
> > Since the information is already known by the kernel, just show it to m=
ake
> > it easier to debug.
> >=20
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Thanks for doing this.

Note that it rejects on current -rc4, but solution is trivial.

Tested-by: Pavel Machek <pavel@ucw.cz>

Unfortunately, it does not help with pwm problem on Droid4, as nothing
is deffered:

user@devuan:/sys/bus/platform/drivers$ cat
/sys/kernel/debug/devices_deferred
user@devuan:/sys/bus/platform/drivers$

									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEqGAACgkQMOfwapXb+vJ/XwCcDX/LTJhKxTte6Pqx4Z1wAMvf
JN4AniDQ5mOw6YrmURQBL9svN07VJtYf
=Z3Ie
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
