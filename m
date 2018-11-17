Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6E6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321FD20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321FD20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKRH0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:26:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49537 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeKRH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:26:40 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9E5B4807FC; Sat, 17 Nov 2018 22:08:38 +0100 (CET)
Date:   Sat, 17 Nov 2018 22:08:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 5/6] drm/omap: add framedone interrupt support
Message-ID: <20181117210840.GE22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <20181115230645.15748-6-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This prepares framedone interrupt handling for
> manual display update support.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void *ar=
g)
> =20
>  		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc, ch=
annel))
>  			omap_crtc_error_irq(crtc, irqstatus);
> +
> +		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, ch=
annel))
> +			omap_crtc_framedone_irq(crtc, irqstatus);
>  	}
> =20
>  	omap_irq_ocp_error_handler(dev, irqstatus);

Will the mgr_get_framedone_irq(priv->dispc, channel) change from
interrupt to interrupt? Would it make sense to cache result as a
micro-organization?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwg1gACgkQMOfwapXb+vLFpQCeNilH3N4aHSKuC7+SOdkSpzsJ
o1wAn1tveKkDFp0iguGX+u4YNlK19vmx
=HLOK
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
