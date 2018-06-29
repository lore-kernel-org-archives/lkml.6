Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7666D27CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7666D27CA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936295AbeF2MF5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:05:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45108 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936208AbeF2MF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:05:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A8C16805C1; Fri, 29 Jun 2018 14:05:54 +0200 (CEST)
Date:   Fri, 29 Jun 2018 14:05:54 +0200
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
Message-ID: <20180629120554.GA2477@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
 <20180629114646.GU629@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20180629114646.GU629@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-29 13:46:46, Johan Hovold wrote:
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
> >=20
> > In particular, we agreed that /dev/gnssrawX would be better device
> > name, so that we still have place where to put proper abstraction
> > layer in future.
>=20
> I did not agree with you on that. I said we could consider that name if
> this was to be changed at all, which I do not think is necessary for
> the reasons spelled out in this thread.

So, again: there's nothing gnss specific in those patches. It does not
know about the format of the data passed around. (Best you can claim
that somehow data flow characteristics are unique to gnss.) And this
takes namespace needed for real gnss subsystem. Please don't do it.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls2IKIACgkQMOfwapXb+vJYNgCfQQRK+T0oM9z2in/mUXt3cQ3e
UVYAniQiYdGQWgA8If/r6UIuzuSZT1vG
=O8yW
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
