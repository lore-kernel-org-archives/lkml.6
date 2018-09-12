Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC162C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC5E20890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC5E20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeILTjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:39:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56061 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeILTjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:39:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 408F4208AC; Wed, 12 Sep 2018 16:34:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03695207B3;
        Wed, 12 Sep 2018 16:34:37 +0200 (CEST)
Date:   Wed, 12 Sep 2018 16:34:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Matt Hart <matthew.hart@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180912143437.bwor5or4di2srk2b@flea>
References: <20180711144403.1022829-1-arnd@arndb.de>
 <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
 <CAK8P3a1w0SrxFNRwjt1nWhQPdqgt=bZ8oqGaPE=z9iHp84R5mw@mail.gmail.com>
 <20180907114255.7j7r6wzolnz5qkk7@flea>
 <CAH+k93F_xJMtXmkKZuZ45AAQgMkgNfSRSM3QyEtATgQSW6Mb9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pzac37zf3lwtaeir"
Content-Disposition: inline
In-Reply-To: <CAH+k93F_xJMtXmkKZuZ45AAQgMkgNfSRSM3QyEtATgQSW6Mb9A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pzac37zf3lwtaeir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2018 at 12:25:54PM +0100, Matt Hart wrote:
> On 7 September 2018 at 12:42, Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
> > On Fri, Sep 07, 2018 at 01:26:30PM +0200, Arnd Bergmann wrote:
> >> On Fri, Sep 7, 2018 at 11:41 AM Jon Hunter <jonathanh@nvidia.com> wrot=
e:
> >> >
> >> >
> >> > On 11/07/18 15:43, Arnd Bergmann wrote:
> >> > > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module=
 results in
> >> > > a link error, as we try to access a symbol from the sun8i_tcon_top=
=2Eko module:
> >> > >
> >> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-=
hdmi.ko] undefined!
> >> > > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.=
ko] undefined!
> >> > >
> >> > > This solves the problem by adding a silent symbol for the tcon_top=
 module,
> >> > > building it as a separate module in exactly the cases that we need=
 it,
> >> > > but in a way that it is reachable by the other modules.
> >> > >
> >> > > Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for pos=
sible crtcs")
> >> > > Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph =
with TCON TOP")
> >> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> > I am seeing the following on today's -next (20180907) as well the la=
st
> >> > few -next versions for that matter ...
> >> >
> >> > ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.=
ko] undefined!
> >> > ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tc=
on.ko] undefined!
> >> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.k=
o] undefined!
> >> >
> >> > Seems like this issue has cropped up again as Arnd's fix is present.=
 I
> >> > am seeing this on ARM64 builds.
> >>
> >> I have not started build testing on linux-next since the merge window,=
 but
> >> looking at the changes that got queued up, I find commits cf77d79b4e29
> >> ("drm/sun4i: tcon: Add another way for matching mixers with tcon") and
> >> 0305189afb32 ("drm/sun4i: tcon: Add support for R40 TCON") that both
> >> introduced a reference to the tcon_top file from sun4i_tcon.c.
> >>
> >> More IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) checks in
> >> the caller like I did in my patch would help, or alternatively one cou=
ld
> >> decide to give up and just always include the TCON_TOP.
> >
> > Sorry for the breakage.
> >
> > Can you test:
> >
> > ----8<----
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i=
/sun4i_tcon.c
> > index 4834c90b4912..c78cd35a1294 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -974,7 +974,8 @@ static bool sun4i_tcon_connected_to_tcon_top(struct=
 device_node *node)
> >
> >         remote =3D of_graph_get_remote_node(node, 0, -1);
> >         if (remote) {
> > -               ret =3D !!of_match_node(sun8i_tcon_top_of_table, remote=
);
> > +               ret =3D !!(IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> > +                        of_match_node(sun8i_tcon_top_of_table, remote)=
);
> >                 of_node_put(remote);
> >         }
> >
> > @@ -1402,13 +1403,20 @@ static int sun8i_r40_tcon_tv_set_mux(struct sun=
4i_tcon *tcon,
> >         if (!pdev)
> >                 return -EINVAL;
> >
> > -       if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_TMDS) {
> > +       if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> > +           encoder->encoder_type =3D=3D DRM_MODE_ENCODER_TMDS) {
> >                 ret =3D sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
> >                 if (ret)
> >                         return ret;
> >         }
> >
> > -       return sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
> > +       if (IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP)) {
> > +               ret =3D sun8i_tcon_top_de_config(&pdev->dev, tcon->id, =
id);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> >  }
> >
> >  static const struct sun4i_tcon_quirks sun4i_a10_quirks =3D {
> > ----8<----
>=20
> Works for me, and still broken in todays next

I pushed that fix, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pzac37zf3lwtaeir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluZI/wACgkQ0rTAlCFN
r3RDBBAAjcys3fv3cnAM72F5kov4pk2Ho9mw1osRMJX9ZXtufxZg2MDGPuTWzGjz
X6s8P219PcsWYYZx8n1Otni5zlBzfhiX6ZVoDpT3e0pFrS30uThJIefZKK0U827D
jsIPrTChU9C3pKVHC2P6EfSW+lJlwT9GFWYeoB/6shhtVw0QsWCVKMBvGWK9OuQW
sQ2DtGTvngBoI3eRqUdPhNzQzbEPXUT3CZs6HNA88a7cVtnXexUode3kh+vYBjTO
HJbXANB9eNN5jRhQRhHayKFiz33dDE5/srDa5nOUaK7lvDtGYixaMtTRR0BQXZGc
OIIQPm/uXhkWAHYDMgoU9+nxMxNwiV9jEUyRbkg8FTkWUMcsJP3gZSsI+OuLtHgH
000d7Hr2+Z09/x+2M4p75/aLkTOtoKaOJLLlf7P7T3snvf9cWua6BTOxGjQpjcME
GkzI9/SIQ4VThKYIyjoCLMzqF7TajPYPrZliow1GI+S1mvm6CqYvreNgVFQ9v8i/
VpVht4CEPJeh4V+xZi1YkqLJZto+CVR3hKRXWAdwafzo0cvHcxY3EaZA3dYV+nVR
lSCm7/xPoGmmONW6eh1SRwQ8mJu7YBxwo1q1jZn2rIG+YTxHQRuGJaNrV49qDAsb
Rqo+CP0MdMZDYBkHiU00euPQi5C5WDGaRTumpi3i7ptuR78AWK0=
=aXmb
-----END PGP SIGNATURE-----

--pzac37zf3lwtaeir--
