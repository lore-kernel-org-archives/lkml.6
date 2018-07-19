Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EBECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E22E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeGSQUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:20:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44075 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731732AbeGSQUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:20:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EDF2620728; Thu, 19 Jul 2018 17:37:05 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id C06A5206F6;
        Thu, 19 Jul 2018 17:37:05 +0200 (CEST)
Date:   Thu, 19 Jul 2018 17:37:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE checking if
 panel is used.
Message-ID: <20180719153706.j7rcqfu37e3ghtem@flea>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
 <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="olj7jgewtp44k4bc"
Content-Disposition: inline
In-Reply-To: <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olj7jgewtp44k4bc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 04:23:57PM +0200, Giulio Benetti wrote:
> Handle both positive and negative dclk polarity,
> according to bus_flags, taking care of this:
>=20
> On A20 and similar SoCs, the only way to achieve Positive Edge
> (Rising Edge), is setting dclk clock phase to 2/3(240=B0).
> By default TCON works in Negative Edge(Falling Edge), this is why phase
> is set to 0 in that case.
> Unfortunately there's no way to logically invert dclk through IO_POL
> register.
> The only acceptable way to work, triple checked with scope,
> is using clock phase set to 0=B0 for Negative Edge and set to 240=B0 for
> Positive Edge.
> On A33 and similar SoCs there would be a 90=B0 phase option, but it divid=
es
> also dclk by 2.
> This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
> for using A33 90=B0 phase divided by 2 and consequently increase code
> complexity.
>=20
> Check if panel is used. TCON can also handle VGA DAC, then panel could
> be empty.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--olj7jgewtp44k4bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltQsCEACgkQ0rTAlCFN
r3RNgw//eeAb69EM81zNVj5PIDa6jbgYAQjvdmdO1XGAsauxUh1M5rpD7gUOyPsJ
1LujDU22oJ4Xe8UVG2mdnLWCr/1k2ILoMLG/3BFmq4SDuDUQ5o9HRfhoKfxT++iW
jgzIBkFB+GnpUOjyal8YJe/egloHU4uJFshpoqmdV78uxGb70T4Y6c9BPnp4if0f
JFMi+PvZIJU/XiFMYG5DoIrFSlrmfnFE3IazTDbu8Wmlbfl4ph24rl/ATFKHVtmN
+IO4qQOpU7+XHMIn2MVIla5PCnw96wKHvEyhqZnB4japW9ucYW2ySliO4ToC/eq3
Lv68uoreLiMmR23WXgdv878WLeQ33/w5JlWUseIGT/AVNhXzJNn7heL/4bS0cbW1
acDLQb3LDgtYlKJEBzSv06BeLooAa8kZgCts9Qfa2EBnKoH3e+kJsl5iadRZUJ3y
MORRVnAN4Gscaem9W3COk4QToTuSzKHNM/7ERGFeovVb1kU0QurAbCsZbZu8mu2p
pqElHMSJ3MoDOXQC/cYBpPu1I6iwQ+dC/J9t2YbU5kz9ApVedWLJ7QO+2u9OUZTg
Gelqx3Y7Cdw6a9bOOo8vIeUXKLLGtUOjZcNuINCxkiNUvjD47YhqVHwG4nSGONKu
Kqzh0N8CqSzlU/VHTW6cKdqlSkB46JF5VgQx5wzhO4DDLpN+6j0=
=g5ar
-----END PGP SIGNATURE-----

--olj7jgewtp44k4bc--
