Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965871AbeBUPCa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:02:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36891 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937439AbeBUPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:02:27 -0500
Message-ID: <1519225147.2617.169.camel@decadent.org.uk>
Subject: Re: [PATCH] Make kernel taint on invalid module signatures
 configurable
From: Ben Hutchings <ben@decadent.org.uk>
To: Matthew Garrett <mjg59@google.com>, Jessica Yu <jeyu@kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 21 Feb 2018 15:59:07 +0100
In-Reply-To: <CACdnJuvQHWBaLtPETbmOu=rwT72KGmYQfExRd8788SrYy2hUPQ@mail.gmail.com>
References: <20170807195027.13192-1-mjg59@google.com>
         <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
         <20180215152514.rxmh7webdg2i2fct@redbean>
         <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
         <20180220192100.wlrn3c4hnqdmu4zg@redbean>
         <CACdnJuvQHWBaLtPETbmOu=rwT72KGmYQfExRd8788SrYy2hUPQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-c8K3iY/Hyn2cTJ2oqMeZ"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 188.29.164.183
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c8K3iY/Hyn2cTJ2oqMeZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-20 at 20:37 +0000, Matthew Garrett wrote:
> On Tue, Feb 20, 2018 at 11:21 AM Jessica Yu <jeyu@kernel.org> wrote:
[...]
> > In any case, I think I'd be willing to merge it as a module_param made
> > available under CONFIG_MODULE_SIG=3Dy (rather than as a new separate co=
nfig
> > option), while preserving the default behavior of tainting on
> > unsigned/invalidly signed module loads (so let's keep the param parts o=
f
> > your patch). I think it makes sense to consider the turning-off-the-tai=
nt
> > param as a behavioral tweak under CONFIG_MODULE_SIG. Then you could tur=
n
> > off the tainting behavior on the kernel command line, would this suffic=
ient
> > enough for your use cases?
>
> I think that's probably not practical - distributions often aren't in
> control of the kernel command line after initial installation, so they'd
> end up with different behaviour depending on whether a machine was a clea=
n
> install or not (which is why several things that are module_params have
> defaults controlled by additional kernel config options)

Indeed.  So long as Debian doesn't do module signing, the default
behaviour in our kernel images will need to be that they don't complain
about lack of signatures.

[...]
> > > 1) Distributions that build out of tree kernel modules and don't have
> > > infrastructure to sign them will end up with kernel taint. That's som=
ething
> > > that can be resolved by implementing that infrastructure.
> > > 2) End-users who build out of tree kernel modules will end up with ke=
rnel
> > > taint and will file bugs. This cannot be fixed but will increase
> > > distribution load anyway.
> > I thought these two cases (particularly #2) were the very situations
> > where distros might find the unsigned module taint useful (especially
> > in the use case where you do benefit from module signatures). From my
> > understanding, the unsigned module taint is intended to be useful when
> > looking at crashes/OOPses, to provide a clear indication of whether or
> > not a developer could reliably debug the crash, or choose to tread
> > carefully, because the end-user has loaded an unsigned/out-of-tree
> > module that wasn't signed/shipped by the distribution. Is the taint
> > just not useful to distros in this manner anymore?
>=20
> The module list is usually sufficient for that - users tend not to replac=
e
> individual distribution modules without rebuilding their entire kernel.

And we already have an O (out-of-tree) taint flag.

Ben.

--=20
Ben Hutchings
[W]e found...that it wasn't as easy to get programs right as we had
thought. ... I realized that a large part of my life from then on was
going to be spent in finding mistakes in my own programs. - Maurice
Wilkes, 1949


--=-c8K3iY/Hyn2cTJ2oqMeZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlqNiTwACgkQ57/I7JWG
EQkDsRAAlFKAqyA/Hvmn5wpjf0nr5hIYNNRVRwMFYyKRTjRHW2Nl5bHwmpBa3nXs
dl/6G6vQW2+qXuRv8hhqjtY7POVJeN1ciQtykBweCG/ii2wlwi0YATkmMl8KJFe9
WRsFqZwuBizh4p7Y0kKXXDGpVVwZ6GqWwnEQ3TvvU6VZpbKCkbwBPhzbwWbvDdmY
RLzA6k0GD/+3Co5F6J3SC0M1yI/xRD6pd95ARjOWkQwL1URKBqtH3fytl9p9CRJ8
m8XbFXOyZUMsSnA2L/pvvm9BSCbH2G8+4jbe8HqVz6kFRUCL4JxCg68aNa+C8uXg
zwy9HHnJ5b3JeunNJ1OKisgwz9txcAkotYM+Tf9nmfy6v4EbMB2WGxl5OqqlVOxd
5RYyVj3tOfnp0g7yxcIX2AfFYE0SBQGRCx4j6xNHJJB/21asB1xNyk0jVMHUBvck
aa2SsTPCY43kGrj8vCsX5SB9nMI1f3YcHS+y7uHz/k2/c1lAutfc9+e2owf96V3W
/F5MyIBa1oGb5Ap05xVA1BlXmh3inLdWMs71FumroXBuK+rRbbZcYE/oBdpZngC1
dw0nN6En7+7jFSXrQl9aFm3x3XyGr4U41k6GTTNGHGHMhQWaONaS49pUxcEMdC8X
jPlZxxc4/MSLAM3KdmV0UuFffSWDTUJtnlZgFubOTX81onaIFp0=
=u0q1
-----END PGP SIGNATURE-----

--=-c8K3iY/Hyn2cTJ2oqMeZ--
