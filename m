Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935417AbeCHJFo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:05:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46583 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbeCHJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:05:37 -0500
Date: Thu, 8 Mar 2018 10:05:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Miller <davem@davemloft.net>
Cc: niklas.cassel@axis.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, Jose.Abreu@synopsys.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
Message-ID: <20180308090535.GD17761@amd>
References: <20180302232853.GA11108@axis.com>
 <20180307.103226.1538176953286317879.davem@davemloft.net>
 <20180307172157.GA22658@axis.com>
 <20180307.124249.619165601144161535.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20180307.124249.619165601144161535.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-03-07 12:42:49, David Miller wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> Date: Wed, 7 Mar 2018 18:21:57 +0100
>=20
> > Considering this, you can drop/revert:
> > 95eb930a40a0 ("net: stmmac: use correct barrier between coherent memory=
 and MMIO")
> > or perhaps you want me to send a revert?
>=20
> You must submit explicit patches to do a revert or any other change.
>=20
> > After reverting 95eb930a40a0, we will still have a dma_wmb() _after_ the
> > last descriptor word write. You just explained that nothing else is nee=
ded
> > after the last descriptor word write, so I actually think that this last
> > barrier is superfluous.
>=20
> You don't need one after the last descriptor write.
>=20
> Look, you're only concerned with ordering within the descriptor writes.
>=20
> So it's only about:
>=20
> 	desc->a =3D x;
>=20
> 	/* Write to 'a' must be visible to the hardware before 'b'. */
> 	dma_wmb();
> 	desc->b =3D y;
>=20
> 	writel();
>=20
> That's all that you need.

We may need to fix the docs then, there's wmb() there in the docs:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/memory-barriers.txt?h=3Dv4.16-rc1#n1913

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqg/N8ACgkQMOfwapXb+vKVYgCcC9jgkgNNZdHJAIhNsCEX+cDK
nIIAni/VG67i1B7SWYi0sP9CkIPZw09T
=lWoN
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
