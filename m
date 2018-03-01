Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033213AbeCAQsX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:48:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033032AbeCAQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:48:22 -0500
Date: Thu, 1 Mar 2018 16:48:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
Message-ID: <20180301164819.GD12864@sirena.org.uk>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-9-hdegoede@redhat.com>
 <20180301162215.GC12864@sirena.org.uk>
 <55819630-6198-6227-63ef-69311b21b255@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <55819630-6198-6227-63ef-69311b21b255@redhat.com>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 05:26:06PM +0100, Hans de Goede wrote:
> On 01-03-18 17:22, Mark Brown wrote:
> > On Sun, Feb 18, 2018 at 11:01:45PM +0100, Hans de Goede wrote:

> > > The ignore_suspend settings were added in an attempt to try and fix
> > > suspend / resume issues. But they never fully fixed these and now we've
> > > a proper fix, so lets remove these.

> > Do these systems not have the ability to continue to play audio through
> > suspend using the DSP?  That's the sort of thing that ignore_suspend is
> > normally used for.

> In theory yes, in practice if we keep ignore_suspend set then we get
> audio for a couple of more seconds after suspend until the buffers
> are empty, as we have no code keeping them filled, which is not really
> useful, since we don't support this in a meaningful way it is better
> to just do a normal full suspend.

That sounds like what's missing is hookup of whatever the DSP uses to
wake the system when it's getting to the bottom of the buffer?  That's
the normal way this stuff is implemented anyway.

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYLtIACgkQJNaLcl1U
h9AvKAf/Vp7NbceL0r2EDqDRNBAlE3p5oLid62O48Anoxfnb3tUeCIcoFa7Ukv6E
lxekUJnwDODB9iW5nPfjztzqZMZ5sRrMt5IBDWRPJoHC/fkXIAKziIyusKY3Mi/I
Hl4Hb6213mTBKweBx/JCLlf/JOe1q12fLSOQMnQRcCNnNEer/QzRjw6ZWi1SXYJv
c5xJOKdH/O8nDk/A1QexeTDJeNaUe53zAKXXE7i797Mf3CNPSzIzHCqrx71ydNI4
41hiaBM7LH/zdmM+lU8dG1oqFQBWfJ2uV/r6451SIzmb2P5R7BujrJq/dXlArb6s
Ds/34OFYhU90+/ozg2X4mWUQuzau1A==
=RC+5
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
