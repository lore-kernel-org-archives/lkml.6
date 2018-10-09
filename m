Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5400C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A9F214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A9F214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIQaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:30:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45193 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeJIQaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:30:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2054120731; Tue,  9 Oct 2018 11:14:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id DEBEF20726;
        Tue,  9 Oct 2018 11:14:01 +0200 (CEST)
Date:   Tue, 9 Oct 2018 11:14:02 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 18/29] drm/sun4i: dw-hdmi: Add quirk for setting TMDS
 clock
Message-ID: <20181009091402.gjaruavagscq6wt5@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-19-jernej.skrabec@siol.net>
 <20181008091406.yjs2u22fmj72e4rj@flea>
 <8016466.hta3A6eauk@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uycfxtqpuxuus2aj"
Content-Disposition: inline
In-Reply-To: <8016466.hta3A6eauk@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uycfxtqpuxuus2aj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 05:09:42PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 08. oktober 2018 ob 11:14:06 CEST je Maxime Ripard napisa=
l(a):
> > Hi,
> >=20
> > On Sun, Oct 07, 2018 at 11:38:54AM +0200, Jernej Skrabec wrote:
> > > It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate =
at
> > > all. At this point it is not clear whether it is just not necessary or
> > > it would cause some kind of issues.
> > >=20
> > > Add a quirk for it.
> > >=20
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >=20
> > >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 5 ++++-
> > >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index ec122136ee9d..e9e93f174=
b35
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > > @@ -165,7 +165,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> > > struct device *master,>=20
> > >  		goto err_disable_clk_tmds;
> > >  =09
> > >  	}
> > >=20
> > > -	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs=
);
> > > +	if (hdmi->quirks->set_rate)
> > > +		drm_encoder_helper_add(encoder,
> > > +				       &sun8i_dw_hdmi_encoder_helper_funcs);
> >=20
> > That seems a bit backward, it only works because we only have mode_set
> > at the moment, and the only thing it does is changing the clock
> > rate. As soon as we change one of these two assumptions, the code will
> > break.
> >=20
> > Why not just return in mode_set if that boolean is true?
>=20
> My original intention was to optimize execution time a bit. If there is n=
o=20
> helpers registered, there is no need to call callback which does nothing.=
 But=20
> your way is probably more reasonable approach.
>=20
> However, I'm pretty sure that even older HDMI controller doesn't need thi=
s=20
> rate changing code. All tests shown that changing HDMI controller divider=
=20
> doesn't have an effect on video or audio output. It's only there because =
BSP=20
> kernel driver set rate and AW engineer said it's necessary.

Maybe we can simply remove it then, and see if it breaks. Given the
feedback from Allwinner, I'd prefer to have the behaviour they
recommend though, at least from MMC experience, it proved to be
needed.

> >=20
> > >  	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
> > >  =09
> > >  			 DRM_MODE_ENCODER_TMDS, NULL);
> > >=20
> > > @@ -235,6 +237,7 @@ static int sun8i_dw_hdmi_remove(struct platform_d=
evice
> > > *pdev)>=20
> > >  static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks =3D {
> > > =20
> > >  	.mode_valid =3D sun8i_dw_hdmi_mode_valid_a83t,
> > >=20
> > > +	.set_rate =3D true,
> > >=20
> > >  };
> > > =20
> > >  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] =3D {
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index a645b8bc9f58..f9eb66386=
5a4
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > > @@ -173,6 +173,7 @@ struct sun8i_hdmi_phy {
> > >=20
> > >  struct sun8i_dw_hdmi_quirks {
> > > =20
> > >  	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
> > >  =09
> > >  					   const struct drm_display_mode *mode);
> > >=20
> > > +	bool set_rate;
> >=20
> > This triggers a check in checkpatch. You should address them (and
> > there's several in your series).
>=20
> Till now we used bools in driver internal structures in spite of this=20
> warnings. So should we start using unsigned int? Or maybe bitfield with=
=20
> unsigned int as a base according to https://lkml.org/lkml/2017/11/21/384

That warning has been introduced pretty recently, so we do indeed have
some drivers that use a bool in their structure.

> As far as other issues reported by strict checkpatch go, most of them are=
 DT=20
> lines over 80 charachters. This was tolerated till now. Last type of issu=
es is=20
> that macro parameters weren't enclosed with braces. These issues won't be=
=20
> reported anymore in new series because sun8i_csc.h won't be touched if I =
drop=20
> patch which renames DE2 register macros (but original issue will remain).

Yeah, I don't worry about those.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--uycfxtqpuxuus2aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu8cVkACgkQ0rTAlCFN
r3Qitg//W2A0VndfZeKOlQuNqD+WOEb7E0Ug/AQF+nZ/RkJY+QAePt2Cy8/6TYGZ
8XjJfnp3VBzWN/MhzWR1LYC1ClaaTdFRqBJ7DgkHn14Z7ocP2wjFj14KgBGXlf+h
N57tg5csjGLp/0eMh4174gg4A2IJkBWcZ673PKwxvSPtepQ/UTqFpKZ0oOB6Y269
9x8EtPF4uM6gHyp/azOqaFRdC39hOVYWGEUSwuwmCw9Mqhh5djSgMK7+XfRQ4Ik+
ECXOPAXTL8RgcrlzVGCx9mk8V2KtXKjHVKwX4SENgObllIARCusPh3nMJPNyyvZS
gQFJbi8AlI6gcilvy6+oOhaFkH74/N07UF5k5Jnq6HeQp6Mv85ns+XMTYB5qTnag
0gKvRzTOsAONOvT8/VGokW1+RRbhJfBrdpLpfJIfiXMICpVlR+EAFJiNwXIzGvrd
Fl2POkNIB3Xu8bhRocSJpsZGbOnwOkSMUnlUFRWo5mb6SR7MAM94vQc1DeXHNUxJ
pRjqXL/kBHjZyvC9VnIvWLa17T4O8ZpDcp8E7bH1oEp/6KQKGxBAYWRjrEeVXliz
b/UNVrTiGar3Yy0eCfX10c0VGhTaN3J4k9ngRnmX2sJ4iwVYm+Fu7WEdDAJM50d2
wbqxvxholpMTSv5iLNzYstFXtIQ4dButuxSvxRoHn9IbZ52NFB0=
=+zwh
-----END PGP SIGNATURE-----

--uycfxtqpuxuus2aj--
