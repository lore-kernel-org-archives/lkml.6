Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5CC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E052086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E052086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGLRRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:17:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38261 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbeGLRRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:17:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DD2702074F; Thu, 12 Jul 2018 19:06:35 +0200 (CEST)
Received: from localhost (LFbn-1-2035-163.w90-76.abo.wanadoo.fr [90.76.104.163])
        by mail.bootlin.com (Postfix) with ESMTPSA id ABF2720717;
        Thu, 12 Jul 2018 19:06:25 +0200 (CEST)
Date:   Thu, 12 Jul 2018 19:06:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v2] drm/sun4i: Implement zpos for DE2
Message-ID: <20180712170625.4w7zwmhkzbb4h5hc@flea.home>
References: <20180706164732.24166-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nlrgt4lfxwgb6gxq"
Content-Disposition: inline
In-Reply-To: <20180706164732.24166-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nlrgt4lfxwgb6gxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 06:47:32PM +0200, Jernej Skrabec wrote:
> Initial implementation of DE2 planes only supported fixed zpos.
>=20
> Expand implementation with configurable zpos property.
>=20
> Implementation background:
> Channel in DE2 driver represents one DRM plane, whereas pipe is just
> mapped channel to known Z position. Pipe 0 will always be at the bottom,
> pipe 1 just above pipe 0 and so on. If, for example, channel 1 is mapped
> at pipe 0 and channel 0 at pipe 1, whatever is on channel 0 will appear
> on top.
>=20
> Before this commit, channel id was used for addressing channel related
> registers (prefixed with SUN8I_MIXER_CHAN_UI_ or SUN8I_MIXER_CHAN_VI_)
> and pipe registers (prefixed with SUN8I_MIXER_BLEND_). Additionally,
> register SUN8I_MIXER_BLEND_ROUTE, which takes care for mapping channels
> to pipes had fixed value. It mapped channel 0 to pipe 0, 1 to 1 and so
> on. Consequence of all that was fixed Z order of planes.
>=20
> With this commit, pipe registers are using zpos property as index and
> channel related registers still use channel id as index. Pipe mapping
> register is now set dynamically too and pipe enable register is rebuild
> every time to make sure only active pipes are enabled.
>=20
> Testing was done to confirm that there is no issues if bottom plane
> contains pixels with alpha value < 0xff and if it doesn't whole screen.
>=20
> Tested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nlrgt4lfxwgb6gxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltHipAACgkQ0rTAlCFN
r3S2zBAAlqynfPawBVeurb6I+rqLpGySQX2/j3XleVWmxBHSKMbvLSZfgdL1VWvw
9MKjIX3aeceLH6sSt3jjZuKRafWFs5m5glNgqMGCiC4gsechfJA80AI7/8ObJJV+
ySDqr1lW5q0Tj8+DK4z06Zk6xQgTN4F5NOCwQiywKvNubAxE8Zs+6NmkbrKx1+aJ
dag1t/WOb29UD2F5fwNOjGmDuNnPSF/hW7LWccfBS74YCLnsmy5ApFajvRf/ivFp
JTthLmms8hBuOhxrPRcXgm8k8LCHgeROy5cGl9Hb8f9w//+LXKaVfqJl7vWJF65R
r/Ziv5RwFVZQupQCudrzMKsmT3TJ376Qw3o18nHriUeR/lkFPqqJUMt7+Etj8LUH
d5tx4F5B60hJjPNENohgigLx6Nz0Yud8CdBMeDNqf4yqkBP2Ir/WUBzEh9RUcKIW
NOMHBYLwrAmWFxvr3mkBn6Tnwn+T7oSHHDpYoMqUf+aBl6vuripsH2fnl4YVlklS
A7RW7Q2QWRuSaakhQoLjObOXkbPKsUT6L4hRny4Au5fhODBxRgi4nhdBSXyMsZJe
LT+AhcPS6JohAWC/gfQb/19SEO4nxu2uQCznQ3h+SwkRAY1AvXjbuh390qOON5Rb
vXAdfJBDrnQZDnDOMOO2txVCHZSCIi8upoL2ahUC6VGanFIUVc8=
=wAOk
-----END PGP SIGNATURE-----

--nlrgt4lfxwgb6gxq--
