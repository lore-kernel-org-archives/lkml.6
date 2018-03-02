Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425599AbeCBJUX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:20:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59382 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424831AbeCBJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:20:01 -0500
Date: Fri, 2 Mar 2018 10:20:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, Jose.Abreu@synopsys.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
Message-ID: <20180302091959.GC15948@amd>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
 <20180226214709.4359-3-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20180226214709.4359-3-niklas.cassel@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for doing the detective work!

> This barrier cannot be a simple dma_wmb(), since a dma_wmb() is only
> used to guarantee the ordering, with respect to other writes,
> to cache coherent DMA memory.

Could you explain this a bit more (and perhaps in code comment)?

Ensuring other writes are done before writing the "GO!" bit should be
enough, no?

(If it is not, do we need heavier barriers in other places, too?)

Best regards,
							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZFz8ACgkQMOfwapXb+vL1fgCgqThlDwvpcOZuyqi6Hp1deKW8
KWkAoLaqDLOJdCTDch6GEjgJwCEQMEgN
=YSd2
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
