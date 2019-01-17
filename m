Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC8AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15C020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAQMvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:51:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42253 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfAQMvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:51:32 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 552798070E; Thu, 17 Jan 2019 13:51:23 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:51:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Johan Hovold <johan@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, omerlle@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190117125128.GA17453@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com>
 <20181218202242.GA30831@amd>
 <20181218215311.GD6707@atomide.com>
 <20190116134823.GA10145@amd>
 <20190117025436.GR5544@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20190117025436.GR5544@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > "quite trivial" does not mix with ofono. I did parts and it is still
> > not finished. At the moment, I do not have enough working SIM cards to
> > test everything. Feel free to help :-).
>=20
> I gave it a try but could only see "ofonod[14012]: motmdm init"
> on start up. Running test/list-modems shows only /stktest
> and no motmdm..
>=20
> Do I need to configure something in /etc/ofono?

No, that should not be needed. But you need this:

user@devuan:~$ cat /etc/udev/rules.d/55-modem.rules
KERNEL=3D=3D"ttyUSB4", ENV{OFONO_DRIVER}=3D"g1"

KERNEL=3D=3D"motmdm1", ENV{OFONO_DRIVER}=3D"motmdm"

(different devices for different branches of ofono), and it is useful
to run ofono like this:

sudo OFONO_AT_DEBUG=3D1 src/ofonod -d -n -p motmdm,udevng,atmodem,motorolam=
odem

=2E..to get right kind of debugging.

You then want to run enable-modem . online-modem is NOP, afaict.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxAelAACgkQMOfwapXb+vKzGACfVDXYNw2SZYWs3WFOEFtj6u1m
VP0AnieRH3ZQ5tfZSbakAcJmg0pzNsgi
=Pu8R
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
