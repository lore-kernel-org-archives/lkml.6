Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeC2SkT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:40:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48353 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeC2SkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:40:09 -0400
Date: Thu, 29 Mar 2018 20:40:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Dan Williams <dcbw@redhat.com>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Message-ID: <20180329184007.GA27688@amd>
References: <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20180329164113.GR5700@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-03-29 09:41:13, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180329 16:38]:
> > Hi!
> >=20
> > > > > > And I do hear a voice talking over the speakerphone :) Sorry ha=
ve not tested the
> > > > > > mic yet..
> > > >=20
> > > > And calling a person I can hear the other end but the mic is
> > > > not working. So maybe I need to tweak the alsamixer settings
> > > > too for mic?
> > >=20
> > > Your override kills most settings from alsamixer. You can try to
> > > just override CPCAP_REG_VAUDIOC, CPCAP_REG_CC and CPCAP_REG_CDI
> > > and setup everything else with alsamixer.
> >=20
> > I tried that, and could not get it to work; will try some more.
> >=20
> > Is there easy way to get the register dump?
>=20
> For mainline kernel:
>=20
> # cat /sys/kernel/debug/regmap/spi0.0/registers
>=20
> For Android v3.0.8 kernel, see cpcaprw on github.

Thanks. I got call working including outgoing audio: in capture
settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
the other phone muted, so I don't yet know if such call would be of
usable quality.

Thanks!
								Pavel

--- tony.as	2018-03-29 18:29:41.715742372 +0000
+++ mic.as	2018-03-29 18:33:40.910759649 +0000
@@ -258,8 +258,8 @@
 0404: 0000
 0408: 0000
 040c: 0000
-0410: 0014
-0414: 0104
+0410: 0004
+0414: 0105
 0418: 000e
 041c: 00ff
 0420: 44d3
@@ -515,8 +515,8 @@
 0808: ae0a
 080c: 0078
 0810: 003c
-0814: 0cc0
-0818: 0610
+0814: 0cc4
+0818: 061f
 081c: 0006
 0820: 0b2c
 0824: 0606
@@ -641,13 +641,13 @@
 0a00: 0000
 0a04: 23b6
 0a08: 002b
-0a0c: 1530
+0a0c: 18ec
 0a10: 0000
-0a14: 4e54
-0a18: 0036
+0a14: 6a90
+0a18: 0040
 0a1c: 0000
 0a20: 0000
-0a24: 0738
+0a24: 0b40
 0a28: 0000
 0a2c: 0000
 0a30: 0000
@@ -769,12 +769,12 @@
 0c00: 9004
 0c04: 0136
 0c08: 0000
-0c0c: 02fb
+0c0c: 02fc
 0c10: 01da
-0c14: 015b
-0c18: 0300
-0c1c: 0271
-0c20: 01e5
+0c14: 015a
+0c18: 02fe
+0c1c: 0270
+0c20: 01f5
 0c24: 0000
 0c28: 0204
 0c2c: 0205

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq9MwcACgkQMOfwapXb+vKNFwCfXxd9MPUKRnmKkwjQ8hYcx0sN
0WgAoILdNTLj1n+vHTeXXGgbrqhenCwt
=Mqev
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
