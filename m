Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeCLHPz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:15:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45870 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932533AbeCLHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:15:53 -0400
X-Google-Smtp-Source: AG47ELtrt1v9usZFALkTD1e5gQd+kjJKR9r1OAS9ShgnbWLhS3vrkeL8qn5dSJ9f2qKePgTTMVtaNA==
Date: Mon, 12 Mar 2018 08:15:48 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
Message-ID: <20180312071548.GB23060@ulmo>
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com>
 <20180308144437.GJ3529@ulmo>
 <92084f1b-848a-39e6-7d77-7ceaa6a6f1d3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <92084f1b-848a-39e6-7d77-7ceaa6a6f1d3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 05:35:46PM +0300, Dmitry Osipenko wrote:
> On 08.03.2018 17:44, Thierry Reding wrote:
> > On Thu, Mar 01, 2018 at 04:33:29PM +0300, Dmitry Osipenko wrote:
> >> On 15.01.2018 13:56, Dmitry Osipenko wrote:
> >>> On 10.01.2018 16:59, Dmitry Osipenko wrote:
> >>>> Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these cloc=
ks
> >>>> as critical.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>>> ---
> >>>>
> >>>> Change log:
> >>>> v2:     Fixed accidentally missed marking EMC as critical on Tegra30=
 and
> >>>>         Tegra124. Switched to a use of common EMC gate definition on=
 Tegra20
> >>>>         and Tegra30.
> >>>>
> >>>> v3:     Dropped marking PLL_P outputs as critical, because seems the=
y are
> >>>>         not so critical. Although, I still haven't got a definitive =
answer
> >>>>         about what exact HW functions are affected by the fixed-cloc=
ks.
> >>>>         Anyway it should be cleaner to correct the actual drivers.
> >>>
> >>> Stephen / Michael, would it be possible to schedule these patches for=
 4.16? My
> >>> T20 and T30 devices aren't working without the 'critical clocks' patc=
h. Things
> >>> happen to work with the opensource u-boot, but not with the proprieta=
ry
> >>> bootloader. It's probably not a big deal that out-of-tree devices are=
 broken,
> >>> although would be nice to have one problem less.
> >>
> >> Guys, is there anything I could do to get these patches in linux-next?
> >=20
> > I've picked these up into the for-4.17/clk branch in the Tegra tree. I
> > already have that branch for the MBIST patches which are a dependency
> > for the for-4.17/soc branch.
>=20
> Thank you very much! Could you please add stable tag to this ("Mark HCLK,=
 SCLK
> and EMC as critical") patch? It would be nice to have 4.16 unbroken event=
ually
> for those who (have to) use downstream android bootloader.
>=20
> Cc: <stable@vger.kernel.org> # v4.16

Should we add a Fixes: line instead? That way it will get automatically
backported to all applicable stable releases.

This is a little complicated because the clocks were introduced in
different commits, most of them a very long time ago:

	a7c8485a0ebbdce303c6709e208bb4fd08aff8ad (sclk)
	2db04f16b589c6c96bd07df3f1ef8558bfdb6810 (emc)
	76ebc134d45d7e6e1dc29fdcef4e539c5bc76eb8 (emc)
	...

So Fixes: is perhaps not desirable after all, but then, so isn't tagging
v4.16 specifically because this is a bug since almost forever, so v4.16
is fairly arbitrary. Shouldn't we at least get this fixed for the last
couple of LTS releases?

Thierry

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmKSAACgkQ3SOs138+
s6Fn+A/9Ef6j/85FSfdovhO7pMyuREVGA/wascvGs05rNoJcEVl7+19gSlNf2CWa
ebEePqzpUNDEcj3ncRyyeu37kdiweWY7evZwOyoV6EkQDEGyJhx1EA2cP2uVja+S
dsAgLnzWpgUdMSCo+mB0GFIqr2JIOAGcrwIt/nd/mUNq3T3uZFV8+sksQ0WTf/K7
Z1fJtLIq6+JWiX8tXoT6C6hDuo/lcYoqLjxc2SGY1ICWfbhZB1zZHvtjRQyyUqea
gemUdnMt8NhnWx6F1bmfTmglVzZBMS68gXzC1sVSCJrttCi+aOH6Mx9eY0aCWTz0
juZIVfaWIlwN4XYWRbvjrku+eoEFckdnwnxYpoXowHGNrBj3gZE2vICUVqMA/fiv
nucPkaoSR9qBv6jOkcxrSr+VmPXge8M7Ecib8uEvlSjE7B99cQiB+VLClwFb8REi
wGAU3dJcxG7xAqyEDaUgRf7HPQNx2bS+fJfYdgziV2fg/QGD24tH1ZBCgBMoISvh
jtp8/mOPuQ4bhtzd5wQtqPWaCEtrCqrXMkdL8k52k3wMNEM9hXdw/A1m8HABzQaz
1t+RL4TjGT1DOkvPyGzvrJfvfiRx5IAiDjL//cii+p8/eVTMoxjWfUQfQEXtwFw+
qUKX1C4bYYq03YmHMuDiz626jRldgAQ5MOHtkJZ56cHYZk342Fk=
=eRVJ
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
