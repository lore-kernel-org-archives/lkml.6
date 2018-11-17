Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5474C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974F720817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974F720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKRHUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:20:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49416 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeKRHUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:20:03 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 68382807E4; Sat, 17 Nov 2018 22:02:03 +0100 (CET)
Date:   Sat, 17 Nov 2018 22:02:05 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 2/6] drm/omap: populate DSI platform bus earlier
Message-ID: <20181117210205.GC22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20181115230645.15748-3-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-16 00:06:41, Sebastian Reichel wrote:
> After the changes from 4.20 the DSI encoder tries to find the
> attached panel before populating the DSI bus. If the panel is
> not found -EPROBE_DEFER is returned, so the DSI bus is never
> populated and the panel never added.
>=20
> Fix this by populating the DSI bus before searching for the
> video sink in dsi_init_output().
>=20
> Fixes: 27d624527d992 ("drm/omap: dss: Acquire next dssdev at probe time")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwgc0ACgkQMOfwapXb+vI/6ACfdWLaip+Otti0kU6I5xv7Ce/m
uUEAoJYYKSgmnPdUswr6KWLnxvBVjFX0
=BfgV
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
