Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeBWMrZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:47:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36566 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBWMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:47:24 -0500
Date: Fri, 23 Feb 2018 13:47:20 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Message-ID: <20180223124720.wntxfitr5iu35osb@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
 <20180216155706.GS6364@atomide.com>
 <20180219130514.GC32761@sirena.org.uk>
 <20180222195418.GC5184@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z65emjrrxhm2ftu2"
Content-Disposition: inline
In-Reply-To: <20180222195418.GC5184@atomide.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z65emjrrxhm2ftu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 22, 2018 at 11:54:19AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180219 12:05]:
> > On Fri, Feb 16, 2018 at 07:57:07AM -0800, Tony Lindgren wrote:
> > > One advantage of using a compatible property for the pmic subdevices
> > > though is that it leaves out a dependency between various device
> > > drivers things happen automagically. The mfd core driver can be
> > > minimal and just implement interrupt handling and regmap. So no need
> > > to to parse the child nodes in the pmic mfd driver :)
> >=20
> > There's no need to do that anyway - with a MFD the child devices can
> > assume that they're part of the MFD and reference their parent.
> >=20
> > > So personally I'd prefer the option that requires least amount
> > > of custom code if compatible vs no compatible property is the
> > > only issue here.
> >=20
> > It's a few lines of code to register the child devices from code rather
> > than the DT, and keeps it out of the ABI.
>=20
> OK yeah that's a good point with avoiding the ABI. Seems
> we still want the dts child node(s) though. That way audio
> device can be disabled for devices where audio is not wired
> up at all on this PMIC.

We need something to identify the correct child node. If there
is no compatible, the node name will become ABI. So I don't
think we gain anything by removing the compatible. As far as
I can see it seems to be unusual to use fixed node names. I
could find some examples, but most sub-devices are identified
using compatibles. This method also has direct support in MFD
(using .of_compatible in mfd_cell).

Based on a bit of grepping through drivers/mfd/, the node name
based identification seems to be mainly used by ASoC, while most
other subsystems seem to prefer compatible based identification.

Anyways, I have implemented the node name based identification and
will post patches once I fixed the enum issue. I will probably
send them later today.

-- Sebastian

--z65emjrrxhm2ftu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqQDVcACgkQ2O7X88g7
+pqVNBAAovaQWV2URhZ0oya9TwHDO1QZVos67lwjSfiNCbgp5gRphq9jAzY8K90G
qFX/3aEZuRTyWMXC0cjC9hopqVLeBRO1+UZemr1FsLBZBXmPk93CoMXRvX++V8/R
CEsUq9rYcKCDVRoNfMg+vdoOKBRlWgBKRAiJWOroEp7wcqD3pRb3BWv2Dr3Xkwn4
rfxf97FQvd1TGEA8vw/yA+WBQbeTAHLQM0SkgNTMDkmmjf2vdNpq1MyG7oorEK4D
GgeTLzxis624bvFhrWLVk2sHZr6NzOQoJhKxnYgeoWLUUW3Gopj71lGrTnMhrqHO
I4fPvvMvo2VrS3creCmM+kZ7/lQ2QGJxOe+kNnd97ZavhVVTCAkb7an18r2ShmIf
Y1f6VSISyJmcOi94tQRSFMxo/NMVrHfQC2bovJW8jTYAf1nok6FmufFizljyny4a
GEXHphrBzXFLyzyuPAYYy/YoQArMkkrlbsRVZfzBDl4tVDxSZSmdjcOyo8s8zz+H
PZDSPZoeEIIgHu7tvWXqdC1OABQkvAlmOa+tH3F0YM8lVOsVvHrABVz/4u4OwdyW
n6wnuvC9l+s/WTAwg7syvasTqzizi05R0bqDhB5Q8p9EQiW6CWtjGRK2YETdrJ13
GeAiAvWqxqJE6KBZCgg0wPf+JLarV0RyRIIS2DDJE6Hnquxp9I8=
=Mz6H
-----END PGP SIGNATURE-----

--z65emjrrxhm2ftu2--
