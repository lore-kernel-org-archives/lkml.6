Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A82147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBGWRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:17:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40160 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:17:52 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1A4C980280; Thu,  7 Feb 2019 23:17:40 +0100 (CET)
Date:   Thu, 7 Feb 2019 23:17:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Droid 4 modem support in kernel & ofono
Message-ID: <20190207221745.GA12219@amd>
References: <20190201203616.GA2087@amd>
 <20190201205032.GF5720@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20190201205032.GF5720@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, so I got calls and smses somehow working in kernel&ofono ... which
> > is really all I need.
>=20
> Nice :)
>=20
> I think the SIM card reading and writing should be doable
> using dlci10 /dev/motmdm10 for AT+CRSM calls..

Might be. Sorry, this is outside of my area of interest, because LTE
would not be on usable frequencies, anyway.

> > I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
> > d4... But I had to do some "rather interesting" hacks. D4 modem
> > expects packets and current kernel drivers rely on write() boundaries
> > and flush(). .. which is a bit of problem for in ofonod, as it expects
> > to work with bytestream with no explicit packet boundaries.
> >=20
> > However D4 still uses normal AT commands, so... it would be good to be
> > able to use AT parsing framework in ofono.
> >=20
> > I believe easiest solution would be to automatically do the packet
> > splitting in kernel, it should be as easy as splitting on \r and
> > ^Z. (Currently packets are only generated when \r or ^Z is seen on
> > write boundary, but that does not work well for ofono).
>=20
> OK yeah it's worth trying. I hit that issue too with the
> flush needed for droid4-sms-tools scripts. And the traffic
> we're seeing is minimal and AFAIK there's no network port
> for ts27010. And SMS messages are PDU encoded anyways.
>=20
> Hmm should we do it for \r\n and \r? Otherwise the \n
> will be left out of the packet :)

I guess splitting on \n makes sense, yes.=20

Ofono normally uses just \r. Translating it to \r\n in kernel (ttys
already do that) would be super nice, but I think this is easy enough
to handle in ofono.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxcrokACgkQMOfwapXb+vK4bwCfV/LVgMgAXt7Rt3r5EGz7Cq9V
vV8AoJcZpIFS/6ox5j6ZCvHU9VHo6GkG
=9OQ6
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
