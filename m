Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD28C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DDF2476F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DDF2476F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeGBTB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:01:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60249 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGBTB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:01:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 597C68051E; Mon,  2 Jul 2018 21:01:24 +0200 (CEST)
Date:   Mon, 2 Jul 2018 21:01:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180702190123.GA30798@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
 <20180629182600.GA17562@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20180629182600.GA17562@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-29 14:26:00, Greg Kroah-Hartman wrote:
> On Fri, Jun 29, 2018 at 11:46:07AM +0200, Pavel Machek wrote:
> >=20
> > > > Finally, note that documentation (including kerneldoc) remains to be
> > > > written, but hopefully this will not hinder review given that the
> > > > current interfaces are fairly self-describing.
> > >=20
> > > This all looks great.  Thanks for doing this work and adding a new
> > > subsystem for something that has been asked for for many years.
> > >=20
> > > All now merged in my tree, nice job!
> >=20
> > I don't think discussion was finished on this one.
>=20
> It looked done to me as there was only a single set of patches, with no
> other working patches submitted from anyone else.

Is "noone submitted patches on top" sufficient reason to apply the patch?

> If this turns out to be a "bad" api, then we can deal with it then, but
> for now let's try this out.

Series uses /dev/gnss0 , without providing hardware abstraction,
blocking place for proper gnss layer. Suggested fix is to to make it
"/dev/gnssraw0". How do you propose to fix this after it is merged?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls6doMACgkQMOfwapXb+vJwaACeI+rqau9/0yFxcUNAqyXyIDPw
ZI8AoLvECl1hLw7rSIT2LPKjY3kT8o0s
=qXOS
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
