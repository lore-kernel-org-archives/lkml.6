Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeCIKs7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:48:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36036 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeCIKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:48:57 -0500
Date: Fri, 9 Mar 2018 11:48:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: remove superfluous wmb() memory
 barriers
Message-ID: <20180309104855.GA17998@amd>
References: <20180308103006.1197-1-niklas.cassel@axis.com>
 <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-09 10:26:11, Jose Abreu wrote:
> Hi Niklas,
>=20
> On 08-03-2018 10:30, Niklas Cassel wrote:
> > These wmb() memory barriers are performed after the last descriptor wri=
te,
> > and they are followed by enable_dma_transmission()/set_tx_tail_ptr(),
> > i.e. a writel() to MMIO register space.
> > Since writel() itself performs the equivalent of a wmb()=20
>=20
> Sorry but I know at least two architectures which don't do a
> wmb() upon an writel [1] [2]. This can be critical if if we are
> accessing the device through some slow or filled bus which will
> delay accesses to the device IO. Notice that writel and then
> readl to the same address will force CPU to wait for writel
> completion before readl, but in this case we are using DMA and
> then writel so I think a wmb() before the writel is a safe measure.

This also matches documentation, as I tried to point out.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqiZpcACgkQMOfwapXb+vIxVQCgvqVPkPgewr9bMlyEKq+HBOSM
FLAAoLfY63FHLQ/olztxWfoq/wM9oCiC
=frPy
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
