Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeCNIBM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:01:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43737 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752882AbeCNIBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:01:11 -0400
Date: Wed, 14 Mar 2018 09:01:08 +0100
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
Message-ID: <20180314080108.2ay6jslwmzp5fsf5@flea>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-4-harald@ccbib.org>
 <20180313082724.7optc2xwgqoiibtx@flea>
 <E1evg4e-0000Qj-2w@stardust.g4.wien.funkfeuer.at>
 <20180313153522.haeemlqbtuei5zb3@flea>
 <E1evn97-0000U0-Fp@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gce2ojw6ywgp32lb"
Content-Disposition: inline
In-Reply-To: <E1evn97-0000U0-Fp@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gce2ojw6ywgp32lb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 05:51:29PM +0100, Harald Geyer wrote:
> Maxime Ripard writes:
> > Hi,
> >=20
> > On Tue, Mar 13, 2018 at 10:18:22AM +0100, Harald Geyer wrote:
> >> Maxime Ripard writes:
> >>> On Mon, Mar 12, 2018 at 04:10:48PM +0000, Harald Geyer wrote:
> >>>> The A64 SoC features two display pipelines, one has a LCD output, the
> >>>> other has a HDMI output.
> >>>>
> >>>> Add support for simplefb for the LCD output. Tested on Teres I.
> >>>>
> >>>> This patch was inspired by work of Icenowy Zheng.
> >>>>
> >>>> Signed-off-by: Harald Geyer <harald@ccbib.org>
> >>>> ---
> >>>> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 +++++++++++++++++=
+++
> >>>> 1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>> index ca1b365bc722..05d5e8def68a 100644
> >>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >>>> @@ -52,6 +52,26 @@
> >>>> 	#address-cells =3D <1>;
> >>>> 	#size-cells =3D <1>;
> >>>>
> >>>> +	chosen {
> >>>> +		#address-cells =3D <1>;
> >>>> +		#size-cells =3D <1>;
> >>>> +		ranges;
> >>>> +
> >>>> +/*
> >>>> + * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CC=
U.
> >>>> + * However there is no support for this clock on A64 yet, so we dep=
end
> >>>> + * on the upstream clocks here to keep them (and thus CLK_MIXER0) u=
p.
> >>>> + */
> >>>=20
> >>> There's definitely support for the CLK_MIXER0 clock in the DE2 CCU
> >>> driver, so I guess this would need to be amended / fixed
> >>=20
> >> AFAIK on the A64 a special sram quirk is necessary, that never got mer=
ged:
> >> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1574303.h=
tml
> >>=20
> >> I asked Icenowy if I should resubmit her patch as part of this series,
> >> but was told further discussion is necessary. I'm sure she can better
> >> explain the details than me.
> >>=20
> >> Actually if it wasn't for the sram quirk, there is a simplefb patch by
> >> her, that could have been merged long ago:
> >> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1574304.h=
tml
> >=20
> > The issue with your patch is that, as soon as that clock is
> > functional, the DT with the node you were introducing here will no
> > longer be.
> >=20
> > And since people use their firmware DT or put them in NOR these days,
> > you can't really expect them to update them every release either.
>=20
> How is this a problem? - The clock can't be functional without adding
> a DT node for it's driver. So the breakage can only happen on DT update,
> which means we can avoid it, by moving the clocks to the proper places
> when we add the node actually using them for real.

Ah, sorry I missed it. Yeah, that would work.

> > I guess a proper solution would be to respin that patch.
>=20
> Sure, but as mentioned above I offered to do that and was told not to.
>=20
> As a compromise I could also move the simple framebuffer node from the
> A64 dtsi to the teres-i dts, where we know that the DT can be updated
> easily?

That's a matter of usecase, not only hardware, so this wouldn't work.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gce2ojw6ywgp32lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqo1sMACgkQ0rTAlCFN
r3Sz2w//bZXMLBG4+C0DN+U5G2nAnJyuduYcR8TviF+F1X2doSTi+STwimRG3IH8
oMO1v7WJTr8DFCcsE8X3HITFEE9JDSiI5nHDj7uabG/1WcidnOWYOFVWBe4koDEQ
Wg7JdRULLZm13lY2ukhz1MVf5x10/OWmh6syAZ13soEAEJBw3bajKVHaXJGSXhWV
Tm8mgdLipwHZoRd6VBo6u8cbSKlZzkuUm8MwbuP408M06XtUVu1FBzl6JiKZ9WXD
jF7tAPg1HWOqKD/GyDymgG3hybcse7HNOTM4HoUvdzVs0MP4rbkp4AQk8UfG8nfR
yr+cg8YN/2zQQO4hutR7FTSP4MWB9LL14drOAYs0NlzWAfPtwMAEEWjLVqwxiRyB
Uo7BOCbK0E5KUvV2H9YMUhunsGmVkc+YifpfHqDIRVonqr1jCidLkmBX6VNgAWFR
ygZZbv/CrgLuFmRgfmiL5lHJifPgM6KtHBysts1YCohOJ/C0ESQ3Rrf2XFK45SKr
8YR2liW+5rkvQOQaD0mGIHjzh770SbGyqB4XQ3+v/wdxBJC9nfpjen4i1ievmbwr
zoeSIlGMgla0VIaEI+B6OKsHFR4izHlLyeEYRcRsg2IHfkwrGdVADlWHrCOHoE7D
wIBH1FcVjpGZn31WvOebG4TtSNzKCDyduLIQ+kbgkx6uQhwXxCU=
=yXHA
-----END PGP SIGNATURE-----

--gce2ojw6ywgp32lb--
