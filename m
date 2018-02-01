Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeBAMqG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:46:06 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47862 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeBAMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:46:03 -0500
Date: Thu, 1 Feb 2018 13:45:51 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun4i-a10: Fix mali changing dclk
 frequency
Message-ID: <20180201124551.kfyz6frx4lcx4wbz@flea.lan>
References: <1517354639-92978-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180131084349.du2ijvhh5rxa5vvt@flea.lan>
 <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2bmercrj53gfillq"
Content-Disposition: inline
In-Reply-To: <7be1e297-4fac-a7a2-a8cc-54061d4e2fde@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2bmercrj53gfillq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 01:05:38PM +0100, Giulio Benetti wrote:
> Hi,
>=20
> Il 31/01/2018 09:43, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Wed, Jan 31, 2018 at 12:23:59AM +0100, Giulio Benetti wrote:
> > > When mali.ko is inserted, it set default clocks and call all parent
> > > clocks to stay into range, causing pll-video0 to change and
> > > subsequently to change dclk to wrong frequencies.
> >=20
> > This is what you should fix.
>=20
> Ok, so it must be patch title(shrinked of course), right?
>=20
> >=20
> > > "gpu" clock has lot of parent plls inside driver, but on sun7i
> > > pll8-gpu does not depend on pll-video0, pll-ve, pll-video1.
> > >=20
> > > It only depends on 24Mhz main clock.
> >=20
> > I don't really know why you are mentionning that. The GPU clock has
> > all the parents described in the driver. And the parents' parents are
> > irrelevant to this particular issue.
> >=20
> > > Remove all pll parents from gpu_parents_sun7i except "pll-gpu".
> >=20
> > However, this is not a proper fix for your issue.
>=20
> Yes, you're right, now I understand.
>=20
> It is more complex than I thought.
> I need to dig more and study better A20 CCU.
>=20
> So this patch can be dropped.
>=20
> >=20
> > What kernel version did you use?
>=20
> Latest mainline.

I guess this patch could fix it:
http://code.bulix.org/1kitrq-268936?raw

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2bmercrj53gfillq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpzC/4ACgkQ0rTAlCFN
r3Rqhg/9EZ2j/qkexuIr2SeaN9UY9MJR5owF0HL7IxqRaf+qgtfG1noTyCBmbUkq
ngs1XtccrNgbYJc8ARGQqAn+HnA2lL4wUYL4S85WYUKTzDadpVwoUjB1IexXDyqk
aCwarI8wfNhSTp9fpW6JiVyDYL8qrnhKq6AEFN1gevcjXb7DK0OfVgtNzBybwYwT
boAVswtw7bKAq9PCf22OzxHoMU3VDRXiNPtwx81L28UFIeJvYaAVhQ9hV+/vOKHj
/T5c8e2DuGfkan1Cx8OlTrY8Xm+MWyKwbBKY+5K2Al7DX16QdXoXQSOu+Zdp2Kzn
LCbr2RkNroEtS7atFk8Z4YBqwb6E9H5ZEf2L3gCg1HMqvdE7IqQAvupBQ4psisNI
NkekHjRdR8PhKNdXEhShornzPh3Jd36CKYZg5wu0mDqN5aeKL+mZdkwvEah0MTe6
C5M1astxuMPp8tWLbtpR6bWSiGQFBqGWAaN0rKzNY4cT9Amm3NXQQNOlu5e+rgTN
wL21PKlQ84bEYouOHzeEZiq1zKFS4jE9Xrojit5MkzpEoEfhjEG1U/CXY5VgiZ8Z
25vrY2AOK8y/oIfpYgKj2guuDU1CeO+Ao/Ojw90RPGiM+oX5CFVK/5fz0XAnL12I
BshUi+yjkmnYLCZ06WlaRHdD6Ixb9RV9ZPISwLrzx8LQU3phcqY=
=1Lpv
-----END PGP SIGNATURE-----

--2bmercrj53gfillq--
