Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeEBJgS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:36:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42839 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeEBJgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:36:13 -0400
Date: Wed, 2 May 2018 11:36:01 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
Message-ID: <20180502093601.fvkacdv62aqxshbr@flea>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hitkphtdp4xe2f6f"
Content-Disposition: inline
In-Reply-To: <45956397-a593-e51e-8637-655178c5901c@arm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hitkphtdp4xe2f6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 10:47:35AM +0100, Andre Przywara wrote:
> >> I am just asking because I want to avoid running into the same problem
> >> as with the A64 before: that future DTs become incompatible with older
> >> kernels, because we change the power supply to point to the AXP
> >> regulators, which this kernel does not support yet.
> >=20
> > The answer is just not to keep this compatibility, as it's not
> > supported option to update DT without updating kernel.
>=20
> Well, I recognise that statement.. ;-) and I understand that it's far
> easier to handle it this way. But:
> - Which .dtb are we going to write into the SPI flash? An older one,
> which covers all kernels, but lacks features? Or a newer one, which
> limits the bootable kernels to recent versions?
> - Which DT are we going to give to EFI applications?
> - Which DT are the BSDs suspected to take? They don't ship their own DTs
> (which is good!).
>=20
> So I understand that "shipping the DT with the kernel" is the old
> (embedded!) way of doing things, but I really believe we should stop
> relying on this and try to come up with backwards compatible DTs, which
> live in the firmware and get updated there. Because this is what the
> distros seem to expect from ARM64 boards these days.

You're not talking about backward compatibility, you're talking about
forward compatibility. All the changes in this patch and the one
predicted by Icenowy are backward compatible.

> >> It looks like there are more users of those power rails, so we could
> >> keep those supplies connected to these fixed regulators here, even with
> >> AXP-805 support in the kernel.
> >=20
> > It's not a good choice.
> >=20
> >>
> >> Or we keep this back until we get proper AXP support in the kernel? I
> >> guess it's quite close to the existing PMICs, so it might be more a
> >> copy&paste exercise to support the AXP-805?
> >=20
> > It's not a reason to keep it back.
>=20
> So I compared the manuals of the AXP806 and the AXP805, the register
> interface looks identical to me. I only have a (somewhat) Chinese
> version of the AXP806 manual, so couldn't really find the difference
> between the two. Do you know more about it? Is it just maybe the
> packaging and the electrical properties (like max current supported)?
>
> If the I2C register interface is really the same, we could just add the
> DT nodes for the regulator and be done.

And that argument is only valid if you 100% trust the fact that both
datasheet are complete and accurate.

And experience show that you can't.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hitkphtdp4xe2f6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrphoAACgkQ0rTAlCFN
r3QQfRAAkm5+mS4qq4o5lETjUPAWkEcbs0f3enZO6U49mn6mcn2YVYiY08czxM/a
6I4bICs8usE59DkHyovV4CZADNgB3cN9W1AbHQhgd1d7sQGK3BrgYfNSulc6Z7CJ
gq19k7A56mL8GxzY9H7LPzvk42mc8IQaM3Vk8CHRA6AkJ6CIIw3/5ivNaF9wOzuJ
hpDEaxuNig/hUgiGlqsO1/4w8q8IGSzyrUxav7SuoJX9S5KZyjD6WchjlC0InBkd
J4OKBNAz2B+LHVk/K60puXhodIx5VWkWPtgrXVwTgEvTwQJIXPzTbZMs3yHLh/ls
3LiAHBJN60vB8gGxxOqP9Nqv9RQMAjl1ni+Leu1RVSNidqKKnWPiXEixe2bkK5cN
xB0TvAWvMVVblC6GzOJ5j1HexHN8YrY4E680vgRwCc/jgyWx8LqYmZPcfVCazeNa
tjUa8NCPVqDOuXXqOXWRS4VCweAg2pWdRWQX2jCLsC4I050NEmgMmXYW+EPzbbDu
GLML8bwnIrNmB6j2e7uZA3XozaPKEK9+mDxiEX9ZizZs56np0Kf6Z10EuVw1hmrH
Isek+2vcH89iMs9AFF5xmrFTQLPmfCf28f0l0XY00BPQBTso08rGl0/hwd/1OsUe
7KgepTrkaqREyXwlN8T7yt1yMGysLYStLw0+iDr09OrQmv/AzUQ=
=uLWa
-----END PGP SIGNATURE-----

--hitkphtdp4xe2f6f--
