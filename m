Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91200C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532CD218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLRUWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:22:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37115 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:22:44 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 010BE80A4E; Tue, 18 Dec 2018 21:22:38 +0100 (CET)
Date:   Tue, 18 Dec 2018 21:22:42 +0100
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
Message-ID: <20181218202242.GA30831@amd>
References: <20181217004450.GW6707@atomide.com>
 <20181218124616.GA10758@amd>
 <20181218153650.GA6707@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20181218153650.GA6707@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > # commit	    0c1bc81ba976bcd480d6e3c3009a28589f8427c0 (patch)
> > # mfd: motmdm: Add Motorola TS 27.010 serdev driver for devices like dr=
oid4
> >=20
> > Oh, that is a lot of fun. Especially state machine for parsing modem
> > responses. I wonder how well it is going to work when modem is
> > accessed over USB...=20
> >=20
> > motmdm_read_state(... size_t len)
>=20
> That's a bit of a layering violation yeah :) But we still need to
> do that somewhere for notifiers. And the notifications are separate
> from the commands and start with a ~ character so from that point of
> view it should not be too bad.

Plus, you seem to assume that data will always come in suitably sized
chunks. Aha, and as it is not plain serial but packet protocol over
serial... I guess that is going to work?

> > I did a quick test in my config... and it did not break my old setup
> > -- voice calls still work when set up over USB and with manual mixer
> > setup. That was good surprise.
>=20
> OK good to hear. Using the n_gsm port instead of USB during idle
> has a major PM advantage as the SoC can hit retention during idle
> while still connected to the modem and getting notifications.
>=20
> So looks like during idle we can keep USB in autosuspend mode with
> something like the below shell script function.

Yes, I should really start using serials instead of USB. But... I have
working ofono there, and was using that phone and am little short on
time at the moment.

Thanks,
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwZVxIACgkQMOfwapXb+vKzsgCfe5SxXLIU0/XDhCS+NU2FI4PJ
hT4An2GGA1G+NWauOlEvtyR5MaZm7zTd
=oZIT
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
