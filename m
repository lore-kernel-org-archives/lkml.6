Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeDYN4N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:56:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36032 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754491AbeDYN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:56:01 -0400
Date: Wed, 25 Apr 2018 15:55:48 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [RFC 00/13] arm64: allwinner: Add A64 DE2 pipeline support
Message-ID: <20180425135548.ayeqo7t2dtbwq3of@flea>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
 <20180424140850.ptxpmtusour7u6nb@flea>
 <CAMty3ZCLOkdmCoh4uBhYKXgDEiAnw+b_z=d0Om2bjH7HLCa7Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bimpxlhks3s6pru5"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCLOkdmCoh4uBhYKXgDEiAnw+b_z=d0Om2bjH7HLCa7Tg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bimpxlhks3s6pru5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 06:29:05PM +0530, Jagan Teki wrote:
> On Tue, Apr 24, 2018 at 7:38 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 24, 2018 at 07:04:12PM +0530, Jagan Teki wrote:
> >> Allwinner A64 has display engine pipeline like other Allwinner SOC's A=
83T/H3/H5.
> >>
> >> A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to=
 tcon0 with
> >> RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with HDMI.
> >> This series merely concentrated on HDMI pipeline and rest will add eve=
ntually.
> >>
> >> patch 1: dt-bindings for a64 DE2 CCU
> >>
> >> patch 2: a64 DE2 CCU node addition
> >>
> >> patch 3: dt-bindings for a64 DE2 pipeline
> >>
> >> patch 4 - 5: dt-bindings for a64 mixer0 and tcon-lcd
> >>
> >> patch 6: a64 DE2 pipeline node addition
> >>
> >> patch 7 - 8: dt-bindings for a64 HDMI and HDMI PHY
> >>
> >> patch 9: a64 HDMI nodes addition
> >>
> >> patch 10 - 11: dt-bindings for a64 mixer1 and tcon-tv
> >>
> >> patch 12: a64 HDMI pipeline
> >>
> >> patch 13: enable HDMI out on bananpi-m64
> >>
> >> Tested HDMI on bananapi-m64 (along with DE2 SRAM C changes from [1]
> >> thread), able to detect the HDMI but, no penguins on screen.
> >>
> >> Request for any suggestions.
> >>
> >> Test log on Bananpi-m64:
> >> [    0.247631] sun4i-drm display-engine: bound 1100000.mixer (ops sun8=
i_mixer_ops)
> >> [    0.256717] sun4i-drm display-engine: bound 1200000.mixer (ops sun8=
i_mixer_ops)
> >> [    0.256783] sun4i-tcon 1c0c000.lcd-controller: Missing LVDS propert=
ies, Please upgrade your DT
> >> [    0.256792] sun4i-tcon 1c0c000.lcd-controller: LVDS output disabled
> >
> > That doesn't seem to work so well for LVDS.
> >
> >> [    0.257081] sun4i-drm display-engine: No panel or bridge found... R=
GB output disabled
> >> [    0.257099] sun4i-drm display-engine: bound 1c0c000.lcd-controller =
(ops sun4i_tcon_ops)
> >> [    0.257273] sun4i-drm display-engine: No panel or bridge found... R=
GB output disabled
> >> [    0.257288] sun4i-drm display-engine: bound 1c0d000.lcd-controller =
(ops sun4i_tcon_ops)
> >> [    0.258176] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller=
 v1.32a with HDCP (sun8i_dw_hdmi_p)
> >> [    0.258596] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI =
I2C bus driver
> >> [    0.259188] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i=
_dw_hdmi_ops)
> >> [    0.259199] [drm] Supports vblank timestamp caching Rev 2 (21.10.20=
13).
> >> [    0.259205] [drm] No driver support for vblank timestamp query.
> >> [    0.259308] [drm] Cannot find any crtc or sizes
> >
> > A good guess would be that you can't get the EDIDs for some
> > reason. Have you tried forcing a mode to see if the display part
> > already works?
>=20
> Yes I've forced and used custom EDID with 1024x786 bin and observed
> that the bin is able to load.
>=20
> [    0.262973] [drm] No driver support for vblank timestamp query.
> [    0.263842] [drm] Got built-in EDID base block and 0 extensions
> from "edid/1024x768.bin" for connector

It's not really clear, is it displaying something?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bimpxlhks3s6pru5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrgiOMACgkQ0rTAlCFN
r3QFNw/+LJeiFlPP3O3G2+yxjOkzQnI9GiEC8s6rn0ahwVnt6OTUY1+X4mnTDAkm
qFjHjpm5MiD+SNIPdlniFL6qg/krc384PswFE7I90ojCxuQLeFiApRg4qiKPlojI
aNecH3au9Kl7W5dMVf0jYpaaoc5JXIOQEs12wYy/YX5QU4KLYXh2LVlqEJ7KmqCy
F+9dZn1GfD1/1xZoI7+x/V1npbXB4h3mLvD4D5AguwpuqrXKBIAv/T74UNhVBelr
JX+sE6VfPmUD/jqJ5TzJOI06r/y2jFw6zR6baSfP89lBgr90clxPLos/CzOcsnh7
/IO532u4/AjJVZQRd+lDrIcO6DRly1dWamf2rbRTlIWgEk3atWYuKWiA/FeeqCii
/2HeE1xp0rzV+myv+om8NHjENM/6VCflG35wplRcHq3iWnrVO9WxeQFNQOblSRx5
qtgZ/g5tuN481T8A6d91I5BqhlTKdqjEGZCH7NE6u/ffnMh7xUb1oN5g/qhQJepP
cL1UJJKmwmdmzHmUw3zFzKl4pYcsM8S1ggoCrvrjAr5gamSDHFBGMeRaz80n5HIc
F7BKp0elljthxtIESac/SYwznFSyeN7Kf0QMdqmO2H0Gj+1gpnJJg8FQvvJJOjZU
/Wku2zTw989LI/FsNCKyM5SYM9KV8rDIqJKh6t3hZ55hQ0wxTBo=
=rwxm
-----END PGP SIGNATURE-----

--bimpxlhks3s6pru5--
