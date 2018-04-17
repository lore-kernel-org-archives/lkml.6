Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeDQLEH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:04:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeDQLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:04:05 -0400
Date: Tue, 17 Apr 2018 12:03:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Radu Pirea <radu.pirea@microchip.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
Message-ID: <20180417110358.GD8973@sirena.org.uk>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20180413181251.GG22187@piout.net>
X-Cookie: Depart in pieces, i.e., split.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 13, 2018 at 08:12:51PM +0200, Alexandre Belloni wrote:
> On 13/04/2018 19:12:54+0200, Nicolas Ferre wrote:

> > This layout of the hardware is completely different from the USART one and
> > it seems to makes sense to address it with a different hardware description
> > and so a different compatible string.

> But then, you can end up with two drivers trying to use the same IP
> because nothing prevents you from writing a DT with both a usart and an
> spi node enabled for the same IP. request_mem_region() will not help
> here because then the working driver will depend on the probing order.

We don't really have too much in the way of better ideas for how to
handle this though.  Take a look at how the PXA SSP stuff handles this,
though that's not really doing too much different it at least layers a
mechanism on top to avoid collisions.

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrV1J0ACgkQJNaLcl1U
h9DCSQf+MvNTpltQosRGeLwGrJwao9U0bH049keLdBcKwW0YHwsyF27+3qgKSt2P
o0yP3Kc0wpvXsg8nCA8i002IsP0TlMwfoK4iErmRsm3yrq9oW1OvLhQhmSQQPMGo
nKCK5JnS9yRigDctPIHxBEypFSVz7yeEcISKO7A7xdhsZx9OZAsj+E/IN/msyur0
qq5dmuxkWEOpHBRVib82AZkiGT4mnKtI1++JyKvtUxPJkALV9/2oZ02zBmF0wP7B
Xr4/E0ceAJ1dGNoCoDgE3buSyUn/4dPf/+0PnN4hnnAfT64Nr0jAogk8U4yVESEC
M2sMuJONsvBSwQh9X6OWXvBtec/3Ig==
=CaAS
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
