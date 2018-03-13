Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933991AbeCMQPE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:15:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50497 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934015AbeCMPfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:35:34 -0400
Date: Tue, 13 Mar 2018 16:35:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 3/5] arm64: dts: allwinner: a64: add simplefb for A64 SoC
Message-ID: <20180313153522.haeemlqbtuei5zb3@flea>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-4-harald@ccbib.org>
 <20180313082724.7optc2xwgqoiibtx@flea>
 <E1evg4e-0000Qj-2w@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ku77t5fsink4ymvn"
Content-Disposition: inline
In-Reply-To: <E1evg4e-0000Qj-2w@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ku77t5fsink4ymvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 13, 2018 at 10:18:22AM +0100, Harald Geyer wrote:
> Maxime Ripard writes:
> > On Mon, Mar 12, 2018 at 04:10:48PM +0000, Harald Geyer wrote:
> >> The A64 SoC features two display pipelines, one has a LCD output, the
> >> other has a HDMI output.
> >>
> >> Add support for simplefb for the LCD output. Tested on Teres I.
> >>
> >> This patch was inspired by work of Icenowy Zheng.
> >>
> >> Signed-off-by: Harald Geyer <harald@ccbib.org>
> >> ---
> >> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++++++++++++
> >> 1 file changed, 20 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index ca1b365bc722..05d5e8def68a 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -52,6 +52,26 @@
> >> 	#address-cells =3D <1>;
> >> 	#size-cells =3D <1>;
> >>
> >> +	chosen {
> >> +		#address-cells =3D <1>;
> >> +		#size-cells =3D <1>;
> >> +		ranges;
> >> +
> >> +/*
> >> + * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
> >> + * However there is no support for this clock on A64 yet, so we depend
> >> + * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
> >> + */
> >=20
> > There's definitely support for the CLK_MIXER0 clock in the DE2 CCU
> > driver, so I guess this would need to be amended / fixed
>=20
> AFAIK on the A64 a special sram quirk is necessary, that never got merged:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1574303.html
>=20
> I asked Icenowy if I should resubmit her patch as part of this series,
> but was told further discussion is necessary. I'm sure she can better
> explain the details than me.
>=20
> Actually if it wasn't for the sram quirk, there is a simplefb patch by
> her, that could have been merged long ago:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1574304.html

The issue with your patch is that, as soon as that clock is
functional, the DT with the node you were introducing here will no
longer be.

And since people use their firmware DT or put them in NOR these days,
you can't really expect them to update them every release either.

I guess a proper solution would be to respin that patch.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ku77t5fsink4ymvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqn77kACgkQ0rTAlCFN
r3Shjw/+NpX/NkKxJFJG0MdVnCvHjms5XDB/izbk/MNgzVBOtIAO9Wr39VxZXS0k
h1OuISa/GLitGXjW6LTxO6RzivfzuLhY/wOooorJtpNBUiTDL8hrwTTjrVj6ga/7
X1pTWNv6YKS05uzHr4X68KZekEhsPXiJB7UIRz2ny4vjXHoMyeWlkelIcYdWfZ8Y
cL+IPhOXw4dWg0zyINM7hTgIYQtngCt3FyLKhewwAfz4mJU+jqcp0YWSzCgeRZDj
AARc84qAjegL2kYaEPG717ya3sYt5Jljrzt59WAtHyphyOCCkcFGPFuknxpGsVV1
frVmfxXksFvHoUolEJWPXDYbOgGOEy5VKBf1rCRDGm/s0x8OOmLLxt34wZyJeY4g
CJM79t6ZhoL1i39UFG+IJhzki3dV7HAWMf2KbgfF0VplZwJvOKKMRspCKbZ/J0Tr
eouICwDYCxQHva5QAlGN91WYcglzwyc25WhnoCX4TGbQmxBJJokmUQ4JOhrrRdcN
Yq5wSkN9drDlhb8ZfjpGyqh7wfTeZjl8vrYo7cIuBgrEoyd1dV6noVcudF/hmGDd
mu6z99WUnYDtZtFsLvznd1ACPFyfNVgyAfx05FSf7trPRkK/gVe7+3/f7F6IncAI
dXakAvntGg1rMoZRlytbO+9bUxcYBRFxWe2Y7JNgYdJRHiZHylM=
=Nbua
-----END PGP SIGNATURE-----

--ku77t5fsink4ymvn--
