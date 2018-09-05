Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02742075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02742075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIELcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:32:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33537 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIELcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:32:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E814820756; Wed,  5 Sep 2018 09:03:36 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id BA306203DC;
        Wed,  5 Sep 2018 09:03:36 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:03:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
Message-ID: <20180905070335.dclhpxjld4vdkdu4@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bycakrqk56pgt6ts"
Content-Disposition: inline
In-Reply-To: <20180904163609.10171-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bycakrqk56pgt6ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 10:06:06PM +0530, Jagan Teki wrote:
> Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
> as default.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4, v3:
> - none
> Changes for v2:
> - Enable for MACH_SUN8I
>=20
>  drivers/clk/sunxi-ng/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 826674d090fd..e20182aa9748 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
> =20
>  config SUN8I_DE2_CCU
>  	bool "Support for the Allwinner SoCs DE2 CCU"
> +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> +	depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))

I don't see why there's a dependency on the DRM driver. I'm pretty
sure this would even break simplefb.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bycakrqk56pgt6ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPf8YACgkQ0rTAlCFN
r3QCxQ/+JSXH10zk0Celm/3OhcS17+7Xpamod/rUV7NMEBkQxm2DeiogB9UMm5AZ
atNXiuONom4uoG+PGu67eHIO2BX4O++V4GlFioEbb02PuhPAKeWRx2luLkaK/RQH
Al8hsIoEQA+VonKJkjPQc2knzqSYYDdWpS3BP6ISYyHT6zb0tNxghVmtFHlFMkxE
EcY95zd4ZFqoILUIAoqYXnhsrrE/ENvADw+vuLa+2cDAOee281Lrzjjzj7wwpjv1
CPNwSE3uDn72n7wsxM/Pkvgnsk709l17C61qi9zaCOU6MODnr6v07J8P8W5PSWOe
pUNHR35oHTsSbhjK7rjQB7DkZozoz+eRKVznwV28w4lxRroF6cR5B6HrW3go3d1t
XSYahmVmGQQTjm6pEnLtPvhJV7OiLFSxwY/NkirU58AUBek8A5jXimvDB0gRu7Ej
FEFqWAV/f1MTAItHcl6wtKy1vNICyYpSFml4N0fBRtPMoGWovNjwuXJsviZ0hN9L
zUgkkbIYb5DYAqUw990FQCP5OnzInz/LIfbg8tu4GnLDuD/TQzfz2SoGAV4l1mdI
UqAv29C0ueFPUMWcCs95ivQ3kk/2mN5EpAswg/0/+Gt3MlteJ4elXXVB9imO1VmZ
4Z2lN4LdwIvKFmeUTtZEsmG7trVcrBd+g+gUef83vG8IbClKvVI=
=zIK+
-----END PGP SIGNATURE-----

--bycakrqk56pgt6ts--
