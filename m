Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA8725054
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8725054
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeGBTca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:32:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60947 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeGBTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:32:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 519978051E; Mon,  2 Jul 2018 21:32:27 +0200 (CEST)
Date:   Mon, 2 Jul 2018 21:32:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180702193226.GB30798@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
 <20180629114646.GU629@localhost>
 <20180629120554.GA2477@amd>
 <20180629120914.GA9802@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20180629120914.GA9802@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-29 14:09:14, Johan Hovold wrote:
> On Fri, Jun 29, 2018 at 02:05:54PM +0200, Pavel Machek wrote:
> > On Fri 2018-06-29 13:46:46, Johan Hovold wrote:
> > > On Fri, Jun 29, 2018 at 11:46:07AM +0200, Pavel Machek wrote:
> > > >=20
> > > > > > Finally, note that documentation (including kerneldoc) remains =
to be
> > > > > > written, but hopefully this will not hinder review given that t=
he
> > > > > > current interfaces are fairly self-describing.
> > > > >=20
> > > > > This all looks great.  Thanks for doing this work and adding a new
> > > > > subsystem for something that has been asked for for many years.
> > > > >=20
> > > > > All now merged in my tree, nice job!
> > > >=20
> > > > I don't think discussion was finished on this one.
> > > >=20
> > > > In particular, we agreed that /dev/gnssrawX would be better device
> > > > name, so that we still have place where to put proper abstraction
> > > > layer in future.
> > >=20
> > > I did not agree with you on that. I said we could consider that name =
if
> > > this was to be changed at all, which I do not think is necessary for
> > > the reasons spelled out in this thread.
> >=20
> > So, again: there's nothing gnss specific in those patches. It does not
> > know about the format of the data passed around. (Best you can claim
> > that somehow data flow characteristics are unique to gnss.) And this
> > takes namespace needed for real gnss subsystem. Please don't do it.
>=20
> This is the real gnss subsystem. Get over it.

Congratulations. You have created gnss subsystem that has 0 lines of
code that are gnss-specific.

This is not real gnss subsystem. This is pipe that passes data,
similar to /dev/psaux or mouse on /dev/ttyS0. Sooner or later, real
gnss subsystem (with unified interface) will be needed, as it was for
input, and this "pipe and gpio" thing should not hog required
namespace.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls6fcoACgkQMOfwapXb+vK2iwCfekkE2c8NlLS4L3/4tD8bWoXA
zHcAn2ZPmC5eoFkUPoujyruLRo+UVc1h
=8YSM
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
