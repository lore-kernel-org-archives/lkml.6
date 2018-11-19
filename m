Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD403C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A430620870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A430620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeKSWgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:36:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44032 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeKSWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:36:23 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AA5DC808D4; Mon, 19 Nov 2018 13:12:53 +0100 (CET)
Date:   Mon, 19 Nov 2018 13:12:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 5/6] drm/omap: add framedone interrupt support
Message-ID: <20181119121255.GA23830@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-6-sebastian.reichel@collabora.com>
 <20181117210840.GE22813@amd>
 <20181119120520.qaw6qyxyirjahzcn@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20181119120520.qaw6qyxyirjahzcn@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > @@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void=
 *arg)
> > > =20
> > >  		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc=
, channel))
> > >  			omap_crtc_error_irq(crtc, irqstatus);
> > > +
> > > +		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc=
, channel))
> > > +			omap_crtc_framedone_irq(crtc, irqstatus);
> > >  	}
> > > =20
> > >  	omap_irq_ocp_error_handler(dev, irqstatus);
> >=20
> > Will the mgr_get_framedone_irq(priv->dispc, channel) change from
> > interrupt to interrupt? Would it make sense to cache result as a
> > micro-organization?
>=20
> Maybe. But this is the same for the the omap_crtc_error_* and the
> driver is currently being restructured by Laurent. I think this can
> wait for later.

Definitely can wait. Thanks!
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvyqMcACgkQMOfwapXb+vLKEQCguFqQy6jtv4eZceDfUNekH+qR
aH8AoIX7+XSfUcSfq2/GTH5MAosrnf8z
=2qsH
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
