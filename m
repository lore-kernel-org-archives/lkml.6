Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F35ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E6A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E6A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJRRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:43:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53663 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeJRRnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:43:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CFF812090A; Thu, 18 Oct 2018 11:42:58 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9875C20723;
        Thu, 18 Oct 2018 11:42:58 +0200 (CEST)
Date:   Thu, 18 Oct 2018 11:42:58 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Dave Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
Message-ID: <20181018094258.oahlopafvm2udvoe@flea>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <20181018073327.64942-10-icenowy@aosc.io>
 <4168274.Gmp9JTCfJR@avalon>
 <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xqjqal4ijvcwwzek"
Content-Disposition: inline
In-Reply-To: <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xqjqal4ijvcwwzek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 11:18:06AM +0200, Daniel Vetter wrote:
> On Thu, Oct 18, 2018 at 10:55 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Icenowy,
> >
> > Thank you for the patch.
> >
> > On Thursday, 18 October 2018 10:33:27 EEST Icenowy Zheng wrote:
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > The panels shipped with Allwinner devices are very "generic", i.e.
> > > they do not have model numbers or reliable sources of information
> > > for the timings (that we know of) other than the fex files shipped
> > > on them. The dot clock frequency provided in the fex files have all
> > > been rounded to the nearest MHz, as that is the unit used in them.
> > >
> > > We were using the simple panel "urt,umsh-8596md-t" as a substitute
> > > for the A13 Q8 tablets in the absence of a specific model for what
> > > may be many different but otherwise timing compatible panels. This
> > > was usable without any visual artifacts or side effects, until the
> > > dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> > > rgb: Validate the clock rate").
> > >
> > > The reason this check fails is because the dotclock frequency for
> > > this model is 33.26 MHz, which is not achievable with our dot clock
> > > hardware, and the rate returned by clk_round_rate deviates slightly,
> > > causing the driver to reject the display mode.
> > >
> > > The LCD panels have some tolerance on the dot clock frequency, even
> > > if it's not specified in their datasheets.
> > >
> > > This patch adds a 5% tolerence to the dot clock check.
> >
> > Why do you think this shouldn't be merged ?
>=20
> It pisses of a lot of people who really insist upon accurate timing.

It's not just about accurate timings. That 5% is a made-up limit, that
never have really been confirmed by looking at the typical tolerancies
of panels.

And while being to relaxed might make some panels work that are not
working currently, it might also break some panels that currently work
and won't now, and ideally, we should really be able to let those
panels work if they can, and filter out resolutions if they can't.

> I think a better fix would be to have a dotclock range in drm_panel,
> and some magic to figure out which one of these we can actually
> do. Then tell userspace that this is the mode is should
> request. That way userspace knows what the actual dotclock/refresh
> rate is, and the panel still works.

It's not just about panels, but also bridges with EDID where the
tolerancy is not exposed.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xqjqal4ijvcwwzek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvIVaEACgkQ0rTAlCFN
r3QUIQ//aqylvlMaqvKcakg6woSHr+2qRJJHUiQuuvO5NjfPge6TPcL6eQyV7vUo
Y4YWHz0/Ds1kt1wr5W0pWrmAqnbzrKc4Nbasirq1oqgk0jKKAtUhQ1hVnlCj2WYX
9hB16webBwVHI6zcNPOcZxTSCuQWEHQwJmT/vKHnbmsXX5WhvdWhVmwOeOxKD2KS
3dpnoSv4kvV3bZlNRzRa/IQiA2m6oGl7i2P+QUXJt11YhJhAbm+xzRjOadrmN8xM
H+6ZFBg8RF/jY0NLbACLixvEPEVvxvdKxDWIZPk24hX/Py1ZOjOQj42d/9cDShkE
Tm8qaGP2vybzU01Mpjbggg1Ny4ZVDunKf8/BozLrsmY0J7KUQsHzTINhkNEZmszQ
1ydAh1iNWhzwMMDAp+QLkb0aZcQ/11ubLHRIPLz0AWlt/1U9DjyGsh5iDEYCOk2j
c+ND+A24GfxgaWlf/RsL9tTJQwVx9ISyLN/F306yclVBJFBEmkwWi2Jhj696zIbx
7krhIi1VDLVelG7gSqZ6avBf2FZiQomqhSYJWjf0L9BKWBEMni//3SjznkQlWB9V
faS8gfLiq60jInmddFJ4RAgn4egviWyLqxkRPoSro9KE9e9xtjZcEHn8+rTZrqgt
k9NWYdx6o8G99nQr3IKCwKSY1KqWrvER8fqHSn5bQsOKhtYmldI=
=esmR
-----END PGP SIGNATURE-----

--xqjqal4ijvcwwzek--
