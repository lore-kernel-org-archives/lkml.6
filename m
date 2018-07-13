Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BACECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDB120873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDB120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGMM7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:59:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60219 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeGMM7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:59:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 93E77207B4; Fri, 13 Jul 2018 14:44:51 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 65F8220737;
        Fri, 13 Jul 2018 14:44:51 +0200 (CEST)
Date:   Fri, 13 Jul 2018 14:44:51 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        robh+dt@kernel.org, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io
Subject: Re: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI
 reset
Message-ID: <20180713124451.pwdp6lf6ql2s4hyz@flea.home>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="37jf5cbnr4a6ludx"
Content-Disposition: inline
In-Reply-To: <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--37jf5cbnr4a6ludx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 11:03:01AM +0000, Corentin Labbe wrote:
> This patch document the new optional resets for ahci node.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Do=
cumentation/devicetree/bindings/ata/ahci-platform.txt
> index 5f362af2724c..a5281d7557e3 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -34,6 +34,8 @@ Optional properties:
>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller
> +- resets            : phandle to the reset line of AHCI controller
> +                      If set, must have a reset-names set as "ahci"

This isn't optional, it's required for the R40, and the other don't
need it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--37jf5cbnr4a6ludx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltInsIACgkQ0rTAlCFN
r3S8hQ/8CG2OkHAWbnyLri/MqARrqv/a990NHVW4gdWiZgdTd4h4ez3rcCtrUiJy
AvkXSK+YiYmqi7t4doINPnaDTD/+RNSU+Naa3QpzsVsgRwAuC43ym5onrNbO7TN1
mxfcM3k9PLWY8d7DE+j/1/X3fogr3YWn77z6nDjC3dZnvUpcSsbuqigCwM9YPFJk
HmmCMmpN3IV5Ts6KSfDuYFFQCJyGTdry57NCrCcuyQ1m3aMAORdZt5nhuMoL7X6n
AAlio+p8pIwMu90uMoWwGxxf7L5rHwch0VfPzwyj6PfiVTFFWlNW4MAtjhizi8lr
uUPTW7arQpZItQKtipJVTemNfxiChjuImwUcVbBIU2MW5ShNgMkuntSCkL7tCv/3
d+gBR5Ofvpr035kxdAoPAjYJEUKSLUKRJSxwA2xD8Vordm6GY+Px7gqzxvGtP4OV
orXWKEy+TyriiEaAArhXy2wQpm1Sj0BhHvSwwGUoJmwIK1tqkuSAUpr8W5OAQZzu
CNcHJ2kdG0Ilk+TYzJmcu5OFqAeymaqC/PSZ4HNal7/S//hquQkgAEAk4QLfP4KX
ddi6BBTkgNljNrssZRBP3VBwmBnDG9RQZXHr3kDSVgESbhVSBiAc9IEmrAabXNi/
S7vy2ri4qEfMTpaMHvmNLN4n7bMvydZuUqxDb5CXy17hHgeeu2E=
=azNX
-----END PGP SIGNATURE-----

--37jf5cbnr4a6ludx--
