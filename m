Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDSNij (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:38:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35709 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeDSNif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:38:35 -0400
Date: Thu, 19 Apr 2018 15:38:33 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kyle Evans <kevans@freebsd.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Emmanuel Vadot <manu@bidouilliste.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: sunxi: Add sid for a83t
Message-ID: <20180419133833.etuuxm3eygp3wfye@flea>
References: <CACNAnaE9GiVTXD-TV1xXyBJKtTGKpdA6n0REk6a=qm218EgHbg@mail.gmail.com>
 <20171221152630.2vf57x5o2yi5sv3n@flea.lan>
 <20171221190903.56ebae536acf51401c63802c@bidouilliste.com>
 <20171222083508.dfcp6egfvxykmogg@flea.lan>
 <20171222110727.520df7394234f6a5dc0b9ec0@bidouilliste.com>
 <CAGb2v64mf-ihyOs-WJZuVa4Yib3Szp90RZu_a1EeQ1LJXnoXEQ@mail.gmail.com>
 <20180104140119.5pyfihp4zs2poz35@flea.lan>
 <CACNAnaHOuPH05hsJ-jt1135-Giknb-DOuvjeQRSGVR2L7Xc-Cg@mail.gmail.com>
 <20180109133412.uyai4s6vfnh37hn2@flea>
 <CACNAnaEyKztSt_SO25e+VcmyN=fdGTVbpooWSu891ueY6xvh-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4syblqsgtkenq3hx"
Content-Disposition: inline
In-Reply-To: <CACNAnaEyKztSt_SO25e+VcmyN=fdGTVbpooWSu891ueY6xvh-g@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4syblqsgtkenq3hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 09:05:19AM -0500, Kyle Evans wrote:
> On Tue, Jan 9, 2018 at 7:34 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Jan 08, 2018 at 09:30:57AM -0600, Kyle Evans wrote:
> >> On Thu, Jan 4, 2018 at 8:01 AM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Fri, Dec 22, 2017 at 06:11:52PM +0800, Chen-Yu Tsai wrote:
> >> >> On Fri, Dec 22, 2017 at 6:07 PM, Emmanuel Vadot <manu@bidouilliste.=
com> wrote:
> >> >> > On Fri, 22 Dec 2017 09:35:08 +0100
> >> >> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >> >> >
> >> >> >> On Thu, Dec 21, 2017 at 07:09:03PM +0100, Emmanuel Vadot wrote:
> >> >> >> >
> >> >> >> >  Hi Maxime,
> >> >> >> >
> >> >> >> > On Thu, 21 Dec 2017 16:26:30 +0100
> >> >> >> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >> >> >> >
> >> >> >> > > Hi,
> >> >> >> > >
> >> >> >> > > On Thu, Dec 21, 2017 at 09:19:24AM -0600, Kyle Evans wrote:
> >> >> >> > > > On Thu, Dec 21, 2017 at 8:55 AM, Maxime Ripard
> >> >> >> > > > <maxime.ripard@free-electrons.com> wrote:
> >> >> >> > > > > Hi Kyle,
> >> >> >> > > > >
> >> >> >> > > > > On Tue, Dec 19, 2017 at 03:05:23PM -0600, kevans91@ksu.e=
du wrote:
> >> >> >> > > > >> Allwinner a83t has a 1 KB sid block with efuse for secu=
rity rootkey and
> >> >> >> > > > >> thermal calibration data, add node to describe it.
> >> >> >> > > > >>
> >> >> >> > > > >> a83t-sid is not currently supported by nvmem/sunxi-sid,=
 but it is
> >> >> >> > > > >> supported in an external driver for FreeBSD.
> >> >> >> > > > >>
> >> >> >> > > > >> Signed-off-by: Kyle Evans <kevans91@ksu.edu>
> >> >> >> > > > >
> >> >> >> > > > > The patch looks fine in itself, but we've had a number o=
f issues with
> >> >> >> > > > > the register layout (and access patterns) in the past, s=
o I'd rather
> >> >> >> > > > > have something that works in Linux too if possible.
> >> >> >> > > >
> >> >> >> > > > I have a patch that I think should make it work fine on Li=
nux [1], but
> >> >> >> > > > I'm afraid I have little to no capability to test it mysel=
f and so I
> >> >> >> > > > did not add it as well.
> >> >> >> > > >
> >> >> >> > > > I do know that the rootkey is offset 0x200 into the given =
space [2],
> >> >> >> > > > as is the case with the H3, and that the readout quirk is =
not needed.
> >> >> >> > > > I wasn't 100% sure that the a83t has 2Kbit worth of efuse =
space as the
> >> >> >> > > > H3, but I do know that thermal data can be found at 0x34 a=
nd 0x38 in
> >> >> >> > > > this space.
> >> >> >> > >
> >> >> >> > > Then maybe we should leave it aside until someone takes some=
 time on
> >> >> >> > > the A83t.
> >> >> >> >
> >> >> >> >  Take some time on the Linux driver and do not apply this patc=
h for
> >> >> >> > now you mean ?
> >> >> >>
> >> >> >> Yep.
> >> >> >>
> >> >> >> Maxime
> >> >> >
> >> >> >  Since linux doesn't have the compatible in it's driver what would
> >> >> > be the harm to add the node in the DTS ? If a quirks is needed be=
cause
> >> >> > some region is weird this would go in the driver right ? I don't =
see a
> >> >> > technical problem for adding this node right now.
> >> >> >  If Kyle confirm the lenght of the region and that no quirk is ne=
eded
> >> >> > will it be enough ?
> >> >>
> >> >> I guess I wasn't very clear. I'm OK with the patch going in. The de=
vice
> >> >> node currently says nothing about how much efuse space there is. The
> >> >> memory region covers that and the control section, and the size mat=
ches
> >> >> what the memory map says.
> >> >>
> >> >> The size and offset of the efuse space would be dealt with in the d=
river.
> >> >
> >> > Let's merge it then.
> >> >
> >> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>
> >> What does the timeline for these things normally look like? I'm new to
> >> these parts. =3D)
> >
> > We're one week away from the merge window, so it's a bit late for it
> > to be merged in 4.16, but it'll be in 4.17.

> It's been two months and this still hasn't quite landed in
> sunxi/for-next. =3D( May I ask the status on this?

It seems to have fallen through the cracks, sorry :/

Can you resend it based on 4.17?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4syblqsgtkenq3hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrYm9gACgkQ0rTAlCFN
r3R7+BAAk1r6nhdLEMwpCQG74YOvnbc/Wetd/1jioMW5eVqq5uyBflHmOMO1b7c/
tr+Fnd8PxfUTjA6FIJ/rSSk5LXGILX65HoCz1ISGFABez+5lOUHf63ivWHJADgny
HpesqsOXeb1Ty0kRObMkb6sI1yv71q+hYZO0QZErEwLB4czuBP+owYd34j4U2TTU
Im3euCAwPI9eNA6oXmdcUD3fyz6zbU1Qiswp5/2KQO3xnkjhHcmo0RxTEtN6bae+
8PLAH1swYLHnPYAvADak+nhtskw7+jeAnguz42sziel94TC2zv7QHQfxYjOJ8Zp6
c1JH0efenn0LCTHG0Ijv1FRtdG3UDr0VzSOfE+7ytqVb0uCLADM49i0prP9lUrmG
aXSJYoiH3aPuphEyXQu2OZpAWqcK1x7LQWnWO813cCeLtgHK6fvnE8r46wD8fqaM
oDw1KwpxKMvJ1M4RKAftgVrvgbJncvyzsUIczDYoWgBRRyYb0AwiHc/cvsGQebug
qxUq2Qx1kpGmB/MNqoc9z9FNKdwbrMji9c1Rmw/7I9fycJAiOWzQOaCgNVYmX1rE
B3Daw77jNYw8+SwaPP4MrPaTo+8a7IT+j1zcw1wW+PYHrg2AJzLnaplSe5DcgUuw
XkwAIQFaIlznfjcoaenJKL3k4j0TJyfD/Dq6qdcLIKKimIsUzQs=
=WWM4
-----END PGP SIGNATURE-----

--4syblqsgtkenq3hx--
