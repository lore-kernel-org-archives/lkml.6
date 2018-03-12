Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCLNsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:48:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37684 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeCLNsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:48:37 -0400
X-Google-Smtp-Source: AG47ELsH0YdPiBAWPXh73szs3edUuo4p2rfLodbNv/vcNAGOB8on1NCzLbcNP4jY+d+5LX279E715g==
Date: Mon, 12 Mar 2018 14:48:32 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
Message-ID: <20180312134832.GA30477@ulmo>
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com>
 <20180308144437.GJ3529@ulmo>
 <92084f1b-848a-39e6-7d77-7ceaa6a6f1d3@gmail.com>
 <20180312071548.GB23060@ulmo>
 <5fc86cc6-947f-ec7c-0c57-905f7aecdfbb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <5fc86cc6-947f-ec7c-0c57-905f7aecdfbb@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 03:37:28PM +0300, Dmitry Osipenko wrote:
> On 12.03.2018 10:15, Thierry Reding wrote:
> > On Fri, Mar 09, 2018 at 05:35:46PM +0300, Dmitry Osipenko wrote:
> >> On 08.03.2018 17:44, Thierry Reding wrote:
> >>> On Thu, Mar 01, 2018 at 04:33:29PM +0300, Dmitry Osipenko wrote:
> >>>> On 15.01.2018 13:56, Dmitry Osipenko wrote:
> >>>>> On 10.01.2018 16:59, Dmitry Osipenko wrote:
> >>>>>> Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these cl=
ocks
> >>>>>> as critical.
> >>>>>>
> >>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Change log:
> >>>>>> v2:     Fixed accidentally missed marking EMC as critical on Tegra=
30 and
> >>>>>>         Tegra124. Switched to a use of common EMC gate definition =
on Tegra20
> >>>>>>         and Tegra30.
> >>>>>>
> >>>>>> v3:     Dropped marking PLL_P outputs as critical, because seems t=
hey are
> >>>>>>         not so critical. Although, I still haven't got a definitiv=
e answer
> >>>>>>         about what exact HW functions are affected by the fixed-cl=
ocks.
> >>>>>>         Anyway it should be cleaner to correct the actual drivers.
> >>>>>
> >>>>> Stephen / Michael, would it be possible to schedule these patches f=
or 4.16? My
> >>>>> T20 and T30 devices aren't working without the 'critical clocks' pa=
tch. Things
> >>>>> happen to work with the opensource u-boot, but not with the proprie=
tary
> >>>>> bootloader. It's probably not a big deal that out-of-tree devices a=
re broken,
> >>>>> although would be nice to have one problem less.
> >>>>
> >>>> Guys, is there anything I could do to get these patches in linux-nex=
t?
> >>>
> >>> I've picked these up into the for-4.17/clk branch in the Tegra tree. I
> >>> already have that branch for the MBIST patches which are a dependency
> >>> for the for-4.17/soc branch.
> >>
> >> Thank you very much! Could you please add stable tag to this ("Mark HC=
LK, SCLK
> >> and EMC as critical") patch? It would be nice to have 4.16 unbroken ev=
entually
> >> for those who (have to) use downstream android bootloader.
> >>
> >> Cc: <stable@vger.kernel.org> # v4.16
> >=20
> > Should we add a Fixes: line instead? That way it will get automatically
> > backported to all applicable stable releases.
> >=20
> > This is a little complicated because the clocks were introduced in
> > different commits, most of them a very long time ago:
> >=20
> > 	a7c8485a0ebbdce303c6709e208bb4fd08aff8ad (sclk)
> > 	2db04f16b589c6c96bd07df3f1ef8558bfdb6810 (emc)
> > 	76ebc134d45d7e6e1dc29fdcef4e539c5bc76eb8 (emc)
> > 	...
> >=20
> > So Fixes: is perhaps not desirable after all, but then, so isn't tagging
> > v4.16 specifically because this is a bug since almost forever, so v4.16
> > is fairly arbitrary. Shouldn't we at least get this fixed for the last
> > couple of LTS releases?
>=20
> That issue was masked in earlier kernels and only appears in 4.16, there =
is no
> need to backport it further. I thought that adding of 'stable' tag is eno=
ugh to
> get patch backported automatically, so let's add 'fixes' instead:
>=20
> Fixes: 109eba2eb61a ("clk: tegra: Mark APB clock as critical")
>=20
> This patch applies cleanly to 4.16, everything should be fine.

It's not immediately obvious why the above would expose the issue and
hence why this patch fixes the problem, and I'm quite frankly not sure
I understand why that is, so perhaps just going with the stable tag is
the best option after all.

Thierry

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmhS0ACgkQ3SOs138+
s6H1lBAAmMU4wAoLH5v6p5qCjLQuT7uoIbI0TSq4r/ROFlAhTlpm1O2Ga7psT+Te
tqKQWXGhx9M6NIVALNgJwNQtEvzU5PpjFT+ki1TBDxvndeUUTbekgWAhP0ELBZ0p
BU1+jrNDXYOJKoq0d0nEC8FfgODozj74ZYrg2AeYuoH953Mhalncgm5cMLFbwCD/
w+y+17yR53YIFx02t0QCSzgUb/IJ3JPd2t9WJmqYBRlAersGWBUditva22CyECnc
w0q5f6bMR8F3+QYKBgSFQ9Cqei8pH5JyUSW39yzKp2lb9ng957cAWSnCYqoyhSuN
n+3oKjMPnGvJRL5+L1W5fYpY7pr3I9F5Aht2m0azUMLtJ0UX7KEK2y0uRbgmOBYf
XUBOJcoMZGwKteeZlUqvAXr7zqUysS4dtezS3wnE6tCtdG5VLLXt4c18F+o1a+A7
qqlYXfuYMrNqVvQNtYfX+Kw8wJ8rbulJnK9bFTkke0Tgj2zV4DxV+wTc/BuAmHrL
JA9eSpJMuXhpal0G38eo+eUJw+b06IM3fzL4SBjrdEP0JYE/QFsyBw1qBp/nO21w
9/HvdidknrfzGQBr2o/f9CBf55B1Pe5xYm2fWft/wIR5rxS5fi6HxEwK9Ce+r4/o
YpKn8BYcT+SzHtCin/JYA62f6TZuLMEdGMPbo2RLQ1TjSKGQ2cY=
=2C36
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
