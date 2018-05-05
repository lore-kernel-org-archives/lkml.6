Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeEEIc7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:32:59 -0400
Received: from sauhun.de ([88.99.104.3]:57192 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeEEIc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:32:57 -0400
Date: Sat, 5 May 2018 10:32:55 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Mark Brown <broonie@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        Baolin Wang <baolin.wang@linaro.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
Message-ID: <20180505083255.7gv3bcjxx3b6nzeb@ninjato>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
 <20180504122447.u3xgrkperxz5dpcz@ninjato>
 <20180505015458.GM13402@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsupeutnjmsk6poi"
Content-Disposition: inline
In-Reply-To: <20180505015458.GM13402@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsupeutnjmsk6poi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> > And maybe this could be used here, too? Introduce this flag for very
> > late/early messages. If they have it, messages are even sent in
> > suspend_noirq() phase with the master_xfer_irqless() callback, otherwise
> > we will have the WARNing printed out.
>=20
> It feels like it'd be more elegant to have the core select the irqless
> function automatically if called after interrupts have been disabled -
> otherwise we end up with the need to special case through other layers
> of the stack like regmap as well which seems like it'd be error prone.

Yes, I was concerned about thae (i.e. regmap accessors), too.

> OTOH it does mean we might not notice things happening later than they
> should so it's not 100% clear...

What do you mean here?

Thanks,

   Wolfram


--xsupeutnjmsk6poi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrtbDMACgkQFA3kzBSg
KbbBzhAAseHOlxKKx9KMx3QscpyweK9YWECeEkcSlnJ0t94dmCi49zQoth7jq7MO
66b/WvV4sLAqbqE4ksYrABXOFZY9Lp4+IeNe1THshZRFzEMNIs5oWtiUhuaBL6QV
662jH76Mu84AuGguE6oMCvj9wvCPTW2fXHFZ2jC48X/ZercdA1ORpUwOYRF0c4XB
Ww2nD3YSKnMHipRoYJhhUrN/e1ILy8mqIoT0O0hsOvN7zfm0AZ4PYQ5KsEYmZ4uR
4WfQjqBPXjqPmWdydseC3CoR2nllyF/SSwAHLQlnslg7FtMeomyzaFFKBDuTggRi
TjVDBOwsgGbyd6MHZY/E4IqwYsB36P1iup9OKksu6OoJBAmDCooY4o+fXjqMI3v7
y/Ew6xRD6tSxH0phCLlvaLh6L6jKSUKRzYwT1cRUkTNy3Nj39ePgtD2CR1UEsn/I
XCOhKje/Yr54droiAs9NVEB/E0fu4rgdVB+sSBW54vyDfhDhmeSXlcCITyztTA6E
rMVxUG4KbiRoViVdpnqPjxl0plkOs+PS5qK7zoMJmnjcd0Vm9qg8RGyxg3C/nM7v
mvU6MhW9FimoM2V5VqDEwDtLgvE8ok4bNi3x6TbhGMOvuKG9OA7YWWoUdLjgfYYz
ysn1ErJaaWZABYKZQHc3TiLpWg76tNpt0SShRMuUUMvqPVdFB0Q=
=cqOr
-----END PGP SIGNATURE-----

--xsupeutnjmsk6poi--
