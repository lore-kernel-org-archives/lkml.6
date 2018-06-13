Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AFB43C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706BE208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706BE208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeFMHgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:36:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41928 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754469AbeFMHgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:36:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DBBEF2092B; Wed, 13 Jun 2018 09:36:05 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id AB04420726;
        Wed, 13 Jun 2018 09:36:05 +0200 (CEST)
Date:   Wed, 13 Jun 2018 09:36:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 24/27] drm: of: Export drm_crtc_port_mask()
Message-ID: <20180613073605.gnhcwrywooxhyryj@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-25-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqk45ekyxbgy3joq"
Content-Disposition: inline
In-Reply-To: <20180612200036.21483-25-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqk45ekyxbgy3joq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 10:00:33PM +0200, Jernej Skrabec wrote:
> Function is useful when drm_of_find_possible_crtcs() can't be used and
> custom parsing is needed. This can happen for example when there is a
> node with multiple muxes between crtc and encoder.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/drm_of.c | 4 ++--
>  include/drm/drm_of.h     | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 1fe122461298..2e9cea3287b2 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -22,8 +22,8 @@ static void drm_release_of(struct device *dev, void *da=
ta)
>   * Given a port OF node, return the possible mask of the corresponding
>   * CRTC within a device's list of CRTCs.  Returns zero if not found.
>   */
> -static uint32_t drm_crtc_port_mask(struct drm_device *dev,
> -				   struct device_node *port)
> +uint32_t drm_crtc_port_mask(struct drm_device *dev,
> +			    struct device_node *port)

It should probably be exported too?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fqk45ekyxbgy3joq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsgyWQACgkQ0rTAlCFN
r3RCFA//eA49EHWyvcyjgsi/qymB6nA7udnswkTDRRXPnYjeNdLiHNcBkZhLsee4
uCBbnHLUyU2EUfYmNeYt4Ie4wur1ALFdDUa11hQrYNsvFx7A1FR0BqJWqvdPTNoN
ynICsozYy4Qv5kpekaocg3vAL4OdoGnfBz+j4duXycNxy9VT8YJ6W3/0mEZghJCo
W2VoB7mt+LOd+W6SVNOjQxnVg1aLliQWkEe/LPXCCU3+8bL1z4M6Uv0jQj7E7m7k
d01IAN12kxEVMZGB8SYFLp+ArKHkFrkZaoOpPEn9giarfw5vbAowgCFwAtDbWezg
loPXXbpDzqV5x/l6d4t44Zsj/uZB6uwZvuW87fGBRa+SYTVPpJsh5INiU59Hfe/N
0ChAB/c0DygV5lQQ8miQNMsa0ihrG4IwmXJD+yn0YHTVcRIZf8BJYewBct3vr4a6
3xw9cPNdVf02/iVYs1rRn50jcft4TaKSFX/Ee9N2lTf3/UtVnwM+D4wn//hymawe
jE0TLbBVzTirh6fKbw7wjsWXRbE/UJ9dd3qbvrwhxCx+/SNZdoXr1kMNffatFq58
n440TKOPUc4/VNx3ni9tnpHR+Nbp1JGMSuxixXCd6gL5bvcerA8VKfaLpK0vnOr2
wj+L1xGOCdSj9O2y7DbovAHzLNo2ovCDzszpTmBKCsFU0ece8lM=
=oShS
-----END PGP SIGNATURE-----

--fqk45ekyxbgy3joq--
