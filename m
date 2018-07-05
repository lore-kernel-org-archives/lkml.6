Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB09C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C722410F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C722410F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeGEIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:04:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41500 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753348AbeGEIEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:04:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B9E6207D4; Thu,  5 Jul 2018 10:04:19 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 527C0203EC;
        Thu,  5 Jul 2018 10:04:19 +0200 (CEST)
Date:   Thu, 5 Jul 2018 10:04:20 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] drm/sun4i: Implement zpos for DE2
Message-ID: <20180705080420.tlwcz7ly5l6xc5rl@flea>
References: <20180627164514.4777-1-jernej.skrabec@siol.net>
 <8012754.crdjCMeE0H@jernej-laptop>
 <20180629071746.ohdhg6mgj6knyijp@flea>
 <10555591.O1hNBsOQsL@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rteifne7bjuvhn7l"
Content-Disposition: inline
In-Reply-To: <10555591.O1hNBsOQsL@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rteifne7bjuvhn7l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 08:59:03PM +0200, Jernej =C5=A0krabec wrote:
> Dne petek, 29. junij 2018 ob 09:17:46 CEST je Maxime Ripard napisal(a):
> > On Wed, Jun 27, 2018 at 10:58:28PM +0200, Jernej =C5=A0krabec wrote:
> > > Dne sreda, 27. junij 2018 ob 20:25:00 CEST je Maxime Ripard napisal(a=
):
> > > > Hi!
> > > >=20
> > > > On Wed, Jun 27, 2018 at 06:45:14PM +0200, Jernej Skrabec wrote:
> > > > > Initial implementation of DE2 planes only supported fixed zpos.
> > > > >=20
> > > > > Expand implementation with configurable zpos property.
> > > > >=20
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > >=20
> > > > Thanks for that work. I guess you should expand a bit on the exact
> > > > setup you're doing here.
> > >=20
> > > OK.
> > >=20
> > > > Are the pipes working the same way on the DE2 than on DE1, ie does =
the
> > > > pipe blending applies before the alpha blending, and therefore you
> > > > need to make sure that there's not two planes with alpha going to t=
he
> > > > same pipe?
> > >=20
> > > I'm not familiar with DE1 and I'm not sure what the problem is.
> >=20
> > The alpha blending is happening after the pipe blending. So you
> > basically have a two-stage blending, the first one between the planes
> > assigned to a pipe, only taking the plane priority into account, and
> > using the highest priority plane's pixel in overlapping area. And
> > then, you have alpha blending between the two pipes.
> >=20
> > But that means that if you have two planes with alpha assigned to the
> > same pipe, it's not going to work since the value and alpha of the
> > lowest priority plane is going to be dropped in favor of the highest
> > priority, instead of having transparency.
>=20
> This sounds familiar. Each channel contains 4 overlays. Those overlays ha=
ve=20
> fixed order, cannot be scaled and only blending supported is premultiply.=
 This=20
> is the first step HW does. I guess this is the thing similar to DE1 plane=
=20
> blending.
>=20
> After that, HW scaling is done on channel level (if it is enabled). Then=
=20
> channels are mapped (reordered) to pipes according to route register and =
at=20
> the end, alpha blending is done between pipes.
>=20
> As you can see, overlays don't fit in DRM concept. They have relative pos=
ition=20
> to channel zpos setting and scalling can't be done on them, with only=20
> premultipy supported. Because of those limitations, only one overlay is u=
sed=20
> in one channel. With this restriction, everything else falls pretty nicel=
y=20
> into DRM concept.

I guess you could expose them as planes, but you'd need to improve the
current atomic_check to make sure that all these constraints are
met. That's definitely a topic for another patch serie though.

> > > However, there is an issue in DE2 when alpha blending multiple planes=
 if
> > > bottom-most plane doesn't cover all screen. In this case alpha blendi=
ng
> > > produce weird result on screen. Fortunately, there is elegant solutio=
n.
> > > Black opaque fill color is enabled for pipe 0 (always at the bottom),
> > > which covers any "undefined region" and that makes alpha blending hap=
py
> > > again.
> > >=20
> > > Alternatively, blending modes between planes could be tweaked or
> > > disabled, but I found aforementioned solution is much simpler and
> > > you set it only once.
> >=20
> > Yeah, we had a similar behaviour as well, if the lowest plane has a
> > some alpha (!=3D 0xff), the pixel value is completely dropped. We worked
> > around this by preventing any plane with alpha at the lowest position,
> > but it might be a good idea to check if the background color set to
> > black fixes it. I remember that we were indeed seeing the background
> > color, but I don't think I tried setting it to black and seeing what
> > happens.
> >=20
>=20
> I tested both corner cases I could think of and all seems to be fine. The=
se=20
> are:
> 1. Having bottom-most plane only partialy covered. This caused issues wit=
h=20
> alpha blending. Solution is to set opaque black fill color to bottom-most=
=20
> pipe. In this case, previously undefined region doesn't have undefined pi=
xel=20
> data and blending is correct.
> 2. Bottom-most plane has alpha values <0xff. This doesn't cause any issue=
 at=20
> all. I suspect that the reason for that is background color set to black.

Ok, that's good.

> > > > Also, you seem to use the pipe and channels indifferently now, why =
is
> > > > that?
> > >=20
> > > Why do you think so?
> >=20
> > Your driver used to use the channel id, and is now replaced by the
> > zpos assigned (for example in SUN8I_MIXER_BLEND_PIPE_CTL_EN)
>=20
> zpos represents pipe number, so that is correct thing to do.
>=20
> I think I know what bothers you. Patch shows only part of the changed=20
> functions. Please take a look at final functions. sun8i_vi_layer_enable()=
 and=20
> sun8i_vi_layer_update_coord() still work (mostly) based on channel id.
>=20
> For example, sun8i_vi_layer_update_coord() function sets almost all of th=
e=20
> registers based on channel id. Only output size after scaling is set base=
d on=20
> pipe (zpos) id.
>=20
> More precisely, zpos has to be used for reading/writing pipe settings in=
=20
> global mixer registers (prefixed with SUN8I_MIXER_BLEND_). Channel id has=
 to=20
> be used when reading/writing channel registers (prefixed with=20
> SUN8I_MIXER_CHAN_UI_ or SUN8I_MIXER_CHAN_VI_).
>=20
> Before the patch, channel id was actually the same as zpos id and because=
 of=20
> that channel id was used for pipes too.

Ok. It's the kind of explanation that definitely belongs in the commit log =
:)

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rteifne7bjuvhn7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls90QMACgkQ0rTAlCFN
r3QBUw//ewlsHsNMo5S7+00hVSDUD2933QscpN8/h1x0riHCUJng2yImB0RJQS38
gyd6Iq9wIvp3Tn27BhQwHhEwukgSDoB7TB9kmhImdwn+bNeG/UPm/IzfD13TUPTu
6Folzrab4jKWhd/Kes8gtEFkk0nrqvepwf5AwYH11shHgOHk5WmmniXIXWHIs884
yO8DeuUkWsC0/mhETRNvulyR8zbnYQFW27WaHuKt1a0ki26Q1ICWxvzRwnKWwV9O
TOLQyJZVS4KH2fq2bwQr79fFjWDUACfi9ZpzZayPbTwNAjZh2CcTO0YjBEEgjA2Q
I4Gbrno2YeJr0ORmfruvWRvMjuHXQnwcMyHScFj35vryUd458yUGyQbuJiA6mqD8
BWZe1Nr8bC4/A7IC8lzpYLDk7mdA93EGgkdfPeGU1nzXCaVJDZVCAoEEJhHKryAd
HLGObSu6S4sejskuKUkbc9V6Gw7IwSgr0vM9pj/oakiFc/3P7FHteVQmJiYnD53H
AjOPB+BTIyugRTdQeDkRKDlifOJw1xncBVixA1pKVIIo01pSwWHCSSFf1WPFGLES
TFeGttzSNQNn1OKnbAK2d039MHKA2+Ya7FGwLxdFShKdAWlRuTP8DnInoNcIx1FM
F4Q2yU726JkU6Vs0K2eusOb1yDCoeuzCzb2AdC453ErinjYvHRk=
=bq0T
-----END PGP SIGNATURE-----

--rteifne7bjuvhn7l--
