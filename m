Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDIL1M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:27:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeDIL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:27:10 -0400
Date: Mon, 9 Apr 2018 12:27:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180409112703.GD11532@sirena.org.uk>
References: <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
 <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
X-Cookie: Professional sample - not for sale.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 02:10:40PM +0300, Sergey Suloev wrote:
> On 04/09/2018 01:50 PM, Mark Brown wrote:
> > On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:

> > > Because current implementation tries to send more than FIFO-depth of =
data in
> > > a single call to "transfer_one" which is wrong.

> > No, that's absolutely not the case.  All any of these functions has to
> > do is transfer whatever they were asked to, how they do it is not at all
> > important to the framework.

> I think you don't fully understand the issue. Let's talk about sun4i and=
=A0
> sun6i SPI=A0 drivers separately.

> sun4i

> 1)it is correctly declaring max_transfer_size=3DFIFO depth for PIO mode=
=A0 but
> transfer_one() function doesn't follow the declaration allowing PIO
> transfers longer than FIFO depth=A0 by just refilling FIFO using 3/4 FIFO
> empty interrupt. I can definitely state here that long transfers WON'T WO=
RK
> on real hardware. I tested it and that's why I can say that. But as soon =
as
> sun4i SPI driver=A0 is correctly declaring max_transfer_size then "smart"
> clients will work well by limiting a single transfer size to FIFO depth. I
> tested it with real hardware, again.

None of this is in the slightest bit related to the use of transfer_one()=
=20
vs transfer_one_message().  These are all implementation details and
will so far as I can tell apply equally to both APIs.

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrLTgYACgkQJNaLcl1U
h9DvMwf8CIj4UsGLjuBE1zeTHE3Qwaw0ed1LshStN6fkryKqAdUNIVlIY7ONiww/
bOuzFEc38tlqkXZoTf09t4NgIbtzo6Ua5xAsjUK0Om2aNUhqfgjmBGJclBzXwkPm
jRVUwLjcWMpxNkDEDpKUWJssD71Ir2/ynreXDTF5//avov+C+MbQUpDXZPjZXUpG
Jxt8oSTe3GwZ10HXlhrShtYG3G90H30kNNyjOoRtRYT+D7xSJg8BROVxnHMX0YDM
wysz+mFs9Rl1RGRdEz66GBxwFgtMmwrUR+Uiu/ZDpgCSqGcPPLnKWj899zsYDH1U
Qpy9J34vjIch6at14BEkpqnNnX4qYg==
=wTgl
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
