Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeFDQYD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:24:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54370 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeFDQX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:23:59 -0400
Date: Mon, 4 Jun 2018 18:23:57 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Message-ID: <20180604162357.rige4rcsiowdl725@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <CAGb2v667pdjfHXYpBk1ER5sC8vgpcaOFKEbEByWoD1zh9Z0cyg@mail.gmail.com>
 <20180604115034.kuy35s4ajewapk4m@flea>
 <8937075.mEvrCV6laa@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h3lseq7wzednarfl"
Content-Disposition: inline
In-Reply-To: <8937075.mEvrCV6laa@jernej-laptop>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3lseq7wzednarfl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 05:09:56PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 04. junij 2018 ob 13:50:34 CEST je Maxime Ripard napisal(=
a):
> > On Fri, Jun 01, 2018 at 09:19:43AM -0700, Chen-Yu Tsai wrote:
> > > On Fri, Jun 1, 2018 at 8:29 AM, Maxime Ripard <maxime.ripard@bootlin.=
com>=20
> wrote:
> > > > On Thu, May 31, 2018 at 07:54:08PM +0200, Jernej =C5=A0krabec wrote:
> > > >> Dne =C4=8Detrtek, 31. maj 2018 ob 11:21:33 CEST je Maxime Ripard n=
apisal(a):
> > > >> > On Thu, May 24, 2018 at 03:01:09PM -0700, Chen-Yu Tsai wrote:
> > > >> > > >> > > + if (tcon->quirks->needs_tcon_top) {
> > > >> > > >> > > +         struct device_node *np;
> > > >> > > >> > > +
> > > >> > > >> > > +         np =3D of_parse_phandle(dev->of_node,
> > > >> > > >> > > "allwinner,tcon-top",
> > > >> > > >> > > 0);
> > > >> > > >> > > +         if (np) {
> > > >> > > >> > > +                 struct platform_device *pdev;
> > > >> > > >> > > +
> > > >> > > >> > > +                 pdev =3D of_find_device_by_node(np);
> > > >> > > >> > > +                 if (pdev)
> > > >> > > >> > > +                         tcon->tcon_top =3D
> > > >> > > >> > > platform_get_drvdata(pdev);
> > > >> > > >> > > +                 of_node_put(np);
> > > >> > > >> > > +
> > > >> > > >> > > +                 if (!tcon->tcon_top)
> > > >> > > >> > > +                         return -EPROBE_DEFER;
> > > >> > > >> > > +         }
> > > >> > > >> > > + }
> > > >> > > >> > > +
> > > >> > > >> >=20
> > > >> > > >> > I might have missed it, but I've not seen the bindings
> > > >> > > >> > additions for
> > > >> > > >> > that property. This shouldn't really be done that way any=
way,
> > > >> > > >> > instead
> > > >> > > >> > of using a direct phandle, you should be using the of-gra=
ph,
> > > >> > > >> > with the
> > > >> > > >> > TCON-top sitting where it belongs in the flow of data.
> > > >> > > >>=20
> > > >> > > >> Just to answer to the first question, it did describe it in
> > > >> > > >> "[PATCH
> > > >> > > >> 07/15] dt- bindings: display: sun4i-drm: Add R40 HDMI pipel=
ine".
> > > >> > > >>=20
> > > >> > > >> As why I designed it that way - HW representation could be
> > > >> > > >> described
> > > >> > > >> that way> >>
> > > >> > > >>=20
> > > >> > > >> (ASCII art makes sense when fixed width font is used to vie=
w=20
> it):
> > > >> > > >>                             / LCD0/LVDS0
> > > >> > > >>                =20
> > > >> > > >>                 / TCON-LCD0
> > > >> > > >>                =20
> > > >> > > >>                 |           \ MIPI DSI
> > > >> > > >>=20
> > > >> > > >> mixer0          |
> > > >> > > >>=20
> > > >> > > >>        \        / TCON-LCD1 - LCD1/LVDS1
> > > >> > > >>       =20
> > > >> > > >>         TCON-TOP
> > > >> > > >>       =20
> > > >> > > >>        /        \ TCON-TV0 - TVE0/RGB
> > > >> > > >>=20
> > > >> > > >> mixer1          |          \
> > > >> > > >>=20
> > > >> > > >>                 |           TCON-TOP - HDMI
> > > >> > > >>                 |         =20
> > > >> > > >>                 |          /
> > > >> > > >>                =20
> > > >> > > >>                 \ TCON-TV1 - TVE1/RGB
> > > >> > > >>=20
> > > >> > > >> This is a bit simplified, since there is also TVE-TOP, whic=
h is
> > > >> > > >> responsible
> > > >> > > >> for sharing 4 DACs between both TVE encoders. You can have =
two
> > > >> > > >> TV outs
> > > >> > > >> (PAL/ NTSC) or TVE0 as TV out and TVE1 as RGB or vice versa=
=2E It
> > > >> > > >> even
> > > >> > > >> seems that you can arbitrarly choose which DAC is responsib=
le
> > > >> > > >> for
> > > >> > > >> which signal, so there is a ton of possible end combination=
s,
> > > >> > > >> but I'm
> > > >> > > >> not 100% sure.
> > > >> > > >>=20
> > > >> > > >> Even though I wrote TCON-TOP twice, this is same unit in HW=
=2E R40
> > > >> > > >> manual
> > > >> > > >> suggest more possibilities, although some of them seem wron=
g,
> > > >> > > >> like RGB
> > > >> > > >> feeding from LCD TCON. That is confirmed to be wrong when
> > > >> > > >> checking BSP
> > > >> > > >> code.
> > > >> > > >>=20
> > > >> > > >> Additionally, TCON-TOP comes in the middle of TVE0 and LCD0,
> > > >> > > >> TVE1 and
> > > >> > > >> LCD1 for pin muxing, although I'm not sure why is that need=
ed at
> > > >> > > >> all,
> > > >> > > >> since according to R40 datasheet, TVE0 and TVE1 pins are
> > > >> > > >> dedicated and
> > > >> > > >> not on PORT D and PORT H, respectively, as TCON-TOP
> > > >> > > >> documentation
> > > >> > > >> suggest. However, HSYNC and PSYNC lines might be shared bet=
ween
> > > >> > > >> TVE
> > > >> > > >> (when it works in RGB mode) and LCD. But that is just my gu=
ess
> > > >> > > >> since
> > > >> > > >> I'm not really familiar with RGB and LCD interfaces.
> > > >> > > >>=20
> > > >> > > >> I'm really not sure what would be the best representation in
> > > >> > > >> OF-graph.
> > > >> > > >> Can you suggest one?
> > > >> > > >=20
> > > >> > > > Rob might disagree on this one, but I don't see anything wro=
ng
> > > >> > > > with
> > > >> > > > having loops in the graph. If the TCON-TOP can be both the i=
nput
> > > >> > > > and
> > > >> > > > output of the TCONs, then so be it, and have it described th=
at
> > > >> > > > way in
> > > >> > > > the graph.
> > > >> > > >=20
> > > >> > > > The code is already able to filter out nodes that have alrea=
dy
> > > >> > > > been
> > > >> > > > added to the list of devices we need to wait for in the comp=
onent
> > > >> > > > framework, so that should work as well.
> > > >> > > >=20
> > > >> > > > And we'd need to describe TVE-TOP as well, even though we do=
n't
> > > >> > > > have a
> > > >> > > > driver for it yet. That will simplify the backward compatibi=
lity
> > > >> > > > later
> > > >> > > > on.
> > > >> > >=20
> > > >> > > I'm getting the feeling that TCON-TOP / TVE-TOP is the glue la=
yer
> > > >> > > that
> > > >> > > binds everything together, and provides signal routing, kind of
> > > >> > > like
> > > >> > > DE-TOP on A64. So the signal mux controls that were originally
> > > >> > > found
> > > >> > > in TCON0 and TVE0 were moved out.
> > > >> > >=20
> > > >> > > The driver needs to know about that, but the graph about doesn=
't
> > > >> > > make
> > > >> > > much sense directly. Without looking at the manual, I understa=
nd it
> > > >> > > to
> > > >> > > likely be one mux between the mixers and TCONs, and one betwee=
n the
> > > >> > > TCON-TVs and HDMI. Would it make more sense to just have the g=
raph
> > > >> > > connections between the muxed components, and remove TCON-TOP =
=66rom
> > > >> > > it, like we had in the past? A phandle could be used to refere=
nce
> > > >> > > the TCON-TOP for mux controls, in addition to the clocks and
> > > >> > > resets.
> > > >> > >=20
> > > >> > > For TVE, we would need something to represent each of the outp=
ut
> > > >> > > pins,
> > > >> > > so the device tree can actually describe what kind of signal, =
be it
> > > >> > > each component of RGB/YUV or composite video, is wanted on each
> > > >> > > pin,
> > > >> > > if any. This is also needed on the A20 for the Cubietruck, so =
we
> > > >> > > can
> > > >> > > describe which pins are tied to the VGA connector, and which o=
ne
> > > >> > > does
> > > >> > > R, G, or B.
> > > >> >=20
> > > >> > I guess we'll see how the DT maintainers feel about this, but my
> > > >> > impression is that the OF graph should model the flow of data be=
tween
> > > >> > the devices. If there's a mux somewhere, then the data is defini=
tely
> > > >> > going through it, and as such it should be part of the graph.
> > > >>=20
> > > >> I concur, but I spent few days thinking how to represent this sane=
ly in
> > > >> graph, but I didn't find any good solution. I'll represent here my
> > > >> idea and please tell your opinion before I start implementing it.
> > > >>=20
> > > >> First, let me be clear that mixer0 and mixer1 don't have same
> > > >> capabilities
> > > >> (different number of planes, mixer0 supports writeback, mixer1 does
> > > >> not,
> > > >> etc.). Thus, it does matter which mixer is connected to which
> > > >> TCON/encoder.
> > > >> mixer0 is meant to be connected to main display and mixer1 to
> > > >> auxiliary. That obviously depends on end system.
> > > >>=20
> > > >> So, TCON TOP has 3 muxes, which have to be represented in graph. T=
wo of
> > > >> them are for mixer/TCON relationship (each of them 1 input and 4
> > > >> possible outputs) and one for TV TCON/HDMI pair selection (2 possi=
ble
> > > >> inputs, 1 output).
> > > >>=20
> > > >> According to current practice in sun4i-drm driver, graph has to ha=
ve
> > > >> port 0, representing input and port 1, representing output. This w=
ould
> > > >> mean that graph looks something like that:
> > > >>=20
> > > >> tcon_top: tcon-top@1c70000 {
> > > >>=20
> > > >>       compatible =3D "allwinner,sun8i-r40-tcon-top";
> > > >>       ...
> > > >>       ports {
> > > >>      =20
> > > >>               #address-cells =3D <1>;
> > > >>               #size-cells =3D <0>;
> > > >>              =20
> > > >>               tcon_top_in: port@0 {
> > > >>              =20
> > > >>                       #address-cells =3D <1>;
> > > >>                       #size-cells =3D <0>;
> > > >>                       reg =3D <0>;
> > > >>                      =20
> > > >>                       tcon_top_in_mixer0: endpoint@0 {
> > > >>                      =20
> > > >>                               reg =3D <0>;
> > > >>                               remote-endpoint =3D <&mixer0_out_tco=
n_top>;
> > > >>                      =20
> > > >>                       };
> > > >>                      =20
> > > >>                       tcon_top_in_mixer1: endpoint@1 {
> > > >>                      =20
> > > >>                               reg =3D <1>;
> > > >>                               remote-endpoint =3D <&mixer1_out_tco=
n_top>;
> > > >>                      =20
> > > >>                       };
> > > >>                      =20
> > > >>                       tcon_top_in_tcon_tv: endpoint@2 {
> > > >>                      =20
> > > >>                               reg =3D <2>;
> > > >>                               // here is HDMI input connection, pa=
rt of
> > > >>                               board DTS
> > > >>                               remote-endpoint =3D <board specific =
phandle
> > > >>                               to TV TCON output>;
> > > >>                      =20
> > > >>                       };
> > > >>              =20
> > > >>               };
> > > >>              =20
> > > >>               tcon_top_out: port@1 {
> > > >>              =20
> > > >>                       #address-cells =3D <1>;
> > > >>                       #size-cells =3D <0>;
> > > >>                       reg =3D <1>;
> > > >>                      =20
> > > >>                       tcon_top_out_tcon0: endpoint@0 {
> > > >>                      =20
> > > >>                               reg =3D <0>;
> > > >>                               // here is mixer0 output connection,=
 part
> > > >>                               of board DTS
> > > >>                               remote-endpoint =3D <board specific =
phandle
> > > >>                               to TCON>;
> > > >>                      =20
> > > >>                       };
> > > >>                      =20
> > > >>                       tcon_top_out_tcon1: endpoint@1 {
> > > >>                      =20
> > > >>                               reg =3D <1>;
> > > >>                               // here is mixer1 output connection,=
 part
> > > >>                               of board DTS
> > > >>                               remote-endpoint =3D <board specific =
phandle
> > > >>                               to TCON>;
> > > >>                      =20
> > > >>                       };
> > > >>                      =20
> > > >>                       tcon_top_out_hdmi: endpoint@2 {
> > > >>                      =20
> > > >>                               reg =3D <2>;
> > > >>                               remote-endpoint =3D <&hdmi_in_tcon_t=
op>;
> > > >>                      =20
> > > >>                       };
> > > >>              =20
> > > >>               };
> > > >>      =20
> > > >>       };
> > > >>=20
> > > >> };
> > > >=20
> > > > IIRC, each port is supposed to be one route for the data, so we wou=
ld
> > > > have multiple ports, one for the mixers in input and for the tcon in
> > > > output, and one for the TCON in input and for the HDMI/TV in
> > > > output. Rob might correct me here.
>=20
> Ok, that seems more clean approach. I'll have to extend graph traversing=
=20
> algorithm in sun4i_drv.c, but that's no problem.
>=20
> Just to be clear, you have in mind 3 pairs of ports (0/1 for mixer0 mux, =
2/3=20
> for mixer1 and 4/5 for HDMI input), right? That way each mux is represent=
ed=20
> with one pair of ports, even numbered for input and odd numbered for outp=
ut.

Yep, unless Rob feels otherwise.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--h3lseq7wzednarfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsVZ5wACgkQ0rTAlCFN
r3Q9HA/8C4NE8CZf2uoqoL0qL+LgrWTNcP7Zd0XzZO/rEFEYp25IKnSEB0psv1c5
C/ASG4b2pRtjfGaMgN4Z3opgpVztqbWKLWP26aK6HzQkUmPtHiGRP/EC2bMEpG6K
h1im/0LTZrfLeeq36GC/6kwJhn+UcKZjNBeKZDhbeubUyNe6BDli6SGKtj6bPoPg
BAnTnD86h4hJFrDFRIEYD+/IDDayNN4l67lLt3OeHdLAofYbHhJbut7ieysOgpCO
UUA4Q9D67Cqwn8FJlZ0djaNcAzuZTq+mngbTsgNCHnnTWO0YmuxMXzavRH1ZP4dG
8+F2MYcRhb390167GydQRY/FOGe79vNSOky2ke+FubybHNAlT2VtmivFmRvX1vqH
G/m2SuafchRmoviykTxSIv6Na1/e3guVWLsovSVoAMKOqPgEMdVX1K0TpUJoWYLU
sH7u8OHFvM946gA5rFhy92VabsL9wxYPKJFB7dfgNMkwHsDULHVSCNOTE3duSDAh
9D8KwK1yRvQh5t0V0Gek/x5kHsnoL0OGefHv77mddJhJzZiwerI1NAxD+WiQsGg+
HSnOHvCaSsygSFD8FSQLynST5ONBPRN+qKzaV/MIUNdXkq9sj22nKS/xH7k1rYXU
obw6anM8sZ4QDArZ/bZRKo7qsH4HpnfctWNrvrIIXO1/DuVpxS4=
=ppNR
-----END PGP SIGNATURE-----

--h3lseq7wzednarfl--
