Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeEIIS5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:18:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeEIISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:18:54 -0400
Date: Wed, 9 May 2018 17:18:48 +0900
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Baolin Wang <baolin.wang@linaro.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
Message-ID: <20180509081848.GO13402@sirena.org.uk>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
 <20180504122447.u3xgrkperxz5dpcz@ninjato>
 <20180505015458.GM13402@sirena.org.uk>
 <20180505083255.7gv3bcjxx3b6nzeb@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
In-Reply-To: <20180505083255.7gv3bcjxx3b6nzeb@ninjato>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 05, 2018 at 10:32:55AM +0200, Wolfram Sang wrote:

> > OTOH it does mean we might not notice things happening later than they
> > should so it's not 100% clear...

> What do you mean here?

If someone is doing I/O later than they should currently we'll notice as
they try to do something that needs interrupts with interrupts disabled.
With transparent noirq then it'll just work on some percentage of
systems with controllers that support that but fail on others.  That may
or may not be what we want but it's worth considering.

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlryrucACgkQJNaLcl1U
h9AK6Qf/dL7AXD4YqQnivJm9tMvny93IdehkZgx7Vi+UAY43/JS6jtF+yyO5MCbB
z8/rYVkh/TsjCYpfhfgEMhorcxrU706PFeADYU8p7MF89jQiFEiskV0gds+mogrv
CP/Zvjtm1dmqnMwXtLvtnJe8yrsoMOzYkKqMBijSKWIWPJhSrYcTZfZrvWtfUFQ/
myNii5kUe+QI/l1XkOxTIoaOdkIh0jChpD/TOkcsNebzX7sI08RROEsKBVg6cAb0
D5ns8MUDtxftG+CITywfT3Vpxyb5jpb7gtSknvp4Tyw9ef+Q8QmGrzwgH9O5mKng
fHdXFLL8QyKFg6rnzGoFie0l9tYrdQ==
=Fd8g
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
